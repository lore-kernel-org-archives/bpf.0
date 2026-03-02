Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDE373BF1
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455249; cv=none; b=WXx8DxAOjTkEcN1alzuyhalhRlkxWh7VK+ygFAbdYPt2nCPe3HYN/SCSbf1J236B0XeVtO4Q/WhSlR25VXG1meccA1Qo9nP1iZpHtZUoOTYOHXdc50kyOVz8/yps8hhYcwvUfZPlRIUYZl2XQscQw0IuT7hW5i00iSQxCNvaSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455249; c=relaxed/simple;
	bh=M355Sbdzqhu36DBOFyHzileJa0ZyXN2c/SHzhAr6JW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYgVC3oqhz4CylM+kcBAqEklEKrSBRsDW3OPGLt993lkbB4pzJvMTNDR0rmuUS9aK8CZ1iE0Hp0T74x1GTV4OCdAmveXzSvMWthT9+jfYKHCbpagQEvTPU6umBmFVT1H00nQ6nW3F0pJuo5vPZ7ozOTUHtotRQ/wAuLT+qmKIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWTQUbu+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWTQUbu+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad617d5b80so27786595ad.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772455248; x=1773060048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2scSrgN6MVzwM6/GDhWSPA9nuDZaPKI6bEHUsTrO/gw=;
        b=fWTQUbu+RczJrsikNd0z5rGla4dbwwxPUk29zKBPNZxJCBkV3hzhpPXeBoN+mCD06g
         7SWPcgrYG4qjDfdXAXux+4Arf3xEzWsVuNnvpsmrzWT45J/je7dfTPXXUKiNzPDRV18F
         13goRjy85LLApdnwMEIva3LmEYJ0Fez72OPtZEU409YmXoF3zZYfz+4o9eeOnWtYYOAz
         j72+h0Bqbq+A8vaT+pn6FtphpBQmus2NLKn+OAk/EF1DsFstIw0WiGfaVO/DJFzPoPLN
         HF9iod+eMmbvDXmUEkfnNk9cFI5h4Gz9zoDCjxetEoEL/u/edr8YGhbFLMwq2qdI4FeJ
         5W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455248; x=1773060048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2scSrgN6MVzwM6/GDhWSPA9nuDZaPKI6bEHUsTrO/gw=;
        b=HXjRtzG+Gy/jh9ERFCBof1WDm902sRdsJHxRzD271MGmCRo4oqfribT0cjkugDDIuf
         rsJeCwVYbgBxd5fq1Hz9xWwuMStWxJqwT+CP/QhoyLuZsUolDH0EAIHwwr/w3fCf+UNp
         tOswv81HPQ06g38Qo3E+DXcyjnhI3qW3G7/0XcBL98FhAcT9nUjlitlTp7oFR8aVPbUb
         y9LbGPowikhlJlAM7MyZuNdy4ev2wPGZZhVo5Y2awUI8dYNLhSn4X0ZGirKoSBEKOeSl
         ZpIjLdFVSfS2luyFt0+nHiseAYBUJRkyV95/gTZQHUfaq5NFftNYAMJ5zeL2+HYFexqR
         TrLQ==
X-Gm-Message-State: AOJu0YxtPy4pAG/Dv5PtZz9B68J80ntFUdzpLdZztLLG8H6PNx80jZNX
	DXoUxFaEm5aeMZIBouedw9ixRRX9s23u8S12d8BAVV1Jg+jFE2L8Lg3r
X-Gm-Gg: ATEYQzyF5tQxorrsDUDCbZnDPfH4KfC6mJc9dOAV1Gi0+ttJXsgm2suHNRmjMOwqLvo
	2hPuQcwUvWNf1WHkpUjnPpxguVyoQ4EpWuSnJuJGSbBXBBVGzx6C/WuraDYSgr0DOasBM4qCtW3
	l/Pos8m6Su2tFFXb7D6mCFztCxz/2oB3TUznd6f5RQ7duO5sI3OcbfthwwG70nP/DmO4Zia80a7
	zQqYS093RpHh/xv6JjG2f9/AxQ2HHvHvFXQRHHR+51MT9YyPJCrt4Uk7cCTYMFRhfel/4LV3oIs
	HAKguKyYqjUDlAfckWHcO49Onmo6zIdTc8PNNFOLRjIcwEAxU8oBbvcA4KQ3FgKWduPHGcprLGG
	6RvxOiaqVKqvEaKDc2l02k5Je5KJfvI6Dhng0B8+tj03KwiV1vRo2jzbgakhFOKK0F0bPyl6BzS
	BbeusJLOJr8gUU7Ri+odoVytghTos3B8zSe6ZTcwqo2RUkEz4k3YycaA==
