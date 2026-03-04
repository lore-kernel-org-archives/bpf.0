Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47523EA80
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594212; cv=none; b=W6Yra4X2KtFhCXBFmGCaJWTtVYDBnimVzra+xFlP6eWtlQut9CM0sSHbvViP7TC53PLwqERL0imrv3VNdkCM5j0KL5DG4LeZ/VnWLUE9awsiaP10tu1fuGdIhXDfszFmtlG3E1gnU3zl5wjmnLuTiRs14o/LJpD3EEP7WI/m0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594212; c=relaxed/simple;
	bh=X6liwf3Zz68Ln2eYf3LldcWUzkSatYgDKtSRFKTQiUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx9tptyLtWta4BgBwhcFXzWgMKKGUzLpA6eKwcQnsp3J38o67STUIz+jsm5Oi92tqylSFl/i43pO/Ryp/E6qziel7WTGaceVttNSUwlHX51HxuLK2Y09SEQUO3LolIdWakH3hapPaz2pEUMwDmaTteAlpbi80XHk6HNfIonYNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRX8YT+O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRX8YT+O"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-359863611faso1302906a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594211; x=1773199011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiJ82F1hpB+Nf2rgWWs29vO4kgncQvhmjK3cNBDk7WA=;
        b=aRX8YT+OqMenQCNI36fe3gR4B8AEmUh8IAGpJe550dvQYSeefqtemZ/h6z4VzjrHDx
         LJKB4qPOBtsX+AAEnbDwvzIi2zD6XjFh0Khj1nsk32/wXgt48N6t0udjqK37ZGGanrs4
         3kvUUVlJ/d2CLC8vmJ1njUGLYzOWVxnJn/wO7umEG0i4xVMYRgup5hz/Fzj9Yp8h/P6q
         ZHfEIIc+fYwUKVKVTHT0PcNSV/oLNn1zjA9HLK1a62nEfC7iPaY8qPwB8bDOM1TqoqAb
         4gVuSw7kNDcBtLE8UHtKXUEH1lJkqrpiUyyEy77pMh1LYkHxcnvr2w8D13XcTknQb0J9
         l7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594211; x=1773199011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiJ82F1hpB+Nf2rgWWs29vO4kgncQvhmjK3cNBDk7WA=;
        b=M7NFWJWNmzPcsFvY3hoCtzF+ep7bmbQoRu52ivayrPyV8ffnE+ieehPB0FLFUrlAiT
         mj/Dplutkr0P/qSyViCsMwI/txj57sAbPt3Ia0IOg8aMEhqk0VGFCf9j45fOKbVIA5+I
         gwxCgW2eYdTYNrfFtUpVoYsunAUbJA8KWIh3tFSz9hh7ltcCgi5E0APVwHW0R8/b0v2g
         UfS+og3BG0iUCVNrZ+oEvc0/IREK9vAe2j2UfdH/p7vTsn4WfkBFwcHlTTrTupQt3jLn
         82vdWYMvu8BuzrtyfObqppDVOptQ56n5muaaoQfrcVXzoavKBFgyVEeiEzVR6KZto1f1
         M88A==
X-Gm-Message-State: AOJu0Yx3j05EvEH9H5B8is2uFLAT/PU3PRkTnhUwydiUzs1eYdZsHkSm
	6BaSr8+HnXg6LjULvhi2YTBObx9ZwoqY4GLr9nid2WOxlrkqcffg1U7X
X-Gm-Gg: ATEYQzxjKfC/YnvvQRn8dJ9orddSdAeclNgm4VgIJGhOxi3r+rkLotMMCd9z+WDI2zp
	Ackpqjx016kAOGmXXQ84THKtoAnad3G0DIKVtVUrh2sbYpU38LPwWEm+6R4JpIW5S8fEy0A2BAG
	dYvZr1OlmtvvVPCsiBYWD2E2jmBSg+9jmaG6eWS8PJZaMvK4o2tzQbGC0WEnS7D2FRai2Ox0WQi
	A3hwFeKJphAYeT8affkqfqes5x/nURylb7njEvhX3RfZ2ZXuYrLMdGcINsydMhfXEAUd+gfjGbC
	OxLamf8SVv0E8lpwJu5GWfEyYL4c+InT9qxFUKdPtnTowoSy5joFCjTAgDg/BZNELMvEK0w7sfI
	fi0XqMNMFwFL9EjkRrjQJ0ez9hFOIjyxYdY6cqtPAxa4DnSzQU3g9G377ZZCKNvXdkhWcOBfGrI
	wEJLESX5i0e+lemoe7OTxjvAnxrmJFTZdFg0tlHrWod+EivKn4t1ZC5L505duV
X-Received: by 2002:a17:90b:1fc5:b0:359:8c9a:fdf6 with SMTP id 98e67ed59e1d1-359a69ae8d6mr608246a91.6.1772594210922;
        Tue, 03 Mar 2026 19:16:50 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3ab946sm3610648a91.13.2026.03.03.19.16.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 19:16:50 -0800 (PST)
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
Subject: [PATCH v5 4/6] selftests/bpf: Add test case for bpf_list_add_impl
Date: Wed,  4 Mar 2026 11:16:04 +0800
Message-ID: <20260304031606.43884-5-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304031606.43884-1-pilgrimtao@gmail.com>
References: <20260304031606.43884-1-pilgrimtao@gmail.com>
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

