import { createBrowserRouter, Navigate } from "react-router";
import { Root } from "./pages/Root";
import { SignIn } from "./pages/SignIn";
import { SignUp } from "./pages/SignUp";
import { PasswordReset } from "./pages/PasswordReset";
import { OTPVerification } from "./pages/OTPVerification";
import { Dashboard } from "./pages/Dashboard";
import { ItemList } from "./pages/ItemList";
import { ItemDetails } from "./pages/ItemDetails";
import { Search } from "./pages/Search";
import { Profile } from "./pages/Profile";
import { EditProfile } from "./pages/EditProfile";
import { Notifications } from "./pages/Notifications";
import { Settings } from "./pages/Settings";
import { Help } from "./pages/Help";
import { CreateForm } from "./pages/CreateForm";
import { EditForm } from "./pages/EditForm";
import { MapView } from "./pages/MapView";
import { TermsAndConditions } from "./pages/TermsAndConditions";
import { PrivacyPolicy } from "./pages/PrivacyPolicy";
import { NotFound } from "./pages/NotFound";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: Root,
    children: [
      { index: true, element: <Navigate to="/auth/signin" replace /> },
      { path: "auth/signin", Component: SignIn },
      { path: "auth/signup", Component: SignUp },
      { path: "auth/reset-password", Component: PasswordReset },
      { path: "auth/otp", Component: OTPVerification },
      { path: "dashboard", Component: Dashboard },
      { path: "items", Component: ItemList },
      { path: "items/:id", Component: ItemDetails },
      { path: "search", Component: Search },
      { path: "profile", Component: Profile },
      { path: "profile/edit", Component: EditProfile },
      { path: "notifications", Component: Notifications },
      { path: "settings", Component: Settings },
      { path: "help", Component: Help },
      { path: "create", Component: CreateForm },
      { path: "edit/:id", Component: EditForm },
      { path: "map", Component: MapView },
      { path: "terms", Component: TermsAndConditions },
      { path: "privacy", Component: PrivacyPolicy },
      { path: "*", Component: NotFound },
    ],
  },
]);
