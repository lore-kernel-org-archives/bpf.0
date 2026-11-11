Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382496;
	b=4/J7YeZCSWmiD9JgsVsgHAvne3A7Y7kLVldBGaQX5FFhiesbItjjMPxl55Pyqn0UY5yr
	 70UJIZAHs6PVRk1OKS4tFbscO8fl6kF2hvhCoEvijnSkInp+xaTsZxH2z6RzgmOYZTwMG
	 jOU9/L5/lfY6VwaxGoK2FtGAuUV18c1c8GRlZdfMmZhKGF+kDocVRwtoeikmqBFYJrcL0
	 ihEJ+ygBpT8H2Tk1/lrekB5nfDN/kK0aR6xLSA5WIRk6wX8zu3M7VBpCgH6w1KY92LXiw
	 7Nzdka20QvOb1dW+STHuZ8u6o3aXl+0uA+6E+gifvSJ8Sd+zQtSeLINdcIFRcMfXTeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382496;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3gt4/QsFJtxGBXnQiNdXuVsUGASLunj0dXoaqegNrPo=;
	b=pYNiVbrwmUH706tjHta6lOLpZXrWY+QdAzpueO40mD3fSZhEm2QDIgFij1BBfOkGvv9f
	 25vQtfuLnSej6C507wd17WyuPVo1wVUF/51QCj+N+cyZxk/zhaZoeoWLcez32g0J5ZVG7
	 wvt4ccm7TeOKUTL5ncRCOdcPLzJ+GFt0NLDKL6/if5Xg0eVOzfwNI+ys0ggVWIt0RWqA5
	 0TSu+P+wKXenpU6dzht4EjR1CSDosVNQlZIrx/otaiwdqAaVt4Zei6Nh5/Mzvan+Vp6S3
	 BfbRg/qJdJu/uzNLkz/PH8NWpnNyB4gjNvmdVLZ1y2En/x6/Pm09EeRb1vEugRrLnSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YtWySJoe;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9160A2618;
	Wed, 11 Nov 2026 07:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F9160A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YtWySJoe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=3gt4/QsFJtxGBXnQiNdXuVsUGASLunj0dXoaqegNrPo=;
	t=1794382495; x=2109742495; b=YtWySJoe6k0YGdgc+cLFI2xi/f/yse9LSWFLQ3bAcytLo4D
	/ktBtWP7FJ25M++bJq1qkArgKc3hMtuzFzf5oNi4j84PPKh9AFFIwPwTqrGtGfqnezktWSEu5I0yD
	FBoyZYGpUuZ+rkWzlpWH7l8BnC+izsiP3bWi7aTOaG4O24W/VksbjYdfURHQnFc2zaHaYV291CINa
	m2Xfw51AYFfaO8B/Oj6xnFUmFWpY3vMgoVyVysdQ/OcFXpztVD5hTnHhqlkQxwXNCVbHP6+Oi6f7J
	EBo23OLiOcfvV1fbzOv/0VHv29vPs7FF4gG58TOF/Pb/v6Vg5yzEIZroQ+dk+0jA==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xR2qy-008aZK-9q; Wed, 11 Nov 2026 08:34:45 +0100
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: libarena: Cache the rbtree's leftmost node and count
Date: Wed, 11 Nov 2026 16:34:16 +0900
Message-ID: <20261111073416.203153-4-changwoo@igalia.com>
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

A run queue built on the tree needs lockless peeks at its head and
length, like scx_bpf_dsq_peek() and scx_bpf_dsq_nr_queued() for
sched_ext DSQs.

Keep the leftmost node and the node count in struct rbtree. An insert
changes the head only when it links left of it, and removing the head
hands it to its in-order successor before the tree changes. rb_least()
and rb_pop() use the cached head. rb_first_lockless(),
rb_first_key_lockless() and rb_nr_nodes_lockless() read them without
the lock. The head pointer, published with release ordering, decides
emptiness, and the key is read through it.

