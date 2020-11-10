class Post {
  String title;
  DateTime date;
  String desc;
  String mood;

  Post(this.title, this.date, this.desc, this.mood);

  Map<String, dynamic> toJson() => {
        'title': title,
        'date': date,
        'desc': desc,
        'mood': mood,
      };
}
