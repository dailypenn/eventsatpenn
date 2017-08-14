class GetPennMembersJob < ApplicationJob
  queue_as :default

  def perform(access_token)
    group = FbGraph2::Group.new('206461236135166').authenticate(access_token)
    group.fetch
    added = 0
    members = group.members(limit: 500)
    loop do
      break if members.empty?
      added += members.length
      add_members(members)
      members = members.next
      p "added #{added} so far..."
    end
  end

  def add_members(members)
    members.each do |member|
      PennFBMember.create(fbID: member.id, name: member.name)
    end
  end
end
