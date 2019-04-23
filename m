Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EB9C282DD
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E7F218DA
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNKXgsx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfDWXWG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:06 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52851 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfDWXWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 19:22:05 -0400
Received: by mail-pl1-f201.google.com with SMTP id 63so6005877plf.19
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CfLjLPqMMv8f7m/5W4q5BVGKdkP730sEZtPAnOlkG8w=;
        b=KNKXgsx/QUVm24cqKH/d1FKD3KhXAMN1E6PcfMUtze4MiDXXrknWpskrDH8vB5RCsj
         7cJ6V4PFAWfnyPrRqGHHxR59f9EZjqLl1ocELKlgyIKvBhk8gitbtBW3mzR5aQrfiNwp
         CwpLUOHZtaQcXMqKc2DdktrTPoiQdVHz3IrQ+68/ksPm315ZMfIp/I5C9jE7sKIi5BQX
         S6cCVqOS6LVZZyrXeMmvBWs6Wl43MCIJrhmBzCGSpPq+5iXPJuHzvoAGN9ciufmVSydh
         OIn/gcCxNzcQAS9uIOLDLqxrR3yjBrdF5FYxWkXt166GzJnf+GIxPd4M0VNT/B5w68YW
         cWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CfLjLPqMMv8f7m/5W4q5BVGKdkP730sEZtPAnOlkG8w=;
        b=HZIPmIx8DOBajY+aYuYDgLO8jnkogu+9huHkUZwugrQzqGQgThBwMbDO86uZphIyHB
         UhiFxF0u++I5Cx6w7uMqOno1mLpO8OBpf5NzW796SDRmU794pLaX4ma9zmfrCZ06K2Ix
         tR3LD1+i6ZwyVu3zIHx3HJKhPGpoaslbh/8YZ4dtigdGpgLkp1B+CrPWO/e2u8HEL3d/
         BVg5YXKw52raNtPb6uHDc0/0mThMiM2uolLj9B+xpWICqvKwx4PFW6evEKgqOL6jxYQV
         KIV/f8+PEPlQvrfnJ1pAio35OsBLo3E7Dg8AslCnnAfM9O1N4s5SSeK/KK6IzOD7Z9kj
         6aHg==
X-Gm-Message-State: APjAAAWy5Ob8ViAuKbhnDG8b9an1aaLfgNbOCnzw/B0wkxSfq2TJS8wK
        ub9YM5Lk3ZEF1N4evDoBBnSMq0U=
X-Google-Smtp-Source: APXvYqzTiJ0mrQXKBZ980+xyn6pG7i27xUwr29Gr1syMJbZW4j6jaxLGB85uWZ49huF5HQGhV1Du4wU=
X-Received: by 2002:a63:d107:: with SMTP id k7mr1918284pgg.116.1556061724585;
 Tue, 23 Apr 2019 16:22:04 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:22:00 -0700
In-Reply-To: <20190423232200.101627-1-sdf@google.com>
Message-Id: <20190423232200.101627-2-sdf@google.com>
Mime-Version: 1.0
References: <20190423232200.101627-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next 2/2] bpftool: show flow_dissector attachment status
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

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/net.c | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index db0e7de49d49..afe0903201e2 100644
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
@@ -180,8 +187,43 @@ static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
 	return 0;
 }
 
+static int query_flow_dissector(struct bpf_attach_info *attach_info)
+{
+	__u32 prog_ids[1] = {0};
+	__u32 prog_cnt = ARRAY_SIZE(prog_ids);
+	__u32 attach_flags;
+	int fd;
+	int err;
+
+	fd = open("/proc/self/ns/net", O_RDONLY);
+	if (fd < 0) {
+		p_err("can't open /proc/self/ns/net: %d",
+		      strerror(errno));
+		return -1;
+	}
+	err = bpf_prog_query(fd, BPF_FLOW_DISSECTOR, 0,
+			     &attach_flags, prog_ids, &prog_cnt);
+	close(fd);
+	if (err) {
+		if (errno == EINVAL) {
+			/* Older kernel's don't support querying
+			 * flow dissector programs.
+			 */
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
@@ -199,6 +241,10 @@ static int do_show(int argc, char **argv)
 		usage();
 	}
 
+	ret = query_flow_dissector(&attach_info);
+	if (ret)
+		return -1;
+
 	sock = libbpf_netlink_open(&nl_pid);
 	if (sock < 0) {
 		fprintf(stderr, "failed to open netlink sock\n");
@@ -227,6 +273,12 @@ static int do_show(int argc, char **argv)
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

