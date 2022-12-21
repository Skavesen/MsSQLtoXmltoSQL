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
    class Product
    {
        public long Id { get; set; } = 1;

        public string name { get; set; } = "Undefined";

        public string description { get; set; } = "Undefined";

        public long price { get; set; } = 1;

        public long id_category{ get; set; } = 1;

        public bool is_available { get; set; } = true;
    }
}
