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

            List<Category> category;
            List<City> city;
            List<Customer> customer;
            List<Product> product;
            List<Order> order;
            List<OrderProduct> orderProduct;

            XmlSerializer deserializer;
            SqlCommand command;
            string connectionString = "Server=DESKTOP-JQDC5MV;Database=Store;Trusted_Connection=True;";

            string sql = "SELECT OrderProduct.id_orderProduct,  [Order].id_order,  [Order].date_time,  Customer.id_customer,  " +
                "Customer.name,  Customer.surname,  Customer.patronymic,  City.id_city,  City.city,  Customer.address,  Customer.phone, " +
                " Product.id_product,  Product.name,  Product.description,  Product.price,  Category.id_category,  Category.category, " +
                " Product.is_available FROM dbo.OrderProduct INNER JOIN dbo.[Order] ON  OrderProduct.id_order = [Order].id_order " +
                "INNER JOIN dbo.Customer ON  [Order].id_customer = Customer.id_customer " +
                "INNER JOIN dbo.City ON  Customer.id_city = City.id_city " +
                "INNER JOIN dbo.Product ON  OrderProduct.id_product = Product.id_product " +
                "INNER JOIN dbo.Category ON  Product.id_category = Category.id_category";
            //чтение из бд
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter(sql, connection);
                DataSet ds = new DataSet("root");
                adapter.Fill(ds);
                ds.WriteXml("store.xml", XmlWriteMode.IgnoreSchema);
                Console.WriteLine("Текст записан в файл");
            }
            using (var reader = new StreamReader("store.xml"))
            {
                deserializer = new XmlSerializer(typeof(List<Category>), new XmlRootAttribute("root"));
                category = (List<Category>)deserializer.Deserialize(reader);

                deserializer = new XmlSerializer(typeof(List<City>), new XmlRootAttribute("root"));
                city = (List<City>)deserializer.Deserialize(reader);

                deserializer = new XmlSerializer(typeof(List<Customer>), new XmlRootAttribute("root"));
                customer = (List<Customer>)deserializer.Deserialize(reader);

                deserializer = new XmlSerializer(typeof(List<Product>), new XmlRootAttribute("root"));
                product = (List<Product>)deserializer.Deserialize(reader);

                deserializer = new XmlSerializer(typeof(List<Order>), new XmlRootAttribute("root"));
                order = (List<Order>)deserializer.Deserialize(reader);

                deserializer = new XmlSerializer(typeof(List<OrderProduct>), new XmlRootAttribute("root"));
                orderProduct = (List<OrderProduct>)deserializer.Deserialize(reader);
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                for (int i = 0; i <= category.Count - 1; i++)
                {
                    sql = "insert into Category values(" + category[i].Id + ",'" + category[i].category + "')";
                    command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("Category заполнена");

                for (int i = 0; i <= city.Count - 1; i++)
                {
                    sql = "insert into City values(" + city[i].Id + ",'" + city[i].city + "')";
                    command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("City заполнена");

                for (int i = 0; i <= customer.Count - 1; i++)
                {
                    sql = "insert into Customer values(" + customer[i].Id + ",'" + customer[i].surname + "','" + customer[i].name + "','" + customer[i].patrtonymic + "','" + customer[i].phone + "','" + customer[i].id_city + "','" + customer[i].address + "','" + customer[i].phone + "')";
                    command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("Customer заполнена");

                for (int i = 0; i <= product.Count - 1; i++)
                {
                    sql = "insert into Product values(" + product[i].Id + ",'" + product[i].name + "','" + product[i].description + "','" + product[i].price + "'," + product[i].id_category + "," + product[i].is_available + ")";
                    command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("Product заполнена");

                for (int i = 0; i <= order.Count - 1; i++)
                {
                    sql = "insert into Order values(" + order[i].Id + "," + order[i].id_customer + ",'" + order[i].dare_time + "')";
                    command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("Order заполнена");

                for (int i = 0; i <= orderProduct.Count - 1; i++)
                {
                    sql = "insert into OrderProduct values(" + orderProduct[i].Id + "," + orderProduct[i].id_order + "," + orderProduct[i].id_product + ")";
                    command = new SqlCommand(sql, connection);
                    adpter.InsertCommand = command;
                    adpter.InsertCommand.ExecuteNonQuery();
                }
                Console.WriteLine("OrderProduct заполнена");
            }               

            Console.Read();
        }

    }
}
