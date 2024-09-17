import * as React from 'react'
import applicationGuide from 'app/javascript/react/images/applicationGuide.png';
import editGuide from 'app/javascript/react/images/editGuide.png';
import noticeGuide from 'app/javascript/react/images/noticeGuide.png';
import searchGuide from 'app/javascript/react/images/searchGuide.png';
import guide from 'app/javascript/react/images/Guide.png';
import { useRef } from "react";
import { motion, useInView } from "framer-motion"
import "./top.css";

function Section({ children }) {
  const ref = useRef(null);
  const isInView = useInView(ref, { margin: "-80px", once: true });

  return (
    <section ref={ref}>
      <span
        style={{
          transform: isInView ? "none" : "translateX(20px)",
          opacity: isInView ? 1 : 0,
          transition: "all 0.9s cubic-bezier(0.17, 0.55, 0.55, 1) 1.0s"
        }}
      >
        {children}
      </span>
    </section>
  );
}

export default function TopPages() {

  return (
    <div>
      <div class="container-fluid">
      <Section>
        <motion.div
            className="box"
            animate={{ x: 0 }}
            transition={{ stiffness: 500 , type: "spring" }}
          >
          <div class="container pb-5">
            <div class="row g-5 align-items-center">
              <div className="col-lg-5 col-md-6 col-sm-12 wow fadeIn" data-wow-delay=".3s">
                <img src={applicationGuide} className="img-fluid mb-1 mt-3" alt="Application Guide" />
              </div>
              <div className="col-lg-7 col-md-6 col-sm-12 text-center">
                <h1 className="mb-4 tutorial-text">歯ブラシLife!は歯ブラシの情報共有と定期的な交換をサポートするアプリです。</h1>
                <p className="tutorial-text">
                  歯ブラシは使い始めて1ヶ月で毛先が広がり、磨く力が弱くなります。
                  <br className="d-none d-lg-block"/>
                  磨き残しが出て虫歯の原因となるので、歯ブラシLife!で定期的な交換を行いましょう!
                  <br className="d-none d-lg-block"/>
                  どんな歯ブラシが使われているのかも確認できるので、新しい歯ブラシの発見に役立ててください!
                </p>
                <div className="d-flex align-items-center mt-2 justify-content-center">
                  <p className="me-3 mb-0" id="line-friend-text">アプリのLINEアカウントを友だち追加して、交換の通知を受け取りましょう!</p>
                  <a href="https://lin.ee/2jlm07B"><img src="https://scdn.line-apps.com/n/line_add_friends/btn/ja.png" alt="友だち追加" height="36" /></a>
                </div>
              </div>
            </div>
          </div>
        </motion.div>
      </Section>
      </div>
      <Section>
        <motion.div
              className="box"
              animate={{ x: 0 }}
              transition={{ stiffness: 500 , type: "spring" }}
            >
          <div className="mt-5 container border-bottom border-dark">
            <h1>使い方</h1>
          </div>
        </motion.div>
      </Section>

      <Section>
        <motion.div
            className="box"
            animate={{ x: 0 }}
            transition={{ stiffness: 500 , type: "spring" }}
          >
          <div className="container-fluid py-2 my-2">
            <div className="container pt-5">
              <div className="row g-5 align-items-center">
                <div className="col-lg-7 col-md-6 col-sm-12 text-center">
                  <h1 className="mb-4 border-bottom border-dark tutorial-text">まずは使いたい歯ブラシを検索</h1>
                  <p className="tutorial-text">歯ブラシの名前はもちろん、知っているメーカーで検索してみましょう</p>
                </div>
                <div className="col-lg-5 col-md-6 col-sm-12 wow fadeIn" data-wow-delay=".3s">
                  <img src={searchGuide} className="img-fluid mb-1 mt-3" alt="Search Guide" />
                </div>
              </div>
            </div>
          </div>
        </motion.div>
      </Section>

      <Section>
        <motion.div
            className="box"
            animate={{ x: 0 }}
            transition={{ stiffness: 500 , type: "spring" }}
          >
          <div className="container-fluid py-2 my-2">
            <div className="container pt-5">
              <div className="row g-5 align-items-center">
                <div className="col-lg-5 col-md-6 col-sm-12 wow fadeIn" data-wow-delay=".3s">
                  <img src={editGuide} className="img-fluid mb-1 mt-3" alt="Edit Guide" />
                </div>
                <div className="col-lg-7 col-md-6 col-sm-12 text-center">
                  <h1 className="mb-4 border-bottom border-dark tutorial-text">歯ブラシが見つかったら、<br className="d-none d-lg-block"/>歯ブラシの情報と使い終わる日を入力</h1>
                  <p className="tutorial-text">一般的な歯ブラシの交換の目安は1ヶ月ですが、<br className="d-none d-lg-block"/>ご自身のライフスタイルに合った交換時期を探してみるのもいいでしょう</p>
                </div>
              </div>
            </div>
          </div>
        </motion.div>
      </Section>

      <Section>
        <motion.div
            className="box"
            animate={{ x: 0 }}
            transition={{ stiffness: 500 , type: "spring" }}
          >
          <div className="container-fluid py-2 my-2">
            <div className="container pt-5">
              <div className="row g-5 align-items-center">
                <div className="col-lg-7 col-md-6 col-sm-12 text-center">
                  <h1 className="border-bottom border-dark tutorial-text">メッセージを受け取れるようにしていると、使い終わる日にお知らせします。</h1>
                  <p className="tutorial-text">使い終わったあとは歯ブラシをリサイクルするか、掃除道具として使うか決めましょう！</p>
                </div>
                <div className="col-lg-5 col-md-6 col-sm-12 wow fadeIn" data-wow-delay=".3s">
                  <img src={noticeGuide} className="img-fluid mb-1 mt-3" alt="Notice Guide" />
                </div>
              </div>
            </div>
          </div>
        </motion.div>
      </Section>

      <Section>
        <motion.div
            className="box"
            animate={{ x: 0 }}
            transition={{ stiffness: 500 , type: "spring" }}
          >
          <div className="container-fluid pt-2 mt-2 pb-5 mb-5">
            <div className="container pt-5">
              <div className="row g-5 align-items-center">
                <div className="col-lg-5 col-md-6 col-sm-12 wow fadeIn" data-wow-delay=".3s">
                  <div className="h-100 position-relative">
                    <img src={guide} className="img-fluid mb-1 mt-3" alt="Guide" />
                  </div>
                </div>
                <div className="col-lg-7 col-md-6 col-sm-12 text-center">
                  <h1 className="tutorial-text">そうです、<br className="d-none d-lg-block tutorial-text"/>歯ブラシはリサイクルができます！</h1>
                  <p className="tutorial-text">LION株式会社さんによる、歯ブラシのリサイクルプログラムが全国で実施されています。</p>
                  <a href="https://www.lion.co.jp/ja/sustainability/toothbrush-recycling/" className="me-2 top-link">リサイクルプログラムについて</a>
                  <a href="https://www.google.com/maps/d/u/0/viewer?mid=1vfm_m3NM73IKEE5VYVRhkV1q_La1juz0&hl=ja&ll=33.868659968878575%2C132.5573857&z=6" className="ms-2 top-link">主なリサイクル実施箇所</a>
                  <p className="tutorial-text">この機会に、リサイクルプログラムとリサイクルが行われている場所を是非確認してみてください!</p>
                  <p className="tutorial-text">もしかしたら、あなたのお家の近くでリサイクルが行われているかもしれません・・・</p>
                </div>
              </div>
            </div>
          </div>
        </motion.div>
      </Section>
      <h3 className="text-center tutorial-text">説明は以上です。歯も地球もきれいにしましょう！</h3>
    </div>
  );
}