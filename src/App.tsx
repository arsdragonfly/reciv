import React from 'react';
import logo from './logo.svg';
import { Counter } from './features/counter/Counter';
import { mkNowrapSquareGridContext, allPositions, nowrapSquareTopology } from 'purs/Topology'
import './App.css';
import { Canvas } from '@react-three/fiber'
import { Box } from './Box';

// polyfill for testing purposes
import { ResizeObserver } from '@juggle/resize-observer'

function App() {
  const gridContext = mkNowrapSquareGridContext(2)(2);
  const positions = allPositions(nowrapSquareTopology)(gridContext);
  console.log(positions)
  return (
    <div className="App">
      <header className="App-header">
        <Canvas resize={{ polyfill: ResizeObserver }}>
          <ambientLight />
          <pointLight position={[10, 10, 10]} />
          {positions.map((position, index) => <Box key={index} position={[position[0], position[1], 0]} />)}
          {/* <Box position={[-1.2, 0, 0]} />
          <Box position={[1.2, 0, 0]} /> */}
        </Canvas>
        <img src={logo} className="App-logo" alt="logo" />
        <Counter />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <span>
          <span>Learn </span>
          <a
            className="App-link"
            href="https://reactjs.org/"
            target="_blank"
            rel="noopener noreferrer"
          >
            React
          </a>
          <span>, </span>
          <a
            className="App-link"
            href="https://redux.js.org/"
            target="_blank"
            rel="noopener noreferrer"
          >
            Redux
          </a>
          <span>, </span>
          <a
            className="App-link"
            href="https://redux-toolkit.js.org/"
            target="_blank"
            rel="noopener noreferrer"
          >
            Redux Toolkit
          </a>
          ,<span> and </span>
          <a
            className="App-link"
            href="https://react-redux.js.org/"
            target="_blank"
            rel="noopener noreferrer"
          >
            React Redux
          </a>
        </span>
      </header>
    </div>
  );
}

export default App;
