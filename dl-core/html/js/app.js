window.addEventListener('message', function (event) {
    console.log("message")
    switch(event.data.action) {
        case 'show':
            AddNotify(event.data.notifyText, event.data.notifyType, event.data.notifyDuration)
            break;
        default:
            AddNotify(event.data.notifyText, event.data.notifyType, event.data.notifyDuration)
            break;
    }
});

function ShowNotif(data) {
    var $notification = $('.notification.template').clone();
    $notification.removeClass('template');
    $notification.addClass(data.type);
    $notification.html(data.text);
    $notification.fadeIn();
    $('.notif-container').prepend($notification);
    setTimeout(function() {
        $.when($notification.fadeOut(1500)).done(function() {
            $notification.remove()
        });
    }, data.length != null ? data.length : 2500);
}



// NEW
const notifyPanel = document.getElementById("notifyPanel");
const notifyTypes = {
    "success": "successNotify",
    "error": "errorNotify",
    "primary": "informNotify",
}

const AddNotify = (notifyText, notifyType, notifyDuration) => {
    const newNotify = document.createElement("div");
    newNotify.innerText = notifyText;
    newNotify.classList.add("notification");
    newNotify.classList.add(notifyTypes[notifyType]);
    notifyPanel.appendChild(newNotify);
    newNotify.style.transition = "transform 0.5s";

    setTimeout(() => {
        newNotify.style.transform = "translateX(0%)";
        setTimeout(() => {
            newNotify.style.transform = "translateX(150%)";
            setTimeout(() => {
                newNotify.remove();
            }, 500);
        }, notifyDuration);
    }, 100);
};

