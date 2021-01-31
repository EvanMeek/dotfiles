#include <X11/XF86keysym.h>

/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 2; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const unsigned int systraypinning =
    0; /* 0: sloppy systray follows selected monitor, >0: pin systray to
          monitorX */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst =
    1; /* 1: if pinning fails, display systray on the first monitor, False:
          display systray on the last monitor*/
static const int showsystray = 1;      /* 0 means no systray */
static const unsigned int gappih = 10; /* horiz inner gap between windows */
static const unsigned int gappiv = 10; /* vert inner gap between windows */
static const unsigned int gappoh =
    5; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov =
    5; /* vert outer gap between windows and screen edge */
static const int smartgaps =
    1; /* 1 means no outer gap when there is only one window */
static const int showbar = 1;       /* 0 means no bar */
static const int topbar = 0;        /* 0 means bottom bar */
static const Bool viewontag = True; /* Switch view on tag switch */
static const char *fonts[] = {"agave Nerd Font:size=14:style=r"};
static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#ffffff";
static const char col_cyan[] = "#37474F";
static const char col_border[] = "#FF75BC";
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, col_gray1, col_gray2},
    [SchemeSel] = {col_gray4, col_cyan, col_border},
    [SchemeHid] = {col_cyan, col_gray1, col_border},
};
static const unsigned int alphas[][3] = {
    /*               fg      bg        border     */
    [SchemeNorm] = {OPAQUE, baralpha, borderalpha},
    [SchemeSel] = {OPAQUE, baralpha, borderalpha},
};

/* tagging */
static const char *tags[] = {"一", "二", "三", "四", "五",
                             "六", "七", "八", "九"};
/* static const char *tags[] = {"\uf120", "\uf7ae", "\uf121", "\uf04b",
 * "\ue62e", */
/*                              "\uf251", "\ue727", "\uf537", "\uf684"}; */

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    {"Emacs", "emacs", " *snails input*", 0, 1, -1},
};

/* layout(s) */
static const float mfact = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;   /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"Tile", tile}, /* first entry is default */
    {"><>", NULL},  /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char rofimon[2] = "0"; /* component of roficmd, manipulated in spawn() */
static const char *roficmd[] = {"rofi", "-show", "drun"};
static const char *termcmd[] = {"alacritty", NULL};
static const char *upvol[] = {
    "/home/evanmeek/Documents/dotfiles/dwm/scripts/vol-up.sh", NULL};
static const char *downvol[] = {
    "/home/evanmeek/Documents/dotfiles/dwm/scripts/vol-down.sh", NULL};
static const char *mutevol[] = {
    "/home/evanmeek/Documents/dotfiles/dwm/scripts/vol-toggle.sh", NULL};

static const char *wpcmd[] = {
    "/home/evanmeek/Documents/dotfiles/dwm/scripts/wp-change.sh", NULL};
static const char *suspendcmd[] = {
    "/home/evanmeek/Documents/dotfiles/dwm/scripts/suspend.sh", NULL};

static const char *screenshotcmd[] = {"flameshot", "gui", NULL};

static const char *emacsclient[] = {"emacsclient -c -a %", NULL};

