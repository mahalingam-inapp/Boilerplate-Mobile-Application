import { useState } from 'react';
import { Card } from '../components/Card';
import { Bell, Package, Heart, MessageSquare, Settings as SettingsIcon, X } from 'lucide-react';
import { Button } from '../components/Button';

interface Notification {
  id: string;
  type: 'order' | 'favorite' | 'message' | 'system';
  title: string;
  message: string;
  time: string;
  read: boolean;
}

const mockNotifications: Notification[] = [
  {
    id: '1',
    type: 'order',
    title: 'Order Shipped',
    message: 'Your order #12345 has been shipped and is on its way',
    time: '2 hours ago',
    read: false,
  },
  {
    id: '2',
    type: 'favorite',
    title: 'Price Drop',
    message: 'An item in your wishlist is now on sale!',
    time: '5 hours ago',
    read: false,
  },
  {
    id: '3',
    type: 'message',
    title: 'New Message',
    message: 'You have a new message from Support Team',
    time: '1 day ago',
    read: true,
  },
  {
    id: '4',
    type: 'system',
    title: 'App Update',
    message: 'A new version of the app is available. Update now!',
    time: '2 days ago',
    read: true,
  },
  {
    id: '5',
    type: 'order',
    title: 'Order Delivered',
    message: 'Your order #12344 has been delivered successfully',
    time: '3 days ago',
    read: true,
  },
];

const getIcon = (type: string) => {
  switch (type) {
    case 'order':
      return Package;
    case 'favorite':
      return Heart;
    case 'message':
      return MessageSquare;
    case 'system':
      return SettingsIcon;
    default:
      return Bell;
  }
};

const getIconColor = (type: string) => {
  switch (type) {
    case 'order':
      return 'text-chart-1 bg-chart-1/10';
    case 'favorite':
      return 'text-pink-600 bg-pink-50';
    case 'message':
      return 'text-chart-2 bg-chart-2/10';
    case 'system':
      return 'text-chart-5 bg-chart-5/10';
    default:
      return 'text-muted-foreground bg-muted';
  }
};

export const Notifications = () => {
  const [notifications, setNotifications] = useState(mockNotifications);
  const [filter, setFilter] = useState<'all' | 'unread'>('all');

  const filteredNotifications = filter === 'unread'
    ? notifications.filter(n => !n.read)
    : notifications;

  const unreadCount = notifications.filter(n => !n.read).length;

  const markAsRead = (id: string) => {
    setNotifications(prev =>
      prev.map(n => (n.id === id ? { ...n, read: true } : n))
    );
  };

  const deleteNotification = (id: string) => {
    setNotifications(prev => prev.filter(n => n.id !== id));
  };

  const markAllAsRead = () => {
    setNotifications(prev => prev.map(n => ({ ...n, read: true })));
  };

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl mb-1">Notifications</h1>
          <p className="text-muted-foreground">
            {unreadCount > 0 ? `${unreadCount} unread` : 'All caught up!'}
          </p>
        </div>
        {unreadCount > 0 && (
          <Button variant="ghost" size="sm" onClick={markAllAsRead}>
            Mark all read
          </Button>
        )}
      </div>

      {/* Filter Tabs */}
      <div className="flex gap-2">
        <button
          onClick={() => setFilter('all')}
          className={`flex-1 py-2.5 rounded-xl transition-colors ${
            filter === 'all'
              ? 'bg-primary text-primary-foreground'
              : 'bg-accent text-accent-foreground'
          }`}
        >
          All ({notifications.length})
        </button>
        <button
          onClick={() => setFilter('unread')}
          className={`flex-1 py-2.5 rounded-xl transition-colors ${
            filter === 'unread'
              ? 'bg-primary text-primary-foreground'
              : 'bg-accent text-accent-foreground'
          }`}
        >
          Unread ({unreadCount})
        </button>
      </div>

      {/* Notifications List */}
      {filteredNotifications.length > 0 ? (
        <div className="space-y-3">
          {filteredNotifications.map((notification) => {
            const Icon = getIcon(notification.type);
            const iconColor = getIconColor(notification.type);
            return (
              <Card
                key={notification.id}
                className={`relative ${
                  !notification.read ? 'border-l-4 border-l-primary' : ''
                }`}
                onClick={() => markAsRead(notification.id)}
              >
                <div className="flex gap-3">
                  <div className={`w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0 ${iconColor}`}>
                    <Icon className="w-5 h-5" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between gap-2 mb-1">
                      <h3 className="text-sm">{notification.title}</h3>
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          deleteNotification(notification.id);
                        }}
                        className="text-muted-foreground hover:text-foreground"
                      >
                        <X className="w-4 h-4" />
                      </button>
                    </div>
                    <p className="text-sm text-muted-foreground line-clamp-2 mb-2">
                      {notification.message}
                    </p>
                    <p className="text-xs text-muted-foreground">{notification.time}</p>
                  </div>
                </div>
                {!notification.read && (
                  <div className="absolute top-4 right-4 w-2 h-2 bg-primary rounded-full" />
                )}
              </Card>
            );
          })}
        </div>
      ) : (
        <Card className="text-center py-12">
          <Bell className="w-12 h-12 mx-auto mb-3 text-muted-foreground" />
          <h3 className="mb-1">No notifications</h3>
          <p className="text-muted-foreground text-sm">
            You're all caught up!
          </p>
        </Card>
      )}
    </div>
  );
};
