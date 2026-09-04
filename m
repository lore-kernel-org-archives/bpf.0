Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF13F54A4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511422; cv=none; b=lftN8R/E8dAXjuBs9GTOJGHcAD+6Yvm2b6oKBKJBApiVb74UJP22PXl8S5aCvy/via4TdUn0cdHAtzCDZ+Sc5rEXzf4gzU6q0hlR8JvHBm4TmbGItUnvQCfS2c+tsXn9vfVsUQ1aTsXIVlE4ebvWo3ca2tLj6BM9oy9zfR7xV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511422; c=relaxed/simple;
	bh=PDE0ug1HWqsL6vvt15BXzhu+bTzmE87we+12xGl+diE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxrSb6dTAJ/1t3hOovEgbU1eSVcUmnEYb2ksjFVjm4jVHTKhGVGkIZMHowozFVIUlcccYgovtKBFwMwOUVUxa95ItalwArRu6MHzTKK6MHVPGgjJMRmcJJjpkHW28Jhm71R3y3Y5Sm7c0paJdp5kVNKp6XMN134jP6ISdP+8q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY/p1KSp; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY/p1KSp"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso3499225e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511416; x=1789116216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sErH7EZH9jZD5huYcrOQyYT+eeKP6ix4c68VzXS58bQ=;
        b=eY/p1KSpsi2GerQk8Ih4HlyAL0S/5Qg2X0vfdzdfSMr4yQ4xMyrY1LeI8FVf5xPDVm
         6xj9Kk5/9Q4oQoTcZEXb32nZh4SsgwlzK1btqK4zpzZ0l6s1TTh8UuKZIHfZgTwtmnA8
         pX+jp+7ZUhe0D1wBKAVoeg/GepB0TGFI/X8cpD7yGygwzHebsBVvanJ7AasB5KAQgI3b
         K74GV257nC7YXqeA/9xfHGpdF+3PnX9r6AQkUZcGvLjqgH6T5zvhwagQGSZdVQZOiZtm
         o27qBB1u7anKWwXNUnMrnlZl9YjIA+9tni8GVoKzeM0Xp/TSlbF55QsHNMKprTxMsnuq
         KcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511416; x=1789116216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sErH7EZH9jZD5huYcrOQyYT+eeKP6ix4c68VzXS58bQ=;
        b=lJlBmryNfiZrgxBvw1vAPZtvNgRHVRvLxDnK6dj0qQMxz/vjlyfMgnMs8LCBQFY4tl
         r2HupfG4q71XlsjkurzeCPDXLiF0l1zld+bm38lL709EBJDAlju4b5Vs0tgBMyaBpPbC
         UJacXk180aeAPKpQkZgtNK3xn60te81+h9b2eiM8kK9ZyzHEs5XBfZhQuY4FvaW+2YjK
         3i5cPmt/K4+peao1VVhqiiOY4I8Sq62jJ5xjfzjypUyOrr3M4vyv+X3KwdBQ2oJaD0pM
         YFbz08ka78o8RRCn+qQoMLps9vET7lAeKNTrKtAX/Rybclb/XCJo8BDkXKmV8kDFpSiN
         0XRQ==
X-Gm-Message-State: AFuF++lFOxHFErBhkkuTO9g0kUiPAwXyXtC+6E/dGfcUW+mDCGpb6y0X
	kk/kr8WwT1ZAyrSLjZOMUxdRL56D2UNJGkkEPl8bbrA2Yh/rp415h/lrWzo+WyfF
X-Gm-Gg: AYBFou01KaPye7XRolYDhGABm2vdJDEbW27tcwTs++6Vo1piMfpA/pR7wMimCsQAH5A
	Ei9nUlYOHhkyoXoQaXdgQb7/8OpbXI+BW22bq4IR6SxRvQzlTx4nUA+FSTe4GCdPLeTZij6ghCi
	P/9XN3txj17Txptj6loa2kLlDhy6yDd2pId14UJb5kOnOijpezVDUgnrqOMBdS64sLuTRNFfkqE
	1QhuJGOIngFyiYyqLwvznec8JhtvGGMJBpcGn0EtIhPcn/NmpeKRSBNQUIj3GDloCZxrhbcmvJv
	RI6pihaUzlYdJBuk7ErvzXJGrhiWQQYTMp+md3hBJt7GZXexOmPitnJ88DWIFfCsonjMLKT5bkl
	L/o12FsMmoSqajOPGU9u33X2MK0kbL+ZgwRVxEPARsEbtHsLoaZHZ429IYj3hMHYsrEN04bSCrk
	e52PQ6BCWKjKWTvbsq+dZMZiafT19IASY80sv1mNszPyyyzWJPQJ9yWYyAsc/0UbOXkQtslXbHw
	Zt75ULvo/ViycNL6bvD1RbzqK1vzOCmW4yzK92EbkpPCVGBvIeiFLirE4OvO+EO2BS3sq9s7elT
	bYIv9si/cGxKX3WlrIraPWM09v0=
