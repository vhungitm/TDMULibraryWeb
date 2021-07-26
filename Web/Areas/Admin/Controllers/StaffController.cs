using System.Web.Mvc;

namespace Web.Areas.Admin.Controllers
{
    public class StaffController : BaseController
    {
        public ActionResult Index(string key = "", int status = 2, int page = 1)
        {
            ViewBag.key = key;
            ViewBag.status = status;
            ViewBag.page = page;

            return View();
        }
    }
}