import { useNavigate } from 'react-router';
import { ArrowLeft } from 'lucide-react';
import { Card } from '../components/Card';

export const PrivacyPolicy = () => {
  const navigate = useNavigate();

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <button
          onClick={() => navigate('/settings')}
          className="w-10 h-10 flex items-center justify-center"
        >
          <ArrowLeft className="w-6 h-6" />
        </button>
        <div>
          <h1 className="text-2xl">Privacy Policy</h1>
          <p className="text-muted-foreground">Last updated: March 3, 2026</p>
        </div>
      </div>

      <Card className="space-y-6">
        <section>
          <h3 className="mb-3">1. Information We Collect</h3>
          <p className="text-muted-foreground leading-relaxed mb-3">
            We collect information that you provide directly to us, including:
          </p>
          <ul className="list-disc list-inside text-muted-foreground space-y-1 ml-4">
            <li>Name and contact information</li>
            <li>Account credentials</li>
            <li>Profile information</li>
            <li>Transaction and payment information</li>
            <li>Communications with us</li>
          </ul>
        </section>

        <section>
          <h3 className="mb-3">2. How We Use Your Information</h3>
          <p className="text-muted-foreground leading-relaxed mb-3">
            We use the information we collect to:
          </p>
          <ul className="list-disc list-inside text-muted-foreground space-y-1 ml-4">
            <li>Provide, maintain, and improve our services</li>
            <li>Process transactions and send related information</li>
            <li>Send you technical notices and support messages</li>
            <li>Respond to your comments and questions</li>
            <li>Monitor and analyze trends and usage</li>
          </ul>
        </section>

        <section>
          <h3 className="mb-3">3. Information Sharing</h3>
          <p className="text-muted-foreground leading-relaxed">
            We do not share your personal information with third parties except as described in this policy. We may share information with service providers who perform services on our behalf, with your consent, or as required by law.
          </p>
        </section>

        <section>
          <h3 className="mb-3">4. Data Security</h3>
          <p className="text-muted-foreground leading-relaxed">
            We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.
          </p>
        </section>

        <section>
          <h3 className="mb-3">5. Your Rights</h3>
          <p className="text-muted-foreground leading-relaxed mb-3">
            You have the right to:
          </p>
          <ul className="list-disc list-inside text-muted-foreground space-y-1 ml-4">
            <li>Access and receive a copy of your personal data</li>
            <li>Correct inaccurate or incomplete data</li>
            <li>Request deletion of your data</li>
            <li>Object to or restrict processing of your data</li>
            <li>Withdraw consent at any time</li>
          </ul>
        </section>

        <section>
          <h3 className="mb-3">6. Cookies and Tracking</h3>
          <p className="text-muted-foreground leading-relaxed">
            We use cookies and similar tracking technologies to track activity on our app and hold certain information. You can instruct your device to refuse all cookies or to indicate when a cookie is being sent.
          </p>
        </section>

        <section>
          <h3 className="mb-3">7. Children's Privacy</h3>
          <p className="text-muted-foreground leading-relaxed">
            Our app is not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13.
          </p>
        </section>

        <section>
          <h3 className="mb-3">8. Changes to This Policy</h3>
          <p className="text-muted-foreground leading-relaxed">
            We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.
          </p>
        </section>

        <section>
          <h3 className="mb-3">9. Contact Us</h3>
          <p className="text-muted-foreground leading-relaxed">
            If you have any questions about this Privacy Policy, please contact us at privacy@example.com
          </p>
        </section>
      </Card>
    </div>
  );
};
