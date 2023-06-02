import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtf/app/custom_clickable.dart';
import 'package:wtf/app/routes/app_pages.dart';

import '../../../model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return

Obx(() =>  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
        leading: Center(
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 15,
            ),
          ),
        ),
        title: ClickableWidget(
          onTap: () {
            Get.toNamed(Routes.PICK_LOCATION);
          },

          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.black,
                    size: 18,
                  ),
                  Text(
                    "Location",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 18,
                  )
                ],
              ),
               Text(
               (controller. lat.value != null &&  controller.long.value != null)  ? "${controller. lat.value!.toStringAsFixed(5)},${controller. long.value!.toStringAsFixed(5)}"  : "No location",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [Icon(Icons.abc)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,

                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 70,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.black26,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color(0xffE2E2E2),
                  ),
                ),
                hintText: "Search by gym name",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: 18),
                // hintStyle: TextStyle(color: Colors.black26),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.black)),
                        backgroundColor:
                            index == 0 ? Colors.black : Colors.white,
                        label: Text(
                          [
                            "All",
                            "WTF Exclusive",
                            "WTF Co-branded",
                            "WTF Powered"
                          ][index],
                          style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  }),
            ),
           controller.data.value!=null ? Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.data.value!.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GymItem(data: controller.data.value!.data![index],),
                    );
                  }),
            ) : Text("No data available")
          ],
        ),
      ),
    )
  );

   }
}

class GymItem extends StatelessWidget {
  final Data data;
  const GymItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF830606), Colors.orange]),
            color: Colors.grey.shade900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                data.categoryName!,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Expanded(
              child: ClipPath(
                  clipper: CustomPath(),
                  child: Container(
                    width: double.infinity,
                    color: Colors.amber,
                    child: data.coverImage!=null ? Image.network( data.coverImage!,fit: BoxFit.fill,) : Center(child: Text("No image available", style: TextStyle(fontWeight: FontWeight.bold),)),
                  )),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data.gymName!,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Text("${data.address1}${data.address2}",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text(data.city!,
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.grey.shade900,
              child: Column(children: [
                Text("STARTING AT 1833/month",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,fontSize: 20
                    )),
                    SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "FREE FIRST DAY",
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "BUY NOW",
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();

    path.moveTo(size.width * 0.0, size.height * 0.0);
    path.lineTo(size.width * 0.6, size.height * 0.0);
    path.lineTo(size.width * 0.65, size.height * 0.1);
    path.lineTo(size.width * 1, size.height * 0.1);
    path.lineTo(size.width * 1, size.height * 1);
    path.lineTo(0, size.height * 1);
    path.lineTo(size.width * 0.0, size.height * 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomPath1 extends CustomClipper<Path> {
  final bool flip;
  CustomPath1({this.flip = false});
  @override
  Path getClip(Size size) {
    final path = new Path();

    path.moveTo(size.width * 0.0, size.height * 0.0);

    flip
        ? path.lineTo(size.width * 0.0, size.height * 1)
        : path.lineTo(size.width * 0.2, size.height * 1);
    flip
        ? path.lineTo(size.width * 0.8, size.height * 1)
        : path.lineTo(size.width * 1, size.height * 1);

    path.lineTo(size.width * 1, size.height * 0.0);
    path.lineTo(size.width * 0.0, size.height * 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0, size.height * 0.0);
    path0.lineTo(size.width * 0.2, size.height * 1);
    path0.lineTo(size.width * 1, size.height * 1);
    path0.lineTo(size.width * 1, size.height * 0.0);
    path0.lineTo(size.width * 0.0, size.height * 0.0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
