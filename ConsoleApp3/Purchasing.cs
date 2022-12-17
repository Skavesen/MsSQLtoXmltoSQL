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
    public class Purchasing
    {
        public long Id { get; set; } = 1;

        public string customer { get; set; } = "Undefined";

        public string phone { get; set; } = "Undefined";

        public string product { get; set; } = "Undefined";

        public string date { get; set; } = "Undefined";
    }
}
