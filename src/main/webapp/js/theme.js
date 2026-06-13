/* theme.js — ES5 compatible (Eclipse JSDT safe) */
document.addEventListener("DOMContentLoaded", function () {

    // 1. Theme Toggle Management
    var themeToggleBtns = document.querySelectorAll(".theme-toggle-btn");
    var currentTheme = localStorage.getItem("theme") || "light";

    document.documentElement.setAttribute("data-theme", currentTheme);
    updateToggleIcons(currentTheme);

    for (var i = 0; i < themeToggleBtns.length; i++) {
        themeToggleBtns[i].addEventListener("click", function () {
            var activeTheme = document.documentElement.getAttribute("data-theme");
            var newTheme = activeTheme === "dark" ? "light" : "dark";
            document.documentElement.setAttribute("data-theme", newTheme);
            localStorage.setItem("theme", newTheme);
            updateToggleIcons(newTheme);
        });
    }

    function updateToggleIcons(theme) {
        for (var i = 0; i < themeToggleBtns.length; i++) {
            var sunIcon  = themeToggleBtns[i].querySelector(".sun-icon");
            var moonIcon = themeToggleBtns[i].querySelector(".moon-icon");
            if (theme === "dark") {
                if (sunIcon)  sunIcon.style.display  = "block";
                if (moonIcon) moonIcon.style.display = "none";
            } else {
                if (sunIcon)  sunIcon.style.display  = "none";
                if (moonIcon) moonIcon.style.display = "block";
            }
        }
    }

    // 2. Password Visibility Toggle
    var passwordToggles = document.querySelectorAll(".password-toggle");
    for (var p = 0; p < passwordToggles.length; p++) {
        passwordToggles[p].addEventListener("click", function (e) {
            e.preventDefault();
            var input      = this.parentElement.querySelector("input");
            var eyeIcon    = this.querySelector(".eye-icon");
            var eyeOffIcon = this.querySelector(".eye-off-icon");
            if (input.type === "password") {
                input.type = "text";
                if (eyeIcon)    eyeIcon.style.display    = "none";
                if (eyeOffIcon) eyeOffIcon.style.display = "block";
            } else {
                input.type = "password";
                if (eyeIcon)    eyeIcon.style.display    = "block";
                if (eyeOffIcon) eyeOffIcon.style.display = "none";
            }
        });
    }

    // 3. Mobile Sidebar Drawer Toggle
    var menuToggleBtn = document.querySelector(".mobile-menu-toggle");
    var sidebar       = document.querySelector(".sidebar");

    if (menuToggleBtn && sidebar) {
        menuToggleBtn.addEventListener("click", function () {
            sidebar.classList.toggle("sidebar-mobile-active");
        });
        document.addEventListener("click", function (e) {
            if (!sidebar.contains(e.target) &&
                !menuToggleBtn.contains(e.target) &&
                sidebar.classList.contains("sidebar-mobile-active")) {
                sidebar.classList.remove("sidebar-mobile-active");
            }
        });
    }

    // 4. Auto Fade-Out Alerts after 5 seconds
    var alerts = document.querySelectorAll(".alert");
    for (var a = 0; a < alerts.length; a++) {
        (function (alert) {
            setTimeout(function () {
                alert.style.transition = "opacity 0.5s ease, transform 0.5s ease";
                alert.style.opacity    = "0";
                alert.style.transform  = "translateY(-10px)";
                setTimeout(function () { alert.remove(); }, 500);
            }, 5000);
        })(alerts[a]);
    }

    // 5. Notification System (Database-Driven)
    function initNotifications() {
        var notificationList = document.getElementById("notification-list");
        var clearAllBtn      = document.getElementById("clear-all-notifications");
        var countText        = document.querySelector(".notification-count-text");
        var badge            = document.querySelector(".notification-badge");

        function getApiUrl() {
            var meta = document.querySelector('meta[name="ctx"]');
            var ctx  = meta ? meta.getAttribute("content") : "";
            return ctx + "/admin/notifications/api";
        }

        function updateBadges(unreadCount) {
            if (countText) {
                countText.textContent  = unreadCount + " New";
                countText.style.display = unreadCount > 0 ? "inline" : "none";
            }
            if (badge) {
                badge.textContent   = unreadCount;
                badge.style.display = unreadCount > 0 ? "flex" : "none";
            }
        }

        function getNotifIconHtml(type, title) {
            var t = (title || "").toLowerCase();

            if (t.indexOf("register") !== -1 || t.indexOf("new user") !== -1 ||
                t.indexOf("sign up")  !== -1 || t.indexOf("registration") !== -1) {
                return {
                    cls: "notif-icon-purple",
                    svg: '<svg viewBox="0 0 24 24"><path d="M16 21v-2a4 4 0 00-4-4H6a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/></svg>'
                };
            }
            if (t.indexOf("approved") !== -1  || t.indexOf("activated")   !== -1 ||
                t.indexOf("reactivated") !== -1 || t.indexOf("approve") !== -1) {
                return {
                    cls: "notif-icon-success",
                    svg: '<svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/><polyline points="16 11 18 13 22 9"/></svg>'
                };
            }
            if (t.indexOf("suspended") !== -1 || t.indexOf("frozen")  !== -1 ||
                t.indexOf("suspend")   !== -1 || t.indexOf("freeze")  !== -1 ||
                t.indexOf("locked")    !== -1) {
                return {
                    cls: "notif-icon-danger",
                    svg: '<svg viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>'
                };
            }
            if (t.indexOf("account") !== -1 || t.indexOf("bank")   !== -1 ||
                t.indexOf("credit")  !== -1) {
                return {
                    cls: "notif-icon-info",
                    svg: '<svg viewBox="0 0 24 24"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>'
                };
            }
            if (type === "SUCCESS") return { cls: "notif-icon-success", svg: '<svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>' };
            if (type === "DANGER")  return { cls: "notif-icon-danger",  svg: '<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>' };
            if (type === "WARNING") return { cls: "notif-icon-warning", svg: '<svg viewBox="0 0 24 24"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>' };
            return {
                cls: "notif-icon-default",
                svg: '<svg viewBox="0 0 24 24"><path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 01-3.46 0"/></svg>'
            };
        }

        function renderNotifications(notifications) {
            notificationList.innerHTML = "";
            var unreadCount = 0;

            if (notifications.length === 0) {
                notificationList.innerHTML =
                    '<div class="notification-empty">' +
                        '<div class="notification-empty-icon">' +
                            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">' +
                                '<path stroke-linecap="round" stroke-linejoin="round" d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/>' +
                                '<path stroke-linecap="round" stroke-linejoin="round" d="M13.73 21a2 2 0 01-3.46 0"/>' +
                            '</svg>' +
                        '</div>' +
                        '<p class="notification-empty-title">No Notifications</p>' +
                        '<p class="notification-empty-sub">You\'re all caught up.</p>' +
                    '</div>';
                if (clearAllBtn) clearAllBtn.style.display = "none";
                updateBadges(0);
                return;
            }

            if (clearAllBtn) clearAllBtn.style.display = "inline";

            for (var i = 0; i < notifications.length; i++) {
                (function (n) {
                    if (!n.read) unreadCount++;

                    var icon = getNotifIconHtml(n.type, n.title);

                    var item = document.createElement("div");
                    item.className = "notification-item" + (n.read ? "" : " unread");
                    item.innerHTML =
                        '<div class="notification-icon-wrap ' + icon.cls + '">' + icon.svg + '</div>' +
                        '<div class="notification-content">' +
                            '<p class="notification-title">'   + n.title + '</p>' +
                            '<p class="notification-msg">'     + n.msg   + '</p>' +
                            '<span class="notification-time">' + n.time  + '</span>' +
                        '</div>';

                    item.addEventListener("click", function () {
                        if (!n.read) {
                            var xhr = new XMLHttpRequest();
                            xhr.open("POST", getApiUrl(), true);
                            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                            xhr.send("action=mark_read&id=" + n.id);
                            n.read = true;
                            item.classList.remove("unread");
                            unreadCount = Math.max(0, unreadCount - 1);
                            updateBadges(unreadCount);
                        }
                        if (n.link && n.link !== "#") {
                            window.location.href = n.link;
                        }
                    });

                    notificationList.appendChild(item);
                })(notifications[i]);
            }

            updateBadges(unreadCount);
        }

        function loadNotifications() {
            if (!notificationList) return;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", getApiUrl(), true);
            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
            xhr.onreadystatechange = function () {
                if (xhr.readyState !== 4) return;
                if (xhr.status === 200) {
                    try {
                        var notifications = JSON.parse(xhr.responseText);
                        renderNotifications(notifications);
                    } catch (e) {
                        console.error("Error parsing notifications JSON:", e);
                        notificationList.innerHTML =
                            '<div style="padding: 2.5rem 1rem; text-align: center; color: var(--danger-color); font-size: 0.9rem;">' +
                                'Failed to load notifications' +
                            '</div>';
                    }
                } else {
                    console.error("Notification API error, status:", xhr.status);
                    notificationList.innerHTML =
                        '<div style="padding: 2.5rem 1rem; text-align: center; color: var(--danger-color); font-size: 0.9rem;">' +
                            'Failed to load notifications' +
                        '</div>';
                }
            };
            xhr.send();
        }

        if (clearAllBtn) {
            clearAllBtn.addEventListener("click", function (e) {
                e.preventDefault();
                var xhr = new XMLHttpRequest();
                xhr.open("POST", getApiUrl(), true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        loadNotifications();
                    }
                };
                xhr.send("action=clear_all");
            });
        }

        // Dropdown Toggle
        var notificationBtns = document.querySelectorAll(".notification-btn");
        for (var nb = 0; nb < notificationBtns.length; nb++) {
            notificationBtns[nb].addEventListener("click", function (e) {
                e.stopPropagation();
                var wrapper = this.closest(".notification-wrapper");
                if (wrapper) {
                    var dropdown = wrapper.querySelector(".notification-dropdown");
                    if (dropdown) dropdown.classList.toggle("show");
                }
            });
        }

        // Close dropdown on outside click
        document.addEventListener("click", function (e) {
            var openDropdowns = document.querySelectorAll(".notification-dropdown.show");
            for (var d = 0; d < openDropdowns.length; d++) {
                var wrapper = openDropdowns[d].closest(".notification-wrapper");
                if (wrapper && !wrapper.contains(e.target)) {
                    openDropdowns[d].classList.remove("show");
                }
            }
        });

        loadNotifications();
    }

    initNotifications();
});
