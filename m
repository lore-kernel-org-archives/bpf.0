Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C69DC10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2948D218D8
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfQfSC7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfB1XY5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:24:57 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:52873 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbfB1XYz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:24:55 -0500
Received: by mail-io1-f74.google.com with SMTP id s18so17181515ioe.19
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j6h+GwQ2theo5wHt3W6KddG7aVIYxunWGzSUi039IPg=;
        b=vfQfSC7t4u2IEw8WK0Wdo/0pMUpLiqZU9t2cTQlZ2FY8VXLzzfRiW2DUgoSFa2+hqq
         KUTVw8S2wV6hF3N296PGfbiEoqcnnDyCBhL1edzHSvX9AXfCRkacqejs0LMtdJv7wSTg
         uyx869lnZqCsvETF4Al2huJmOsUftNxku523w8VAfJTqbHfmcWqtf/zYtSmGzZBVgEGq
         xGB1OHUZPGe6V3P8CoI67AScdMKkftbc2I5skuL9M6yxsru9Be4RGh/XDAU2L8WDhzLT
         XUmWjPoN7LU3x5+HXfZo2jcSQQ3XY4lBp7iSVWhfS262nkpo1/2dh8vbuRiaHbEzjCSF
         2ZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j6h+GwQ2theo5wHt3W6KddG7aVIYxunWGzSUi039IPg=;
        b=uabMw+h6BNeJNrSnXHnrLxXgRKUao5Cy2FmNR8GX3L2+SlNZex7Xmy+pG8nnBm8dTe
         jqb2s0qhotcINKRpRcBk+Sw/NZmSlCoDndmCFDhK5BNuO5WvVq3B8rimbRzsWM/EwL3n
         tPyHAVDTGQLXhnEzxDxQvE9fxSrpFppuKTt5bcO0tmFWlOfywCnMDg78Ne8XC0O7tFfM
         kTl3hQ1NSGoHrsXEkiCWbv8BWDR6ahIi2klZl8ZYlmJv93TPHxL7Cobfjg7M6TyFxj1T
         2DUxwOTfzZxEle4kzEU/KU5s2Cz6Ncj47Brz/Ng+LYvoQDcUL9JvTRKbZ70n10c6iGwL
         ZDvg==
X-Gm-Message-State: AHQUAuaXfIKh+cF9RzzbmVKdlXzkYBEudAfHhccoV80JxbnM0IDGIULV
        r7QczexEJCrIFW/pAAG842DFn3c=
X-Google-Smtp-Source: AHgI3IZAcOU4hqgESjT4eUTDvGtczLWz+65nUEiPB5v/OjaMnJRussbTMMv0ZgtqZiGCKsGWJs7kZuw=
X-Received: by 2002:a24:37c6:: with SMTP id r189mr1540948itr.13.1551396295138;
 Thu, 28 Feb 2019 15:24:55 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:24:36 -0800
In-Reply-To: <20190228232440.28668-1-sdf@google.com>
Message-Id: <20190228232440.28668-4-sdf@google.com>
Mime-Version: 1.0
References: <20190228232440.28668-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next v2 3/7] selftests: bpf: break up test_progs - xdp
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move xdp prog tests into separate files.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  46 +++++
 .../bpf/prog_tests/xdp_adjust_tail.c          |  31 ++++
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  82 +++++++++
 tools/testing/selftests/bpf/test_progs.c      | 162 ------------------
 tools/testing/selftests/bpf/test_progs.h      |   4 +
 5 files changed, 163 insertions(+), 162 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_noinline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp.c b/tools/testing/selftests/bpf/prog_tests/xdp.c
