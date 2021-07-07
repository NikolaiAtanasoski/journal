# Java Snippets # 

## measure time ##

```java
    private Instant lastInstant = Instant.now();

    private void logTime(String text) {
        logger.info(text + " -- Duration: " + Duration.between(lastInstant, Instant.now()).getSeconds() + " Sekunden ---" + Instant.now());
        lastInstant = Instant.now();
    }

    private void logTime(String text, Instant instant) {
        logger.info(text + " -- Duration: " + Duration.between(instant, Instant.now()).getSeconds() + " Sekunden ---" + Instant.now());
        lastInstant = Instant.now();
    }
```

