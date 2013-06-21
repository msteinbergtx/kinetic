require 'spec_helper'

describe User do
  it { expect(subject).to have_many(:commissions) }
  it { expect(subject).to belong_to(:organization) }

  describe 'creation' do
    it 'sets the roles_list to the user role' do
      user = build(:user, roles_list: '')

      user.save!

      expect(user.roles_list).to eq 'user'
    end
  end

  describe '#is?' do
    it 'returns true if the user is the passed in role' do
      admin = create(:admin)

      expect(admin.is?('admin')).to be_true
    end
  end

  describe 'roles' do
    it 'returns an immutable array of roles' do
      user = build(:user, roles_list: 'test_role|another_role')

      expect(user.roles).to eq(['test_role', 'another_role'])
      expect { user.roles << 'new_role' }.to raise_error("can't modify frozen Array")
    end

    it 'memoizes roles' do
      user = build(:user, roles_list: 'test')

      expect(user.roles).to eq(['test'])
      user.roles_list = 'modified'
      expect(user.roles).to eq(['test'])
    end
  end

  describe 'add_role' do
    it 'assigns a user to new role' do
      user = build(:user, roles_list: 'test')

      user.add_role(:new_role)

      expect(user.roles_list).to eq('test|new_role')
    end
  end

  describe 'remove_role' do
    it 'remove a role from a user' do
      user = build(:user, roles_list: 'test|another_test')

      user.remove_role(:another_test)

      expect(user.roles_list).to eq('test')
    end

    it 'raises an exception when a user is left with no roles' do
      user = build(:user, roles_list: 'another_test')

      expect{ user.remove_role(:another_test) }.to raise_error("user must have at least one role")
    end
  end
end
