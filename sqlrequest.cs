using System;
using System.Data.SqlClient;

class Program {
    static void Main() {
        // Create a connection to the database
        string connectionString = "Data Source=(local);Initial Catalog=YourDatabaseName;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString)) {
            // Open the connection to the database
            connection.Open();

            // Create the SQL query command that the user will request
            Console.Write("Enter query: ");
            string query = Console.ReadLine();
            SqlCommand command = new SqlCommand(query, connection);

            // Execute the SQL query command and print the result
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read()) {
                Console.WriteLine(reader.GetString(0)); // Assumes first column is a string
            }
            reader.Close();
        }
    }
}
