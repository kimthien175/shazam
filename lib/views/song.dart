import 'package:acr_test/models/deezer_song.dart';
import 'package:acr_test/views/player.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

class SongScreen extends StatefulWidget {
  const SongScreen(this.song, {Key? key}) : super(key: key);

  final DeezerSong song;
  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  void initState() {
    super.initState();
    //Player.getInstance().setUrl(widget.song.preview.toString());
  }

  String _contributers = '_contributer';
  @override
  Widget build(BuildContext context) {
    // convert contributers to string
    var contributers = widget.song.contributors;
    if (contributers!.isNotEmpty) {
      _contributers = '';
      if (contributers.length > 1) {
        var i = 0;
        for (; i < contributers.length - 1; i++) {
          _contributers =
              _contributers + contributers[i].name.toString() + ' & ';
        }
        _contributers = _contributers +
            contributers[contributers.length - 1].name.toString();
      } else {
        _contributers = contributers.first.name.toString();
      }
    }
    var _scrHeight = MediaQuery.of(context).size.height;
    var _scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded)),
          flexibleSpace: gradientContainer(),
          elevation: 0,
        ),
        body: gradientContainer(
          child: SizedBox(
            height: _scrHeight,
            width: _scrWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),

                // Track cover
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: (widget.song.album!.coverMedium != null)
                      ? Image.network(widget.song.album!.coverMedium.toString(),
                          loadingBuilder: ((context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }))
                      : Container(
                          padding: const EdgeInsets.all(40),
                          height: 250,
                          width: 250,
                          decoration:
                              const BoxDecoration(color: Color(0xFFFFFFFF)),
                          child: Image.asset(
                            'assets/images/shazam-logo.png',
                            color: mainBlue,
                          ),
                        ),
                ),

                // Track name, artists and duration
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.song.title!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      _contributers,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Text(
                        'Duration: ${_secToMinFullDuration(widget.song.duration!.toInt())}',
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))
                  ],
                ),

                // Play section
                PlayerSection(widget.song.preview.toString())
              ],
            ),
          ),
        ));
  }
}

String _secToMinFullDuration(int sec) {
  var _min = sec ~/ 60;
  var _sec = sec % 60;
  return '${_min}m ${_sec}s';
}
