import 'package:flutter/material.dart';
import 'package:flutter_app/Widget/Wifi/wifi_modal_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_app/Controller/wifi_controller.dart';

class WifiConnectWidget extends StatelessWidget {
  final WifiController controller = Get.put(WifiController());

  WifiConnectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.connectToESPWifi();
    return Scaffold(
      body: Obx(() => Column(
            children: <Widget>[
              Text(
                'uri: ${controller.uri}, response: ${controller.response}, retry: ${controller.retryCount}',
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: controller.receivedDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          elevation: 16,
                          shadowColor: Colors.blue,
                          child: ListTile(
                            title: Text(controller.receivedDataList[index]),
                            trailing: const Icon(Icons.wifi),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (context) {
                                  controller.ssid.value = controller.receivedDataList[index];
                                  return const WifiConnectModalWidget();
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.receivedDataList.clear();
        },
        child: const Icon(Icons.wifi),
      ),
    );
  }
}