static Key keys[] = {
    /* modifier            key                      function argument
     */
    // 程序启动器 rofi
    {MODKEY, XK_d, spawn, {.v = roficmd}},
    // EamcsClient
    {MODKEY | ShiftMask, XK_Return, spawn, {.v = emacsclient}},
    // 终端 alacritty
    {MODKEY, XK_Return, spawn, {.v = termcmd}},
    /* { MODKEY,              XK_c,                    spawn, {.v =
       browsercmd } }, */
    /* {MODKEY | ShiftMask, XK_w, spawn, {.v = setqwertycmd}}, */
    /* { MODKEY|ShiftMask,    XK_m,                    spawn, {.v =
       setcolemakcmd } }, */
    // 休眠
    {MODKEY | ShiftMask, XK_s, spawn, {.v = suspendcmd}},
    /* { MODKEY|ControlMask,  XK_s,                    spawn, {.v =
       sktogglecmd } }, */
    // 锁屏
    /* {MODKEY | ControlMask | ShiftMask, XK_l, spawn, {.v = screenlockcmd}}, */
    // 声音 -5
    {MODKEY, XK_bracketleft, spawn, {.v = downvol}},
    {0, XF86XK_AudioLowerVolume, spawn, {.v = downvol}},
    // 静音
    {MODKEY, XK_backslash, spawn, {.v = mutevol}},
    {0, XF86XK_AudioMute, spawn, {.v = mutevol}},
    // 声音+5
    {MODKEY, XK_bracketright, spawn, {.v = upvol}},
    {0, XF86XK_AudioRaiseVolume, spawn, {.v = upvol}},
    // 切换壁纸
    {MODKEY, XK_b, spawn, {.v = wpcmd}},
    // 屏幕亮度+5
    /* {MODKEY | ShiftMask, XK_Up, spawn, {.v = decbacklightcmd}}, */
    /* // 屏幕亮度-5 */
    /* {MODKEY | ShiftMask, XK_Down, spawn, {.v = incbacklightcmd}}, */
    // 截图
    {MODKEY | ControlMask, XK_p, spawn, {.v = screenshotcmd}},
    // 切换窗口位置
    {MODKEY | ShiftMask, XK_r, rotatestack, {.i = +1}},
    // 切换焦点
    {MODKEY, XK_l, focusstack, {.i = +1}},
    // 切换焦点
    {MODKEY, XK_h, focusstack, {.i = -1}},
    /* { MODKEY,              XK_a,                    viewtoleft, {0}
       }, */
    /* { MODKEY,              XK_f,                    viewtoright,
       {0} }, */
    /* // 移动当前窗口到左边 */
    /* {MODKEY | ShiftMask, XK_h, tagtoleft, {0}}, */
    /* // 移动当前窗口到右边 */
    /* {MODKEY | ShiftMask, XK_l, tagtoright, {0}}, */
    /* {MODKEY | ShiftMask | ControlMask, XK_e, incnmaster, {.i = +1}}, */
    /* {MODKEY | ShiftMask | ControlMask, XK_l, incnmaster, {.i = -1}}, */
    // 修改窗口大小
    {MODKEY | ControlMask, XK_h, setmfact, {.f = -0.05}},
    {MODKEY | ControlMask, XK_l, setmfact, {.f = +0.05}},
    // 隐藏窗口
    {MODKEY, XK_equal, hidewin, {0}},
    // 显示隐藏窗口
    {MODKEY, XK_minus, restorewin, {0}},
    /* { MODKEY,              XK_o,                    hideotherwins,  {0}}, */
    /* { MODKEY|ShiftMask,    XK_o,                    restoreotherwins, {0}},
     */
    /* { MODKEY|ShiftMask,    XK_b,                    togglebar,      {0} }, */
    /* {MODKEY | ShiftMask, XK_Return, zoom, {0}}, */
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY | ShiftMask, XK_q, killclient, {0}},
    // 新建窗口为平铺
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    // 新建窗口为浮动
    {MODKEY, XK_i, setlayout, {.v = &layouts[1]}},
    // 新建窗口为标签
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_f, togglefullscr, {0}},
    /* {MODKEY, XK_space, setlayout, {0}}, */
    // 设置当前窗口为浮动
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    // 窗口移动至左边显示器
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    // 窗口移动至右边显示器
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    // 注销
    {MODKEY | ControlMask | ShiftMask, XK_q, quit, {0}},
    // 焦点至左边显示器
    {MODKEY, XK_o, focusmon, {.i = -1}},
    // 焦点至右边显示器
    {MODKEY, XK_p, focusmon, {.i = +1}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8)};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument
     */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button1, togglewin, {0}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
