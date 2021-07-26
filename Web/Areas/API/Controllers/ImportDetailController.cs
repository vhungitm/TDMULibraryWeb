using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;

namespace Web.Areas.API.Controllers
{
    public class ImportDetailController : Controller
    {
        ImportDetailDAO dao = new ImportDetailDAO();

        [HttpGet]
        public JsonResult Gets(long importId, string book = "", int page = 1, int pageSize = 5)
        {
            try
            {
                List<ImportDetail> data = dao.Gets(importId, book, page, pageSize);
                int totalRow = dao.Count(importId, book);

                return Json(new
                {
                    data = data,
                    totalRow = totalRow
                }, JsonRequestBehavior.AllowGet);
            } 
            catch (Exception)
            {
                return Json(new
                {
                    data = DBNull.Value.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult Get(long importId, string book)
        {
            try
            {
                ImportDetail data = dao.Get(importId, book);

                return Json(new
                {
                    data = data
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    data = DBNull.Value.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult Insert(ImportDetail model)
        {
            try
            {
                long status =  dao.Insert(model);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpPut]
        public JsonResult Update(ImportDetail model)
        {
            try
            {
                int status = dao.Update(model);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpDelete]
        public JsonResult Delete(long importId, long[] bookId)
        {
            try
            {
                int[] status = new int[bookId.Length];

                for (int i = 0; i < bookId.Length; i++)
                {
                    status[i] = dao.Delete(importId, bookId[i]);
                }

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }
    }
}