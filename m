Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27684374751
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455258; cv=none; b=sgfOdkoDDevKJIxXu8gf9tMBZKaF7BuZTi9ZZMrRfEhJddkbf+UVaRDyr+euDAT5RgvzWkP9j1walrw1/PwgT+lZllSzMdxUYm7JP7KfjV2bn7mmzmX4G34yoSI1qp09fQyZ0p7XKv10yLfLRjnCV8Geicluus11sXIMQOFSBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455258; c=relaxed/simple;
	bh=sOe9arj46SNWwf/pIF8963vr5xEYDR3pc1hBPuALohY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWRGwyB/nAfS1tjBlHZFt4tQUse9dGGXxr09wuRcNj/xnajXv9xYLNQnkWwgd+B8dJIPbE/MsHmxPJjk2KIoT21z+Y2ketyxNJSZSi9++uZygnl1WtNdwsw2rzvnqwsRCArFn1trL9QHpFskuwlFtjvmk0tMsbxuLvVg8SJkA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW7f/9tl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW7f/9tl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae41544dcfso18556425ad.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772455256; x=1773060056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX4WAvxsCrnf+I/DBX5XaVur9b97LAwNil7wzBRZi20=;
        b=UW7f/9tlWtJ3TM5LHAMxWUipm3FjEpFbCpEnjckH3Eb3vANq4Ac6F/zY/6hdEg68M9
         JHRh5FsLpvoSLneyQ07RVDDiyXmFMJtYdpoaDJRP1kMGwI0UVNPT5Kk2R0/teWcgod0A
         442ukMb/EnDeMT5XRVaYVDJOe2bulhCjuHmOLbUzBvzlQSlhsdndHACH58HgeTr4I3W/
         nF3uc36K1MuyyoqgKnReZLdXZmyGCPEt2ft+TRLxamfZdP84jFj9Sa3Kt3O7Krk5MZGf
         apBSkQmrZbY9dsJK3gZl4Lsz8LcY7Axli7672l8EskcBb9+V9vrGcx8IHIP7evzzYA17
         Xw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455256; x=1773060056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uX4WAvxsCrnf+I/DBX5XaVur9b97LAwNil7wzBRZi20=;
        b=dZGYSUJqHIIIzbC32d7O6wUrn2lfD9Xn7/d+abPKwiOPrZ0mrpyvjG8cNtoqQ9skMm
         X8YSeKS9IVm/pC3VXFEBBXE7ARFMz0ySnOR//PbkJf0oDc71PickCBoUwKnMKfGeAuNG
         cEDNP1hTMQHKPZKiI9aDyXrcCDnpPvVrWDo6iypv5AXMaS6R0/3awLuTrFTEs5+X5e7K
         r1mco1H8iHiuRdGWRWwfUWp4W3HBdUu1CatdfJyiLZVwGqoa3s5Ny/jMXx5gU42s2gkg
         hzT2gVu5CxzK2aCZCHJT/4KRdXNWv6Kq7LBmnztz7GHyBjudBRLYNs5kaRiXR6jlG3o1
         9C/A==
X-Gm-Message-State: AOJu0YwxF+Zv+/l1KwyuX3+D0tVLKxWZreEWrgSg0UUw3cqtjkT3jBTV
	kDJFU59tM82oaHfhf02jTP6iLKsmVbm6dxpGaulOdwMFxRN1yiG0rcPj
X-Gm-Gg: ATEYQzy4tcKXmAZXC5jC2pUKhV6ePZr5e+ocMmfa5Sfk3xHHMHniQWaDEbwRGxM9Klb
	EqxKEsxBpvYL1n3BLCNxo6Q+ViHivfJU1pHzj7uMDa7Zdrisjne0BhkBIncRZITHOVqVc+L5BoV
	A9t7O2L0ywb2csOan/ujzRvFsVyM+co5D/KA0IT5Xi7JxMD/+Wq2Rhj9zAEaW+ilCq3+UHYZV1N
	pC5kHdWQrTHcXUhVjVsgIpsFBxOTWvZutyPZQAii9iTpZzd73kMiril+JWGamh6tAZDFJlZ+Pia
	ov9o4Sdnh31dh8GetpguPkUau4Z6eOafwYjZvfz62Km2eaQwxNVEdZpGgn4n3Fro6LO2ybjPsd1
	HJq8dASsaQc7pEdhBFmrAvzTjWIJW9MwmgZThYU0gXv2H+7DJrRfjg5PdxEO0nMXNohrcvpn8Hf
	Od4PNGqAfhbzqMlC4OGKH9/MLLCaX1nM1n14rEl/JUJWlJoO6JKDoYcQ==
X-Received: by 2002:a17:903:37d0:b0:2ad:dfb8:8ed3 with SMTP id d9443c01a7336-2ae2e3ecea7mr116397005ad.8.1772455256520;
        Mon, 02 Mar 2026 04:40:56 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1956absm67910225ad.14.2026.03.02.04.40.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Mar 2026 04:40:56 -0800 (PST)
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
Subject: [PATCH v3 2/6] selftests/bpf: Add test cases for bpf_list_del
Date: Mon,  2 Mar 2026 20:40:24 +0800
Message-ID: <20260302124028.82420-3-pilgrimtao@gmail.com>
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

Add a node to both an rbtree and a list, retrieve the node from
the rbtree, use the obtained node pointer to remove it from the
list, and finally free the node.

To verify the validity of bpf_list_del, also expect the verifier
to reject calls to bpf_list_del made without holding the spin_lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 10 +++
 .../selftests/bpf/progs/refcounted_kptr.c     | 71 +++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..b4fb0459f11f 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -99,6 +99,16 @@ extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ks
  */
 extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
 
+/* Description
+ *	Remove 'node' from its BPF linked list.
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
index 1aca85d86aeb..c4fb5615d08b 100644
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
+SEC("?tc")
+__failure __msg("bpf_spin_lock must be held for bpf_list_del")
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
+	l = bpf_list_del(&n->l);
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

