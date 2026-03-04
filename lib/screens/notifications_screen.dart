import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class _Notification {
  final String id;
  final String type;
  final String title;
  final String message;
  final String time;
  final bool read;
  const _Notification({required this.id, required this.type, required this.title, required this.message, required this.time, required this.read});
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool showAll = true;
  List<_Notification> _notifications = const [
    _Notification(id: '1', type: 'order', title: 'Order Shipped', message: 'Your order #12345 has been shipped and is on its way', time: '2 hours ago', read: false),
    _Notification(id: '2', type: 'favorite', title: 'Price Drop', message: 'An item in your wishlist is now on sale!', time: '5 hours ago', read: false),
    _Notification(id: '3', type: 'message', title: 'New Message', message: 'You have a new message from Support Team', time: '1 day ago', read: true),
    _Notification(id: '4', type: 'system', title: 'App Update', message: 'A new version of the app is available. Update now!', time: '2 days ago', read: true),
    _Notification(id: '5', type: 'order', title: 'Order Delivered', message: 'Your order #12344 has been delivered successfully', time: '3 days ago', read: true),
  ];

  int get _unreadCount => _notifications.where((n) => !n.read).length;
  List<_Notification> get _filtered => showAll ? _notifications : _notifications.where((n) => !n.read).toList();

  void _markAsRead(String id) {
    setState(() {
      _notifications = _notifications.map((n) => n.id == id ? _Notification(id: n.id, type: n.type, title: n.title, message: n.message, time: n.time, read: true) : n).toList();
    });
  }

  void _delete(String id) {
    setState(() => _notifications = _notifications.where((n) => n.id != id).toList());
  }

  void _markAllRead() {
    setState(() {
      _notifications = _notifications.map((n) => _Notification(id: n.id, type: n.type, title: n.title, message: n.message, time: n.time, read: true)).toList();
    });
  }

  static IconData _icon(String type) {
    switch (type) {
      case 'order': return Icons.local_shipping;
      case 'favorite': return Icons.favorite;
      case 'message': return Icons.message;
      case 'system': return Icons.settings;
      default: return Icons.notifications;
    }
  }

  static Color _iconColor(String type) {
    switch (type) {
      case 'order': return AppColors.chart1;
      case 'favorite': return Colors.pink;
      case 'message': return AppColors.chart4;
      case 'system': return AppColors.chart5;
      default: return AppColors.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notifications', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  Text(_unreadCount > 0 ? '$_unreadCount unread' : 'All caught up!', style: TextStyle(color: AppColors.mutedForeground)),
                ],
              ),
              if (_unreadCount > 0)
                TextButton(
                  onPressed: _markAllRead,
                  child: const Text('Mark all read'),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => showAll = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: showAll ? AppColors.primary : AppColors.accent,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    ),
                    child: Text('All (${_notifications.length})', textAlign: TextAlign.center,
                        style: TextStyle(color: showAll ? AppColors.primaryForeground : AppColors.accentForeground)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => showAll = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: !showAll ? AppColors.primary : AppColors.accent,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    ),
                    child: Text('Unread ($_unreadCount)', textAlign: TextAlign.center,
                        style: TextStyle(color: !showAll ? AppColors.primaryForeground : AppColors.accentForeground)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_filtered.isEmpty)
            AppCard(
              child: Column(
                children: [
                  Icon(Icons.notifications_none, size: 48, color: AppColors.mutedForeground),
                  const SizedBox(height: 12),
                  const Text('No notifications', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text("You're all caught up!", style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                ],
              ),
            )
          else
            ..._filtered.map((n) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                onTap: () => _markAsRead(n.id),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: _iconColor(n.type).withOpacity(0.15), shape: BoxShape.circle),
                          child: Icon(_icon(n.type), size: 20, color: _iconColor(n.type)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(n.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
                                  GestureDetector(
                                    onTap: () => _delete(n.id),
                                    child: Icon(Icons.close, size: 16, color: AppColors.mutedForeground),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(n.message, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text(n.time, style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (!n.read)
                      Positioned(
                        top: 16,
                        right: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        ),
                      ),
                  ],
                ),
              ),
            )),
        ],
      ),
    );
  }
}
