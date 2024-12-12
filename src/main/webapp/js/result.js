document.addEventListener("DOMContentLoaded", function () {
    const team1 = JSON.parse(localStorage.getItem("team1"));
    const team2 = JSON.parse(localStorage.getItem("team2"));

    const loadingAnimation = document.getElementById("loading-animation");
    const team1Container = document.getElementById("team1-players");
    const team2Container = document.getElementById("team2-players");
    const hiddenTeam1 = document.getElementById("hidden-team1");
    const hiddenTeam2 = document.getElementById("hidden-team2");

    if (!team1 || !team2) {
        alert("팀 구성 데이터가 없습니다.");
        window.location.href = "main.jsp";
        return;
    }

    // 로딩 애니메이션 시작
    setTimeout(() => {
        // 블러 제거
        team1Container.classList.add("clear");
        team2Container.classList.add("clear");
        loadingAnimation.classList.add("hidden");
        // 팀1 데이터 표시
        const team1Inputs = team1Container.querySelectorAll("input");
        team1.forEach((player, index) => {
            team1Inputs[index].value = `${player.name} (${player.rank}-${player.tier})`;
        });

        // 팀2 데이터 표시
        const team2Inputs = team2Container.querySelectorAll("input");
        team2.forEach((player, index) => {
            team2Inputs[index].value = `${player.name} (${player.rank}-${player.tier})`;
        });
    }, 3000); // 3초 후 블러 해제

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

    // 팀 1 데이터 표시 및 숨겨진 필드 설정
    const team1Data = team1
        .map(player => `${player.name} (${player.rank}-${player.tier})`)
        .join(", ");
    hiddenTeam1.value = team1Data;

    team1.forEach((player, index) => {
        const input = team1Container.querySelectorAll("input")[index];
        if (input) {
            input.value = `${player.name} (${player.rank}-${player.tier})`;
        }
    });

    // 팀 2 데이터 표시 및 숨겨진 필드 설정
    const team2Data = team2
        .map(player => `${player.name} (${player.rank}-${player.tier})`)
        .join(", ");
    hiddenTeam2.value = team2Data;

    team2.forEach((player, index) => {
        const input = team2Container.querySelectorAll("input")[index];
        if (input) {
            input.value = `${player.name} (${player.rank}-${player.tier})`;
        }
    });


    // 콘솔에 출력
    console.log(`Team 1 Score: ${team1Score}`);
    console.log(`Team 2 Score: ${team2Score}`);
    console.log(`Score Difference: ${scoreDifference}`);
    console.log(`Team 1: ${team1Data}`);
    console.log(`Team 2: ${team2Data}`);
});
