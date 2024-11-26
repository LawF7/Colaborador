using Colaboradores.Models;
using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace Colaboradores.Servicios
{
    public interface IRepositorioDepartamentos
    {
        Task Borrar(int id);
        Task<IEnumerable<Departamento>> Buscar();
        Task<int> Crear(Departamento departamento);
        Task<int> Editar(Departamento departamento);
        Task<Departamento> ObtenerPorId(int id);
    }
    public class RepositorioDepartamentos : IRepositorioDepartamentos
    {
        private readonly string? connectionString;
        private readonly StoredProcedures _procedures;


        public RepositorioDepartamentos(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");
            _procedures = configuration.GetSection("StoredProcedures").Get<StoredProcedures>();

        }

        public async Task<int> Crear(Departamento departamento)
        {
            using var connection = new SqlConnection(connectionString);
            var id = 
                await connection.QuerySingleAsync<int>(_procedures.SpCrearDepartamento, 
                                                        new { Nombre = departamento.Nombre, Estatus = departamento.Estatus },
                                                        commandType: System.Data.CommandType.StoredProcedure);

            return id;
        }

        //LISTADO departamentos
        public async Task<IEnumerable<Departamento>> Buscar()
        {
            using var connection = new SqlConnection(connectionString);

            // Llama al procedimiento almacenado
            return await connection.QueryAsync<Departamento>(
                _procedures.SpDepartamentos,
                commandType: CommandType.StoredProcedure
            );
        }


        //OBTENER departamento POR ID
        public async Task<Departamento> ObtenerPorId(int id)
        {
            using var connection = new SqlConnection(connectionString);

            // Llama al procedimiento almacenado
            return await connection.QueryFirstOrDefaultAsync<Departamento>(
                _procedures.SpObtenerDepartamento,
                new { Id = id },
                commandType: CommandType.StoredProcedure
            );
        }



        //EDITAR departamento
        public async Task<int> Editar(Departamento departamento)
        {
            using var connection = new SqlConnection(connectionString);

            // Llama al procedimiento almacenado
            var result = await connection.ExecuteScalarAsync<int>(
                _procedures.SpEditarDepartamento,
                new
                {
                    Id = departamento.Id,
                    Nombre = departamento.Nombre,
                    Estatus = departamento.Estatus
                },
                commandType: CommandType.StoredProcedure
            );

            return result; 
        }


        //BORRAR departamento
        public async Task Borrar(int id)
        {
            using var connection = new SqlConnection(connectionString);

            await connection.ExecuteAsync(
                _procedures.SpEliminarDepartamento,
                new { Id = id },
                commandType: CommandType.StoredProcedure
            );
        }


    }
}
