Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD9CC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF020828
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NJ6GIxjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCSKVl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36553 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCSKVj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so15859560wrd.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oG6SluiBJUS9pszWht8Z8gDKRDaGfKFt6iY687sDJm8=;
        b=NJ6GIxjIRTdE/zA7Qrr/2sHqLbXC6hGxZNRuPIKnhDfk/ZvWWzRE7Zs9sQa8C26344
         Yw4lpB6qgAV+rHJ6UQGGrnBx7rfKf9sBg+nQG7XCVF3Z7pcm9HtJBdi60aZx5Je1AW6g
         h3PA5QbyClxy4Nlyei8+fjnqPCWG6+mCGwyV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oG6SluiBJUS9pszWht8Z8gDKRDaGfKFt6iY687sDJm8=;
        b=j6dtPaXLTJW5cjqP4PvNtJ5XFI9Sgs363/U43kHf4BE0+1cbA6a12+bYmGTq5T4dn5
         xinpxEZ4zje0dEHekr9KNmOkM/uy1A27+qk0FD9/VOlIiupkJ6RSl4Orbj4QXxrjehCi
         /1qgWCxDDNvDYaRO3rFlCyoFG8ZZLlnB0AAPbTQyJjxL834a/IN3wClIKk5qpRvG8dlv
         aoQ0uIu0K+icu2nCRpw3sJs3r+j+pd+g+tolU5WJfSBvwAfzeqMKiKZUA2g12DW/417Z
         4YVOopN61fjSB8rjzustk8URY8PkjoqENO5t7G9ti+hhxoEBGzP4Zb6yFJ/LwuisGfRd
         snLA==
X-Gm-Message-State: APjAAAX1AL/wDSy0z4enFgV+9xfOyhW4aS5Y256+1POIvVzxOJM0iS7I
        lEY6TSLf1CvGxRq+4Bvhc93TDg==
X-Google-Smtp-Source: APXvYqwawpU1cCaFxqWFqxw8hktCXsjY/MEpRCBcKDttcNk82UpGTBDAhGvovwzDQXBH9+sOCCA1eA==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr15443383wrs.157.1552990895967;
        Tue, 19 Mar 2019 03:21:35 -0700 (PDT)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id q2sm27895781wrd.46.2019.03.19.03.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:35 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 8/8] selftests/bpf: add tests for bpf_tcp_check_syncookie and bpf_skc_lookup_tcp
Date:   Tue, 19 Mar 2019 10:21:03 +0000
Message-Id: <20190319102103.7380-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190319102103.7380-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190319102103.7380-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests which verify that the new helpers work for both IPv4 and
IPv6, by forcing SYN cookies to always on. Use a new network namespace
to avoid clobbering the global SYN cookie settings.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   8 +
 .../bpf/progs/test_tcp_check_syncookie_kern.c | 126 +++++++++++
 .../selftests/bpf/test_tcp_check_syncookie.sh |  81 +++++++
 .../bpf/test_tcp_check_syncookie_user.c       | 212 ++++++++++++++++++
 6 files changed, 431 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
 create mode 100644 tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 3b74d23fffab..41e8a689aa77 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -30,4 +30,5 @@ test_netcnt
 test_section_names
 test_tcpnotify_user
 test_libbpf
+test_tcp_check_syncookie_user
 alu32
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 518cd587cd63..ae60cb29f39d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -51,7 +51,8 @@ TEST_PROGS := test_kmod.sh \
 	test_skb_cgroup_id.sh \
 	test_flow_dissector.sh \
 	test_xdp_vlan.sh \
-	test_lwt_ip_encap.sh
+	test_lwt_ip_encap.sh \
+	test_tcp_check_syncookie.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
@@ -60,7 +61,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_libbpf_open test_sock_addr test_skb_cgroup_id_user \
-	flow_dissector_load test_flow_dissector
+	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index c81fc350f7ad..0b38562786a1 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -159,6 +159,11 @@ static struct bpf_sock *(*bpf_sk_lookup_tcp)(void *ctx,
 					     int size, unsigned long long netns_id,
 					     unsigned long long flags) =
 	(void *) BPF_FUNC_sk_lookup_tcp;
