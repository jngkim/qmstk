#include <libxml/xmlreader.h>
#include <string>
#include <iostream>


int main()
{

  std::string s("<?xml version=\"1.0\"?> \
      <project> \
      </project> ");

  xmlDocPtr m_doc = xmlParseMemory(s.data(), s.size());
  xmlFreeDoc(m_doc);

  return 0;
}

