Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BE41B374
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565607; cv=none; b=GqjvkCjqFBka5ZuxFbZ7D2g9QTBqEIC9s8/EhAn3DHRMK5PzlZwxHICgN8JK+yNzbUiqaO+XuqKNQ53/s5V0hVyMoyWT47i/6eC8H380U0U45htCzPpiQyD/+bn1Ufw8sg15TZNwSe42FTDghBzZsTMFRNpfddxa02TiG8Iai04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565607; c=relaxed/simple;
	bh=5p64GKPG5304730wA3md9aMwwm3p5LHhf4Lb7/Btios=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfPLmi2nBg9xGFnMXxyT72iE9D3dWfnSvuULDQdOiHpqERLJaOGm0HVgSwJ1vjGLsyLuFjSpFjR74sz++JJTZ/IgZ05YAzjdDiutI2XXmZ3MPhCTPSeEhDG0+fFUGEt4qB8l1Roo1L9JgrvH80HsnRioGYVZRjn5FjV2+8t73Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d9U7gtdP; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d9U7gtdP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778565600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUwkb+rVEVAyaI4tzJled16qKyxWqmXsFV4GgQBJAAI=;
	b=d9U7gtdPQe3MaUuT7FdIdky8oB6KYMLPQEoCT+V7jSCI5PMoDFbfCR8bxfM0SYWoQP3C/i
	R2souKj7JPydRPG91BHoZEDuQczG96WjQH1Md0WZiP1LXvickLzikhpXR10Pe1cGQm4reo
	tH4U8osKMq3KmlM+zPe3HkMInNHzNoQ=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: ast@kernel.org,
	corbet@lwn.net,
	martin.lau@linux.dev,
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
	skhan@linuxfoundation.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	vmalik@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND bpf-next v10 5/8] bpf: Add bpf_list_add to insert node after a given list node
Date: Tue, 12 May 2026 13:59:16 +0800
Message-ID: <20260512055919.95716-6-kaitao.cheng@linux.dev>
In-Reply-To: <20260512055919.95716-1-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
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

