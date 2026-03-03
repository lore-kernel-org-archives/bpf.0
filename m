Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786E35F191
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545977; cv=none; b=f3n65/8mx9s27VD2BU/NU+HrSyoulKDueS7kThVZ+e+mZVKuNMzjRuLRmRnx35CBDiiiRycZbFBBINl+FeG/ss1VuSqpkoLaIjXjxTIcgK8+hHwvBUa+NKkZKd0xq6XGnVdhwHjx/+YztTa1I5AYwBuZDsga1PsRqSYZO923UFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545977; c=relaxed/simple;
	bh=5k3B4Ygo1wjsDMA1EPhJXyhhcMiqhAMzgiy+JUuepVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI5dfQnC7SGO16/FU+UmtM+OvivXiimV62X9PmVGEXBuHyrkr08pXXyzKhJ+VWUWZHBdgk7P+CnTDMHdaPSugDifTOUCpNVlnC2687ZsVQfD/vssJ97x0qNGpFBUhwKxpNS13u4EJG5iGOPsDBlC2rOQ4DxsMc19OeS2DDNsvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1Sb70Tj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Sb70Tj"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824a6f2d816so2513091b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772545976; x=1773150776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yrYqqdL3L32jfs4+IGyGROm0lZBENJH7/3+fmtOXxw=;
        b=F1Sb70Tj345lwTMqmngIa4+emLD7oKmaf7Flttjq3fF5f8VJVrpw0U+7A3KQ5OCqBQ
         MC4+1/gzWhQgRyHdjXh+xPNl91JYQwDe3a/ye7fSVwaJfYz3B6kdnQrYvd624SRmMWty
         LkDuuSh6TpxUeDl6KNW1FSTmi8SW61tKjoQlpwHdpjFy8xIdJEEZ1egUuRKPO0QcwbQf
         0ND+paymfA495tldA6iPlcBGrAcbo7Loe8lMweqcWU0+sTEgAH1ZofsAd4e9Sey/Glds
         DbqIZYX/T6ycuL/jnx1NfpUILdGmWCY7+WHs/7fOmNv1EYUdKYYOdZjsyYl6kwNXC1wj
         7+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545976; x=1773150776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yrYqqdL3L32jfs4+IGyGROm0lZBENJH7/3+fmtOXxw=;
        b=lzXoTb/oxlrmF/A2NBe+OkSqNcbSWv83jNYUTT2NtSPGF+RKhKZePfqVeAjuwjpScR
         vbwvkPGIpm15xqwvYS42+fhhpABgQo4nYM+5xG98bthA43AvwvfcaLu+Wb0grkrcKf9w
         B2AXZuf3O6Q40pVcm2k8yqoTAgPr2Ms9aKqHbO2iyb2FLHXsI+ALqmldZPVgdin3Y5dN
         4vuGkxcy38zW9IwQ+oXYHpuwYgmmd7dVTKMJ2G7mpYw3nOsN2Dc8y4Xts+7adgZefYtG
         wryHb50exGsG92z3B05/qgKhQ7pkyL12il6uMpSvGNNxRwvFTP8nhEq8WVRjdrstiUx1
         I9gQ==
X-Gm-Message-State: AOJu0YzHK4WbtzyEhd9hyULnZnzlR05LGzwup/ob3yoQbkv9QSH8LxEf
	0mrWemMCCaUDiJOyvvdAQTJQ+UPQhayWVU/CkRynqflzTbpBiVcWFNVQ
X-Gm-Gg: ATEYQzw7iQ+gzXdCr/QbS7OfUStdF7gtphOnKmfuYC2N19i8Zyj9GL5a4wMO4UaBz82
	+DilhTGrvtaqatwWLGGPDe9LfgHU03jelgJ6lNE+3WeJa6vOunQK+ATCd/jzgXw8jiZXLKItwqR
	CI/mWSgD7mbzuGHZT3CqyPxGdB9WV1c9Hb0UjuncjgRals7e1S/itkfqaGP3BEjNLSS5qrn+j0O
	MENtF6toEGEM6jHRcZP+t7R+6GdOckrOVVDywDTje/IcrbJVPBcdkp9UHebBX4o4pXNEf/6KTfZ
	ar3e+nj+NB8NGGmrfTKtdcGJ8KeJforOlNI+LVZ/5zGJcevVeGRj5ODyc0Q0owo1fCNZujV8AWP
	9MeWivaqoy5vRQFRHebU7fBiTxmYAn8Xwo8iABnlllaGHaw9ASMrsp5AUh4A4utonBSK7LQETnO
	yKyiK+gGCRT5N8lehUQGEnVSvQ/8RuVQQsjvQV9Vvz79jWqok2
X-Received: by 2002:a05:6a21:a341:b0:366:1f1f:3299 with SMTP id adf61e73a8af0-395c39f7a2emr14911659637.6.1772545975553;
        Tue, 03 Mar 2026 05:52:55 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm14689782a12.12.2026.03.03.05.52.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 05:52:55 -0800 (PST)
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
Subject: [PATCH v4 2/6] selftests/bpf: Add test cases for bpf_list_del
Date: Tue,  3 Mar 2026 21:52:15 +0800
Message-ID: <20260303135219.33726-3-pilgrimtao@gmail.com>
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

Add a node to both an rbtree and a list, retrieve the node from
the rbtree, use the obtained node pointer to remove it from the
list, and finally free the node.

To verify the validity of bpf_list_del, also expect the verifier
to reject calls to bpf_list_del made without holding the spin_lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 11 +++
 .../selftests/bpf/progs/refcounted_kptr.c     | 71 +++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..54ec9d307fdc 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -99,6 +99,17 @@ extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ks
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
 /* Description
  *	Remove 'node' from rbtree with root 'root'
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 1aca85d86aeb..ac7672cfefb8 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,6 +367,77 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
+/* Insert node_data into both rbtree and list, remove from tree, then remove
+ * from list via bpf_list_del using the node obtained from the tree.
+ */
+SEC("tc")
+__description("test_bpf_list_del: remove an arbitrary node from the list")
+__success __retval(0)
+long test_bpf_list_del(void *ctx)
+{
+	long err;
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l;
+	struct node_data *n;
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
 SEC("tc")
 __success
 long rbtree_refcounted_node_ref_escapes(void *ctx)
-- 
2.50.1 (Apple Git-155)

