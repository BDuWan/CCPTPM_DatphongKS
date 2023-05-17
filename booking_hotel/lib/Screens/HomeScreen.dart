import 'package:booking_hotel/Screens/IntroScreen.dart';
import 'package:booking_hotel/fire_base/fire_base_auth.dart';
import 'package:booking_hotel/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '';
import '../blocs/provider.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';
import 'package:booking_hotel/Helper.dart';
import 'ShowListScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    IntroScreen(),
    LoginScreen(),
    RegisterScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<String>(
            future: FireAuth().getPropertyById(provider.userId, 'name'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'Chào mừng ${snapshot.data!}',
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return const Text('Loading...');
            },
          ),
        ),
        body: const HomeBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.local_grocery_store),
              label: 'Mail',
              backgroundColor: Colors.deepOrange,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              label: 'Screen 3',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              label: 'Screen 4',
              backgroundColor: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _formkey = GlobalKey<FormState>();
  String roomId = '';
  int floor = -1;
  int numofper = -1;
  int lowcost = -1;
  int highcost = -1;

  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
            height: size.height * 0.2,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
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
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        provider.setRoomId(roomId);
                        Helper.nextPage(context, ShowListScreen());
                      }
                    },
                    child:
                        const Text(style: TextStyle(fontSize: 20), 'Tìm kiếm'),
                  ),
                ],
              ),
            )),
        const SizedBox(
          height: 30,
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: 0.45 * size.height,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Tầng số',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      width: 53,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              floor = value as int;
                            });
                          },
                          validator: (value) {
                            floor = value! as int;
                            if (floor == -1) {
                              return 'Bạn chưa nhập dữ liệu';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
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
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              numofper = value as int;
                            });
                          },
                          validator: (value) {
                            numofper = value! as int;
                            if (numofper == -1) {
                              return 'Bạn chưa nhập dữ liệu';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
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
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      width: 63,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              lowcost = value as int;
                            });
                          },
                          validator: (value) {
                            lowcost = value! as int;
                            if (lowcost == -1) {
                              return 'Bạn chưa nhập dữ liệu';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
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
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              highcost = value as int;
                            });
                          },
                          validator: (value) {
                            highcost = value! as int;
                            if (highcost == -1) {
                              return 'Bạn chưa nhập dữ liệu';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
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
                    if(_formkey.currentState!.validate()){
                      provider.setFloor(floor);
                      provider.setNumofper(numofper);
                      provider.setLowcost(lowcost);
                      provider.setHighcost(highcost);
                      Helper.nextPage(context, ShowListScreen());
                    }
                  },
                  child: const Text(style: TextStyle(fontSize: 20), 'Lọc'),
                ),
              ],
            ))
      ]),
    );
  }
}