Add rb_init() for a tree embedded in another object, such as a queue
that keeps its lock next to the tree, and rb_fini() to empty it, since
rb_destroy() also frees the tree's memory.

Add selftests for the head and count across inserts, removals and
updates, and for an embedded tree.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/rbtree.h    |  50 +++++
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 209 ++++++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   |  94 ++++++--
 3 files changed, 336 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
index 788e25fcd7fd..e34d5a51ae3d 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
@@ -59,11 +59,28 @@ struct rbtree {
 	struct rbnode __arena *root;
 	enum rbtree_alloc alloc;
 	enum rbtree_insert_mode insert;
+
+	/*
+	 * The leftmost node and the node count. The writer keeps them current,
+	 * and readers may read them without the writer's lock (see
+	 * rb_first_lockless() and friends).
+	 */
+	struct rbnode __arena *first;
+	uint64_t nr;
 };
 
 #ifdef __BPF__
 struct rbtree __arena *rb_create(enum rbtree_alloc alloc, enum rbtree_insert_mode insert);
 
+/*
+ * Initialize and finalize a tree embedded in another arena object.
+ * rb_fini() frees the nodes of an RB_ALLOC tree and fails with -EBUSY on a
+ * non-empty RB_NOALLOC tree. It leaves the tree's memory to its owner.
+ */
+int rb_init(struct rbtree __arena *rbtree, enum rbtree_alloc alloc,
+	    enum rbtree_insert_mode insert);
+int rb_fini(struct rbtree __arena *rbtree);
+
 int rb_destroy(struct rbtree __arena *rbtree);
 int rb_insert(struct rbtree __arena *rbtree, u64 key, u64 value);
 int rb_remove(struct rbtree __arena *rbtree, u64 key);
@@ -81,4 +98,37 @@ void rb_node_free(struct rbnode __arena *rbnode);
 
 int rb_integrity_check(struct rbtree __arena *rbtree);
 
+/*
+ * Lockless reads of the head and the node count. They need not be called
+ * under the writer's lock, so they are advisory: the tree may change before
+ * the caller acts on the result. The node rb_first_lockless() returns may
+ * have left the tree, or been freed in an RB_ALLOC tree, by the time the
+ * caller reads it. A caller that dereferences it must keep the node's memory
+ * valid itself, for example by embedding the node in an object that is freed
+ * only after an RCU grace period and reading it inside an RCU read-side
+ * critical section. The count is a separate read and need not agree with the
+ * head.
+ */
+static struct rbnode __arena *rb_first_lockless(struct rbtree __arena *rbtree)
+{
+	return READ_ONCE(rbtree->first);
+}
+
+/* -ENOENT if the tree is empty, 0 with the leftmost key in @key otherwise. */
+static int rb_first_key_lockless(struct rbtree __arena *rbtree, u64 *key)
+{
+	struct rbnode __arena *first = READ_ONCE(rbtree->first);
+
+	if (!first)
+		return -ENOENT;
+
+	*key = READ_ONCE(first->key);
+	return 0;
+}
+
+static u64 rb_nr_nodes_lockless(struct rbtree __arena *rbtree)
+{
+	return READ_ONCE(rbtree->nr);
+}
+
 #endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
index a92b00f799f8..4da6f293e286 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
@@ -285,6 +285,146 @@ __weak int test_rbtree_duplicate_fifo(void)
 	return rb_destroy(rbtree);
 }
 
