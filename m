Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52536EAB8
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919529; cv=none; b=uaQ1dEpBeJV/86Upk61ro9uZq70V+9eLKtAaaEeMy64d1mln69tFn0R+7oMtUYwNwL9CFKgy4hz5SH3na85q+dQfxDM5lofBsQ/l2fyPkx5pkR9Yhs548Riv+uLZAZdos5PIOQ4pFq/so41rojp8/nw0aPbFpX3Q5m6/s/F3rdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919529; c=relaxed/simple;
	bh=w1vTCwqCmyqKDX1WddgRMs5U/S2CLxsTCVfYt3Dp6Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tHanYCRXJpiJoDr5iUEGwA6TMU7+wcYf6vXzp0I6qtLm/5rEQIyJfC2cX4GlMkP+tR853j49x5P9ZRqfDB9yDreAbuiL9RLVWkqzEwMCYCcy9ng973JCGojmb50tc9kN6AF6xNKxMpQsbjD3hoPrPHVYQnZJpM93nEfrAvSHLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4f6Tcjq; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4f6Tcjq"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347866278b6so2737795eec.2
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790919526; x=1791524326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yyDqLLqFV/rqc17tkYdS3jusC5HzkW230guq0WC+SSc=;
        b=b4f6TcjqAKfRgw5/f9aVpsBzlK+vf8uwA/nA629F8xcuRm0vGdNDw3/WEp00m2aw7c
         VFnL6VR/pFoA+md3i9iLFlWLNHFNAd6Ux5bInkuLAVHjgoY7O/X8ZqQJ9Pc17wtzztCf
         J9UT+nOJz/3jcVnALUzU2IIBN46dTp5atYlNa1Hgv9Yd5i7i9Sxl4ErDbXZ09R+QWzgi
         qfI++Nzhat+8lPPwBiDjCIFuGNeJvVusgxHlg9u1+auMDJL2+dCz49+xZd21XzhVftCr
         aK2berMbRCuHF/ivRxlMS5hQ5RTDqjUjwNXA3IlpfDTq0oMNoh4bR9Kb9DelsK4kP8lM
         P1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919526; x=1791524326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyDqLLqFV/rqc17tkYdS3jusC5HzkW230guq0WC+SSc=;
        b=LMjq2ui/o6X2T0EwNl5rvay4z6GyHjXcB7JOp7534npFuaxZxfhEJTcNdcLx/pKtIc
         U7uMouPmidypu3I75uU/FBYic3HRW8a0U2ddhzWABpdDS64dW+rPL5ThzWKtj0om6TwK
         v4982jQ6V/4eLjPkh/u8HB8wl6Alv80idyJOOmYEEQAueB/NyE2oxCWYd8NZje69bDVw
         NHe7j7rbhq9MM5B/fNj9cGEObCcSE1VtFTuFjM2B3av1gHu7uPcR1mAX9LcjfQylXRCj
         CYu0pXtdfxqkHYOQKO72y9Isd5nopbRxUp7st9RJOuJE9OGwF4P3uJD7+ciC5sVgUlkO
         xTow==
X-Forwarded-Encrypted: i=1; AKwUvBzdBk9oCuG6lfZU/1EVstDGhOZF51SvKkuBxjjaUeoyHMPzgZPWbLu4/SZRXigoNBkncZw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzgRwLO8+Qx/GppAvXrhWUIZeHfKQHKraVHW1Ea/cJcBgfR467
	9mVUQxyTSct2fdtGq8BSYTPtyHWU0KpqO7h6fd8SE6DSsbAp+Yt7gjHR
X-Gm-Gg: AYBFou2fupAzSSlIbmH9nT4sJb5XPHLGavbbPHl4LDzDm6Ip/o1IcbOsrxrwqO51GlE
	8+uZsOi1ZyxJ3DtadhdTCje+CSmqMFVlZMFWN/cJxg1ahZBf0xin5uFNL+CkIM0ObG+P+WyQoYa
	TZWaIhs97aVPx0BgQNWLRQCx+wMcQ5t9WlpsjgLCA/0Uw9VS6ILjlIWsY0ECbI6FrqiPoXlMU1E
	Ode2+Y8lRUZueD0Hn9PsObLYy4fp4NfHpc3+rBnLaVKIDGEOhN9iMbku+89932P2hJKfhADQpDo
	8guWq4PTcQlJb0Bot1ZwiJYCb33DrcUhGKzH6+s7dsEGyrirAZQ9JbFXReFqF4FfqfJLnVdYG9+
	ITDbPyn4TmXkZ6E+FIY50AX40prGX2tCVGYbQSPbQ+03oUteqwgScQxso0k6wv4dJz7yFrtGqsD
	0P7l3ivnojIy42YTiVWHk6ipkSfDA22uwZ6YvLQ8qTItr1SUlKLGLeJAdENBDjCPbVXF8Emlbrx
	HrbFN3ZCvvcTKd4i9oai5ouAlQ3ZJssf0/nWoqb3akwGUzk097R3jaHunTL8vb3LXhrjxY1P6SC
	cxMyQhID6R5WbufScqcz23qZO1Wg4vKjMyz+RmsVd+E=
X-Received: by 2002:a05:7300:fb91:b0:34d:4a08:5ec7 with SMTP id 5a478bee46e88-34f14488744mr3174901eec.1.1790919526098;
        Thu, 01 Oct 2026 22:38:46 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34ef98d925csm3536041eec.0.2026.10.01.22.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 22:38:45 -0700 (PDT)
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
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH bpf-next v3] selftests/bpf: add XDP test for per-flow LRU_HASH window updates
Date: Fri,  2 Oct 2026 05:38:37 +0000
Message-Id: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
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
v3:
 - wrap: send the post-wrap packets with a different length and verify
   only the wrapped slots change, so a wrong but in-range post-wrap
   index is caught (BPF CI review).
 - trunc: send well-formed but short frames to actually exercise the
   IPv4 and TCP length checks, instead of a non-IPv4 frame that bailed
   at the ethertype test (BPF CI review).
 - No change to the BPF program, uapi or header.

v2: https://lore.kernel.org/netdev/20261002042201.3483076-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/netdev/20260917135433.2260048-1-anilkaushikwireless@gmail.com/

 .../selftests/bpf/prog_tests/xdp_lru_window.c | 216 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_lru_window.c      |  81 +++++++
 tools/testing/selftests/bpf/xdp_lru_window.h  |  28 +++
 3 files changed, 325 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/xdp_lru_window.h

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
new file mode 100644
index 000000000..5e353fb14
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
@@ -0,0 +1,216 @@
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
+/* Like inject(), but sends frames of a chosen on-wire length (>= the
+ * TCP/IPv4 headers) so the recorded pkt_len differs from the default.
+ */
+static int inject_len(int n, __u16 dport, __u32 len)
+{
+	unsigned char buf[sizeof(struct ipv4_packet) + 64] = {};
+	struct ipv4_packet pkt;
+	int i, retval;
+
+	fill_pkt(&pkt, dport);
+	memcpy(buf, &pkt, sizeof(pkt));
+	if (len > sizeof(buf))
+		len = sizeof(buf);
+	for (i = 0; i < n; i++) {
+		if (run_pkt(buf, len, &retval))
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
+	__u32 base_len = sizeof(struct ipv4_packet);
+	__u32 new_len = base_len + 20;
+	int i;
+
+	reset_map();
+	if (inject(1, DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup"))
+		return;
+	ASSERT_EQ(st.seq, 1, "seq");
+	ASSERT_EQ(st.pkt_len[0], base_len, "len0");
+
+	/* Fill the whole window with base-length packets (slots 0..W-1),
+	 * then send 5 more of a different length so they wrap into slots
+	 * 0..4. Distinct lengths let the checks below catch a wrong, but
+	 * still in-range, post-wrap index.
+	 */
+	if (inject(AGGREGATION_WINDOW - 1, DST_PORT))
+		return;
+	if (inject_len(5, DST_PORT, new_len))
+		return;
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup wrap"))
+		return;
+	ASSERT_EQ(st.seq, AGGREGATION_WINDOW + 5, "seq wrap");
+	for (i = 0; i < 5; i++)
+		ASSERT_EQ(st.pkt_len[i], new_len, "wrapped slot");
+	for (i = 5; i < AGGREGATION_WINDOW; i++)
+		ASSERT_EQ(st.pkt_len[i], base_len, "kept slot");
+}
+
+static void test_trunc(void)
+{
+	struct xdp_lru_window_state before, after;
+	struct xdp_lru_window_key key, next;
+	struct ipv4_packet pkt;
+	__u32 ip_trunc = sizeof(pkt_v4.eth);
+	__u32 tcp_trunc = sizeof(pkt_v4.eth) + sizeof(pkt_v4.iph);
+	int err, retval;
+
+	fill_pkt(&pkt, DST_PORT);
+	reset_map();
+
+	/* Valid Ethernet/IP ethertype, but the IPv4 header is cut off:
+	 * exercises the program's IPv4 length check.
+	 */
+	if (run_pkt(&pkt, ip_trunc, &retval))
+		return;
+	ASSERT_EQ(retval, XDP_PASS, "ip trunc retval");
+	err = bpf_map_get_next_key(map_fd, NULL, &next);
+	ASSERT_EQ(err, -ENOENT, "ip trunc no insert");
+
+	/* Full Ethernet + IPv4 header, but the TCP header is cut off:
+	 * exercises the program's TCP length check.
+	 */
+	if (run_pkt(&pkt, tcp_trunc, &retval))
+		return;
+	ASSERT_EQ(retval, XDP_PASS, "tcp trunc retval");
+	err = bpf_map_get_next_key(map_fd, NULL, &next);
+	ASSERT_EQ(err, -ENOENT, "tcp trunc no insert");
+
+	/* A truncated packet must not mutate an already-tracked flow. */
+	if (inject(1, DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &before), "setup"))
+		return;
+	if (run_pkt(&pkt, tcp_trunc, &retval))
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

