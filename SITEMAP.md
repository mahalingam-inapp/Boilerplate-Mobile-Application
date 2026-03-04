# BoilerplateAppFlutterSMA – Sitemap

Quick reference for all screens and how to reach them. Routes require the user to be signed in unless under **Auth**.

---

## Auth (unauthenticated)

| Screen | Route | How to get there |
|--------|--------|-------------------|
| **Sign In** | `/auth/signin` | Initial route when not logged in; "Sign up" link from here |
| **Sign Up** | `/auth/signup` | Link from Sign In |
| **Password Reset** | `/auth/reset-password` | "Forgot password?" on Sign In |
| **OTP Verification** | `/auth/otp` | After submitting phone/email on Sign In (OTP flow) |

---

## Main (bottom nav)

These are the five tabs in the root shell (bottom navigation).

| Screen | Route | Tab |
|--------|--------|-----|
| **Dashboard** | `/dashboard` | Home (first tab) |
| **Search** | `/search` | Search |
| **Notifications** | `/notifications` | Notifications |
| **Profile** | `/profile` | Profile |
| **Settings** | `/settings` | Settings (last tab) |

---

## Profile & account

| Screen | Route | How to get there |
|--------|--------|-------------------|
| **Edit Profile** | `/profile/edit` | Profile screen → "Edit profile" |
| **Addresses** | `/profile/addresses` | Profile → Addresses |
| **Order History** | `/profile/orders` | Profile → Order History |
| **Terms & Conditions** | `/terms` | Settings → Terms; or Sign Up / footer links |
| **Privacy Policy** | `/privacy` | Settings → Privacy; or Sign Up / footer links |

---

## Items & forms

| Screen | Route | How to get there |
|--------|--------|-------------------|
| **Item List** | `/items` | Dashboard or navigation to "Items" |
| **Item Details** | `/items/:id` | Item List → tap an item (e.g. `/items/1`) |
| **Create Form** | `/create` | Dashboard or menu → "Create" |
| **Edit Form** | `/edit/:id` | Item Details → Edit (e.g. `/edit/1`) |

---

## Other

| Screen | Route | How to get there |
|--------|--------|-------------------|
| **Notification Detail** | `/notifications/:id` | Notifications → tap a notification card |
| **Order History** | `/orders` | Dashboard → Quick Actions → View Orders; or Profile → Order History |
| **Order Detail** | `/orders/:id` | Order History → tap an order |
| **Analytics** | `/analytics` | Dashboard → Quick Actions → Analytics |
| **Add User** | `/users/add` | Dashboard → Quick Actions → Add User |
| **Help Center** | `/help` | Settings → Help Center |
| **Language** | `/settings/language` | Settings → Language |
| **About** | `/settings/about` | Settings → About |
| **Nearby locations (map)** | `/map` | Dashboard → Quick Actions → Find nearby. Purpose: find offices/sites near you and get directions. |
| **Not Found (404)** | `/404` or any unknown path | Any unmatched route |

---

## Route list (copy-paste)

```
/auth/signin
/auth/signup
/auth/reset-password
/auth/otp
/dashboard
/search
/notifications
/notifications/:id
/orders
/orders/:id
/analytics
/users/add
/help
/settings/language
/settings/about
/profile
/profile/edit
/profile/addresses
/profile/orders
/settings
/items
/items/:id
/create
/edit/:id
/map
/terms
/privacy
/404
```

---

## File → screen

| File | Screen |
|------|--------|
| `lib/screens/auth/sign_in_screen.dart` | Sign In |
| `lib/screens/auth/sign_up_screen.dart` | Sign Up |
| `lib/screens/auth/password_reset_screen.dart` | Password Reset |
| `lib/screens/auth/otp_verification_screen.dart` | OTP Verification |
| `lib/screens/root_screen.dart` | Root (shell with bottom nav) |
| `lib/screens/dashboard_screen.dart` | Dashboard |
| `lib/screens/search_screen.dart` | Search |
| `lib/screens/notifications_screen.dart` | Notifications |
| `lib/screens/notification_detail_screen.dart` | Notification Detail |
| `lib/screens/order_history_screen.dart` | Order History |
| `lib/screens/order_detail_screen.dart` | Order Detail |
| `lib/screens/addresses_screen.dart` | Addresses |
| `lib/screens/language_screen.dart` | Language |
| `lib/screens/about_screen.dart` | About |
| `lib/screens/analytics_screen.dart` | Analytics |
| `lib/screens/add_user_screen.dart` | Add User |
| `lib/screens/profile_screen.dart` | Profile |
| `lib/screens/edit_profile_screen.dart` | Edit Profile |
| `lib/screens/settings_screen.dart` | Settings |
| `lib/screens/help_screen.dart` | Help |
| `lib/screens/item_list_screen.dart` | Item List |
| `lib/screens/item_details_screen.dart` | Item Details |
| `lib/screens/create_form_screen.dart` | Create Form |
| `lib/screens/edit_form_screen.dart` | Edit Form |
| `lib/screens/map_view_screen.dart` | Map View |
| `lib/screens/terms_screen.dart` | Terms & Conditions |
| `lib/screens/privacy_screen.dart` | Privacy Policy |
| `lib/screens/not_found_screen.dart` | Not Found |

Routing is defined in `lib/app_router.dart`.