X-Received: by 2002:a17:903:2449:b0:2ae:57cc:63d7 with SMTP id d9443c01a7336-2ae57cc65femr12287425ad.7.1772455247611;
        Mon, 02 Mar 2026 04:40:47 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1956absm67910225ad.14.2026.03.02.04.40.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Mar 2026 04:40:47 -0800 (PST)
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
Subject: [PATCH v3 1/6] bpf: Introduce the bpf_list_del kfunc.
Date: Mon,  2 Mar 2026 20:40:23 +0800
Message-ID: <20260302124028.82420-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302124028.82420-1-pilgrimtao@gmail.com>
References: <20260302124028.82420-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

If a user holds ownership of a node in the middle of a list, they
can directly remove it from the list without strictly adhering to
deletion rules from the head or tail.

When a kfunc has only one bpf_list_node parameter, supplement the
initialization of the corresponding btf_field. Add a new lock_rec
member to struct bpf_reference_state for lock holding detection.

This is typically paired with bpf_refcount. After calling
bpf_list_del, it is generally necessary to drop the reference to
the list node twice to prevent reference count leaks.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/linux/bpf_verifier.h |  4 +++
 kernel/bpf/btf.c             | 33 +++++++++++++++++++---
 kernel/bpf/helpers.c         | 17 ++++++++++++
 kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++++++++++++--
 4 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ef8e45a362d9..e1358b62d6cc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -261,6 +261,10 @@ struct bpf_reference_state {
 	 * it matches on unlock.
 	 */
 	void *ptr;
+	/* For REF_TYPE_LOCK_*: btf_record of the locked object, used for lock
+	 * checking in kfuncs such as bpf_list_del.
+	 */
+	struct btf_record *lock_rec;
 };
 
 struct bpf_retval_range {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..8a977c793d56 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3785,7 +3785,6 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_RES_SPIN_LOCK:
 	case BPF_TIMER:
 	case BPF_WORKQUEUE:
-	case BPF_LIST_NODE:
 	case BPF_RB_NODE:
 	case BPF_REFCOUNT:
 	case BPF_TASK_WORK:
@@ -3794,6 +3793,27 @@ static int btf_find_field_one(const struct btf *btf,
 		if (ret < 0)
 			return ret;
 		break;
+	case BPF_LIST_NODE:
+		ret = btf_find_struct(btf, var_type, off, sz, field_type,
+				      info_cnt ? &info[0] : &tmp);
+		if (ret < 0)
+			return ret;
+		/* graph_root for verifier: container type and node member name */
+		if (info_cnt && var_idx >= 0 && (u32)var_idx < btf_type_vlen(var)) {
+			u32 id;
+			const struct btf_member *member;
+
+			for (id = 1; id < btf_nr_types(btf); id++) {
+				if (btf_type_by_id(btf, id) == var) {
+					info[0].graph_root.value_btf_id = id;
+					member = btf_type_member(var) + var_idx;
+					info[0].graph_root.node_name =
+						__btf_name_by_offset(btf, member->name_off);
+					break;
+				}
+			}
+		}
+		break;
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
@@ -4138,6 +4158,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_LIST_NODE:
 		case BPF_LIST_HEAD:
 			ret = btf_parse_list_head(btf, &rec->fields[i], &info_arr[i]);
 			if (ret < 0)
@@ -4148,7 +4169,6 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
-		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 			break;
 		default:
@@ -4192,20 +4212,25 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 	int i;
 
 	/* There are three types that signify ownership of some other type:
-	 *  kptr_ref, bpf_list_head, bpf_rb_root.
+	 *  kptr_ref, bpf_list_head/node, bpf_rb_root.
 	 * kptr_ref only supports storing kernel types, which can't store
 	 * references to program allocated local types.
 	 *
 	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
 	 * does not form cycles.
 	 */
-	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & (BPF_GRAPH_ROOT | BPF_UPTR)))
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask &
+	   (BPF_GRAPH_ROOT | BPF_GRAPH_NODE | BPF_UPTR)))
 		return 0;
