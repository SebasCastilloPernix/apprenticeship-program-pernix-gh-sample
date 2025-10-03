# Original code

``` Ruby

class Order
  def initialize(items)
    @items = items
  end

  def calculate_total
    total = 0
    @items.each do |item|
      total += item.price
    end
    total
  end

  def send_confirmation_email
    # Lógica para enviar un correo electrónico de confirmación
    puts "Email enviado a customer@example.com"
  end

  def print_order
    @items.each do |item|
      puts "Item: #{item.name} - Price: #{item.price}"
    end
  end
end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

```

## Refactor code with SOLID

``` Ruby

class Order
    def initialize(items)
        @items = items
    end

    def calculate_total(strategy)
        strategy.calculate_total(@items)
    end
end

# Open/Closed Principle
class NormalPrice
    def calculate_total(items)
        items.sum { |item| item.price }
    end
end

# Open/Closed Principle
class DiscountApplier
    def initialize(discount)
        @discount = discount
    end

    def apply(items)
        total = items.sum { |item| item.price }
        total - (total * @discount)    
    end
end

# Dependecy Inversion Principle (DIP)
class EmailSender
    def send_confirmation(email)
        # Lógica para enviar un correo electrónico de confirmación
        puts "Email enviado a #{email}"
    end
end

# Single Responsability Principle(SRP)
class OrderPrint
    def print(order)
        order.items.each do |item|
            puts "Item: #{item.name} - Price: #{item.price}"
        end
    end
end

# No requiere modificaciones
class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

```
