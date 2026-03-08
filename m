Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1923EAB7
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977624; cv=none; b=iRh+muym5uCuswHtKwYlN1w8OmQD3iNeRvdmIs4W1M3dtBj1ROHrsRSGtHS39UAFC3uIWIlQ04SLBVbYcAfg9OqU4KFz+fT60GzspzsQ3cqJV0i6+maLpgYD2EgDUCKLk+8x/FIRFytrdULg6xACRiIIqEOY4xpBvDfl/+wMxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977624; c=relaxed/simple;
	bh=vlnT0qx9z2tgLchicqex4emzHsHHdPmTZee/+gMzAko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx1PoWnvwo14b3f6dfscwlgyROLSib4thR2nOjUzv/i1lY3sog7lc0gB5q6B4GilLK/Iavg3c+XKAalQgx5UK8q8a6FQybMfskzNg5STZYs6thk1d0y2yqhPbwk9geJ+2eYcemN7+93GXewm4q9/HJedd6UIAkyJK6uZXGhYtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9A+AyJV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9A+AyJV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829b2018c94so833500b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772977622; x=1773582422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE0gvW5I8wxwMECBfOzg+fw5DMaARSTRZ4S0cwcKh68=;
        b=Y9A+AyJVUz9IV8H+qjB5vnmrWiC60SMaBMr1FVkQw5MVJ1gUkD6rbi2Ce0vEnHHyl1
         VbO2B7OAozOaJVaQ9AREpmUCQjZpyWO5e6AuqXHWMZ13LWN7oQDUFGbe08WjZlxooAam
         FOoPtzw+c6TLAkxiZYMcd/zJuejwFT4BUShQvkwSulUn71cTqnj8hNnX9dHb+gvCoop8
         CjL5LDeFSh2BY8OGrP+szO2M7jlgfpxof3LPWa0NS3JVqQA5+BwUDKmtkcmeWR1khKt9
         zIxTemwQeM8y+g2RevzyShFBv+RWyHQeQjlV+ZTel9QhJyLGeCNY7bI9bF+oEt1Oefud
         yt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977622; x=1773582422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LE0gvW5I8wxwMECBfOzg+fw5DMaARSTRZ4S0cwcKh68=;
        b=vJ1a9MzsXVpkCKps4ZU8CmRS4KVw0wkbt+fGeh1k7l2YnTPEAwHsYkasFeJOMY0jSY
         kJinIuhIjda+DsbS2mTNU9URqBR2rsP69DSIWtRbLAm0g2rNoBPNmdlobSfBDOxEQYzA
         zyc9Zt9EkwynvGJN8Y7n/rvDDqrKVT6dT6mnhvij9UtN/wsUjxZChYMOHK6X014tjjuF
         b3vQf1Yqpy/LMXg+kbZCViHdI4A3vayIwL2wZ6stMO3zviyNrXrM+Z38bTCTvBkBosSD
         ykm8pdr0nEDgDT2iYBmjAnMA5WkIM8WNFjdzDBOL0yT5UOBs8vTyPFXviXFjoe02n0xb
         2DNA==
X-Gm-Message-State: AOJu0YxCSigLm/cxIYsufxvrGGUXAGW6SGOYuisCrc58/nTmKQ84U9BK
	6+Wlkt1d/20Tp5WZUBqrycmmsbp6BkSr2P0aENMJdTFw38CxWY9994+N
X-Gm-Gg: ATEYQzx5qF5MHts2lhI0kxdIDYm2bYTTaCjGuKh5h10D5twM1umdBYhJwcHcP4yCItC
	QZc9+PAKTpq7SFLf+Rc9/P7RrefqGA4aVufBesixRBk1R2QnRMF52fwZTi/9SVnxSmbn6qMNS8I
	SA7t6zupl1jiVtOZ/wbJpl6WqY2sT5sPRR+xs+h+Rsz9h/LmHzU6NpIP0nfTYTm/5El6/4+VE6m
	Mg6+X4F1SoTnlYMs5VxoEn/Ei1DpxodWulpvxwOPg561TJDkurYyrdmvrVpgOGOYJwCvKlgaBXn
	/grOk0XJ7wxje4PdT+OJDTvgNdidbuBuWUJOiwAKYhptj2YbZC1x1cE2hrtaTTD47rBcXXDVnYC
	F0s5aUZRQ1/7b+zYeR1+vKAjcHdDkucrQ087SV7fYZTQEVyAxPYjCT3303cYaqYXSYZNaGv+eym
	Q10lCgMW9DTy95Z79PR3OeDa0vg88eRXzlcW2ztojLK7jYcqjX
