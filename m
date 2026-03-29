Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735F37A486
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793181; cv=none; b=q2V183xqIDtO1h03s7AQKMQeWO/al6QFUBTojK/r0vWDiBV7FzVBR+uKQ7jjyj+Y3O6/D4dfG+uXepQazGK2y0zrtk5/HGlT+43BMz1azmSt3H9417DlV9KLprB4JdVdWRuFs8guXGBHK0Z1Pv8xrccb8qrfcsP61jTQPaWUijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793181; c=relaxed/simple;
	bh=iFNWymfmfxX/QJqdbdhLQocWSeqa+lLLvreHPgxAa/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI+bIA3nl5AUL/dYgfEHCGHp1xOB0Ek7uxackcplohChOtb0nkXRHkg2cEZmv6/Nm6ZkN322Z7znoPgJi0fNtXwk2k5Q749zODW3Dujm0HtWI0QGkEaYHboy1w6h8+gP29GFSPxW0ERG9hPyyKGQXa0yzkKGZ+432GP78krc29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClAJhtE9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClAJhtE9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso517759a91.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793180; x=1775397980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZLdK6dkEj8TjVSrlUlFfcQoiH20fwv6lL/iTYgpM30=;
        b=ClAJhtE9Wo1SkS82Zy2w3iJlP3CYqk6H/cJ+vzeECj/kFaPFi2LOv0wiAD/gCktkIv
         hNdo+xkZrGObOurHi3tqYE3djX/rQcvjMq/cjskor7Nu/eEHI7Be0jQe0HSmjetDNsqT
         ZGWEogWoZ5HRQLNUexH0b727E9AEMhFR3Dwqt47LiAqe6S3c+p8371K6lmwRgoAi6bGQ
         aSFj4RtQbL6GoBZjv7PzmwVtFHXm7EroCuw1rJA4gSwh2O2m4a+HQgtacj0W59DlWGrH
         zvzjbhHg5tc5od4mUhq5nQTjfloaqR6X1+wzvDVhaSiXBX7OgCQzT7H14R0K9FbJIGvV
         xlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793180; x=1775397980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZLdK6dkEj8TjVSrlUlFfcQoiH20fwv6lL/iTYgpM30=;
        b=lZJ61WN3Bc7z0x27iF0PIVeYMBIqneD2hqgUNdjjZN7HrXpOG9Q+KkkuTSr/Wa2+PI
         WAvFpDcZJDqO5FDIEcOo0bwfWfbzDG9ibxn0/mLmr0nU3eRup5GLlo7ssPJQMcK2A71U
         gavuizSMfxVQt1hCEzDmVb46DiYQ4ASZIuINdSWhBgdp2rUuhcuSdFgwgw3Mn1F8/PwQ
         hvNonbLCuYbrk4RzjRazhBBi8+hRyjwbnrWC11n9aTeFvUi9WwcptLHP4Re3ECv7R6Jk
         0ru2kXS9qE+u8gQIcrOghtk4HLnStMfd/ClsIMwULqiE96chtC60F1yuSUjuATJ441cS
         y50A==
X-Gm-Message-State: AOJu0YxiWzeGZI/AB/8dOxebbFc3WeUh1hL2xxT/cvuf1EwZiVrDC14y
	FvcmaWOxtGCr13ImgumZ3J9jCze6wVzRfwpmgvGGYFDeJUzHx8yNVRWY
X-Gm-Gg: ATEYQzyWm/n+G845UtaJNGVDDnrY/F37vfflhD006QFC6W4gx/9eWB5TguW2vi7ZsS5
	QABBa37707ed7gg+Wafxy3GgjC7Ctehvbmwl9xHo+pOEXRUQWPmmsNfH4wmIB1bNf+AV2cFowYN
	QZ3g5FksMQjPKxoq1fM2n3gjNc3ncESEznaBOWYhCmD6h6K9So3jiJ2WWgUrcJtCfr4Ka+HNFQg
	DizCcQkIlNV5rx/IKBgzpXenalPoRffV/8HhVj3aquHgHuuneDjwRdUlt7ZChH7AJy2rYWu3jXh
	GypcdCNknYsibaBug+aPcL3kEVeoAkkGoJJLQ1kudGghMH3SV5YZDyFAFkh4WBCy4+YmeE1ygPf
	Whf9uJqxIM1aAtBlUUivwPlDcNMakBa8nHB7dSQOvcroDB4OPezCSAAKd6H/ZLN7zhkI60tYy0a
	2q2VAM1SkfP9Nr+W1FDt/+pethvj5A+qa52VEj2UPE0q3GKdRB8roFMHd//WcK26Ih
X-Received: by 2002:a17:90b:3b44:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-35c300f9c52mr8062463a91.23.1774793179945;
        Sun, 29 Mar 2026 07:06:19 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.06.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:06:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 9/9] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
