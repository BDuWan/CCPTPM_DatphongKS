import 'package:flutter/material.dart';
import 'package:booking_hotel/model/room_model.dart';
import 'package:booking_hotel/repository/room_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../blocs/provider.dart';

class ShowListScreen extends StatefulWidget {
  @override
  State<ShowListScreen> createState() => _ShowListScreenState();
}

class _ShowListScreenState extends State<ShowListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách các phòng phù hợp'),
      ),
      body: RoomListWidget(),
    );
  }
}

class RoomListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    Get.put(RoomRepository());
    return FutureBuilder<List<RoomModel>>(
      future: RoomRepository.instance.getRoomById(provider.roomId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final rooms = snapshot.data!;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return ListTile(
                title: Text('Phòng ${room.id}'),
                subtitle:
                    Text('Tầng: ${room.floor}, Số người: ${room.numofper}'),
                trailing: Text('Giá: ${room.cost}'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Đã xảy ra lỗi khi tải danh sách phòng');
        } else if (snapshot.data == null) {
          return const Text('Không tìm thấy phòng phù hợp');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
