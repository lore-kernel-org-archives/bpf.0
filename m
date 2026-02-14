Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040E27F749
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072882; cv=none; b=AlF6VsjpkTqGLkPJCBaMOXjBzqvB+kZ4bXTv6avlw3tdRimD6cisQMGaUYmxvOYBoV+Mzi4S5yy2VmTXfSCliQyU5ZVVBmcf17zinyfUzaCzJyx6JdMiVD2Fb5UbJwOQaawHsVjRAw8QMgMDda3X8cpdKG97Pk+b+zDz2OBxiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072882; c=relaxed/simple;
	bh=bA50R0bu4pcFiczphQwo0OOSupIpSY/EOYDo7M0jk+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t36Vmmdv6EmqJ9BrBEnvGV2oNGfcIzAMIpy8yqF10PTJxJy3Se1OvjVZ81xvFnyG/+S5POxwe+ANO8wuctvXMiPkDWLqBcjBtl6AT+cn23ZgB8vvhC9iaR+Amu4PGQSa6G42iF8ABH6Tgxdovi3e3F16h4++IkP8yEmuLsBGRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzi6/Mbd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzi6/Mbd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824a9348603so708072b3a.2
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771072879; x=1771677679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhBTVQRjsnIct/t3J+DD3t989mrabDRUagk4xQvzMQ=;
        b=bzi6/MbdpHDsO0RkKkdNUZMPLI9o+/SLJ+uKnVlpRGNJDmdnlFLrlsdGrQdF3nLcl2
         RGlnoh2CzD2FCdxUgkTpK9DszwI8b7J8JSvwvDFY7OSDwzHahHCuDBI/iaAzXERcBXaF
         cBAaF/9k3No4jMu21OV8Ev0xw48QP8pGXtV+vTNK8V4vGIW1MLWkwl685pmLDxctljC2
         W6Tn2CtQaXlZiSYwzYsOYoNwJJxft2ZekO94nyHEbP4iZ5eTU2pHEqfspWeRYTRxJmwv
         cZvb6lwW4V3lCj7XuIvrplUS69afsbKYWxhRFGFM9Jlm6zNTzHevcsIajO0S5l9jdPq6
         097A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771072879; x=1771677679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWhBTVQRjsnIct/t3J+DD3t989mrabDRUagk4xQvzMQ=;
        b=ccXwouqMi36PkpUOtefBYiiRWzDi6NMFL4sAaUFUlfrhP/d6DYD+DefDfl65w0BmhN
         jcqnSdBFII8cQ2bx0P9MvVDXV3dQwsmSK8LYEVW0Xpa1ZHdb1WDIXj/VSU7BVpBLh0MQ
         e7F8MJ2R7bO7QLAM36QKNmIUk15n9jGRYaetmdalCZAsAPSzLsCjT7u9/5wO01FfLku5
         GGhcGjW1HnQ+AVfYy0tDS5CbOB5bAYt/1SQRS1NaD/xgn/7nqBkcrKWK96KQH1cG2ewA
         nApVi6P5Sefw0MMAXGw2hVovtx5Xd+xcdz7yjqhBMgeycOAuFrGp76fCfbNl8tRrExVx
         hYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxJ8QpYIknmR8uYk3AknNNWnXp4HN7gDKxlPbAtWWLt0FQ9othLIVgyC0LeI03eAmiEJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ub6G8ASOkCo3p3eBY+6Z7SilS6JxRo8BDptKT6O53tEbUiLA
	clsRtom+L1EPK8YPv+CpN5qA3x2Z7PbFJd+5z6UfqyZizvA7I4MB0DVR
X-Gm-Gg: AZuq6aJ8E0zLOJMhJrSQTVHseyI/Q9b9lYFdclCOTgCvs7H1EbSBPMHn+aJb3uh5Zs2
	ay3jmK2RRHh+9WNdpKPvbKkktcU5V9dgcH3HX/PxPzcCTW5jmLwXU7pAVPI+e8HAJux4oPlsP3Y
	/LUAgS9NFaVCusshsrsNxcYS3rqbV9IRbjSYd+5BrZ4oetX2x+3X/pgb+Tt4h5Ovc7raTsyWk/H
	Re0hkQd/zMxiq37Qcw+jw91p+oyWN3wX/l8KmH6Vqc9nnBcTpPS6/IoZX2q9IDsdbu6KetfcmrO
	VsFXkdUlqqjT0cExm70AvAkPBqEsLTksednqTSiGdqhYr2FOWnV5EGChn3pqB1CMZ9Z6Vm4HfA6
	fKDx99FqWO5VW+yLrJ7NHWrdvnw53y20MQhIM92z+fBY0GBZHzWQbscHXYY0VMHB8A9GDL5K94g
	69Qk8XYe3fZhNwt9Z9HFDtZaLxneORvtClUEAYtfwEGcOXICggXCGG
X-Received: by 2002:a05:6a00:b904:b0:821:81ef:5de8 with SMTP id d2e1a72fcca58-824c9444a20mr4983100b3a.12.1771072879198;
        Sat, 14 Feb 2026 04:41:19 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2e40bsm7064497b3a.11.2026.02.14.04.41.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Feb 2026 04:41:18 -0800 (PST)
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
Subject: [PATCH RESEND v7 5/5] selftests/bpf: Add test case for rbtree nodes that contain both bpf_refcount and kptr fields.
Date: Sat, 14 Feb 2026 20:40:42 +0800
Message-ID: <20260214124042.62229-6-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214124042.62229-1-pilgrimtao@gmail.com>
References: <20260214124042.62229-1-pilgrimtao@gmail.com>
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

