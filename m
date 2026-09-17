Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BE54488D
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653336; cv=none; b=fG1P6M3cBzdK7ZcZGwjiChiFK91bLfnPLydvQVa639ZHEACSJ0BBf2tc1jux+TF+gmL7ckwTwW5nIgv0+9kg/yOs0nQe0pT4PZ99hJdA1KHSt4Vq2eHDIKb14AS0mW2V/iMWUt/hbIUTwTRK+uqBUD0SJEpZCropusoUwtt3fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653336; c=relaxed/simple;
	bh=S4FzxyY81JBgBK/DLRIngRJoW1IASupe1FVT/ajGqA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cntlLDNV/NrkyutE7rO0RA2y2X2Pn4HNJOBi7GqWQBbfd66PceRQPDStERC+/7JCCcIeTbg0tUhhbPYIyJUCZv+LTlRCzrtubVq0Bfn7uHIT2oCfyNoLe457ppXVA7OBzhpP8X4kaxI0VjM8svA/Rat99IBftzbDxCoPb/M3oro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIzIlhN8; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIzIlhN8"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so501706a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789653320; x=1790258120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0VhkO2QjZLxheCHngNBW2WO8dVcT517aUI84pskcII=;
        b=rIzIlhN8KfAX1ApXkFANWVr1eZCR+AafJDUakqh8Phs9I64BIulTlqXRXkZKlDNTCI
         NCK1JE9nDxvCgy1wk0hAaeJdyXuhejE5gAqC3U0JU/iYE0LtTvlx6PZmG8P9BlJSrqrn
         6VbcfQ5JpiAFfQQ3+bXUadi0W5NH90Y6BBgbKq/VJomyO6d97RVok98SQ2UbnYT1Xj0l
         d80K+gDroUQ6rVPJKiXr7Xk8UqiVRuA6MW58cnk+RM2c3zsogiXnQhYZqv9qJtI1NlER
         2T11J3e1v07KOM30jZD6mDl4mYMx7o74mqTYOYSCzna/DwzO6jEaS4NJBVanpuV/oiwa
         Sd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653320; x=1790258120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0VhkO2QjZLxheCHngNBW2WO8dVcT517aUI84pskcII=;
        b=KWxDvyHdiuEThHsq5IOcSy4VkstkGVWq+h6bapF9BN1qZQzkP+gMwDCU8GfHilnvXF
         GmELfSwkioT+QGE+xGShXkhw70Gno/NUPcBPJtAKsKA5m9+x8votRuanD9v2BdkY/XyX
         4ji+U45oqa1epZXzbS7RQyWBnYVMBUVSEz4JrBSEwH4EjKt6RwzUuDNboMoC36IsHKLE
         +7TEF5JebvC8kiqhDhdgPx96MP6EaFboe6M9CQHzz/963elJn5anHP32nVvVl5vtmXXG
         C3Uhdx6Njn3v9U25JXULIXn8hJ6hx6/6mztmgKwO8gR0R8UQiA/t7AkOiqJUrBbi0+iN
         T6HA==
X-Gm-Message-State: AFuF++lbdKVpnICWDDTlI1mr6m7cUnpb6u4qZt2wAWJvkID4r3Byczxx
	lBpwD6qsXg8txgJxwz8bSHDi+gu9W2AYW83+8Urjka1Wg5zr7PBqChsJmgxsYw==
X-Gm-Gg: AYBFou1xkSlUzgPuYBYX+QeocWXaMYEoEjpEEQKUuiK2yyF+Ud5MJwMhKsD/KLsdLaZ
	rF5F4iL6+xi6eAzjRGeEpsuuJpPn/j2cGNwSlmDcIE+iUUQmvHUL3ra/4O+MLTyf/OrHU55p4RC
	Dr/yKxHzg85+cyIpi2F8jKVtdF2YqRF0+oDxOK74HDYDYv8lZV5U4pmE1jZZZurylUCY29nazhl
	wfmUjI6ikIk2RipJE4E08J2U7Nzm9JdGU8o8IsLn1KxeVe7ghj4WQh4QWiPrA46BgVteqoUv1tZ
	ajPrB33d/lcLf9fS5o47ZXxO2mVAvXBvZX3RdBQ74nwT4AJA/A2i8vljMVz2KmRPc9moNc5X5D3
	iGH9PCONJG+x6qwDCPHfSu8CXX6tZQoRO0qQhu8O3rsebHE3zGRy88Eo8D5qp8OVbqRGn4WpDOa
	sixZGfbs39fjren4wWoFjmTCj7fsl+HYtsMZSohzQY0jmX/cSGFI1jBPMB3MUMNK9dmwInc0vUf
	Z3k2w5H6x8M3cb62W8iET2lNkD5zNAF/9AmimDx8mI2JAwXDbhURHdVXbjAF//JTyeN3RYuzkBI
	zJ4CwIGAeB1JuBK3pGZ4KRGIivotFGninL83Mlorfew=
