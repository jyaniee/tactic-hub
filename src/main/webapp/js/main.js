document.addEventListener("DOMContentLoaded", function() {
    const submitButton = document.querySelector(".submit");
    const resetButton = document.querySelector(".reset");
    const playerInputs = document.querySelectorAll(".player_list input");
    const calcButton = document.querySelector(".calc"); // calcButton 변수 정의 추가
    const rankScores = {
      "아이언": 0,
      "브론즈": 4,
      "실버": 8,
      "골드": 12,
      "플래티넘": 16,
      "다이아몬드": 20
  };
  
  const tierScores = {
      "I": 4,
      "II": 3,
      "III": 2,
      "IV": 1
  };
  
  
    let currentPlayerIndex = 0;


    let playerData = []; // 10명 저장 배열

    let totalScore = 0; 

    submitButton.addEventListener("click", function() {
      const playerName = document.getElementById("player").value.trim();
      const selectedRank= document.querySelector(".rank_icon .button.active");
      const selectedTier= document.querySelector(".tier_radio input[type='radio']:checked");
  
      if (!playerName) {
        alert("Please enter player name.");
        return;
      }
  
      if (!selectedRank) {
        alert("Please select a rank.");
        return;
      }
      if (!selectedTier){
        alert("Please select a tier.");
      }

      if (currentPlayerIndex >= playerInputs.length) {
        alert("All player slots filled. You can't submit more players.");
        return;
      }
      
      // 입력된 데이터 input(readonly)로 이동
      playerInputs[currentPlayerIndex].value = `${playerName} (${selectedRank.dataset.rank}-${selectedTier.dataset.tier})`;
      
      currentPlayerIndex++;
      document.getElementById("player").value = "";



      // 연산하기 위해 데이터 저장 : playerData[]
      const rank = selectedRank.dataset.rank;    
      const rankScore = selectedRank.dataset.value;
      const tierScore = selectedTier.dataset.value;
      const rtScore = parseInt(rankScore) + parseInt(tierScore);
      const tier = selectedTier.dataset.tier;
      
      playerData.push({
        name: playerName,
        rank: rank,
        rankValue: rankScore,
        tierValue: tierScore,
        tier: tier

      });
      
      totalScore = 0;
      for (var i = 0; i < playerData.length; i++) {
        const currentPlayer = playerData[i];
        const currentPlayerScore = parseInt(currentPlayer.rankValue) + parseInt(currentPlayer.tierValue);
        totalScore += currentPlayerScore;
    }
      
      console.log("Total Score: ", totalScore);
      
      

      if(playerData.length == 10){
        console.log("All player data: ", playerData);
        
        console.log("if(playerData.length == 10) totalScore: ",totalScore); 
        
      
      }



    });
  
    resetButton.addEventListener("click", function() {
      playerInputs.forEach(input => {
        input.value = "";
      });
      currentPlayerIndex = 0;
    });

	document.querySelectorAll(".rank_icon .button").forEach(button => {
	    button.addEventListener("click", function() {
	        // 모든 버튼에서 active 클래스 제거
	        document.querySelectorAll(".rank_icon .button").forEach(btn => btn.classList.remove("active"));
	        
	        // 현재 클릭한 버튼에 active 클래스 추가
	        this.classList.add("active");
	    });
	});

	// 모든 버튼에서 active 클래스를 제거하는 함수
	function removeActiveClass() {
	    document.querySelectorAll(".rank_icon .button").forEach(btn => btn.classList.remove("active"));
	}

	submitButton.addEventListener("click", function() {
	    // 모든 버튼에서 active 클래스 제거
	    removeActiveClass();
	});

	resetButton.addEventListener("click", function() {
	    playerInputs.forEach(input => {
	        input.value = "";
	    });
	    currentPlayerIndex = 0;

	    // 모든 버튼에서 active 클래스 제거
	    removeActiveClass();
	});

	// 클릭 이벤트 리스너
	document.querySelectorAll(".rank_icon .button").forEach(button => {
	    button.addEventListener("click", function() {
	        // 모든 버튼에서 active 클래스 제거
	        removeActiveClass();
	        
	        // 현재 클릭한 버튼에 active 클래스 추가
	        this.classList.add("active");
	    });
	});

	submitButton.addEventListener("click", function() {
	    // 모든 버튼에서 active 클래스 제거
	    removeActiveClass();
	    
	    // 라디오 버튼 선택 해제
	    document.querySelectorAll(".tier_radio input[type='radio']").forEach(radio => {
	        radio.checked = false;
	    });
	});

	resetButton.addEventListener("click", function() {
	    playerInputs.forEach(input => {
	        input.value = "";
	    });
	    currentPlayerIndex = 0;

	    // 모든 버튼에서 active 클래스 제거
	    removeActiveClass();

	    // 라디오 버튼 선택 해제
	    document.querySelectorAll(".tier_radio input[type='radio']").forEach(radio => {
	        radio.checked = false;
	    });
	});

	
    calcButton.addEventListener("click", function() {
      if (playerData.length !== 10) {
          alert("Please submit 10 players before calculating teams.");
          return;
      }
              

      // Pass the data to rp.html using localStorage
      localStorage.setItem('playerData', JSON.stringify(playerData));
      localStorage.setItem('totalScore', totalScore);

          // result.html
      window.location.href = "./result.html";
  });
  

  });
  

