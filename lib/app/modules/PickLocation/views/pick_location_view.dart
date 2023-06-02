import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:wtf/app/modules/home/controllers/home_controller.dart';

import '../../../api.dart';
import '../../../custom_clickable.dart';
import '../../../location.dart';
import '../controllers/pick_location_controller.dart';

class PickLocationView extends GetView<PickLocationController> {
  const PickLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 50,

            leading: Center(
              child: ClickableWidget(
                onTap: () {
                  Get.back();
                  Get.find<HomeController>().init();
                },
                widget: Container(
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
            ),
            title: const Text(
              'Pick Location',
              style: TextStyle(color: Colors.black),
            ),
            // centerTitle: true,

            actions:  [
              Row(
                children: [
                  Text(
                     (controller. lat.value != null &&  controller.long.value != null)  ? "${controller. lat.value!.toStringAsFixed(5)},${controller. long.value!.toStringAsFixed(5)}"  : "No location",

                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  )
                ],
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE2E2E2),
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Search Location',
                    // hintStyle: TextStyle(color: Colors.black26),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClickableWidget(
                         onTap: () async {
                        Get.showOverlay(
                            loadingWidget:
                                Center(child: CircularProgressIndicator()),
                            asyncFunction: () async {
                              var position = await determinePosition();

                              // List<Placemark> placemarks =
                              //     await placemarkFromCoordinates(
                              //         position.latitude, position.longitude);

                              // print(placemarks);

                              controller.data.value = await getGymData(
                                  1, 30, position.latitude, position.longitude);

                              controller.setLocationToLocalStorage(
                                  position.latitude, position.longitude);
                            });
                      },
                        widget: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.location_searching_rounded),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Around Your Location",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    ClickableWidget(
                      onTap: () async {
                        Get.showOverlay(
                            loadingWidget:
                                Center(child: CircularProgressIndicator()),
                            asyncFunction: () async {
                              var position = await determinePosition();

                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      position.latitude, position.longitude);

                              print(placemarks);

                              controller.data.value = await getGymData(
                                  1, 30, position.latitude, position.longitude);

                              controller.setLocationToLocalStorage(
                                  position.latitude, position.longitude);
                            });
                      },
                      widget: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.add_location_alt),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                RichText(
                  text: const TextSpan(
                    text: "AREA ",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: '(No. of gyms)',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal
                            // decoration: TextDecoration.underline
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                if (controller.data.value != null)
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.data.value!.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  Icon(Icons.location_pin),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    controller.data.value!.data![index]
                                            .address1 ??
                                        "Address not available",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
              ],
            ),
          ),
        ));
  }
}