X-Received: by 2002:a17:90b:2d4f:b0:39e:1b0c:4773 with SMTP id 98e67ed59e1d1-39e1df86c10mr16404067a91.0.1789653319360;
        Thu, 17 Sep 2026 06:55:19 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e360a6c8asm6465850a91.13.2026.09.17.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:55:18 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC bpf-next] selftests/bpf: Test XDP LRU hash rolling-window map updates
Date: Thu, 17 Sep 2026 13:54:33 +0000
Message-Id: <20260917135433.2260048-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_lru_map covers LRU_HASH from syscall helpers only. Existing XDP
selftests parse packets but do not store a modulo-bounded window in a
map value.

Add a small XDP program that writes packet lengths into
BPF_MAP_TYPE_LRU_HASH at seq % AGGREGATION_WINDOW, plus a test_progs
case that uses bpf_prog_test_run to check wrap, parse-fail isolation,
and 5-tuple isolation.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_lru_window.c | 171 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_lru_window.c      |  81 +++++++++
 tools/testing/selftests/bpf/xdp_lru_window.h  |  28 +++
 3 files changed, 280 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/xdp_lru_window.h

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
new file mode 100644
index 000000000..fffbb4a04
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "xdp_lru_window.h"
+#include "xdp_lru_window.skel.h"
+
+#define SRC_IP		0x0a000001
+#define DST_IP		0x0a000002
+#define SRC_PORT	12345
+#define DST_PORT	80
+#define ALT_DST_PORT	81
+
+static struct xdp_lru_window *skel;
+static int prog_fd, map_fd;
+
+static void fill_pkt(struct ipv4_packet *pkt, __u16 dport)
+{
+	*pkt = pkt_v4;
+	pkt->iph.saddr = htonl(SRC_IP);
+	pkt->iph.daddr = htonl(DST_IP);
+	pkt->tcp.source = htons(SRC_PORT);
+	pkt->tcp.dest = htons(dport);
+}
+
+static void fill_key(struct xdp_lru_window_key *key, __u16 dport)
+{
+	memset(key, 0, sizeof(*key));
+	key->saddr = htonl(SRC_IP);
+	key->daddr = htonl(DST_IP);
+	key->sport = htons(SRC_PORT);
+	key->dport = htons(dport);
+	key->proto = IPPROTO_TCP;
+}
+
+static int run_pkt(const void *data, __u32 len, int *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = data,
+		    .data_size_in = len,
+		    .repeat = 1,
+	);
+	int err;
+
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		return err;
+	if (retval)
+		*retval = opts.retval;
+	return 0;
+}
+
+static int inject(int n, __u16 dport)
+{
+	struct ipv4_packet pkt;
+	int i, retval;
+
+	fill_pkt(&pkt, dport);
+	for (i = 0; i < n; i++) {
+		if (run_pkt(&pkt, sizeof(pkt), &retval))
+			return -1;
+		if (!ASSERT_EQ(retval, XDP_PASS, "retval"))
+			return -1;
+	}
+	return 0;
+}
+
+static void reset_map(void)
+{
+	struct xdp_lru_window_key key, next;
+	int err;
+
+	err = bpf_map_get_next_key(map_fd, NULL, &next);
+	while (!err) {
+		key = next;
+		err = bpf_map_get_next_key(map_fd, &key, &next);
+		bpf_map_delete_elem(map_fd, &key);
+	}
+}
+
+static void test_one_and_wrap(void)
+{
+	struct xdp_lru_window_state st;
+	struct xdp_lru_window_key key;
+	int i, n;
+
+	reset_map();
+	if (inject(1, DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup"))
+		return;
+	ASSERT_EQ(st.seq, 1, "seq");
+	ASSERT_EQ(st.pkt_len[0], sizeof(struct ipv4_packet), "len0");
+
+	n = AGGREGATION_WINDOW + 5;
+	if (inject(n - 1, DST_PORT))
+		return;
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup wrap"))
+		return;
+	ASSERT_EQ(st.seq, n, "seq wrap");
+	for (i = 0; i < AGGREGATION_WINDOW; i++)
+		ASSERT_EQ(st.pkt_len[i], sizeof(struct ipv4_packet), "slot");
+}
+
+static void test_trunc(void)
+{
+	struct xdp_lru_window_state before, after;
+	struct xdp_lru_window_key key, next;
+	unsigned char short_pkt[sizeof(struct ethhdr)] = {};
+	int err, retval;
+
+	reset_map();
+	err = run_pkt(short_pkt, sizeof(short_pkt), &retval);
+	if (err)
+		return;
+	ASSERT_EQ(retval, XDP_PASS, "trunc retval");
+	err = bpf_map_get_next_key(map_fd, NULL, &next);
+	ASSERT_EQ(err, -ENOENT, "trunc no insert");
+
+	if (inject(1, DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &before), "setup"))
+		return;
+	if (run_pkt(short_pkt, sizeof(short_pkt), &retval))
+		return;
+	ASSERT_EQ(retval, XDP_PASS, "trunc2 retval");
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &after), "after"))
+		return;
+	ASSERT_EQ(after.seq, before.seq, "trunc no mutate");
+}
+
+static void test_isolate(void)
+{
+	struct xdp_lru_window_state a, b;
+	struct xdp_lru_window_key key;
+
+	reset_map();
+	if (inject(2, DST_PORT) || inject(1, ALT_DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &a), "flow a"))
+		return;
+	fill_key(&key, ALT_DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &b), "flow b"))
+		return;
+	ASSERT_EQ(a.seq, 2, "seq a");
+	ASSERT_EQ(b.seq, 1, "seq b");
+}
+
+void test_xdp_lru_window(void)
+{
+	skel = xdp_lru_window__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_lru_window);
+	map_fd = bpf_map__fd(skel->maps.flow_table);
+	if (!ASSERT_GE(prog_fd, 0, "prog_fd") ||
+	    !ASSERT_GE(map_fd, 0, "map_fd"))
+		goto out;
+
+	if (test__start_subtest("wrap"))
+		test_one_and_wrap();
+	if (test__start_subtest("trunc"))
+		test_trunc();
+	if (test__start_subtest("isolate"))
+		test_isolate();
+out:
+	xdp_lru_window__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_lru_window.c b/tools/testing/selftests/bpf/progs/xdp_lru_window.c
new file mode 100644
index 000000000..27aa1509e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_lru_window.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "xdp_lru_window.h"
+
+#ifndef ETH_P_IP
+#define ETH_P_IP	0x0800
+#endif
+
+#ifndef EEXIST
+#define EEXIST		17
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, XDP_LRU_WINDOW_FLOWS);
+	__type(key, struct xdp_lru_window_key);
+	__type(value, struct xdp_lru_window_state);
+} flow_table SEC(".maps");
+
+SEC("xdp")
+int xdp_lru_window(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct xdp_lru_window_state init, *st;
+	struct xdp_lru_window_key key;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct tcphdr *th;
+	__u32 idx, pkt_len;
+	int err;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return XDP_PASS;
+	if (eth->h_proto != bpf_htons(ETH_P_IP))
+		return XDP_PASS;
+
+	iph = (void *)(eth + 1);
+	if ((void *)(iph + 1) > data_end)
+		return XDP_PASS;
+	if (iph->protocol != IPPROTO_TCP)
+		return XDP_PASS;
+
+	th = (void *)(iph + 1);
+	if ((void *)(th + 1) > data_end)
+		return XDP_PASS;
+
+	__builtin_memset(&key, 0, sizeof(key));
+	key.saddr = iph->saddr;
+	key.daddr = iph->daddr;
+	key.sport = th->source;
+	key.dport = th->dest;
+	key.proto = iph->protocol;
+	pkt_len = data_end - data;
+
+	st = bpf_map_lookup_elem(&flow_table, &key);
+	if (!st) {
+		__builtin_memset(&init, 0, sizeof(init));
+		err = bpf_map_update_elem(&flow_table, &key, &init,
+					  BPF_NOEXIST);
+		if (err && err != -EEXIST)
+			return XDP_PASS;
+		st = bpf_map_lookup_elem(&flow_table, &key);
+		if (!st)
+			return XDP_PASS;
+	}
+
+	idx = st->seq % AGGREGATION_WINDOW;
+	barrier_var(idx);
+	if (idx >= AGGREGATION_WINDOW)
+		return XDP_PASS;
+
+	st->pkt_len[idx] = pkt_len;
+	st->seq++;
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_lru_window.h b/tools/testing/selftests/bpf/xdp_lru_window.h
new file mode 100644
index 000000000..78434045c
--- /dev/null
+++ b/tools/testing/selftests/bpf/xdp_lru_window.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __XDP_LRU_WINDOW_H
+#define __XDP_LRU_WINDOW_H
+
+/*
+ * ABI for the XDP LRU rolling-window selftest. Existing test_lru_map
+ * coverage never enters XDP; XDP parse tests do not store a modulo
+ * index into an LRU map value.
+ */
+
+#define AGGREGATION_WINDOW	50
+#define XDP_LRU_WINDOW_FLOWS	64
+
+struct xdp_lru_window_key {
+	__be32	saddr;
+	__be32	daddr;
+	__be16	sport;
+	__be16	dport;
+	__u8	proto;
+	__u8	pad[3];
+};
+
+struct xdp_lru_window_state {
+	__u32	seq;
+	__u32	pkt_len[AGGREGATION_WINDOW];
+};
+
+#endif /* __XDP_LRU_WINDOW_H */
-- 
2.25.1

