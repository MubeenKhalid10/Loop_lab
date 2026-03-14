import 'package:flutter/material.dart';
import 'package:loop_lab/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementsScreen extends StatelessWidget {
  final FirestoreService _fs = FirestoreService();
  AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Announcements')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fs.announcementsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('No announcements'));
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final d=docs[index];
              final data = d.data() as Map<String,dynamic>;
              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['content'] ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
