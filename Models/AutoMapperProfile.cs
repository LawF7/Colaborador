using AutoMapper;

namespace Colaboradores.Models
{
    public class AutoMapperProfile: Profile
    {
        public AutoMapperProfile() {
            CreateMap<Colaborador, ColaboradorCreacionViewModel>();
        }
    }
}
