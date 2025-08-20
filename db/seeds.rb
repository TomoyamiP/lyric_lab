# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all

User.create({
  username: "nol0428",
  email: "naing@mail.com",
  password: "123456",
  age: 27,
  gender: "Male",
  music_style: "Pop",
  musician_type: "Semi-Pro"
})

User.create({
  username:  "paul",
  email: "paul@email.com",
  password: "password",
  age: 42,
  gender: "Male",
  music_style: "R&B",
  musician_type: "Virtuoso"
})

User.create({
  username: "gooner",
  email: "gonner@gmail.com",
  password:"gooner1234",
  age: 41,
  gender: "male",
  music_style: "Hip-Hop",
  musician_type: "Hobbyist"
})

User.create({
  username:  "vince",
  email: "vince@email.com",
  password: "123456",
  age: 30,
  gender: "Male",
  music_style: "Country",
  musician_type: "Beginner"
})

User.all.each do |user|
  Song.create({
    user: user,
    title: "Sunshine in the Morning",
    generated_lyrics: "
      Verse 1:

      Woke up this morning, feeling so bright

      Chasing the shadows, stepping into the light

      Every little moment, feels like a dream

      Dancing with the colors of the sunbeam

      Pre-Chorus:

      Oh, it's a good day, can't keep it inside

      Spread my wings, I'm ready to fly

      Nothing's gonna stop this feeling, I'm alive

      With sunshine in my heart, I thrive

      Chorus:

      Sunshine smile, shining all the while

      Lighting up my world, making me feel high

      Laughing in the rain, dancing in the glow

      With sunshine in my soul, I just wanna show

      Oh, oh, sunshine smile

      Verse 2:

      Golden rays are painting my sky

      Every moment's magic, I don't wanna say goodbye

      Happiness is calling, I hear the tune

      Singing along under the afternoon

      Pre-Chorus:

      Oh, it's a good day, can't keep it inside

      Spread my wings, I'm ready to fly

      Nothing's gonna stop this feeling, I'm alive

      With sunshine in my heart, I thrive

      Chorus:

      Sunshine smile, shining all the while

      Lighting up my world, making me feel high

      Laughing in the rain, dancing in the glow

      With sunshine in my soul, I just wanna show

      Oh, oh, sunshine smile

      Bridge:

      Brightness in my eyes, nothing can bring me down

      Every step I take, I'm spinning round and round

      Feel the warmth inside, it's a brand new start

      Sunshine on my face, it's a work of art

      Chorus:

      Sunshine smile, shining all the while

      Lighting up my world, making me feel high

      Laughing in the rain, dancing in the glow

      With sunshine in my soul, I just wanna show

      Oh, oh, sunshine smile

      Outro:

      Let the sunshine in, let the good times roll

      Forever in my heart, it's my shining goal"
    })

    Song.create({
    user: user,
    title: "Rain on my Heart",
    generated_lyrics: "
      Verse 1:

      Clouds are hanging low, shadows in my mind

      Rain falls soft and slow, tears I can't confine

      Every drop that hits the ground, echoes in my soul

      Lost in this lonely sound, trying to stay whole

      Chorus:

      Rain on my heart, wash away the pain

      Falling tears from the sky, calling out your name

      In this endless gray, I'm trying to find my way

      Rain on my heart, won't you stay?

      Verse 2:

      Memories like storms, swirling in my head

      Silent whispers' form, words I wish I'd said

      Darkness wraps around, hiding what I feel

      In this gloom I drown, wounds that won't heal

      Chorus:

      Rain on my heart, wash away the pain

      Falling tears from the sky, calling out your name

      In this endless gray, I'm trying to find my way

      Rain on my heart, won't you stay?

      Bridge:

      Sometimes I wonder why the sky cries for me

      Lost in this sorrow, longing to be free

      But the rain keeps falling, like the tears I hide

      In the storm, I'm falling, with nothing left inside

      Outro:

      Rain on my heart, softly fade away

      Leave me with the dark, until the break of day"
    })

    Song.create({
    user: user,
    title: "Echoes of Love",
    generated_lyrics: "
      Verse 1:

      Walking under neon lights, I see your face in every glow

      Heartbeat racing, catching fire, only you can make it so

      Whispered secrets in the night, tangled dreams we can't let go

      Lost in this moment, you and I, in a love that's bound to grow

      Pre-Chorus:

      Every time I hear your name, my world begins to spin

      Feel the magic in your touch, let the love come rushing in

      Chorus:

      Love, you're the melody that plays inside my heart

      Love, you're the reason I believe in us from the start

      Hold me close, don't let me go, this feeling's true and pure

      Love, with you forevermore, I know I can endure

      Verse 2:

      Sunrise paints the sky with gold, but your eyes outshine the dawn

      In your arms, I find my home, where I know I belong

      No need for words, just your smile, it's the language of my soul

      With you, I am complete, and I never want to let go

      Pre-Chorus:

      Every time I hear your name, my world begins to spin

      Feel the magic in your touch, let the love come rushing in

      Chorus:

      Love, you're the melody that plays inside my heart

      Love, you're the reason I believe in us from the start

      Hold me close, don't let me go, this feeling's true and pure

      Love, with you forevermore, I know I can endure

      Bridge:

      In this world of endless nights, you're my shining star

      Guiding me through every fight, showing who we are

      Forever's just a heartbeat away, as long as you're with me

      Love will never fade, it's our destiny

      Chorus:

      Love, you're the melody that plays inside my heart

      Love, you're the reason I believe in us from the start

      Hold me close, don't let me go, this feeling's true and pure

      Love, with you forevermore, I know I can endure

      Outro:

      Love, oh love, it's in the air we breathe

      Love, oh love, with you I believe"
    })

    Song.create({
    user: user,
    title: "Raging Fire Inside",
    generated_lyrics: "
      Verse 1:

      Burning up, I can't contain this rage

      Fury's rising, breaking out of my cage

      Every word, a spark that lights the flame

      This anger's wild, can't tame the beast in my name

      Pre-Chorus:

      Shouting loud, no I won't back down

      Feel the heat, I'm gonna take this town

      Let it out, all the pain I hide

      This is my storm, my furious pride

      Chorus:

      Raging fire inside, burning through my veins

      Can't hold back the storm, unleashed the pain

      Screaming loud, breaking through the night

      This anger's mine, I'm ready to fight

      Verse 2:

      Broken chains, I'm tearing them apart

      Rising up, a thunder in my heart

      No more silence, no more disguise

      This fury's real, it's fueling my rise

      Pre-Chorus:

      Shouting loud, no I won't back down

      Feel the heat, I'm gonna take this town

      Let it out, all the pain I hide

      This is my storm, my furious pride

      Chorus:

      Raging fire inside, burning through my veins

      Can't hold back the storm, unleashed the pain

      Screaming loud, breaking through the night

      This anger's mine, I'm ready to fight

      Bridge:

      No more chains, I'm breaking free

      Anger's my fuel, my destiny

      Stand my ground, I won't retreat

      This raging fire's my heartbeat

      Outro:

      Raging fire inside, feel the power rise

      Unleash the storm, no compromise

      This is who I am, loud and proud

      My furious voice, screaming out loud"
    })
  end
