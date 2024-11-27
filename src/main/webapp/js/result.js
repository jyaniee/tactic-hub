document.addEventListener("DOMContentLoaded", function () {
    const team1 = JSON.parse(localStorage.getItem("team1"));
    const team2 = JSON.parse(localStorage.getItem("team2"));

    if (!team1 || !team2) {
        alert("팀 구성 데이터가 없습니다.");
        window.location.href = "main.jsp";
        return;
    }

    const playerInputs = document.querySelectorAll(".player_list input");

    team1.forEach((player, index) => {
        playerInputs[index].value = `${player.name} (${player.rank}-${player.tier})`;
    });

    team2.forEach((player, index) => {
        playerInputs[index + 5].value = `${player.name} (${player.rank}-${player.tier})`;
    });

    // 팀1의 점수 합산
    const team1Score = team1.reduce((total, player) => {
        return total + parseInt(player.rankValue) + parseInt(player.tierValue);
    }, 0);

    // 팀2의 점수 합산
    const team2Score = team2.reduce((total, player) => {
        return total + parseInt(player.rankValue) + parseInt(player.tierValue);
    }, 0);

    // 점수 차이 계산
    const scoreDifference = Math.abs(team1Score - team2Score);

    // 팀1 데이터 포맷팅
    const team1Data = team1
        .map(player => `${player.name} (${player.rank}-${player.tier})`)
        .join(", ");

    // 팀2 데이터 포맷팅
    const team2Data = team2
        .map(player => `${player.name} (${player.rank}-${player.tier})`)
        .join(", ");

    // 콘솔에 출력
    console.log(`Team 1 Score: ${team1Score}`);
    console.log(`Team 2 Score: ${team2Score}`);
    console.log(`Score Difference: ${scoreDifference}`);
    console.log(`Team 1: ${team1Data}`);
    console.log(`Team 2: ${team2Data}`);
});
