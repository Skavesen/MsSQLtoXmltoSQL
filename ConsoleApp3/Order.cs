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
    class Order
    { 
        public long Id { get; set; } = 1;

        public long id_customer { get; set; } = 1;

        public DateTime dare_time { get; set; }
    }
}
