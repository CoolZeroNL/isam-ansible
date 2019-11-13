# (c) 2017 Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type
from pygments import highlight, lexers, formatters
import logging
import operator
import json

DOCUMENTATION = '''
    callback: debug
    type: stdout
    short_description: formatted stdout/stderr display
    description:
      - Use this callback to sort through extensive debug output
    version_added: "2.4"
    extends_documentation_fragment:
      - default_callback
    requirements:
      - set as stdout in configuration
'''

from ansible.plugins.callback.default import CallbackModule as CallbackModule_default


class CallbackModule(CallbackModule_default):  # pylint: disable=too-few-public-methods,no-init
    '''
    Override for the default callback module.

    Render std err/out outside of the rest of the result which it prints with
    indentation.
    '''
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = 'stdout'
    CALLBACK_NAME = 'debug_custom'

    def _dump_results(self, result, indent=None, sort_keys=True, keep_invocation=False):
        '''Return the text to output for a result.'''


        # Enable JSON identation
        result['_ansible_verbose_always'] = True

        save = {}
        for key in ['stdout', 'stdout_lines', 'stderr', 'stderr_lines', 'msg', 'log', 'module_stdout', 'module_stderr']:
            if key in result:
                save[key] = result.pop(key)

        output = CallbackModule_default._dump_results(self, result)

        print("\e[31m Hello world \e[0m")

        CRED = '\033[91m'
        CEND = '\033[0m'
        content = ''

        for key in ['stdout', 'stderr', 'msg', 'log', 'module_stdout', 'module_stderr']:
            if key in save and save[key]:
                if key == 'log' :
                  # print("this key is log")
                  # print(save[key])
                  lines = save[key].split('\n')
                  for line in lines:

                    if operator.contains(line.lower(), "text"):
                      data = line.lower().split(" text: ")
                      content += '\n' + data[0]

                      json_object = json.loads(data[1])
                      # json_formatted_str = json.dumps(json_object, indent=2)
                      formatted_json = json.dumps(json_object, sort_keys=True, indent=4)
                      colorful_json = highlight(formatted_json, lexers.JsonLexer(), formatters.TerminalFormatter())
                      content += '\n' + CRED + "Text:" + CEND
                      content += '\n' + CRED + colorful_json + CEND + '\n'

                    elif operator.contains(line.lower(), "headers are:"):
                      data = line.lower().split(" headers are: ")
                      content += '\n' + data[0]
                      content += '\n' + CRED + "Headers are:" + CEND
                      content += '\n' + CRED + data[1] + CEND + '\n'

                    elif operator.contains(line.lower(), "input data:"):
                      data = line.lower().split(" input data: ")
       	       	      content += '\n' + data[0]
                      content += '\n' + CRED + "Input Data:" + CEND
                      content += '\n' + CRED + data[1] + CEND + '\n'

                    else:
                      content += '\n' + line

                  # add content to output:
                  output += '\n\n%s:\n\n%s\n' % (key.upper(), content)
                else:
                  # print("this key issnt log")
                  output += '\n\n%s:\n\n%s\n' % (key.upper(), save[key])


               # logging.warning(output)

        for key, value in save.items():
                result[key] = value

        return output
