## :📱 Tujijenge Database README

**Tujijenge** is a digital platform that supports Mama Mbogas (small-scale vegetable vendors) by helping them connect with suppliers, get certified training, and manage their inventory better.

### :📁 Tables Overview

#### 1. `user`

* Stores basic info about users (MamaMboga, GAIN, or Taimba).
* Includes `username`, `user_type`, `phone_number`, `email`, and `location`.
* Rules:

  * MamaMboga must have a phone number, no email.
  * GAIN and Taimba must have an email, no phone number.

#### 2. `user_account`

* Holds profile details for each user.
* Includes `profile_image`, `certified`, `is_active`, and `reactivation_window`.

#### 3. `product`

* Stores product names, categories, and units (e.g., “kg”, “piece”).

#### 4. `product_details`

* Contains price, amount, image URL, stock status, and when it was last updated.

#### 5. `notifications`

* Sends alerts like order updates or training reminders.
* Each has a `message`, `notification_type`, `is_read`, and `sent_at`.

#### 6. `notification_status`

* Tracks if a notification is read or not (can be expanded for multi-users per alert).

#### 7. `communities`

* For organizing Mama Mbogas into location-based or topic-based groups (e.g., "Nairobi Sellers").

---

### :⚙️ Notes

* Locations are stored using **PostGIS** (geography type).
* All IDs are short `VARCHAR(15)` strings.
* Important checks are in place to make sure each user type has the right contact info.

---

### :📢 How to Add Icons in README Without Copy-Paste

If you’re using **Markdown** on platforms like GitHub, you can use emoji shortcodes like this:

