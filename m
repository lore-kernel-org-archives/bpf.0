Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCB3AE1BD
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332232; cv=none; b=dPjVuYb8b0qgL3gfLAJ8t3Y3HEseV1w0O9fyezUgx9ZnGyyyQAe7wDZ/TzIrtdkTUJMz2po9VWOYC+PNTuMS6XZzBvwTAwZ6/CBFuCGHxzpbVfMJMNmdjhY15LkoKojPIAqefr2RF9ZUxXpgjh6foUR+PYYSaaoj4OI7Wn+tY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332232; c=relaxed/simple;
	bh=/HPVPjRSDFycJjWRrR9fadROsiRQAnj/cyZO1xnHImY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUixDzWJAJ5zoMw4mTr2cFicUKZFlCag61wDA/fZlXMmTcgWUrRbfMNzJQtfPtH5mydo2y4iF5nOHp63vD4CyCHHrdkWfhNIMKac5HvFVFthKrpNUjoVh2rhN6qsrQQnnF8DfXIqhurVePX4YlEQ73A4tXsFQ3vUq+zL0ogt5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odBTU1Hz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odBTU1Hz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF63DC19425;
	Mon, 27 Apr 2026 23:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332232;
	bh=/HPVPjRSDFycJjWRrR9fadROsiRQAnj/cyZO1xnHImY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odBTU1HzVOt9IjhOPr/6mUxC3Ehc+fK9cURtLEV+sEbXzTSTH2LrtoOdLgrUZ8SMo
	 SWTfUpUnlZ01p6FSudGThZmhJGMIwz/0yG+tzWKMO8U8XdjAX9fR+aoQU4krb8M5Oj
	 aC+fsExjF6U7RjPnaiqSzwaLbLEWvnOgXmU/6YKJvmYYGoBhBWPehcqREfMZj/Egy2
	 pTZCGBltWWsPttGrNAav5CO5p8SpZPkCNdLAXBtQ7yIyStTbWWTQL0ZxZk/bFtq98U
	 YML6+9pbfc+wUIWRaO0CfBLGYGzGyZaeP3EoUip3me+Oi5/FN7L7PGRT9yDJ5tTfsu
	 QSgg1JqNAECSw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 5/7] selftests/bpf: Add XDP load-balancer BPF program
Date: Mon, 27 Apr 2026 16:23:02 -0700
Message-ID: <20260427232313.1582588-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427232313.1582588-1-puranjay@kernel.org>
References: <20260427232313.1582588-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the BPF datapath for the XDP load-balancer benchmark, a
simplified L4 load-balancer inspired by katran.

The pipeline: L3/L4 parse -> VIP lookup -> per-CPU LRU connection
table or consistent-hash fallback -> real server lookup -> per-VIP
and per-real stats -> IPIP/IP6IP6 encapsulation.  TCP SYN forces
the consistent-hash path (skipping LRU); TCP RST skips LRU insert
to avoid polluting the table.

process_packet() is marked __noinline so that the BENCH_BPF_LOOP
reset block (which strips encapsulation) operates on valid packet
pointers after bpf_xdp_adjust_head().

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/progs/xdp_lb_bench.c        | 647 ++++++++++++++++++
 1 file changed, 647 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lb_bench.c

diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
new file mode 100644
index 000000000000..b9fd848c035d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
@@ -0,0 +1,647 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <stddef.h>
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/in.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_compiler.h"
+#include "xdp_lb_bench_common.h"
+#include "bench_bpf_timing.bpf.h"
+
+#ifndef IPPROTO_FRAGMENT
+#define IPPROTO_FRAGMENT 44
+#endif
+
+/* jhash helpers */
+
+static inline __u32 rol32(__u32 word, unsigned int shift)
+{
+	return (word << shift) | (word >> ((-shift) & 31));
+}
+
+#define __jhash_mix(a, b, c)			\
+{						\
+	a -= c;  a ^= rol32(c, 4);  c += b;	\
+	b -= a;  b ^= rol32(a, 6);  a += c;	\
+	c -= b;  c ^= rol32(b, 8);  b += a;	\
+	a -= c;  a ^= rol32(c, 16); c += b;	\
+	b -= a;  b ^= rol32(a, 19); a += c;	\
+	c -= b;  c ^= rol32(b, 4);  b += a;	\
+}
+
+#define __jhash_final(a, b, c)			\
+{						\
+	c ^= b; c -= rol32(b, 14);		\
+	a ^= c; a -= rol32(c, 11);		\
+	b ^= a; b -= rol32(a, 25);		\
+	c ^= b; c -= rol32(b, 16);		\
+	a ^= c; a -= rol32(c, 4);		\
+	b ^= a; b -= rol32(a, 14);		\
+	c ^= b; c -= rol32(b, 24);		\
+}
+
+#define JHASH_INITVAL 0xdeadbeef
+
+static inline __u32 __jhash_nwords(__u32 a, __u32 b, __u32 c, __u32 initval)
+{
+	a += initval;
+	b += initval;
+	c += initval;
+	__jhash_final(a, b, c);
+	return c;
+}
+
+static inline __u32 jhash_2words(__u32 a, __u32 b, __u32 initval)
+{
+	return __jhash_nwords(a, b, 0, initval + JHASH_INITVAL + (2 << 2));
+}
+
+static inline __u32 jhash2_4words(const __u32 *k, __u32 initval)
+{
+	__u32 a, b, c;
+
+	a = b = c = JHASH_INITVAL + (4 << 2) + initval;
+
+	a += k[0]; b += k[1]; c += k[2];
+	__jhash_mix(a, b, c);
+
+	a += k[3];
+	__jhash_final(a, b, c);
+
+	return c;
+}
+
+static __always_inline void ipv4_csum(struct iphdr *iph)
+{
+	__u16 *next_iph = (__u16 *)iph;
+	__u32 csum = 0;
+	int i;
+
+	__pragma_loop_unroll_full
+	for (i = 0; i < (int)(sizeof(*iph) >> 1); i++)
+		csum += *next_iph++;
+
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+	iph->check = ~csum;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, struct vip_definition);
+	__type(value, struct vip_meta);
+} vip_map SEC(".maps");
+
+struct lru_inner_map {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__type(key, struct flow_key);
+	__type(value, struct real_pos_lru);
+	__uint(max_entries, DEFAULT_LRU_SIZE);
+} lru_inner SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, BENCH_NR_CPUS);
+	__array(values, struct lru_inner_map);
+} lru_mapping SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CH_RINGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u32);
+} ch_rings SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_REALS);
+	__type(key, __u32);
+	__type(value, struct real_definition);
+} reals SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, STATS_SIZE);
+	__type(key, __u32);
+	__type(value, struct lb_stats);
+} stats SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, MAX_REALS);
+	__type(key, __u32);
+	__type(value, struct lb_stats);
+} reals_stats SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct ctl_value);
+} ctl_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct vip_definition);
+} vip_miss_stats SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, MAX_REALS);
+	__type(key, __u32);
+	__type(value, __u32);
+} lru_miss_stats SEC(".maps");
+
+volatile __u32 flow_mask;
+volatile __u32 cold_lru;
+__u32 batch_gen;
+
+/*
+ * old_eth MUST be read BEFORE writing the outer header because
+ * bpf_xdp_adjust_head makes them overlap.
+ */
+static __always_inline int encap_v4(struct xdp_md *xdp, __be32 saddr, __be32 daddr,
+				    __u16 payload_len, const __u8 *dst_mac)
+{
+	struct ethhdr *new_eth, *old_eth;
+	void *data, *data_end;
+	struct iphdr *iph;
+
+	if (bpf_xdp_adjust_head(xdp, -(int)sizeof(struct iphdr)))
+		return -1;
+
+	data     = (void *)(long)xdp->data;
+	data_end = (void *)(long)xdp->data_end;
+
+	new_eth = data;
+	iph     = data + sizeof(struct ethhdr);
+	old_eth = data + sizeof(struct iphdr);
+
+	if (new_eth + 1 > data_end || old_eth + 1 > data_end || iph + 1 > data_end)
+		return -1;
+
+	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
+	__builtin_memcpy(new_eth->h_dest, dst_mac, sizeof(new_eth->h_dest));
+	new_eth->h_proto = bpf_htons(ETH_P_IP);
+
+	__builtin_memset(iph, 0, sizeof(*iph));
+	iph->version  = 4;
+	iph->ihl      = sizeof(*iph) >> 2;
+	iph->protocol = IPPROTO_IPIP;
+	iph->tot_len  = bpf_htons(payload_len + sizeof(*iph));
+	iph->ttl      = 64;
+	iph->saddr    = saddr;
+	iph->daddr    = daddr;
+	ipv4_csum(iph);
+
+	return 0;
+}
+
+static __always_inline int encap_v6(struct xdp_md *xdp, const __be32 saddr[4],
+				    const __be32 daddr[4], __u8 nexthdr, __u16 payload_len,
+				    const __u8 *dst_mac)
+{
+	struct ethhdr *new_eth, *old_eth;
+	void *data, *data_end;
+	struct ipv6hdr *ip6h;
+
+	if (bpf_xdp_adjust_head(xdp, -(int)sizeof(struct ipv6hdr)))
+		return -1;
+
+	data     = (void *)(long)xdp->data;
+	data_end = (void *)(long)xdp->data_end;
+
+	new_eth = data;
+	ip6h    = data + sizeof(struct ethhdr);
+	old_eth = data + sizeof(struct ipv6hdr);
+
+	if (new_eth + 1 > data_end || old_eth + 1 > data_end || ip6h + 1 > data_end)
+		return -1;
+
+	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
+	__builtin_memcpy(new_eth->h_dest, dst_mac, sizeof(new_eth->h_dest));
+	new_eth->h_proto = bpf_htons(ETH_P_IPV6);
+
+	__builtin_memset(ip6h, 0, sizeof(*ip6h));
+	ip6h->version     = 6;
+	ip6h->nexthdr     = nexthdr;
+	ip6h->payload_len = bpf_htons(payload_len);
+	ip6h->hop_limit   = 64;
+	__builtin_memcpy(&ip6h->saddr, saddr, sizeof(ip6h->saddr));
+	__builtin_memcpy(&ip6h->daddr, daddr, sizeof(ip6h->daddr));
+
+	return 0;
+}
+
+static __always_inline void update_stats(void *map, __u32 key, __u16 bytes)
+{
+	struct lb_stats *st = bpf_map_lookup_elem(map, &key);
+
+	if (st) {
+		st->v1 += 1;
+		st->v2 += bytes;
+	}
+}
+
+static __always_inline void count_action(int action)
+{
+	struct lb_stats *st;
+	__u32 key;
+
+	if (action == XDP_TX)
+		key = STATS_XDP_TX;
+	else if (action == XDP_PASS)
+		key = STATS_XDP_PASS;
+	else
+		key = STATS_XDP_DROP;
+
+	st = bpf_map_lookup_elem(&stats, &key);
+	if (st)
+		st->v1 += 1;
+}
+
+static __always_inline bool is_under_flood(void)
+{
+	__u32 key = STATS_NEW_CONN;
+	struct lb_stats *conn_st = bpf_map_lookup_elem(&stats, &key);
+	__u64 cur_time;
+
+	if (!conn_st)
+		return true;
+
+	cur_time = bpf_ktime_get_ns();
+	if ((cur_time - conn_st->v2) > ONE_SEC) {
+		conn_st->v1 = 1;
+		conn_st->v2 = cur_time;
+	} else {
+		conn_st->v1 += 1;
+		if (conn_st->v1 > MAX_CONN_RATE)
+			return true;
+	}
+	return false;
+}
+
+static __always_inline struct real_definition *connection_table_lookup(void *lru_map,
+								       struct flow_key *flow,
+								       __u32 *out_pos)
+{
+	struct real_pos_lru *dst_lru;
+	struct real_definition *real;
+	__u32 key;
+
+	dst_lru = bpf_map_lookup_elem(lru_map, flow);
+	if (!dst_lru)
+		return NULL;
+
+	/* UDP connections use atime-based timeout instead of FIN/RST */
+	if (flow->proto == IPPROTO_UDP) {
+		__u64 cur_time = bpf_ktime_get_ns();
+
+		if (cur_time - dst_lru->atime > LRU_UDP_TIMEOUT)
+			return NULL;
+		dst_lru->atime = cur_time;
+	}
+
+	key = dst_lru->pos;
+	*out_pos = key;
+	real = bpf_map_lookup_elem(&reals, &key);
+	return real;
+}
+
+static __always_inline bool get_packet_dst(struct real_definition **real, struct flow_key *flow,
+					   struct vip_meta *vip_info, bool is_v6, void *lru_map,
+					   bool is_rst, __u32 *out_pos)
+{
+	bool under_flood;
+	__u32 hash, ch_key;
+	__u32 *ch_val;
+	__u32 real_pos;
+
+	under_flood = is_under_flood();
+
+	if (is_v6) {
+		__u32 src_hash = jhash2_4words((__u32 *)flow->srcv6, MAX_VIPS);
+
+		hash = jhash_2words(src_hash, flow->ports, CH_RING_SIZE);
+	} else {
+		hash = jhash_2words(flow->src, flow->ports, CH_RING_SIZE);
+	}
+
+	ch_key = CH_RING_SIZE * vip_info->vip_num + hash % CH_RING_SIZE;
+	ch_val = bpf_map_lookup_elem(&ch_rings, &ch_key);
+	if (!ch_val)
+		return false;
+	real_pos = *ch_val;
+
+	*real = bpf_map_lookup_elem(&reals, &real_pos);
+	if (!(*real))
+		return false;
+
+	if (!(vip_info->flags & F_LRU_BYPASS) && !under_flood && !is_rst) {
+		struct real_pos_lru new_lru = { .pos = real_pos };
+
+		if (flow->proto == IPPROTO_UDP)
+			new_lru.atime = bpf_ktime_get_ns();
+		bpf_map_update_elem(lru_map, flow, &new_lru, BPF_ANY);
+	}
+
+	*out_pos = real_pos;
+	return true;
+}
+
+static __always_inline void update_vip_lru_miss_stats(struct vip_definition *vip, bool is_v6,
+						      __u32 real_idx)
+{
+	struct vip_definition *miss_vip;
+	__u32 key = 0;
+	__u32 *cnt;
+
+	miss_vip = bpf_map_lookup_elem(&vip_miss_stats, &key);
+	if (!miss_vip)
+		return;
+
+	if (is_v6) {
+		if (miss_vip->vipv6[0] != vip->vipv6[0] || miss_vip->vipv6[1] != vip->vipv6[1] ||
+		    miss_vip->vipv6[2] != vip->vipv6[2] || miss_vip->vipv6[3] != vip->vipv6[3])
+			return;
+	} else {
+		if (miss_vip->vip != vip->vip)
+			return;
+	}
+
+	if (miss_vip->port != vip->port || miss_vip->proto != vip->proto)
+		return;
+
+	cnt = bpf_map_lookup_elem(&lru_miss_stats, &real_idx);
+	if (cnt)
+		*cnt += 1;
+}
+
+static __noinline int process_packet(struct xdp_md *xdp)
+{
+	void *data     = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	struct real_definition *dst = NULL;
+	struct vip_definition vip_def = {};
+	struct ctl_value *cval;
+	struct flow_key flow = {};
+	struct vip_meta *vip_info;
+	struct lb_stats *data_stats;
+	struct udphdr *uh;
+	__be32 tnl_src[4];
+	void *lru_map;
+	void *l4;
+	__u16 payload_len;
+	__u32 real_pos = 0, cpu_num, key;
+	__u8 proto;
+	int action = XDP_DROP;
+	bool is_v6, is_syn = false, is_rst = false;
+
+	if (eth + 1 > data_end)
+		goto out;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		is_v6 = true;
+	} else if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		is_v6 = false;
+	} else {
+		action = XDP_PASS;
+		goto out;
+	}
+
+	if (is_v6) {
+		struct ipv6hdr *ip6h = (void *)(eth + 1);
+
+		if (ip6h + 1 > data_end)
+			goto out;
+		if (ip6h->nexthdr == IPPROTO_FRAGMENT)
+			goto out;
+
+		payload_len = sizeof(struct ipv6hdr) + bpf_ntohs(ip6h->payload_len);
+		proto = ip6h->nexthdr;
+
+		__builtin_memcpy(flow.srcv6, &ip6h->saddr, sizeof(flow.srcv6));
+		__builtin_memcpy(flow.dstv6, &ip6h->daddr, sizeof(flow.dstv6));
+		__builtin_memcpy(vip_def.vipv6, &ip6h->daddr, sizeof(vip_def.vipv6));
+		l4 = (void *)(ip6h + 1);
+	} else {
+		struct iphdr *iph = (void *)(eth + 1);
+
+		if (iph + 1 > data_end)
+			goto out;
+		if (iph->ihl != 5)
+			goto out;
+		if (iph->frag_off & bpf_htons(PCKT_FRAGMENTED))
+			goto out;
+
+		payload_len = bpf_ntohs(iph->tot_len);
+		proto = iph->protocol;
+
+		flow.src    = iph->saddr;
+		flow.dst    = iph->daddr;
+		vip_def.vip = iph->daddr;
+		l4 = (void *)(iph + 1);
+	}
+
+	/* TCP and UDP share the same port layout at offset 0 */
+	if (proto != IPPROTO_TCP && proto != IPPROTO_UDP) {
+		action = XDP_PASS;
+		goto out;
+	}
+
+	uh = l4;
+	if ((void *)(uh + 1) > data_end)
+		goto out;
+	flow.port16[0] = uh->source;
+	flow.port16[1] = uh->dest;
+
+	if (proto == IPPROTO_TCP) {
+		struct tcphdr *th = l4;
+
+		if ((void *)(th + 1) > data_end)
+			goto out;
+		is_syn = th->syn;
+		is_rst = th->rst;
+	}
+
+	flow.proto    = proto;
+	vip_def.port  = flow.port16[1];
+	vip_def.proto = proto;
+
+	vip_info = bpf_map_lookup_elem(&vip_map, &vip_def);
+	if (!vip_info) {
+		action = XDP_PASS;
+		goto out;
+	}
+
+	key = STATS_LRU;
+	data_stats = bpf_map_lookup_elem(&stats, &key);
+	if (!data_stats)
+		goto out;
+	data_stats->v1 += 1;
+
+	cpu_num = bpf_get_smp_processor_id();
+	lru_map = bpf_map_lookup_elem(&lru_mapping, &cpu_num);
+	if (!lru_map)
+		goto out;
+
+	if (!(vip_info->flags & F_LRU_BYPASS) && !is_syn)
+		dst = connection_table_lookup(lru_map, &flow, &real_pos);
+
+	if (!dst) {
+		if (flow.proto == IPPROTO_TCP) {
+			struct lb_stats *miss_st;
+
+			key = STATS_LRU_MISS;
+			miss_st = bpf_map_lookup_elem(&stats, &key);
+			if (miss_st)
+				miss_st->v1 += 1;
+		}
+
+		if (!get_packet_dst(&dst, &flow, vip_info, is_v6, lru_map, is_rst, &real_pos))
+			goto out;
+
+		update_vip_lru_miss_stats(&vip_def, is_v6, real_pos);
+		data_stats->v2 += 1;
+	}
+
+	key = 0;
+	cval = bpf_map_lookup_elem(&ctl_array, &key);
+	if (!cval)
+		goto out;
+
+	update_stats(&stats, vip_info->vip_num, payload_len);
+	update_stats(&reals_stats, real_pos, payload_len);
+
+	if (is_v6) {
+		create_encap_ipv6_src(flow.port16[0], flow.srcv6[0], tnl_src);
+		if (encap_v6(xdp, tnl_src, dst->dstv6, IPPROTO_IPV6, payload_len, cval->mac))
+			goto out;
+	} else if (dst->flags & F_IPV6) {
+		create_encap_ipv6_src(flow.port16[0], flow.src, tnl_src);
+		if (encap_v6(xdp, tnl_src, dst->dstv6, IPPROTO_IPIP, payload_len, cval->mac))
+			goto out;
+	} else {
+		if (encap_v4(xdp, create_encap_ipv4_src(flow.port16[0], flow.src), dst->dst,
+			     payload_len, cval->mac))
+			goto out;
+	}
+
+	action = XDP_TX;
+
+out:
+	count_action(action);
+	return action;
+}
+
+static __always_inline int strip_encap(struct xdp_md *xdp, const struct ethhdr *saved_eth)
+{
+	void *data = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	int hdr_sz;
+
+	if (eth + 1 > data_end)
+		return -1;
+
+	hdr_sz = (eth->h_proto == bpf_htons(ETH_P_IPV6)) ? (int)sizeof(struct ipv6hdr)
+							 : (int)sizeof(struct iphdr);
+
+	if (bpf_xdp_adjust_head(xdp, hdr_sz))
+		return -1;
+
+	data     = (void *)(long)xdp->data;
+	data_end = (void *)(long)xdp->data_end;
+	eth      = data;
+
+	if (eth + 1 > data_end)
+		return -1;
+
+	__builtin_memcpy(eth, saved_eth, sizeof(*saved_eth));
+	return 0;
+}
+
+static __always_inline void randomize_src(struct xdp_md *xdp, int saddr_off, __u32 *rand_state)
+{
+	void *data     = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	__u32 *saddr   = data + saddr_off;
+
+	*rand_state ^= *rand_state << 13;
+	*rand_state ^= *rand_state >> 17;
+	*rand_state ^= *rand_state << 5;
+
+	if ((void *)(saddr + 1) <= data_end)
+		*saddr = *rand_state & flow_mask;
+}
+
+SEC("xdp")
+int xdp_lb_bench(struct xdp_md *xdp)
+{
+	void *data     = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	struct ethhdr saved_eth;
+	__u32 rand_state = 0;
+	__u32 batch_hash = 0;
+	int saddr_off = 0;
+	bool is_v6;
+
+	if (eth + 1 > data_end)
+		return XDP_DROP;
+
+	__builtin_memcpy(&saved_eth, eth, sizeof(saved_eth));
+
+	is_v6 = (saved_eth.h_proto == bpf_htons(ETH_P_IPV6));
+
+	saddr_off = sizeof(struct ethhdr) + (is_v6 ? offsetof(struct ipv6hdr, saddr) :
+					     offsetof(struct iphdr, saddr));
+
+	if (flow_mask)
+		rand_state = bpf_get_prandom_u32() | 1;
+
+	if (cold_lru) {
+		__u32 *saddr = data + saddr_off;
+
+		batch_gen++;
+		batch_hash = (batch_gen ^ bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
+		if ((void *)(saddr + 1) <= data_end)
+			*saddr ^= batch_hash;
+	}
+
+	return BENCH_BPF_LOOP(
+		process_packet(xdp),
+		({
+			if (__bench_result == XDP_TX) {
+				if (strip_encap(xdp, &saved_eth))
+					return XDP_DROP;
+				if (rand_state)
+					randomize_src(xdp, saddr_off, &rand_state);
+			}
+			if (cold_lru) {
+				void *d = (void *)(long)xdp->data;
+				void *de = (void *)(long)xdp->data_end;
+				__u32 *__sa = d + saddr_off;
+
+				if ((void *)(__sa + 1) <= de)
+					*__sa ^= batch_hash;
+			}
+		})
+	);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

