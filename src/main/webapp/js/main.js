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
        const selectedTier = document.querySelector(".tier_radio input[type='radio']:checked");

        if (!playerName || !selectedRank || !selectedTier) {
            alert("모든 항목을 입력해주세요!");
            return;
        }

        if (currentPlayerIndex >= playerInputs.length) {
            alert("모든 플레이어 슬롯이 채워졌습니다.");
            return;
        }

        const rank = selectedRank.dataset.rank;
        const tier = selectedTier.value;
        const rankValue = selectedRank.dataset.value;
        const tierValue = selectedTier.dataset.value;

        playerInputs[currentPlayerIndex].value = `${playerName} (${rank} ${tier})`;
        playerData.push({ name: playerName, rank, tier, rankValue, tierValue });
        currentPlayerIndex++;

    });

    resetButton.addEventListener("click", function () {
        playerInputs.forEach((input) => (input.value = ""));
        currentPlayerIndex = 0;
        playerData.length = 0;
    });

    calcButton.addEventListener("click", function () {
        if (playerData.length !== 10) {
            alert("10명의 플레이어를 입력해주세요.");
            return;
        }
        console.log(playerData);
        // 데이터를 서버로 전송
        fetch("TeamServlet", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(playerData),
        })
            .then((response) => response.json())
            .then((result) => {
                alert("팀 구성이 완료되었습니다!");
                console.log(result);
            })
            .catch((error) => console.error("Error:", error));
    });
});
