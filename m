Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C23168EE
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634959; cv=none; b=ihGrGQug3Rt7TbgORpCaLvQQhOgILFK44Ta6UAdD1lbjP/s5pUXmRCmiahgRl4e6xAhZ/5vW9eGsPqRmyB19BHjxJLqInv1j9gTAqXFX5l4S5DEMif//KCaW3+OCLCzz+spm28cOfbNq/WibDUlm1pTN3wF3H6PcCnQpkAyQdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634959; c=relaxed/simple;
	bh=N4SSyL9EehPGbdPfqVp1P6qfUSFqFa1GZFzsACG9sAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmHjx30ppjnraArn2YhEgk9WGB4R/CeYjb1Wg5IjR2imwcJIVrKQEOxHjnt6P4g+imKUuDZFm56gsiaK51a3o6CV6T5PAhW0oGxWAxVniiobLJLMN0H2mN6GWpzpE0KBIYfCrBsN8bteDHOVVhXGkygKrlQ5ZZIIy4tclFVwb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4NvlTcJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4NvlTcJ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82735a41985so4126400b3a.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634957; x=1773239757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNOcpRqny/ZGYzfD6jguHPYGCE71ZgAVAdOs/NQGLEk=;
        b=m4NvlTcJT5/gDnbzYixF3kL7dAyoN/0rUom+ah7D/EdspqiK9XUzNSHMjdw1+DYNY0
         MjZf29u0qKbLinF88wVXLoB5Zil8joGo/LShS29RnlJUIzBIzc+3917w2DEiPkelEy9+
         yzq88jJHezhXpYJu6sCQURIAVCt4LCdcernZ+dxR8Pg56CQWNUtSmsmDRDs43axNuisn
         EzTyYpEvpITma2ReyBcmHTL1cmKA6BKUQsnj6B/2qFoXtVF2dH5qqJxNRGBfXjRVCRtY
         /qDzqL08tf8VGXMmtiVGZ7GtzJkbmIzAsZ7er/bAuJhs59gbJ05bmbLAEuh+MBoIUHNJ
         ceDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634957; x=1773239757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNOcpRqny/ZGYzfD6jguHPYGCE71ZgAVAdOs/NQGLEk=;
        b=NVulQ6+xuJuhzKs9tozEvzBCKesOlYPFgFA5CiiJoPv7ZM8HT6gRIkvJRsJfK3Ik0m
         hbHjk1cOJLGyY1Osc8eD0wHvj8uB17KBQeOiQSAcmj4ozW8qmN5OPCAh/XqQG1fG+sQa
         HlZLxSA5nscGyt5sbbLLkBRu/v6G8xN3Row2bUA8+oD51F5estkIp2V7ziTex0LubDIQ
         kMZPk9hdZgzp1HtuVaUzI4blZmcoIxkmDrn4IAgVC7CYY44p4jLOXnlvR83bjGDR8Au4
         SQiHFOMlJkAPH27pq0vvnGFvgDZN3AsWLBNPZomkF0CyUyWAiIYPmwoMdwq43Z/E+l5s
         qu3w==
X-Gm-Message-State: AOJu0YwbFfUsS5DJbbHtfhZRCeL5f8dxyVhQFZu53jNZWYWttjH/EaGC
	993mMJWvG/21vGoI81dm1sNvavIZnWDwOqvrCLHxOV7WyQCMK73q1dHj
