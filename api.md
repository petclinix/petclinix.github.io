---
title: API - **PetcliniX**
permalink: /api/
---

# 📖 API Reference

**PetcliniX** publishes a shared [OpenAPI specification](/openapi.json) describing the reference
backend contract (generated from the [java-springboot-react-mtier](https://github.com/petclinix/java-springboot-react-mtier)
implementation). You can browse it interactively below, or grab the raw file directly:

👉 **[openapi.json](/openapi.json)**

---

## Why this matters for your implementation

Most showcases build both a frontend and a backend from scratch. If your paradigm is only about
*one side* of the stack, you don't have to build the other side just to have something to plug into:

- **Frontend-only implementations** — building a new UI (a different framework, a different
  rendering paradigm, a design-system experiment, ...) can target this API directly instead of
  standing up a backend. Point your client at a running instance of the reference backend and
  build your UI against this contract.
- **Backend-only implementations** — building a new backend (a different language, framework, or
  architectural style) can implement this same contract so it stays compatible with the reference
  frontend, and with any other frontend-only implementation in this showcase.

This is optional, not a requirement — see the [functionality requirements](/#-functionality-requirements-from-end-user-perspective)
for what actually has to be implemented. But conforming to this contract is the fastest way to get
a runnable full showcase without writing both halves yourself, and it keeps implementations
interchangeable with each other.

The spec is regenerated from the reference backend as its API evolves; treat it as a snapshot of
the current contract rather than a frozen standard.

---

<div id="swagger-ui"></div>

<link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@5/swagger-ui.css">
<script src="https://unpkg.com/swagger-ui-dist@5/swagger-ui-bundle.js"></script>
<script>
  window.onload = function() {
    window.ui = SwaggerUIBundle({
      url: "/openapi.json",
      dom_id: "#swagger-ui",
      presets: [
        SwaggerUIBundle.presets.apis,
        SwaggerUIBundle.SwaggerUIStandalonePreset
      ],
    });
  };
</script>