X-Received: by 2002:a05:6a00:21d4:b0:824:36f8:3461 with SMTP id d2e1a72fcca58-829a2e14048mr6726119b3a.23.1772977622138;
        Sun, 08 Mar 2026 06:47:02 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636968sm7095056b3a.9.2026.03.08.06.46.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Mar 2026 06:47:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/5] bpf: Add bpf_list_add_impl to insert node after a given list node
Date: Sun,  8 Mar 2026 21:46:11 +0800
Message-ID: <20260308134614.29711-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260308134614.29711-1-pilgrimtao@gmail.com>
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
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
 kernel/bpf/helpers.c  | 56 ++++++++++++++++++++++++++++++-------------
 kernel/bpf/verifier.c | 13 ++++++++--
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 01b74c4ac00d..407520fde668 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2379,11 +2379,12 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
 	return (void *)p__refcounted_kptr;
 }
 
-static int __bpf_list_add(struct bpf_list_node_kern *node,
-			  struct bpf_list_head *head,
-			  bool tail, struct btf_record *rec, u64 off)
+static int __bpf_list_add(struct bpf_list_head *head,
+			  struct bpf_list_node_kern *new,
+			  struct list_head *prev,
+			  struct btf_record *rec, u64 off)
 {
-	struct list_head *n = &node->list_head, *h = (void *)head;
+	struct list_head *n = &new->list_head, *h = (void *)head;
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -2391,39 +2392,59 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
 
-	/* node->owner != NULL implies !list_empty(n), no need to separately
+	/* When prev is not the list head, it must be a node in this list. */
+	if (prev != h && WARN_ON_ONCE(READ_ONCE(container_of(
+	    prev, struct bpf_list_node_kern, list_head)->owner) != head))
+		goto fail;
+
+	/* new->owner != NULL implies !list_empty(n), no need to separately
 	 * check the latter
 	 */
-	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
-		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl((void *)n - off, rec, false);
-		return -EINVAL;
-	}
-
-	tail ? list_add_tail(n, h) : list_add(n, h);
-	WRITE_ONCE(node->owner, head);
+	if (cmpxchg(&new->owner, NULL, BPF_PTR_POISON))
+		goto fail;
 
+	list_add(n, prev);
+	WRITE_ONCE(new->owner, head);
 	return 0;
+
+fail:
+	/* Only called from BPF prog, no need to migrate_disable */
+	__bpf_obj_drop_impl((void *)n - off, rec, false);
+	return -EINVAL;
 }
 
 __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
 					 struct bpf_list_node *node,
 					 void *meta__ign, u64 off)
 {
-	struct bpf_list_node_kern *n = (void *)node;
+	struct bpf_list_node_kern *new = (void *)node;
 	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
+	return __bpf_list_add(head, new, h, meta ? meta->record : NULL, off);
 }
 
 __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 					struct bpf_list_node *node,
 					void *meta__ign, u64 off)
 {
-	struct bpf_list_node_kern *n = (void *)node;
+	struct bpf_list_node_kern *new = (void *)node;
+	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *h = (void *)head;
+
+	return __bpf_list_add(head, new, h->prev, meta ? meta->record : NULL, off);
+}
+
+__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
+				  struct bpf_list_node *new,
+				  struct bpf_list_node *prev,
+				  void *meta__ign, u64 off)
+{
+	struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
 	struct btf_struct_meta *meta = meta__ign;
 
-	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
+	return __bpf_list_add(head, kn, &kp->list_head,
+			      meta ? meta->record : NULL, off);
 }
 
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
@@ -4563,6 +4584,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_add_impl)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9557d3fb8dd..5f55b68ed935 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12459,6 +12459,7 @@ enum special_kfunc_type {
 	KF_bpf_refcount_acquire_impl,
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
+	KF_bpf_list_add_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
 	KF_bpf_list_del,
@@ -12520,6 +12521,7 @@ BTF_ID(func, bpf_obj_drop_impl)
 BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
+BTF_ID(func, bpf_list_add_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
@@ -12996,6 +12998,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
@@ -13122,6 +13125,7 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 	case BPF_LIST_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
 		break;
 	case BPF_RB_NODE:
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

