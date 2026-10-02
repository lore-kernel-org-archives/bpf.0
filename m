Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439031F9B5
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914933; cv=none; b=NkLYetinBWYzJIL3bOYndC++Nl1gy7DL7KHg9rfSLhg6gEOlImcuMMWowvg6wdaC/7kp7hzRiRyDg5mkTI9dn9RsnWH08l6FVXh1DfK/+8ZgTSX6kan9TnFXLO62SNW2/77YoKPmrdhS5v79Sfkz0oB5+sjQS0V75kNfjBzwXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914933; c=relaxed/simple;
	bh=cCGtKzRan8BWBEBX1JfJ3AgQYo8AGQ9XZRDmtPnG1yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKfL3AEwSqMMvswdab1XUdca9sUtgLHP5I86lQRD83xI00ZbKwqZVG8CIkEVAlm/ajsJUmnlEtgg3c9JOTKeo2PJCQLTx+THzGbWrA11/oiOxV7vHffYAkKiK83itDOLUxP2Du41YQVoBbdLCWztXmow0iVzmKceAefqN/Uo2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNMiMFIL; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNMiMFIL"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b223602d7so2861765eec.2
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914931; x=1791519731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xq7JBmYQfpiyGGj6KWk3jb5GoLIoazeQmys5Q46VZRg=;
        b=eNMiMFILS9TRLeBm94BHfOP2/9/SyW0OJPDkYOtazkMtdYGufwgE6/O0VSWD0vBApq
         bh7jv4TTRYkEsQNuvtMDg/Vjuyngw5sW4nR3LtJmIXYuviBvkM9GGBdE/AV8VyPyZMrJ
         rGelIaGIoXka+wVa2mJr6J/iH2qkOGs4yY6cHzIKsf1NRfDP8cZd6cQwsF/zeD6dJxSk
         rCiX0zvkeMy2HpNq6dBGRZ+Lf3fRw+5DSh7emeTNC49Wux86NDocQwBzaxquevPpp8P2
         RvR8CymX+rt+M024v5lLa2z3OFHE2oucZxUmgVRXAHKsXG4jGQCfdTNB2F48JCumqkvR
         FhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914931; x=1791519731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xq7JBmYQfpiyGGj6KWk3jb5GoLIoazeQmys5Q46VZRg=;
        b=UfkJZ/TbeyIdtplUciTBmufVpD7Zq2bTDQ80YVO3Q+R8PJaA/fr6uEhLkNtpytkra3
         2gIgnHlKrL/ESTweIct4UaMDn0r+frLz5LAjaOcR5bUVs6KoH7otsk8DHT2Egn2PjZaI
         f0D6VYkTPO6oGpiuZLthkvdNfp3QEHwo7ITlWc1JgRIvU16DCCN/GclSu9/QwpXLSrCG
         0KCNYxEZWvTUQ2g8OrM30/8OGtudvmxkkFec8M1zbrUR1RPpw8XPZwAUwOpC7+8bMMFt
         CVQnNhEnbYNOxwX+cLAvnf9lwu3+fRhVr8q5GmzcLsoY6f/RzAxPNZyYwTESywsnl0VB
         o4eQ==
X-Forwarded-Encrypted: i=1; AKwUvBww64mR6nsu56KGElav/GP3sAGUswjLhrBGAXCh28yWhydPWKA0OlgK5W3m+UuQB6Pjdoo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzIk3IzWLKnK6K7uvrYY+fqY8HFZWF4tIp339cYX10Bsjxt+TR
	qMpPwtqIAHOdDPBKkuyg3eokJD3DjyDU5eNEublKkH+viX985sZOLKtB
X-Gm-Gg: AYBFou1ZfIriq83BnwVY5TNsI90kwa5qUnhI5v+TF8CeUszb2E0GpPQpfaIcfLsKYuA
	GBs/ttSa2kfHkz4qh3pdZoCvdJzmMp7CgAUhSevPRHdoFXl9xHIXcGJI6tlq/widcx+HPOQ2sII
	gtMqzCR9JtkfX/OHU4WXkDGk7h1entdHH+m0qTIMbew3whu2kAomNIlfssfh8aNhn4K8c19Y3su
	xACR+i2bz7TvactdzJQ2YusiDFJ6tyNThgLpD0nBtUzLwhK+miMtBHNewZgq1nlq2nHiGLPwT+a
	R/AgSk0MDFommJVYpyS38lpVvxlj7gkChhEZ9vKssBHL8NSTKngmYom9ITixydchVnISJ/et4Wk
	w6k+USLeWIpQxVYtyhEHLEw4H3MHTDgEUJbGkARd3tI0dodLZm4+kx2Fv0nScKpsGnxWQSYKegr
	X8PC9vz6RxDmLbYTHohOKsr2wqu47O1K3AmNvuv0Sm4HZxgWjLQry3m3do/8GJQEn4J28yy4ozy
	eon9KUfLJnhV/jxrsLMN1dp3Lc4DuVKFx2g9VPKU42ucx7PJzLV7sABS+BWxOicCGD/hAEB4jaq
	LpNzZPEKJYHPJYTHuei6CiGblzPypbOvNlVm1oSBwdc=
X-Received: by 2002:a05:7300:7fa8:b0:34e:f967:8cfa with SMTP id 5a478bee46e88-34f21990e24mr2294841eec.32.1790914930420;
        Thu, 01 Oct 2026 21:22:10 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm2526734eec.29.2026.10.01.21.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:22:09 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org
Cc: sdf@fomichev.me,
	ihor.solodrai@linux.dev,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: add XDP test for per-flow LRU_HASH window updates
Date: Fri,  2 Oct 2026 04:22:01 +0000
Message-Id: <20261002042201.3483076-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LRU_HASH selftests (test_lru_map) exercise BPF_MAP_TYPE_LRU_HASH
only from the syscall side. There is no coverage of an XDP program
updating an LRU_HASH map on the data path: inserting an entry with
BPF_NOEXIST on first sight of a flow, then updating a bounded array
inside the map value using a runtime (modulo) index.

That pattern is common in XDP flow-tracking programs and stresses two
things worth testing together: the verifier's bounds checking of a
value-internal array indexed by a runtime value, and per-flow key
isolation in an LRU map driven from XDP.

Add an XDP program that keys an LRU_HASH by the TCP/IPv4 5-tuple and
records packet lengths into value->pkt_len[seq % AGGREGATION_WINDOW],
plus a test_progs case driven by bpf_prog_test_run that checks:

 - wrap:    seq advances and the bounded array wraps, with the runtime
            index accepted by the verifier;
 - trunc:   a short (parse-failing) packet neither inserts a new entry
            nor mutates an existing one;
 - isolate: two distinct 5-tuples get independent entries.

Selftest only; no kernel change.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
v2:
 - CC the XDP / BPF-selftests maintainers and reviewers; v1 was sent to
   the lists only and received no review.
 - Rewrite the commit message to explain the coverage gap and intent.
 - No change to the test code.

v1: https://lore.kernel.org/netdev/20260917135433.2260048-1-anilkaushikwireless@gmail.com/

 .../selftests/bpf/prog_tests/xdp_lru_window.c | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_lru_window.c      |  81 +++++++++
 tools/testing/selftests/bpf/xdp_lru_window.h  |  28 +++
 3 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/xdp_lru_window.h

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
new file mode 100644
index 000000000..55175c216
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
@@ -0,0 +1,168 @@
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
+
+	if (test__start_subtest("wrap"))
+		test_one_and_wrap();
+	if (test__start_subtest("trunc"))
+		test_trunc();
+	if (test__start_subtest("isolate"))
+		test_isolate();
+
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

