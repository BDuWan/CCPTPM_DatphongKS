import 'package:booking_hotel/Helper.dart';
import 'package:booking_hotel/Screens/BookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel/model/room_model.dart';
import 'package:booking_hotel/repository/room_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import 'bottom_navigation.dart';

class ShowListRoomScreen extends StatefulWidget {
  const ShowListRoomScreen({super.key});

  @override
  State<ShowListRoomScreen> createState() => _ShowListRoomScreenState();
}

class _ShowListRoomScreenState extends State<ShowListRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách các phòng phù hợp'),
      ),
      body: const RoomListWidget(),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0,),
    );
  }
}

class RoomListWidget extends StatelessWidget {
  const RoomListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    Get.put(RoomRepository());
    return FutureBuilder<List<RoomModel>>(
      future: RoomRepository.instance.getRoomWithQuery(provider.floor,
          provider.capacity, provider.lowcost, provider.highcost),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final rooms = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return ListTile(
                  title: Text('Phòng ${room.roomid}'),
                  subtitle:
                      Text('Tầng: ${room.floor}, Số người: ${room.capacity}'),
                  trailing: Text('Giá: ${room.cost}'),
                  onTap: () {
                    provider.setChoosedRoomId(room.roomid);
                    Helper.nextPage(context, BookingScreen());
                  });
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Đã xảy ra lỗi khi tải danh sách phòng');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
