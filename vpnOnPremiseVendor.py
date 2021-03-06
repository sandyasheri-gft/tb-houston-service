"""
This is the deployments module and supports all the ReST actions for the
vpnOnPremiseVendor collection
"""

# System modules
from datetime import datetime

# 3rd party modules
from flask import make_response, abort
from config import db, app
from models import VPNOnPremiseVendor, VPNOnPremiseVendorSchema
from pprint import pformat


def read_all():
    """
    This function responds to a request for /api/vpnOnPremiseVendor
    with the complete lists of vpnOnPremiseVendors

    :return:        json string of list of vpnOnPremiseVendors
    """

    # Create the list of vpnOnPremiseVendors from our data
    vpnOnPremiseVendor = VPNOnPremiseVendor.query.order_by(VPNOnPremiseVendor.key).all()
    app.logger.debug(pformat(vpnOnPremiseVendor))
    # Serialize the data for the response
    vpnOnPremiseVendor_schema = VPNOnPremiseVendorSchema(many=True)
    data = vpnOnPremiseVendor_schema.dump(vpnOnPremiseVendor)
    return data


def read_one(id):
    """
    This function responds to a request for /api/subnetmode/{id}
    with one matching vpnOnPremiseVendor from vpnOnPremiseVendors

    :param application:   id of vpnOnPremiseVendor to find
    :return:              vpnOnPremiseVendor matching key
    """

    vpnOnPremiseVendor = (VPNOnPremiseVendor.query.filter(VPNOnPremiseVendor.id == id).one_or_none())

    if vpnOnPremiseVendor is not None:
        # Serialize the data for the response
        vpnOnPremiseVendor_schema = VPNOnPremiseVendorSchema()
        data = vpnOnPremiseVendor_schema.dump(vpnOnPremiseVendor)
        return data
    else:
        abort(404, f"VPNOnPremiseVendor with id {id} not found")


def create(vpnOnPremiseVendor):
    """
    This function creates a new vpnOnPremiseVendor in the vpnOnPremiseVendor list
    based on the passed in vpnOnPremiseVendor data

    :param vpnOnPremiseVendor:  vpnOnPremiseVendor to create in vpnOnPremiseVendor structure
    :return:        201 on success, 406 on vpnOnPremiseVendor exists
    """

    # Remove id as it's created automatically
    if 'id' in vpnOnPremiseVendor:
        del vpnOnPremiseVendor['id']

    schema = VPNOnPremiseVendorSchema()
    new_vpnOnPremiseVendor = schema.load(vpnOnPremiseVendor, session=db.session)
    db.session.add(new_vpnOnPremiseVendor)
    db.session.commit()

    # Serialize and return the newly created deployment
    # in the response
    data = schema.dump(new_vpnOnPremiseVendor)
    return data, 201


def update(id, vpnOnPremiseVendor):
    """
    This function updates an existing vpnOnPremiseVendor in the vpnOnPremiseVendor list

    :param key:    key of the vpnOnPremiseVendor to update in the vpnOnPremiseVendor list
    :param vpnOnPremiseVendor:   vpnOnPremiseVendor to update
    :return:       updated vpnOnPremiseVendor
    """

    app.logger.debug(pformat(vpnOnPremiseVendor))

    if vpnOnPremiseVendor.get("id", id) != id:
           abort(400, f"Key mismatch in path and body")
           
    # Does the vpnOnPremiseVendor exist in vpnOnPremiseVendor list?
    existing_vpnOnPremiseVendor = VPNOnPremiseVendor.query.filter(
            VPNOnPremiseVendor.id == id 
    ).one_or_none()

    # Does vpnOnPremiseVendor exist?

    if existing_vpnOnPremiseVendor is not None:
        VPNOnPremiseVendor.query.filter(VPNOnPremiseVendor.id == id).update(vpnOnPremiseVendor)
        db.session.commit()

        # return the updated vpnOnPremiseVendor in the response
        schema = VPNOnPremiseVendorSchema()
        data = schema.dump(existing_vpnOnPremiseVendor)
        return data, 200
    else:
        abort(404, f"VPNOnPremiseVendor {id} not found")


def delete(id):
    """
    This function deletes a vpnOnPremiseVendor from the vpnOnPremiseVendors list

    :param key: key of the vpnOnPremiseVendor to delete
    :return:    200 on successful delete, 404 if not found
    """
    # Does the vpnOnPremiseVendor to delete exist?
    existing_vpnOnPremiseVendor = VPNOnPremiseVendor.query.filter(VPNOnPremiseVendor.id == id).one_or_none()

    # if found?
    if existing_vpnOnPremiseVendor is not None:
        db.session.delete(existing_vpnOnPremiseVendor)
        db.session.commit()

        return make_response(f"VPNOnPremiseVendor {id} successfully deleted", 200)

    # Otherwise, nope, vpnOnPremiseVendor to delete not found
    else:
        abort(404, f"VPNOnPremiseVendor {id} not found")


