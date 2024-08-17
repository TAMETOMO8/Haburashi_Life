import React from "react";
import { createRoot } from "react-dom/client";
import Sample from "../index";

const container = document.getElementById("form_area");
if (container) {
  const root = createRoot(container);
  root.render(<Sample />);
}