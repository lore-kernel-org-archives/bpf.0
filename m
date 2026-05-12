Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC440B6F0
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565634; cv=none; b=TDqhhGniZtbzKC3xJiT0cOE8P2gl1BmwqZt98DcXputP24KdnjitwGV8w2ctW72tR4Q6A1V+eS8+hEFZQzCzm1GbiNquZXOWmDeIsLROsxbX4RctorqnOoBdYkVRoXxDaaP1/3AOSfu5W2plKEUXd6Ciu1pDeCGZD8VrIAV3QYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565634; c=relaxed/simple;
	bh=kRF9RHp407Fxt7W9NCJuN2XXVOJ+iJ65bCFZX7kuqVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU7KJACIbF4CyjvBUXDJR6PRK+QmH7hntKOk3/eaJxQnnJB86CcIRT+gbjKfNCs7dm8LuOhoYNZaZX7YX3ZcXYM8rdWr8s0jV04uQ1A8IRFieslAYBix8S3DQzm1Y6O1AQlS3PrUGYl8lfTPboR7YryAwlEraeDxX9ESmVjD8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e69zZ4NY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e69zZ4NY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778565615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkHpM1vn80llxrmN+R6WT0i6FCnOAAEKA+jHxtvWc3A=;
	b=e69zZ4NYpLqH1ixrjBCxt8xdNV3c8uTl91/qk5fjjo+D2jJ4gUpRgJJY1But4SRJmzLy1P
	bSrvUG5275oZU4ddcoe/Gii/nxI2KEzvTYTT5EcTEXaVEtWET8IUruoLixpZopTLx8AHd+
	52RgL1m5AsLWoF0Nv1qLIA4Ae9w1op4=
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
Subject: [PATCH RESEND bpf-next v10 8/8] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
Date: Tue, 12 May 2026 13:59:19 +0800
Message-ID: <20260512055919.95716-9-kaitao.cheng@linux.dev>
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

Extend refcounted_kptr with tests for bpf_list_add (including prev from
bpf_list_front and bpf_refcount_acquire), bpf_list_del (including node
from bpf_list_front, bpf_rbtree_remove and bpf_refcount_acquire),
bpf_list_empty, bpf_list_is_first/last, and push_back on uninit head.

To verify the validity of bpf_list_del/add, the test also expects the
verifier to reject calls to bpf_list_del/add made without holding the
spin_lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../selftests/bpf/progs/refcounted_kptr.c     | 421 ++++++++++++++++++
 1 file changed, 421 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index c847398837cc..21ae06797b18 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,6 +367,427 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
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
+__description("list_is_edge_test1: is_first on first node, is_last on last node")
+__success __retval(0)
+int list_is_edge_test1(void *ctx)
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
+__description("list_is_edge_test2: accept list_front/list_back return value")
+__success __retval(0)
+int list_is_edge_test2(void *ctx)
+{
+	struct bpf_list_node *front, *back;
+	struct node_data *a, *b;
+	long err = 0;
+
+	a = __add_in_list(&head, &lock);
+	if (!a)
+		return -1;
+
+	b = __add_in_list(&head, &lock);
+	if (!b) {
+		bpf_obj_drop(a);
+		return -2;
+	}
+
+	bpf_spin_lock(&lock);
+	front = bpf_list_front(&head);
+	back = bpf_list_back(&head);
+	if (!front || !back) {
+		err = -3;
+		goto out_unlock;
+	}
+
+	if (!bpf_list_is_first(&head, front) || bpf_list_is_last(&head, front)) {
+		err = -4;
+		goto out_unlock;
+	}
+
+	if (!bpf_list_is_last(&head, back) || bpf_list_is_first(&head, back)) {
+		err = -5;
+		goto out_unlock;
+	}
+
+out_unlock:
+	bpf_spin_unlock(&lock);
+	bpf_obj_drop(a);
+	bpf_obj_drop(b);
+	return err;
+}
+
+SEC("tc")
+__description("list_is_edge_test3: single node is both first and last")
+__success __retval(0)
+int list_is_edge_test3(void *ctx)
+{
+	struct node_data *tmp;
+	struct bpf_list_node *node;
+	long err = 0;
+
+	tmp = __add_in_list(&head, &lock);
+	if (!tmp)
+		return -1;
+
+	bpf_spin_lock(&lock);
+	node = bpf_list_front(&head);
+	if (!node) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(tmp);
+		return -2;
+	}
+
+	if (!bpf_list_is_first(&head, node) || !bpf_list_is_last(&head, node))
+		err = -3;
+	bpf_spin_unlock(&lock);
+
+	bpf_obj_drop(tmp);
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
+__description("list_del_test3: list_del accepts list_front return value as node")
+__success __retval(0)
+int list_del_test3(void *ctx)
+{
+	struct node_data *tmp;
+	struct bpf_list_node *bpf_node, *l;
+	long err = 0;
+
+	tmp = __add_in_list(&head, &lock);
+	if (!tmp)
+		return -1;
+
+	bpf_spin_lock(&lock);
+	bpf_node = bpf_list_front(&head);
+	if (!bpf_node) {
+		bpf_spin_unlock(&lock);
+		err = -2;
+		goto fail;
+	}
+
+	l = bpf_list_del(&head, bpf_node);
+	bpf_spin_unlock(&lock);
+	if (!l) {
+		err = -3;
+		goto fail;
+	}
+
+	bpf_obj_drop(container_of(l, struct node_data, l));
+	bpf_obj_drop(tmp);
+	return 0;
+
+fail:
+	bpf_obj_drop(tmp);
+	return err;
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
+	return err;
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
+	struct node_data *n;
+	struct bpf_list_node *l;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return -1;
+
+	/* Error case: delete list node without holding lock */
+	l = bpf_list_del(&head, &n->l);
+	bpf_obj_drop(n);
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
+	struct node_data *n, *prev;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return -1;
+
+	prev = bpf_obj_new(typeof(*prev));
+	if (!prev) {
+		bpf_obj_drop(n);
+		return -1;
+	}
+
+	/* Error case: add list node without holding lock */
+	if (bpf_list_add(&head, &n->l, &prev->l)) {
+		bpf_obj_drop(prev);
+		bpf_obj_drop(n);
+		return -2;
+	}
+
+	return 0;
+}
+
 SEC("tc")
 __success
 long rbtree_refcounted_node_ref_escapes(void *ctx)
-- 
2.50.1 (Apple Git-155)

