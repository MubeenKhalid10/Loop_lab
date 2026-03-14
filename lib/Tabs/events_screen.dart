import 'package:flutter/material.dart';
import 'package:loop_lab/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final FirestoreService _fs = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fs.eventsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('No events'));
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final d=docs[index];
              final data = d.data() as Map<String,dynamic>;
              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['location'] ?? ''),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
