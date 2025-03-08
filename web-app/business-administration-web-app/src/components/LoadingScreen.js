import { motion } from "framer-motion";
import { useState, useEffect } from "react";

const LoadingScreen = ({ onFinish }) => {
  const [isExiting, setIsExiting] = useState(false);

  return (
    <motion.div
      className="fixed top-0 left-0 w-full h-full bg-white flex items-center z-50"
      initial={{ opacity: 1 }}
      animate={{ opacity: isExiting ? 0 : 1 }}
      transition={{ duration: 0.5}}
      onAnimationComplete={() => isExiting && onFinish()}
    >
      {/* Line animation */}
      <motion.svg
        width="100%"
        height="400"
        viewBox="0 0 200 80"
        preserveAspectRatio="none" // Ensures the line stretches fully
  
        
      >
        <motion.path
          d="M 0 40 L 30 40 L 40 35 L 50 50 L 60 10 L 70 60 L 80 40 L 90 45 L 100 40 L 130 40 L 140 35 L 150 50 L 160 10 L 170 60 L 180 40 L 190 45 L 200 40 L 300 40"

          stroke="green"         
          strokeWidth="1"
          fill="transparent"
          initial={{ pathLength: 0 }}
          animate={{ pathLength: 1 }}
          exit={{ pathLength: 0 }}
          transition={{ duration: 2.5, 
            ease: [0.9,0.00000000002,1,1],
            times: [0, 0.1, 0.9, 1] // Custom cubic bezier for smooth motion
           
        }}
          onAnimationComplete={() => setIsExiting(true)} // Triggers exit when line completes
        />
      </motion.svg>
    </motion.div>
  );
};

export default LoadingScreen;
