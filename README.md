# VShipping

VShipping is a Ruby library for integrating VietNamese shipping document.

## Installation

Install the latest release:

```bash
gem install v_shipping
```
In Rails, add it to your Gemfile:

```bash
gem 'v_shipping', '~> 0.0.1'
```

Finally, restart the server to apply the changes.

## Getting Started


```
require 'v_shipping'

class ShippingService
  include VShipping

  class << self
    def ahamove_token
      status, body = ahamove.retrieved_token
    end
  end
end
```

Using via class method:

```
include VShipping

status, body = self.class.ahamove.retrieved_token
```

### Configuring VShipping

VShipping has a broad range of configuration options, which you can configure, both globally and on a per-uploader basis:

```
VShipping.configure do |config|
  config.ahamove_api_key =  ENV['AHAMOVE_API_KEY']
  config.ahamove_config_path = Rails.root.join('config', 'ahamove-config.yaml')
end

```
If you're using Rails, create an initializer for this:
```
config/initializers/v_shipping.rb
```
### Using Ahamove
Create ahamove config path then copy to configuration, please using [Ahamove document](https://developers.ahamove.com):

```
# config/ahamove-config.yaml

base_api_url: # Base api url
register_endpoint: # Endpoint for register to retrieved token
create_order_endpoint: # Create new order endpoint
orders_endpoint: # List order endpoint
order_endpoint: # Order detail endpoint
city_endpoint: # City detail endpoint
services_endpoint: # List services endpoint
order_tracking_endpoint: # Order tracking share endpoint
notify_order_endpoint: # Notify to supplier endpoint
```
Ahamove Feature
| Feature                         |  Method                   |
|---------------------------------|---------------------------|
|  Retrieved Token                |  retrieved_token          |
|  Create new Order               |  create_order             |
|  Get list orders                |  retrieved_orders         |
|  Get detail order               |  retrieved_order          |
|  Get detail city                |  retrieved_city           |
|  Get list services              |  retrieved_services       |
|  Get share tracking order link  |  retrieved_tracking_link  |
|  Notify to supplier             |  notify_supplier          |

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)