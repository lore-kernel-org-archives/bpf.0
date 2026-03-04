Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691DC2FF
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594205; cv=none; b=ViZyWEoPRhzlkfm9HHgLI4BlwH342tw17efIlLxgXFemt3PVH4adHhtXiJKZQN/+/oWDdalhrH8PWEQjTDcnWVWMmlRMOxXhIyekEl/HNaj2lcIeM/SsXi1IoPIOSw9hoDzEhSgS2tVkhQcHA6JGv9HFH+JQWYtEJJ21oVgDFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594205; c=relaxed/simple;
	bh=ehdit5EAOOpytD0YsvqDJRya3u0Bbwh8g1Ul7dRN9cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhAsp6Dlsbku+ipL8CBSzCGKkM2Fl//JfzGYDM42JO/LFgnfu7c4pwCuw073nBZe9ayb9hKTzf2nJfMzjbPtkqoCGCf4EB1t4kE9vnjCsHKNeZu2PNyIfbnU+Nz3GYqDMiv8a3Lf3GcTMcQkeqX08Y6BJPGB6RRCNpZ4fdQS91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+sGx/iY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+sGx/iY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-359832fc558so2635545a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594204; x=1773199004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvK4RWAiZa01vBUY+g5ujJJ2sul5o+PDqUXg1exrkgc=;
        b=A+sGx/iYsIIDNKIJWBTqUjyfic0AQR+/RnoG2F1bFEch9eCT2eiu/8gr2rPuPEVik/
         bfRLFGWiNPPjIOTEINQVXcm/9Oax0OHDITXKRK3llRw5nOZJ/TGK0aP2nmem9fdn0TPb
         eJltVS8hJK3+I7dx/NrBiqaCiwUmcjY0qmg5R5cbtT1q+s7+qHl+cih37/Or5273VhEb
         91ZLLJLlRzMU8b1OiWDVu1DOqzMaxyUoPg1MdXouhEHb0pO/sZfQj9RxqQ9af5PvWuem
         Zqi8vrSa2T5Dvve2eocUPlzA7mLNqPtPY1A377B2tNXFpYuSsnnhppCBwx6FjFwXcnLz
         A3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594204; x=1773199004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VvK4RWAiZa01vBUY+g5ujJJ2sul5o+PDqUXg1exrkgc=;
        b=CWFlgTEBPaZ3haKdiAvtYHqaJHyZG5rind3XXhNN5MpcMAp799HvBdXmvL9Dh1c5FK
         0DNsDbFbs62msHLD9Sm2SwZOt2ezP2Yq3SZsoNrfZ4jbscU2aAW5v6XJ+gWVbF2hGILr
         jaxhzTxP4pDe3DCOWWJejN5CT6HWYU1DzpQ6GPTzLO36TK2LroU9jwwo7GEf2dY89YxU
         qVitf1SMENwHjua9Y/RcQ4iXEEhMrjaLw7TM0OdmTe49Y+61+SjbEePdSsjjT4Gwzbd0
         ikQHBffi+6Sg2WhWpJ6EMP3ZEovOYeXpn8YncWRfvi8khOwg2Z7zF41ZZl+2uAqK38fJ
         frsw==
X-Gm-Message-State: AOJu0Yw+EEwIp3sjNHBDrdjWqw3Xd6qoF1S7x6xPc3XZibtijIp8mVpZ
	hOz3xEVFe7Z+PEmnU4/Xy/stNU8iBdO0wfhMH971hMtpZXwXYpl7GcOX