+static struct bpf_sock *(*bpf_skc_lookup_tcp)(void *ctx,
+					     struct bpf_sock_tuple *tuple,
+					     int size, unsigned long long netns_id,
+					     unsigned long long flags) =
+	(void *) BPF_FUNC_skc_lookup_tcp;
 static struct bpf_sock *(*bpf_sk_lookup_udp)(void *ctx,
 					     struct bpf_sock_tuple *tuple,
 					     int size, unsigned long long netns_id,
@@ -184,6 +189,9 @@ static struct bpf_sock *(*bpf_get_listener_sock)(struct bpf_sock *sk) =
 	(void *) BPF_FUNC_get_listener_sock;
 static int (*bpf_skb_ecn_set_ce)(void *ctx) =
 	(void *) BPF_FUNC_skb_ecn_set_ce;
+static int (*bpf_tcp_check_syncookie)(struct bpf_sock *sk,
+	    void *ip, int ip_len, void *tcp, int tcp_len) =
+	(void *) BPF_FUNC_tcp_check_syncookie;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
new file mode 100644
index 000000000000..da3bdb22d99d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Facebook
+// Copyright (c) 2019 Cloudflare
+
+#include <string.h>
+
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <sys/socket.h>
+#include <linux/tcp.h>
+
+#include "bpf_helpers.h"
+#include "bpf_endian.h"
+
+struct bpf_map_def SEC("maps") results = {
+	.type = BPF_MAP_TYPE_ARRAY,
+	.key_size = sizeof(__u32),
+	.value_size = sizeof(__u64),
+	.max_entries = 1,
+};
+
+static __always_inline void check_syncookie(void *ctx, void *data,
+					    void *data_end)
+{
+	struct bpf_sock_tuple tup;
+	struct bpf_sock *sk;
+	struct ethhdr *ethh;
+	struct iphdr *ipv4h;
+	struct ipv6hdr *ipv6h;
+	struct tcphdr *tcph;
+	int ret;
+	__u32 key = 0;
+	__u64 value = 1;
+
+	ethh = data;
+	if (ethh + 1 > data_end)
+		return;
+
+	switch (bpf_ntohs(ethh->h_proto)) {
+	case ETH_P_IP:
+		ipv4h = data + sizeof(struct ethhdr);
+		if (ipv4h + 1 > data_end)
+			return;
+
+		tcph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);
+		if (tcph + 1 > data_end)
+			return;
+
+		tup.ipv4.saddr = ipv4h->saddr;
+		tup.ipv4.daddr = ipv4h->daddr;
+		tup.ipv4.sport = tcph->source;
+		tup.ipv4.dport = tcph->dest;
+
+		sk = bpf_skc_lookup_tcp(ctx, &tup, sizeof(tup.ipv4),
+					BPF_F_CURRENT_NETNS, 0);
+		if (!sk)
+			return;
+
+		if (sk->state != BPF_TCP_LISTEN)
+			goto release;
+
+		ret = bpf_tcp_check_syncookie(sk, ipv4h, sizeof(*ipv4h),
+					      tcph, sizeof(*tcph));
+		break;
+
+	case ETH_P_IPV6:
+		ipv6h = data + sizeof(struct ethhdr);
+		if (ipv6h + 1 > data_end)
+			return;
+
+		if (ipv6h->nexthdr != IPPROTO_TCP)
+			return;
+
+		tcph = data + sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
+		if (tcph + 1 > data_end)
+			return;
+
+		memcpy(tup.ipv6.saddr, &ipv6h->saddr, sizeof(tup.ipv6.saddr));
+		memcpy(tup.ipv6.daddr, &ipv6h->daddr, sizeof(tup.ipv6.daddr));
+		tup.ipv6.sport = tcph->source;
+		tup.ipv6.dport = tcph->dest;
+
+		sk = bpf_skc_lookup_tcp(ctx, &tup, sizeof(tup.ipv6),
+					BPF_F_CURRENT_NETNS, 0);
+		if (!sk)
+			return;
+
+		if (sk->state != BPF_TCP_LISTEN)
+			goto release;
+
+		ret = bpf_tcp_check_syncookie(sk, ipv6h, sizeof(*ipv6h),
+					      tcph, sizeof(*tcph));
+		break;
+
+	default:
+		return;
+	}
+
+	if (ret == 0)
+		bpf_map_update_elem(&results, &key, &value, 0);
+
+release:
+	bpf_sk_release(sk);
+}
+
+SEC("clsact/check_syncookie")
+int check_syncookie_clsact(struct __sk_buff *skb)
+{
+	check_syncookie(skb, (void *)(long)skb->data,
+			(void *)(long)skb->data_end);
+	return TC_ACT_OK;
+}
+
+SEC("xdp/check_syncookie")
+int check_syncookie_xdp(struct xdp_md *ctx)
+{
+	check_syncookie(ctx, (void *)(long)ctx->data,
+			(void *)(long)ctx->data_end);
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
new file mode 100755
index 000000000000..d48e51716d19
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Facebook
+# Copyright (c) 2019 Cloudflare
+
+set -eu
+
+wait_for_ip()
+{
+	local _i
+	printf "Wait for IP %s to become available " "$1"
+	for _i in $(seq ${MAX_PING_TRIES}); do
+		printf "."
+		if ns1_exec ping -c 1 -W 1 "$1" >/dev/null 2>&1; then
+			echo " OK"
+			return
+		fi
+		sleep 1
+	done
+	echo 1>&2 "ERROR: Timeout waiting for test IP to become available."
+	exit 1
+}
+
+get_prog_id()
+{
+	awk '/ id / {sub(/.* id /, "", $0); print($1)}'
+}
+
+ns1_exec()
+{
+	ip netns exec ns1 "$@"
+}
+
+setup()
+{
+	ip netns add ns1
+	ns1_exec ip link set lo up
+
+	ns1_exec sysctl -w net.ipv4.tcp_syncookies=2
+
+	wait_for_ip 127.0.0.1
+	wait_for_ip ::1
+}
+
+cleanup()
+{
+	ip netns del ns1 2>/dev/null || :
+}
+
+main()
+{
+	trap cleanup EXIT 2 3 6 15
+	setup
+
+	printf "Testing clsact..."
+	ns1_exec tc qdisc add dev "${TEST_IF}" clsact
+	ns1_exec tc filter add dev "${TEST_IF}" ingress \
+		bpf obj "${BPF_PROG_OBJ}" sec "${CLSACT_SECTION}" da
+
+	BPF_PROG_ID=$(ns1_exec tc filter show dev "${TEST_IF}" ingress | \
+		      get_prog_id)
+	ns1_exec "${PROG}" "${BPF_PROG_ID}"
+	ns1_exec tc qdisc del dev "${TEST_IF}" clsact
+
+	printf "Testing XDP..."
+	ns1_exec ip link set "${TEST_IF}" xdp \
+		object "${BPF_PROG_OBJ}" section "${XDP_SECTION}"
+	BPF_PROG_ID=$(ns1_exec ip link show "${TEST_IF}" | get_prog_id)
+	ns1_exec "${PROG}" "${BPF_PROG_ID}"
+}
+
+DIR=$(dirname $0)
+TEST_IF=lo
+MAX_PING_TRIES=5
+BPF_PROG_OBJ="${DIR}/test_tcp_check_syncookie_kern.o"
+CLSACT_SECTION="clsact/check_syncookie"
+XDP_SECTION="xdp/check_syncookie"
+BPF_PROG_ID=0
+PROG="${DIR}/test_tcp_check_syncookie_user"
+
+main
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
new file mode 100644
index 000000000000..87829c86c746
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Facebook
+// Copyright (c) 2019 Cloudflare
+
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "bpf_rlimit.h"
+#include "cgroup_helpers.h"
+
+static int start_server(const struct sockaddr *addr, socklen_t len)
+{
+	int fd;
+
+	fd = socket(addr->sa_family, SOCK_STREAM, 0);
+	if (fd == -1) {
+		log_err("Failed to create server socket");
+		goto out;
+	}
+
+	if (bind(fd, addr, len) == -1) {
+		log_err("Failed to bind server socket");
+		goto close_out;
+	}
+
+	if (listen(fd, 128) == -1) {
+		log_err("Failed to listen on server socket");
+		goto close_out;
+	}
+
+	goto out;
+
+close_out:
+	close(fd);
+	fd = -1;
+out:
+	return fd;
+}
+
+static int connect_to_server(int server_fd)
+{
+	struct sockaddr_storage addr;
+	socklen_t len = sizeof(addr);
+	int fd = -1;
+
+	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
+		log_err("Failed to get server addr");
+		goto out;
+	}
+
+	fd = socket(addr.ss_family, SOCK_STREAM, 0);
+	if (fd == -1) {
+		log_err("Failed to create client socket");
+		goto out;
+	}
+
+	if (connect(fd, (const struct sockaddr *)&addr, len) == -1) {
+		log_err("Fail to connect to server");
+		goto close_out;
+	}
+
+	goto out;
+
+close_out:
+	close(fd);
+	fd = -1;
+out:
+	return fd;
+}
+
+static int get_map_fd_by_prog_id(int prog_id)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 map_ids[1];
+	int prog_fd = -1;
+	int map_fd = -1;
+
+	prog_fd = bpf_prog_get_fd_by_id(prog_id);
+	if (prog_fd < 0) {
+		log_err("Failed to get fd by prog id %d", prog_id);
+		goto err;
+	}
+
+	info.nr_map_ids = 1;
+	info.map_ids = (__u64)(unsigned long)map_ids;
+
+	if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len)) {
+		log_err("Failed to get info by prog fd %d", prog_fd);
+		goto err;
+	}
+
+	if (!info.nr_map_ids) {
+		log_err("No maps found for prog fd %d", prog_fd);
+		goto err;
+	}
+
+	map_fd = bpf_map_get_fd_by_id(map_ids[0]);
+	if (map_fd < 0)
+		log_err("Failed to get fd by map id %d", map_ids[0]);
+err:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	return map_fd;
+}
+
+static int run_test(int server_fd, int results_fd)
+{
+	int client = -1, srv_client = -1;
+	int ret = 0;
+	__u32 key = 0;
+	__u64 value = 0;
+
+	if (bpf_map_update_elem(results_fd, &key, &value, 0) < 0) {
+		log_err("Can't clear results");
+		goto err;
+	}
+
+	client = connect_to_server(server_fd);
+	if (client == -1)
+		goto err;
+
+	srv_client = accept(server_fd, NULL, 0);
+	if (srv_client == -1) {
+		log_err("Can't accept connection");
+		goto err;
+	}
+
+	if (bpf_map_lookup_elem(results_fd, &key, &value) < 0) {
+		log_err("Can't lookup result");
+		goto err;
+	}
+
+	if (value != 1) {
+		log_err("Didn't match syncookie: %llu", value);
+		goto err;
+	}
+
+	goto out;
+
+err:
+	ret = 1;
+out:
+	close(client);
+	close(srv_client);
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	struct sockaddr_in addr4;
+	struct sockaddr_in6 addr6;
+	int server = -1;
+	int server_v6 = -1;
+	int results = -1;
+	int err = 0;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s prog_id\n", argv[0]);
+		exit(1);
+	}
+
+	results = get_map_fd_by_prog_id(atoi(argv[1]));
+	if (results < 0) {
+		log_err("Can't get map");
+		goto err;
+	}
+
+	memset(&addr4, 0, sizeof(addr4));
+	addr4.sin_family = AF_INET;
+	addr4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr4.sin_port = 0;
+
+	memset(&addr6, 0, sizeof(addr6));
+	addr6.sin6_family = AF_INET6;
+	addr6.sin6_addr = in6addr_loopback;
+	addr6.sin6_port = 0;
+
+	server = start_server((const struct sockaddr *)&addr4, sizeof(addr4));
+	if (server == -1)
+		goto err;
+
+	server_v6 = start_server((const struct sockaddr *)&addr6,
+				 sizeof(addr6));
+	if (server_v6 == -1)
+		goto err;
+
+	if (run_test(server, results))
+		goto err;
+
+	if (run_test(server_v6, results))
+		goto err;
+
+	printf("ok\n");
+	goto out;
+err:
+	err = 1;
+out:
+	close(server);
+	close(server_v6);
+	close(results);
+	return err;
+}
-- 
2.19.1