new file mode 100644
index 000000000000..a74167289545
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_xdp(void)
+{
+	struct vip key4 = {.protocol = 6, .family = AF_INET};
+	struct vip key6 = {.protocol = 6, .family = AF_INET6};
+	struct iptnl_info value4 = {.family = AF_INET};
+	struct iptnl_info value6 = {.family = AF_INET6};
+	const char *file = "./test_xdp.o";
+	struct bpf_object *obj;
+	char buf[128];
+	struct ipv6hdr *iph6 = (void *)buf + sizeof(struct ethhdr);
+	struct iphdr *iph = (void *)buf + sizeof(struct ethhdr);
+	__u32 duration, retval, size;
+	int err, prog_fd, map_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	map_fd = bpf_find_map(__func__, obj, "vip2tnl");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_update_elem(map_fd, &key4, &value4, 0);
+	bpf_map_update_elem(map_fd, &key6, &value6, 0);
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+
+	CHECK(err || retval != XDP_TX || size != 74 ||
+	      iph->protocol != IPPROTO_IPIP, "ipv4",
+	      "err %d errno %d retval %d size %d\n",
+	      err, errno, retval, size);
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != XDP_TX || size != 114 ||
+	      iph6->nexthdr != IPPROTO_IPV6, "ipv6",
+	      "err %d errno %d retval %d size %d\n",
+	      err, errno, retval, size);
+out:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
new file mode 100644
index 000000000000..922aa0a19764
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_xdp_adjust_tail(void)
+{
+	const char *file = "./test_adjust_tail.o";
+	struct bpf_object *obj;
+	char buf[128];
+	__u32 duration, retval, size;
+	int err, prog_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+
+	CHECK(err || retval != XDP_DROP,
+	      "ipv4", "err %d errno %d retval %d size %d\n",
+	      err, errno, retval, size);
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != XDP_TX || size != 54,
+	      "ipv6", "err %d errno %d retval %d size %d\n",
+	      err, errno, retval, size);
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
new file mode 100644
index 000000000000..09e6b46f5515
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_xdp_noinline(void)
+{
+	const char *file = "./test_xdp_noinline.o";
+	unsigned int nr_cpus = bpf_num_possible_cpus();
+	struct vip key = {.protocol = 6};
+	struct vip_meta {
+		__u32 flags;
+		__u32 vip_num;
+	} value = {.vip_num = VIP_NUM};
+	__u32 stats_key = VIP_NUM;
+	struct vip_stats {
+		__u64 bytes;
+		__u64 pkts;
+	} stats[nr_cpus];
+	struct real_definition {
+		union {
+			__be32 dst;
+			__be32 dstv6[4];
+		};
+		__u8 flags;
+	} real_def = {.dst = MAGIC_VAL};
+	__u32 ch_key = 11, real_num = 3;
+	__u32 duration, retval, size;
+	int err, i, prog_fd, map_fd;
+	__u64 bytes = 0, pkts = 0;
+	struct bpf_object *obj;
+	char buf[128];
+	u32 *magic = (u32 *)buf;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	map_fd = bpf_find_map(__func__, obj, "vip_map");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_update_elem(map_fd, &key, &value, 0);
+
+	map_fd = bpf_find_map(__func__, obj, "ch_rings");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_update_elem(map_fd, &ch_key, &real_num, 0);
+
+	map_fd = bpf_find_map(__func__, obj, "reals");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_update_elem(map_fd, &real_num, &real_def, 0);
+
+	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != 1 || size != 54 ||
+	      *magic != MAGIC_VAL, "ipv4",
+	      "err %d errno %d retval %d size %d magic %x\n",
+	      err, errno, retval, size, *magic);
+
+	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v6, sizeof(pkt_v6),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != 1 || size != 74 ||
+	      *magic != MAGIC_VAL, "ipv6",
+	      "err %d errno %d retval %d size %d magic %x\n",
+	      err, errno, retval, size, *magic);
+
+	map_fd = bpf_find_map(__func__, obj, "stats");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_lookup_elem(map_fd, &stats_key, stats);
+	for (i = 0; i < nr_cpus; i++) {
+		bytes += stats[i].bytes;
+		pkts += stats[i].pkts;
+	}
+	if (bytes != MAGIC_BYTES * NUM_ITER * 2 || pkts != NUM_ITER * 2) {
+		error_cnt++;
+		printf("test_xdp_noinline:FAIL:stats %lld %lld\n", bytes, pkts);
+	}
+out:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 91bb5c8a97c9..cdf515dfaeed 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -86,85 +86,6 @@ static void test_prog_run_xattr(void)
 	bpf_object__close(obj);
 }
 
