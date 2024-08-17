import React from "react";
import { createRoot } from "react-dom/client";
import Header from "../header/header";

const container = document.getElementById("header_area");
if (container) {
  const root = createRoot(container);
  root.render(<Header />);
}