Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167269;
	b=11KdUwu50rEZzMdK0O435t6AIgTjdrPOMd0/qXwf4txNigaN/H1o5wMDnMTWR/yil1we
	 pD1v7YQPdykjxIOiU4v36dDv8nEUFAiwLYs/UWaYd6I6CI7b9vwayqU80xMUw94eg01P4
	 kV6WTpA3aaXiGik+IYAskVkbkkqY9YoqnXvj416+gxbcegbaIwP0P5ozYgjgfmK4+Hs/E
	 ltrSUTinozeJvFvOL3N01bfrX+CDJLdLeRh2NSgNrQvFCa1QbeK2Rr4Yy9t4W+DhMVawz
	 g2dWAe8uvJEiCTuFlOEvKmtlfCgPBRMg1SEkfiALtFKjy1Q+h6aUg1BoU3/Z6XNK9lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167269;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=84Bn2Cf6EqABafANereiG8E0SsGFJGqQ6GZUSuDqBf8=;
	b=R+OJdiZ5UskneNVwQyVQSUA+NOFwK51k7caW2qqHQrB5KvaNhM6ejArrgwPv13iB9Ety
	 Y6U6zNxadAkiRSQUsZTdkTIa0XgMy87tpNakATmw5wfSMb9uA/w1Mc4772sR/mdFUJ2P0
	 uNqmL2hg6E4tip8xGNb2lZugs/NEI9+4kHAMUkPWVilPTnV+GA2SIlUgItAspg0sMLEIc
	 9TRvH66xMx90+pXGCrCKuM804I1GjKT7S+aTZ+JJk0nCVL/SvfJ+qTBZeSkJs9n6AhG4V
	 W2hRNyNAky5ub+Wf7Y7D8lY+YASAD7uHK/wjtBXEly+I6lbn1VkkmAdTRGxwuF2RYIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=G50fdtRa;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9333606A31D;
	Wed, 28 Oct 2026 06:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9333606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=G50fdtRa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=84Bn2Cf6EqABafANereiG8E0SsGFJGqQ6GZUSuDqBf8=; b=
	G50fdtRa8wTyuAvMeYEo+S30zeCB8FwXN0oROcbZXEn2T5nRrTsI96+Q8Ju+4n1yxSj1mZa0L79YD
	g01XrvGgKhzl4Z1SKwu9uIbJ1g26cjzWZwXWFKc4kNKTqttTKoDry0iPSK69p3zVL3arAuj5nyOxX
	/bn/O4rULzfBEZEABOxq9MlF08JBVYb5HIEkl6/ETqGZaBkvKYM/WJyNwfIRq67J0eUWsC2N9+uWO
	dJtMz+5xCX5+DELtFTb+fQC583V6WzCzypVoMpIeRmeh3bd+JVFwHVPK2UOPoS2A6JKExDVnn1CHa
	pt15Bz1X4VZ9xjyYn3megJGy/q2isg4cVA==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xLwiY-00CYmD-VK; Wed, 28 Oct 2026 07:01:00 +0100
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
Subject: [PATCH bpf-next 1/3] selftests/bpf: libarena: Order equal rbtree keys FIFO
Date: Wed, 28 Oct 2026 15:00:44 +0900
Message-ID: <20261028060046.549097-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028060046.549097-1-changwoo@igalia.com>
References: <20261028060046.549097-1-changwoo@igalia.com>
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

An RB_DUPLICATE tree links a new key to the left of an equal one, so
rb_least() and rb_pop() return the newest of several equal keys. A
queue of tasks keyed by vtime should instead serve equal keys in
arrival order, as sched_ext's vtime-ordered DSQs do.

Send equal keys right on insert, as the kernel's rb_add() does. A new
node then lands after every node with an equal key. Rotations and
removals preserve the in-order sequence, so equal keys stay in
insertion order without a tie-break field.

