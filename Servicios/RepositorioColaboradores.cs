using Colaboradores.Models;
using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Colaboradores.Servicios
{
    public interface IRepositorioColaboradores
    {
        Task Borrar(int id);
        Task<IEnumerable<Colaborador>> Buscar();
        Task<int> Crear(Colaborador colaborador);
        Task<int> Editar(Colaborador colaborador);
        Task<Colaborador> ObtenerPorId(int id);
    }

    public class RepositorioColaboradores : IRepositorioColaboradores
    {
        private readonly string? connectionString;
        private readonly StoredProcedures _procedures;


        public RepositorioColaboradores(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");
            _procedures = configuration.GetSection("StoredProcedures").Get<StoredProcedures>();

        }

        public async Task<int> Crear(Colaborador colaborador)
        {
            using var connection = new SqlConnection(connectionString);
            var id =
                await connection.QuerySingleAsync<int>(_procedures.SpCrearColaborador,
                                                        new
                                                        {
                                                            DepartamentoId = colaborador.DepartamentoId,
                                                            DPI = colaborador.DPI,
                                                            NombreCompleto = colaborador.NombreCompleto,
                                                            Telefono = colaborador.Telefono,
                                                            CorreoElectronico = colaborador.CorreoElectronico
                                                        },
                                                        commandType: System.Data.CommandType.StoredProcedure);

            return id;
        }

        //LISTADO Colaboradores
        public async Task<IEnumerable<Colaborador>> Buscar()
        {
            using var connection = new SqlConnection(connectionString);

            return await connection.QueryAsync<Colaborador>(
                _procedures.SpColaboradores,
                commandType: CommandType.StoredProcedure
            );
        }


        //OBTENER EMPRESA POR ID
        public async Task<Colaborador> ObtenerPorId(int id)
        {
            using var connection = new SqlConnection(connectionString);

            return await connection.QueryFirstOrDefaultAsync<Colaborador>(
                _procedures.SpObtenerColaborador,
                new { Id = id },
                commandType: CommandType.StoredProcedure
            );
        }



        //EDITAR EMPRESA
        public async Task<int> Editar(Colaborador colaborador)
        {
            using var connection = new SqlConnection(connectionString);

            var result = await connection.ExecuteScalarAsync<int>(
                _procedures.SpEditarColaborador,
                new
                {
                    Id = colaborador.Id,
                    DepartamentoId = colaborador.DepartamentoId,
                    DPI = colaborador.DPI,
                    NombreCompleto = colaborador.NombreCompleto,
                    Telefono = colaborador.Telefono,
                    CorreoElectronico = colaborador.CorreoElectronico
                },
                commandType: CommandType.StoredProcedure
            );

            return result;

        }


        //BORRAR EMPRESA
        public async Task Borrar(int id)
        {
            using var connection = new SqlConnection(connectionString);

            var result = await connection.ExecuteAsync(
                _procedures.SpEliminarColaborador,
                new { Id = id },
                commandType: CommandType.StoredProcedure
            );

        }



    }
}
