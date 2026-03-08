Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F63368B2
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977662; cv=none; b=rDmvrF7JLvkwevWnfRdEjbkdcU33e8WFStFaAQef3YQTE72/Y1lDcfHkFiVuDDlxrrBZKRZwcJDt0PJoQwYH15+thy0pieJWjN3oADKirAnqmXbO15uPxbafCEHxbmRvOJKxpRe0+0CIlVX3AZ84875vA8BKRIEKmounR/zLD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977662; c=relaxed/simple;
	bh=1fVjL/BWbWrnK0xa23u3xDjOZ/zHvb6gwBS6fUH3NPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyK1/58m66jYOEirs0s+BU2YgLT7PDk/j7WiSRpq301h+r5J7ewgFa1B7YXd4UBJoc4O0vzb9Wb04z3MC2baeE+gq1e0XU56SpCK64aHvAwYZbYmu5+05U1T+eFFSMB4UhnY9HgVvEnfV/9rXek9Y4Hywx8Z6WnCKGkmlMSGhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRNkOgmx; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRNkOgmx"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so4715718a12.3
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772977660; x=1773582460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XrESepKNhObGU0gsyPBOvwXryFumcINMmhOSkp1V30=;
        b=cRNkOgmxbvhTcfHxC7op0J5RqHPKFcgpXHyFlDY/MdfNl9YATozj81SGpV0dvG4t2Q
         Z3v0+nsJxjmNcgBJcW58xRS8oomnBTVuUXmy0Zcco1Zf8MyhqNLk+SwO81iwpFOgtfu0
         t3fh8v20WcHKEL30avHjeHS9w8u/rzFPlQ9I6jf48HAYciFSBcT7C/99+7+SKLMqbzQm
         CsCmszDooyECRukZ/noPw0adp+hXrDv6wCqgRVorXmmJmUXyGDnv/rgLvIvB1eecTEa/
         NNBdU1+yI9u40mJU9pdwJrktIr2sO39g2HMGc9HXw2bQ5z65a3my9ErX3M2i5q1hXtJw
         mOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977660; x=1773582460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XrESepKNhObGU0gsyPBOvwXryFumcINMmhOSkp1V30=;
        b=dtkoBVBPJWm8ucJgqRfkBOIwHQlddyaIAtsan9HEOx58pfvQ+EYFB2cImQH1Ug0yE8
         /84byFQt0ikurmTszUt9PbngsWGdFO8T8GktCXl71cSp1mtKy5hqIViufD+E3xNz3UCt
         3zl70Oynn2b0Y+EqG5HmPMJKd+j1uvCV+/HhHLJpDFDjRNjrdXUT0WWRUIavjRBnDoXe
         T93xj1NqF13YcSrrt0m+Uy5oYmjlvOofBONqaPirRjElWcKl+fglh6gBWgmNULx6m1W+
         TdVu1KuVCPpPBqqkPQ/TD+8wYuHX+Z42dAwqe/OP93DVi53qHo/Lm6J8M+WyNRS7o/XI
         0QMQ==
X-Gm-Message-State: AOJu0YydH0NK6tyeOvnDo3pjMmZUguMSwqJg90Ypna44l8q6Js3WINx8
	eH9HwLzF77Ew20V2CVja9sBfABGEl3N3yYO3l1aO2/CkjSxbyepXSy6v
X-Gm-Gg: ATEYQzwerrwkIWFZ8IEgD5t9iqcRsmRMwlqj3G2IpPh2llHsUNBDGGNLNWbtpG3KLrx
	eIE/aMGcGS6rqBq6V1NC/f5DlAJwdgjJL/ydR/w7NhOkC1mv9iV4tyEpClDLvwsxN45QigKV0q3
	L+2SHak4er82GdIzOjy0bKcKj7GQDL2sYseO94iWXzeDQahErWAf/cMtoZ2o9UCFsGl0rLsKddL
	gOBaxKI+LeIPF7Zam+h6/o97NKMudSqJ8NGAjn/xlruiiCbeZKkPpx4eqRBhoFMuZk47RopiEYo
	GAq8ZQTceVfpp0/J5WVW9t+UEEvNIK179Nrh8ypBO5zd3/mhsXhjQso6VDtylXwLFHt4P/VZUr1
	TZCsRBvZsHhAfOWbzi6ZaRb0qseUThZXCOiDq+fbx5TiEO/oxnd43ATpJG3ya4aZapBudxQ5a0/
	e6m7UgIhfDM3EEGOP+rI1JuwIcWMgrw9nM5T2C3LsCKLXwoZeN
