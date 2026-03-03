import { useNavigate } from 'react-router';
import { ArrowLeft } from 'lucide-react';
import { Card } from '../components/Card';

export const TermsAndConditions = () => {
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
          <h1 className="text-2xl">Terms & Conditions</h1>
          <p className="text-muted-foreground">Last updated: March 3, 2026</p>
        </div>
      </div>

      <Card className="space-y-6">
        <section>
          <h3 className="mb-3">1. Introduction</h3>
          <p className="text-muted-foreground leading-relaxed">
            Welcome to our whitelabel mobile application. By accessing or using our app, you agree to be bound by these Terms and Conditions. Please read them carefully.
          </p>
        </section>

        <section>
          <h3 className="mb-3">2. Use License</h3>
          <p className="text-muted-foreground leading-relaxed">
            Permission is granted to temporarily access and use the app for personal, non-commercial purposes. This is the grant of a license, not a transfer of title, and under this license you may not:
          </p>
          <ul className="list-disc list-inside text-muted-foreground mt-2 space-y-1 ml-4">
            <li>Modify or copy the materials</li>
            <li>Use the materials for any commercial purpose</li>
            <li>Attempt to decompile or reverse engineer any software</li>
            <li>Remove any copyright or proprietary notations</li>
          </ul>
        </section>

        <section>
          <h3 className="mb-3">3. User Accounts</h3>
          <p className="text-muted-foreground leading-relaxed">
            You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.
          </p>
        </section>

        <section>
          <h3 className="mb-3">4. Content</h3>
          <p className="text-muted-foreground leading-relaxed">
            Users are solely responsible for any content they submit, post, or display. We reserve the right to remove any content that violates these terms or is otherwise objectionable.
          </p>
        </section>

        <section>
          <h3 className="mb-3">5. Disclaimer</h3>
          <p className="text-muted-foreground leading-relaxed">
            The materials on our app are provided on an 'as is' basis. We make no warranties, expressed or implied, and hereby disclaim all other warranties including implied warranties or conditions of merchantability and fitness for a particular purpose.
          </p>
        </section>

        <section>
          <h3 className="mb-3">6. Limitations</h3>
          <p className="text-muted-foreground leading-relaxed">
            In no event shall we or our suppliers be liable for any damages (including, without limitation, damages for loss of data or profit) arising out of the use or inability to use our app.
          </p>
        </section>

        <section>
          <h3 className="mb-3">7. Modifications</h3>
          <p className="text-muted-foreground leading-relaxed">
            We may revise these terms at any time without notice. By using this app, you are agreeing to be bound by the then-current version of these Terms and Conditions.
          </p>
        </section>

        <section>
          <h3 className="mb-3">8. Contact Information</h3>
          <p className="text-muted-foreground leading-relaxed">
            If you have any questions about these Terms, please contact us at legal@example.com
          </p>
        </section>
      </Card>
    </div>
  );
};
