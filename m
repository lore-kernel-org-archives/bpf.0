Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B9C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16AB206C0
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua9Gexce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfDYVhb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:37:31 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:43403 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfDYVha (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 17:37:30 -0400
Received: by mail-ot1-f74.google.com with SMTP id q23so661155otk.10
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I2JTfqrC8u8PvvtvlU3SwuCWT5zC0tVBoJ8XxBMMeTM=;
        b=Ua9GexceU0NU1w3TH7N6Hk0+DAb5EWteOGztE9Sba6FLw5JYgL/WfMPV+Gul7u4eLQ
         1oyW3p5lGMmlQi7jqxY27pbkoTp1zIi2yftalCq4jYxGEMqDetF9z8n8ByKMbPq8gwzj
         5VzqcbeyVxaK+E3KU2yZGBJCkIQ5PEoVZ5Sd9yEVef2Lece+wPjab0KmbGqThnWRFQp2
         QbxN5tUVCmh0yhXtFpJwISCAQBTVEOM+6qMcKOqjP6Y68BZ5yEvgeL387Dx9pn4Dzmkd
         6NfJeL9SrLeSxIKr/JhSl+9LgqMirecForrkccBbyo/DNcH19mWJJtg3lvQ0WFAZfjKo
         IbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I2JTfqrC8u8PvvtvlU3SwuCWT5zC0tVBoJ8XxBMMeTM=;
        b=HQElJ/1Ys6qYxCClMd83oVz68TOzQP+0k3tdo5B02wLG5Kn0H8fnlZsiSnDq6LwVKl
         Fg8lpifwdwNEFuqZqdbMtPRhHAtREkDa4Nk1xqnbGLRW79NL/X0JSDZKGN7oPrz3yuT8
         caCAZTeg2DvIczpbjAoCUvmdi+O4HCDjKmI60XyGocbtmThjHRZupHHmCiL3A+k6iCuh
         FGOzQtklRvXmaK1FqKXaxs73Rwj8yNvsYYAXs8L6nTlV1tbqVqlyciJTNNAYRwBJDS5R
         +9YjQlxkOU1vSJLTQ8lEyNhMCqFlyINJaOkClkIV2Xk6I052qMp/ZldH4lRsFdWw6Bxd
         IUJw==
X-Gm-Message-State: APjAAAW19TG3cY6OJQenxLZefAnhyCF5joNe/d2D9sDh6ek8a8zaJRgA
        KBXNGa8CcGzX/ct23C6CnezazqU=
X-Google-Smtp-Source: APXvYqxT9/FliOL4MJ72uBvutaw4oZyJMBVzmtmHF7JpNWEde9fLj9IKHUvqGrcJRk11iD+QQ8eSzXg=
X-Received: by 2002:aca:564e:: with SMTP id k75mr5009183oib.54.1556228249534;
 Thu, 25 Apr 2019 14:37:29 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:37:24 -0700
In-Reply-To: <20190425213724.25056-1-sdf@google.com>
Message-Id: <20190425213724.25056-2-sdf@google.com>
Mime-Version: 1.0
References: <20190425213724.25056-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v5 2/2] bpftool: show flow_dissector attachment status
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
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
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
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