X-Gm-Gg: ATEYQzxfkXzJ5m5SGH0r+t0Cs+NTaXXzfIs5CMJl5Wc1yVqK8QaBSIGaiQjLgLcuM0l
	j/2Sm61a9rdzU/DSLnhJY0XmawQNNJqK0tttPVlpGUbuKY+JhlLBloBHgIKxeJgU5XEZd1xUct4
	OsT1LtM7gkjEiDOofrZiNR6hOLiutGz5wGAReNfLCgY2geT4x5zuQ5fXrQnJL2En/q52uEtcIGZ
	XVZn3u5mQr9PAAHxGRaRKyqz+vKhmpOYnDe2caQSUDtQifRMp4wx99m8d9d92dcA6HR/QpHea/E
	b0jDUJv5fc17JlqBuBg//YAh5krEPqTl3+sS15YekPQeBrowFDyYWv0SibPSg2JXYHoq9tuDef4
	BzS5LeK/asFJ0tT3K23Aa7pDqudoxEVJmZhO+o+a82uBTlSlQiXSDOKZF8nC8Oy1NNWgFLw9gXJ
	wKZUcB/ttlsdbR7MJSYnZYM6NnBPCrycZhNMfYUQDkd9pU8LRNsLuRoQ==
X-Received: by 2002:a05:6a00:39a7:b0:823:12cb:f5d1 with SMTP id d2e1a72fcca58-8297292e77dmr1929411b3a.6.1772634957382;
        Wed, 04 Mar 2026 06:35:57 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm18470184b3a.15.2026.03.04.06.35.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 06:35:56 -0800 (PST)
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
Subject: [PATCH v6 4/5] selftests/bpf: Add test cases for bpf_list_del/add/is_edge/empty
Date: Wed,  4 Mar 2026 22:34:58 +0800
Message-ID: <20260304143459.78059-5-pilgrimtao@gmail.com>
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

Extend the refcounted_kptr test: add a node to both an rbtree and a
list, retrieve the node from the rbtree to obtain the node pointer,
then add a new node after the first in the list, and finally use
bpf_list_del to remove both nodes.

The test asserts that the list is non-empty after insert, asserts the
first and last nodes after bpf_list_add, and asserts that the list is
empty after removing both nodes.

To verify the validity of bpf_list_del/add, the test also expects the
verifier to reject calls to bpf_list_del/add made without holding the
spin_lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  39 ++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 182 ++++++++++++++++++
 2 files changed, 221 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..d5f42ed69166 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -99,6 +99,45 @@ extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ks
  */
 extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
 
