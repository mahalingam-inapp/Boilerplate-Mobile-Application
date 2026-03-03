import { useState } from 'react';
import { Card } from '../components/Card';
import { Input } from '../components/Input';
import { Button } from '../components/Button';
import { ChevronDown, ChevronUp, Mail, MessageSquare, Phone } from 'lucide-react';
import { toast } from 'sonner';

interface FAQ {
  id: string;
  question: string;
  answer: string;
}

const faqs: FAQ[] = [
  {
    id: '1',
    question: 'How do I create an account?',
    answer: 'You can create an account by clicking the "Sign Up" button on the home screen and filling in your details. You can use either email or phone number to register.',
  },
  {
    id: '2',
    question: 'How do I reset my password?',
    answer: 'Click on "Forgot Password" on the sign-in screen, enter your email address, and we\'ll send you a reset link.',
  },
  {
    id: '3',
    question: 'How do I track my order?',
    answer: 'Go to your Profile > Order History to see all your orders. Click on any order to view detailed tracking information.',
  },
  {
    id: '4',
    question: 'What payment methods do you accept?',
    answer: 'We accept all major credit cards, debit cards, and digital wallets. Payment processing is secure and encrypted.',
  },
  {
    id: '5',
    question: 'How can I contact customer support?',
    answer: 'You can reach us through the contact form below, send an email to support@example.com, or call our hotline at +1 (555) 123-4567.',
  },
  {
    id: '6',
    question: 'What is your refund policy?',
    answer: 'We offer a 30-day money-back guarantee on all products. If you\'re not satisfied, contact our support team for a full refund.',
  },
];

export const Help = () => {
  const [expandedFaq, setExpandedFaq] = useState<string | null>(null);
  const [contactForm, setContactForm] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
  });
  const [loading, setLoading] = useState(false);

  const toggleFaq = (id: string) => {
    setExpandedFaq(expandedFaq === id ? null : id);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await new Promise(resolve => setTimeout(resolve, 1000));
      toast.success('Message sent! We\'ll get back to you soon.');
      setContactForm({ name: '', email: '', subject: '', message: '' });
    } catch (error) {
      toast.error('Failed to send message');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl mb-1">Help & Support</h1>
        <p className="text-muted-foreground">We're here to help you</p>
      </div>

      {/* Quick Contact Options */}
      <div className="grid grid-cols-3 gap-3">
        <Card className="text-center p-4">
          <div className="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-2">
            <Phone className="w-6 h-6 text-primary" />
          </div>
          <p className="text-xs text-muted-foreground">Call Us</p>
        </Card>
        <Card className="text-center p-4">
          <div className="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-2">
            <Mail className="w-6 h-6 text-primary" />
          </div>
          <p className="text-xs text-muted-foreground">Email</p>
        </Card>
        <Card className="text-center p-4">
          <div className="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-2">
            <MessageSquare className="w-6 h-6 text-primary" />
          </div>
          <p className="text-xs text-muted-foreground">Chat</p>
        </Card>
      </div>

      {/* FAQ Section */}
      <div>
        <h2 className="text-xl mb-4">Frequently Asked Questions</h2>
        <div className="space-y-3">
          {faqs.map((faq) => (
            <Card key={faq.id} className="overflow-hidden">
              <button
                onClick={() => toggleFaq(faq.id)}
                className="w-full flex items-start justify-between gap-3 text-left"
              >
                <h3 className="flex-1">{faq.question}</h3>
                {expandedFaq === faq.id ? (
                  <ChevronUp className="w-5 h-5 text-muted-foreground flex-shrink-0" />
                ) : (
                  <ChevronDown className="w-5 h-5 text-muted-foreground flex-shrink-0" />
                )}
              </button>
              {expandedFaq === faq.id && (
                <p className="text-muted-foreground mt-3 leading-relaxed">
                  {faq.answer}
                </p>
              )}
            </Card>
          ))}
        </div>
      </div>

      {/* Contact Form */}
      <div>
        <h2 className="text-xl mb-4">Contact Support</h2>
        <Card>
          <form onSubmit={handleSubmit} className="space-y-4">
            <Input
              label="Name"
              type="text"
              value={contactForm.name}
              onChange={(e) => setContactForm({ ...contactForm, name: e.target.value })}
              required
            />
            <Input
              label="Email"
              type="email"
              value={contactForm.email}
              onChange={(e) => setContactForm({ ...contactForm, email: e.target.value })}
              required
            />
            <Input
              label="Subject"
              type="text"
              value={contactForm.subject}
              onChange={(e) => setContactForm({ ...contactForm, subject: e.target.value })}
              required
            />
            <div>
              <label className="block mb-2 text-sm">Message</label>
              <textarea
                value={contactForm.message}
                onChange={(e) => setContactForm({ ...contactForm, message: e.target.value })}
                className="w-full px-4 py-3 bg-input-background border border-border rounded-xl focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all resize-none"
                rows={5}
                placeholder="Describe your issue..."
                required
              />
            </div>
            <Button type="submit" variant="primary" className="w-full" disabled={loading}>
              {loading ? 'Sending...' : 'Send Message'}
            </Button>
          </form>
        </Card>
      </div>
    </div>
  );
};
