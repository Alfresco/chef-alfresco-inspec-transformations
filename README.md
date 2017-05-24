# chef-alfresco-inspec-transformations Inspec Profile

Inspec profile for [chef-alfresco-transformations](https://github.com/Alfresco/chef-alfresco-transformations) cookbook

To use it in your Kitchen suite add:

```
verifier:
  inspec_tests:
    - name: chef-alfresco-inspec-transformations
      git: https://github.com/Alfresco/chef-alfresco-inspec-transformations
```

This Profile depends on [chef-alfresco-inspec-utils](https://github.com/Alfresco/chef-alfresco-inspec-utils) to import libraries and matchers
