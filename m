Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580C3AE192
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634948; cv=none; b=OrxfLjToCgWMQ/moFzqc5V3rezI+9jjyaIsnylKR3nFmwfplBmBkYDEgmqCc/xAJnZEUkzRYg121DOyUuJCV2MeQDT08sQL9j8Tpd0RAoS06NMWDbRYkwWtIYR8lJKGPQShxskEjE2wByiNHpr9VZjIF88CpsIiIIkK3eQ/D7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634948; c=relaxed/simple;
	bh=XL6lEjWFt+XtdR6JFV7Hk/lJSZOMN7fdGjaesaU1jQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9rFoca9iyDuKuhzs9HH5EzIYb+ZCCYWyKAKvZphN+Qh9beJdUqFAk7ufo4W3iL1VPEmtO7fj+QVRLdG/s80VRFaZAOp/DDb/GY/n9wiJbzovNBjBr/KO/eFcC2MwBDhzPd4+Fm29NB+xcAaaG/UBIzLa3+5yzTLaj4Y46QKlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI+IAcat; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI+IAcat"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-827390e8a3cso4493559b3a.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634947; x=1773239747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hw1wiE26Ls+6Ko48lXsKErvuJGGoK4sfU++ZQGgH2pk=;
        b=CI+IAcattnl3V7MbO3b8viTJvSgAjFblGBNTuvrjGEpMQIhH5mn0L8ZzfnrTIGZgpX
         UUigNXxnqvue31JU0V9qDQnkTsd4vieiBGFVVuFacXIFCdqebnkBQYdGEbmb54d/HvOS
         lCqao9dCKOQefCz9ApUXl6hMsBwoU0E75AY+qYs95A8zTFNk/AaS0Hdy/9/YSzln3k3n
         yEPgMbSm63B+bYt3VOnrzLjFfR4cKi6u1Pk/voPNryhbb9UJ5BcO3TVgNxhJgdoo/Bvt
         0ZWMJopFI/f3QZR+XPmDZjwSjfZVymwQYtg+XK3deE7b5CeuMs/0+f2rw9+cZlzHyUF+
         0tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634947; x=1773239747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hw1wiE26Ls+6Ko48lXsKErvuJGGoK4sfU++ZQGgH2pk=;
        b=NI78MxS/xQv5tFansidkA6o1zk5dx7Oy95x0iaLI5EZi2EjhLG9QSAAt6h2DHKQg6T
         HV219LAEiK1m2gxYVEilxn05Sz1HKY9byr4YiZceXA0YjAG+0++tqyS1s93T/HOCYNRm
         QknJzlECmNwqripuui6e4Fu+9HNumfjAf2TgHDxQMCcTz5/UMy74YYp8znKPNlbjqlVZ
         9cPKMJ86Mlis+ccJfuqLKIxGJDHW7kka4uYUdzkuu4WPDHJeumzwPD8PyXqN5+w6olZA
         Rq/PvCuFVOk0PgRzas6f4RvHEd8hXzcbttCLEx7FlquUTJgOrpTKRnZlwCj0UurPIbjC
         jZOg==
X-Gm-Message-State: AOJu0Yzto5Er5G3lVk0fzX6pWTir8cXC8dXEuxaVdkLBZbJ/iQ+rxg9A
	YEl/Y5Lp9vPfd31xsEVKPXljHfhGABR0fXli/gRAvPd28hgUgzS+NjCF
X-Gm-Gg: ATEYQzzz7JmFdlhYrPUBqv7vnBj69aVwoexkXMeWQXUyowqqSCRtt87vAnBQBVysXf5
	8H+kX0Xr5PHo4UcrvC38023M2gPfZpNPU7I+NyseNCkKrbuz+m8oVMBNa9jGGZfF6+CmCPFMHtb
	dYr0T19gpXTZsWT3enPNctWb4p3juaw61Hnq0IO0Ab71RkKSxdJbvZ/9D0RGudZvMYgzIocnMwW
	Mq57fFnu0+qUdftXTAQjsDw7pX9df3Qy9sg3+DJb/JkiJIjq+mBstXcLj+tfVMcb2tNmAbOJgmN
	+HXobksVHI9aVIHuBKMne8qHXDrp8d6eQ7t0nfG8O7FNespGGeY04ktdO9/IRtrK9pr2RgojM5y
	jACYaGnalU/VGWfwFnBhdDV0Mi0pwDc/7PPKG2aDgwdijhtdI6xP2Ciu8E4+LjIEXB3cTT2TvOV
	4wVHQgKjROaIzvI+xhjp4kN5Qi4BRKsYlZSNErQag9bsOvSswldZhKkQ==
X-Received: by 2002:a05:6a00:9141:b0:829:7a62:6a with SMTP id d2e1a72fcca58-8297a621faamr725346b3a.22.1772634947050;
        Wed, 04 Mar 2026 06:35:47 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm18470184b3a.15.2026.03.04.06.35.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 06:35:46 -0800 (PST)
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
Subject: [PATCH v6 3/5] bpf: Add bpf_list_is_edge/empty kfuncs
Date: Wed,  4 Mar 2026 22:34:57 +0800
Message-ID: <20260304143459.78059-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304143459.78059-1-pilgrimtao@gmail.com>
References: <20260304143459.78059-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add three kfuncs for BPF linked list queries:
- bpf_list_node_is_edge(head, node, is_first): true if node is the first
  (when is_first is true) or the last (when is_first is false) in the list.
- bpf_list_empty(head): true if the list has no entries.

In previous versions, to implement the above functionality, it was
necessary to first call bpf_list_pop_front/back to retrieve the first
or last node before checking whether the passed-in node was the first
or last one. After the check, the node had to be pushed back into the
list using bpf_list_push_front/back, which was very inefficient.

Now, with the bpf_list_is_edge/empty kfuncs, we can directly
check whether a node is the first, last, or whether the list is empty,
without having to first retrieve the node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 37 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 11 +++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 740b53024283..3d22b6080185 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2538,6 +2538,41 @@ __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
 	return -EINVAL;
 }
 
+__bpf_kfunc bool bpf_list_node_is_edge(struct bpf_list_head *head,
+				       struct bpf_list_node *node, bool is_first)
+{
+	struct list_head *h = (struct list_head *)head, *edge;
+	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
+
+	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
+	 * called on its fields, so init here
+	 */
+	if (unlikely(!h->next))
+		INIT_LIST_HEAD(h);
+
+	if (list_empty(h))
+		return false;
+
+	if (READ_ONCE(n->owner) != head)
+		return false;
+
+	edge = is_first ? h->next : h->prev;
+	return edge == &n->list_head;
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
@@ -4608,6 +4643,8 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_add_impl)
+BTF_ID_FLAGS(func, bpf_list_node_is_edge)
+BTF_ID_FLAGS(func, bpf_list_empty)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e458cf3b1dd1..d133d18aa0cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12465,6 +12465,8 @@ enum special_kfunc_type {
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_list_add_impl,
+	KF_bpf_list_node_is_edge,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12527,6 +12529,8 @@ BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_list_add_impl)
+BTF_ID(func, bpf_list_node_is_edge)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -13003,7 +13007,9 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
+	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_node_is_edge] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_empty];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13126,7 +13132,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_node_is_edge]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-- 
2.50.1 (Apple Git-155)