Add a selftest that interleaves equal keys while the tree grows and
checks the pop order.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../bpf/libarena/include/libarena/rbtree.h    |  6 +--
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 37 +++++++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 16 +++++---
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
index 486428911d96..00e63b12d82e 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
@@ -45,9 +45,9 @@ enum rbtree_alloc {
  * the existing node.
  *
  * RB_DUPLICATE: Allow nodes with identical keys in the rbtree.
- * Finding/popping/removing a key acts on any of the nodes
- * with the appropriate key - there is no ordering by time
- * of insertion.
+ * Nodes with identical keys are kept in insertion order, so
+ * rb_least() and rb_pop() return the oldest of them. Finding
+ * or removing by key acts on any of them.
  */
 enum rbtree_insert_mode {
 	RB_DEFAULT,
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
index 856c484a009a..1e2a0fac1e4f 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
@@ -248,6 +248,43 @@ __weak int test_rbtree_duplicate(void)
 	return rb_destroy(rbtree);
 }
 
+#define FIFO_NR_NODES	64
+#define FIFO_NR_KEYS	4
+
+SEC("syscall")
+__weak int test_rbtree_duplicate_fifo(void)
+{
+	const u64 per_key = FIFO_NR_NODES / FIFO_NR_KEYS;
+	struct rbtree __arena *rbtree;
+	u64 key, value;
+	int ret, i;
+
+	rbtree = rb_create(RB_ALLOC, RB_DUPLICATE);
+	if (!rbtree)
+		return 1;
+
+	for (i = 0; i < FIFO_NR_NODES && can_loop; i++) {
+		ret = rb_insert(rbtree, i % FIFO_NR_KEYS, i);
+		if (ret)
+			return 2;
+	}
+
+	for (i = 0; i < FIFO_NR_NODES && can_loop; i++) {
+		ret = rb_pop(rbtree, &key, &value);
+		if (ret)
+			return 3;
+
+		/* All of key 0 in insertion order, then all of key 1, ... */
+		if (key != i / per_key)
+			return 4;
+
+		if (value != key + FIFO_NR_KEYS * (i % per_key))
+			return 5;
+	}
+
+	return rb_destroy(rbtree);
+}
+
 static inline int
 clean_up_noalloc_tree(struct rbtree __arena *rbtree)
 {
diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
index 7f0f6dc3e17d..e6c9430f734b 100644
--- a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
@@ -161,8 +161,14 @@ struct rbnode __arena *rbnode_find(struct rbnode __arena *subtree, u64 key)
 	return node;
 }
 
+/*
+ * Find the node to link @key under. Smaller keys go left and everything else
+ * right, so a new key lands after every node with an equal key and equal keys
+ * stay in insertion order. Rotations and removals preserve the in-order
+ * sequence, so they keep that order too.
+ */
 static
-struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *subtree, uint64_t key)
+struct rbnode __arena *rbnode_insert_parent(struct rbnode __arena *subtree, uint64_t key)
 {
 	struct rbnode __arena *node = subtree;
 	int dir;
@@ -171,7 +177,7 @@ struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *subtree,
 		return NULL;
 
 	while (can_loop) {
-		dir = (key <= node->key) ? 0 : 1;
+		dir = (key < node->key) ? 0 : 1;
 
 		if (!node->child[dir])
 			break;
@@ -255,7 +261,7 @@ int rb_node_insert(struct rbtree __arena *rbtree,
 	if (rbtree->insert != RB_DUPLICATE)
 		parent = rbnode_find(parent, key);
 	else
-		parent = rbnode_least_upper_bound(parent, key);
+		parent = rbnode_insert_parent(parent, key);
 
 	if (key == parent->key && rbtree->insert != RB_DUPLICATE) {
 		if (rbtree->insert == RB_UPDATE) {
@@ -278,8 +284,8 @@ int rb_node_insert(struct rbtree __arena *rbtree,
 	}
 
 	node->parent = parent;
-	/* Also works if key == parent->key. */
-	if (key <= parent->key)
+	/* An equal key goes right, after the existing ones. */
+	if (key < parent->key)
 		parent->left = node;
 	else
 		parent->right = node;
-- 
2.56.0

