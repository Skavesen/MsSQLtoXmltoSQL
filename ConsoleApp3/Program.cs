using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Xml.Serialization;
using System.Xml;

namespace ConsoleApp3
{
    class Program
    {
        static void Main(string[] args)
        {
            SqlDataAdapter adpter = new SqlDataAdapter();
            Purchasing p = new Purchasing();
            string connectionString = "Server=DESKTOP-JQDC5MV;Database=Store;Trusted_Connection=True;";
            string sql = "SELECT * FROM Query";
            //чтение из бд
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter(sql, connection);
                DataSet ds = new DataSet("root");
                adapter.Fill(ds);
                ds.WriteXml("store.xml", XmlWriteMode.IgnoreSchema);
                Console.WriteLine("Текст записан в файл");
            }
            //1 метод десериализации
            List<Purchasing> purchasing;
            using (var reader = new StreamReader("store.xml"))
            {
                XmlSerializer deserializer = new XmlSerializer(typeof(List<Purchasing>),
                    new XmlRootAttribute("root"));
                purchasing = (List<Purchasing>)deserializer.Deserialize(reader);
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                for (int i = 0; i <= purchasing.Count - 1; i++)
                {
                    sql = "insert into Purchasing values(" + purchasing[i].Id + ",'" + purchasing[i].customer + "','" + purchasing[i].phone + "','" + purchasing[i].product + "','" + purchasing[i].date + "')";
                    SqlCommand command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("Текст записан в бд 1 метод");
            }
            // 2 метод просто из xml
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                XmlReader xmlFile = XmlReader.Create("store.xml", new XmlReaderSettings());
                DataSet ds = new DataSet();
                ds.ReadXml(xmlFile);
                for (int i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
                {
                    p.Id = Convert.ToInt32(ds.Tables[0].Rows[i].ItemArray[0]);
                    p.customer = ds.Tables[0].Rows[i].ItemArray[1].ToString();
                    p.phone = ds.Tables[0].Rows[i].ItemArray[2].ToString();
                    p.product = ds.Tables[0].Rows[i].ItemArray[3].ToString();
                    p.date = ds.Tables[0].Rows[i].ItemArray[4].ToString();

                    sql = "insert into Purchasing values(" + p.Id + ",'" + p.customer + "','" + p.phone + "','" + p.product + "','" + p.date + "')";
                    SqlCommand command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("Текст записан в бд 2 метод");
            }

            Console.Read();
        }


    }
}
