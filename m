Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167280;
	b=uAcsFA7vm2uB7ZGAfw2Gfy7LQ10FZAf/GmYNjJcJBaaTBCtlsAy+8nV03enSVx3zxBEK
	 ucWGTmj7xqaIfyb9O4pIccgrroFX7aNlPuP7cgLuljwtpQpUqnNfoACFKZZ7rGwpV6ZN/
	 NFZ0YmsDtO22bj/Yj+rWMjRbHuu/5T1ghgpPZQnCjBDhh6XRY9gYCr5qQb3rMoiDJ+giD
	 HNv5G0Ycd9orDS7/KhsxoRxmVPRfZIVXzHZyTFq545CAr5yx1GRmgeF3cEK/9P0vf1GcN
	 WW59o5TG77lNJ3ktcYTzqGmcVJFMRE0FO6bCaamRgk09UnQPz1+a/f4K1aW/dhxNvnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167280;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zpqLEr10AHuRXeZNCHfpvRJOss9BKxjiTn64h+8gkzw=;
	b=IC+fd/W13XDD0fVQT31uskBu4/ipNxwhw8CHhUMGaY4v0tboaqa1wen3wXrjPVbi+s4l
	 Mnf/bJGmRGspBdKLEc6D3OOin8vkmtr887JLmaEKMRXAY5nRzXhhiebKrsa4ufGwWGQ72
	 KHf8GKJTJ3RXbvAjR25+XwRc7sryrIGQq6r8lSfHzVgVsn+w6KJmyIfUE631nbyJvs0q0
	 9Bh/q7WBeLIaN22XoVVY6RhlUFfRnLZvTmj3ovwRvr8W6KYF1/ogysuaztOY8l6znheE4
	 UkK4TflP+TvhLaC11K6nXDvHqosjcsCiabuTM1NGmmRKVk/TbspmHJ4YkQoY8qgcCig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=P82kOYxS;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B6606A32A;
	Wed, 28 Oct 2026 06:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B3B6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=P82kOYxS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=zpqLEr10AHuRXeZNCHfpvRJOss9BKxjiTn64h+8gkzw=; b=
	P82kOYxSQ8mzq6Fpn+8X0WpRd8NxiJSZ/j283T3+iWZbbtX4QKo+rjgsI8LLlURE4a+7zrW3IWAlO
	VIZWHhPkTszos/B46qDoXMztH1peBxdfFMcoVCgfFUE9H1w+BOud7VVjsyNZiTE9k3lio0/ux/ntv
	80ezYv+OMMvfSpUal21zcB5MmuYdfUH3Gr5WTtj9vUW26QBLRXPqoWMnWNVVh24zXBvfaEaSYa6rr
	+DirXmRcV6dzEiMEpW7OtkZWXLFSAQDS7qtnxYBLTyrER+7mEB0pP0NlWwHUoF/U65A5Crsbufo88
	Cg5U57XeZyJ3bODsMknCPNqUA8T5XR4wvg==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xLwig-00CYmU-Ut; Wed, 28 Oct 2026 07:01:07 +0100
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
Subject: [PATCH bpf-next 2/3] selftests/bpf: libarena: Cache the rbtree's leftmost node and count
Date: Wed, 28 Oct 2026 15:00:45 +0900
Message-ID: <20261028060046.549097-3-changwoo@igalia.com>
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

A run queue built on the tree needs lockless peeks at its head and
length, like scx_bpf_dsq_peek() and scx_bpf_dsq_nr_queued() for
sched_ext DSQs.

Keep the leftmost node and the node count in struct rbtree. An insert
changes the head only when it links left of it, and removing the head
hands it to its in-order successor. rb_least() and rb_pop() use the
cached head. rb_first(), rb_first_key() and rb_nr_nodes() read them
without the lock. The head pointer, published with release ordering,
decides emptiness, and the key is read through it. Both fields sit on
their own cache line.

Add rb_init() for a tree embedded in another object, such as a queue
that keeps its lock next to the tree, and rb_fini() to empty it, since
rb_destroy() also frees the tree's memory.

Add selftests for the head and count across inserts, removals and
updates, and for an embedded tree.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../bpf/libarena/include/libarena/rbtree.h    |  53 +++++
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 209 ++++++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 122 ++++++++--
 3 files changed, 365 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
index 00e63b12d82e..a8dd8c2e7596 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
@@ -4,6 +4,9 @@
 
 #define RB_MAXLVL_PRINT (16)
 
