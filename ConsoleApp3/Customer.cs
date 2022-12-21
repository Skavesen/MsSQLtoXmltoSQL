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
    class Customer
    {
        public long Id { get; set; } = 1;

        public string name { get; set; } = "Undefined";

        public string surname { get; set; } = "Undefined";

        public string patrtonymic { get; set; } = "Undefined";

        public long id_city { get; set; } = 1;

        public string address { get; set; } = "Undefined";

        public string phone { get; set; } = "Undefined";
    }
}
