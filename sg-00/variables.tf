variable "services" {
  default = {
    mongodb   = 27017
    mysql     = 3306
    redis     = 6379
    rabbitmq  = 5672
    catalogue = 8080
    user      = 8080
    cart      = 8080
    shipping  = 8080
    payment   = 8080


  }

}


variable "sg_connections" {
  default = [
    {
      source      = "catalogue"
      destination = "mongodb"

    },
    {
      source      = "user"
      destination = "mongodb"


    },
    {
      source      = "user"
      destination = "redis"


    },
    {
      source      = "cart"
      destination = "redis"


    },
    {
      source      = "shipping"
      destination = "mysql"


    },
    {
      source      = "payment"
      destination = "rabbitmq"


    },
    {
      source      = "cart"
      destination = "catalogue"


    },
    {
      source      = "payment"
      destination = "user"


    },
    {
      source      = "payment"
      destination = "cart"

    },
    {
      source      = "shipping"
      destination = "cart"

    }
  ]

}