X-Received: by 2002:a05:600c:6306:b0:49c:f5c0:aa76 with SMTP id 5b1f17b1804b1-49cf81e366amr87030375e9.5.1788511416006;
        Fri, 04 Sep 2026 01:43:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bc74298sm2340493f8f.6.2026.09.04.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 6/8] selftests/bpf: Reject graph kptr use after RCU unlock
Date: Fri,  4 Sep 2026 10:43:19 +0200
Message-ID: <20260904084325.52250-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4968; i=memxor@gmail.com; h=from:subject; bh=PDE0ug1HWqsL6vvt15BXzhu+bTzmE87we+12xGl+diE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWy6T3R7IFNVIW7Jil8Gqn3+WJKavPpr/W8Do6LXVDo 2KV44obHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIYW+G/+6nl+dkbhOo21i5 fe/dC0fO+Jw4wcR2OU9//rn1Gibn5d4z/OHheT39jkZI8K0zca/fnmH5POctW5+CYa66jvZzP9U 0HlYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a sleepable verifier test that loads a graph-node local kptr in an
explicit RCU read-side critical section, then passes its node to
bpf_rbtree_remove() after the section ends.

Before the verifier fix, the stale NON_OWN_REF flag makes the node look like
a live borrowed reference and the program is accepted. After the fix, the
pointer is demoted without NON_OWN_REF and the graph kfunc argument is
rejected.

Also exercise a graph kptr loaded while a spin lock provides implicit RCU
protection. The pointer must be invalidated when the lock is released, which
guards the required ordering between non-owning-reference invalidation and
RCU demotion.

Update the existing fault-protected load test state description. The
post-unlock pointer no longer carries NON_OWN_REF, but remains readable
because the load is rewritten to use BPF_PROBE_MEM.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/rcu_read_lock.c       |  6 +-
 .../bpf/progs/refcounted_kptr_fail.c          | 75 +++++++++++++++++++
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 31d4081c3a9f..cdb255addbc3 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -592,9 +592,9 @@ int non_own_ref_untrusted_ld(void *ctx)
 	}
 	bpf_rcu_read_unlock();
 	/*
-	 * The unlock leaves node as PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED
-	 * | NON_OWN_REF, and the load below has to get the BPF_PROBE_MEM
-	 * rewrite for it, otherwise a bad address panics the kernel.
+	 * The unlock leaves node as PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED,
+	 * and the load below has to get the BPF_PROBE_MEM rewrite for it,
+	 * otherwise a bad address panics the kernel.
 	 */
 	non_own_ref_key = node->key;
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 7d2f8897e5ad..f787ecf189d8 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -28,6 +28,17 @@ struct map_value_refcount_only {
 	struct node_refcount_only __kptr *node;
 };
 
+struct rcu_graph_node {
+	struct bpf_rb_node node;
+	long data;
+};
+
+struct rcu_graph_node *just_here_because_btf_bug;
+
+struct map_value_rcu_graph {
+	struct rcu_graph_node __kptr *node;
+};
+
 extern void bpf_rcu_read_lock(void) __ksym;
 extern void bpf_rcu_read_unlock(void) __ksym;
 
@@ -36,6 +47,8 @@ private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_acquire, node);
 private(B) struct bpf_spin_lock lock;
 private(B) struct bpf_list_head head __contains(node_refcounted, list);
+private(C) struct bpf_spin_lock graph_lock;
+private(C) struct bpf_rb_root graph_root __contains(rcu_graph_node, node);
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -44,6 +57,13 @@ struct {
 	__uint(max_entries, 1);
 } stashed_refcount_only SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value_rcu_graph);
+	__uint(max_entries, 1);
+} stashed_rcu_graph SEC(".maps");
+
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
 	struct node_acquire *node_a;
@@ -137,6 +157,61 @@ long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__failure
+__msg("bpf_rbtree_remove can only take non-owning or refcounted "
+      "bpf_rb_node pointer")
+long rbtree_remove_after_rcu_unlock(void *ctx)
+{
+	struct map_value_rcu_graph *mapval;
+	struct bpf_rb_node *rb_node;
+	struct rcu_graph_node *node;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_rcu_graph, &idx);
+	if (!mapval)
+		return 0;
+
+	bpf_rcu_read_lock();
+	node = mapval->node;
+	if (!node) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	bpf_rcu_read_unlock();
+
+	bpf_spin_lock(&graph_lock);
+	rb_node = bpf_rbtree_remove(&graph_root, &node->node);
+	bpf_spin_unlock(&graph_lock);
+	if (rb_node)
+		bpf_obj_drop(container_of(rb_node, struct rcu_graph_node, node));
+
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("invalid mem access 'scalar'")
+long graph_kptr_after_spin_unlock(void *ctx)
+{
+	struct map_value_rcu_graph *mapval;
+	struct rcu_graph_node *node;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_rcu_graph, &idx);
+	if (!mapval)
+		return 0;
+
+	bpf_spin_lock(&graph_lock);
+	node = mapval->node;
+	if (!node) {
+		bpf_spin_unlock(&graph_lock);
+		return 0;
+	}
+	bpf_spin_unlock(&graph_lock);
+
+	return node->data;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
-- 
2.53.0

