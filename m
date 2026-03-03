Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAB3624A5
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545998; cv=none; b=gRAS3y89ZKrnx4DGQ4Tkq6DmJmYbdRp1JIlJIOacMHNgEpPMCU5t998gUrVUHGZrRdMC+lUnAUZcr7FJno+vw3aXqcel629UAHW7ZiwyY4f9pkXVYCrfu5j+huW7qwO9XZoxYB0YbUJS6gN9CDJe2kVkK2xxVS+qgLhZ8e7ywhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545998; c=relaxed/simple;
	bh=X6liwf3Zz68Ln2eYf3LldcWUzkSatYgDKtSRFKTQiUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BseXzztmSE4qWch6pNAIw4jA34rkzAFn8i+GRRJegVxEyx8a3W1MPCt+rQ4FV2CoXcVCTj3gTBjuKfiJSQdVjTzk9So2qJ3QVecVM83MNCz7+Pi0ziqHnNv4F1KVb5whTZmiV37msLpaTkKJMbcbHIXImAdRsunQJeNv4dALvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hyz6tqNd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hyz6tqNd"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824b32875e7so2706356b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 05:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772545996; x=1773150796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiJ82F1hpB+Nf2rgWWs29vO4kgncQvhmjK3cNBDk7WA=;
        b=Hyz6tqNdArngbSFXNqIRjTFHNViIPpYFFV+IaILWLba94l6qRq0zMaJa3SSIyPBV07
         +AwFXgDxm2e0whmYf4m6hNL+OX3ZZIhLtg/a0dkRYC4soxe63uK9H+f5XNKwkxaJi0Ac
         X77rt2Ugyb7jUwI488foYoWxQCS6zh4MMjwLcBd1JeICD9RxYPE0boZPyTqB7sNYqjyg
         7oMjgTmg7QJLdGLA4ttiXEQEaX3qQnL3aNTBB9qRhKfCV8YaNHdoHZJs54/nQLaQOzCH
         WohOk1XS6jVSlY5oQV2jWFGe1SIzkNo3GM8lm3UHs9jt3kHTAkAmYqgtg/wPUL1i7KGX
         69pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545996; x=1773150796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiJ82F1hpB+Nf2rgWWs29vO4kgncQvhmjK3cNBDk7WA=;
        b=Tg656kEPqbisbm6bC3paLHOMm9SlwD2TxmcgQuuoC2hH/ckyY8mFCQJ50DP1TY/UsS
         aR9qB2X4q6mabUBdAEC5Z9K1FE9Xf0JA78QNGZPmS75RjnYr6FqVMyYBlMvuFU5QfwRH
         ij7OZE8PIhIysFZEve/qoNSyNY0MrT1S0qWZUwtHYjSdh4nlFFV4DQnHlW8JpXj39ti7
         sLrBKLOFV/bGZD9KFTfoKc1KvwWVfSBXH/SWYHX6EUUeRb8cWgURMyGmHWoniag41x5i
         Lq/Vrc5R04WEBiiG/R/xB7Te2nEKqZYg7N/Kucp48rlbwUh9l71khNfa/1iU9Pvsiavb
         lhog==
X-Gm-Message-State: AOJu0Yz059foc3WiD5ysrx1zSunQmeGkjRFBl3d1O9jz0onM5k7yzPCQ
	/ZizxUry+n20wras8pFoFVoiDe2tCjMr7aAJnyPurJ6uCHOjY3QuiIRe
