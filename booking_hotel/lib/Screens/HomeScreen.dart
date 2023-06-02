import 'package:booking_hotel/Screens/ShowRoomScreen.dart';
import 'package:booking_hotel/dialog/LoadingDialog.dart';
import 'package:booking_hotel/dialog/MsgDialog.dart';
import 'package:booking_hotel/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import '../repository/user_repository.dart';
import 'package:booking_hotel/Helper.dart';
import 'ShowListRoomScreen.dart';
import 'bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    LoadingDialog.hideLoadingDialog();
    MyProvider provider = context.read<MyProvider>();
    Get.put(UserRepository());
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: FutureBuilder<UserModel>(
              future: UserRepository().getUserById(provider.curUserId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Chào mừng ${snapshot.data!.name}',
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return const Text('Loading...');
              },
            ),
          ),
          body: const HomeBody(),
          bottomNavigationBar: const BottomNavigation(
            currentIndex: 0,
          )),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String roomId = '';

  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                onChanged: (value) {
                  setState(() {
                    roomId = value;
                  });
                },
                validator: (value) {
                  roomId = value!;
                  if (roomId.isEmpty) {
                    return 'Bạn chưa nhập id phòng cần tìm';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Tìm kiếm',
                    hintText: 'Nhập id phòng bạn cần tìm',
                    prefixIcon: Image.asset(
                      'assets/images/search.png',
                      width: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 1, 0, 1)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    provider.setRoomId(roomId);
                    Helper.nextPage(context, const ShowRoomScreen());
                  }
                },
                child:
                    const Text(style: TextStyle(fontSize: 20), 'Tìm kiếm'),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const HomeBody2()
      ]),
    );
  }
}

class HomeBody2 extends StatefulWidget {
  const HomeBody2({Key? key}) : super(key: key);

  @override
  State<HomeBody2> createState() => _HomeBody2State();
}

class _HomeBody2State extends State<HomeBody2> {
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();
  String floor = '';
  String capacity = '';
  String lowcost = '';
  String highcost = '';

  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        height: 0.45 * size.height,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.indigo,
            width: 3,
          ),
        ),
        child: Form(
          key: _formkey2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Tầng số',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 53,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              floor = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 1, 0, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Số người ở',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              capacity = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 1, 0, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    Text(
                      'Khoảng giá tiền:',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Từ',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 63,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              lowcost = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 1, 0, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Đến',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              highcost = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 1, 0, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    int? floorInt = int.tryParse(floor);
                    int? capacityInt = int.tryParse(capacity);
                    int? lowcostInt = int.tryParse(lowcost);
                    int? highcostInt = int.tryParse(highcost);

                    if (floorInt == null ||
                        capacityInt == null ||
                        lowcostInt == null ||
                        highcostInt == null) {
                      MsgDialog.showMsgDialog(context, 'Errol',
                          'Bạn phải nhập đẩy đủ dữ liệu, dữ liệu nhập vào phải là số nguyên');
                    } else {
                      provider.setFloor(floorInt);
                      provider.setCapacity(capacityInt);
                      provider.setLowcost(lowcostInt);
                      provider.setHighcost(highcostInt);
                      Helper.nextPage(context, const ShowListRoomScreen());
                    }
                  },
                  child: const Text(style: TextStyle(fontSize: 20), 'Lọc'),
                ),
              ],
            ),
          ),
        ));
  }
}
