body =
  "初めまして最初の投稿です！ここでは主にRubyとSwiftについての記事を書いていこうと思っています。\n" +
  "そしてたまにTech界隈で私が気になった事を取り上げようと思っています。出来るだけ多くの記事を書いていこうと思いますので、楽しみにしていてください\n" +
  "今回はまず初めに私が今一番気になっっている、アプリについて紹介していきたいと思っております。"

  0.upto(9) do |idx|
    Article.create(
    title:"ブログを更新しました!#{idx}",
    body:body,
    release_at:8.days.ago.advance(days: idx),
    expire_at:2.days.ago.advance(days:idx),
    member_only:(idx % 3 == 0)
    )
  end
