# Code smells

## Original code

``` java
    public class User {
        private String name;
        private String address;
        private String phone;
        private String email;
        private int loyaltyPoints;
        private double accountBalance;
        private List<String> orders;
        private List<String> coupons;

        // Method to update user information
        public void updateInfo(String name, String address, String phone, String email) {
            this.name = name;
            this.address = address;
            this.phone = phone;
            this.email = email;
        }

        // Method to calculate discount based on loyalty points
        public double calculateDiscount(int loyaltyPoints, double accountBalance) {
            double discount = 0.0;
            if (loyaltyPoints > 100) {
                discount = accountBalance * 0.1;
            } else if (loyaltyPoints > 200) {
                discount = accountBalance * 0.2;
            } else {
                discount = accountBalance * 0.05;
            }
            return discount;
        }

        // Method to print all orders
        public void printOrders() {
            for (String order : orders) {
                System.out.println("Order: " + order);
            }
        }

        // Method to apply coupons
        public void applyCoupons(List<String> coupons) {
            for (String coupon : coupons) {
                System.out.println("Applying coupon: " + coupon);
            }
        }

        // Deprecated method
        public void deprecatedMethod() {
            // This method is no longer used
        }
    }
```

## Problems with the codes

### Clase grande

La clase user es muy grande, se puede modularizar para hacerla más limpia y fácil de mantener.

### Código duplicado

Este código es duplicado ya que ambos iteran sobre una lista e imprimen en la consola, ambas podrian ser clases aparte.

``` java
      // Method to print all orders
        public void printOrders() {
            for (String order : orders) {
                System.out.println("Order: " + order);
            }
        }

        // Method to apply coupons
        public void applyCoupons(List<String> coupons) {
            for (String coupon : coupons) {
                System.out.println("Applying coupon: " + coupon);
            }
        }
```

### Lista larga de parámetros

Este método recibe una lista larga de parámetros, estos se podrían enviar para otra clase como "userInfo", haciendo la lectura del código más sencilla.

``` java
        // Method to update user information
        public void updateInfo(String name, String address, String phone, String email) {
            this.name = name;
            this.address = address;
            this.phone = phone;
            this.email = email;
        }
```
### Código muerto

Este código se debe de eliminar ya que dice que no se va a usar más. Agrega complejidad.

``` java
        // Deprecated method
        public void deprecatedMethod() {
            // This method is no longer used
        }
```

### Problema de lógica

Acá por ejemplo nunca se va a aplicar el descuento si tiene más de 200 puntos, siempre en ese caso se aplicaría el primer if. A parte que no hace falta enviar estos por parámetro si están dentro de la misma clase.

``` java
        // Method to calculate discount based on loyalty points
        public double calculateDiscount(int loyaltyPoints, double accountBalance) {
            double discount = 0.0;
            if (loyaltyPoints > 100) {
                discount = accountBalance * 0.1;
            } else if (loyaltyPoints > 200) {
                discount = accountBalance * 0.2;
            } else {
                discount = accountBalance * 0.05;
            }
            return discount;
        }
```

### Comentarios

Muchos métodos de esta clase contienen comentarios innecesarios si no es que todos los métodos los tienen, porque ya los métodos tienen nombres significativos.

### Obsesión por los primitivos

Las direcciones, direcciones de correo y email si tienen validaciones pueden convertirse en algo difícil de mantener debido a que le pueden agregar más complejidad a esta clase.

``` java
        private String address;
        private String phone;
        private String email;
```

## Refactor

``` java

public class User {
    private UserInfo user;
    private int loyaltyPoints;
    private double accountBalance;
    private Item orders;
    private Item coupons;

    public User(UserInfo user, int loyaltyPoints, Item orders, Item coupons, double accountBalance) {
        this.user = user;
        this.loyaltyPoints = loyaltyPoints;
        this.accountBalance = accountBalance;
        this.orders = orders;
        this.coupons = coupons;
    }
    
    public double calculateDiscount() {
        if (loyaltyPoints > 200) {
            return accountBalance * 0.2;
        } else if (loyaltyPoints > 100) {
            return accountBalance * 0.1;
        }
        return accountBalance * 0.05;
    }
    public void printOrders() {
        orders.print("Order");
    }

    public void applyCoupons() {
        coupons.print("Applying coupon");
    }

    public void updateInfo(UserInfo user) {
        this.user = user;
    }
}

public class UserInfo {
    private String name;
    private Email email;
    private Address address;
    private Phone phone;

    void updateName(String name) { 
        this.name = name;
    }

    void updateEmail(Email email) {
        this.email = email;
    }

    void updateAddress(Address address) {
        this.address = address;
    }

    void updatePhone(Phone phone) {
        this.phone = phone;
    }
}

abstract class ContactInfo {
    protected String value;
    public String getValue() { return this.value; }
}

public class Email extends ContactInfo {
    public Email(String value) {
        // We can add validations in this part
        // and we don't overcharge the class User
        this.value = value;
    }
}

public class Address extends ContactInfo {
    public Address(String value) {
        // We can add validations in this part
        // and we don't overcharge the class User
        this.value = value;
    }
}

public class Phone extends ContactInfo {
    public Phone(String value) {
        // We can add validations in this part
        // and we don't overcharge the class User
        this.value = value;
    }
}

public class Item {
    private List<String> items;

    public Item(List<String> items){
        this.items = items;
    }

    public addItem(String item) {
        items.add(item);
    }

    public void print(String name) {
        for(String item : items) {
            System.println.out(name + ": " + items);
        }
    } 
}
```
