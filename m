Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803541A517
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503825; cv=none; b=MwI54FMHbnkNpnZwRqe8ElZ1OVlmP0zc62j/i0GmbynmFAGhUJNTsv+JtZUEoMETfClxJfev6wn8zstNaK7URXfVK8TXN1eDogohMjU4FbjYpoSXJVrkpalGOwhMnektpOnpPmYlwZ3uA6Gaa+gKGgNBOdXqSNA7y9wkTab33os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503825; c=relaxed/simple;
	bh=KxFFIn9/mNihatkIdIKWJSA0fU/WKLS8ovyz5z/hkhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWbUHBsphrHNPKqCZSs8bVMITltpPkhGC6K26wUAVVINAY1jJf0fLMutrwdXKE5aivDgqvpuxROmhT3esDwW8m2zSsBbjkxANN6Z1e9RFjCHNxDk6mx2Irj55sZPa1f9cd7H2NL27efO6hgcuuVBYKaB42A8NE2RoQfSBybd3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9eSAtvD; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9eSAtvD"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-482e1e7a4f6so281622f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503822; x=1789108622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYdQna79aFPiJ/kQREdasA4vle58tUpoleS0Sq/FBbI=;
        b=Q9eSAtvDnbpy+O6bhx0h7nd71p5q7edY36h3/ODRa9XcNbl4+wCAsJLIkhKgJR5Lup
         /Ov9Gq4Y3+XulA2XG8la6bMB9dDOmdRD90NfvSytSTqSsSSXvm0EnaOljNTJQFNr06V1
         KJO5tIzTdDzIO3iK6Dgr04PbheLy2gDG9fShHWDGcN1w5l4ir9Rr5dzddjWNU2XkIm6N
         KSC38sMlVaDKyKIm3oMw2CWuNCzIfpaVBzEw/SseHr+Q9hs4QjCJzDf9Vz18GLXO+iH3
         citaAbbIlw9mQscyRnkwaqmWgW/7EwhQOmQVW9qhYXeR2/fsL3NsEUOw8l3trbXILXde
         /rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503822; x=1789108622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYdQna79aFPiJ/kQREdasA4vle58tUpoleS0Sq/FBbI=;
        b=Cfm5wA9FUCvXNPGYTDm+AktOPQiGtx/m1+/IU80e0DMwQPaWLNu0UtGQbEM6N+FcAA
         S7gTNz1GCK0lgwCWZv5hwxRjuXk+jvcRdSwedIVA5ATAPhG5VtQQq2bxgvkBugKF5UMI
         rNtpd/lHlAZmyDjBxWpe7zqrzcz4cROUX6fh0v8UNsgi20x5wYFBpM+GXcxJEwqzepPD
         h6+FbeWyb17QddEhYHMeUJ5uSlm03KCjDx4n0C9NYSvT9jnWL7aBDB+rmG8VCugvSPqV
         d1nnTtSTurgXHMzaX9UMMI/4Jp1HAlK1B6sXCZ5WmUJsyD6eDk440P9LXnZ3PQYkAJJr
         AQcg==
X-Gm-Message-State: AFuF++ngSwq8f4BY4JfBRWrAQgKNpCXoFbnkWczJlObx2IJ/bGFhLN8y
	ip3F2SubLdwTRdEZdamsOD4Zt+VhqKdq9AkUQQtVQ0UHemcxQATHeYdvqqTR9TIH
X-Gm-Gg: AYBFou1mafbF52KhMGraGZGpRBPIs8bmtpaUtlE8jBZaYIjnnTuj5+Ou2Lx+jTcvwMy
	jV42O/89gefgAxTi1cJMbvoJfrZgrMFuNeUVUpX0bbX30mhZLo6/q4jS8BHTkLmVTHxllmyKPr0
	u2LsvNanuO8gJdphdrZu+/mciZ5xFYyH7QQrQ8q+HsvgypkiR1o2T1W5kdY5oOP/rc4DRSENVHk
	+NFZgIhqmpglD75ZkvW4s277Hi5JrakzL+V6MWiLOmJwnu7nAhEw1SvvWIMDIFNn83rn11Cgt7F
	FirvB87xQiANfYN9dp4/lBBGLhmGrWZlYUrlFo51JIdMmq/A6bNScdIMfl+tCExgVetb7zI8PdA
	0F1T1VGVpUk6VvyTYKeCpv90Z+sOKppapR1fP6IAEiDepm6ym6hLMfpgqe3agrq/0Aca9TMNaUl
	SSuMtOBJ3MkUHsmaJzhYczjbiT6Pv/zNPS5GDNzgBlI4VhqMm0N+oLkncC+gB5nHEd6XHKj5HZN
	87LKt30byUTlr50MpH3hvnmkcSK972Rh2kOQxffRPzmutqzHiwDLUZ5X/BBeoyWRLEvdpsvYrA8
	KScJwyrOHWyearO+J4zggo9Wwr8=
X-Received: by 2002:a05:6000:25c2:b0:482:e2f2:19c1 with SMTP id ffacd0b85a97d-4858703f827mr6256344f8f.2.1788503821638;
        Thu, 03 Sep 2026 23:37:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm3990171f8f.35.2026.09.03.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:37:01 -0700 (PDT)
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
Subject: [PATCH bpf v1 6/8] selftests/bpf: Reject graph kptr use after RCU unlock
Date: Fri,  4 Sep 2026 08:36:44 +0200
Message-ID: <20260904063650.3877826-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913; i=memxor@gmail.com; h=from:subject; bh=KxFFIn9/mNihatkIdIKWJSA0fU/WKLS8ovyz5z/hkhQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2uXXb25qfwuWXXJ6WrHWzZRD5VdTIr2XhWr4Xd8vz SvTE7+zo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZMJvhf+5BvevXu19taI9h uxScbBubWrLvDq+GWNWsG/dvWh6SLGf4p7mxqKVS2s0uTFFQJ7zG65/SFJ03WpPm23fee/HhjH4 vIwA=
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
 .../bpf/progs/refcounted_kptr_fail.c          | 73 +++++++++++++++++++
 2 files changed, 76 insertions(+), 3 deletions(-)

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
index 7d2f8897e5ad..5abd8387d26f 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -28,6 +28,15 @@ struct map_value_refcount_only {
 	struct node_refcount_only __kptr *node;
 };
 
+struct rcu_graph_node {
+	struct bpf_rb_node node;
+	long data;
+};
+
+struct map_value_rcu_graph {
+	struct rcu_graph_node __kptr *node;
+};
+
 extern void bpf_rcu_read_lock(void) __ksym;
 extern void bpf_rcu_read_unlock(void) __ksym;
 
@@ -36,6 +45,8 @@ private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_acquire, node);
 private(B) struct bpf_spin_lock lock;
 private(B) struct bpf_list_head head __contains(node_refcounted, list);
+private(C) struct bpf_spin_lock graph_lock;
+private(C) struct bpf_rb_root graph_root __contains(rcu_graph_node, node);
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -44,6 +55,13 @@ struct {
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
@@ -137,6 +155,61 @@ long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
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

