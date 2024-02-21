import { useState, useEffect } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import BlueHerring from './assets/BlueHerring.jpeg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)
  useEffect(() => {
    localStorage.setItem('flag', "broncoctf{ab4_d3_4ba_d1e_1m_blu3}")
  }, [])

  return (
    <>
      <div>
        <h1>Hello, Blue Boy</h1>
        <iframe width="560" height="315" src="https://www.youtube.com/embed/68ugkg9RePc?si=aYfCkEep9bdWykLt&amp;controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
        <p>Psssss you should watch the whole video</p>
        <img src={BlueHerring} id="wrong-fish" />
      </div>

    </>
  )
}

export default App
