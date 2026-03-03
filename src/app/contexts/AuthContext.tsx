import React, { createContext, useContext, useState, useEffect } from 'react';

interface User {
  id: string;
  email: string;
  phone?: string;
  name: string;
  avatar?: string;
}

interface AuthContextType {
  user: User | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signInWithOTP: (phoneOrEmail: string, otp: string) => Promise<void>;
  signUp: (email: string, password: string, name: string) => Promise<void>;
  signOut: () => void;
  resetPassword: (email: string) => Promise<void>;
  updateProfile: (data: Partial<User>) => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  // Check for existing session on mount
  useEffect(() => {
    const checkSession = () => {
      const storedUser = localStorage.getItem('user');
      const token = localStorage.getItem('token');
      const tokenExpiry = localStorage.getItem('tokenExpiry');

      if (storedUser && token && tokenExpiry) {
        const expiryDate = new Date(tokenExpiry);
        if (expiryDate > new Date()) {
          setUser(JSON.parse(storedUser));
        } else {
          // Token expired
          localStorage.removeItem('user');
          localStorage.removeItem('token');
          localStorage.removeItem('tokenExpiry');
        }
      }
      setLoading(false);
    };

    checkSession();

    // Simulate token refresh every 10 minutes
    const refreshInterval = setInterval(() => {
      const token = localStorage.getItem('token');
      if (token) {
        const newExpiry = new Date(Date.now() + 60 * 60 * 1000); // 1 hour from now
        localStorage.setItem('tokenExpiry', newExpiry.toISOString());
      }
    }, 10 * 60 * 1000);

    return () => clearInterval(refreshInterval);
  }, []);

  const signIn = async (email: string, password: string) => {
    // Mock authentication
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    const mockUser: User = {
      id: '1',
      email,
      name: email.split('@')[0],
      avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${email}`,
    };

    const token = 'mock-jwt-token-' + Date.now();
    const expiry = new Date(Date.now() + 60 * 60 * 1000); // 1 hour from now

    localStorage.setItem('user', JSON.stringify(mockUser));
    localStorage.setItem('token', token);
    localStorage.setItem('tokenExpiry', expiry.toISOString());

    setUser(mockUser);
  };

  const signInWithOTP = async (phoneOrEmail: string, otp: string) => {
    // Mock OTP authentication
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    const mockUser: User = {
      id: '1',
      email: phoneOrEmail.includes('@') ? phoneOrEmail : undefined,
      phone: !phoneOrEmail.includes('@') ? phoneOrEmail : undefined,
      name: phoneOrEmail.split('@')[0] || 'User',
      avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${phoneOrEmail}`,
    };

    const token = 'mock-jwt-token-' + Date.now();
    const expiry = new Date(Date.now() + 60 * 60 * 1000);

    localStorage.setItem('user', JSON.stringify(mockUser));
    localStorage.setItem('token', token);
    localStorage.setItem('tokenExpiry', expiry.toISOString());

    setUser(mockUser);
  };

  const signUp = async (email: string, password: string, name: string) => {
    // Mock sign up
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    const mockUser: User = {
      id: Date.now().toString(),
      email,
      name,
      avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${email}`,
    };

    const token = 'mock-jwt-token-' + Date.now();
    const expiry = new Date(Date.now() + 60 * 60 * 1000);

    localStorage.setItem('user', JSON.stringify(mockUser));
    localStorage.setItem('token', token);
    localStorage.setItem('tokenExpiry', expiry.toISOString());

    setUser(mockUser);
  };

  const signOut = () => {
    localStorage.removeItem('user');
    localStorage.removeItem('token');
    localStorage.removeItem('tokenExpiry');
    setUser(null);
  };

  const resetPassword = async (email: string) => {
    // Mock password reset
    await new Promise(resolve => setTimeout(resolve, 1000));
  };

  const updateProfile = async (data: Partial<User>) => {
    if (!user) return;
    
    const updatedUser = { ...user, ...data };
    localStorage.setItem('user', JSON.stringify(updatedUser));
    setUser(updatedUser);
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        loading,
        signIn,
        signInWithOTP,
        signUp,
        signOut,
        resetPassword,
        updateProfile,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};
