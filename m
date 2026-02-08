Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA80288530
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770518995; cv=none; b=na0IkvNQ+SQDX0biXe6xVZJ8Lpu03JHh5oeD5flAMVstqBLruT+LbRNgXcYZMpRrrcxE+o/l0LMqxse106NquD5ycl+DUp4CzLskEOJ17vJF3UeaF207hF7VXHt7vcDz/Isx0Z9bx1l+NDyODz5ejiMUf3Qs0jcROJSfMX+IoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770518995; c=relaxed/simple;
	bh=bA50R0bu4pcFiczphQwo0OOSupIpSY/EOYDo7M0jk+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnJfUYtHVTjwaM5GBSRg/JoxTi7edZSJ5FOYD7ugpu+34wTokvPGn5+8hAKVT8ReCIj/KxjlbKLdODSsrDBJnVdyhy+MVwq2K9/fGzRe1axGDLS1aBfc+qSxG7f9g3wX3Riq5eCNLs0oO3sVrjMUZ7EneJsF7VUU8MR3OAaymsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5/S/5Tp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5/S/5Tp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae4816912so309125ad.2
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 18:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770518995; x=1771123795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhBTVQRjsnIct/t3J+DD3t989mrabDRUagk4xQvzMQ=;
        b=B5/S/5TpBr4/41WsnOGYvFcKBYAJ2yGoTd0eKYEz1D7ag+vtQ4Evt8crh8WSgMEhyc
         MzHuRDlciJkKAfpOPqcAEKREsk0Vl8o8Cti0SUL305yfRSnfN0w7+Mnx6xlgkUYwRCNv
         Ul3OHhlwtbiW0aj3H9uwT7x/RXGEAh0uvBWzsApgeNtY3gqEs0MS4eDI6pFndq+OCV1V
         hAOQ0xaGROjK7AxcxY8zB/7Aeqv+21ko/ogRNBe7YCS1kuYeMqfvXEHsgXuVFvZrseg2
         ruWMZdLQQ2ZRqVLQszev1Fo/dwsz5ozykdtZWgWlp7d3oh36a4XJ2antlL6Nd1kbJ4CW
         yhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770518995; x=1771123795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWhBTVQRjsnIct/t3J+DD3t989mrabDRUagk4xQvzMQ=;
        b=Lottk7qdWhBaT6cAwuwiPLc0XvyYo15upxaobRdzhqLQGQL9rhmsO7fWZx2kQgA0fC
         2NLKXVph3bUEgE0+EmTyW694YyNo9Or0PKDmOmioXXmX+DBmmYWV6sZkyyKOTghCc67A
         yINLuJdjSqPV5GSlS7uaD7f2XEP4caWJ3ODKhgjfE6M8JAtS4vSLAI2WyUUjQLPKJKQ+
         LXuESf8sgYSj2q45aSALAxwFTM2T415K1TiBUINzjpWjP0ArouZuBxpHDhsOz1reB15U
         iqlxpOkvlKdpElHQwpN2lCgZ77IRaw//IvEkVAZw2/ZM1RAWRfSiSKWB+g2IEYIOdncY
         ptWw==
X-Forwarded-Encrypted: i=1; AJvYcCUjylS38rSanQsDgWxA0UAwuMTQbxs/uSiBsK0uwezsotTa8qgflnNngrTy0A96hpdZgt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZv6R8Ditrwy/iwUGT1bueNb+wOBngahBzDObZDSjKrxQ1TGt
	dyW3GXvR973nbcplvGfyS9C25vF6LwuTV5fPHrR/gMGU9aSip4vmBdUS
X-Gm-Gg: AZuq6aJeZcethpinXJTuCSfdcRrVEFPGRaRTcNSnTxUIJSzln07CfckawxXNkOUgEMD
	vR6FbR8B1xBrcaVKc2QEYoHeOJGQ5l3o2fW3upDtpmvHEL4FphC3ypFW8MYphja+JHfAGs+sf2k
	m/pXzaAYDcA56X4z2pdr/Hl/VyEXe6pPOKktqHP+fmEFc3udQgoHPvJPqmLyrE9KqpzRdal+/Rm
	FkYBMGJrMaPz/qbU/nFvdOeV/D2dTtN+MO4tYo9775bo7a11qyLBdsy9Cycc9bswkqiz12m6TmW
	PYjPywNUBWGdfT2/xY27B4rf83jkCxsofdnwX1nLiW80JZGziRMET9W5gzFyHEoif+fvd+vFa2v
	CksIirfHvY2WLbkVV8P296HYac6xor9vn/+d9Ixs6G/ocpJr32p0VCiRSUMJkjHECKF5uXQsOdR
	2Q+oSUaoRepdOhA8EhfGqnowFvbwzbeFefdMY/XnKE
X-Received: by 2002:a17:903:8c7:b0:2a9:6414:719c with SMTP id d9443c01a7336-2a964148176mr34608145ad.16.1770518994826;
        Sat, 07 Feb 2026 18:49:54 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9f5esm67194715ad.51.2026.02.07.18.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Feb 2026 18:49:54 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v6 5/5] selftests/bpf: Add test case for rbtree nodes that contain both bpf_refcount and kptr fields.
