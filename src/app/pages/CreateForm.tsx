import { useState } from 'react';
import { useNavigate } from 'react-router';
import { Button } from '../components/Button';
import { Input } from '../components/Input';
import { Card } from '../components/Card';
import { ArrowLeft, Upload } from 'lucide-react';
import { toast } from 'sonner';

export const CreateForm = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    title: '',
    category: 'Electronics',
    price: '',
    description: '',
    status: 'In Stock',
  });

  const categories = ['Electronics', 'Furniture', 'Food & Beverage', 'Fashion', 'Other'];
  const statuses = ['In Stock', 'Low Stock', 'Out of Stock'];

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      toast.success('Item created successfully!');
      navigate('/items');
    } catch (error) {
      toast.error('Failed to create item');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <button
          onClick={() => navigate('/items')}
          className="w-10 h-10 flex items-center justify-center"
        >
          <ArrowLeft className="w-6 h-6" />
        </button>
        <div>
          <h1 className="text-2xl">Create Item</h1>
          <p className="text-muted-foreground">Add a new item</p>
        </div>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Image Upload */}
        <Card>
          <label className="flex flex-col items-center justify-center py-12 cursor-pointer">
            <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mb-3">
              <Upload className="w-8 h-8 text-primary" />
            </div>
            <p className="text-sm mb-1">Upload Images</p>
            <p className="text-xs text-muted-foreground">PNG, JPG up to 5MB</p>
            <input
              type="file"
              accept="image/*"
              multiple
              className="hidden"
            />
          </label>
        </Card>

        {/* Basic Information */}
        <Input
          label="Title"
          type="text"
          value={formData.title}
          onChange={(e) => setFormData({ ...formData, title: e.target.value })}
          placeholder="Enter item title"
          required
        />

        <div>
          <label className="block mb-2 text-sm">Category</label>
          <select
            value={formData.category}
            onChange={(e) => setFormData({ ...formData, category: e.target.value })}
            className="w-full px-4 py-3 bg-input-background border border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent"
            required
          >
            {categories.map((category) => (
              <option key={category} value={category}>
                {category}
              </option>
            ))}
          </select>
        </div>

        <Input
          label="Price"
          type="text"
          value={formData.price}
          onChange={(e) => setFormData({ ...formData, price: e.target.value })}
          placeholder="$0.00"
          required
        />

        <div>
          <label className="block mb-2 text-sm">Description</label>
          <textarea
            value={formData.description}
            onChange={(e) => setFormData({ ...formData, description: e.target.value })}
            className="w-full px-4 py-3 bg-input-background border border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent resize-none"
            rows={5}
            placeholder="Describe your item..."
            required
          />
        </div>

        <div>
          <label className="block mb-2 text-sm">Status</label>
          <select
            value={formData.status}
            onChange={(e) => setFormData({ ...formData, status: e.target.value })}
            className="w-full px-4 py-3 bg-input-background border border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent"
            required
          >
            {statuses.map((status) => (
              <option key={status} value={status}>
                {status}
              </option>
            ))}
          </select>
        </div>

        {/* Actions */}
        <div className="flex gap-3 pt-4">
          <Button
            type="button"
            variant="outline"
            className="flex-1"
            onClick={() => navigate('/items')}
          >
            Cancel
          </Button>
          <Button
            type="submit"
            variant="primary"
            className="flex-1"
            disabled={loading}
          >
            {loading ? 'Creating...' : 'Create Item'}
          </Button>
        </div>
      </form>
    </div>
  );
};
