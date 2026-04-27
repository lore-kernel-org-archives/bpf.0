Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B8381B1F
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309185; cv=none; b=U0uJnLmTATi/K5wj+kI/xA6qg+vWT2vbrLodfYXC2aiZNrVY6KGay9EEjs95v5TxFNNJzLEOJEWt5Mwv1B17JjYpEwoVObGT2rc8KCux00eTs1zhSNfLLtTMiHSW9t5I56YS58JP+urvgN7jnaAVdm45sF5ZSbA6m8uK/2vi/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309185; c=relaxed/simple;
	bh=5p64GKPG5304730wA3md9aMwwm3p5LHhf4Lb7/Btios=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdG5lVqJuXUbWObOU4Yty13z1HaVwZsuDQmuJ/faVGD8b8DwF4t7RkGOXnbENgoTH04DQOY0rSV9BhTim3O/roirqqhRMXzBbT59xzlN+ou2A2Axc3ooQPZDfWcUsWNdlJqJVXGrKWn12cv8BdKkALYY6nGUszvreOx7SLH/If8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TRFj+ha2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TRFj+ha2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777309181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUwkb+rVEVAyaI4tzJled16qKyxWqmXsFV4GgQBJAAI=;
	b=TRFj+ha29nxtVqf7G/L8eEaL09U0MEa+C+ZEDa8LIaPMNHYFmkFSQq5gdjVPzt/5F0b0wm
	qqZyDDeBuivb8yssrWGkcEBAL78BbDyXUTGvCf0qHGhmb5qMbSmHuKti8oAycs/EKGNO0M
	foFtFwg1ky5b+kxjMZnrtwFqP60qQoo=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 5/8] bpf: Add bpf_list_add to insert node after a given list node
Date: Tue, 28 Apr 2026 00:59:03 +0800
Message-ID: <20260427165906.84420-6-kaitao.cheng@linux.dev>
In-Reply-To: <20260427165906.84420-1-kaitao.cheng@linux.dev>
References: <20260427165906.84420-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add a new kfunc bpf_list_add(head, new, prev, meta, off) that
inserts 'new' after 'prev' in the BPF linked list. Both must be in
the same list; 'prev' must already be in the list. The new node must
be an owning reference (e.g. from bpf_obj_new); the kfunc consumes
that reference and the node becomes non-owning once inserted.

We have added an additional parameter bpf_list_head *head to
bpf_list_add, as the verifier requires the head parameter to
check whether the lock is being held.

Returns 0 on success, -EINVAL if 'prev' is not in a list or 'new'
is already in a list (or duplicate insertion). On failure, the
kernel drops the passed-in node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 11 +++++++++++
 kernel/bpf/verifier.c | 12 +++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5388078f3171..2b8e8d4284a5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2570,6 +2570,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 	return bpf_list_push_back(head, node, meta__ign, off);
 }
 
+__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list_node *new,
+			     struct bpf_list_node *prev, struct btf_struct_meta *meta,
+			     u64 off)
+{
+	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev;
+	struct list_head *prev_ptr = &p->list_head;
+
+	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
+}
+
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
 					    struct list_head *n)
 {
@@ -4748,6 +4758,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
+BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c0e0076bd69..50f8732aa065 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10742,6 +10742,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_front,
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_push_back,
+	KF_bpf_list_add,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
 	KF_bpf_list_del,
@@ -10811,6 +10812,7 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_front)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_push_back)
+BTF_ID(func, bpf_list_add)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
@@ -10923,7 +10925,8 @@ static bool is_bpf_list_push_kfunc(u32 func_id)
 	return func_id == special_kfunc_list[KF_bpf_list_push_front] ||
 	       func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	       func_id == special_kfunc_list[KF_bpf_list_push_back] ||
-	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl];
+	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+	       func_id == special_kfunc_list[KF_bpf_list_add];
 }
 
 static bool is_bpf_rbtree_add_kfunc(u32 func_id)
@@ -19228,8 +19231,11 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		int struct_meta_reg = BPF_REG_3;
 		int node_offset_reg = BPF_REG_4;
 
-		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
-		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
+		/* list_add/rbtree_add have an extra arg (prev/less),
+		 * so args-to-fixup are in diff regs.
+		 */
+		if (desc->func_id == special_kfunc_list[KF_bpf_list_add] ||
+		    is_bpf_rbtree_add_kfunc(desc->func_id)) {
 			struct_meta_reg = BPF_REG_4;
 			node_offset_reg = BPF_REG_5;
 		}
-- 
2.50.1 (Apple Git-155)

