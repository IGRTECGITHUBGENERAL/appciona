import 'package:appciona/pages/audiovisual/podcast/podcasts_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudiovisualPage extends StatefulWidget {
  final Widget drawer;
  const AudiovisualPage({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  State<AudiovisualPage> createState() => _AudiovisualPageState();
}

class _AudiovisualPageState extends State<AudiovisualPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text('Audiovisual'),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      drawer: Drawer(
        child: widget.drawer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Center(
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      _turismoImageCard(
                        size,
                        'assets/icons/podcast_colors.png',
                        'Podcasts',
                        const PodcastsPage(),
                      ),
                      _turismoImageCard(
                        size,
                        'assets/icons/radio_directo_colors.png',
                        'Radio en vivo',
                        const PodcastsPage(),
                      ),
                      _turismoImageCard(
                        size,
                        'assets/icons/directo_colors.png',
                        'En directo',
                        const PodcastsPage(),
                      ),
                      _turismoImageCard(
                        size,
                        'assets/icons/videos_colors.png',
                        'Videos',
                        const PodcastsPage(),
                      ),
                      _turismoImageCard(
                        size,
                        'assets/icons/imagen_colors.png',
                        'Imágenes',
                        const PodcastsPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card _turismoImageCard(
      Size size, String image, String title, Widget widgetPage) {
    return Card(
      elevation: 7,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => widgetPage),
        ),
        child: Container(
          width: size.width * 0.43,
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Image.asset(image),
              const Divider(),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
