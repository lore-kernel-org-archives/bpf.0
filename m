Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F907C4360F
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E4920840
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sI8vLvep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfCBDmb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:42:31 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:37169 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCBDmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:42:31 -0500
Received: by mail-oi1-f201.google.com with SMTP id f125so11583052oib.4
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=65Oug4yBrXv7xtan+Fd1eu4/QXGWWHHv0PgD5WObTac=;
        b=sI8vLvepk9hkUYGgSl8cImRd3AuKK49hzkJEIRIMvFXQH8Kb2f6DJapbO23SPIf/oJ
         upTF+9LETdu4TKiqc7cEJplLCvIkp326kfoa4AVRdG//R0zeKCGn3bI8pfTopRCgAJmY
         TCceBYqNUCptV7ufFfB59CJvK6PRxFw+/Qn07KCiR5SrIWgQp/BNmgH0XGlGb5S4SCuy
         O92xDU56kxchz0CavFQa+/srhzl9pMfCwkxb1h0PQuyScBcZ7pv1aQ1zqIMj36lkVizY
         T4teUxYdZIdCoobTQwb5eL3gxfvKV0mgFpvkaykacjyRLnQvegExjsP7QFUimhhFFbkl
         /HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=65Oug4yBrXv7xtan+Fd1eu4/QXGWWHHv0PgD5WObTac=;
        b=SknPnOg6LTUxij095xfb5haN1BlIuaHGiNfbjh4bo+QYHWfMmstK+TlLWGvmecK6mJ
         L8ukYl4hl+Xw/iLnpMB+Z5XCskaPE+La72phZb8vW973YkkETZlg3wLTkUCjueiy3e0l
         5Et6tsDzpqThDXQ35gyr8WmKhQ6+KAxrNxH8bCwHnR2o0ZXaNGwWXAzNFZd0zIaJ/T+4
         OoYIbkncdznppENA6iVPrqvF9PPq12fl0Ir87JTG93pPSXekaE4IQf5cwX/YIaKlGg/n
         MMy449nRtu1o5i0bjabBmeyoJ2KSOQT8nWMStZpy129m17YFUNPiY8KUC9gGvSytGt/g
         9HXQ==
X-Gm-Message-State: APjAAAVmAnes1VmrdvTUX0ZphYqedDDzCgPRaKOdOZU3GU0p9FYGi0Nc
        Px3VqvLr694dSon0vBF1GoM+80E=
X-Google-Smtp-Source: APXvYqyxp6KEr2ofdo+N9IUbOR6ZUWuuJaYvohPkjUbaihJx5ZXsBxW2VdnzJKr4Kv0DBP1u5AjJo5U=
X-Received: by 2002:a9d:19d1:: with SMTP id k75mr4837544otk.49.1551498150510;
 Fri, 01 Mar 2019 19:42:30 -0800 (PST)
Date:   Fri,  1 Mar 2019 19:42:15 -0800
In-Reply-To: <20190302034219.99480-1-sdf@google.com>
Message-Id: <20190302034219.99480-4-sdf@google.com>
Mime-Version: 1.0
References: <20190302034219.99480-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf-next v3 3/7] selftests: bpf: break up test_progs - xdp
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
index 4f5709615749..1f48bf400c66 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -87,85 +87,6 @@ static void test_prog_run_xattr(void)
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
@@ -254,86 +175,6 @@ static void test_l4lb_all(void)
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
@@ -2047,10 +1888,7 @@ int main(void)
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
index 658efa080fc0..040132877680 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -77,4 +77,8 @@ extern struct ipv6_packet pkt_v6;
 #define CHECK_ATTR(condition, tag, format...) \
 	_CHECK(condition, tag, tattr.duration, format)
 
+#define MAGIC_VAL 0x1234
+#define NUM_ITER 100000
+#define VIP_NUM 5
+
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
-- 
2.21.0.352.gf09ad66450-goog

