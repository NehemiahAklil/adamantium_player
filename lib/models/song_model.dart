class Song {
  final String title;
  final String artist;
  final String url;
  final String coverUrl;
  final String? lyrics;

  Song(
      {required this.title,
      required this.artist,
      required this.url,
      required this.coverUrl,
      this.lyrics});

  static List<Song> songs = [
    Song(
        title: "U know my name",
        artist: 'Rivers & Robots',
        url: 'assets/music/you_know_my_name.mp3',
        coverUrl: 'assets/images/the_eternal_son.png'),
    Song(
        title: "Billion Years",
        artist: 'Trip Lee',
        url: 'assets/music/billion_years.mp3',
        coverUrl: 'assets/images/billion_years_ahead.jpg',
        lyrics: """
(Verse 1)
A billion
years ahead
This old world will be nothing
There's a joy that is coming
Like the morning
And nothing that we left
Will compare to this new song
Hearts united in freedom
And nothing that we left 
Will compare to this new song   

(Chorus)
A billion years ahead
A billion years ahead
This old world will be nothing
There's a joy that is coming
Like the morning
And nothing that we left
Will compare to this new song
Hearts united in freedom 
And nothing that we left 
Will compare to this new song 


(Verse 2) 
Some told me I ain't got no heat 
No, no more success forever 
But I know change with my own feet 
I'm headed way way high 
On my way home 
My rear view mirror's ripped off 
On my way home 
No reminiscing, I will not bother 
Dwell on the past unless it's Golgotha 

(Chorus) 
A billion years ahead 
A billion years ahead 
This old world will be nothing 
There's a joy that is coming 
Like the morning 
And nothing that we left
Will compare to this new song 
Hearts united in freedom 
And nothing that we left 
Will compare to this new song   

(Bridge) 
My life ain't field skipping, no field tripping 
I'm headed way way high 
On my way home 
My rear view mirror's ripped off 
On my way home 
No reminiscing, I will not bother 
Dwell on the past unless it's Golgotha 
 
(Chorus) 
A billion years ahead 
A billion years ahead 
This old world will be nothing 
There's a joy that is coming 
Like the morning 
And nothing that we left 
Will compare to this new song 
Hearts united in freedom 
And nothing that we left 
Will compare to this new song   
 
(Outro) 
A billion years ahead 
A billion years ahead 
A billion years ahead 
A billion years ahead 
"""),
    Song(
        title: "I Need A Miracle",
        artist: 'Third Day',
        url: 'assets/music/i_need_a_miracle.mp3',
        coverUrl: 'assets/images/miracle.jpg'),
    Song(
        title: "Amen",
        artist: 'Lecrae x Zaytoven',
        url: 'assets/music/you_know_my_name.mp3',
        coverUrl: 'assets/images/amen.jpg'),
  ];
}
