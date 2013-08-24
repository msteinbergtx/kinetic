require 'spec_helper'

describe User do
  it { expect(subject).to have_many(:commissions) }
  it { expect(subject).to have_many(:payment_plans) }
  it { expect(subject).to have_many(:payments) }

  it { expect(subject).to belong_to(:organization) }

  describe 'creation' do
    it 'sets the roles to the user role' do
      user = build(:user, roles: nil)

      user.save!

      expect(user.roles).to eq ['user']
    end

    it 'assigns the user to an organization' do
      user = build(:user, organization: nil)
      organization = create(:organization)

      user.save!

      expect(user.organization).to eq organization
    end
  end

  describe '#is?' do
    it 'returns true if the user is the passed in role' do
      admin = create(:admin)

      expect(admin.is?(:admin)).to be_true
    end
  end

  describe 'add_role' do
    it 'assigns a user to new role' do
      user = build(:user, roles: ['test'])

      user.add_role(:new_role)

      expect(user.roles).to eq(['test','new_role'])
    end
  end

  describe 'remove_role' do
    it 'remove a role from a user' do
      user = build(:user, roles: ['test','another_test'])

      user.remove_role(:another_test)

      expect(user.roles).to eq(['test'])
    end

    it 'raises an exception when a user is left with no roles' do
      user = build(:user, roles: ['another_test'])

      expect{ user.remove_role(:another_test) }.to raise_error('user must have at least one role')
    end
  end
end
