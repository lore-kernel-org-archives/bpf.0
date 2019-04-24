Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1565C282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABDC21900
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPcxQxT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfDXQJ6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:09:58 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:55508 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbfDXQJ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 12:09:57 -0400
Received: by mail-ot1-f73.google.com with SMTP id m15so3363052otf.22
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y26YYpJo+j197/H/WL3uSeQSfcjK7Ir/q88rFZ9QbXk=;
        b=jPcxQxT4lLro8gf2p5qPrvFOco4gzcV4BG9z7Z4V/btQ3OMk7CwWOk/k/R7ndqojYG
         T7Nh/x25x4Q/g5u50z/fpPbV9P00Bdun1Fra7JCuUF6JtgquWLHOcNxGjG4Vkc7IUI7I
         9/XlhQDgJ4LhukqhzD4CKYr+Z1ARnGXXKSvd42az4mwPWGN+R53QGb8OeeFNiQuxxkQK
         7E46eteAFOeopbHVu4asvGtx9IkzRPSNsM6Y/0Fci3VuRPEo64Z2QJjFXRWXwrVuT3aM
         sL199LbqHW7Jop2hlBfjl5pS78CQMmqMM9ledoEXUZT9GwuKxI0mgaBdxCm5NB94UrO1
         agUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y26YYpJo+j197/H/WL3uSeQSfcjK7Ir/q88rFZ9QbXk=;
        b=k4kx1ut/OAjq9TbBPdUpegRe/e+ZWwC6m477iMTnmkVGfZ3qjGy/S8ZNdjB3HAFESK
         QEFtnsHlueIzJUqJQxi/SDQRnqOb5RcMlDSssRCwZeWOvbh8z+o0vaFRT/3GBI6Ak19y
         ldbtpAePNoOAIct7/vLNP+3PUooN+e9KvtTyxmyH8izDafyebRmoMgBvLapsGCyoyC6h
         fldFj1veT07CtAY1lSdXBEGA7Of0ag2QWchtuMMVLmL/Gok3Og1fChLt2cKj46wCXwtv
         OPl1Pzi8XTBFrAQS6LYY1KiTHH8Ld2NDIKwBlixk4e+LvDF/hoZGvXzIXliFfwlj9v44
         wTCQ==
X-Gm-Message-State: APjAAAUC2I1lzKDZ7nGIOdABbpLjuWIl+HVgWHQxbn1nfjHL5/G++Q35
        8TpvC6l61ZXIOQRcjYCWE0SlQZc=
X-Google-Smtp-Source: APXvYqx0fNKhCiRiA1c/7VdAK/4ZgvB873H642JnR37aGk6ayMZX1is142qxnNtLjOzF9EuZ5wXIIL4=
X-Received: by 2002:a9d:6b15:: with SMTP id g21mr20815745otp.266.1556122196488;
 Wed, 24 Apr 2019 09:09:56 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:09:51 -0700
In-Reply-To: <20190424160951.45865-1-sdf@google.com>
Message-Id: <20190424160951.45865-2-sdf@google.com>
Mime-Version: 1.0
References: <20190424160951.45865-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v2 2/2] bpftool: show flow_dissector attachment status
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

