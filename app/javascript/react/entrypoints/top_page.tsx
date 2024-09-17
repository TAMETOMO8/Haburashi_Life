import React from "react";
import { createRoot } from "react-dom/client";
import TopPages from "../top/top";

const container = document.getElementById("top_area");
if (container) {
  const root = createRoot(container);
  root.render(<TopPages />);
}