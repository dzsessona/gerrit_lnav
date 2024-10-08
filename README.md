# GERRIT_LNAV

Formats and other resources to support Gerrit log formats in lnav.
The Log File Navigator (lnav) is an advanced log file viewer for the console.

## Installation

Prerequisite: have [lnav](https://lnav.org/) installed in your system.

1. Clone this repository `git clone "https://review.gerrithub.io/dzsessona/gerrit_lnav"`
2. Follow the instruction by executing the command `./gerrit_lnav/gerrit-lnav.sh --help`


## Lnav useful information

• Format files are read from:
    📂 /etc/lnav
    📂 /opt/homebrew/Cellar/lnav/0.12.1/etc/lnav
    📂 ~/.lnav/formats

• Configuration, session, and format files are stored in:
    📂 ~/.lnav

## Development

To contribute to the various formats for Gerrit logs, please see this guide. 

[Define a new format in lnav](https://docs.lnav.org/en/latest/formats.html#defining-a-new-format)
[Install a new format in lnav](https://docs.lnav.org/en/latest/formats.html#installing-formats)

When lnav loads a file, it tries each log format against the first 15,000 lines of the file trying to find a match. 
To check if the format you defined is the one that is used when viewing a gerrit log file in lnav, simply lunch lnav
in debug mode i.e.

`truncate -s 0 /tmp/lnav.log && lnav -d /tmp/lnav.log ./error_log`

To import and test a format starting from [regex101](https://regex101.com):

`lnav -m regex101 import https://regex101.com/r/XXXXX/1 test`

and the resulting format will be installed in `~/.lnav/installed/test.json`

## Regex references

### error_log
```
^\[(?<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3,6}))(?:Z|([\+\-]\d{2}:\d{2}))?\][[:blank:]]\[(?<thread>.*)\][[:blank:]](?<level>[[:word:]]+)[[:blank:]](?<logger>(.)*)[[:blank:]]:[[:blank:]](?<message>((.*)(\r?\n(?!\[).*)*))
```


### httpd_log

- std
```
^(?<host>([0-9]{1,3}.){3}[0-9]{1,3})[[:blank:]]\[(?<thread>[^\]]+)\][[:blank:]]-[[:blank:]](?<username>\S+)[[:blank:]]\[(?<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3,6}))(?:Z|([\+\-]\d{2}:\d{2}))?\][[:blank:]]\"(?<method>[[:word:]]+)[[:blank:]](?<request>\S+)[[:blank:]](?<protocol>[^\"]+)\"[[:blank:]](?<status_code>\d+)[[:blank:]](?<response_size>(-)|\d+)[[:blank:]](?<latency>(-)|\d+)[[:blank:]](?<referer>\S+)[[:blank:]](?<client_agent>-|((\")?[^\"]*(\")?))[[:blank:]](?<total_cpu>(-)|\d+)[[:blank:]](?<user_cpu>(-)|\d+)[[:blank:]](?<memory>\d+)[[:blank:]](?<command_status>(\"-1\")|(-)|(\"0\"))$
```

- ipv6
```
^(?<host>\[([0-9]:){7}\d\])[[:blank:]]\[(?<thread>[^\]]+)\][[:blank:]]-[[:blank:]](?<username>\S+)[[:blank:]]\[(?<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3,6}))(?:Z|([\+\-]\d{2}:\d{2}))?\][[:blank:]]\"(?<method>[[:word:]]+)[[:blank:]](?<request>\S+)[[:blank:]](?<protocol>[^\"]+)\"[[:blank:]](?<status_code>\d+)[[:blank:]](?<response_size>(-)|\d+)[[:blank:]](?<latency>(-)|\d+)[[:blank:]](?<referer>\S+)[[:blank:]](?<client_agent>-|((\")?[^\"]*(\")?))[[:blank:]](?<total_cpu>(-)|\d+)[[:blank:]](?<user_cpu>(-)|\d+)[[:blank:]](?<memory>\d+)[[:blank:]](?<command_status>(\"-1\")|(-)|(\"0\"))$
```

### sshd_log

- std
```
^\[(?<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3,6}))(?:Z|([\+\-]\d{2}:\d{2}))?\][[:blank:]](?<session_id>\S+)[[:blank:]]\[(?<thread>.+)\][[:blank:]](?<username>\S+)[[:blank:]]a\/(?<account_id>[\S]+)[[:blank:]](?<operation>\S+)[[:blank:]](?<wait>\S+)[[:blank:]](?<exec>\S+)[[:blank:]]-[[:blank:]](?<status>\d+)[[:blank:]](?<client_agent>\S+)[[:blank:]](?<total_cpu>\S+)[[:blank:]](?<user_cpu>\S+)[[:blank:]](?<memory>(-)?\d+)$
```

- login / logout
```
^\[(?<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3,6}))(?:Z|([\+\-]\d{2}:\d{2}))?\][[:blank:]](?<session_id>\S+)[[:blank:]]\[(?<thread>.+)\][[:blank:]](?<username>\S+)[[:blank:]]a\/(?<account_id>[\S]+)[[:blank:]](?<operation>(LOGOUT)|(LOGIN FROM).*)
```

- git-upload-pack
```
^\[(?<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3,6}))(?:Z|([\+\-]\d{2}:\d{2}))?\][[:blank:]](?<session_id>\S+)[[:blank:]]\[(?<thread>.+)\][[:blank:]](?<username>\S+)[[:blank:]]a\/(?<account_id>[\S]+)[[:blank:]](?<operation>git-upload-pack.(\S)*)[[:blank:]](?<wait>\S+)[[:blank:]](?<exec>\S+)[[:blank:]]'(?<time_negotiating>\S+)[[:blank:]](?<time_searching_for_reuse>\S+)[[:blank:]](?<time_searching_for_sizes>\S+)[[:blank:]](?<time_counting>\S+)[[:blank:]](?<time_compressing>\S+)[[:blank:]](?<time_writing>\S+)[[:blank:]](?<total_time_in_uploadpack>\S+)[[:blank:]](?<bitmap_index_misses>(-1)|\d+)[[:blank:]](?<total_deltas>(-1)|\d+)[[:blank:]](?<total_objects>(-1)|\d+)[[:blank:]](?<total_bytes>(-1)|\d+)'[[:blank:]](?<status>\d+)[[:blank:]](?<client_agent>\S+)[[:blank:]](?<total_cpu>\S+)[[:blank:]](?<user_cpu>\S+)[[:blank:]](?<memory>\d+)$
```