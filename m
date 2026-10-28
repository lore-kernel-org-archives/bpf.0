Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167282;
	b=DydXFWIJmLu0jI4WEE5PGMMaSr6VD8BXXn80vbWBrFrJvthId+j93B2FQRmBXPlOkpEV
	 RgRwkVZODmXn2zqHoBiEgjuZSnvK0g2L3tt6Km9Nypl2Zlw8YJzgHQaO3f3dkefvauiV7
	 U4omDMyjE7z4b0/h89lJhwzzu9jboV21mB/BdLRI0oLUw5ilBzKm48DNj5T4IazgEStGJ
	 Dxv+tvCRfkdfqxFhlnJzeF94gMQ+SAhbRU2zoegICD4wWUKqXlhSocTvEbUJ8c2HFfYS8
	 CWKbRMXcSFMo9ZEzX4ufFjwG/UDphElIASIcYOUhOCEsqd4nOWluYL35O6AywmTKL1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167282;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jrfdz/Bz9ZLfkxcuP/38DAm/xoYYnKdyOHq9rVJM3Lo=;
	b=IqhJ4g1VFWAumIMOsQat2F3HpHUzjWaB6NL0dILJsqtHUPbEa85JCFfyhyVoEiA+DUJy
	 VIWobdismabcKdLnKJZFFuqZP/0IgzUFOfNh8pA+JMacYZEcg5cPwtpYRGUjxNStd9Euw
	 VFZZCP/X5mTdAKQCMek0NbSnjokQiCN+WCS8m08G35hS+ano66ITWyOiMMwfhK3Umov3d
	 R1tW2G3H7s0rakg8TXNRlLctezk3AI0XyEI3sOjkhn6jfl4KaKsWjUn+71tqhsdWOyRkv
	 PYYInVRhzjCQexC4+PrkJpZglTzABJd2K/ODfTn4d7w98TQe7yUTlfjAVc2znDfOXcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YzbUVTrc;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985D606A31F;
	Wed, 28 Oct 2026 06:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D985D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YzbUVTrc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=jrfdz/Bz9ZLfkxcuP/38DAm/xoYYnKdyOHq9rVJM3Lo=; b=
	YzbUVTrcloILtQt7AJWOaB31yjuno+CYkkWMVFs3FrnQHF0ehvtMNvybf0FfgcD5zB5i/O2dFWk6y
	L5mtw6jOnD1uZFGDZ55S9gehBPsIpMqiPqXvLf4aK+drpysCVgvUnR9z5cmaxtQIw8svJrbhbef1w
	fl8OjBTgFANR+Cm/QwjiUmInnszPkP/vdJMFO5Mv2xtnKG5sDoTXtR/KeI237rDm0lXxZkh2oXUo8
	EatPUX4P+vSpNwGH6WRMARZWl3Sjvx+il+1datJgYTV9QA4DMKGhDwoms+gHcPtrBKS4JOuGySn+9
	OazdIryh188WIqSDFi4YEpV6lt4gLgnVrw==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xLwin-00CYnD-0M; Wed, 28 Oct 2026 07:01:14 +0100
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: libarena: Add rb_next()
Date: Wed, 28 Oct 2026 15:00:46 +0900
Message-ID: <20261028060046.549097-4-changwoo@igalia.com>
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

Add rb_next(), the in-order successor through parent pointers.

Add a selftest that walks a tree with repeated keys and checks the walk
against the order in which the head leaves the tree.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../bpf/libarena/include/libarena/rbtree.h    | 23 ++++++++
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 54 +++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
index a8dd8c2e7596..956b4a24b52a 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
@@ -103,6 +103,29 @@ void rb_node_free(struct rbnode __arena *rbnode);
 
 int rb_integrity_check(struct rbtree __arena *rbtree);
 
+/*
+ * Return the in-order successor of @node, or NULL if @node is the last one.
+ * Walking from rb_first() with it visits the tree in key order, equal keys in
+ * insertion order. Call it under the writer's lock.
+ */
+static __always_inline struct rbnode __arena *rb_next(struct rbnode __arena *node)
+{
+	struct rbnode __arena *parent;
+
+	if (node->right) {
+		node = node->right;
+		while (node->left && can_loop)
+			node = node->left;
+		return node;
+	}
+
+	/* Climb until we leave a left subtree; its parent comes next. */
+	while ((parent = node->parent) && node == parent->right && can_loop)
+		node = parent;
+
+	return parent;
+}
+
 /*
  * Lockless reads of the head and the node count. They need not be called
  * under the writer's lock, so they are advisory: the tree may change before
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
index 57c4395c046a..784cc9edea17 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
@@ -425,6 +425,60 @@ __weak int test_rbtree_first_update(void)
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
+	u64 seed = 0xcafe;
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
+	node = rb_first(rbtree);
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
+		node = rb_first(rbtree);
+		if (node != next_nodes[i])
+			return 6;
+
+		if (rb_remove_node(rbtree, node))
+			return 7;
+
+		rb_node_free(node);
+	}
+
+	return rb_destroy(rbtree);
+}
+
 struct rb_embed {
 	u64 pad;
 	struct rbtree tree;
-- 
2.56.0