+/* Description
+ *	Remove 'node' from the BPF linked list with head 'head'.
+ *	The node must be in the list. Caller receives ownership of the
+ *	removed node and must release it with bpf_obj_drop.
+ * Returns
+ *	Pointer to the removed bpf_list_node, or NULL if 'node' is NULL
+ *	or not in the list.
+ */
+extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+					  struct bpf_list_node *node) __ksym;
+
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
+/* Description
+ *	Return true if 'node' is the first (when 'is_first' is true) or the last
+ *	(when 'is_first' is false) node in the list with head 'head'.
+ */
+extern bool bpf_list_node_is_edge(struct bpf_list_head *head,
+				  struct bpf_list_node *node, bool is_first) __ksym;
+
+/* Description
+ *	Return true if the list with head 'head' has no entries.
+ */
+extern bool bpf_list_empty(struct bpf_list_head *head) __ksym;
+
 /* Description
  *	Remove 'node' from rbtree with root 'root'
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 1aca85d86aeb..aca201f9fb56 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,6 +367,188 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
+/* Insert one node in tree and list, remove it from tree, add a second node
+ * after it with bpf_list_add, check bpf_list_node_is_edge/empty, then
+ * remove both nodes from list via bpf_list_del.
+ */
+SEC("tc")
+__description("list_add_del_and_check: test bpf_list_add/del/is_first/is_last/empty")
+__success __retval(0)
+long list_add_del_and_check(void *ctx)
+{
+	long err = 0;
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l, *l_1;
+	struct node_data *n, *n_1, *m_1;
+
+	err = __insert_in_tree_and_list(&head, &root, &lock);
+	if (err)
+		return err;
+
+	bpf_spin_lock(&lock);
+	if (bpf_list_empty(&head)) {
+		bpf_spin_unlock(&lock);
+		return -7;
+	}
+
+	rb = bpf_rbtree_first(&root);
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -4;
+	}
+
+	rb = bpf_rbtree_remove(&root, rb);
+	bpf_spin_unlock(&lock);
+	if (!rb)
+		return -5;
+
+	n = container_of(rb, struct node_data, r);
+	n_1 = bpf_obj_new(typeof(*n_1));
+	if (!n_1) {
+		bpf_obj_drop(n);
+		return -1;
+	}
+	m_1 = bpf_refcount_acquire(n_1);
+	if (!m_1) {
+		bpf_obj_drop(n);
+		bpf_obj_drop(n_1);
+		return -1;
+	}
+
+	bpf_spin_lock(&lock);
+	if (bpf_list_add(&head, &n_1->l, &n->l)) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(n);
+		bpf_obj_drop(m_1);
+		return -8;
+	}
+
+	if (!bpf_list_node_is_edge(&head, &n->l, true) ||
+	    !bpf_list_node_is_edge(&head, &m_1->l, false)) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(n);
+		bpf_obj_drop(m_1);
+		return -9;
+	}
+
+	l = bpf_list_del(&head, &n->l);
+	l_1 = bpf_list_del(&head, &m_1->l);
+	bpf_spin_unlock(&lock);
+	bpf_obj_drop(n);
+	bpf_obj_drop(m_1);
+
+	if (l)
+		bpf_obj_drop(container_of(l, struct node_data, l));
+	else
+		err = -6;
+
+	if (l_1)
+		bpf_obj_drop(container_of(l_1, struct node_data, l));
+	else
+		err = -6;
+
+	bpf_spin_lock(&lock);
+	if (!bpf_list_empty(&head))
+		err = -7;
+	bpf_spin_unlock(&lock);
+	return err;
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
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -4;
+	}
+
+	rb = bpf_rbtree_remove(&root, rb);
+	bpf_spin_unlock(&lock);
+	if (!rb)
+		return -5;
+
+	n = container_of(rb, struct node_data, r);
+	l = bpf_list_del(&head, &n->l);
+	bpf_obj_drop(n);
+	if (!l)
+		return -6;
+
+	bpf_obj_drop(container_of(l, struct node_data, l));
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
+long list_add_without_lock_fail(void *ctx)
+{
+	long err = 0;
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l, *l_1;
+	struct node_data *n, *n_1, *m_1;
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
+	bpf_spin_unlock(&lock);
+	if (!rb)
+		return -5;
+
+	n = container_of(rb, struct node_data, r);
+	n_1 = bpf_obj_new(typeof(*n_1));
+	if (!n_1) {
+		bpf_obj_drop(n);
+		return -1;
+	}
+	m_1 = bpf_refcount_acquire(n_1);
+	if (!m_1) {
+		bpf_obj_drop(n);
+		bpf_obj_drop(n_1);
+		return -1;
+	}
+
+	/* Intentionally no lock: verifier should reject bpf_list_add without lock */
+	if (bpf_list_add(&head, &n_1->l, &n->l)) {
+		bpf_obj_drop(n);
+		bpf_obj_drop(m_1);
+		return -8;
+	}
+
+	bpf_spin_lock(&lock);
+	l = bpf_list_del(&head, &n->l);
+	l_1 = bpf_list_del(&head, &m_1->l);
+	bpf_spin_unlock(&lock);
+	bpf_obj_drop(n);
+	bpf_obj_drop(m_1);
+
+	if (l)
+		bpf_obj_drop(container_of(l, struct node_data, l));
+	else
+		err = -6;
+
+	if (l_1)
+		bpf_obj_drop(container_of(l_1, struct node_data, l));
+	else
+		err = -6;
+
+	return err;
+}
+
 SEC("tc")
 __success
 long rbtree_refcounted_node_ref_escapes(void *ctx)
-- 
2.50.1 (Apple Git-155)

