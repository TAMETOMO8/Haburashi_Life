import React from "react";

type Props = {
  ImageName : string
}

export default function Image({ImageName} : Props) {

  return (
    <div className="col-lg-5 col-md-6 col-sm-12">
      <img src={ImageName} className="img-fluid mb-1 mt-3" alt="Application Image" />
    </div>
  );
}