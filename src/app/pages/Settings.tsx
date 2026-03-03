import { useState } from 'react';
import { useNavigate } from 'react-router';
import { Card } from '../components/Card';
import { 
  Moon, 
  Bell, 
  Globe, 
  Lock, 
  HelpCircle, 
  Info, 
  FileText, 
  Shield,
  ChevronRight 
} from 'lucide-react';

export const Settings = () => {
  const navigate = useNavigate();
  const [darkMode, setDarkMode] = useState(false);
  const [notifications, setNotifications] = useState(true);
  const [language, setLanguage] = useState('English');

  const toggleDarkMode = () => {
    setDarkMode(!darkMode);
    document.documentElement.classList.toggle('dark');
  };

  const settingsSections = [
    {
      title: 'Preferences',
      items: [
        {
          icon: Moon,
          label: 'Dark Mode',
          type: 'toggle',
          value: darkMode,
          onChange: toggleDarkMode,
        },
        {
          icon: Bell,
          label: 'Push Notifications',
          type: 'toggle',
          value: notifications,
          onChange: () => setNotifications(!notifications),
        },
        {
          icon: Globe,
          label: 'Language',
          type: 'link',
          value: language,
          path: '/settings/language',
        },
      ],
    },
    {
      title: 'Security',
      items: [
        {
          icon: Lock,
          label: 'Change Password',
          type: 'link',
          path: '/auth/reset-password',
        },
      ],
    },
    {
      title: 'Support',
      items: [
        {
          icon: HelpCircle,
          label: 'Help Center',
          type: 'link',
          path: '/help',
        },
        {
          icon: Info,
          label: 'About',
          type: 'link',
          path: '/settings/about',
        },
      ],
    },
    {
      title: 'Legal',
      items: [
        {
          icon: FileText,
          label: 'Terms & Conditions',
          type: 'link',
          path: '/terms',
        },
        {
          icon: Shield,
          label: 'Privacy Policy',
          type: 'link',
          path: '/privacy',
        },
      ],
    },
  ];

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl mb-1">Settings</h1>
        <p className="text-muted-foreground">Manage your preferences</p>
      </div>

      {/* Settings Sections */}
      {settingsSections.map((section) => (
        <div key={section.title}>
          <h3 className="mb-3 text-sm text-muted-foreground px-2">
            {section.title}
          </h3>
          <Card className="divide-y divide-border">
            {section.items.map((item) => {
              const Icon = item.icon;
              return (
                <div
                  key={item.label}
                  className="flex items-center justify-between p-4 first:rounded-t-2xl last:rounded-b-2xl"
                >
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-primary/10 rounded-full flex items-center justify-center">
                      <Icon className="w-5 h-5 text-primary" />
                    </div>
                    <span>{item.label}</span>
                  </div>
                  {item.type === 'toggle' && (
                    <button
                      onClick={item.onChange}
                      className={`relative w-12 h-7 rounded-full transition-colors ${
                        item.value ? 'bg-primary' : 'bg-switch-background'
                      }`}
                    >
                      <div
                        className={`absolute top-1 left-1 w-5 h-5 bg-white rounded-full transition-transform ${
                          item.value ? 'translate-x-5' : 'translate-x-0'
                        }`}
                      />
                    </button>
                  )}
                  {item.type === 'link' && (
                    <button
                      onClick={() => item.path && navigate(item.path)}
                      className="flex items-center gap-2 text-muted-foreground"
                    >
                      {item.value && (
                        <span className="text-sm">{item.value}</span>
                      )}
                      <ChevronRight className="w-5 h-5" />
                    </button>
                  )}
                </div>
              );
            })}
          </Card>
        </div>
      ))}

      {/* App Version */}
      <Card className="text-center text-muted-foreground">
        <p className="text-sm">Version 1.0.0</p>
        <p className="text-xs mt-1">© 2026 WhiteLabel App. All rights reserved.</p>
      </Card>
    </div>
  );
};
