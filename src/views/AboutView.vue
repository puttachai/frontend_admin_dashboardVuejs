<template>
  <div class="about px-4 py-4">
    <div class="text-center mb-4">
      <p>ดูแผนที่ของเราได้ด้านล่าง</p>
    </div>

    <div class="map-container">
      <iframe
        width="100%"
        height="450"
        frameborder="0"
        style="border:0"
        allowfullscreen
        loading="lazy"
        referrerpolicy="no-referrer-when-downgrade"
        src="https://www.google.com/maps/embed?pb=!1m23!1m12!1m3!1d62002.33963771467!2d100.66409341741806!3d13.770053975489327!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m8!3e9!4m0!4m5!1s0x311d63121168ab47%3A0xf287f979a6855241!2zUVBDNCsyNEYg4Lia4Lij4Li04Lip4Lix4LiXIOC4lOC4teC5gOC4nuC4suC5gOC4p-C4reC4o-C5jCDguYTguK3guJfguLUg4LmA4LiX4LiE4LmC4LiZ4LmC4Lil4Lii4Li1IOC4iOC4s-C4geC4seC4lCDguJYuIOC4o-C4suC4qeC4juC4o-C5jOC4nuC4seC4kuC4meC4siDguYHguILguKfguIfguKPguLLguKnguI7guKPguYzguJ7guLHguJLguJnguLIg4Liq4Liw4Lie4Liy4LiZ4Liq4Li54LiHIOC4geC4o-C4uOC4h-C5gOC4l-C4nuC4oeC4q-C4suC4meC4hOC4oyAxMDI0MA!3m2!1d13.7701057!2d100.70520239999999!5e0!3m2!1sth!2sth!4v1749868964514!5m2!1sth!2sth">
      </iframe>
    </div>
  </div>
</template>

<style>
.about {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;

  p{
    color: var(--dark);
    font-size: 1.5rem;
  }

}
.map-container {
  width: 100%;
  max-width: 900px;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
</style>
