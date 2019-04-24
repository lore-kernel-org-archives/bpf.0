Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA9C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DFB20835
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXXnN4OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfDXVbr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:31:47 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56546 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfDXVbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 17:31:47 -0400
Received: by mail-pl1-f201.google.com with SMTP id gn10so13155354plb.23
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1EjWmQcKxn9x5KSLal9ZUpeWIYKWWx06r7Cg/o3+fR8=;
        b=LXXnN4OMmV9e+mG7FePNk6u6Iln7RB1APjSVO0yWgr4bk5wCgBpUCI9sB2TJfB3zGS
         YdDgATqrgOs4TVqRZOh+9RedXgmKMIqFLLnhZf8MiWDliuvX5OvOGX78Z9JpeIzjObEn
         T7+WTbwrnqBeD9UK9OA7z4c92ZjCJwJpyzjOTdW9CtS/kimZUFKQRks14Dm+RnnqFe7P
         0Vz38wlbzvx/tE6u36k9AjiYf1KeH/mbnjtHZ+vrvUIX2wMoizLtAWwsqpKiQZRIgo0X
         8YkzE3ADlqcRi8LqFvcYklhA1nSYlB2O3W10e9rnF3qNB1SX9L+aPn0IsHX9K2qDU17Y
         V5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1EjWmQcKxn9x5KSLal9ZUpeWIYKWWx06r7Cg/o3+fR8=;
        b=RWFwnBL+IE3lIl2fPZmZBSUk7dUgbRIStruE6TRqaHYuwplUzJQ0nj8TjmNWGy191Q
         jHvcjKA2f6Fr9VDyFpTtOypcFeaJAe0p51dXyT3QGHCVBR1XWQNF8goqr+7EeRJT1Y6h
         vJqzQZUkWIgk2xGrouqPVw5lh7BmOnYuoaSFdv9Rjsfn4hAQJzG+evTiCkZK0VCkgUhN
         0XDRdhUK5Ozjni4cSLaAWD+DIC+feM6m3MRrjTMoFhGoNJEgfw9PtumoJzB2xA2Twihi
         g9WMu5iUDDlFMyWvqXY7llWfbYb+dKFiJ1LBX4qMmaLKbWh3etrb45ABepk/Yzru2ZUH
         Z1cQ==
X-Gm-Message-State: APjAAAXLdDhtkzAQtv3mI5ULYAuwC7CACxyUHoJQQy0JpogG9d3Sc+vH
        3Abq0BL6fkL43p2C4g5pnFHVWtY=
X-Google-Smtp-Source: APXvYqx3q9tKd+XZIofazqF6ITdF5rGA7V0mFcXKWLURdS5xiZAnbh15rjVzEzA8aDKoO0vVVSb1q/s=
X-Received: by 2002:a65:480c:: with SMTP id h12mr32478341pgs.266.1556141505949;
 Wed, 24 Apr 2019 14:31:45 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:31:41 -0700
In-Reply-To: <20190424213141.201134-1-sdf@google.com>
Message-Id: <20190424213141.201134-2-sdf@google.com>
Mime-Version: 1.0
References: <20190424213141.201134-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v4 2/2] bpftool: show flow_dissector attachment status
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, quentin.monnet@netronome.com,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Right now there is no way to query whether BPF flow_dissector program
is attached to a network namespace or not. In previous commit, I added
support for querying that info, show it when doing `bpftool net`:

$ bpftool prog loadall ./bpf_flow.o \
	/sys/fs/bpf/flow type flow_dissector \
	pinmaps /sys/fs/bpf/flow
$ bpftool prog
3: flow_dissector  name _dissect  tag 8c9e917b513dd5cc  gpl
        loaded_at 2019-04-23T16:14:48-0700  uid 0
        xlated 656B  jited 461B  memlock 4096B  map_ids 1,2
        btf_id 1
...

$ bpftool net -j
[{"xdp":[],"tc":[],"flow_dissector":[]}]

$ bpftool prog attach pinned \
	/sys/fs/bpf/flow/flow_dissector flow_dissector
$ bpftool net -j
[{"xdp":[],"tc":[],"flow_dissector":["id":3]}]

Doesn't show up in a different net namespace:
$ ip netns add test
$ ip netns exec test bpftool net -j
[{"xdp":[],"tc":[],"flow_dissector":[]}]

Non-json output:
$ bpftool net
xdp:

tc:

flow_dissector:
id 3

v2:
* initialization order (Jakub Kicinski)
* clear errno for batch mode (Quentin Monnet)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/bpf/bpftool/net.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index db0e7de49d49..67e99c56bc88 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -3,6 +3,7 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
+#include <fcntl.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -12,6 +13,8 @@
 #include <linux/rtnetlink.h>
 #include <linux/tc_act/tc_bpf.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 
 #include <bpf.h>
 #include <nlattr.h>
@@ -48,6 +51,10 @@ struct bpf_filter_t {
 	int		ifindex;
 };
 
+struct bpf_attach_info {
+	__u32 flow_dissector_id;
+};
+
 static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_netdev_t *netinfo = cookie;
@@ -180,8 +187,45 @@ static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
 	return 0;
 }
 
+static int query_flow_dissector(struct bpf_attach_info *attach_info)
+{
+	__u32 attach_flags;
+	__u32 prog_ids[1];
+	__u32 prog_cnt;
+	int err;
+	int fd;
+
+	fd = open("/proc/self/ns/net", O_RDONLY);
+	if (fd < 0) {
+		p_err("can't open /proc/self/ns/net: %d",
+		      strerror(errno));
+		return -1;
+	}
+	prog_cnt = ARRAY_SIZE(prog_ids);
+	err = bpf_prog_query(fd, BPF_FLOW_DISSECTOR, 0,
+			     &attach_flags, prog_ids, &prog_cnt);
+	close(fd);
+	if (err) {
+		if (errno == EINVAL) {
+			/* Older kernel's don't support querying
+			 * flow dissector programs.
+			 */
+			errno = 0;
+			return 0;
+		}
+		p_err("can't query prog: %s", strerror(errno));
+		return -1;
+	}
+
+	if (prog_cnt == 1)
+		attach_info->flow_dissector_id = prog_ids[0];
+
+	return 0;
+}
+
 static int do_show(int argc, char **argv)
 {
+	struct bpf_attach_info attach_info = {};
 	int i, sock, ret, filter_idx = -1;
 	struct bpf_netdev_t dev_array;
 	unsigned int nl_pid;
@@ -199,6 +243,10 @@ static int do_show(int argc, char **argv)
 		usage();
 	}
 
+	ret = query_flow_dissector(&attach_info);
+	if (ret)
+		return -1;
+
 	sock = libbpf_netlink_open(&nl_pid);
 	if (sock < 0) {
 		fprintf(stderr, "failed to open netlink sock\n");
@@ -227,6 +275,12 @@ static int do_show(int argc, char **argv)
 		}
 		NET_END_ARRAY("\n");
 	}
+
+	NET_START_ARRAY("flow_dissector", "%s:\n");
+	if (attach_info.flow_dissector_id > 0)
+		NET_DUMP_UINT("id", "id %u", attach_info.flow_dissector_id);
+	NET_END_ARRAY("\n");
+
 	NET_END_OBJECT;
 	if (json_output)
 		jsonw_end_array(json_wtr);
-- 
2.21.0.593.g511ec345e18-goog

