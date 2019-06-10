Return-Path: <SRS0=GDV9=UJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F27BC31E40
	for <bpf@archiver.kernel.org>; Mon, 10 Jun 2019 16:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA55C20859
	for <bpf@archiver.kernel.org>; Mon, 10 Jun 2019 16:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KobB5gjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfFJQer (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:34:47 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46274 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfFJQep (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 12:34:45 -0400
Received: by mail-qk1-f202.google.com with SMTP id 18so8602109qkl.13
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LUp0nj+AqZw3G+Fm1Fsn+w6Tf8Ol+e+vk5LYlQtxXeU=;
        b=KobB5gjSPg8Gg1d2ox4dVsG/KCskwyZVD5NwQxnfS+t0vemYKQe/ZWY8J3gw7QKgvB
         IlOKi1ES+dEUijdy7XKsi0SMmcQ4S9CN3w/qFQwfuWrSSHSGaq1R90XdUPSbeH6wFOCJ
         tOkAOcUTavaAkDI9Ktd8qB2W90MdOupfL06RzopEwUjYRLW0MNVA0UMJb1jhYyFjtGku
         sC752PJX8u2UM8koKDXQZxpkLdfH0wRzcutSVv0Wtm5n4JAD9K8jsNrX+d4+NL5HsMTi
         TFcmW8FdkAIF1znUeshZfdEwrXGDIsQl9W5ig/xwEaahQqfaCr/uXxs2wpPf8F2hlCB0
         5krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LUp0nj+AqZw3G+Fm1Fsn+w6Tf8Ol+e+vk5LYlQtxXeU=;
        b=hdyacvszhAJNIozKsrib4X7w+deQPw2vpCWprB52tIslChR31c+pyL5xx+I/FBN/Xe
         rxI/I7JRY3K+cWcbf/17x3C7RKldJe4GVEJgEEcNTfnlyVd/yuzc+etCJMDfOwTSH5DO
         Np4J+H35IU5nLWuIGy++/n55i4J6n882lwDZ9ilJDHulQyu/3eUSokcy25kyCCpV+Vo9
         j8xxUMeuQBa3Usy2udoLmGXA++MTMeJd+w5wDYwAYjqi2qFZci85RzYrW1+D1nvVto3p
         wu3jFIaD1Kuqt3FjWJDUmPxRTzlcuHFH1Wm0YLdzGsP5C0846Iy0Bq7V7XFGmceDxnul
         YD9Q==
X-Gm-Message-State: APjAAAUSFuHZYFPX2OL5mEdPCizaDyt0YPInvu0jc5Vb+8yl5ljKMrgD
        m7AwDQWU0kpQ5OiuaG8+fSeZWqg=
X-Google-Smtp-Source: APXvYqzD6/dCTu7oopS4u/dAAk/pm10qqlg0uvYqEKjjqlhN4rtxwd6weG0DsIpKXWRsciZHMU98g6Y=
X-Received: by 2002:a05:620a:55c:: with SMTP id o28mr54164589qko.86.1560184484992;
 Mon, 10 Jun 2019 09:34:44 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:34:21 -0700
In-Reply-To: <20190610163421.208126-1-sdf@google.com>
Message-Id: <20190610163421.208126-9-sdf@google.com>
Mime-Version: 1.0
References: <20190610163421.208126-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v4 8/8] bpftool: support cgroup sockopt
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support sockopt prog type and cgroup hooks in the bpftool.

Cc: Martin Lau <kafai@fb.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst | 7 +++++--
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool          | 8 +++++---
 tools/bpf/bpftool/cgroup.c                         | 5 ++++-
 tools/bpf/bpftool/main.h                           | 1 +
 tools/bpf/bpftool/prog.c                           | 3 ++-
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index 36807735e2a5..cac088a320a6 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -29,7 +29,8 @@ CGROUP COMMANDS
 |	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
 |	*ATTACH_TYPE* := { **ingress** | **egress** | **sock_create** | **sock_ops** | **device** |
 |		**bind4** | **bind6** | **post_bind4** | **post_bind6** | **connect4** | **connect6** |
-|		**sendmsg4** | **sendmsg6** | **sysctl** }
+|		**sendmsg4** | **sendmsg6** | **sysctl** | **getsockopt** |
+|		**setsockopt** }
 |	*ATTACH_FLAGS* := { **multi** | **override** }
 
 DESCRIPTION
@@ -86,7 +87,9 @@ DESCRIPTION
 		  unconnected udp4 socket (since 4.18);
 		  **sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
 		  unconnected udp6 socket (since 4.18);
