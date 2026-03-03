import { useNavigate } from 'react-router';
import { Button } from '../components/Button';
import { Home } from 'lucide-react';

export const NotFound = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen flex items-center justify-center p-6 bg-gradient-to-b from-background to-muted/30">
      <div className="text-center space-y-6 max-w-md">
        <div className="text-8xl">404</div>
        <div>
          <h1 className="text-2xl mb-2">Page Not Found</h1>
          <p className="text-muted-foreground">
            The page you're looking for doesn't exist or has been moved.
          </p>
        </div>
        <Button
          variant="primary"
          onClick={() => navigate('/dashboard')}
          className="flex items-center justify-center gap-2 mx-auto"
        >
          <Home className="w-5 h-5" />
          Back to Home
        </Button>
      </div>
    </div>
  );
};
