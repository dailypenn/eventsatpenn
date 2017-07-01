class GetPennMembersJob < ApplicationJob
  queue_as :default

  def perform(access_token)
    group = FbGraph2::Group.new('206461236135166').authenticate(access_token)
    group.fetch
    add_members(group.members)
    loop do
      group.members.next
      break unless group.members.length
      add_members(group.members)
    end
  end

  def add_members(members)
    members.each do |member|
      p member.name
      PennFBMember.create(fbID: member.id, name: member.name)
    end
  end
end
