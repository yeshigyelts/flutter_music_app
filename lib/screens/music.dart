import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/components/custom_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List musicList = [
    {
      "title": "Daddy Cool",
      "singer": "Bonny M",
      "url":
          "https://nl04.mp3snow.com/bcb2bf225c5f32f5885a1/Boney%20M%20-%20Daddy%20Cool.mp3",
      "coverUrl":
          "https://img.discogs.com/yD8LmJFhI7KbUDcJExnL-Lkd158=/fit-in/600x584/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-2368252-1372470699-5766.jpeg.jpg"
    },
    {
      "title": "Take On Me",
      "singer": "A-ha",
      "url":
          "https://fr05.mp3snow.com/ec6843135c5f341a03b21/a-ha%20-%20Take%20On%20Me.mp3",
      "coverUrl":
          "https://static.wikia.nocookie.net/best-music-and-songs/images/e/e1/Take_On_Me_cover.jpg/revision/latest?cb=20190602044426"
    },
    {
      "title": "Pehli Dafa",
      "singer": "Atif Aslam",
      "url":
          "https://medium.cdnmp3.com/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhbGJ1bV9pZCI6Mjk0NzAsInRpbWVvdXQiOjE2MjUwMjQyMTV9.0s_dz20djMcjp5hxU3_K7L7EZXdWnwsw-N0FxhO2KF4/gcrmh/Pehli%20Dafa%20-%20%28amlijatt.in%29.mp3",
      "coverUrl":
          "https://i.pinimg.com/originals/50/48/f5/5048f5d15a535dc9e2742117cfda59b9.jpg"
    },
    {
      "title": "Blinding Lights",
      "singer": "The Weeknd",
      "url":
          "https://mp3by.in/siteuploads/files/sfd12/5922/The%20Weeknd%20-%20Blinding%20Lights%20320kbps(mp3by.in).mp3",
      "coverUrl":
          "https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png"
    },
    {
      "title": "Levitating",
      "singer": "Dua Lipa Ft. DaBaby",
      "url":
          "https://naijaforbe.com/wp-content/uploads/2021/06/Dua_Lipa_Ft_DaBaby_-_Levitating_Remixcom.mp3",
      "coverUrl":
          "https://i1.sndcdn.com/artworks-Qz6ZhZMRYyz8H80k-w8lePg-t500x500.jpg"
    },
    {
      "title": "8TEEN",
      "singer": "Khalid",
      "url": "https://download.mp3oops.fun/s/Khalid-8TEEN.mp3",
      "coverUrl":
          "https://upload.wikimedia.org/wikipedia/en/7/7d/Khalid_-_American_Teen.png"
    }
  ];

  String currentTitle = "";
  String currentSinger = "";
  String currentCover = "";
  IconData btnPlay = Icons.play_arrow;

  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool initiated = false;
  bool isPlaying = false;
  String currentSong = "";

  Duration duration = new Duration();
  Duration position = new Duration();

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        isPlaying = true;
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        position = Duration.zero;
        isPlaying = false;
        btnPlay = Icons.play_arrow;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Playlist",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.list), color: Colors.black)
        ],
        elevation: 1,
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            // Playlist UI
            Expanded(
              child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) => customListTile(
                    onTap: () {
                      playMusic(musicList[index]['url']);
                      setState(() {
                        initiated = true;
                        isPlaying = true;
                        btnPlay = Icons.pause;
                        currentTitle = musicList[index]['title'];
                        currentSinger = musicList[index]['singer'];
                        currentCover = musicList[index]['coverUrl'];
                      });
                    },
                    title: musicList[index]['title'],
                    singer: musicList[index]['singer'],
                    cover: musicList[index]['coverUrl']),
              ),
            ),

            // Music Player UI
            Visibility(
              visible: initiated ? true : false,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0x55212121), blurRadius: 8)
                  ],
                ),
                child: Column(
                  children: [
                    Slider.adaptive(
                        value: position.inSeconds.toDouble(),
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          audioPlayer.seek(Duration(seconds: value.toInt()));
                        }),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8, left: 12, right: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              child: CachedNetworkImage(
                                  imageUrl: currentCover, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentTitle,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(height: 5),
                                    Text(currentSinger,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))
                                  ]),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (isPlaying) {
                                    audioPlayer.pause();
                                    setState(() {
                                      btnPlay = Icons.play_arrow;
                                      isPlaying = false;
                                    });
                                  } else {
                                    audioPlayer.resume();
                                    setState(() {
                                      btnPlay = Icons.pause;
                                      isPlaying = true;
                                    });
                                  }
                                },
                                icon: Icon(btnPlay),
                                iconSize: 42),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
