Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8C292B54
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770605589; cv=none; b=hlM20BhtyjKgKQfhUV09QD3zovMJYIVfIa0h10aT6FLolC4WwgBy2rF5B2LT7ivFwqqtAUwKLU6qqABkt4ilhXjQdtjzerItrPK0B8UGVbGwC48KVGFrY7QNkcCwTgc0VSksL3o7uemHGd2155gVVkl/9vDFGCteUpcGVwjj8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770605589; c=relaxed/simple;
	bh=dZyWorY56D04HTdXpSwh7QEZlBPCUnue80n0dJ628hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqI1UscUguU29TVVkecZCtII2GgmFQwdlCay0nXWE0nzf9Jrmv6PrTWKYKGgDHPMfWVx+qRVLBoM9zcDiqCa/kBJo/c944cBTfPKk0Mqf2NSiF/8EeZ5cerUQLtY5trkCMHh01kc8jmw+1oz0v7c3KDwm6YOmF2GqTEHW5Gs9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWOxidjj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWOxidjj"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so2188859a91.1
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 18:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770605589; x=1771210389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQyhNUDLqzwbtqwaK40Ft6UNR4W3i+d+XwrUt1sl98s=;
        b=dWOxidjjI33rHL2TvhPdcEEzFcd/LYMhI6G9ZD3wiH7/GSBH6dOR49aJ2vhX9i+6an
         agnHddBa8V7x3ozmqoYtOqlGB8Q5esrAl3K6k4TILJfDzWiBuioiMNnog5sTnJmnWt06
         DPKB5LiYrAopUmba5yafH15ctSxqLn3E67iX5uxZM4CtcVw8zOBFIM8cDBN+DQGOGCxe
         KUg+NnhxAx2WPC6gyZWfJMcKdoNMa6LuM6ACINPodZ1H6pwsv6mBdbRjiV4mJvNnecsB
         SwLlX0q4WSQP0mpDhuOv+x4GEJz3xh+jCmgHTJT4QwF/GcfKEgpQMtXMNVagdTJ9zaBC
         ivBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770605589; x=1771210389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQyhNUDLqzwbtqwaK40Ft6UNR4W3i+d+XwrUt1sl98s=;
        b=UI2DUqMF35QrTkoDeWzNwKMvLhTksLC/awefj+tEv0VszI4ujRhoTVODBn3GD/FthP
         MwGK4jqnD2LZ+7rlctPaGp83X1LAIARFZ8gBMmo8iAt8HOH2BXZ8JOQdXeLT2dySAcpm
         RGdV67sLiVoUwVelyEf8HU8Kma79k4iq16n1a7RdIOGffsbc/SF889D2j5tQONcbJO2J
         pY34NSxTcCWVIX1SrcWYISeZZK8AGahs9QYR3YI2WCKVujcA3xgBiyDlnRWsoSLM1uqg
         vP8zLQWP1Uod1RLf6mnhxLVYtg7kDv/lAmEw5uphNm0w1utPlChuMoX9pJKpCjjeu3qq
         uO5g==
X-Forwarded-Encrypted: i=1; AJvYcCVu4YnehCmJMylgmdjjSO3xIQICbZcu5KjpRm8yqRSElvXWC2MkwTxPkHIrNq1TEbY95T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKygiESS08SXs98aLqwQGMV0hFs0ifHaJ3GqWcElDFNMseEadd
	pd1fPU7kAML/9rW03B5F8G6PlOk6oRozgnXWZ7VLWxFp6laV99cCzShL
X-Gm-Gg: AZuq6aK1sYF+xFFdUqhJhIVykMW6YLWX22D7B9mkguryudHNz1khHFg5WvVwt5jepA3
	NGtnguVRvv6XEEgZrIqVtiyIIE0KLxncQkJuRNTKsQ+L6RONd4t1h6Hxjbg3yRJr1L43HvCTfvp
	+bNZBSwvnjwT04nLI16/7WOgMozVFi24dqQp1bIUAyX/g3qVkdf1uiaDKuZR3j8PJj9IQagxB+m
	35I1wIzQvoCMdEyyscp8xcSg5k4loWaAsHvmwSTPQpQMQ2Su7ChD5urRtq3CrPz7gwaGKIfyDuT
	Su5xha8b5/AxXzQYZ3fnGrv3cDzoNVaFwJ9KjEyEX2z7QMXJcy9cv95CGGlJk1VFf5+7xfECJw6
	Oa2U10trSgHrcL0PXyk8F3r5xs3P1ecLH/nI2MciXJUHLBNXResbDFRG9fUKi7cQYVHX5eqL7j6
	12fHEOl+wiC1ZD6GcAJqy15Wi2gI8jwvUNdg+NxAgykV3sAjKyXoXN
X-Received: by 2002:a17:90b:1c8a:b0:356:268f:4fc with SMTP id 98e67ed59e1d1-356268f08c5mr4112871a91.11.1770605588737;
        Sun, 08 Feb 2026 18:53:08 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35621177896sm6302649a91.15.2026.02.08.18.53.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Feb 2026 18:53:08 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: chengkaitao@kylinos.cn,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] bpf: Introduce the bpf_list_del kfunc.
Date: Mon,  9 Feb 2026 10:52:49 +0800
Message-ID: <20260209025250.55750-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260209025250.55750-1-pilgrimtao@gmail.com>
References: <20260209025250.55750-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

If a user holds ownership of a node in the middle of a list, they
can directly remove it from the list without strictly adhering to
deletion rules from the head or tail.

This is typically paired with bpf_refcount. After calling
bpf_list_del, it is generally necessary to drop the reference to
the list node twice to prevent reference count leaks.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 19 +++++++++++++++++++
 kernel/bpf/verifier.c |  6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..44d9b9ea8d40 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2388,6 +2388,24 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, true);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+					       struct bpf_list_node *node)
+{
+	struct bpf_list_node_kern *knode = (struct bpf_list_node_kern *)node;
+	struct list_head *h = (void *)head;
+
+	if (unlikely(!knode))
+		return NULL;
+
+	if (WARN_ON_ONCE(READ_ONCE(knode->owner) != h))
+		return NULL;
+
+	list_del_init(&knode->list_head);
+	WRITE_ONCE(knode->owner, NULL);
+
+	return node;
+}
+
 __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
 {
 	struct list_head *h = (struct list_head *)head;
@@ -4404,6 +4422,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 50cb4956e5bb..dff6cc8912e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12345,6 +12345,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
@@ -12399,6 +12400,7 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
@@ -12862,6 +12864,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_back];
 }
@@ -12970,7 +12973,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-- 
2.50.1 (Apple Git-155)