X-Received: by 2002:a05:6a20:7350:b0:394:58eb:48fa with SMTP id adf61e73a8af0-39858fb419bmr8732290637.6.1772977660602;
        Sun, 08 Mar 2026 06:47:40 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636968sm7095056b3a.9.2026.03.08.06.47.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Mar 2026 06:47:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 4/5] selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
Date: Sun,  8 Mar 2026 21:46:13 +0800
Message-ID: <20260308134614.29711-5-pilgrimtao@gmail.com>
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
 .../testing/selftests/bpf/bpf_experimental.h  |  16 ++
 .../selftests/bpf/progs/refcounted_kptr.c     | 140 ++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..005ca9d84677 100644
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
index 1aca85d86aeb..c2defa991acd 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,6 +367,146 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
+/*
+ * Insert one node in tree and list, remove it from tree, add a second node
+ * after it with bpf_list_add, check bpf_list_is_first/is_last/empty, then
+ * remove both nodes from list via bpf_list_del.
+ */
+SEC("tc")
+__description("list_add_del_and_check: test bpf_list_add/del/is_first/is_last/empty")
+__success __retval(0)
+long list_add_del_and_check(void *ctx)
+{
+	long err = 0;
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l_node, *l_node_ref;
+	struct node_data *n_rb, *n_new, *n_new_ref;
+
+	err = __insert_in_tree_and_list(&head, &root, &lock);
+	if (err)
+		return err;
+
+	bpf_spin_lock(&lock);
+	/* Test1: bpf_list_empty */
+	if (bpf_list_empty(&head)) {
+		bpf_spin_unlock(&lock);
+		return -4;
+	}
+
+	rb = bpf_rbtree_first(&root);
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -5;
+	}
+
+	rb = bpf_rbtree_remove(&root, rb);
+	bpf_spin_unlock(&lock);
+	if (!rb)
+		return -6;
+
+	n_rb = container_of(rb, struct node_data, r);
+	n_new = bpf_obj_new(typeof(*n_new));
+	if (!n_new) {
+		bpf_obj_drop(n_rb);
+		return -7;
+	}
+	n_new_ref = bpf_refcount_acquire(n_new);
+	if (!n_new_ref) {
+		bpf_obj_drop(n_rb);
+		bpf_obj_drop(n_new);
+		return -8;
+	}
+
+	bpf_spin_lock(&lock);
+	/* Test2: bpf_list_add */
+	if (bpf_list_add(&head, &n_new->l, &n_rb->l)) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(n_rb);
+		bpf_obj_drop(n_new_ref);
+		return -9;
+	}
+
+	/* Test3: bpf_list_is_first/is_last */
+	if (!bpf_list_is_first(&head, &n_rb->l) ||
+	    !bpf_list_is_last(&head, &n_new_ref->l)) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(n_rb);
+		bpf_obj_drop(n_new_ref);
+		return -10;
+	}
+
+	/* Test4: bpf_list_del */
+	l_node = bpf_list_del(&head, &n_rb->l);
+	l_node_ref = bpf_list_del(&head, &n_new_ref->l);
+	bpf_spin_unlock(&lock);
+	bpf_obj_drop(n_rb);
+	bpf_obj_drop(n_new_ref);
+
+	if (l_node)
+		bpf_obj_drop(container_of(l_node, struct node_data, l));
+	else
+		err = -11;
+
+	if (l_node_ref)
+		bpf_obj_drop(container_of(l_node_ref, struct node_data, l));
+	else
+		err = -12;
+
+	bpf_spin_lock(&lock);
+	/* Test5: bpf_list_empty */
+	if (!bpf_list_empty(&head))
+		err = -13;
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

