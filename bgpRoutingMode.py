"""
This is the deployments module and supports all the ReST actions for the
bgpRoutingMode collection
"""

# System modules
from datetime import datetime

# 3rd party modules
from flask import make_response, abort
from config import db, app
from models import BGPRoutingMode, BGPRoutingModeSchema
from pprint import pformat


def read_all():
    """
    This function responds to a request for /api/bgpRoutingMode
    with the complete lists of bgpRoutingModes

    :return:        json string of list of bgpRoutingModes
    """

    # Create the list of bgpRoutingModes from our data
    bgpRoutingMode = BGPRoutingMode.query.order_by(BGPRoutingMode.key).all()
    app.logger.debug(pformat(bgpRoutingMode))
    # Serialize the data for the response
    bgpRoutingMode_schema = BGPRoutingModeSchema(many=True)
    data = bgpRoutingMode_schema.dump(bgpRoutingMode)
    return data


def read_one(id):
    """
    This function responds to a request for /api/bgproutingmode/{id}
    with one matching bgpRoutingMode from bgpRoutingModes

    :param application:   id of bgpRoutingMode to find
    :return:              bgpRoutingMode matching key
    """

    bgpRoutingMode = (BGPRoutingMode.query.filter(BGPRoutingMode.id == id).one_or_none())

    if bgpRoutingMode is not None:
        # Serialize the data for the response
        bgpRoutingMode_schema = BGPRoutingModeSchema()
        data = bgpRoutingMode_schema.dump(bgpRoutingMode)
        return data
    else:
        abort(404, f"BGPRoutingMode with id {id} not found")


def create(bgpRoutingMode):
    """
    This function creates a new bgpRoutingMode in the bgpRoutingMode list
    based on the passed in bgpRoutingMode data

    :param bgpRoutingMode:  bgpRoutingMode to create in bgpRoutingMode structure
    :return:        201 on success, 406 on bgpRoutingMode exists
    """

    # Remove id as it's created automatically
    if 'id' in bgpRoutingMode:
        del bgpRoutingMode['id']

    schema = BGPRoutingModeSchema()
    new_bgpRoutingMode = schema.load(bgpRoutingMode, session=db.session)
    db.session.add(new_bgpRoutingMode)
    db.session.commit()

    # Serialize and return the newly created deployment
    # in the response
    data = schema.dump(new_bgpRoutingMode)
    return data, 201


def update(id, bgpRoutingMode):
    """
    This function updates an existing bgpRoutingMode in the bgpRoutingMode list

    :param key:    key of the bgpRoutingMode to update in the bgpRoutingMode list
    :param bgpRoutingMode:   bgpRoutingMode to update
    :return:       updated bgpRoutingMode
    """

    app.logger.debug(pformat(bgpRoutingMode))

    if bgpRoutingMode.get("id", id) != id:
           abort(400, f"Key mismatch in path and body")
           
    # Does the bgpRoutingMode exist in bgpRoutingMode list?
    existing_bgpRoutingMode = BGPRoutingMode.query.filter(
            BGPRoutingMode.id == id 
    ).one_or_none()

    # Does bgpRoutingMode exist?

    if existing_bgpRoutingMode is not None:
        BGPRoutingMode.query.filter(BGPRoutingMode.id == id).update(bgpRoutingMode)
        db.session.commit()

        # return the updted bgpRoutingMode in the response
        schema = BGPRoutingModeSchema()
        data = schema.dump(existing_bgpRoutingMode)
        return data, 200

    # otherwise, nope, deployment doesn't exist, so that's an error
    else:
        abort(404, f"BGPRoutingMode not found")


def delete(id):
    """
    This function deletes a bgpRoutingMode from the bgpRoutingModes list

    :param key: key of the bgpRoutingMode to delete
    :return:    200 on successful delete, 404 if not found
    """
    # Does the bgpRoutingMode to delete exist?
    existing_bgpRoutingMode = BGPRoutingMode.query.filter(BGPRoutingMode.id == id).one_or_none()

    # if found?
    if existing_bgpRoutingMode is not None:
        db.session.delete(existing_bgpRoutingMode)
        db.session.commit()

        return make_response(f"BGPRoutingMode {id} successfully deleted", 200)

    # Otherwise, nope, bgpRoutingMode to delete not found
    else:
        abort(404, f"BGPRoutingMode {id} not found")


