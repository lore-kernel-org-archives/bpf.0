Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382487;
	b=gTZQilMN0RgWbVUeIb+4IIjBnsU82iCia23M9fBVQ4SewhfLN02N76pV46T4aWnFjYOY
	 ksime0qT90QjLc0SVxUmZ5m0mneXHpLIjz7vLZgDk8oPAxQBDzap36IZ3Y3IDnlK5b3sx
	 YdsfB51Ucx1XX36u6Oj9/CiEYs+5oPB/5WFQu5IYDPFFnhl5F1yD5/hE/5GCQMPbRMi2T
	 Lp/tIBvfVcTK6aT37b5yixrgGf7moWPAhDHYTsA2zLI/Jh4AhfLpA7dIyclgUBk2HSDs3
	 8N8VbKIxetoZymeOuh3EqeNKgMMKkHkcSsezPdOZoqEVBrFO8eP+8IN5V/AQcXQsCog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382487;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ms9BPHkoaP+qtvZ2CK2xTYT/SNrV2XAl7Rjaysi6YTs=;
	b=SA0RKtIC0fAGxYRn/Qrp0xE6cnHCz9DZiQKDCvVOq1g/Nar2tMRsNimmjghB4rsT6Spq
	 DoLy6MdJ2yu9fz00UenvtUKgGi+3Lf7JPfj5pEO9mb1Pg+RyuMd6EvRNK3i5YtaM7KQLq
	 pTvl3Iw8zev+T1AsVQaFyAP4n+1p6kgHEOYRSRZGBXClm0wYHCUWfdMSpYeWlSOVfMljH
	 UKHHsD3d9ALoqTosHRzhZL/2m9MjKd55Dbex90gwQK2rpGQd1vRJ1yPhDQB1uGIr0Wd26
	 z3qkEx5rlysiL6T7lqiDzb3a+yI++xIbDrKxHvKNqapJj2lWTMg7VSeAqAjUFrXO0sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AEPFmlyP;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA160A2610;
	Wed, 11 Nov 2026 07:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AA160A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AEPFmlyP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=Ms9BPHkoaP+qtvZ2CK2xTYT/SNrV2XAl7Rjaysi6YTs=;
	t=1794382487; x=2109742487; b=AEPFmlyPQIpxAS/AV96nXZJXwfZ+yAqJ2Qecv2hztbsFNy6
	Oy9x5QcL5plhVP/tMryuOZolYMNuLQ67xebXDWbIeW4a4isqbbVK9lBIyWos0Oiav0Od9MNp83Gy7
	SPpsSTyWQsGuXNVbBBQKaRaTCepMzdmuPJl3XGBKhbxppaF81+yx9AAR2ZYgbPtHkz+3U1WrPpGbJ
	MKZTPAYt9nx1AgQCHITI6fcXVuTb3sBLI4auUHMYHGasMMIQpli6zEsHAY+uEgO1X5akfUZWHr1Fd
	/u+hX8GgXOM2C59NRhNT5iCE64JjRkVKX2Ul1XsW8orncp8VoHm4IDQsTFioeb2w==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xR2qs-008aYr-8H; Wed, 11 Nov 2026 08:34:39 +0100
From: Changwoo Min <changwoo@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	david.dai@linux.dev,
	Gavin Guo <gavinguo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: libarena: Add rb_next()
Date: Wed, 11 Nov 2026 16:34:15 +0900
Message-ID: <20261111073416.203153-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111073416.203153-1-changwoo@igalia.com>
References: <20261111073416.203153-1-changwoo@igalia.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rb_next(), the in-order successor through parent pointers.

Add a selftest that walks a tree with repeated keys and checks the walk
against the order in which the head leaves the tree.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/rbtree.h    |  1 +
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 57 +++++++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 20 +++++++
 3 files changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
index 00e63b12d82e..788e25fcd7fd 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
@@ -71,6 +71,7 @@ int rb_find(struct rbtree __arena *rbtree, u64 key, u64 *value);
 int rb_print(struct rbtree __arena *rbtree);
 int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value);
 int rb_pop(struct rbtree __arena *rbtree, u64 *key, u64 *value);
+struct rbnode __arena *rb_next(struct rbnode __arena *node);
 
 int rb_insert_node(struct rbtree __arena *rbtree, struct rbnode __arena *node);
 int rb_remove_node(struct rbtree __arena *rbtree, struct rbnode __arena *node);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
index 1e2a0fac1e4f..a92b00f799f8 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
@@ -285,6 +285,63 @@ __weak int test_rbtree_duplicate_fifo(void)
 	return rb_destroy(rbtree);
 }
 
+#define NEXT_NR_NODES	64
+
+static struct rbnode __arena *next_nodes[NEXT_NR_NODES];
+
+SEC("syscall")
+__weak int test_rbtree_next(void)
+{
+	struct rbtree __arena *rbtree;
+	struct rbnode __arena *node;
+	u64 seed = 0xcafe, value;
+	int i;
+
+	rbtree = rb_create(RB_NOALLOC, RB_DUPLICATE);
+	if (!rbtree)
+		return 1;
+
+	/* Pseudo-random keys with repeats, so the walk crosses equal keys. */
+	for (i = 0; i < NEXT_NR_NODES && can_loop; i++) {
+		/* LCG using Knuth's MMIX constants for determinism. */
+		seed = seed * 6364136223846793005ULL + 1442695040888963407ULL;
+		node = rb_node_alloc((seed >> 33) % 16, i);
+		if (!node)
+			return 2;
+
+		if (rb_insert_node(rbtree, node))
+			return 3;
+	}
+
+	/* Start the walk at the leftmost node. */
+	node = rbtree->root;
+	while (node->left && can_loop)
+		node = node->left;
+
+	for (i = 0; i < NEXT_NR_NODES && can_loop; i++) {
+		if (!node)
+			return 4;
+
+		next_nodes[i] = node;
+		node = rb_next(node);
+	}
+
+	if (node)
+		return 5;
+
+	for (i = 0; i < NEXT_NR_NODES && can_loop; i++) {
+		if (rb_least(rbtree, NULL, &value) || value != next_nodes[i]->value)
+			return 6;
+
+		if (rb_remove_node(rbtree, next_nodes[i]))
+			return 7;
+
+		rb_node_free(next_nodes[i]);
+	}
+
+	return rb_destroy(rbtree);
+}
+
 static inline int
 clean_up_noalloc_tree(struct rbtree __arena *rbtree)
 {
diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
index 831a1ef1c2a1..bf39cb2aa751 100644
--- a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
@@ -413,6 +413,26 @@ __weak int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value)
 	return 0;
 }
 
+/*
+ * Return the in-order successor of @node, or NULL if @node is the last one.
+ * Walking from the leftmost node with it visits the tree in key order, equal
+ * keys in insertion order. Call it under the writer's lock.
+ */
+__weak
+struct rbnode __arena *rb_next(struct rbnode __arena *node)
+{
+	struct rbnode __arena *parent;
+
+	if (node->right)
+		return rbnode_least(node->right);
+
+	/* Climb until we leave a left subtree; its parent comes next. */
+	while ((parent = node->parent) && node == parent->right && can_loop)
+		node = parent;
+
+	return parent;
+}
+
 
 /*
  * If we are referencing ourselves, a and b have a parent-child relation,
-- 
2.56.0

