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
    class City
    {
        public long Id { get; set; } = 1;

        public string city { get; set; } = "Undefined";
    }
}
