Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5134DCCC
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660595; cv=none; b=tH0eOF/ph+/yfA4CdCOwLTUAkiVURsrZeRS98ZeS9J6CeOvNlWeCXqHJaoAgS5WApxWo/BpetjZ6xOGke1r7pz9QSAeJ+zTccpa2yv4syZWhSj+CcLOLXN72+Yz+s+MWmDSNbMIZQQw6HTTDCDR3amjMVBVUDwEfkK5XeojOgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660595; c=relaxed/simple;
	bh=iFNWymfmfxX/QJqdbdhLQocWSeqa+lLLvreHPgxAa/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPMXc+po8EdvM4/1DTc8wS1RRZE6FUpiLYu4o+3DzU+gWS+kkCbfoMGKnVPDKEnyrfX0AxG46zKZrhQ6abLgSOdKHnf3h+K10k6eQuE61cEJW39AaVTDahxopumWhVBZQ6BfprO8lpDYhcEbpcWJD5Dc5dGlk7YTnof9dYeijfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSrMChax; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSrMChax"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2943903a12.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660593; x=1774265393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZLdK6dkEj8TjVSrlUlFfcQoiH20fwv6lL/iTYgpM30=;
        b=OSrMChaxTPi4rDkJrzJHNphoewSkJtP5z7riBpE2UEna6QWdR8LbiXTQG3+mFnfa5s
         btHmPhExpGSCLUAMdyKWw+1Huy2EbqZDP6kVlEYskK7LaNubH0TLP+0dK6iuk7SFMz0j
         20MyrehWCqBTVe5yYbrMqv5ofIW/Xmdp5nWr2MhjqMmsrYnBoLWe5EHZSJTL54RuQmI7
         x2ceCsGGuayqUps9/n18uygPhisCZCIHHcSm8SmY3vjfuHlZhH0l89FQF5+kH2kXMo4Z
         n3xI6ZcKMo9s9jRh1aWrhg59+W04FEGsHJiNht/YJBykyvTEA1HePlaXRjWgih2TT2gT
         wqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660593; x=1774265393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZLdK6dkEj8TjVSrlUlFfcQoiH20fwv6lL/iTYgpM30=;
        b=K9nEkJERwBMlaiOVrL/d1ALwAOCgjMo4bP5zDUCzmoYBQkxhVPjEypKGo8IZGfD/v7
         RyS7aw30aFIrFPc6NCaJXIMkWhDjyIcQVLabXE2I87zNJ8GHiuw5kbLn6Rbh/pVrjXKN
         iTvpkDQYHHjijX5EaQHVMz7xHTNiWtHoVcl5lmXzuaNbK/UBmeETLaJG/NEsHww8iu4I
         ZY//mfpBQqtEukACt7fd03XEr7JLFjCiqZ9mmAdL/Y++MTco6rEoYJ4SJHMf/KTBucss
         IODFt1wqJX/WdK10vipYWWh9ERMRy3fVb1ZRLgobryLideJYujLcYdrWdeD8xQj4ajM0
         W55A==
X-Gm-Message-State: AOJu0YyRtNgm7G5gNfXnEb0UP9K+hpHszbNQBkTZOmYhSRQ2Al753F5l
	JVgc8iLV8UQxlV3V9P9ixrW+QjA272QcQt3j57osYcvc75k/UErn8+Wr
X-Gm-Gg: ATEYQzxWWWzCj6EjBWkzfKdnXfQrXpq+/HBWnhJQj11CDLGVJqfyiZSt6Jixu2cHxwz
	q3QDSoKkbulm2uZ+WI4rQ+7r05+f5M5tc7LjfYmGw8DICttdpaWFIeSfanbWTlpsB4HiX0eXdSO
	79zawS/WeZCnZ3EdLaFbmHoIFuJ6G30KQtgcLdqQZnP8c9OvSD9xJ46LkHEtaBeMxRPW96rYR6k
	sEpmSYujyUS011cgOwn+R8eX0zD3aKq9QezVYAEbplBn3+JtufxaDRNXQ0syg4UAlOqS695U6DT
	HAXUNVKiFR2dN8hZDyMjTMf5u0v6L1OMN5z0fEX5d5vXBM/2C+NP3W1o48/SkLl/3p06qIlSJFt
	zmXdkLjSlaoE1ixMbfTe/xi9UeMthyiva1HpJz+W9NOm4ys+WA1YM8epZg2YtQ43rBgVmB6zfQQ
	Rt6s3wCe6L6OjkURDm/3SgoRXKITSLgIJjuIXRP3leYYxsBmfbgc+LlCfNYNNNxhL4+w==
X-Received: by 2002:a05:6a21:685:b0:398:6ea8:21d8 with SMTP id adf61e73a8af0-398ec9b4a31mr11583444637.15.1773660592920;
        Mon, 16 Mar 2026 04:29:52 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.29.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:29:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 8/8] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
Date: Mon, 16 Mar 2026 19:28:43 +0800
Message-ID: <20260316112843.78657-9-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316112843.78657-1-pilgrimtao@gmail.com>
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
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

