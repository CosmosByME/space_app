class Post {
  String uid = "";
  String fullname = "";
  String imgUser = "";
  String id = "";
  String imgPost = "";
  String caption = "";
  String date = DateTime.now().toIso8601String();
  int likesCount = 0;
  int commentsCount = 0;
  bool liked = false;

  bool mine = false;

  Post(this.caption, this.imgPost);

  Post.fromJson(Map<String, dynamic> json)
    : uid = json['uid'],
      fullname = json['fullname'],
      imgUser = json['img_user'],
      imgPost = json['img_post'],
      id = json['id'],
      caption = json['caption'],
      date = json['date'],
      liked = json['liked'],
      likesCount = json['likesCount'],
      commentsCount = json['commentsCount'];

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'fullname': fullname,
    'img_user': imgUser,
    'id': id,
    'img_post': imgPost,
    'caption': caption,
    'date': date,
    'liked': liked,
    'likesCount': likesCount,
    'commentsCount': commentsCount,
  };

  Post.fromMap(Map<String, dynamic> map)
    : uid = map['uid'],
      fullname = map['fullname'],
      imgUser = map['img_user'],
      imgPost = map['img_post'],
      id = map['id'],
      caption = map['caption'],
      date = map['date'],
      liked = map['liked'],
      likesCount = map['likesCount'],
      commentsCount = map['commentsCount'];
}