+/* Cache line size assumed for keeping the lockless fields apart. */
+#define RB_CACHELINE_SIZE (64)
+
 struct rbnode;
 
 struct rbnode {
@@ -56,14 +59,34 @@ enum rbtree_insert_mode {
 };
 
 struct rbtree {
+	/* Writer fields, on a cache line of their own. */
 	struct rbnode __arena *root;
 	enum rbtree_alloc alloc;
 	enum rbtree_insert_mode insert;
+
+	/*
+	 * The leftmost node and the node count on their own cache line.
+	 * The writer keeps them current, and readers may read them without
+	 * the writer's lock (see rb_first() and friends).
+	 */
+	struct {
+		struct rbnode __arena *first;
+		uint64_t nr;
+	} __attribute__((aligned(RB_CACHELINE_SIZE)));
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
@@ -80,4 +103,34 @@ void rb_node_free(struct rbnode __arena *rbnode);
 
 int rb_integrity_check(struct rbtree __arena *rbtree);
 
+/*
+ * Lockless reads of the head and the node count. They need not be called
+ * under the writer's lock, so they are advisory: the tree may change before
+ * the caller acts on the result. The node rb_first() returns may have
+ * left the tree, or been freed in an RB_ALLOC tree, by the time the
+ * caller reads it. The count is a separate read and need not agree
+ * with the head.
+ */
+static __always_inline struct rbnode __arena *rb_first(struct rbtree __arena *rbtree)
+{
+	return READ_ONCE(rbtree->first);
+}
+
+/* -ENOENT if the tree is empty, 0 with the leftmost key in @key otherwise. */
+static __always_inline int rb_first_key(struct rbtree __arena *rbtree, u64 *key)
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
+static __always_inline u64 rb_nr_nodes(struct rbtree __arena *rbtree)
+{
+	return READ_ONCE(rbtree->nr);
+}
+
 #endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
index 1e2a0fac1e4f..57c4395c046a 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
@@ -285,6 +285,215 @@ __weak int test_rbtree_duplicate_fifo(void)
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
+	if (rb_first(rbtree) != least)
+		return 1;
+
+	if (rb_nr_nodes(rbtree) != nr)
+		return 2;
+
+	if (!least)
+		return rb_first_key(rbtree, &key) == -ENOENT ? 0 : 3;
+
+	if (rb_first_key(rbtree, &key) || key != least->key)
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
+		node = rb_first(rbtree);
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
+	node = rb_first(rbtree);
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
+		node = rb_first(rbtree);
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
index e6c9430f734b..2622c78302af 100644
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
@@ -32,19 +30,51 @@ struct rbtree __arena *rb_create(enum rbtree_alloc alloc,
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
+/*
+ * arena_malloc() aligns a block to its power-of-two size, so the tree's
+ * lockless fields get a cache line of their own.
+ */
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
 
+static __always_inline void rb_set_first(struct rbtree __arena *rbtree,
+					 struct rbnode __arena *node)
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
 
@@ -63,11 +93,11 @@ int rb_destroy(struct rbtree __arena *rbtree)
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
@@ -76,11 +106,22 @@ int rb_destroy(struct rbtree __arena *rbtree)
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
@@ -255,6 +296,8 @@ int rb_node_insert(struct rbtree __arena *rbtree,
 
 	if (!parent) {
 		rbtree->root = node;
+		rb_set_first(rbtree, node);
+		WRITE_ONCE(rbtree->nr, 1);
 		return 0;
 	}
 
@@ -273,6 +316,10 @@ int rb_node_insert(struct rbtree __arena *rbtree,
 			if (ret)
 				return ret;
 
+			/* Same key and place, so only the head's identity changes. */
+			if (rbtree->first == parent)
+				rb_set_first(rbtree, node);
+
 			if (rbtree->alloc == RB_ALLOC)
 				rb_node_free(parent);
 
@@ -290,6 +337,14 @@ int rb_node_insert(struct rbtree __arena *rbtree,
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
@@ -410,7 +465,7 @@ __weak int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value)
 	if (!rbtree->root)
 		return -ENOENT;
 
-	least = rbnode_least(rbtree->root);
+	least = rbtree->first;
 	if (key)
 		*key = least->key;
 	if (value)
@@ -578,8 +633,8 @@ static inline bool rbnode_has_red_children(struct rbnode __arena *node)
 }
 
 static
-int rb_node_remove(struct rbtree __arena *rbtree,
-		   struct rbnode __arena *node)
+int rbnode_remove(struct rbtree __arena *rbtree,
+		  struct rbnode __arena *node)
 {
 	struct rbnode __arena *parent, *sibling, *close_nephew, *distant_nephew;
 	bool free = (rbtree->alloc == RB_ALLOC);
@@ -765,6 +820,35 @@ int rb_node_remove(struct rbtree __arena *rbtree,
 	return 0;
 }
 
+/*
+ * Remove @node and keep the head and the node count current. The head has no
+ * left child, so if it is the node going away, its successor is the leftmost
+ * node of its right subtree, or else its parent. Take it before the tree
+ * changes; the removal and its fixups preserve the in-order sequence.
+ */
+static __always_inline
+int rb_node_remove(struct rbtree __arena *rbtree,
+		   struct rbnode __arena *node)
+{
+	struct rbnode __arena *next = NULL;
+	bool was_first;
+	int ret;
+
+	was_first = node == rbtree->first;
+	if (was_first)
+		next = node->right ? rbnode_least(node->right) : node->parent;
+
+	ret = rbnode_remove(rbtree, node);
+	if (ret)
+		return ret;
+
+	if (was_first)
+		rb_set_first(rbtree, next);
+	WRITE_ONCE(rbtree->nr, rbtree->nr - 1);
+
+	return 0;
+}
+
 __weak
 int rb_remove_node(struct rbtree __arena *rbtree,
 		   struct rbnode __arena *node)
@@ -813,7 +897,7 @@ int rb_pop(struct rbtree __arena *rbtree, u64 *key, u64 *value)
 	if (rbtree->alloc != RB_ALLOC)
 		return -EINVAL;
 
-	node = rbnode_least(rbtree->root);
+	node = rbtree->first;
 	if (unlikely(!node))
 		return -ENOENT;
 
-- 
2.56.0