Date: Sun,  8 Feb 2026 10:48:46 +0800
Message-ID: <20260208024846.18653-6-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260208024846.18653-1-pilgrimtao@gmail.com>
References: <20260208024846.18653-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Allow bpf_kptr_xchg to directly operate on pointers marked with
NON_OWN_REF | MEM_RCU.

In the example demonstrated in this patch, as long as "struct
bpf_refcount ref" exists, the __kptr pointer is guaranteed to
carry the MEM_RCU flag. The ref member itself does not need to
be explicitly used.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../selftests/bpf/progs/rbtree_search_kptr.c  | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_search_kptr.c b/tools/testing/selftests/bpf/progs/rbtree_search_kptr.c
index 069fc64b0167..610aae45e2dc 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_search_kptr.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_search_kptr.c
@@ -18,11 +18,21 @@ struct tree_node {
 	struct node_data __kptr * node_data;
 };
 
+struct tree_node_ref {
+	struct bpf_refcount ref;
+	struct bpf_rb_node node;
+	u64 key;
+	struct node_data __kptr * node_data;
+};
+
 #define private(name) SEC(".data." #name) __hidden __aligned(8)
 
 private(A) struct bpf_rb_root root __contains(tree_node, node);
 private(A) struct bpf_spin_lock lock;
 
+private(B) struct bpf_rb_root root_r __contains(tree_node_ref, node);
+private(B) struct bpf_spin_lock lock_r;
+
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
 	struct tree_node *node_a, *node_b;
@@ -130,6 +140,119 @@ long rbtree_search_kptr(void *ctx)
 	return ret;
 }
 
+static bool less_r(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct tree_node_ref *node_a, *node_b;
+
+	node_a = container_of(a, struct tree_node_ref, node);
+	node_b = container_of(b, struct tree_node_ref, node);
+
+	return node_a->key < node_b->key;
+}
+
+SEC("syscall")
+__retval(0)
+long rbtree_search_kptr_ref(void *ctx)
+{
+	struct tree_node_ref *tnode_r, *tnode_m;
+	struct bpf_rb_node *rb_n;
+	struct node_data __kptr * node_data;
+	int lookup_key  = NR_NODES / 2;
+	int lookup_data = NR_NODES / 2;
+	int i, data, ret = 0;
+
+	for (i = 0; i < NR_NODES && can_loop; i++) {
+		tnode_r = bpf_obj_new(typeof(*tnode_r));
+		if (!tnode_r)
+			return __LINE__;
+
+		node_data = bpf_obj_new(typeof(*node_data));
+		if (!node_data) {
+			bpf_obj_drop(tnode_r);
+			return __LINE__;
+		}
+
+		tnode_r->key = i;
+		node_data->data = i;
+
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, node_data);
+		if (node_data)
+			bpf_obj_drop(node_data);
+
+		/* Unused reference */
+		tnode_m = bpf_refcount_acquire(tnode_r);
+		if (!tnode_m)
+			return __LINE__;
+
+		bpf_spin_lock(&lock_r);
+		bpf_rbtree_add(&root_r, &tnode_r->node, less_r);
+		bpf_spin_unlock(&lock_r);
+
+		bpf_obj_drop(tnode_m);
+	}
+
+	bpf_spin_lock(&lock_r);
+	rb_n = bpf_rbtree_root(&root_r);
+	while (rb_n && can_loop) {
+		tnode_r = container_of(rb_n, struct tree_node_ref, node);
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, NULL);
+		if (!node_data) {
+			ret = __LINE__;
+			goto fail;
+		}
+
+		data = node_data->data;
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, node_data);
+		if (node_data) {
+			bpf_spin_unlock(&lock_r);
+			bpf_obj_drop(node_data);
+			return __LINE__;
+		}
+
+		if (lookup_key == tnode_r->key) {
+			if (data == lookup_data)
+				break;
+
+			ret = __LINE__;
+			goto fail;
+		}
+
+		if (lookup_key < tnode_r->key)
+			rb_n = bpf_rbtree_left(&root_r, rb_n);
+		else
+			rb_n = bpf_rbtree_right(&root_r, rb_n);
+	}
+	bpf_spin_unlock(&lock_r);
+
+	while (can_loop) {
+		bpf_spin_lock(&lock_r);
+		rb_n = bpf_rbtree_first(&root_r);
+		if (!rb_n) {
+			bpf_spin_unlock(&lock_r);
+			return 0;
+		}
+
+		rb_n = bpf_rbtree_remove(&root_r, rb_n);
+		if (!rb_n) {
+			ret = __LINE__;
+			goto fail;
+		}
+		bpf_spin_unlock(&lock_r);
+
+		tnode_r = container_of(rb_n, struct tree_node_ref, node);
+
+		node_data = bpf_kptr_xchg(&tnode_r->node_data, NULL);
+		if (node_data)
+			bpf_obj_drop(node_data);
+
+		bpf_obj_drop(tnode_r);
+	}
+
+	return 0;
+fail:
+	bpf_spin_unlock(&lock_r);
+	return ret;
+}
 
 SEC("syscall")
 __failure __msg("R1 type=scalar expected=map_value, ptr_, ptr_")
-- 
2.50.1 (Apple Git-155)

