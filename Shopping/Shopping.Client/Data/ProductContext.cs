using Shopping.Client.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Shopping.Client.Data
{
    public static class ProductContext
    {
        public static readonly List<Product> Products = new List<Product>()
        {
            new Product()
            {
                Name = "Iphone X",
                Description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                ImageFile = "product-1.png",
                Price = 950.00M,
                Category = "Smart Phone"
            },
            new Product()
            {
                Name = "Samsung S10",
                Description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                ImageFile = "product-2.png",
                Price = 840.00M,
                Category = "Smart Phone"
            },
            new Product()
            {
                Name = "Huawei Plus",
                Description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                ImageFile = "product-3.png",
                Price = 950.00M,
                Category = "White Appliances"
            },
            new Product()
            {
                Name = "Xiaomi Mi 9",
                Description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                ImageFile = "product-4.png",
                Price = 470.00M,
                Category = "White Appliances"
            },
            new Product()
            {
                Name = "HTC U11+ Plus",
                Description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                ImageFile = "product-5.png",
                Price = 300.00M,
                Category = "Smart Phone"
            },
            new Product()
            {
                Name = "LG G7 ThinQ",
                Description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                ImageFile = "product-6.png",
                Price = 240.00M,
                Category = "Home Kitchen"
            }
        };
    }
}
