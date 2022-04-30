import 'package:flutter/material.dart';
import 'package:ai_radio/pages/playing_audio.dart';
import 'package:ai_radio/models/podcasts_data.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:audioplayers/audioplayers.dart';


class PodcastPage extends StatefulWidget {
  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  AudioPlayer _audioPlayer;
  AudioCache _audioCache;
  PlayerState _playerState = PlayerState.STOPPED;
  void initState() {
    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    // _audioPlayer.play(
    //     "https://pagalnew.com/mp3-songs/indipop-mp3-songs/teri-ada-kaushik-guddu-128-kbps-sound.mp3");
    _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      //get the duration of audio
      time = DateTime.now().millisecondsSinceEpoch + d.inMilliseconds;
      maxsize = d.inMilliseconds;
    });
    slider();
    super.initState();
  }

  int time = 0;
  slider() {
    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        slidderval = p.inMilliseconds;
      });
      //get the current position of playing audio
    });
  }

  seek(sec) async {
    await _audioPlayer.seek(Duration(milliseconds: sec));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  bool small = true;
  double size = 145;
  int maxsize = 0;
  int slidderval = 0;
  bool playing1 = PlayingAudio.playingStatus == true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      drawer: Drawer(
          child: Container(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(),
          padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Container(
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "P",
                        textScaleFactor: 2,
                        style: TextStyle(color: Color(0xFF364F6B)),
                      ),
                      Text(
                        "o",
                        textScaleFactor: 2,
                        style: TextStyle(color: Color(0xFFFF77A0)),
                      ),
                      Text(
                        "dcast",
                        textScaleFactor: 2,
                        style: TextStyle(color: Color(0xFF364F6B)),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ]))),
      appBar: AppBar(
        toolbarHeight: 75,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 0.4,
        backgroundColor: Color(0xFFF9F7F7),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu_rounded,
                size: 35,
                color: Color(0xFF364F6B),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "P",
                  textScaleFactor: 1.25,
                  style: TextStyle(color: Color(0xFF364F6B)),
                ),
                Text(
                  "o",
                  textScaleFactor: 1.25,
                  style: TextStyle(color: Color(0xFFFF77A0)),
                ),
                Text(
                  "dcast",
                  textScaleFactor: 1.25,
                  style: TextStyle(color: Color(0xFF364F6B)),
                ),
              ],
            )),
      ),
      body: SnappingSheet(
        lockOverflowDrag: true,
        // ignore: non_constant_identifier_names
        onSheetMoved: (SheetPositionData) {
          if (SheetPositionData.relativeToSnappingPositions > 0) {
            setState(() {
              small = false;
              size = 10;
            });
          } else if (SheetPositionData.relativeToSnappingPositions < 0.5) {
            setState(() {
              small = true;
              size = 145;
            });
          } else {
            setState(() {
              small = true;
              size = 145;
            });
          }
        },
        child: screen(context),
        grabbingHeight: 130,

        // ignore: todo
        // TODO: Add your grabbing widget here,
        grabbing: small
            ? smallscreen(context)
            : Container(
                decoration: BoxDecoration(
                    color: Color(0xffF9F7F7),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset.zero,
                          blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17))),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(17))),
                    ),
                  ],
                ),
              ),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          // ignore: todo
          // TODO: Add your sheet content here
          child: Container(
            color: Color(0xffF9F7F7),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: Color(0xffF9F7F7)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(PlayingAudio.imgae),
                              fit: BoxFit.fill),
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      PlayingAudio.trackName,
                      textScaleFactor: 2,
                      style: TextStyle(
                          color: Color(0xFF364F6B),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      PlayingAudio.description,
                      textScaleFactor: 0.75,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () => {
                                  if (PlayingAudio.index == 0)
                                    {}
                                  else
                                    {
                                      setState(() {
                                        PlayingAudio.index--;
                                        PlayingAudio.trackName = PodcastsData
                                            .data[PlayingAudio.index]["name"];
                                        PlayingAudio.description = PodcastsData
                                                .data[PlayingAudio.index]
                                            ["description"];
                                        PlayingAudio.imgae = PodcastsData
                                            .data[PlayingAudio.index]["img"];

                                        _audioPlayer.play(PodcastsData
                                            .data[PlayingAudio.index]["audio"]);
                                        playing1 = true;
                                        PlayingAudio.playingStatus = true;
                                      })
                                    }
                                },
                            child: Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                  color: Color(0xFF364F6B),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: Icon(
                                Icons.skip_previous_rounded,
                                color: Color(0xffF9F7F7),
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () => {
                                  setState(() {
                                    int index = PlayingAudio.index;
                                    if (index >= 0) {
                                      if (playing1 == true &&
                                          PlayingAudio.playingStatus == true) {
                                        _audioPlayer.pause();
                                        PlayingAudio.playingStatus = false;
                                        playing1 = false;
                                      } else {
                                        _audioPlayer.play(
                                            PodcastsData.data[index]["audio"]);
                                        playing1 = true;
                                        PlayingAudio.playingStatus = true;
                                      }
                                    }
                                  })
                                },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xFF364F6B),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: playing1
                                  ? Icon(
                                      Icons.pause,
                                      color: Color(0xffF9F7F7),
                                    )
                                  : Icon(
                                      Icons.play_arrow_rounded,
                                      color: Color(0xffF9F7F7),
                                    ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () => {
                            if (PodcastsData.data.length == PlayingAudio.index)
                              {}
                            else
                              {
                                setState(() {
                                  PlayingAudio.index++;
                                  PlayingAudio.trackName = PodcastsData
                                      .data[PlayingAudio.index]["name"];
                                  PlayingAudio.description = PodcastsData
                                      .data[PlayingAudio.index]["description"];
                                  PlayingAudio.imgae = PodcastsData
                                      .data[PlayingAudio.index]["img"];

                                  _audioPlayer.play(PodcastsData
                                      .data[PlayingAudio.index]["audio"]);
                                  playing1 = true;
                                  PlayingAudio.playingStatus = true;
                                })
                              }
                          },
                          child: Container(
                            height: 37,
                            width: 37,
                            decoration: BoxDecoration(
                                color: Color(0xFF364F6B),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Icon(
                              Icons.skip_next_rounded,
                              color: Color(0xffF9F7F7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 3,
                          activeTrackColor: Color(0xffFF77A0),
                          inactiveTrackColor: Color(0xffE5E5E5),
                          thumbColor: Colors.white,
                          thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 12.0, elevation: 1.5),
                        ),
                        child: Slider(
                            min: 0,
                            max: maxsize.toDouble(),
                            value: slidderval.toDouble(),
                            onChanged: (size) {
                              setState(() {
                                seek(size.toInt());
                                slidderval = size.toInt();
                              });
                            })),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  // ignore: non_constant_identifier_names
  Widget smallscreen(BuildContext) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffF9F7F7),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset.zero, blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17), topRight: Radius.circular(17))),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 100,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(17))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(PlayingAudio.imgae),
                              fit: BoxFit.fill),
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PlayingAudio.trackName,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Color(0xFF364F6B),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          PlayingAudio.description,
                          textScaleFactor: 0.75,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => {
                    setState(() {
                      int index = PlayingAudio.index;
                      if (index >= 0) {
                        if (playing1 == true &&
                            PlayingAudio.playingStatus == true) {
                          _audioPlayer.pause();
                          PlayingAudio.playingStatus = false;
                          playing1 = false;
                        } else {
                          _audioPlayer.play(PodcastsData.data[index]["audio"]);
                          playing1 = true;
                          PlayingAudio.playingStatus = true;
                        }
                      }
                    })
                  },
                  child: Container(
                    height: 37,
                    width: 37,
                    decoration: BoxDecoration(
                        color: Color(0xFF364F6B),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: playing1
                        ? Icon(
                            Icons.pause,
                            color: Color(0xffF9F7F7),
                          )
                        : Icon(
                            Icons.play_arrow_rounded,
                            color: Color(0xffF9F7F7),
                          ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget screen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Popular Podcasts",
                textScaleFactor: 1.25,
                style: TextStyle(
                    color: Color(0xFF364F6B), fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(child: listView(context)),
          ],
        ),
      ),
    );
  }

  Widget listView(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          bool playing =
              PlayingAudio.index == index && PlayingAudio.playingStatus == true;
          return Container(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage(PodcastsData.data[index]["img"]),
                              fit: BoxFit.fill),
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PodcastsData.data[index]["name"],
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Color(0xFF364F6B),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          PodcastsData.data[index]["description"],
                          textScaleFactor: 0.75,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => {
                    setState(() {
                      if (playing == true &&
                          PlayingAudio.playingStatus == true) {
                        _audioPlayer.pause();
                        PlayingAudio.playingStatus = false;
                        playing1 = false;
                      } else if (playing == false &&
                          PlayingAudio.playingStatus == true) {
                        _audioPlayer.stop();
                        PlayingAudio.playingStatus = false;
                        _audioPlayer.play(PodcastsData.data[index]["audio"]);
                        playing1 = true;
                        PlayingAudio.playingStatus = true;
                        PlayingAudio.index = index;
                        PlayingAudio.description =
                            PodcastsData.data[index]["description"];
                        PlayingAudio.trackName =
                            PodcastsData.data[index]["name"];
                        PlayingAudio.imgae = PodcastsData.data[index]["img"];
                      } else {
                        _audioPlayer.play(PodcastsData.data[index]["audio"]);
                        playing1 = true;
                        PlayingAudio.playingStatus = true;
                        PlayingAudio.index = index;
                        PlayingAudio.description =
                            PodcastsData.data[index]["description"];
                        PlayingAudio.trackName =
                            PodcastsData.data[index]["name"];
                        PlayingAudio.imgae = PodcastsData.data[index]["img"];
                      }
                    })
                  },
                  child: Container(
                    height: 37,
                    width: 37,
                    decoration: BoxDecoration(
                        color: Color(0xFF364F6B),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: playing
                        ? Icon(
                            Icons.pause,
                            color: Color(0xffF9F7F7),
                          )
                        : Icon(
                            Icons.play_arrow_rounded,
                            color: Color(0xffF9F7F7),
                          ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 5,
            thickness: 0,
            color: Colors.transparent,
          );
        },
        itemCount: PodcastsData.data.length);
  }
}