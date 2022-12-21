using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace ConsoleApp3
{
    [Serializable]
    [XmlType("Table")]
    class OrderProduct
    {
        public long Id { get; set; } = 1;

        //[XmlArrayItem("order")]
        //public List<Order> id_order { get; set; }

        //[XmlArrayItem("product")]
        //public List<Product> id_product { get; set; }

        public long id_order { get; set; } = 1;

        public long id_product { get; set; } = 1;
    }
}
