Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36172E717B
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011667; cv=none; b=hQvmeg4fYK324F/1N09yNWKDrvjPzeKs3ps63AFNVMWCSgljfkdKcXMOhMDVAsN9mzzX8WDXMP+Gk3PF9j7dKXQwMlE8+KCuK2J8xHnxAqyjbMuqG6ef7uiBmwsrm57MHWPfdikyaee0NdHgyuhjhvqFVS5BOrCYIP38wtNh2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011667; c=relaxed/simple;
	bh=ntnkQefVl45lQLEojls73Rs/Y+YFDH/AmymklrtPohE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+qFZDsacx3acO4x6JMMDlpK2pt6jsvycry6uVCrDCnA3DQhGuvmaOWWA3vbc2wWBbGxV5KZVpQu03wvMOseMDs3e3LJo8LQWMwUo/mq4pMclKNeeX+Lym0t5qIpXaMPX0AQjmFR2Lpdj5Rq22sEdxpWW9+NmpbtvdjTfZMmHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b076u3PR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b076u3PR"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354c19bf64bso327485a91.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011663; x=1772616463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edeAv+lo1yi2ZetRpzlKqTFXrWjKU1IM+ewr9/GQxlk=;
        b=b076u3PRUo9NH4yBxsw0ocdQFubUZl9GwZfd5pywQn48+YjpU3vMoXmZrdsi5GbXxi
         9YPfZo0BoAbVrHAqwOzi4apQtJg2+jWopn2XaUWsGuyqwRpsOhLCSiuHZ3MrF5Gjq5E7
         +ZKKf5uFUrYxvT6Hp5lo9ozzoLWDsHx992gQ0SPYXbN1XKC9AUdQZynRT3jax/h8vtvK
         /UcOP7+L5PikaAMwGO+ST0KyNUcRIyxf7j/o4kJ1Binv3kV84hXNFu2v8I6G/m06Xunm
         zAo/vw5pYqYTWx8YofVYvkNkf+cnhASVFY5ew/e+FejCXdPxupe68QrxEZS/ZUadUdOG
         Cu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011663; x=1772616463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edeAv+lo1yi2ZetRpzlKqTFXrWjKU1IM+ewr9/GQxlk=;
        b=pJN3l+p+3g5NcKGjreM2lspWcr6x4seD8NWYOrVcnOlTQ8qsXxQr1Y0zDZmPQbMFWw
         AeGWlGxpY5EQVedRIUi6vle+EXdEXlOmQXltH+3gYTFl0vcEc6DfC6sEaiBeARjCfZna
         MurMt7PCukiBehfCoV8rm5bYNSByPayQs6d/UQsjDpgmg3zWWNZzVtR1EE1N3exsdt9J
         fW9YjcQQoy10Og2c27njnodboMdgFayuNjKjex5RdvD9QZwkQjU6HPRV2U0W4raOn/Wj
         NRuEtPefybsZtq/cljDq5sVroQ1lZJwMfBvLANhL15pX4eIMtPnZZGbDtVbp2sZwBbRf
         TOmQ==
X-Gm-Message-State: AOJu0YxI8/2V4wqXxdYb16Se3DIelY3QrbUKHY4aSgnn7lrd/5CnAoli
	GQiy3G7Vn2VOZgjd9qbLcM/nidLdcb+DSPAHEGK3LAQJBQVrk9HWwWc0
X-Gm-Gg: ATEYQzwPjGXRfrplixyJKfe0prvjVXq4CAmEqDbejf85nv9SEUC94BU3iMsv6lKx9s6
	eXTujHxgyhZEnW+yKo67hJAMJcllZRU1xTZT44GBwDQSzgJtGO4sfASLQtp/7dMOPSDyVMlVGAw
	ltIFgXX3wx0EEB4nuRQFgIrn/8imoQsncmQ/TkECmpUTz/fPrgsqCmgxmtFs1cZp4hrRFp5x1vc
	Y1uQ9tThhyW5iBZroOEzKXUjRHA4yeh3sc9Ha8RDj3S1owIN6qeD7s3qyd5vNdqoZlUFSsxIO1Q
	xQ9arAgYx3tDKqNNLp54OcCTxkuHc7f4l0CTydeXhjz+LEheasJnMO0UZp+OJqbKVMi+oXRAmXo
	JFDFg8QGbgAcU5UOMxePD6ISYXWoO96zgUGpbGwRR58abM9R5SrpsqEbQnzOw0717qwD0Se4UQo
	BpgpUOmNkMrQ7Bkq3ApLUSX+5UjKTdn7nJojQAqbfVM+tIQhGed4n6cw==
X-Received: by 2002:a17:90b:5787:b0:34c:7212:7a67 with SMTP id 98e67ed59e1d1-3590382bfabmr2213562a91.12.1772011663325;
        Wed, 25 Feb 2026 01:27:43 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f5f29fsm837901a91.1.2026.02.25.01.27.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 01:27:43 -0800 (PST)
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
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] selftests/bpf: Add test cases for bpf_list_del
Date: Wed, 25 Feb 2026 17:26:47 +0800
Message-ID: <20260225092651.94689-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225092651.94689-1-pilgrimtao@gmail.com>
References: <20260225092651.94689-1-pilgrimtao@gmail.com>
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

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 10 +++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 41 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..c7c950e10501 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -99,6 +99,16 @@ extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ks
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
+extern struct bpf_list_node *bpf_list_del(struct bpf_list_node *node) __ksym;
+
 /* Description
  *	Remove 'node' from rbtree with root 'root'
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 1aca85d86aeb..86f7f5f8e4c8 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,6 +367,47 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
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
+	bpf_spin_unlock(&lock);
+	if (!rb)
+		return -5;
+	n = container_of(rb, struct node_data, r);
+
+	bpf_spin_lock(&lock);
+	l = bpf_list_del(&n->l);
+	bpf_spin_unlock(&lock);
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

