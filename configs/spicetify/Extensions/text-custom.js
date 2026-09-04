(function () {
  const s = document.createElement("style");
  s.classList.add("text-custom");
  s.textContent = `
/* Hide connect button */
.main-connectBar-connectBar,
button[title*="Connect"],
button[aria-label*="Connect"],
button[data-testid="connect-button"],
button[aria-label*="Devices"] {
  display: none !important;
}

/* Hide miniplayer button */
button[data-testid="mini-player-button"],
button[aria-label*="Miniplayer"],
button[aria-label*="mini-player"],
.main-nowPlayingBar-right button[aria-label*="Mini"] {
  display: none !important;
}

/* Fix light text on accent buttons (modal confirm etc) */
.encore-dark-theme .encore-bright-accent-set,
.encore-dark-theme .encore-bright-accent-set * {
  --text-base: var(--spice-main) !important;
  --text-subdued: var(--spice-main) !important;
  color: var(--spice-main) !important;
}

/* Fix modal dialog colors (was showing light theme) */
.GenericModal,
.GenericModal__overlay,
.GenericModal__overlay > div,
.GenericModal__overlay *,
dialog,
dialog *,
div[role="dialog"] {
  --background-base: var(--spice-main);
  --background-highlight: var(--spice-highlight);
  --background-press: var(--spice-highlight);
  --background-elevated-base: var(--spice-main);
  --background-elevated-highlight: var(--spice-highlight);
  --text-base: var(--spice-text);
  --text-subdued: var(--spice-subtext);
  --essential-subdued: var(--spice-border-inactive);
  --decorative-subdued: var(--spice-accent-inactive);
  --essential-base: var(--spice-border-active);
  --essential-bright-accent: var(--spice-button-active);
}
.GenericModal,
.GenericModal__overlay > div,
dialog {
  background-color: var(--spice-main);
}

/* Pane header labels use border color instead of invisible header color */
.Root__globalNav::before,
.main-globalNav-searchContainer form div:has(> .main-topBar-searchBar:focus)::before,
.Root__nav-bar .main-yourLibraryX-entryPoints:has(.main-yourLibraryX-navItems)::before,
.Root__nav-bar .main-yourLibraryX-entryPoints:has(.main-yourLibraryX-libraryContainer)::before,
.Root__main-view::before,
.main-nowPlayingBar-container::before,
.Root__right-sidebar:has(aside:not(:empty))::before {
  color: var(--spice-border-inactive) !important;
}
.Root__globalNav:hover::before,
.Root__nav-bar .main-yourLibraryX-entryPoints:hover::before,
.Root__main-view:hover::before,
.main-nowPlayingBar-container:hover::before,
.Root__right-sidebar:has(aside:not(:empty)):hover::before {
  color: var(--spice-border-active) !important;
}

/* Bigger playback controls */
.player-controls__buttons {
  transform: scale(1.3) !important;
  transform-origin: center !important;
  gap: 4px !important;
}

/* Progress bar style - thin line with accent color */
.main-nowPlayingBar-container [data-testid="playback-progressbar"] {
  height: 3px !important;
  border-radius: 2px !important;
}
.main-nowPlayingBar-container [data-testid="playback-progressbar"] [data-testid="progress-bar"] {
  --progress-bar-height: 3px !important;
  --progress-bar-radius: 2px !important;
}
.main-nowPlayingBar-container [data-testid="playback-progressbar"] .x-progressBar-fillColor,
.main-nowPlayingBar-container [data-testid="playback-progressbar"] [data-testid="progress-bar-fill"] {
  background-color: var(--spice-button-active) !important;
}
.main-nowPlayingBar-container .playback-bar .progress-bar__slider,
.main-nowPlayingBar-container [data-testid="playback-progressbar"] [data-testid="progress-bar-handle"] {
  display: none !important;
}

/* Liked songs heart color - use accent */
.main-addButton-button[aria-label*="Liked"],
button[aria-label*="Remove from Liked"],
.main-addButton-button[aria-checked="true"] svg,
.main-addButton-button[data-encore-id="buttonTertiary"] svg[fill="#1ed760"],
.main-addButton-button svg path[d*="M12 21"] {
  color: var(--spice-button-active) !important;
  fill: var(--spice-button-active) !important;
}
.main-addButton-button svg path {
  fill: var(--spice-subtext) !important;
}
.main-addButton-button[aria-checked="true"] svg path,
.main-addButton-button[aria-label*="Remove from"] svg path {
  fill: var(--spice-button-active) !important;
}
  `;
  document.head.appendChild(s);
})();
