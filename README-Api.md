# Simple Shop - API

Create an api server for an ecommerce application.

About the users:

- Users
  - Types
    - Customers - Basic users who can signup and login with email and password.
    - Admins - These users are responsible to manage regions, products.
  - Users can be both customers and admins.
  - Note: Generate users via seed.

About the store:

- Regions - This application should be flexible to allow creation of stores in different regions. E.g. Thailand, Singapore, etc. each with their own currency setup. Only Admins can manage regions.
  - Fields:
    - title (region name)
    - country
    - currency (USD, SGD, etc)
    - tax (e.g, 10% which can be stored in cents)
  - Note: Generate regions via seed.

- Products - Each region has their own set of products. Products can be anything - tshirt, pants, mugs, watches. Only Admins can manage products.
  - Fields:
    - title
    - description
    - image_url
    - price
    - sku
    - stock (quantity)
      - Note: Customers should not be allowed to order items beyond the available stock number.
  - Note: Generate products via seed.

- Orders
  - Fields:
    - customer_name
    - shipping_address
    - order_total
    - paid_at
  - An order can contain multiple items.
  - Note: Create CRUD for orders.

- Payment - Once the order is made, a payment should be made. Create a fake payment gateway and create a task that is triggered 1 minute after order creation that updates the state of the order to either paid or unpaid.


## Requirements

- Implement JWT authentication for sign_in steps
- Rspec tests
- Update this README to include a list of API endpoints
- Please upload your code to a repository and add emails suhas@morphos.is, peter@morphos.is, and win@morphos.is access to that repo.


## Routes
### Users
- POST        users/login - Login with username and password supplied via parameters. (db/seeds.rb for creds)
- GET         users/me    - Verfies token and provies user information as JSON

### Orders
- POST        orders      - Create new order ( only customers can create order )
- GET         orders      - List orders by current user
- GET         orders/:id  - Get order with :id
- DELETE      orders/:id  - Delete order with :id
- PUT/PATCH   orders/:id  - Update order with :id

## Tests
- spec/models
- spec/requests