Date: Sun, 29 Mar 2026 22:05:06 +0800
Message-ID: <20260329140506.9595-10-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329140506.9595-1-pilgrimtao@gmail.com>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Extend refcounted_kptr with tests for bpf_list_add (including prev from
bpf_list_front and bpf_refcount_acquire), bpf_list_del (including node
from bpf_rbtree_remove and bpf_refcount_acquire), bpf_list_empty,
bpf_list_is_first/last, and push_back on uninit head.

To verify the validity of bpf_list_del/add, the test also expects the
verifier to reject calls to bpf_list_del/add made without holding the
spin_lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  16 +
 .../selftests/bpf/progs/refcounted_kptr.c     | 311 ++++++++++++++++++
 2 files changed, 327 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 44466acf8083..5821f0000e1f 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -85,6 +85,22 @@ extern int bpf_list_push_back_impl(struct bpf_list_head *head,
 /* Convenience macro to wrap over bpf_list_push_back_impl */
 #define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
 
+/* Description
+ *	Insert 'new' after 'prev' in the BPF linked list with head 'head'.
+ *	The bpf_spin_lock protecting the list must be held. 'prev' must already
+ *	be in that list; 'new' must not be in any list. The 'meta' and 'off'
+ *	parameters are rewritten by the verifier, no need for BPF programs to
+ *	set them.
+ * Returns
+ *	0 on success, -EINVAL if head is NULL, prev is not in the list with head,
+ *	or new is already in a list.
+ */
+extern int bpf_list_add_impl(struct bpf_list_head *head, struct bpf_list_node *new,
+			     struct bpf_list_node *prev, void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_list_add_impl */
+#define bpf_list_add(head, new, prev) bpf_list_add_impl(head, new, prev, NULL, 0)
+
 /* Description
  *	Remove the entry at the beginning of the BPF linked list.
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index c847398837cc..e5558994a76d 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,6 +367,317 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
+SEC("tc")
+__description("list_empty_test: list empty before add, non-empty after add")
+__success __retval(0)
+int list_empty_test(void *ctx)
+{
+	struct node_data *node_new;
+
+	bpf_spin_lock(&lock);
+	if (!bpf_list_empty(&head)) {
+		bpf_spin_unlock(&lock);
+		return -1;
+	}
+	bpf_spin_unlock(&lock);
+
+	node_new = bpf_obj_new(typeof(*node_new));
+	if (!node_new)
+		return -2;
+
+	bpf_spin_lock(&lock);
+	bpf_list_push_front(&head, &node_new->l);
+
+	if (bpf_list_empty(&head)) {
+		bpf_spin_unlock(&lock);
+		return -3;
+	}
+	bpf_spin_unlock(&lock);
+	return 0;
+}
+
+static struct node_data *__add_in_list(struct bpf_list_head *head,
+				       struct bpf_spin_lock *lock)
+{
+	struct node_data *node_new, *node_ref;
+
+	node_new = bpf_obj_new(typeof(*node_new));
+	if (!node_new)
+		return NULL;
+
+	node_ref = bpf_refcount_acquire(node_new);
+
+	bpf_spin_lock(lock);
+	bpf_list_push_front(head, &node_new->l);
+	bpf_spin_unlock(lock);
+	return node_ref;
+}
+
+SEC("tc")
+__description("list_is_edge_test: is_first on first node, is_last on last node")
+__success __retval(0)
+int list_is_edge_test(void *ctx)
+{
+	struct node_data *node_first, *node_last;
+	int err = 0;
+
+	node_last = __add_in_list(&head, &lock);
+	if (!node_last)
+		return -1;
+
+	node_first = __add_in_list(&head, &lock);
+	if (!node_first) {
+		bpf_obj_drop(node_last);
+		return -2;
+	}
+
+	bpf_spin_lock(&lock);
+	if (!bpf_list_is_first(&head, &node_first->l)) {
+		err = -3;
+		goto fail;
+	}
+	if (!bpf_list_is_last(&head, &node_last->l))
+		err = -4;
+
+fail:
+	bpf_spin_unlock(&lock);
+	bpf_obj_drop(node_first);
+	bpf_obj_drop(node_last);
+	return err;
+}
+
+SEC("tc")
+__description("list_del_test1: del returns removed nodes")
+__success __retval(0)
+int list_del_test1(void *ctx)
+{
+	struct node_data *node_first, *node_last;
+	struct bpf_list_node *bpf_node_first, *bpf_node_last;
+	int err = 0;
+
+	node_last = __add_in_list(&head, &lock);
+	if (!node_last)
+		return -1;
+
+	node_first = __add_in_list(&head, &lock);
+	if (!node_first) {
+		bpf_obj_drop(node_last);
+		return -2;
+	}
+
+	bpf_spin_lock(&lock);
+	bpf_node_last = bpf_list_del(&head, &node_last->l);
+	bpf_node_first = bpf_list_del(&head, &node_first->l);
+	bpf_spin_unlock(&lock);
+
+	if (bpf_node_first)
+		bpf_obj_drop(container_of(bpf_node_first, struct node_data, l));
+	else
+		err = -3;
+
+	if (bpf_node_last)
+		bpf_obj_drop(container_of(bpf_node_last, struct node_data, l));
+	else
+		err = -4;
+
+	bpf_obj_drop(node_first);
+	bpf_obj_drop(node_last);
+	return err;
+}
+
+SEC("tc")
+__description("list_del_test2: remove an arbitrary node from the list")
+__success __retval(0)
+int list_del_test2(void *ctx)
+{
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l;
+	struct node_data *n;
+	long err;
+
+	err = __insert_in_tree_and_list(&head, &root, &lock);
+	if (err)
+		return err;
+
+	bpf_spin_lock(&lock);
+	rb = bpf_rbtree_first(&root);
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -4;
+	}
+
+	rb = bpf_rbtree_remove(&root, rb);
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -5;
+	}
+
+	n = container_of(rb, struct node_data, r);
+	l = bpf_list_del(&head, &n->l);
+	bpf_spin_unlock(&lock);
+	bpf_obj_drop(n);
+	if (!l)
+		return -6;
+
+	bpf_obj_drop(container_of(l, struct node_data, l));
+	return 0;
+}
+
+SEC("tc")
+__description("list_add_test1: insert new node after prev")
+__success __retval(0)
+int list_add_test1(void *ctx)
+{
+	struct node_data *node_first;
+	struct node_data *new_node;
+	long err = 0;
+
+	node_first = __add_in_list(&head, &lock);
+	if (!node_first)
+		return -1;
+
+	new_node = bpf_obj_new(typeof(*new_node));
+	if (!new_node) {
+		err = -2;
+		goto fail;
+	}
+
+	bpf_spin_lock(&lock);
+	err = bpf_list_add(&head, &new_node->l, &node_first->l);
+	bpf_spin_unlock(&lock);
+	if (err) {
+		err = -3;
+		goto fail;
+	}
+
+fail:
+	bpf_obj_drop(node_first);
+	return 0;
+}
+
+SEC("tc")
+__description("list_add_test2: list_add accepts list_front return value as prev")
+__success __retval(0)
+int list_add_test2(void *ctx)
+{
+	struct node_data *new_node, *tmp;
+	struct bpf_list_node *bpf_node;
+	long err = 0;
+
+	tmp = __add_in_list(&head, &lock);
+	if (!tmp)
+		return -1;
+
+	new_node = bpf_obj_new(typeof(*new_node));
+	if (!new_node) {
+		err = -2;
+		goto fail;
+	}
+
+	bpf_spin_lock(&lock);
+	bpf_node = bpf_list_front(&head);
+	if (!bpf_node) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(new_node);
+		err = -3;
+		goto fail;
+	}
+
+	err = bpf_list_add(&head, &new_node->l, bpf_node);
+	bpf_spin_unlock(&lock);
+	if (err) {
+		err = -4;
+		goto fail;
+	}
+
+fail:
+	bpf_obj_drop(tmp);
+	return err;
+}
+
+struct uninit_head_val {
+	struct bpf_spin_lock lock;
+	struct bpf_list_head head __contains(node_data, l);
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct uninit_head_val);
+	__uint(max_entries, 1);
+} uninit_head_map SEC(".maps");
+
+SEC("tc")
+__description("list_push_back_uninit_head: push_back on 0-initialized list head")
+__success __retval(0)
+int list_push_back_uninit_head(void *ctx)
+{
+	struct uninit_head_val *st;
+	struct node_data *node;
+	int ret = -1, key = 0;
+
+	st = bpf_map_lookup_elem(&uninit_head_map, &key);
+	if (!st)
+		return -1;
+
+	node = bpf_obj_new(typeof(*node));
+	if (!node)
+		return -1;
+
+	bpf_spin_lock(&st->lock);
+	ret = bpf_list_push_back(&st->head, &node->l);
+	bpf_spin_unlock(&st->lock);
+
+	return ret;
+}
+
+SEC("?tc")
+__failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
+long list_del_without_lock_fail(void *ctx)
+{
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l;
+	struct node_data *n;
+
+	bpf_spin_lock(&lock);
+	rb = bpf_rbtree_first(&root);
+	bpf_spin_unlock(&lock);
+	if (!rb)
+		return -1;
+
+	n = container_of(rb, struct node_data, r);
+	/* Error case: delete list node without holding lock */
+	l = bpf_list_del(&head, &n->l);
+	if (!l)
+		return -2;
+	bpf_obj_drop(container_of(l, struct node_data, l));
+
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
+long list_add_without_lock_fail(void *ctx)
+{
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l;
+	struct node_data *n;
+
+	bpf_spin_lock(&lock);
+	rb = bpf_rbtree_first(&root);
+	l = bpf_list_front(&head);
+	bpf_spin_unlock(&lock);
+	if (!rb || !l)
+		return -1;
+
+	n = container_of(l, struct node_data, l);
+	/* Error case: add list node without holding lock */
+	if (bpf_list_add(&head, &n->l, l))
+		return -2;
+
+	return 0;
+}
+
 SEC("tc")
 __success
 long rbtree_refcounted_node_ref_escapes(void *ctx)
-- 
2.50.1 (Apple Git-155)

