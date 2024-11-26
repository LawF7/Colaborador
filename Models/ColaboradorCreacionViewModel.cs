using Microsoft.AspNetCore.Mvc.Rendering;

namespace Colaboradores.Models
{
    public class ColaboradorCreacionViewModel: Colaborador
    {
        public IEnumerable<SelectListItem>? Departamentos { get; set; }
    }
}
