Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996E248F54
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977639; cv=none; b=IaVxw0DKYm6fV9m41kX4vpQLyznu9foLzCjMsI2atSQ9qGkpFS1J/ibzukcb7noY1IThAQiDblzRdJbzBCJ0o1poOCIAUE72W5M6+WGHEA/Lad3OQ4f00r+c7g6hP1XOARcsJADaHXlM/Z9QpEwZwURxCXH+oQ9/jNVJzRifXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977639; c=relaxed/simple;
	bh=1eWxWto6KUk7PXfmWo0yP2+4m0Bt3mH32o0CRbZIsgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iryHo3hzz8FXCDLnbMu07ONypP7ugi2PiNbtzNN778kIjl0yVRo3qECPl8tjtFHnjzpfE6/qq4hnhlyviAgGMJO3Rd0RJCgPxw6ib8e4sKbZg1Wfb5wFhPWjofvSQUESVjA/cO4pKFJcXRacML8prDU7ePlLzpcCZyHyOUpMrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SizQlioL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SizQlioL"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82984c077b2so1570040b3a.1
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772977637; x=1773582437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5ogfvh3LzPgqc+SKxRTFIvNBgOyOocO0BrAiL+IkvQ=;
        b=SizQlioLetZYYJsXqd9lDAv4ffIprn6V7/fq3EN1oqWu4ZFdWFWW7RxPoeaU1aA0yf
         3XmN7iVs7r6P1qG2XnbAVTJZNQ4WxBpuIDMXiIMxNKSQ9oilrpAeu1Jay9PC34pXStLg
         wDg4IW/lVtnSPbHc56B7Er4aPL9q93PfYepUEBylAvLTbh3xmkvoeAHsxsT6IIVJLeXZ
         Xgt8IUQm/TS2XPioA2OTTBSCwhL27utzgXeq4pjTF6b0mRrqyZWLybsFWM/xbzTa+cc9
         Lwc8L9dYFuucngbAvYsCeBiuAQ6H67cZEGzpT4/33wfrxZ0rZ01eO9FEDF7b55R3se/Y
         1n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977637; x=1773582437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5ogfvh3LzPgqc+SKxRTFIvNBgOyOocO0BrAiL+IkvQ=;
        b=fk0HBh4AalSeyugV+TmJq0GlurquTNZ97wlbf6fFvzKst4vhG09KXwaXXWaszbMgoo
         z6yAATX8jCsgYHJEvxvn1uud42r8B6trCGKFce/vrhmV6qcIzdjRccgMNs7KRU1lEPT+
         pWcR0sfe8ovUPdTjmpl+xTE1D0ZeG1770j4/JxVpLaD8yphVcbxiFg46eM94r0VV/l60
         ZLkmlzLEtU9tjuoWRQYZ9NMCNv2JDSYyqY4dUyQiXiVzJUs9VBnAuwZH1dQOc8ko+K6s
         iNLsfj89s3spZ5oa2vuixLGxgmrw6rR40jRaN0bR9fncFXwIf+XNjwTKLmIx/f82YeB3
         iaIg==
X-Gm-Message-State: AOJu0YxKZkP85nSntK8eOQeTVYz0qs6nqT87Jg8ulEAvnlQurC1Xq5ge
	TZWVRaqPiHqf9WuMpObNVYse5r1p4iRoElmS/Zb3g62mUXNOrbwStsSC
X-Gm-Gg: ATEYQzy8z1NQONOBFRJHGfN903pPfonJvafvb3oaMnJqz+6tAmUg247rX8J4b+C90rZ
	LOBX5/wpLZg2p2saoBwCxno7shQNsfBrlLBl7ofkZk+FknBlwvLixBeY9KV7YmD5Pk4a1gc53Q2
	r59SrFotTy9x8DT5LML0UKrErNsUz9rn/xOQH/myYe8bTeCtUUYXnCftXDxCl5y9Go7ThFmj5h+
	iPNfhS1ftc8F8hiMI/wB09QgUo/GGpFikSIu5LFX5UrZoq8FKGhJGOSVZkQCN+P1kXAkbkBUeAq
	EAxdom3o8fp3IUmyHUV4qnARpI34Whk+0ub90TuZbg/GBLR2xrr47AuF/fHFAu+19GlFh3w7YsP
	6CE+dFL+yo0wkNZjzrFVMHJBnUkQoposy0BslVcO+uq0w0XIs0ALEariXj0jWxsMULcrmykIRCC
	KqE51BvJ/p5kBNOu0xSnV9Lg7nMS6j8qPn5H7wOtHHGVoGWE2G
X-Received: by 2002:a05:6a00:3c8d:b0:821:81ef:5de8 with SMTP id d2e1a72fcca58-829a2dc08bbmr7422879b3a.12.1772977637188;
        Sun, 08 Mar 2026 06:47:17 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636968sm7095056b3a.9.2026.03.08.06.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Mar 2026 06:47:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/5] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Sun,  8 Mar 2026 21:46:12 +0800
Message-ID: <20260308134614.29711-4-pilgrimtao@gmail.com>
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

Add three kfuncs for BPF linked list queries:
- bpf_list_is_first(head, node): true if node is the first in the list.
- bpf_list_is_last(head, node): true if node is the last in the list.
- bpf_list_empty(head): true if the list has no entries.

In previous versions, to implement the above functionality, it was
necessary to first call bpf_list_pop_front/back to retrieve the first
or last node before checking whether the passed-in node was the first
or last one. After the check, the node had to be pushed back into the
list using bpf_list_push_front/back, which was very inefficient.

Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
check whether a node is the first, last, or whether the list is empty,
without having to first retrieve the node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 15 +++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 407520fde668..476f5ad319e2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2515,6 +2515,41 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
 	return (struct bpf_list_node *)h->prev;
 }
 
+__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
+
+	if (READ_ONCE(kn->owner) != head)
+		return false;
+
+	return list_is_first(&kn->list_head, h);
+}
+
+__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
+
+	if (READ_ONCE(kn->owner) != head)
+		return false;
+
+	return list_is_last(&kn->list_head, h);
+}
+
+__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
+	 * called on its fields, so init here
+	 */
+	if (unlikely(!h->next))
+		INIT_LIST_HEAD(h);
+
+	return list_empty(h);
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -4585,6 +4620,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_add_impl)
+BTF_ID_FLAGS(func, bpf_list_is_first)
+BTF_ID_FLAGS(func, bpf_list_is_last)
+BTF_ID_FLAGS(func, bpf_list_empty)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f55b68ed935..5e32e02429c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12465,6 +12465,9 @@ enum special_kfunc_type {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12527,6 +12530,9 @@ BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -13003,7 +13009,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_back];
+	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_empty];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13126,7 +13135,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-- 
2.50.1 (Apple Git-155)

