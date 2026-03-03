import { useState } from 'react';
import { Search as SearchIcon, SlidersHorizontal, X } from 'lucide-react';
import { Card } from '../components/Card';
import { Input } from '../components/Input';
import { Button } from '../components/Button';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { useNavigate } from 'react-router';

const mockSearchResults = [
  {
    id: '1',
    title: 'Premium Wireless Headphones',
    category: 'Electronics',
    price: '$299',
    image: 'https://images.unsplash.com/photo-1636353125878-38f866ee0343?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwcm9kdWN0JTIwdGVjaG5vbG9neSUyMGdhZGdldHxlbnwxfHx8fDE3NzI1NTI0NzJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
  },
  {
    id: '2',
    title: 'Modern Office Chair',
    category: 'Furniture',
    price: '$449',
    image: 'https://images.unsplash.com/photo-1709346739762-e8ecacc96e0a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBmdXJuaXR1cmUlMjBkZXNpZ258ZW58MXx8fHwxNzcyNDc4ODcxfDA&ixlib=rb-4.1.0&q=80&w=1080',
  },
];

export const Search = () => {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState({
    category: 'All',
    priceRange: 'All',
    sortBy: 'relevance',
  });

  const categories = ['All', 'Electronics', 'Furniture', 'Food & Beverage', 'Fashion'];
  const priceRanges = ['All', '$0-$50', '$50-$100', '$100-$300', '$300+'];
  const sortOptions = [
    { value: 'relevance', label: 'Relevance' },
    { value: 'price-low', label: 'Price: Low to High' },
    { value: 'price-high', label: 'Price: High to Low' },
    { value: 'newest', label: 'Newest' },
  ];

  const filteredResults = searchQuery
    ? mockSearchResults.filter(item =>
        item.title.toLowerCase().includes(searchQuery.toLowerCase())
      )
    : [];

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl mb-1">Search</h1>
        <p className="text-muted-foreground">Find what you're looking for</p>
      </div>

      {/* Search Bar */}
      <div className="relative">
        <SearchIcon className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
        <Input
          type="text"
          placeholder="Search items..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="pl-12 pr-12"
        />
        {searchQuery && (
          <button
            onClick={() => setSearchQuery('')}
            className="absolute right-4 top-1/2 -translate-y-1/2"
          >
            <X className="w-5 h-5 text-muted-foreground" />
          </button>
        )}
      </div>

      {/* Filter Toggle */}
      <div className="flex items-center justify-between">
        <p className="text-muted-foreground">
          {filteredResults.length} results
        </p>
        <Button
          variant="outline"
          size="sm"
          onClick={() => setShowFilters(!showFilters)}
          className="flex items-center gap-2"
        >
          <SlidersHorizontal className="w-4 h-4" />
          Filters
        </Button>
      </div>

      {/* Filters Panel */}
      {showFilters && (
        <Card className="space-y-4">
          <div>
            <label className="block mb-2 text-sm">Category</label>
            <div className="flex flex-wrap gap-2">
              {categories.map((category) => (
                <button
                  key={category}
                  onClick={() => setFilters({ ...filters, category })}
                  className={`px-3 py-1.5 text-sm rounded-lg transition-colors ${
                    filters.category === category
                      ? 'bg-primary text-primary-foreground'
                      : 'bg-accent text-accent-foreground'
                  }`}
                >
                  {category}
                </button>
              ))}
            </div>
          </div>

          <div>
            <label className="block mb-2 text-sm">Price Range</label>
            <div className="flex flex-wrap gap-2">
              {priceRanges.map((range) => (
                <button
                  key={range}
                  onClick={() => setFilters({ ...filters, priceRange: range })}
                  className={`px-3 py-1.5 text-sm rounded-lg transition-colors ${
                    filters.priceRange === range
                      ? 'bg-primary text-primary-foreground'
                      : 'bg-accent text-accent-foreground'
                  }`}
                >
                  {range}
                </button>
              ))}
            </div>
          </div>

          <div>
            <label className="block mb-2 text-sm">Sort By</label>
            <select
              value={filters.sortBy}
              onChange={(e) => setFilters({ ...filters, sortBy: e.target.value })}
              className="w-full px-4 py-3 bg-input-background border border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-ring"
            >
              {sortOptions.map((option) => (
                <option key={option.value} value={option.value}>
                  {option.label}
                </option>
              ))}
            </select>
          </div>

          <Button
            variant="outline"
            className="w-full"
            onClick={() => setFilters({ category: 'All', priceRange: 'All', sortBy: 'relevance' })}
          >
            Clear Filters
          </Button>
        </Card>
      )}

      {/* Search Results */}
      {searchQuery ? (
        <div className="space-y-3">
          {filteredResults.length > 0 ? (
            filteredResults.map((item) => (
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
                <div className="flex-1">
                  <p className="text-xs text-muted-foreground">{item.category}</p>
                  <h3 className="line-clamp-1">{item.title}</h3>
                  <p className="text-primary mt-1">{item.price}</p>
                </div>
              </Card>
            ))
          ) : (
            <Card className="text-center py-12">
              <SearchIcon className="w-12 h-12 mx-auto mb-3 text-muted-foreground" />
              <h3 className="mb-1">No results found</h3>
              <p className="text-muted-foreground text-sm">
                Try adjusting your search or filters
              </p>
            </Card>
          )}
        </div>
      ) : (
        <Card className="text-center py-12">
          <SearchIcon className="w-12 h-12 mx-auto mb-3 text-muted-foreground" />
          <h3 className="mb-1">Start searching</h3>
          <p className="text-muted-foreground text-sm">
            Enter a search term to find items
          </p>
        </Card>
      )}
    </div>
  );
};
