using Microsoft.AspNetCore.Mvc;

namespace CiCdTestApp.Controllers
{
    [ApiController]
    public class HealthController : ControllerBase
    {
        [HttpGet("/health")]
        public IActionResult Health()
        {
            // Return 200 OK for liveness
            return Ok(new { status = "Healthy" });
        }

        [HttpGet("/ready")]
        public IActionResult Ready()
        {
            // Return 200 OK for readiness
            return Ok(new { status = "Ready" });
        }
    }
}
