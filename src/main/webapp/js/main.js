// import Swal from 'sweetalert2'
// const Swal = require('sweetalert2')

document.addEventListener("DOMContentLoaded", function () {
    const submitButton = document.getElementById("submit");
    const resetButton = document.getElementById("reset");
    const calcButton = document.getElementById("calc");
    const playerInputs = document.querySelectorAll(".player_list input");

    const rankScores = {
        "iron": 0,
        "bronze": 4,
        "silver": 8,
        "gold": 12,
        "platinum": 16,
        "emerald": 20,
        "diamond": 24,
    };

    const tierScores = {
        "1": 4,
        "2": 3,
        "3": 2,
        "4": 1,
    };


    let currentPlayerIndex = 0;
    const playerData = [];

    submitButton.addEventListener("click", function () {
        const playerName = document.getElementById("player").value.trim();
        const selectedRank = document.querySelector(".rank-icon button.active");
        const selectedTier = document.querySelector(".tier_radio input[type='radio']:checked"); //선택된 라디오 버튼 찾기

        if (!playerName || !selectedRank || !selectedTier) {
            alert("모든 항목을 입력해주세요!");
            return;
        }

        if (currentPlayerIndex >= playerInputs.length) {
            alert("모든 플레이어 슬롯이 채워졌습니다.");
            return;
        }

        // html 태그 속성에서 가져옴
        const rank = selectedRank.dataset.rank; //dataset -> data- 로 시작하는 커스텀 데이터 속성에 접근
        const tier = selectedTier.value;

        // 미리 선언해둔 rankScores와 tierScores를 이용해서 선언
      //  const rankValue = selectedRank.dataset.value;
      //  const tierValue = selectedTier.dataset.value;
        const rankValue = rankScores[rank]; // rankScores 객체를 이용하여 값 매핑
        const tierValue = tierScores[tier]; // tierScores 객체를 이용하여 값 매핑

        playerInputs[currentPlayerIndex].value = `${playerName} (${rank} ${tier})`;
        playerData.push({name: playerName, rank, tier, rankValue, tierValue});
        currentPlayerIndex++;

        console.log("현재 플레이어 데이터:", playerData);
    });

    resetButton.addEventListener("click", function () {
        playerInputs.forEach((input) => (input.value = ""));//input 요소들에 대해 순차적으로 실행되는 메서드
        currentPlayerIndex = 0;
        playerData.length = 0;
    });

    calcButton.addEventListener("click", function () {
        if (playerData.length !== 10) {
           alert("10명의 플레이어를 입력해주세요.");
           /* Swal.fire({
                icon: 'error',
                title: '알림',
                text: '10명의 플레이어를 입력해주세요.',
                confirmButtontext: '확인'
            });*/
            return;
        }
        console.log(playerData);
        // 데이터를 서버로 전송
        fetch("TeamServlet", { //http요청을 보내는 함수
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(playerData),
        })
            .then((response) => response.json())
            .then((result) => {
                // 서버에서 받은 결과 처리
                localStorage.setItem("team1", JSON.stringify(result.team1));
                localStorage.setItem("team2", JSON.stringify(result.team2));
                console.log("result: " + result);
                window.location.href = "result.jsp";
            })
            .catch((error) => {
                    console.error("Error:", error);
                    alert("팀 구성 중 문제가 발생했습니다.");
            });
    });
});
