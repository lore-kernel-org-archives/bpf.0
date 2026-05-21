Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB41384CE5
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333884; cv=none; b=pAC5XEvdrqoI6H2A5AD2vMcw5J+xhwCODJlVTsaC+2Dn0JsQP5yqg6/WDK1sUz/gXUGKpt4ULXwf8I6IMh7NXKvuH+Gjnq6va+i0dZF4p9+PdyDwwVZLk/wDN8hxLUWFkiZ9Sj6szYAM+p/ZNe1kejHoqyZVHcZ4PvItmrWfofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333884; c=relaxed/simple;
	bh=+BtilysjVVxO3ABeOMvlyB+8+Ttt5znjOUyB3PcI7s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY/YWz8qYF9XuU6dcJb2BdHS1dzK/Wd0aphg3rG28qHxfIGYfndkfGxJ5mSZBl9xzSw9F9PRq90v/wvJmmKb7IfI7GYAuKnUBrpTYv6hdtONSzEkmPrtVZFzEjkUpi6MTQsu5I760QuESoMJUGFfbTd1u6E7CIuuMGgYrYbNqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dPCYBrLT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dPCYBrLT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779333880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGyFnbwX8XkqTWxZDvl1NqVaoqhkKtKsutTFkKeV2Vg=;
	b=dPCYBrLTiI7xfKNGYWi0ykInKCr1plrt4IHusFF44eZ9uxxbIGptIvduyUOw/lvxfXAYUV
	PVKJh4r+tXEQG/S3A0lEgQiNSZR7Q00msTp9U/Kqwft/43rXwJWY/ndAcvT1GGm+aBNjor
	9UMZ7Ex6218cG7hqbBk6753kZNG73pU=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
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
Subject: [PATCH bpf-next v11 6/8] bpf: Add bpf_list_add to insert node after a given list node
Date: Thu, 21 May 2026 11:23:04 +0800
Message-ID: <20260521032306.97118-7-kaitao.cheng@linux.dev>
In-Reply-To: <20260521032306.97118-1-kaitao.cheng@linux.dev>
References: <20260521032306.97118-1-kaitao.cheng@linux.dev>
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
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c  | 11 +++++++++++
 kernel/bpf/verifier.c | 12 +++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1c69476c8a09..89579165ef4d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2577,6 +2577,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 	return bpf_list_push_back(head, node, meta__ign, off);
 }
 
+__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list_node *new,
+			     struct bpf_list_node *prev__nonown_allowed,
+			     struct btf_struct_meta *meta, u64 off)
+{
+	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev__nonown_allowed;
+	struct list_head *prev_ptr = &p->list_head;
+
+	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
+}
+
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
 					    struct list_head *n)
 {
@@ -4756,6 +4766,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
+BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 35eebb5e7769..662ad7312697 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10959,6 +10959,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_front,
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_push_back,
+	KF_bpf_list_add,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
 	KF_bpf_list_del,
@@ -11028,6 +11029,7 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_front)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_push_back)
+BTF_ID(func, bpf_list_add)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
@@ -11140,7 +11142,8 @@ static bool is_bpf_list_push_kfunc(u32 func_id)
 	return func_id == special_kfunc_list[KF_bpf_list_push_front] ||
 	       func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	       func_id == special_kfunc_list[KF_bpf_list_push_back] ||
-	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl];
+	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+	       func_id == special_kfunc_list[KF_bpf_list_add];
 }
 
 static bool is_bpf_rbtree_add_kfunc(u32 func_id)
@@ -19524,8 +19527,11 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