-		  **sysctl** sysctl access (since 5.2).
+		  **sysctl** sysctl access (since 5.2);
+		  **getsockopt** call to getsockopt (since 5.3);
+		  **setsockopt** call to setsockopt (since 5.3).
 
 	**bpftool cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
 		  Detach *PROG* from the cgroup *CGROUP* and attach type
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 228a5c863cc7..c6bade35032c 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -40,7 +40,7 @@ PROG COMMANDS
 |		**lwt_seg6local** | **sockops** | **sk_skb** | **sk_msg** | **lirc_mode2** |
 |		**cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
 |		**cgroup/connect4** | **cgroup/connect6** | **cgroup/sendmsg4** | **cgroup/sendmsg6** |
-|		**cgroup/sysctl**
+|		**cgroup/sysctl** | **cgroup/getsockopt** | **cgroup/setsockopt**
 |	}
 |       *ATTACH_TYPE* := {
 |		**msg_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 2725e27dfa42..7afb8b6fbaaa 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -378,7 +378,8 @@ _bpftool()
                                 cgroup/connect4 cgroup/connect6 \
                                 cgroup/sendmsg4 cgroup/sendmsg6 \
                                 cgroup/post_bind4 cgroup/post_bind6 \
-                                cgroup/sysctl" -- \
+                                cgroup/sysctl cgroup/getsockopt \
+                                cgroup/setsockopt" -- \
                                                    "$cur" ) )
                             return 0
                             ;;
@@ -688,7 +689,8 @@ _bpftool()
                 attach|detach)
                     local ATTACH_TYPES='ingress egress sock_create sock_ops \
                         device bind4 bind6 post_bind4 post_bind6 connect4 \
-                        connect6 sendmsg4 sendmsg6 sysctl'
+                        connect6 sendmsg4 sendmsg6 sysctl getsockopt \
+                        setsockopt'
                     local ATTACH_FLAGS='multi override'
                     local PROG_TYPE='id pinned tag'
                     case $prev in
@@ -698,7 +700,7 @@ _bpftool()
                             ;;
                         ingress|egress|sock_create|sock_ops|device|bind4|bind6|\
                         post_bind4|post_bind6|connect4|connect6|sendmsg4|\
-                        sendmsg6|sysctl)
+                        sendmsg6|sysctl|getsockopt|setsockopt)
                             COMPREPLY=( $( compgen -W "$PROG_TYPE" -- \
                                 "$cur" ) )
                             return 0
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 7e22f115c8c1..3083f2e4886e 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -25,7 +25,8 @@
 	"       ATTACH_TYPE := { ingress | egress | sock_create |\n"	       \
 	"                        sock_ops | device | bind4 | bind6 |\n"	       \
 	"                        post_bind4 | post_bind6 | connect4 |\n"       \
-	"                        connect6 | sendmsg4 | sendmsg6 | sysctl }"
+	"                        connect6 | sendmsg4 | sendmsg6 | sysctl |\n"  \
+	"                        getsockopt | setsockopt }"
 
 static const char * const attach_type_strings[] = {
 	[BPF_CGROUP_INET_INGRESS] = "ingress",
@@ -42,6 +43,8 @@ static const char * const attach_type_strings[] = {
 	[BPF_CGROUP_UDP4_SENDMSG] = "sendmsg4",
 	[BPF_CGROUP_UDP6_SENDMSG] = "sendmsg6",
 	[BPF_CGROUP_SYSCTL] = "sysctl",
+	[BPF_CGROUP_GETSOCKOPT] = "getsockopt",
+	[BPF_CGROUP_SETSOCKOPT] = "setsockopt",
 	[__MAX_BPF_ATTACH_TYPE] = NULL,
 };
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 28a2a5857e14..9c5d9c80f71e 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -74,6 +74,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_REUSEPORT]		= "sk_reuseport",
 	[BPF_PROG_TYPE_FLOW_DISSECTOR]		= "flow_dissector",
 	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
+	[BPF_PROG_TYPE_CGROUP_SOCKOPT]		= "cgroup_sockopt",
 };
 
 extern const char * const map_type_name[];
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 1f209c80d906..a201e1c83346 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1070,7 +1070,8 @@ static int do_help(int argc, char **argv)
 		"                 sk_reuseport | flow_dissector | cgroup/sysctl |\n"
 		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
 		"                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
-		"                 cgroup/sendmsg4 | cgroup/sendmsg6 }\n"
+		"                 cgroup/sendmsg4 | cgroup/sendmsg6 | cgroup/getsockopt |\n"
+		"                 cgroup/setsockopt }\n"
 		"       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
 		"                        flow_dissector }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

