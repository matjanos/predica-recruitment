using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Microsoft.AspNetCore.Mvc;

using Task2.Domain.Models;

namespace Task2.Controllers
{
    [Route ("api/[controller]")]
    [ApiController]
    public class CarsController : ControllerBase
    {
        [HttpGet]
        public ActionResult<IEnumerable<Car>> Get ()
        {
            return new Car[]
            {
                new Car ("YASD 2123", "Black", new DateTime (2011, 01, 26)),
                new Car ("CT 2123", "Yellow", new DateTime (2017, 02, 23)),
                new Car ("YAPO 2123", "Black", new DateTime (2001, 01, 22)),
            };
        }
    }
}