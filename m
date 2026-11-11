Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391813;
	b=air/pOEcVEoYbUqPpia3Oc8iAILt0fKTcPmVjkCW5sZ545HAKxs2w+brJiFyCy34mNEo
	 KaZLuD7OP8Q8MUmDSW57BAXJoXDBl9m7zhEUA523ccJ3a212Qk+OgVHC3Kh2I24qSgjT5
	 uFmp2Wkm4kLlPSk527QOhOcsnn/KE1BCOB1iTSTJ8CKRH76MhSbNaUEqZDzsJihvsRzvo
	 CLqrWKXM6mrP1/YtPLCf5VgAJODRRACwSQzoncLh4S/oGhlNXvTte+1WZ/gHtddVL1pDA
	 gwn3098BAlfwWNmZrojtm6ybNY1CRUZijnnQ2Fs7mr9eKTrNImok5r0bH1eJpp9aQJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391813;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TKdv7edjmPjExE3RyciVP5KfNQ2HgIujnfELAufwRbY=;
	b=WG+ybpm5WllPDrKzle+BmlKQ33wYd1JyTB8fE9DNyrFDsGn10PS1Gt+UHeTGt9l7R6C0
	 eBCehs9Z5bEo+ugGoOZSwQXUHgqtFUmWJ0Gn/z3Dwpgvr85mWbdGKvcRt4Mc7siUn35Fq
	 TAXKzkAZEXPdbCRRcTemddOtqP93tRapiPCRkOpiV0xXftiComaDkivM7WDXrWhxwZLVT
	 OhH4C4ke25B5UQBU/3Z/LUXb4NpCxBazwMHiZMtIC+Xn9mMTNQcbX/nxhoDT5AIjqtWI6
	 vRg5s6kSZ1TGh3a9cDs8KF+6Tw3RMyLdk7817WVDqCC64gW333g6iCOtjJKmvGxbLBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lYMH0dCe;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6826606A31C;
	Wed, 11 Nov 2026 10:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6826606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lYMH0dCe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=TKdv7edjmPjExE3RyciVP5KfNQ2HgIujnfELAufwRbY=;
	t=1794391812; x=2109751812; b=lYMH0dCei7pknFhzgRYYfLo8lA58O0s5uUTC30SWtr9j425
	aivLUSdgS+C2hYgM5fN3LZ5gGxdI6VXf+Yw8tdqpzpCsz0XYo42rBduleTus3xYxpHwAvYqXkVdFV
	3DWmDOiZLnb2/eFLQLEokrsgZNbUF9eUEIngefQqHs6rM66ZWz3XjEr178id6hcXJyVppgLf3CpUQ
	wJZgu6fi5ILTC0/Uh72kc9tKU773Vgh4ITlUKLEtvN030MdLj8I9Nz8chX9i2o5o/3hXqIjES9U0S
	mmcsclOLX7rWIDfkMvGuKLM8GGFUPTDM/IM0MVsk3uPKdMDy+ah2m6X+o7s6ClEQ==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xR5HH-008kZF-CK; Wed, 11 Nov 2026 11:10:04 +0100
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
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: libarena: Order equal rbtree keys FIFO
Date: Wed, 11 Nov 2026 19:09:49 +0900
Message-ID: <20261111100951.230730-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111100951.230730-1-changwoo@igalia.com>
References: <20261111100951.230730-1-changwoo@igalia.com>
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
Reviewed-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/rbtree.h    |  6 +--
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 37 +++++++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   |  6 +--
 3 files changed, 43 insertions(+), 6 deletions(-)

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
index 7f0f6dc3e17d..831a1ef1c2a1 100644
--- a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
@@ -171,7 +171,7 @@ struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *subtree,
 		return NULL;
 
 	while (can_loop) {
-		dir = (key <= node->key) ? 0 : 1;
+		dir = (key < node->key) ? 0 : 1;
 
 		if (!node->child[dir])
 			break;
@@ -278,8 +278,8 @@ int rb_node_insert(struct rbtree __arena *rbtree,
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

