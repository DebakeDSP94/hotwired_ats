class MentionsReflex < ApplicationReflex
  def user_list
    users = current_user
            .account
            .users
            .where.not(id: current_user.id)
            .map { |user| { sgid: user.attachable_sgid, name: user.name } }
            .to_json

    cable_ready.set_dataset_property(
      name: 'mentionsUserListValue',
      selector: '#comment_comment',
      value: users
    )
    morph :nothing
  end
end