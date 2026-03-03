import { Outlet, useLocation, useNavigate } from 'react-router';
import { Home, Search, User, Settings as SettingsIcon, Bell } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';

export const Root = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { user } = useAuth();

  const isAuthRoute = location.pathname.startsWith('/auth');

  // Don't show navigation on auth pages
  if (isAuthRoute) {
    return (
      <div className="min-h-screen bg-background">
        <Outlet />
      </div>
    );
  }

  // Protected routes - redirect to signin if not authenticated
  if (!user) {
    navigate('/auth/signin');
    return null;
  }

  const navItems = [
    { icon: Home, label: 'Home', path: '/dashboard' },
    { icon: Search, label: 'Search', path: '/search' },
    { icon: Bell, label: 'Notifications', path: '/notifications' },
    { icon: User, label: 'Profile', path: '/profile' },
    { icon: SettingsIcon, label: 'Settings', path: '/settings' },
  ];

  return (
    <div className="min-h-screen bg-background pb-20">
      {/* Main Content */}
      <main className="max-w-md mx-auto">
        <Outlet />
      </main>

      {/* Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 bg-card border-t border-border max-w-md mx-auto">
        <div className="flex items-center justify-around px-2 py-3">
          {navItems.map((item) => {
            const isActive = location.pathname === item.path;
            const Icon = item.icon;
            return (
              <button
                key={item.path}
                onClick={() => navigate(item.path)}
                className={`flex flex-col items-center gap-1 px-3 py-1 rounded-lg transition-colors ${
                  isActive
                    ? 'text-primary'
                    : 'text-muted-foreground hover:text-foreground'
                }`}
              >
                <Icon className="w-5 h-5" />
                <span className="text-xs">{item.label}</span>
              </button>
            );
          })}
        </div>
      </nav>
    </div>
  );
};