X-Gm-Gg: ATEYQzzE5nDerQ1prVKnvoXGryCRLSUXXKRMB5p0xWubgQeMEvvoTHzITpraqHsigTs
	8KIT6VPE8OEFi5RFNXdc7dEF5y25nfxKxWVEUB4unQlWI8C5+ZHKBuV1CKF6lBBOD/UjiYbuGa9
	8GIKeASbm8n/uN6K8EKPc3xGhJSCFwILUF4aLKiQIrR/hEnesbVZwWz26I+5Noe9ocQlYOK47Qh
	d62zk0xI+Dj0P2ey8F9vwMDDMue5HXQ9H90CR84U5w9NNM2wrbGIu8mqxYpnWob4/4sGQ6RFVxD
	sGa9l7rGdQl2F3PT8M6A98PUvolUOgWsOyrnRhKBHzevihiEJgfwmf9cQYs9cv+SWDpfacoAtPJ
	FZiKcJMvWdlPgHASDIYoCV0dAcMz4geRVMXJ7M1cujzWfkjrxLFJ060IkjL31RnR/afa2ziVll1
	HHfSw7Lx/ShMqu1I8Ktc6VT6BeijTjq5UYXnK21PuAmrh+2UsXFg==
X-Received: by 2002:a17:90b:48d2:b0:353:e91:9b38 with SMTP id 98e67ed59e1d1-359a6a9f518mr666512a91.34.1772594203918;
        Tue, 03 Mar 2026 19:16:43 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3ab946sm3610648a91.13.2026.03.03.19.16.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 19:16:43 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
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
Subject: [PATCH v5 3/6] bpf: add bpf_list_add_impl to insert node after a given list node
Date: Wed,  4 Mar 2026 11:16:03 +0800
Message-ID: <20260304031606.43884-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304031606.43884-1-pilgrimtao@gmail.com>
References: <20260304031606.43884-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add a new kfunc bpf_list_add_impl(head, new, prev, meta, off) that
inserts 'new' after 'prev' in the BPF linked list. Both must be in
the same list; 'prev' must already be in the list. The new node must
be an owning reference (e.g. from bpf_obj_new); the kfunc consumes
that reference and the node becomes non-owning once inserted.

We have added an additional parameter bpf_list_head *head to
bpf_list_add_impl, as the verifier requires the head parameter to
check whether the lock is being held.

Returns 0 on success, -EINVAL if 'prev' is not in a list or 'new'
is already in a list (or duplicate insertion). On failure, the
kernel drops the passed-in node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 25 +++++++++++++++++++++++++
 kernel/bpf/verifier.c | 15 +++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 19d88da8e694..188840057c7d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2497,6 +2497,30 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
 	return (struct bpf_list_node *)h->prev;
 }
 
+__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
+				  struct bpf_list_node *new,
+				  struct bpf_list_node *prev,
+				  void *meta__ign, u64 off)
+{
+	struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
+	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *n = &kn->list_head, *p = &kp->list_head;
+
+	if (unlikely(!head || READ_ONCE(kp->owner) != head))
+		goto fail;
+
+	if (cmpxchg(&kn->owner, NULL, BPF_PTR_POISON))
+		goto fail;
+
+	list_add(n, p);
+	WRITE_ONCE(kn->owner, head);
+	return 0;
+
+fail:
+	__bpf_obj_drop_impl((void *)n - off, meta ? meta->record : NULL, false);
+	return -EINVAL;
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -4566,6 +4590,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_add_impl)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9557d3fb8dd..197b972e79a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12464,6 +12464,7 @@ enum special_kfunc_type {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_add_impl,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12525,6 +12526,7 @@ BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
+BTF_ID(func, bpf_list_add_impl)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -13000,7 +13002,8 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_back];
+	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13122,7 +13125,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 	case BPF_LIST_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
@@ -14264,6 +14268,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
 		insn_aux->insert_off = regs[BPF_REG_2].off;
@@ -23230,13 +23235,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = 3;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 		int struct_meta_reg = BPF_REG_3;
 		int node_offset_reg = BPF_REG_4;
 
-		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
-		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+		/* They has extra arg, so args-to-fixup are in diff regs */
+		if (desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+		    desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 			struct_meta_reg = BPF_REG_4;
 			node_offset_reg = BPF_REG_5;
 		}
-- 
2.50.1 (Apple Git-155)

