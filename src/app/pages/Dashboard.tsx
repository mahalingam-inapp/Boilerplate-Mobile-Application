import { useAuth } from '../contexts/AuthContext';
import { Card } from '../components/Card';
import { TrendingUp, Users, ShoppingBag, DollarSign, Activity } from 'lucide-react';
import { AreaChart, Area, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

const areaData = [
  { name: 'Mon', value: 400 },
  { name: 'Tue', value: 300 },
  { name: 'Wed', value: 600 },
  { name: 'Thu', value: 800 },
  { name: 'Fri', value: 500 },
  { name: 'Sat', value: 700 },
  { name: 'Sun', value: 900 },
];

const barData = [
  { name: 'Jan', value: 4000 },
  { name: 'Feb', value: 3000 },
  { name: 'Mar', value: 5000 },
  { name: 'Apr', value: 4500 },
  { name: 'May', value: 6000 },
  { name: 'Jun', value: 5500 },
];

export const Dashboard = () => {
  const { user } = useAuth();

  const metrics = [
    { icon: TrendingUp, label: 'Revenue', value: '$12,345', change: '+12.5%', color: 'text-chart-1' },
    { icon: Users, label: 'Users', value: '2,834', change: '+8.2%', color: 'text-chart-2' },
    { icon: ShoppingBag, label: 'Orders', value: '1,234', change: '+23.1%', color: 'text-chart-4' },
    { icon: Activity, label: 'Active', value: '892', change: '+5.3%', color: 'text-chart-5' },
  ];

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl mb-1">Welcome back, {user?.name}!</h1>
        <p className="text-muted-foreground">Here's what's happening today</p>
      </div>

      {/* Metrics Cards */}
      <div className="grid grid-cols-2 gap-4">
        {metrics.map((metric) => {
          const Icon = metric.icon;
          return (
            <Card key={metric.label} className="space-y-2">
              <div className="flex items-center justify-between">
                <Icon className={`w-5 h-5 ${metric.color}`} />
                <span className="text-xs text-green-600 bg-green-50 px-2 py-1 rounded-full">
                  {metric.change}
                </span>
              </div>
              <div>
                <p className="text-muted-foreground text-sm">{metric.label}</p>
                <p className="text-2xl mt-1">{metric.value}</p>
              </div>
            </Card>
          );
        })}
      </div>

      {/* Weekly Activity Chart */}
      <Card>
        <div className="mb-4">
          <h3 className="mb-1">Weekly Activity</h3>
          <p className="text-sm text-muted-foreground">Your activity over the past week</p>
        </div>
        <ResponsiveContainer width="100%" height={200}>
          <AreaChart data={areaData}>
            <defs>
              <linearGradient id="colorValue" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#ab1e23" stopOpacity={0.3} />
                <stop offset="95%" stopColor="#ab1e23" stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f2" />
            <XAxis dataKey="name" stroke="#6b6d7f" style={{ fontSize: '12px' }} />
            <YAxis stroke="#6b6d7f" style={{ fontSize: '12px' }} />
            <Tooltip
              contentStyle={{
                backgroundColor: '#ffffff',
                border: '1px solid #f0f0f2',
                borderRadius: '8px',
              }}
            />
            <Area
              type="monotone"
              dataKey="value"
              stroke="#ab1e23"
              strokeWidth={2}
              fillOpacity={1}
              fill="url(#colorValue)"
            />
          </AreaChart>
        </ResponsiveContainer>
      </Card>

      {/* Monthly Overview */}
      <Card>
        <div className="mb-4">
          <h3 className="mb-1">Monthly Overview</h3>
          <p className="text-sm text-muted-foreground">Performance over the last 6 months</p>
        </div>
        <ResponsiveContainer width="100%" height={200}>
          <BarChart data={barData}>
            <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f2" />
            <XAxis dataKey="name" stroke="#6b6d7f" style={{ fontSize: '12px' }} />
            <YAxis stroke="#6b6d7f" style={{ fontSize: '12px' }} />
            <Tooltip
              contentStyle={{
                backgroundColor: '#ffffff',
                border: '1px solid #f0f0f2',
                borderRadius: '8px',
              }}
            />
            <Bar dataKey="value" fill="#ab1e23" radius={[8, 8, 0, 0]} />
          </BarChart>
        </ResponsiveContainer>
      </Card>

      {/* Quick Actions */}
      <Card>
        <h3 className="mb-4">Quick Actions</h3>
        <div className="grid grid-cols-2 gap-3">
          <button className="p-4 bg-primary/5 rounded-xl text-left hover:bg-primary/10 transition-colors">
            <DollarSign className="w-6 h-6 text-primary mb-2" />
            <p className="text-sm">New Transaction</p>
          </button>
          <button className="p-4 bg-secondary/5 rounded-xl text-left hover:bg-secondary/10 transition-colors">
            <Users className="w-6 h-6 text-secondary mb-2" />
            <p className="text-sm">Add User</p>
          </button>
          <button className="p-4 bg-primary/5 rounded-xl text-left hover:bg-primary/10 transition-colors">
            <ShoppingBag className="w-6 h-6 text-primary mb-2" />
            <p className="text-sm">View Orders</p>
          </button>
          <button className="p-4 bg-secondary/5 rounded-xl text-left hover:bg-secondary/10 transition-colors">
            <Activity className="w-6 h-6 text-secondary mb-2" />
            <p className="text-sm">Analytics</p>
          </button>
        </div>
      </Card>
    </div>
  );
};