+/*
+ * Check the lockless head and count against a walk to the leftmost node,
+ * which does not use the cached head.
+ */
+__weak int rbtree_check_first(struct rbtree __arena *rbtree, u64 nr)
+{
+	struct rbnode __arena *least = rbtree->root;
+	u64 key;
+
+	while (least && least->left && can_loop)
+		least = least->left;
+
+	if (rb_first_lockless(rbtree) != least)
+		return 1;
+
+	if (rb_nr_nodes_lockless(rbtree) != nr)
+		return 2;
+
+	if (!least)
+		return rb_first_key_lockless(rbtree, &key) == -ENOENT ? 0 : 3;
+
+	if (rb_first_key_lockless(rbtree, &key) || key != least->key)
+		return 4;
+
+	return 0;
+}
+
+#define FIRST_NR_NODES	64
+
+static struct rbnode __arena *first_nodes[FIRST_NR_NODES];
+
+SEC("syscall")
+__weak int test_rbtree_first(void)
+{
+	struct rbtree __arena *rbtree;
+	struct rbnode __arena *node;
+	u64 seed = 12345, nr = 0;
+	int ret, i;
+
+	rbtree = rb_create(RB_NOALLOC, RB_DUPLICATE);
+	if (!rbtree)
+		return 1;
+
+	ret = rbtree_check_first(rbtree, 0);
+	if (ret)
+		return 10 + ret;
+
+	/* Pseudo-random keys with repeats, so the head moves and gets ties. */
+	for (i = 0; i < FIRST_NR_NODES && can_loop; i++) {
+		seed = seed * 6364136223846793005ULL + 1442695040888963407ULL;
+		node = rb_node_alloc((seed >> 33) % 32, i);
+		if (!node)
+			return 2;
+
+		first_nodes[i] = node;
+
+		ret = rb_insert_node(rbtree, node);
+		if (ret)
+			return 3;
+
+		ret = rbtree_check_first(rbtree, ++nr);
+		if (ret)
+			return 20 + ret;
+	}
+
+	/* Remove every other node in insertion order, head or not. */
+	for (i = 0; i < FIRST_NR_NODES && can_loop; i += 2) {
+		ret = rb_remove_node(rbtree, first_nodes[i]);
+		if (ret)
+			return 4;
+
+		rb_node_free(first_nodes[i]);
+
+		ret = rbtree_check_first(rbtree, --nr);
+		if (ret)
+			return 30 + ret;
+	}
+
+	/* Remove the head of the remaining half, emptying the tree. */
+	for (i = 0; i < FIRST_NR_NODES / 2 && can_loop; i++) {
+		node = rb_first_lockless(rbtree);
+		if (!node)
+			return 5;
+
+		ret = rb_remove_node(rbtree, node);
+		if (ret)
+			return 6;
+
+		rb_node_free(node);
+
+		ret = rbtree_check_first(rbtree, --nr);
+		if (ret)
+			return 40 + ret;
+	}
+
+	return rb_destroy(rbtree);
+}
+
+SEC("syscall")
+__weak int test_rbtree_first_update(void)
+{
+	struct rbtree __arena *rbtree;
+	struct rbnode __arena *node;
+	int ret;
+
+	rbtree = rb_create(RB_ALLOC, RB_UPDATE);
+	if (!rbtree)
+		return 1;
+
+	if (rb_insert(rbtree, 5, 1))
+		return 2;
+
+	if (rb_insert(rbtree, 5, 2))
+		return 3;
+
+	node = rb_first_lockless(rbtree);
+	if (!node || node->key != 5 || node->value != 2)
+		return 4;
+
+	ret = rbtree_check_first(rbtree, 1);
+	if (ret)
+		return 10 + ret;
+
+	if (rb_insert(rbtree, 3, 3))
+		return 5;
+
+	ret = rbtree_check_first(rbtree, 2);
+	if (ret)
+		return 20 + ret;
+
+	if (rb_remove(rbtree, 3) || rb_remove(rbtree, 5))
+		return 6;
+
+	ret = rbtree_check_first(rbtree, 0);
+	if (ret)
+		return 30 + ret;
+
+	return rb_destroy(rbtree);
+}
+
 #define NEXT_NR_NODES	64
 
 static struct rbnode __arena *next_nodes[NEXT_NR_NODES];
@@ -342,6 +482,75 @@ __weak int test_rbtree_next(void)
 	return rb_destroy(rbtree);
 }
 
