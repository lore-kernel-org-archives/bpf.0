Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743E3A8759
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634931; cv=none; b=eqhWtZ5eMxV73RRHnD5gEUsU4OO7KUskOmMw9/uIG8TdnV3iyrJIlcITm9G025xIw3uKWIMpa7Nf3XQRrlNEDtES2npyILcoOEy0opqoOK7EJJMRFNbBUXqollRSCDOyLWyghtVqbfIZFR6ycXvKRs0Xbu7+JpmqmDfLlrnGv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634931; c=relaxed/simple;
	bh=Ull5jkaPX/Z44Wt7wwTBgL+Vii3TF1svoGfJwvWXAXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGIs3+QRTlDTyKbR0Fb/RF4+P3rh8RE5L1DHjx4NBeF/NSE5b8vjgY1sE4NUTtL3SXsZsZpLt4NALh1S1558sN2GriyrHwDAy7yrmj6LKiZvAAPu8EKyeg9lvdtCQxcRPgyIKvHuidzn/naC+x05ikRVYZc7XRz5D+//lmo/fW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGNjQN6t; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGNjQN6t"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8296dabef74so876969b3a.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634929; x=1773239729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4THeY1nNZA8yDYT6Sd0Re4nLCMtXKkz6T4mk8ZpRgk=;
        b=SGNjQN6tYyTC789dvt6FNJ+P8y4kC//8MftbLk44RJVk+7Eb/KyXVTHghtW0IDGqtx
         /OUMJ9c+Gat9tC+NUiF6ZUtqj+q+EanQgFpo6Tf+kQrCSisgcsMcz+uaqOTHA5lSBHht
         BrcM9/86+1khuFCexAVELMq6ynisVxqip7E7gMTYSBsr1qCLxdpl6/3p75vrRT8dBIxr
         6yqyboQgd4fFT0CqA/zyeoVs4FpF0HXT6EEYros7DEfrK8nMZvBlCgMHEs2HhtT5XxT/
         hbHU9YDAmXJgAYygce7IKlDUlcmUxM7mbEkELAWi6wPYPcG8zhOelCn2v0a2nmVHMEEL
         ljlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634929; x=1773239729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4THeY1nNZA8yDYT6Sd0Re4nLCMtXKkz6T4mk8ZpRgk=;
        b=ADPxNXDmzbX+aHsmHFYrddeTrY//PrJbEf40SKQfOWKfs4sk+nQmzNMGBZP4CE4YO9
         SvpyfVJeocMlHog/dRa9lkPsPHE00WDtKKlVpXUxLepthZhb9s5M3CqMXWS/En3H3pvf
         rHH9K7FZDftyc3zDNAAE4CFD07nUtLvnar0jmDvJdnvJfrfvcf5+NhiuiMBFDcsXpU8K
         u0WsWgD6f2KGMSmVLnXBdHgIGJQPZF7JWxa3AGYg2WMyJwk2A+3aqF7DeYheiYHYN+f3
         hpTWL//c9qgWaN7HIj7eEbTQ718+/YoAe73bX0p0rLlhXYtGsClGduVir5oApagukClw
         IrTQ==
X-Gm-Message-State: AOJu0YwyNty6t5y5yz/rZa9vtlTh4oyt8IEIU7zdtnl92RapSsyOsWSp
	m1k53vQmWYpU4X2l2y5oImNcrYLCQhviQoQHsCafj3Q89W6VTIIgU2LD
X-Gm-Gg: ATEYQzyPXrhLwJvMTrOjdtCDacs9g54xpaK9lZluvTbFm511pvcHHB24QQNXorRfhWa
	lvZGS5rsV14flRvvchIpH6LUwMm+GpaL1hHgKOUZac6Meuf+/JEtbOhI8eVKVlxhEDPG70Rkxlb
	v3Io8WZltKsKdwyGZldkn+RHqGjPFqB+O2pzqrWaBuAfnRA7PjSOW7F0e5y9DKX8zw+GFRdGtjU
	O7CVCZKKZXaJg45zWLRF96FYmhLzjul4fIdH+6KZOddFSVEdufIxEMvdrqcc3xg9aVBncaGSDDD
	Ma3fCFAhjKfc1LUWMZN8GP0fL/TSoro57L8pvp8uFQpAlXecGn191we1b+BEJZlbWsv8pxv2Z0V
	pJllCZ7k8OWly2pPglLZoOQ36Z1aNQOv4EyeaVcQWQlA3YUCR6pgRnC3t6m6x78sHezs3sE96id
	IhJS7RWCTOcLbJQXLvmrxfm0fHYNV88+7iVhQXFauBa9j2iRh+KQFJzQ==
X-Received: by 2002:a05:6a00:3e02:b0:827:2792:e413 with SMTP id d2e1a72fcca58-82972a35181mr2405909b3a.17.1772634929419;
        Wed, 04 Mar 2026 06:35:29 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm18470184b3a.15.2026.03.04.06.35.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 06:35:29 -0800 (PST)
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
Subject: [PATCH v6 1/5] bpf: Introduce the bpf_list_del kfunc.
Date: Wed,  4 Mar 2026 22:34:55 +0800
Message-ID: <20260304143459.78059-2-pilgrimtao@gmail.com>
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

If a user holds ownership of a node in the middle of a list, they
can directly remove it from the list without strictly adhering to
deletion rules from the head or tail.

We have added an additional parameter bpf_list_head *head to
bpf_list_del, as the verifier requires the head parameter to
check whether the lock is being held.

This is typically paired with bpf_refcount. After calling
bpf_list_del, it is generally necessary to drop the reference to
the list node twice to prevent reference count leaks.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 27 +++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  6 +++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6eb6c82ed2ee..cc1a096a1f64 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2459,6 +2459,32 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, true);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+					       struct bpf_list_node *node)
+{
+	struct bpf_list_node_kern *knode = (struct bpf_list_node_kern *)node;
+	struct list_head *h = (void *)head;
+
+	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
+	 * called on its fields, so init here
+	 */
+	if (unlikely(!h->next)) {
+		INIT_LIST_HEAD(h);
+		return NULL;
+	}
+
+	if (unlikely(!knode))
+		return NULL;
+
+	if (WARN_ON_ONCE(READ_ONCE(knode->owner) != head))
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
@@ -4545,6 +4571,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
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

