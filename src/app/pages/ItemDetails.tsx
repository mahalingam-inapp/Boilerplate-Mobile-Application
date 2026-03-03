import { useParams, useNavigate } from 'react-router';
import { Button } from '../components/Button';
import { Card } from '../components/Card';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { ArrowLeft, Star, ShoppingCart, Heart, Share2 } from 'lucide-react';
import { toast } from 'sonner';

const mockItemDetails = {
  '1': {
    title: 'Premium Wireless Headphones',
    category: 'Electronics',
    price: '$299',
    rating: 4.8,
    reviews: 234,
    image: 'https://images.unsplash.com/photo-1636353125878-38f866ee0343?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwcm9kdWN0JTIwdGVjaG5vbG9neSUyMGdhZGdldHxlbnwxfHx8fDE3NzI1NTI0NzJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    description: 'Experience premium audio quality with our state-of-the-art wireless headphones. Featuring active noise cancellation, 30-hour battery life, and premium comfort padding.',
    features: [
      'Active Noise Cancellation',
      '30-hour battery life',
      'Premium comfort padding',
      'Bluetooth 5.0',
      'Foldable design',
    ],
    status: 'In Stock',
  },
  '2': {
    title: 'Modern Office Chair',
    category: 'Furniture',
    price: '$449',
    rating: 4.6,
    reviews: 128,
    image: 'https://images.unsplash.com/photo-1709346739762-e8ecacc96e0a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBmdXJuaXR1cmUlMjBkZXNpZ258ZW58MXx8fHwxNzcyNDc4ODcxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    description: 'Ergonomic office chair designed for all-day comfort. Features adjustable lumbar support, breathable mesh back, and premium hydraulic adjustment.',
    features: [
      'Ergonomic design',
      'Adjustable lumbar support',
      'Breathable mesh',
      'Premium hydraulics',
      '360° swivel',
    ],
    status: 'In Stock',
  },
  '3': {
    title: 'Artisan Coffee Blend',
    category: 'Food & Beverage',
    price: '$24',
    rating: 4.9,
    reviews: 456,
    image: 'https://images.unsplash.com/photo-1771422574972-3d8b237d6c12?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb2ZmZWUlMjBkcmluayUyMGJldmVyYWdlfGVufDF8fHx8MTc3MjU1MjQ3M3ww&ixlib=rb-4.1.0&q=80&w=1080',
    description: 'Carefully crafted artisan coffee blend sourced from sustainable farms. Rich, smooth flavor with notes of chocolate and caramel.',
    features: [
      'Single-origin beans',
      'Sustainably sourced',
      'Medium roast',
      'Rich flavor profile',
      'Freshly roasted',
    ],
    status: 'In Stock',
  },
  '4': {
    title: 'Designer Jacket',
    category: 'Fashion',
    price: '$189',
    rating: 4.7,
    reviews: 89,
    image: 'https://images.unsplash.com/photo-1763771522867-c26bf75f12bc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmYXNoaW9uJTIwY2xvdGhpbmclMjBhcHBhcmVsfGVufDF8fHx8MTc3MjUwMDYwM3ww&ixlib=rb-4.1.0&q=80&w=1080',
    description: 'Stylish designer jacket perfect for any season. Premium materials and modern cut for a sophisticated look.',
    features: [
      'Premium materials',
      'Modern cut',
      'Multiple pockets',
      'Water-resistant',
      'Machine washable',
    ],
    status: 'Low Stock',
  },
};

export const ItemDetails = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const item = mockItemDetails[id as keyof typeof mockItemDetails];

  if (!item) {
    return (
      <div className="p-6">
        <p>Item not found</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      {/* Image Section */}
      <div className="relative">
        <ImageWithFallback
          src={item.image}
          alt={item.title}
          className="w-full h-80 object-cover"
        />
        <button
          onClick={() => navigate('/items')}
          className="absolute top-6 left-6 w-10 h-10 bg-card/90 backdrop-blur rounded-full flex items-center justify-center"
        >
          <ArrowLeft className="w-5 h-5" />
        </button>
        <div className="absolute top-6 right-6 flex gap-2">
          <button className="w-10 h-10 bg-card/90 backdrop-blur rounded-full flex items-center justify-center">
            <Share2 className="w-5 h-5" />
          </button>
          <button className="w-10 h-10 bg-card/90 backdrop-blur rounded-full flex items-center justify-center">
            <Heart className="w-5 h-5" />
          </button>
        </div>
      </div>

      {/* Content */}
      <div className="p-6 space-y-6">
        {/* Title and Price */}
        <div>
          <div className="flex items-start justify-between mb-2">
            <div className="flex-1">
              <p className="text-sm text-muted-foreground mb-1">{item.category}</p>
              <h1 className="text-2xl mb-2">{item.title}</h1>
            </div>
            <span className={`px-3 py-1 text-sm rounded-full ${
              item.status === 'In Stock'
                ? 'bg-green-50 text-green-600'
                : 'bg-yellow-50 text-yellow-600'
            }`}>
              {item.status}
            </span>
          </div>
          <div className="flex items-center gap-3 mb-3">
            <div className="flex items-center gap-1">
              <Star className="w-5 h-5 fill-yellow-400 text-yellow-400" />
              <span>{item.rating}</span>
            </div>
            <span className="text-muted-foreground">({item.reviews} reviews)</span>
          </div>
          <p className="text-3xl text-primary">{item.price}</p>
        </div>

        {/* Description */}
        <Card>
          <h3 className="mb-2">Description</h3>
          <p className="text-muted-foreground leading-relaxed">{item.description}</p>
        </Card>

        {/* Features */}
        <Card>
          <h3 className="mb-3">Features</h3>
          <ul className="space-y-2">
            {item.features.map((feature, index) => (
              <li key={index} className="flex items-center gap-2 text-muted-foreground">
                <div className="w-1.5 h-1.5 rounded-full bg-primary" />
                {feature}
              </li>
            ))}
          </ul>
        </Card>
      </div>

      {/* Bottom Actions */}
      <div className="fixed bottom-0 left-0 right-0 p-6 bg-card border-t border-border max-w-md mx-auto">
        <div className="flex gap-3">
          <Button
            variant="outline"
            size="lg"
            className="flex-1"
            onClick={() => toast.success('Added to wishlist')}
          >
            <Heart className="w-5 h-5" />
          </Button>
          <Button
            variant="primary"
            size="lg"
            className="flex-1 flex items-center justify-center gap-2"
            onClick={() => toast.success('Added to cart')}
          >
            <ShoppingCart className="w-5 h-5" />
            Add to Cart
          </Button>
        </div>
      </div>
    </div>
  );
};
