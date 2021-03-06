cimport screens.game as game
from screens import minmax_ai
from screens import minmax_ai_copy
from screens cimport minmax_ai
from screens cimport minmax_ai_copy
from screens import alpha_beta
from screens import alpha_beta_copy
from screens cimport alpha_beta
from screens cimport alpha_beta_copy
import pygame
import logging
import settings
cimport settings
import gui
import utils
import sys


class Menu:

    def __init__(self, app, force_music=False):
        logging.info('Initializing menu')
        self.app = app
        self.gui_container = None
        logging.info('Loading fonts')
        self.title_font = utils.load_font('monofur.ttf', 62)
        self.normal_font = utils.load_font('monofur.ttf', 18)
        self.small_font = utils.load_font('monofur.ttf', 15)
        self.musics_volume = self.app.config.getfloat('connectfour', 'music_volume')
        if not pygame.mixer.music.get_busy() or force_music:
            utils.load_music('menu.wav', volume=self.musics_volume)
        self.load_gui()

    def create_menu_button(self, y, text, on_click, disabled=False):
        btn_rect = pygame.Rect(0, y, 400, 40)
        btn_rect.centerx = self.app.window.get_rect().centerx
        return gui.Button(
            rect=btn_rect,
            font=self.normal_font,
            text=text,
            on_click=on_click,
            disabled=disabled
        )

    def btn_offline_game_click(self, widget):
        logging.info('Offline game button clicked')
        self.app.set_current_screen(game.Game)

    def start_minmax_copy_ai_game(self, widget):
        logging.info('Starting Minmax AI Copy')
        self.app.set_current_screen(minmax_ai_copy.GameMinmaxAICopy)

    def start_minmax_ai_game(self, widget):
        logging.info('Starting Minmax AI Stateful')
        self.app.set_current_screen(minmax_ai.GameMinmaxAI)

    def start_alpha_beta_ai_game(self, widget):
        logging.info('Starting AlphaBeta AI Stateful')
        self.app.set_current_screen(alpha_beta.AlphaBetaAI)

    def start_alpha_beta_copy_ai_game(self, widget):
        logging.info('Starting AlphaBeta AI Copy')
        self.app.set_current_screen(alpha_beta_copy.AlphaBetaAICopy)

    def btn_quit_click(self, widget):
        pygame.quit()
        sys.exit()

    def load_gui(self):
        gui.init(theme=settings.GuiTheme(
            sounds_volume=self.app.config.getfloat('connectfour', 'sounds_volume')))
        self.gui_container = pygame.sprite.Group()
        self.gui_container.add(self.create_menu_button(
            y=150,
            text='Two Player Mode',
            on_click=self.btn_offline_game_click
        ))
        self.gui_container.add(self.create_menu_button(
            y=510,
            text='Quit',
            on_click=self.btn_quit_click
        ))
        self.gui_container.add(self.create_menu_button(
            y=210,
            text='Play vs an AI (MinMax Stateful)',
            on_click=self.start_minmax_ai_game
        ))
        self.gui_container.add(self.create_menu_button(
            y=280,
            text='Play vs an AI (MinMax Copying Boards)',
            on_click=self.start_minmax_copy_ai_game
        ))
        self.gui_container.add(self.create_menu_button(
            y=350,
            text='Play vs an AI (AlphaBeta Stateful)',
            on_click=self.start_alpha_beta_ai_game
        ))
        self.gui_container.add(self.create_menu_button(
            y=420,
            text='Play vs an AI (AlphaBeta Copying Boards)',
            on_click=self.start_alpha_beta_copy_ai_game
        ))

    def draw_title(self):
        title = self.title_font.render('Connect Four', True, settings.Colors.BLACK.value)
        title_rect = title.get_rect()
        title_rect.centerx = self.app.window.get_rect().centerx
        title_rect.top = 25
        self.app.window.blit(title, title_rect)
        version = self.normal_font.render('v' + settings.VERSION, True, settings.Colors.BLACK.value)
        version_rect = version.get_rect()
        version_rect.topright = title_rect.bottomright
        self.app.window.blit(version, version_rect)

    def update(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT or (
                    event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE):
                pygame.quit()
                sys.exit()
            gui.event_handler(self.gui_container, event)
        self.app.window.fill(settings.Colors.WHITE.value)
        self.draw_title()
        self.gui_container.update()
        self.gui_container.draw(self.app.window)
