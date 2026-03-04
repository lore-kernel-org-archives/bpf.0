Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADD3A8747
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634938; cv=none; b=p6Zb2k/LEUjw+TeeRLLLhNyj5pn5OApeF3QhrxIpmmESjEs+HPV6SK9DGj2SGFxj6UVZLIjZzzf41wQeZk5s25ACdZAXD756J64mjJwd/1zGHMkE9jCx2Q/oRXf86BGjE0JnQ0fyidISAFxzs99o17IgJBm6RXtCsU2nnSeYNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634938; c=relaxed/simple;
	bh=xwZ3UGx9G2sdDI6IE3+6gfQlSrbF46ymwr2NWpQcIMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZiz6B7CuYKM0I2IoztdVv5xJehxpZjSjXxm41OD4Livc5mmFGPVK3tL+FTzjxNGqdfsmSpgARhjvaNa4ighPpXnUwirrioXzp4DCgEvtTacVqolPwZXnIs3pVY5YB3mLhBrjUd73L1FAs9+lqB8GH2l1jHsGx9jveJ0Kk/LswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUId7j7s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUId7j7s"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82746ed8cdcso4432281b3a.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634937; x=1773239737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7egJvwJqBHagMwboSMYPKqhuF2wpmChoASF/sFznWPI=;
        b=SUId7j7szEKGVEra/ItJxWvmHjLs47A62KwhKSLO4xtmnz1UbuYclNHkTJM4JIZ5ek
         ML+stupvmjnl3Z9NB0Y7oP6VMIR3hAbN4rQ+Ol8LR4NrhJOHdbZLkkqbRR5AdoFdWCNh
         7zO9ugL6JVGB2ttgHrquUY1psRn0G//NLIQ4d72E+91P0LvK6XsYd7oSXyT3xRTUA5xd
         t85lvr/zDlqJnCGcYIzbGaMeVaIYUVraDHcMgHfvgyQUnzmBGUe4onB+/McqK+lyq3QK
         jagHcrLm5TXAO/GBjKIqrV+KsJB/5L65VI1tx1ezDpBKvJR/Bq8Ncj/dWb8usRep3PMu
         b49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634937; x=1773239737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7egJvwJqBHagMwboSMYPKqhuF2wpmChoASF/sFznWPI=;
        b=B57fD+2BF2E50VxCZAGx8TLvEdjqow0B5rCul5WpBuc8ufZGqQx04WmyGYhsn8b++5
         NpOwt+uzA07qjj59Dee8nKsAg51N9Xc2zACM2vZhErVDPz35OzmATEK9aUSrUDMSeGPS
         MQVFFAm3VfBKmAEAn5f2YzPE+fMK5mMvY+JxA12Rwo0vTsJIs9TWBEsX77tNCZc3D0Mq
         GpS5+L2bBRvbYDCVzphHm5yNWefqc4MsP6XNKHCQeFXBuA1N9Ul38WUacQ2Po38Rgbjz
         5jbDiQSnOGPa2671rZydfpBmZB114YxmWiaU0oQR9+Azbx+N+ZWwQewbxkYwmCdqE3fp
         t+CA==
X-Gm-Message-State: AOJu0YwoWK5wpzXhCZSu5u8B9z4infJjqw5V5TuZlV0SY+Y2+7ifUKY2
	34dPpWRoLzl/icSq1csT3xotzQ0Fq6vTXUbP/J+IaxFxa5W6AuIDcjP7
X-Gm-Gg: ATEYQzxmznRzk42hiGZwvWnL+ChQT9NVow5PWLabjPszhm4IbQ0Bqh+ERrrbhbLC6cy
	L2sc3zvi9JQWZsHuYTzWhPQOE3Xo0moeouyx8stFbZbsNIMULFOL/70G4Ji3Yxjw+i3jhxogRBO
	cXslpDSnPZ0/sPqrl8kQC0WgrawFJaOwMXzkImttOgKHartAvW9HyjwkYbuMEHeBUtIg3rYOuPm
	CffyTfJJwoLMdhpdTc3qIVYE0DA31cOHvJU5PN5ZKeDcUQuqf1kGPUcHN2S852AFL/d2IK+HPcq
	6640SyYzes2CMEWR82CJuaPtf+iTnDYhr3hFoIdiHa62BqVdhGC9gwhTw3XI2QiIirvPBK/kqXH
	meTDhNpy+sXkoLSm8pF1VF8eCoofTYu5APLDIHhfa/XiYoanFAim4D+6cFj/1q7aVEU6b2yH3b3
	Y4C4Tw+pWq8/8shkkoLxX21vFot9wtie89cVZUdnuT9aaCzRCiurfiDQhKRlj0AH74
X-Received: by 2002:a05:6a00:4393:b0:827:3e19:574b with SMTP id d2e1a72fcca58-82972c9f980mr1726978b3a.43.1772634936549;
        Wed, 04 Mar 2026 06:35:36 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm18470184b3a.15.2026.03.04.06.35.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 06:35:36 -0800 (PST)
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
Subject: [PATCH v6 2/5] bpf: Add bpf_list_add_impl to insert node after a given list node
Date: Wed,  4 Mar 2026 22:34:56 +0800
Message-ID: <20260304143459.78059-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304143459.78059-1-pilgrimtao@gmail.com>
References: <20260304143459.78059-1-pilgrimtao@gmail.com>
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
 kernel/bpf/helpers.c  | 34 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 17 +++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cc1a096a1f64..740b53024283 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2505,6 +2505,39 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
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
+	struct list_head *h = (void *)head;
+
+	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
+	 * called on its fields, so init here
+	 */
+	if (unlikely(!h->next)) {
+		INIT_LIST_HEAD(h);
+		goto fail;
+	}
+
+	if (WARN_ON_ONCE(READ_ONCE(kp->owner) != head))
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
@@ -4574,6 +4607,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_add_impl)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9557d3fb8dd..e458cf3b1dd1 100644
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
@@ -23230,13 +23235,17 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+		/* list/rbtree_add_impl have an extra arg (prev/less),
+		 * so args-to-fixup are in different regs.
+		 */
+		if (desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+		    desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 			struct_meta_reg = BPF_REG_4;
 			node_offset_reg = BPF_REG_5;
 		}
-- 
2.50.1 (Apple Git-155)

