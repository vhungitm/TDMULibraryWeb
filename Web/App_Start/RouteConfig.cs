using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Trangchu",
                url: "Index",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "Web.Controllers" }
            );

            routes.MapRoute(
                name: "DangNhap",
                url: "dang-nhap",
                defaults: new { controller = "Home", action = "Login", id = UrlParameter.Optional },
                namespaces: new[] { "Web.Controllers" }
            );

            routes.MapRoute(
                name: "LienHe",
                url: "lien-he",
                defaults: new { controller = "Home", action = "Contact", id = UrlParameter.Optional },
                namespaces: new[] { "Web.Controllers" }
            );

            routes.MapRoute(
                name: "GioiThieu",
                url: "gioi-thieu",
                defaults: new { controller = "Home", action = "Introduce", id = UrlParameter.Optional },
                namespaces: new[] { "Web.Controllers" }
            );

            routes.MapRoute(
                name: "LichSuMuon",
                url: "lich-su-muon/{id}",
                defaults: new { controller = "Book", action = "BorrowHistory", id = UrlParameter.Optional },
                namespaces: new[] { "Web.Controllers" }
            );

            routes.MapRoute(
              name: "TimKiem",
              url: "tim-kiem/{id}",
              defaults: new { controller = "Book", action = "Search", id = UrlParameter.Optional },
              namespaces: new[] { "Web.Controllers" }
           );

            routes.MapRoute(
              name: "NhaXuatBan",
              url: "nha-xuat-ban/{metaTitle}",
              defaults: new { controller = "Book", action = "Publisher", id = UrlParameter.Optional },
              namespaces: new[] { "Web.Controllers" }
           );

            routes.MapRoute(
               name: "TheLoai",
               url: "{metaTitle}",
               defaults: new { controller = "Book", action = "Category", id = UrlParameter.Optional },
               namespaces: new[] { "Web.Controllers" }
            );

            routes.MapRoute(
               name: "Sach",
               url: "{categoryName}/{metaTitle}",
               defaults: new { controller = "Book", action = "Detail", id = UrlParameter.Optional },
               namespaces: new[] { "Web.Controllers" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "Web.Controllers" }
            );
        } 
    }
}
