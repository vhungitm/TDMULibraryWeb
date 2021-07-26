using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.EF;
using Web.Global;

namespace Web.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        public ActionResult Index()
        {
            var session = (User)Session[Constants.ADMIN];

            if (session != null)
            {
                return Redirect("/Admin");
            }
            else
            {
                return View();
            }
        }
    }
}