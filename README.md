# RailsEngine

RailsEngine implements a versioned JSON API including a set of business intelligence queries based on a suite of CSV files providing a volume of fictitious data for an e-commerce platform. This implementation includes the required files to deploy the application using Docker.

### Dependencies

- Ruby 2.4
- Rails 5.2.3
- PostgreSQL

### Getting Started

``` bash
gem install bundler
bundle install
rails db:{create,migrate}
rake import:generic
```

`bundler` is used to automate dependency requirements for the project

`rails db:{create,migrate}` creates the database and runs the migrations to generate the tables

`rake import:generic` is a rake task used to populate the database with the information within the provided CSV files located in `/data`

###### Starting the Application

To start the application run the following:

```bash
rails s
```

By default, the application listens on port `3000`

###### Stopping the Application

To stop the application when running, press `ctrl + c` to stop the server.

###### Running the Test Suite

The application, includes a testing suite built using RSpec. In order to run the test suite, use the command `bundle exec rspec`

### Using the Application

The application provides a uniform collection of API endpoints for all records included in the application. The included record types are:

- Customers
- Merchants
- Items
- Invoices
- Invoice_Items
- Transactions

##### All Records

For each of the record types listed above, the application provides a set of endpoints for retrieving all records. This can be accessed from URLs matching the following pattern:

```
localhost:3000/api/v1/resources
```

Where `resources` is the record type requested.

##### Single Records

For each of the record types, the application also implements an endpoint to retrieve a single record based on the ID of the record. This can be accessed from URLs matching the following pattern:
```
localhost:3000/api/v1/resources/id
```

Where `id` represents the unique ID for a specific resource.

Additionally, the application can return a `random` record from a resource type. This functionality can be accessed from URLs matching the following pattern:

```
localhost:3000/api/v1/resources/random
```

##### Finding Records

The application can find single records based on the information present in the resource. When using this functionality, the application will return the first record found matching the search terms. This functionality can be accessed at URLs matching the following pattern:
```
localhost:3000/api/v1/resources/find?field=value
```

Additionally, the application can find all records for a provided criteria. This functionality can be accessed at URLs matching the following pattern:


```
localhost:3000/api/v1/resources/find_all?field=value
```

The available fields vary for each resource type. A comprehensive list of search fields can be found below, and all matches are `case insensitive`:

Customers:
- id
- first_name
- last_name
- created_at
- updated_at

Merchants:
- id
- name
- created_at
- updated_at

Items:
- id
- name
- description
- unit_price
- merchant_id
- created_at
- updated_at

Invoices:
- id
- customer_id
- merchant_id
- status
- created_at
- updated_at

Transactions:
- id
- credit_card_number
- credit_card_expiration_date
- result
- created_at
- updated_at

Invoice_items:
- id
- item_id
- invoice_id
- unit_price
- quantity
- created_at
- updated_at

##### Resource Relationships

The application also provides a series of endpoints to return the related resources for a given resource. All relationship endpoints can be accessed at URLs matching the following pattern:

```
localhost:3000/api/v1/resources/id/related_resource
```

The available relationships can be found below:

Customers:
- Invoices
- Transactions

Merchants:
- Items
- Invoices

Items:
- Invoice_items
- Merchant

Invoices:
- Transactions
- Invoice_items
- Items
- Customer
- Merchant

Transactions:
- Invoice

Invoice_items:
- Invoice
- Item



