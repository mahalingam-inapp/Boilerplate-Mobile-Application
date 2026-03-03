import { useState } from 'react';
import { useParams, useNavigate } from 'react-router';
import { Button } from '../components/Button';
import { Input } from '../components/Input';
import { Card } from '../components/Card';
import { ArrowLeft, Trash2 } from 'lucide-react';
import { toast } from 'sonner';

export const EditForm = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    title: 'Premium Wireless Headphones',
    category: 'Electronics',
    price: '$299',
    description: 'Experience premium audio quality with our state-of-the-art wireless headphones.',
    status: 'In Stock',
  });

  const categories = ['Electronics', 'Furniture', 'Food & Beverage', 'Fashion', 'Other'];
  const statuses = ['In Stock', 'Low Stock', 'Out of Stock'];

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      toast.success('Item updated successfully!');
      navigate(`/items/${id}`);
    } catch (error) {
      toast.error('Failed to update item');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (window.confirm('Are you sure you want to delete this item?')) {
      try {
        await new Promise(resolve => setTimeout(resolve, 1000));
        toast.success('Item deleted successfully');
        navigate('/items');
      } catch (error) {
        toast.error('Failed to delete item');
      }
    }
  };

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <button
            onClick={() => navigate(`/items/${id}`)}
            className="w-10 h-10 flex items-center justify-center"
          >
            <ArrowLeft className="w-6 h-6" />
          </button>
          <div>
            <h1 className="text-2xl">Edit Item</h1>
            <p className="text-muted-foreground">Update item details</p>
          </div>
        </div>
        <button
          onClick={handleDelete}
          className="w-10 h-10 flex items-center justify-center text-destructive"
        >
          <Trash2 className="w-5 h-5" />
        </button>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-4">
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
            onClick={() => navigate(`/items/${id}`)}
          >
            Cancel
          </Button>
          <Button
            type="submit"
            variant="primary"
            className="flex-1"
            disabled={loading}
          >
            {loading ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>
      </form>
    </div>
  );
};
