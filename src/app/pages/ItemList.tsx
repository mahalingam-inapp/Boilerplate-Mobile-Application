import { useState } from 'react';
import { useNavigate } from 'react-router';
import { Card } from '../components/Card';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { Grid, List, ChevronRight, Plus } from 'lucide-react';
import { Button } from '../components/Button';

const mockItems = [
  {
    id: '1',
    title: 'Premium Wireless Headphones',
    category: 'Electronics',
    price: '$299',
    image: 'https://images.unsplash.com/photo-1636353125878-38f866ee0343?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwcm9kdWN0JTIwdGVjaG5vbG9neSUyMGdhZGdldHxlbnwxfHx8fDE3NzI1NTI0NzJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    status: 'In Stock',
  },
  {
    id: '2',
    title: 'Modern Office Chair',
    category: 'Furniture',
    price: '$449',
    image: 'https://images.unsplash.com/photo-1709346739762-e8ecacc96e0a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBmdXJuaXR1cmUlMjBkZXNpZ258ZW58MXx8fHwxNzcyNDc4ODcxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    status: 'In Stock',
  },
  {
    id: '3',
    title: 'Artisan Coffee Blend',
    category: 'Food & Beverage',
    price: '$24',
    image: 'https://images.unsplash.com/photo-1771422574972-3d8b237d6c12?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb2ZmZWUlMjBkcmluayUyMGJldmVyYWdlfGVufDF8fHx8MTc3MjU1MjQ3M3ww&ixlib=rb-4.1.0&q=80&w=1080',
    status: 'In Stock',
  },
  {
    id: '4',
    title: 'Designer Jacket',
    category: 'Fashion',
    price: '$189',
    image: 'https://images.unsplash.com/photo-1763771522867-c26bf75f12bc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmYXNoaW9uJTIwY2xvdGhpbmclMjBhcHBhcmVsfGVufDF8fHx8MTc3MjUwMDYwM3ww&ixlib=rb-4.1.0&q=80&w=1080',
    status: 'Low Stock',
  },
];

export const ItemList = () => {
  const navigate = useNavigate();
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  const [selectedCategory, setSelectedCategory] = useState<string>('All');

  const categories = ['All', 'Electronics', 'Furniture', 'Food & Beverage', 'Fashion'];

  const filteredItems = selectedCategory === 'All'
    ? mockItems
    : mockItems.filter(item => item.category === selectedCategory);

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl mb-1">Items</h1>
          <p className="text-muted-foreground">{filteredItems.length} items available</p>
        </div>
        <Button
          variant="primary"
          size="sm"
          onClick={() => navigate('/create')}
          className="flex items-center gap-2"
        >
          <Plus className="w-4 h-4" />
          Add
        </Button>
      </div>

      {/* View Toggle */}
      <div className="flex items-center justify-between">
        <div className="flex gap-2 overflow-x-auto pb-2">
          {categories.map((category) => (
            <button
              key={category}
              onClick={() => setSelectedCategory(category)}
              className={`px-4 py-2 rounded-xl whitespace-nowrap transition-colors ${
                selectedCategory === category
                  ? 'bg-primary text-primary-foreground'
                  : 'bg-accent text-accent-foreground hover:bg-accent/80'
              }`}
            >
              {category}
            </button>
          ))}
        </div>
        <div className="flex gap-2">
          <button
            onClick={() => setViewMode('grid')}
            className={`p-2 rounded-lg ${
              viewMode === 'grid' ? 'bg-primary text-primary-foreground' : 'bg-accent'
            }`}
          >
            <Grid className="w-5 h-5" />
          </button>
          <button
            onClick={() => setViewMode('list')}
            className={`p-2 rounded-lg ${
              viewMode === 'list' ? 'bg-primary text-primary-foreground' : 'bg-accent'
            }`}
          >
            <List className="w-5 h-5" />
          </button>
        </div>
      </div>

      {/* Items Grid/List */}
      {viewMode === 'grid' ? (
        <div className="grid grid-cols-2 gap-4">
          {filteredItems.map((item) => (
            <Card
              key={item.id}
              onClick={() => navigate(`/items/${item.id}`)}
              className="overflow-hidden p-0"
            >
              <ImageWithFallback
                src={item.image}
                alt={item.title}
                className="w-full h-40 object-cover"
              />
              <div className="p-3 space-y-2">
                <div>
                  <p className="text-xs text-muted-foreground">{item.category}</p>
                  <h3 className="text-sm line-clamp-2">{item.title}</h3>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-primary">{item.price}</span>
                  <span className={`text-xs px-2 py-1 rounded-full ${
                    item.status === 'In Stock'
                      ? 'bg-green-50 text-green-600'
                      : 'bg-yellow-50 text-yellow-600'
                  }`}>
                    {item.status}
                  </span>
                </div>
              </div>
            </Card>
          ))}
        </div>
      ) : (
        <div className="space-y-3">
          {filteredItems.map((item) => (
            <Card
              key={item.id}
              onClick={() => navigate(`/items/${item.id}`)}
              className="flex items-center gap-4"
            >
              <ImageWithFallback
                src={item.image}
                alt={item.title}
                className="w-20 h-20 rounded-lg object-cover"
              />
              <div className="flex-1 min-w-0">
                <p className="text-xs text-muted-foreground">{item.category}</p>
                <h3 className="text-sm line-clamp-1">{item.title}</h3>
                <div className="flex items-center gap-2 mt-1">
                  <span className="text-primary">{item.price}</span>
                  <span className={`text-xs px-2 py-0.5 rounded-full ${
                    item.status === 'In Stock'
                      ? 'bg-green-50 text-green-600'
                      : 'bg-yellow-50 text-yellow-600'
                  }`}>
                    {item.status}
                  </span>
                </div>
              </div>
              <ChevronRight className="w-5 h-5 text-muted-foreground flex-shrink-0" />
            </Card>
          ))}
        </div>
      )}
    </div>
  );
};
