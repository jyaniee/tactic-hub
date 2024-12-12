// DOMContentLoaded 이벤트가 발생하면 JavaScript 실행
window.addEventListener("DOMContentLoaded", () => {
    const submitButton = document.getElementById("submit");
    const resetButton = document.getElementById("reset");
    const calcButton = document.getElementById("calc");
    const playerInputs = document.querySelectorAll(".player_list input");

    let currentPlayerIndex = 0;
    const playerData = [];

    // API로 플레이어 추가
    if (submitButton) {
        submitButton.addEventListener("click", async () => {
            const playerInput = document.getElementById("player").value.trim();

            if (!playerInput || !playerInput.includes("#")) {
                alert("올바른 플레이어 이름과 태그를 입력하세요. (예: 이름#KR1)");
                return;
            }

            const [gameName, tagLine] = playerInput.split("#");

            try {
                const playerInfo = await fetchPlayerData(gameName, tagLine);
                if (!playerInfo) {
                    alert("플레이어 데이터를 가져올 수 없습니다.");
                    return;
                }

                // 플레이어 리스트에 추가
                if (currentPlayerIndex >= playerInputs.length) {
                    alert("모든 플레이어 슬롯이 채워졌습니다.");
                    return;
                }

                const rankValue = getRankValue(playerInfo.tier);
                const tierValue = getTierValue(playerInfo.rank);
    
                playerInputs[currentPlayerIndex].value = `${playerInfo.name} (${playerInfo.tier} ${playerInfo.rank})`;
                playerData.push({
                    name: playerInfo.name,
                    rank: playerInfo.tier,
                    tier: playerInfo.rank,
                    rankValue: rankValue,
                    tierValue: tierValue
                });
                currentPlayerIndex++;

                console.log("현재 플레이어 데이터:", playerData);
            } catch (error) {
                console.error("플레이어 데이터를 가져오는 중 오류 발생:", error);
                alert("API 호출 중 오류가 발생했습니다.");
            }
        });
    }

    // 초기화 버튼
    resetButton.addEventListener("click", () => {
        playerInputs.forEach(input => (input.value = ""));
        currentPlayerIndex = 0;
        playerData.length = 0;
    });

    // 팀 구성하기 버튼
    calcButton.addEventListener("click", () => {
        if (playerData.length !== 10) {
            alert("10명의 플레이어를 입력해주세요.");
            return;
        }

        // 데이터를 서버로 전송
        fetch(`${contextPath}/TeamServlet`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(playerData),
        })
            .then((response) => response.json())
            .then((result) => {
                // 서버에서 받은 결과 처리
                localStorage.setItem("team1", JSON.stringify(result.team1));
                localStorage.setItem("team2", JSON.stringify(result.team2));
                window.location.href = "result.jsp";
            })
            .catch((error) => {
                console.error("Error:", error);
                alert("팀 구성 중 문제가 발생했습니다.");
            });
    });

    // 랭크 점수 계산
    function getRankValue(tier) {
        const rankScores = {
            "IRON": 0,
            "BRONZE": 4,
            "SILVER": 8,
            "GOLD": 12,
            "PLATINUM": 16,
            "EMERALD": 20,
            "DIAMOND": 24,
        };
        return rankScores[tier] || 0;
    }

    // 티어 점수 계산
    function getTierValue(rank) {
        const tierScores = {
            "I": 4,
            "II": 3,
            "III": 2,
            "IV": 1,
        };
        return tierScores[rank] || 0;
    }
});

// Riot API 호출 함수
async function fetchPlayerData(gameName, tagLine) {
    try {
        const response = await fetch(`${contextPath}/riotApiService?gameName=${encodeURIComponent(gameName)}&tagLine=${encodeURIComponent(tagLine)}`);

        if (!response.ok) {
            throw new Error(`HTTP 오류! 상태 코드: ${response.status}`);
        }

        const data = await response.json();
        console.log("API응답 데이터: ", data);
        console.log("gameName: ", gameName);
        console.log("랭크: ", data.tier, " ", data.rank);

        return {
            name: gameName || "Unknown",
            rank: data.rank && data.tier !== "Unranked" ? `${data.rank}` : "",
            tier: data.tier !== "Unranked" ? `${data.tier}` : "Unranked"
        };
    } catch (error) {
        console.error("플레이어 데이터를 가져오는 중 오류 발생:", error);
        throw error;
    }
}
