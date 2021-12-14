# Simple Shop - Web

Create a web-app using React and Ruby on Rails.  Use Redux if desired.

About the users:

- Users
  - Types
    - Customers - Basic users who can signup and login with email and password.
    - Admins - These users are responsible to manage regions, products.
  - Users can be both customers and admins.

About the store:

- Regions - This application should be flexible to allow creation of stores in different regions. E.g. Thailand, Singapore, etc. each with their own currency setup. Only Admins can manage regions.
  - Fields:
    - title (region name)
    - country
    - currency (USD, SGD, etc)
    - tax (e.g, 10% which can be stored in cents)

- Products - Each region has their own set of products. Products can be anything - tshirt, pants, mugs, watches. Only Admins can manage products.
  - Fields:
    - title
    - description
    - image_url
    - price
    - sku
    - stock (quantity) Note: Customers should not be allowed to order items beyond the available stock number.

- Orders
  - Fields:
    - customer_name
    - shipping_address
    - order_total
    - paid_at
  - Note: An order can contain multiple items.

- Payment - Once the order is made, a payment should be made to confirm the order and make it available for delivery. Create a fake payment gateway and create a task that is triggered 1 minute after order creation that updates the state of the order to either paid or unpaid.


## Requirements

- Seed the database with test data.
- Add screenshots to this repo.  In addition, you may also want to capture videos using Loom.  Please limit the length of the videos to a total of 10 minutes or less.
- Please upload your code to a repository and add emails suhas@morphos.is, peter@morphos.is, and win@morphos.is access to that repo.
