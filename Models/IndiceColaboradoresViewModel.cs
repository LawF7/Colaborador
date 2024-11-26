namespace Colaboradores.Models
{
    public class IndiceColaboradoresViewModel
    {
        public string? Departamento {  get; set; }
        public IEnumerable<Colaborador>? Colaboradores { get; set; }
    }
}
