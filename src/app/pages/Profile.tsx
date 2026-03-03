import { useNavigate } from 'react-router';
import { useAuth } from '../contexts/AuthContext';
import { Card } from '../components/Card';
import { Button } from '../components/Button';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { Edit, Mail, Phone, MapPin, Calendar, Settings as SettingsIcon } from 'lucide-react';

export const Profile = () => {
  const navigate = useNavigate();
  const { user, signOut } = useAuth();

  const stats = [
    { label: 'Orders', value: '24' },
    { label: 'Wishlist', value: '12' },
    { label: 'Reviews', value: '8' },
  ];

  const menuItems = [
    { icon: Edit, label: 'Edit Profile', path: '/profile/edit' },
    { icon: SettingsIcon, label: 'Settings', path: '/settings' },
    { icon: MapPin, label: 'Addresses', path: '/profile/addresses' },
    { icon: Calendar, label: 'Order History', path: '/profile/orders' },
  ];

  return (
    <div className="p-6 space-y-6">
      {/* Profile Header */}
      <Card className="text-center">
        <div className="relative inline-block mb-4">
          <ImageWithFallback
            src={user?.avatar || ''}
            alt={user?.name || 'User'}
            className="w-24 h-24 rounded-full mx-auto object-cover border-4 border-background"
          />
          <button className="absolute bottom-0 right-0 w-8 h-8 bg-primary text-primary-foreground rounded-full flex items-center justify-center">
            <Edit className="w-4 h-4" />
          </button>
        </div>
        <h2 className="text-xl mb-1">{user?.name}</h2>
        {user?.email && (
          <div className="flex items-center justify-center gap-2 text-muted-foreground mb-2">
            <Mail className="w-4 h-4" />
            <span className="text-sm">{user.email}</span>
          </div>
        )}
        {user?.phone && (
          <div className="flex items-center justify-center gap-2 text-muted-foreground">
            <Phone className="w-4 h-4" />
            <span className="text-sm">{user.phone}</span>
          </div>
        )}
      </Card>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-4">
        {stats.map((stat) => (
          <Card key={stat.label} className="text-center">
            <p className="text-2xl mb-1">{stat.value}</p>
            <p className="text-sm text-muted-foreground">{stat.label}</p>
          </Card>
        ))}
      </div>

      {/* Menu Items */}
      <Card className="divide-y divide-border">
        {menuItems.map((item) => {
          const Icon = item.icon;
          return (
            <button
              key={item.label}
              onClick={() => navigate(item.path)}
              className="w-full flex items-center gap-3 p-4 hover:bg-accent/50 transition-colors first:rounded-t-2xl last:rounded-b-2xl"
            >
              <div className="w-10 h-10 bg-primary/10 rounded-full flex items-center justify-center">
                <Icon className="w-5 h-5 text-primary" />
              </div>
              <span className="flex-1 text-left">{item.label}</span>
              <span className="text-muted-foreground">›</span>
            </button>
          );
        })}
      </Card>

      {/* Sign Out */}
      <Button
        variant="outline"
        className="w-full"
        onClick={() => {
          signOut();
          navigate('/auth/signin');
        }}
      >
        Sign Out
      </Button>
    </div>
  );
};
