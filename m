Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D08C2FF
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594190; cv=none; b=D/8OmRcrbYNegHLE+GbfNLkQgxJTnA8pGSbQbXzusjEklqAituZ3phxZWYXc8RV8iPX79WMOEW5nYh7Vyq6V2Ett4KyLTn4JknSvmHv/GQ/ptJsftw19UCrUnD1arY1YeOKiNJ5sEEGmlnQM+YnkbrGItRVzAXH/8prhLIaUFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594190; c=relaxed/simple;
	bh=bXOZyfrjjEJNg2zXkkRsWg+H9U/k/NIMjxFzOVXWV+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbkyHGF/7eplw/TJn+JiFweAJVfEoLheX6RJJQLPEH0tfedljqPUpNgAu605RHqQK4pzGh5bLAiKKot1ctwuXDCouhN7HA8MVWrSuSZY1rfUv45JMzlwz7MXmr2aTjhzvfy0/xhl8Fitvpjfl1G2DqHxuJEQhh+/ilLzAWigqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f//U9OPo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f//U9OPo"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296d553142so170272b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594188; x=1773198988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5WORjt7SxVQlhYT/6rzYEp8dt5s0cz4VVG01wwIAJ8=;
        b=f//U9OPo3nKm/ZZxd12kIfzmM7/PN4YhYB+2QXC/DE2SGIvidZxDPIKeHdVsFYpkoL
         9D+smbVC9gdSSzUdE6yo/tMaxi8YpP56DPMcvIpdVHXeb1aDvPetchRFjXt6F9KlY4J1
         BSozryKs7P2zyl9KTv49mrjs7nv07heZjBR6CSFHEOBXrGYr4UwN/6MM40Aah1IFj0Vm
         n7QvcacCj/d9wReVTiWnIwToefMvmm7b4Pp8N9qT7G/QeQM+vCKFzsvK1eTwM8Y4eT6S
         Eq0eTZLQU4m7aWo246wbIS1pB/N8oAwyEBtHgFiiENGVJ2h1zAHxgKPGW6GlphyuzEXi
         ZnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594188; x=1773198988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5WORjt7SxVQlhYT/6rzYEp8dt5s0cz4VVG01wwIAJ8=;
        b=h2phJKpu9jcNcOV5GhCXJerSjNEm4WRTGEjadOugLCc15wqFDeF9kGGYG+7Cb8irVE
         5xddzmZi+SQhjyF5aO3voCdSOFaD13tS7z3Fl4xauXrJK8eK2qzGELhW2YpgHaogfeaS
         cKdwie0MRrHkHVR/iqY/Fok9l7k2ebvRTQQ95eqJZ1JVT18YxkBjgRXtGUMf9YV2hw4L
         ofcwlIILP6YQyDPwrHVD/MQgEH9Z0BMJCn5MELqcY1MIlxLTdNH4K4dM5xiaGGmh11cC
         SjRTCDN1LfMh9W9vE/pufgOsxXovv+8zSAdJ4SbwRDGxll6NvmxTfMjHVurQDRn+i3j0
         k1jw==
X-Gm-Message-State: AOJu0YwR3Ts7XkuV7qYGJpu8UF1tN60yg9tEyvfUpRei5OLH04iGYzrG
	r81LJPW1Pd3IVg4SJkAR/vX/FrJ7CeMSrVYRrX/P/GhtksN8qXmNO9bP
X-Gm-Gg: ATEYQzy6R7ezkD49w08cttiWZJObq4520Zv/fER7m4JfztY8fv694eXRwmTluJ/X94b
	RF1UigNj2h0nyizVXcGxFVime4wY0Y5SOBgs0QAmQVGuZAnMTinmYv8kADbw5X4UWo5dmnvvf9r
	D61oBzWw2B5JlCPcX2CBDIWcOUBdE2YTbGV2mwYDxTX5HlcPtQrkABj5jQkaxVYtkjhyf7g3uxO
	LNjDMWc15ER1fbMLfnyRdQsnHvUsqZhFC1zvxTm33UciFbqTPx52jBZFe684XtsH2ODpOJwh2gL
	Lhk2O1queIQ+Rm4nuN2tWoKY/yaxHMy+prYzwFeCt62k68bmPVNptUgQ8P1VJWBivzwkNttDi/d
	DOcngTMTkr6Ep7s2wP6tjzZFJZAPKmkTy+v2eJLR+rl29XP1sEHG3qm7SfpmbfuhgRGiUhjIFz1
	GXx6LlyFCVyfaCCgkOXxB9KfNc+UWm7w9iBbidrZPrqwgsW+znIg==
X-Received: by 2002:a17:90b:390a:b0:359:8ef8:7a77 with SMTP id 98e67ed59e1d1-359a69ba1a1mr646963a91.9.1772594188387;
        Tue, 03 Mar 2026 19:16:28 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3ab946sm3610648a91.13.2026.03.03.19.16.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 19:16:27 -0800 (PST)
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
Subject: [PATCH v5 1/6] bpf: Introduce the bpf_list_del kfunc.
Date: Wed,  4 Mar 2026 11:16:01 +0800
Message-ID: <20260304031606.43884-2-pilgrimtao@gmail.com>
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
index 6eb6c82ed2ee..19d88da8e694 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2459,6 +2459,24 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
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
@@ -4545,6 +4563,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67c09b43a497..c9557d3fb8dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12461,6 +12461,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
@@ -12521,6 +12522,7 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
@@ -12996,6 +12998,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_back];
 }
@@ -13118,7 +13121,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
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

