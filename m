Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC035BDC2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545968; cv=none; b=DkVPQwujxBkQaiCugifSQLfygumy3KsezKL3x6qBC1YF9t/xp46jFACK2WrnOYG+Hf7k9DZJH10MsdRSXkwUuC0w2eOkE9opmz5HKcNcLW7SYS9/hDaUHTREbS/L38xyc3gI9L2ddG18RWdR7Z1fg+iGsZMEibn7e9b78YtLpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545968; c=relaxed/simple;
	bh=bXOZyfrjjEJNg2zXkkRsWg+H9U/k/NIMjxFzOVXWV+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcqszRvlHt2GpElsXZ+MNnbgWIUm6ixe996RvDzLr9A79bSExjBWRur+a22dIkqi0zwVV6/SCp9FbDJyn9y1Hjj4vIdlVC4J7p7d2BX+Vhv+vzsQD5gXb3oqnAl5n3k9HzBuu/wyNcA7vQVLeUrDslUdZUDbJh3Z5K8pTAwJNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izg8TOLB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izg8TOLB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8274936d2c0so5584209b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 05:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772545966; x=1773150766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5WORjt7SxVQlhYT/6rzYEp8dt5s0cz4VVG01wwIAJ8=;
        b=izg8TOLB1yNjkO5NJ3g2uyGdEc0fIY3Giyvue25EIY/pftojzqi7WrKFao3DXMwX/8
         sX7sUn9Ktm6wa7s0qPDrR3S+A6qqfH02L039X5VFNkTwbwDmNGlOCjy8Ef4t7FdrWb0R
         YyxFvRw1Pw1Eo3Y98bPYQ8MHBRBoC0cYn5PtAjIIl1fJ3HwjIaL8vin3cybo9GgCCGr9
         neWQNP8Bom80TpCfTbcN5TFem4x5MOXA5RkT09J5XTpm343ATOzV52ZnUL72GA7tsEf9
         1GeztXCc109EglgOOHhKMiC3FWlF0FiQHFA2szCLXFBSTULq3IspBhcGlsv1DsvM3CXv
         cgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545966; x=1773150766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5WORjt7SxVQlhYT/6rzYEp8dt5s0cz4VVG01wwIAJ8=;
        b=efVJRiZsXhvVbBh8a/fK/qtqTIVYJcbPLrEVzMZ+d16A+wonEP8DOi/greWuS0+bRM
         oF1WVTnYtvZYD2oIBtF4Qznty8Q940aNUuKRQMpX16ihS75zBdquKcf2hipRlZY4djNw
         xcaL2an4Qcq/m0rpBT/O3Z++N9sYQExzzxUZhmMi9BFIyPyxenE9yj7sWOWoy+BYpBzR
         WdSwBR+gzWVKvuZIQo69dpFoKRZC8rpISbOsGzQed99nX6HnYgkEKS2MLCqnsZj5I5oV
         C2z51tA7wnPdOsvNVqKR8RdPaklsEuuWR6fkHQWAbDm3onPKu/t6AozFt4zGxTrYGKF0
         zonQ==
X-Gm-Message-State: AOJu0YzXJ2N1LzM1NvMp/TEZPcZzX6C+AbYOUWZGrxT+YF+0y323y35E
	CjO4nktfZrqxUb4/V75onSguHzrNv0wOtJGWOyumZokKi7dwqtI04uOZ
X-Gm-Gg: ATEYQzymC6KfY1GogAOO72ne4Co7Me3jxd3MgiSdVvqELD20/rUCxUIwO2pzEu0Sq/s
	wmiGj8Oit/GurseIyygnQISYciOjSxer0yT75S/iSB+WYVw6rZTf5L67IZd9+U6eUpN3gFsOFCc
	neExeV2nGSRRpBgAv55+ZQxC/PKy2CPmr9z3EwAtxw1eYypQBBv+2tP08UMi1QfWI3DvkUjavNm
	Avnl+hVqFGGxBMPwY7IXbSwj0L0fBXxmKa9WkbkTXgVNl9bUneH7BwGvcVrkSfP3cj5hYzarQis
	q/L9E/xtfudTKVYXmr1+tmdp//PJ9fmtKN/W/4OxUhdfbyZ8ULuXJmX2rNmEGR9E9nAGUapqBJA
	OoZ+iSp9vVJAbYLYx86p3zSkrzAzjwMv1wACFCgEbRSlB+blHbwbmiP+xiy17z6afCqT5I/idid
	frEuvw5Vtkrwd8CbZVGAI8y4qsuj3vG0m6bbS5U8L+8tZ5fKDh
X-Received: by 2002:a05:6a21:140a:b0:395:6f58:d4b7 with SMTP id adf61e73a8af0-395c3a0cbafmr15399033637.6.1772545966299;
        Tue, 03 Mar 2026 05:52:46 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm14689782a12.12.2026.03.03.05.52.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 05:52:46 -0800 (PST)
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
Subject: [PATCH v4 1/6] bpf: Introduce the bpf_list_del kfunc.
Date: Tue,  3 Mar 2026 21:52:14 +0800
Message-ID: <20260303135219.33726-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303135219.33726-1-pilgrimtao@gmail.com>
References: <20260303135219.33726-1-pilgrimtao@gmail.com>
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

