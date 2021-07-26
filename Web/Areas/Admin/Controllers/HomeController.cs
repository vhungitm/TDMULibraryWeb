using System.Web.Mvc;
using Web.Global;
using Model.EF;

namespace Web.Areas.Admin.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var session = (User)Session[Constants.ADMIN];

            if (session != null)
            {
                return View();
            }
            else
            {
                return Redirect("/Admin/Login");
            }
        }
    }
}