+
 	for (i = 0; i < rec->cnt; i++) {
 		struct btf_struct_meta *meta;
 		const struct btf_type *t;
 		u32 btf_id;
 
+		if (rec->fields[i].type & BPF_GRAPH_NODE)
+			rec->fields[i].graph_root.value_rec = rec;
+
 		if (rec->fields[i].type == BPF_UPTR) {
 			/* The uptr only supports pinning one page and cannot
 			 * point to a kernel struct
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6eb6c82ed2ee..577af62a9f7a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2459,6 +2459,22 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, true);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_node *node)
+{
+	struct bpf_list_node_kern *knode = (struct bpf_list_node_kern *)node;
+
+	if (unlikely(!knode))
+		return NULL;
+
+	if (WARN_ON_ONCE(!READ_ONCE(knode->owner)))
+		return NULL;
+
+	list_del_init(&knode->list_head);
+	WRITE_ONCE(knode->owner, NULL);
+
+	return node;
+}
+
 __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
 {
 	struct list_head *h = (struct list_head *)head;
@@ -4545,6 +4561,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a3390190c26e..8a782772dd36 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1536,7 +1536,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
 }
 
 static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
-			      int id, void *ptr)
+			      int id, void *ptr, struct btf_record *lock_rec)
 {
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_reference_state *s;
@@ -1547,6 +1547,7 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	s->type = type;
 	s->id = id;
 	s->ptr = ptr;
+	s->lock_rec = lock_rec;
 
 	state->active_locks++;
 	state->active_lock_id = id;
@@ -1662,6 +1663,23 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	return NULL;
 }
 
+static bool rec_has_list_matching_node_type(struct bpf_verifier_env *env,
+					   const struct btf_record *rec,
+					   const struct btf *node_btf, u32 node_btf_id)
+{
+	u32 i;
+
+	for (i = 0; i < rec->cnt; i++) {
+		if (!(rec->fields[i].type & BPF_LIST_HEAD))
+			continue;
+		if (btf_struct_ids_match(&env->log, node_btf, node_btf_id, 0,
+					rec->fields[i].graph_root.btf,
+					rec->fields[i].graph_root.value_btf_id, true))
+			return true;
+	}
+	return false;
+}
+
 static void update_peak_states(struct bpf_verifier_env *env)
 {
 	u32 cur_states;
@@ -8576,7 +8594,8 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 			type = REF_TYPE_RES_LOCK;
 		else
 			type = REF_TYPE_LOCK;
-		err = acquire_lock_state(env, env->insn_idx, type, reg->id, ptr);
+		err = acquire_lock_state(env, env->insn_idx, type, reg->id, ptr,
+					 reg_btf_record(reg));
 		if (err < 0) {
 			verbose(env, "Failed to acquire lock state\n");
 			return err;
@@ -12431,6 +12450,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
@@ -12491,6 +12511,7 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
@@ -12966,6 +12987,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_back];
 }
@@ -13088,7 +13110,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
@@ -13211,6 +13234,9 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	if (!*node_field)
+		*node_field = field;
+
 	field = *node_field;
 
 	et = btf_type_by_id(field->graph_root.btf, field->graph_root.value_btf_id);
@@ -13237,6 +13263,28 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	/* bpf_list_del: require list head's lock. Use refs[] REF_TYPE_LOCK_MASK
+	 * only. At lock time we stored the locked object's btf_record in ref->
+	 * lock_rec, so we can get the list value type from the ref directly.
+	 */
+	if (node_field_type == BPF_LIST_NODE &&
+	    meta->func_id == special_kfunc_list[KF_bpf_list_del]) {
+		struct bpf_verifier_state *cur = env->cur_state;
+
+		for (int i = 0; i < cur->acquired_refs; i++) {
+			struct bpf_reference_state *s = &cur->refs[i];
+
+			if (!(s->type & REF_TYPE_LOCK_MASK) || !s->lock_rec)
+				continue;
+
+			if (rec_has_list_matching_node_type(env, s->lock_rec,
+							reg->btf, reg->btf_id))
+				return 0;
+		}
+		verbose(env, "bpf_spin_lock must be held for bpf_list_del\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)

