Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73805387372
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011680; cv=none; b=oueWfpvHR/Yd4ym75KeJNgruKNUU9cE3d2oRkNvx0m+3X/B3LNkTXRahxT1mGlW/2SqhKuhbfZ7dBKMIRtayrmgWW/2tm4uDe1XlTm7I0PvjB4LI8WWvlip4UrxjNoKcN6p9ALtSnzrloVQCMWqE+d+quxO/AAUAfm053z/qrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011680; c=relaxed/simple;
	bh=yXrH5rL6UTGlagvJh99nORU7wnrKGwIaVSCupkBW4K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5E0C00JplGYfVkJF7h8gmA8sS5JoHo0hNwGfMNsQsOTMdd+pN9RleEHjFwUtoKQDj/Or5HxHCp4GQqSwXcLh6p/sz3QyWR3Cg3wWYRcb7kj66cCxSgDm6L8T4Jfa4HKOn2UxgdxK3dSBNkFzZj0Hj4qd0qBy/q7l7/HoZoMcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeGkM6Hu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeGkM6Hu"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2271903a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011679; x=1772616479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G/55UcWAx4kclxigcvG1vbLWUkcp/GEASDckWLnDsY=;
        b=BeGkM6HukGM5Vn0Vnp7LThhZOflsimtLtj41kE8v7QyswSORFFDrsFHdk24Nd9ZgHs
         TLYwmsRbvi9v85E+7iFtNDRXFtTOXaMQDkXGMc6/rB2D3nzB+eCHvsNIc20rPuyVFGMv
         BVtZsLkq1GZVzEzuf2dgMNU2aLAXrLS7oyyis+s2fSJrr/sTSkPn+qI/RkvRw8fhNSfW
         ruPdpGIfuvm/P3MwAu0Nc4pp0CsR4d4k/D+c9brNavpNjCOMf+n9YJq+k35qtC4oRRBu
         tfXEe1TJ6mLtPByoxYyQZN4FoqLDSqooQkf5l/IkkHrlYaTTwIZ4e0CdA/bWSfVTWqGO
         eEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011679; x=1772616479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9G/55UcWAx4kclxigcvG1vbLWUkcp/GEASDckWLnDsY=;
        b=FiltWUwnhOSsAsI9R4ZyrkonQhN7d6Peiicye/O3H+E4GSxnyTT4KKcMkaV6Is2Nxk
         YjYUj7kuhG20pQRbQZ/MLMq/kAFekUpI5YoarCdYqKN+aGI1ezy+mHUpxbbxGil3zOj+
         v2dtlie/Ol72APEMbmrnUTBenlgAjHdOAAEYVCifQVZODmU9HWhDjpbV+DsdcIbIivdF
         ADqYaILOo5fFUjpZ3Z127sTK1QJpI73hgop6VV7QZXMdc/+mi6kpfKMEJM94aYnQfl8K
         lVUFAbf9sF3vzxAGynRWLHxXlrwTp8oRq5fMMYHxI+V0Z5+9WFNsI4CoaoS4pPAxlcY3
         EfzQ==
X-Gm-Message-State: AOJu0Yy5boElxzE0F7MFtP3QVUEyaPsDK/QL2RdFPhYygHxMqnsAm1No
	1XvY400YSxyxWDRjZ8iBdFLWHlMSLSvTnmPaiAEJSfOpDblHOZczepqf
X-Gm-Gg: ATEYQzyQHGQvnw9qzd/AG2rBBoqtjOMBri7GZjF9I5T9oIJqoYawKdfJnZXtfNHY/hm
	DaMkJTeQ6tSfJW8ERf+hyx7VTMz+HjYf30vzLk3SeZQtBLT4kY+z/uU4TgWY4XnQZz4jpQrLp/N
	VdCeEILRh+/iRfYCVJqacArjtuw8Ft4H5oCqIzBl7ImQInaikwdLTWTKk/Jgy424EzkwzL1MNBB
	hNarmsr46vTFc2ReKQ1A9iNSmFc2XD5vJRM/Jd/IbnYvxWGldJkfkUnAc5qvCHa4ozfL73la4Zi
	f99yd9Us9Et3R8oLiwM9Tp4EjUl+5/8UjSeFntS6z1dkzFrE2qzlibYCZ0NNSLCj0cVwbSKCT5E
	K10xio7rpqibPSrK2+a4x+dlLUWZwM1F3beSnkIPbHMMpLrmhpsWYcsBl+q6JXRiRTh6+S2LXly
	f9G7TOyY4cqH9N9/jjQVbvsfR7CFBFmCzE7tezWZfEyIw0elrfW0DrGg==
X-Received: by 2002:a17:90b:2e0f:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-358ae8b23damr14852741a91.16.1772011678742;
        Wed, 25 Feb 2026 01:27:58 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f5f29fsm837901a91.1.2026.02.25.01.27.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 01:27:58 -0800 (PST)
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
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] bpf: add bpf_list_add_impl to insert node after a given list node
Date: Wed, 25 Feb 2026 17:26:48 +0800
Message-ID: <20260225092651.94689-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225092651.94689-1-pilgrimtao@gmail.com>
References: <20260225092651.94689-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add a new kfunc bpf_list_add_impl(prev, node, meta, off) that inserts
'node' after 'prev' in the BPF linked list. Both must be in the same
list; 'prev' must already be in the list. The new node must be an
owning reference (e.g. from bpf_obj_new); the kfunc consumes that
reference and the node becomes non-owning once inserted.

Returns 0 on success, -EINVAL if prev is not in a list or node is
already in a list (or duplicate insertion). On failure, the kernel
drops the passed-in node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 34 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 10 ++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 577af62a9f7a..d212962d4ed6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2495,6 +2495,39 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
 	return (struct bpf_list_node *)h->prev;
 }
 
+static int __bpf_list_add_after(struct bpf_list_node_kern *prev,
+				struct bpf_list_node_kern *node,
+				struct btf_record *rec, u64 off)
+{
+	struct bpf_list_head *head;
+	struct list_head *n = &node->list_head, *p = &prev->list_head;
+
+	head = READ_ONCE(prev->owner);
+	if (unlikely(!head))
+		goto fail;
+
+	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON))
+		goto fail;
+
+	list_add(n, p);
+	WRITE_ONCE(node->owner, head);
+	return 0;
+
+fail:
+	__bpf_obj_drop_impl((void *)n - off, rec, false);
+	return -EINVAL;
+}
+
+__bpf_kfunc int bpf_list_add_impl(struct bpf_list_node *prev,
+				  struct bpf_list_node *node,
+				  void *meta__ign, u64 off)
+{
+	struct bpf_list_node_kern *n = (void *)node, *p = (void *)prev;
+	struct btf_struct_meta *meta = meta__ign;
+
+	return __bpf_list_add_after(p, n, meta ? meta->record : NULL, off);
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -4564,6 +4597,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_add_impl)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e9857177a7a..923deb73683b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12434,6 +12434,7 @@ enum special_kfunc_type {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_add_impl,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12495,6 +12496,7 @@ BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
+BTF_ID(func, bpf_list_add_impl)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -12970,7 +12972,8 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_back];
+	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13092,7 +13095,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 	case BPF_LIST_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
@@ -14237,6 +14241,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
 		insn_aux->insert_off = regs[BPF_REG_2].off;
@@ -23203,6 +23208,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = 3;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 		int struct_meta_reg = BPF_REG_3;
-- 
2.50.1 (Apple Git-155)

