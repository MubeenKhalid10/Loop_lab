import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class EventDetailScreen extends StatefulWidget {
  final Map<String, dynamic> event;
  
  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isRegistered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar with Event Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: _getEventTypeColor(widget.event['type'] as String),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _getEventTypeColor(widget.event['type'] as String),
                      _getEventTypeColor(widget.event['type'] as String).withOpacity(0.8),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getEventIcon(widget.event['type'] as String),
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget.event['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.event['type'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Event Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Info Card
                  _buildEventInfoCard(isDark, textColor, secondaryTextColor, cardColor),
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  _buildActionButtons(isDark, textColor),
                  const SizedBox(height: 24),
                  
                  // Description
                  _buildDescription(isDark, textColor, secondaryTextColor),
                  const SizedBox(height: 24),
                  
                  // Agenda
                  _buildAgenda(isDark, textColor, secondaryTextColor, cardColor),
                  const SizedBox(height: 24),
                  
                  // Speakers
                  _buildSpeakers(isDark, textColor, secondaryTextColor, cardColor),
                  const SizedBox(height: 24),
                  
                  // Attendees
                  _buildAttendees(isDark, textColor, secondaryTextColor, cardColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfoCard(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.calendar_today, 'Date', widget.event['date'] as String, isDark, secondaryTextColor, textColor),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.access_time, 'Time', widget.event['time'] as String, isDark, secondaryTextColor, textColor),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.location_on, 'Location', widget.event['location'] as String, isDark, secondaryTextColor, textColor),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.people, 'Attendees', '${widget.event['attendees']} registered', isDark, secondaryTextColor, textColor),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDark, Color secondaryTextColor, Color textColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getEventTypeColor(widget.event['type'] as String).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: _getEventTypeColor(widget.event['type'] as String),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isDark, Color textColor) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isRegistered = !isRegistered;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isRegistered 
                  ? AppColors.greenAccent
                  : _getEventTypeColor(widget.event['type'] as String),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              isRegistered ? 'Registered ✓' : 'Register Now',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Add to calendar
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: _getEventTypeColor(widget.event['type'] as String),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Icon(
              Icons.calendar_today,
              color: _getEventTypeColor(widget.event['type'] as String),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Share event
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              foregroundColor: textColor,
            ),
            child: const Icon(
              Icons.share,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(bool isDark, Color textColor, Color secondaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About this event',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.event['description'] as String,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAgenda(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    final agenda = [
      {'time': '2:00 PM', 'title': 'Registration & Welcome'},
      {'time': '2:30 PM', 'title': 'Opening Keynote'},
      {'time': '3:15 PM', 'title': 'Technical Session 1'},
      {'time': '4:00 PM', 'title': 'Coffee Break'},
      {'time': '4:30 PM', 'title': 'Technical Session 2'},
      {'time': '5:15 PM', 'title': 'Q&A and Closing'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Agenda',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: agenda.map((item) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getEventTypeColor(widget.event['type'] as String).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['time']!,
                      style: TextStyle(
                        color: _getEventTypeColor(widget.event['type'] as String),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakers(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    final speakers = [
      {'name': 'John Smith', 'role': 'Senior Developer', 'company': 'Tech Corp'},
      {'name': 'Jane Doe', 'role': 'Product Manager', 'company': 'Innovation Inc'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Speakers',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        ...speakers.map((speaker) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: _getEventTypeColor(widget.event['type'] as String),
                child: Text(
                  speaker['name']![0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      speaker['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      speaker['role']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                    Text(
                      speaker['company']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: _getEventTypeColor(widget.event['type'] as String),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildAttendees(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendees (${widget.event['attendees']})',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(
                  color: _getEventTypeColor(widget.event['type'] as String),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar Stack
              SizedBox(
                width: 120,
                height: 40,
                child: Stack(
                  children: List.generate(5, (index) => Positioned(
                    left: index * 20.0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: _getEventTypeColor(widget.event['type'] as String),
                      child: Text(
                        'U${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'and ${int.parse(widget.event['attendees'] as String) - 5} others',
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getEventTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'workshop':
        return AppColors.greenAccent;
      case 'bootcamp':
        return AppColors.blueAccent;
      case 'meetup':
        return AppColors.orangeAccent;
      default:
        return AppColors.primaryBlue;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type.toLowerCase()) {
      case 'workshop':
        return Icons.build;
      case 'bootcamp':
        return Icons.school;
      case 'meetup':
        return Icons.people;
      default:
        return Icons.event;
    }
  }
}
