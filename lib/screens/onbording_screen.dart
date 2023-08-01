import 'package:flutter/material.dart';
import 'package:http_gelocalisation_futurebuilder/screens/google_map_screeen.dart';
import '../components/dot_indicator.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  List<String> images = [
    "3d-casual-life-science-lab-featuring-chair-and-desk-with-microscope-and-pot-plant.png",
    "casual-life-3d-boy-sitting-in-armchair-and-reading-book-1.png",
    "casual-life-3d-female-doctor-with-clipboard.png",
    "casual-life-3d-young-doctor-man.png"
  ];
  PageController controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: images.length,
                  onPageChanged: (currentpage) {
                    currentPage = currentpage;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/${images[index]}",
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                            Text(
                              "Find the item you've been looking for",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Lorem ismum de la vegas",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                          images.length,
                          (index) => DotIndicator(
                                isActive: index == currentPage,
                              )).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentPage == images.length-1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const GoogleMapScreen()),
                (route) => false);
          } else {
            controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          }
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
