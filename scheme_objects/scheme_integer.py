from scheme_objects.scheme_number import SchemeNumber


class SchemeInteger(SchemeNumber):
	"""Scheme Integer Values"""
	def __init__(self, int_value):
		super(SchemeInteger, self).__init__()
		self.value = int_value

	def to_string(self):
		return str(self.value)