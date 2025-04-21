const container = document.querySelector('.container');
const options = document.querySelector('.options');
const closeButton = document.querySelector('.close-button');
const nameOfPed = document.querySelector('.name-of-ped');
const show = (data, displayName) => {
    container.style.display = 'block';
    options.innerHTML = '';
    nameOfPed.innerText = displayName;
    data.forEach((item) => {
        const button = document.createElement('button');
        button.classList.add('button');
        button.textContent = item.label;
        button.addEventListener('click', () => {
            container.style.display = 'none';
            fetch('https://jhn_interactions/interact', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    actionId: item.actionId,
                    interactionId: item.interactionId
                }),
            });
        });
        options.appendChild(button);
    });
};

closeButton.addEventListener('click', () => {
    container.style.display = 'none';
    fetch('https://jhn_interactions/close', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
    });
});
window.addEventListener("message", function(event) {
    const e = event.data;
    if (e.action === "show") {
        show(e.options, e.displayName);
    } else if (e.action === "hide") {
        container.style.display = 'none';
    }
});