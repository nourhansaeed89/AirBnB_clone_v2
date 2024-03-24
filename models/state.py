#!/usr/bin/python3
"""This module defines the State class."""

from models.base_model import BaseModel, Base
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship
import models


class State(BaseModel, Base):
    """This class defines a state by various attributes."""
    __tablename__ = 'states'
    name = Column(String(128), nullable=False)
    cities = relationship("City", backref="state", cascade="all, delete")

    if models.storage_type != 'db':
        @property
        def cities(self):
            """Getter attribute that returns the list of City instances
            with state_id equals to the current State.id"""
            cities_list = []
            for city in models.storage.all('City').values():
                if city.state_id == self.id:
                    cities_list.append(city)
            return cities_list