+struct rb_embed {
+	u64 pad;
+	struct rbtree tree;
+};
+
+SEC("syscall")
+__weak int test_rbtree_embedded(void)
+{
+	struct rb_embed __arena *embed;
+	struct rbtree __arena *rbtree;
+	struct rbnode __arena *node;
+	int ret, i;
+
+	embed = arena_malloc(sizeof(*embed));
+	if (!embed)
+		return 1;
+
+	rbtree = &embed->tree;
+
+	/* Poison the fields rb_init() must set. */
+	WRITE_ONCE(rbtree->root, (struct rbnode __arena *)~0ULL);
+	WRITE_ONCE(rbtree->first, (struct rbnode __arena *)~0ULL);
+	WRITE_ONCE(rbtree->nr, ~0ULL);
+
+	if (rb_init(rbtree, RB_NOALLOC, RB_DUPLICATE))
+		return 2;
+
+	ret = rbtree_check_first(rbtree, 0);
+	if (ret)
+		return 10 + ret;
+
+	for (i = 0; i < 4 && can_loop; i++) {
+		node = rb_node_alloc(4 - i, i);
+		if (!node)
+			return 3;
+
+		if (rb_insert_node(rbtree, node))
+			return 4;
+
+		ret = rbtree_check_first(rbtree, i + 1);
+		if (ret)
+			return 20 + ret;
+	}
+
+	if (rb_fini(rbtree) != -EBUSY)
+		return 7;
+
+	for (i = 0; i < 4 && can_loop; i++) {
+		node = rb_first_lockless(rbtree);
+		if (!node || node->key != i + 1)
+			return 5;
+
+		if (rb_remove_node(rbtree, node))
+			return 6;
+
+		rb_node_free(node);
+
+		ret = rbtree_check_first(rbtree, 3 - i);
+		if (ret)
+			return 30 + ret;
+	}
+
+	if (rb_fini(rbtree))
+		return 8;
+
+	arena_free(embed);
+	return 0;
+}
+
 static inline int
 clean_up_noalloc_tree(struct rbtree __arena *rbtree)
 {
diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
index bf39cb2aa751..90fa0036e9d2 100644
--- a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
@@ -15,14 +15,12 @@ static int rbnode_replace(struct rbtree __arena *rbtree,
 			  struct rbnode __arena *existing,
 			  struct rbnode __arena *replacement);
 
-struct rbtree __arena *rb_create(enum rbtree_alloc alloc,
-				 enum rbtree_insert_mode insert)
+__weak
+int rb_init(struct rbtree __arena *rbtree, enum rbtree_alloc alloc,
+	    enum rbtree_insert_mode insert)
 {
-	struct rbtree __arena *rbtree;
-
-	rbtree = arena_malloc(sizeof(*rbtree));
 	if (unlikely(!rbtree))
-		return NULL;
+		return -EINVAL;
 
 	/*
 	 * RB_UPDATE overwrites existing values in the nodes, but RB_NOALLOC
@@ -32,19 +30,47 @@ struct rbtree __arena *rb_create(enum rbtree_alloc alloc,
 	 */
 	if (alloc == RB_NOALLOC && insert == RB_UPDATE) {
 		arena_stderr("WARNING: Cannot combine RB_NOALLOC and RB_UPDATE");
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(rbtree->root, NULL);
+	WRITE_ONCE(rbtree->alloc, alloc);
+	WRITE_ONCE(rbtree->insert, insert);
+	WRITE_ONCE(rbtree->first, NULL);
+	WRITE_ONCE(rbtree->nr, 0);
+
+	return 0;
+}
+
+struct rbtree __arena *rb_create(enum rbtree_alloc alloc,
+				 enum rbtree_insert_mode insert)
+{
+	struct rbtree __arena *rbtree;
+
+	rbtree = arena_malloc(sizeof(*rbtree));
+	if (unlikely(!rbtree))
+		return NULL;
+
+	if (rb_init(rbtree, alloc, insert)) {
 		arena_free(rbtree);
 		return NULL;
 	}
 
-	rbtree->alloc = alloc;
-	rbtree->insert = insert;
-	rbtree->root = NULL;
-
 	return rbtree;
 }
 
+static void rb_set_first(struct rbtree __arena *rbtree,
+			 struct rbnode __arena *node)
+{
+	/*
+	 * Publish the new leftmost node with release ordering, so a lockless
+	 * reader that sees it also sees the node's fields.
+	 */
+	smp_store_release(&rbtree->first, node);
+}
+
 __weak
-int rb_destroy(struct rbtree __arena *rbtree)
+int rb_fini(struct rbtree __arena *rbtree)
 {
 	int ret = 0;
 
@@ -63,11 +89,11 @@ int rb_destroy(struct rbtree __arena *rbtree)
 		 * the now freed nodes. Throw an error instead.
 		 */
 		if (rbtree->root) {
-			arena_stderr("WARNING: Destroying RB_NOALLOC tree with > 0 nodes");
+			arena_stderr("WARNING: Finalizing RB_NOALLOC tree with > 0 nodes");
 			return -EBUSY;
 		}
 
-		goto out;
+		return 0;
 	}
 
 	while (rbtree->root && can_loop) {
@@ -76,11 +102,22 @@ int rb_destroy(struct rbtree __arena *rbtree)
 			break;
 	}
 
-out:
-	arena_free(rbtree);
 	return ret;
 }
 
+__weak
+int rb_destroy(struct rbtree __arena *rbtree)
+{
+	int ret;
+
+	ret = rb_fini(rbtree);
+	if (ret)
+		return ret;
+
+	arena_free(rbtree);
+	return 0;
+}
+
 static inline int rbnode_dir(struct rbnode __arena *node)
 {
 	/* Arbitrarily choose a direction for the root. */
@@ -249,6 +286,8 @@ int rb_node_insert(struct rbtree __arena *rbtree,
 
 	if (!parent) {
 		rbtree->root = node;
+		rb_set_first(rbtree, node);
+		WRITE_ONCE(rbtree->nr, 1);
 		return 0;
 	}
 
@@ -267,6 +306,10 @@ int rb_node_insert(struct rbtree __arena *rbtree,
 			if (ret)
 				return ret;
 
+			/* Same key and place, so only the head's identity changes. */
+			if (rbtree->first == parent)
+				rb_set_first(rbtree, node);
+
 			if (rbtree->alloc == RB_ALLOC)
 				rb_node_free(parent);
 
@@ -284,6 +327,14 @@ int rb_node_insert(struct rbtree __arena *rbtree,
 	else
 		parent->right = node;
 
+	/*
+	 * The node is the new head only if it went left of the old one. The
+	 * rotations below never change which node is leftmost.
+	 */
+	if (parent == rbtree->first && parent->left == node)
+		rb_set_first(rbtree, node);
+	WRITE_ONCE(rbtree->nr, rbtree->nr + 1);
+
 	while (can_loop) {
 		parent = node->parent;
 		if (!parent)
@@ -404,7 +455,7 @@ __weak int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value)
 	if (!rbtree->root)
 		return -ENOENT;
 
-	least = rbnode_least(rbtree->root);
+	least = rbtree->first;
 	if (key)
 		*key = least->key;
 	if (value)
@@ -601,6 +652,15 @@ int rb_node_remove(struct rbtree __arena *rbtree,
 	bool is_red;
 	int dir;
 
+	/*
+	 * Hand the head to its successor before the tree changes. The removal
+	 * frees @node in an RB_ALLOC tree, so the head must not point to it
+	 * by then.
+	 */
+	if (rbtree->first == node)
+		rb_set_first(rbtree, rb_next(node));
+	WRITE_ONCE(rbtree->nr, rbtree->nr - 1);
+
 	/* Both children present, replace with next largest key. */
 	if (node->left && node->right) {
 		/*
@@ -827,7 +887,7 @@ int rb_pop(struct rbtree __arena *rbtree, u64 *key, u64 *value)
 	if (rbtree->alloc != RB_ALLOC)
 		return -EINVAL;
 
-	node = rbnode_least(rbtree->root);
+	node = rbtree->first;
 	if (unlikely(!node))
 		return -ENOENT;
 
-- 
2.56.0

