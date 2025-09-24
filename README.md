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

La clase user es muy grande y contiene cosas que no son propias de la clase por ejemplo la lista orderss

### Código duplicado

Este código es duplicado ya que ambos iteran sobre una lista e imprimen en la consola

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

Este método recibe una lista larga de parámetros, estos se podrían enviar para otra clase como "userInfo"

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

Este código se debe de eliminar ya que dice que no se va a usar más

``` java
        // Deprecated method
        public void deprecatedMethod() {
            // This method is no longer used
        }
```

### Problema de lógica

Acá por ejemplo nunca se va a aplicar el descuento si tiene más de 200 puntos, siempre en ese caso se aplicaría el primer if, además siempre se va a aplicar un descuento del 0.05 debido al else.

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

Las dirrecciones, direcciones de correo y email si tienen validaciones pueden convertirse en algo difícil de mantener debido a que le pueden agregar más complejidad a esta clase.

``` java
        private String address;
        private String phone;
        private String email;
```

### Envidia de características

Estas dos pareciera que perfectamente pueden pertenecer a otra clase, además una clase no debe de manejar todas las cosas de un programa, pienso que orders y coupons no calzan en la clase User. 

``` java
        private List<String> orders;
        private List<String> coupons;
```