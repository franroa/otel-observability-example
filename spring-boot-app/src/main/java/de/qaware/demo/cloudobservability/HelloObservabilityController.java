package de.qaware.demo.cloudobservability;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.concurrent.atomic.AtomicLong;

@RestController
public class HelloObservabilityController {

  private static final Logger logger = LogManager.getLogger();

  private final AtomicLong counter = new AtomicLong();
  private final OkHttpClient client = new OkHttpClient();

  /**
   * GET /hello will trigger a GET request to /god-of-fire. That way, we get a
   * nice distributed trace for the OpenTelemetry agent.
   */
  @GetMapping("/hello")
  public String hello() throws IOException {
    String path = "/hello";
    randomError(path);
    Request request = new Request.Builder().url("http://localhost:8080/observability").build();
    try (Response response = client.newCall(request).execute()) {
      return "Hello three, " + response.body().string() + "!\n";
    }
  }

  @GetMapping("/observability")
  public String observability() throws IOException {
    String path = "/observability";
    try {
      randomError(path);
    } finally {
      counter.incrementAndGet();
      testLog(counter.get());
    }
    return "Observability";
  }

  private void randomError(String path) throws IOException {
    if (Math.random() > 0.9) {
      throw new IOException("Random error with " + path + "!");
    }
  }

  public void testLog(Long name) {
    logger.trace("Hello World Nr." + name);
  }
}