X-Gm-Gg: ATEYQzxPSDKmeveD3obwXsjZHvevJWHCvGfFRe48C2yipZYvDv30wtGB1FOwjagbFCX
	5qBZOhlvSRXRT/noClOtSpVIIiZm7txPQ4ys/a7EEo7evUwbFpZ21wdW2GpT4IJOv3aIRNtEGWl
	iANnDQ+8sBptZIt/orhit4nNTz4MfuCmAxMCxWCOV3VmlKzm8UOXEG5tZwvFsJSkpTIqQkN3R/U
	XHueewecZv1Qhj0XeVtli32V5kF/AwyQ9i6DR5xxAIK45g15FALnEHM8Xj4zOajvYDLcvKEIhux
	YpdwGsyzB6f2mmMhq4MssXlmwcueukmufeKchNo2gfGsifRn0ywbuJvd53u75HHxNMTnvIPacNY
	e+znr17dQS7Gt0cLY1RDSJ2MdJUSmcXFlMZaoJ6v0qdK2kJKJXEr9YcM7bNwbQlODYVwm/bTUlN
	xhUX5xNt1sJq4/tJERJZJXyZ3E2dKVfH4hTA1RSsT5wamciVBS
X-Received: by 2002:a05:6a21:6e8a:b0:394:5878:e1fa with SMTP id adf61e73a8af0-395c3a1aa3dmr15295153637.6.1772545996456;
        Tue, 03 Mar 2026 05:53:16 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm14689782a12.12.2026.03.03.05.53.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 05:53:16 -0800 (PST)
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
Subject: [PATCH v4 4/6] selftests/bpf: Add test case for bpf_list_add_impl
Date: Tue,  3 Mar 2026 21:52:17 +0800
Message-ID: <20260303135219.33726-5-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303135219.33726-1-pilgrimtao@gmail.com>
References: <20260303135219.33726-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Extend refcounted_kptr test to exercise bpf_list_add:
add a second node after the first, then bpf_list_del both nodes.

To verify the validity of bpf_list_add, also expect the verifier
to reject calls to bpf_list_add made without holding the spin_lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  16 +++
 .../selftests/bpf/progs/refcounted_kptr.c     | 122 ++++++++++++++++--
 2 files changed, 124 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 54ec9d307fdc..fdcc7a054095 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -110,6 +110,22 @@ extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksy
 extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
 					  struct bpf_list_node *node) __ksym;
 
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
  *	Remove 'node' from rbtree with root 'root'
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index ac7672cfefb8..5a83274e1d26 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,18 +367,19 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
-/* Insert node_data into both rbtree and list, remove from tree, then remove
- * from list via bpf_list_del using the node obtained from the tree.
+/* Insert one node in tree and list, remove it from tree, add a second
+ * node after it in list with bpf_list_add, then remove both nodes from
+ * list via bpf_list_del.
  */
 SEC("tc")
-__description("test_bpf_list_del: remove an arbitrary node from the list")
+__description("test_list_add_del: test bpf_list_add/del")
 __success __retval(0)
-long test_bpf_list_del(void *ctx)
+long test_list_add_del(void *ctx)
 {
-	long err;
+	long err = 0;
 	struct bpf_rb_node *rb;
-	struct bpf_list_node *l;
-	struct node_data *n;
+	struct bpf_list_node *l, *l_1;
+	struct node_data *n, *n_1, *m_1;
 
 	err = __insert_in_tree_and_list(&head, &root, &lock);
 	if (err)
@@ -392,20 +393,48 @@ long test_bpf_list_del(void *ctx)
 	}
 
 	rb = bpf_rbtree_remove(&root, rb);
-	if (!rb) {
-		bpf_spin_unlock(&lock);
+	bpf_spin_unlock(&lock);
+	if (!rb)
 		return -5;
-	}
 
 	n = container_of(rb, struct node_data, r);
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
 	l = bpf_list_del(&head, &n->l);
+	l_1 = bpf_list_del(&head, &m_1->l);
 	bpf_spin_unlock(&lock);
 	bpf_obj_drop(n);
-	if (!l)
-		return -6;
+	bpf_obj_drop(m_1);
 
-	bpf_obj_drop(container_of(l, struct node_data, l));
-	return 0;
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
 }
 
 SEC("?tc")
@@ -438,6 +467,71 @@ long list_del_without_lock_fail(void *ctx)
 	return 0;
 }
 
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

