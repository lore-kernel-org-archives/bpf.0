Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E542773E5
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771044130; cv=none; b=KWgPFp8Lng/6HDlRLxviKsWIt14luixIeSoUV/ri2mdSOdVi4hwzMELzhlwlE5nbrwneZZeDWtK3fU92h1WGFjJsNhjgUN9vLpSZy13FBsrhAv29/MxiYAdwMNbG26kTdmW81Qj00d/dewG39L9969M7D+r+H8AMHH9i2tARb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771044130; c=relaxed/simple;
	bh=bA50R0bu4pcFiczphQwo0OOSupIpSY/EOYDo7M0jk+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QftPl4oMA/Lo82v6CbW5EwOqL8sqccNfvSSMz8vX40YmpeJpf4iPkfvpnELUGAVedDEavGIwadBZsoQDCFZNkQev6R++boeC2LFJODr6NROoloJ0hWCdTZ28OBPfy2wNL2Uyiqk3R6bxNFwv0PflMT/+h+je2DKGkeOonm0wGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlYxzt+U; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlYxzt+U"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a962230847so13320735ad.3
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 20:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771044129; x=1771648929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhBTVQRjsnIct/t3J+DD3t989mrabDRUagk4xQvzMQ=;
        b=KlYxzt+UUVseC02Op/FqlJ/H48xNCr5CLtss7o5gPlSyWXIvxRJCdcPaF3Ulh9ZX6F
         7tNN7uyi9N487iGz7usGBTJZe0KdGeDipvJYMAnV1sq4d5G0EH7+8LPNTh0bZDyDXw/u
         iOJvMue0nAW+uOiFuCg/kjoNSeXHqm+pjrZZlQTHM3fI3Wl0KgTsM5UfJio/lhV7EQ17
         NTqhq5H7yJZBqWMYl2j7IqNj/Ld+PDAmAgTiuJBmjn9mpIiT6tkEmIJofGReGFRoZWp+
         1TcKpvRDGKz1yOdbP2v/VSuWQpPGtcjypLimS32SEUwvpyNiQfdKFdNsMq3cWThMZe9S
         SlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771044129; x=1771648929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWhBTVQRjsnIct/t3J+DD3t989mrabDRUagk4xQvzMQ=;
        b=k6aCEFZJDdv/fbJYDN609Di8XUOXxjpYTwH4T6K/bcFzxLcFZZ4wFIjZ8iGJQYpthH
         jyQ2LE2aY2r9XgvF5eoXcvnYjzoeZvRhobTeRfQEP4ewYUbpz/uAe7Bt875G24OquQX+
         TWdAIZwey7ofMopdBVwvMTBpKxMIlSG2NBSDRAXdvXEuxZEi9MepXrQElfe09lVcqDkn
         AeXXWvAnIws/e0X8ORmTbj5Ze/FG6pfcYTtHDC+5OsHmdQpmV0l1M9KHsNXHbmCgzTgU
         gpAgWT5Qt9PrUMkrRfqYUpDdy+j5h90dK27+gKrdrs0lbZWcDHttnU+L1NEIlWg1IDES
         BSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVgPi39o7Vj6Uj3WnIZBd7WAe9gC6wxOffkEjXtZ5lBsqbGgGR4B7zVvRQgiGq+jAyzHzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvuSRif/I7SIXHMFyJ8rqMXqejV9sloNcD5sJIhikjxz5ZO6j
	00ofTYzIOo8RmGAGZZ2C7nZRMxHghX7+u8g8gjvdcFpLZweYxJ/x0W6A
X-Gm-Gg: AZuq6aLKs6ax05Vlo4wJBLoFF7CQgdS9aQncYKr0G9ee/yoKyC/X4Rx/PVpSq79rU0x
	g21cecD+uEwLG6oGwSASC8nhOqW3Fvb1+y33tjml0BhCc88qrDv7nUbETh7YEOX9cCKplqz+NbT
	z5JpZhgm4Yf+PJmi1SeuGmmbtpQ5CBXROjrHY4wBkq+327+FdZC5P1dxAbYyuAWzeGrHiIJo7ZF
	BROCOFWXksm2HT7ApgrhsxEpCb+StaizKCabIUYCZgRJzPDTRla19UYRigECVyOwxFYaBrPZLFK
	N2zSAKyvg7oWFvV27aUCbSqco7YAR0mNWmLRya5PsP6tEpe49Ba8OSd4KuMbpY8elzIqFukYcyg
	3JpCcwJEao32RaTob0nEsdrs0mLXdL9eqMpBNu0BfCtoFQhNYjMcRSy4jX3LMk0iZLb5zBJGF0x
	axVm+NcLlrdzx/tinUfK6FQ6st49DwF28VP4tY6GBmKcTa4Cb7dlbh
X-Received: by 2002:a17:903:2444:b0:2aa:ec1b:d3c3 with SMTP id d9443c01a7336-2ab505c34bcmr44046355ad.43.1771044129086;
        Fri, 13 Feb 2026 20:42:09 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa21dsm7218885ad.12.2026.02.13.20.42.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 20:42:08 -0800 (PST)
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
Subject: [PATCH v7 5/5] selftests/bpf: Add test case for rbtree nodes that contain both bpf_refcount and kptr fields.
Date: Sat, 14 Feb 2026 12:41:55 +0800
Message-ID: <20260214044155.38820-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214044155.38820-1-pilgrimtao@gmail.com>
References: <20260214044155.38820-1-pilgrimtao@gmail.com>
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