-static void test_xdp(void)
-{
-	struct vip key4 = {.protocol = 6, .family = AF_INET};
-	struct vip key6 = {.protocol = 6, .family = AF_INET6};
-	struct iptnl_info value4 = {.family = AF_INET};
-	struct iptnl_info value6 = {.family = AF_INET6};
-	const char *file = "./test_xdp.o";
-	struct bpf_object *obj;
-	char buf[128];
-	struct ipv6hdr *iph6 = (void *)buf + sizeof(struct ethhdr);
-	struct iphdr *iph = (void *)buf + sizeof(struct ethhdr);
-	__u32 duration, retval, size;
-	int err, prog_fd, map_fd;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	map_fd = bpf_find_map(__func__, obj, "vip2tnl");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_update_elem(map_fd, &key4, &value4, 0);
-	bpf_map_update_elem(map_fd, &key6, &value6, 0);
-
-	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-
-	CHECK(err || retval != XDP_TX || size != 74 ||
-	      iph->protocol != IPPROTO_IPIP, "ipv4",
-	      "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
-
-	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_TX || size != 114 ||
-	      iph6->nexthdr != IPPROTO_IPV6, "ipv6",
-	      "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
-out:
-	bpf_object__close(obj);
-}
-
-static void test_xdp_adjust_tail(void)
-{
-	const char *file = "./test_adjust_tail.o";
-	struct bpf_object *obj;
-	char buf[128];
-	__u32 duration, retval, size;
-	int err, prog_fd;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-
-	CHECK(err || retval != XDP_DROP,
-	      "ipv4", "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
-
-	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_TX || size != 54,
-	      "ipv6", "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
-	bpf_object__close(obj);
-}
-
-
-
-#define MAGIC_VAL 0x1234
-#define NUM_ITER 100000
-#define VIP_NUM 5
-
 static void test_l4lb(const char *file)
 {
 	unsigned int nr_cpus = bpf_num_possible_cpus();
@@ -253,86 +174,6 @@ static void test_l4lb_all(void)
 	test_l4lb(file2);
 }
 
-static void test_xdp_noinline(void)
-{
-	const char *file = "./test_xdp_noinline.o";
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct vip key = {.protocol = 6};
-	struct vip_meta {
-		__u32 flags;
-		__u32 vip_num;
-	} value = {.vip_num = VIP_NUM};
-	__u32 stats_key = VIP_NUM;
-	struct vip_stats {
-		__u64 bytes;
-		__u64 pkts;
-	} stats[nr_cpus];
-	struct real_definition {
-		union {
-			__be32 dst;
-			__be32 dstv6[4];
-		};
-		__u8 flags;
-	} real_def = {.dst = MAGIC_VAL};
-	__u32 ch_key = 11, real_num = 3;
-	__u32 duration, retval, size;
-	int err, i, prog_fd, map_fd;
-	__u64 bytes = 0, pkts = 0;
-	struct bpf_object *obj;
-	char buf[128];
-	u32 *magic = (u32 *)buf;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	map_fd = bpf_find_map(__func__, obj, "vip_map");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_update_elem(map_fd, &key, &value, 0);
-
-	map_fd = bpf_find_map(__func__, obj, "ch_rings");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_update_elem(map_fd, &ch_key, &real_num, 0);
-
-	map_fd = bpf_find_map(__func__, obj, "reals");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_update_elem(map_fd, &real_num, &real_def, 0);
-
-	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval != 1 || size != 54 ||
-	      *magic != MAGIC_VAL, "ipv4",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
-
-	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval != 1 || size != 74 ||
-	      *magic != MAGIC_VAL, "ipv6",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
-
-	map_fd = bpf_find_map(__func__, obj, "stats");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_lookup_elem(map_fd, &stats_key, stats);
-	for (i = 0; i < nr_cpus; i++) {
-		bytes += stats[i].bytes;
-		pkts += stats[i].pkts;
-	}
-	if (bytes != MAGIC_BYTES * NUM_ITER * 2 || pkts != NUM_ITER * 2) {
-		error_cnt++;
-		printf("test_xdp_noinline:FAIL:stats %lld %lld\n", bytes, pkts);
-	}
-out:
-	bpf_object__close(obj);
-}
-
 static void test_tcp_estats(void)
 {
 	const char *file = "./test_tcp_estats.o";
@@ -2046,10 +1887,7 @@ int main(void)
 #include <prog_tests/tests.h>
 #undef CALL
 	test_prog_run_xattr();
-	test_xdp();
-	test_xdp_adjust_tail();
 	test_l4lb_all();
-	test_xdp_noinline();
 	test_tcp_estats();
 	test_bpf_obj_id();
 	test_obj_name();
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 8b79ab3e3042..94e94ae87483 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -78,4 +78,8 @@ extern struct ipv6_packet pkt_v6;
 #define CHECK_ATTR(condition, tag, format...) \
 	_CHECK(condition, tag, tattr.duration, format)
 
+#define MAGIC_VAL 0x1234
+#define NUM_ITER 100000
+#define VIP_NUM 5
+
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

