Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791E3ACF18
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332228; cv=none; b=kqaNca2Hzj2rfNKBjnrq2TJFugNzVUgjIqmYNaZYMQqpWbZznh2X09GJetwARPO38m361jl6zQurrTdiOJxGhYCuO+8VAw0K7Wvaj+eWlXWn8d7c7CyrNT8S88E+B5V0Xg2lHWOJwUpU86Pupwd1tpe0fExCYHuOB6cIfKYZ+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332228; c=relaxed/simple;
	bh=xvbhnBRd6wieZQaXWKr6XODAoOC3IeKTneQHSCvOqnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lShCFpYy3KsRJTZEr620fg6xNcmMLHZbXOoxryYCQCU9mUSixZUVpSm465ehGjX+hbrW5OkfIAKMRCKSXuSy1PjYqOsJqFdzTpDX3fU5KqXvwXlbNHmJIwVXsNjIVPjpk4QAzoSP9molCd8f1NXHSnSKf+VRZZ/Ryr5ANxb7hvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkv9wTsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkv9wTsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278EFC19425;
	Mon, 27 Apr 2026 23:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332228;
	bh=xvbhnBRd6wieZQaXWKr6XODAoOC3IeKTneQHSCvOqnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkv9wTsfb3a9NR1ADhjJ4jffK7WzmDvmM/+DrXIvdT/ZpKJKWbwLEYbxZDwX/MJ2d
	 eaY2qdrAADlFMaXH0kkxuTY3VqNCT+lUE11wZtp2FmpdRenRe9VPnTHoc6ePhbZg6y
	 JVp5uWTkmT0GqbVSiKGuxJbgAQ/1/qGold+DIO7+RxwRK4s1QLT0TLATdHBH0Od5SU
	 cppJAgoZad9q7BjYTyesUtfxIDmBR/DKvuDaPDTa+672QDMEK0xMm9LE2GGMOsU0dl
	 uuIoyuy++rhtMxfiMq8JRz5ZbOVnBWcP5eVBRjIdesy3Gs3jTw3q86fK0q6ho+dWBJ
	 OX5S+yFpIR5Ng==
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
Subject: [PATCH bpf-next 4/7] selftests/bpf: Add XDP load-balancer common definitions
Date: Mon, 27 Apr 2026 16:23:01 -0700
Message-ID: <20260427232313.1582588-5-puranjay@kernel.org>
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

Add the shared header for the XDP load-balancer benchmark.  This
defines the data structures used by both the BPF program and
userspace: flow_key, vip_definition, real_definition, and the
stats/control structures.

Also provides the encapsulation source-address helpers shared
between the BPF datapath (for encap) and userspace (for building
expected output packets used in validation).

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/xdp_lb_bench_common.h       | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/xdp_lb_bench_common.h

diff --git a/tools/testing/selftests/bpf/xdp_lb_bench_common.h b/tools/testing/selftests/bpf/xdp_lb_bench_common.h
new file mode 100644
index 000000000000..aed20a963701
--- /dev/null
+++ b/tools/testing/selftests/bpf/xdp_lb_bench_common.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef XDP_LB_BENCH_COMMON_H
+#define XDP_LB_BENCH_COMMON_H
+
+#define F_IPV6		(1 << 0)
+#define F_LRU_BYPASS	(1 << 1)
+
+#define CH_RING_SIZE	65537		/* per-VIP consistent hash ring slots */
+#define MAX_VIPS	16
+#define CH_RINGS_SIZE	(MAX_VIPS * CH_RING_SIZE)
+#define MAX_REALS	512
+#define DEFAULT_LRU_SIZE 100000		/* connection tracking cache size */
+#define ONE_SEC		1000000000U	/* 1 sec in nanosec */
+#define MAX_CONN_RATE	100000000	/* high enough to never trigger in bench */
+#define LRU_UDP_TIMEOUT	30000000000ULL	/* 30 sec in nanosec */
+#define PCKT_FRAGMENTED	0x3FFF
+#define KNUTH_HASH_MULT	2654435761U
+#define IPIP_V4_PREFIX	4268		/* 172.16/12 in network order */
+#define IPIP_V6_PREFIX1	1		/* 0100::/64 (RFC 6666 discard) */
+#define IPIP_V6_PREFIX2	0
+#define IPIP_V6_PREFIX3	0
+
+/* Stats indices (0..MAX_VIPS-1 are per-VIP packet/byte counters) */
+#define STATS_LRU	(MAX_VIPS + 0)	/* v1: total VIP packets, v2: LRU misses */
+#define STATS_XDP_TX	(MAX_VIPS + 1)
+#define STATS_XDP_PASS	(MAX_VIPS + 2)
+#define STATS_XDP_DROP	(MAX_VIPS + 3)
+#define STATS_NEW_CONN	(MAX_VIPS + 4)	/* v1: conn count, v2: last reset ts */
+#define STATS_LRU_MISS	(MAX_VIPS + 5)	/* v1: TCP LRU misses */
+#define STATS_SIZE	(MAX_VIPS + 6)
+
+#ifdef __BPF__
+#define lb_htons(x)	bpf_htons(x)
+#define LB_INLINE	static __always_inline
+#else
+#define lb_htons(x)	htons(x)
+#define LB_INLINE	static inline
+#endif
+
+LB_INLINE __be32 create_encap_ipv4_src(__u16 port, __be32 src)
+{
+	__u32 ip_suffix = lb_htons(port);
+
+	ip_suffix <<= 16;
+	ip_suffix ^= src;
+	return (0xFFFF0000 & ip_suffix) | IPIP_V4_PREFIX;
+}
+
+LB_INLINE void create_encap_ipv6_src(__u16 port, __be32 src, __be32 *saddr)
+{
+	saddr[0] = IPIP_V6_PREFIX1;
+	saddr[1] = IPIP_V6_PREFIX2;
+	saddr[2] = IPIP_V6_PREFIX3;
+	saddr[3] = src ^ port;
+}
+
+struct flow_key {
+	union {
+		__be32 src;
+		__be32 srcv6[4];
+	};
+	union {
+		__be32 dst;
+		__be32 dstv6[4];
+	};
+	union {
+		__u32 ports;
+		__u16 port16[2];
+	};
+	__u8 proto;
+	__u8 pad[3];
+};
+
+struct vip_definition {
+	union {
+		__be32 vip;
+		__be32 vipv6[4];
+	};
+	__u16 port;
+	__u8 proto;
+	__u8 pad;
+};
+
+struct vip_meta {
+	__u32 flags;
+	__u32 vip_num;
+};
+
+struct real_pos_lru {
+	__u32 pos;
+	__u64 atime;
+};
+
+struct real_definition {
+	__be32 dst;
+	__be32 dstv6[4];
+	__u8   flags;
+};
+
+struct lb_stats {
+	__u64 v1;
+	__u64 v2;
+};
+
+struct ctl_value {
+	__u8 mac[6];
+	__u8 pad[2];
+};
+
+#endif /* XDP_LB_BENCH_COMMON_H */
-- 
2.52.0

