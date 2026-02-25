Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B783115AF
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011714; cv=none; b=reTeqvi3/nCep3hQLOalVAZG4FYBRQAaaEUu7yK4mjRylg3W0zw5uQv/xyjjL6Zmxk9a5NIWyZdQt9ZIgdfdfs6/o/2Jsg7tw5LtVgLX63bBjhkUFdfMQlpLZlQED+8CfLpKW1t3CKr1NItMDJd5WcGsdJKOtsDlDKZF6h4ybDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011714; c=relaxed/simple;
	bh=MtGZ1s9d0Ohu8LVtS1x+dMK9rylCalqlFA6D7V3l7Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzb3sY+oBGWpOJCOJCzfokBgrhu/PkQAB5Oq1dWdozXWzSlmTzlDOKg7ed9SbXl+RZREUVlsF5alPbd/a4tLkKujNRL5wVJH2Wooh1tSY324b+9B7Y3IihJVjkTBmkxtFEgLBZ1UStUAY0QtoCu+iMBaKCnLZvM0P1Jn19xqNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ7vnRzM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ7vnRzM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so4011349a91.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011713; x=1772616513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcNjMPltPtLcCQ8lC4dQD+ECjUO8JYcdiEXegBoi6yA=;
        b=IJ7vnRzMWIosw+fn1X84Dv/FciYW0nbnyW6ij8AoUaJqLsFPG92mHyaYBSrkG6hd5w
         vNOxXanELbPPw1DqtHSirSc5LItDmpwXd2m0ukyx/LH8z4SW+Jdu1OzCTv0vvHzXQVZu
         btsSavK2hE10aN/jVxxMbk+S/gKqlooLnmRKcIufkn9C1tID7xJIGUDsGMBzd/BQUuLd
         jR7jYuV9Axjg2eZG9Gv3/3CRGrHCSZs6qzxEN82tcQr5ZKtziw2L0cohj3Cumu1dQSH+
         ADnYk+OgN11OVhZVOMrT2wVkfrOV3OeA/wZgkQu8qgbTRWOH0q5DR6eDiAqKhg+75ymW
         h5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011713; x=1772616513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcNjMPltPtLcCQ8lC4dQD+ECjUO8JYcdiEXegBoi6yA=;
        b=skjFLkREpRMBQhJ/LujU3Clx4qIKvNy8ukF1HNPhDTMuXDVz4W0D1zeXRw2uTvJmAO
         krQIiY6yBNn3JsD7NzYyqV+YBSO9j1mnJnZX1Ya+VSaQ9ZYcUnNmKwlPPgGlvQqezo9O
         o+HWcBVbnRuS+PkCGrkDqm73x71WOaVtGFml7mZjPhl3i1FeV00qIvz16ShCcGdSQqba
         NimNpjhBIJMIYWmBARfMdrDFotSug26XuIUd5CRTBCSk8yLgnKs+6n+yegvz5JqpeY+I
         vbzft/R7uh8bfoqFwqNbATFkM12qDfsEc5cB/2b7izQLmvEy7vpJ/Au9U4VfOCv65cL9
         KUiA==
X-Gm-Message-State: AOJu0YyjisShIW0mJqpKAWtbY1mUGRRr3U/8weBHXPj4YQBayMivW3KI
	YogC0QMh3bYYguGQvh/UWi8EDydsDfrs0k2gPhklBeUYOm4XAhpnOBXu
X-Gm-Gg: ATEYQzzhtHEW8QiXdcgRn6IVqvrf2dJ9fmlEP8GgBc/ixQz9tprlKOvjmuO3H825X10
	FkUPiU5SEOXQHR/Lo8Yec8sVtvbV9uP1LxxX0K0z1niIbrhTQebAyx/DCWCGBC1FRX/BjQgu34F
	k+MhQfi/oFUnEiAcTq2WFrvOWb9JmD2HCrnV0FYbYcQbwz89nLA4f87Rk7e42ktTIES2A3EvhNt
	isNO/4UF1HKuuVoxhWSHElXQNTxucvTItg+4/Lbz+CJDXx2xhTxxEbU1MVpFxp9Xes9oOuoQfDL
	QBbFMc8XdqvqUtiA2c3WAnm0rpLTMJdxy78dfsMh2d8+aVciTuwL/9M2vaHsA4uWhzZPiSkievp
	I0ZnbpGnsy/ndtg59HECYCoS5ZZgaAMDIxSpDgo1Wj+5W8cANC/yV0a8TpsC7iSLEufCH1OfnNe
	Np0HodGtxPpnD4IrENtqjjaSYkldCH7BRZzudU0GtQLxglaYjbMa7qR/8PcyHqrWnt
X-Received: by 2002:a17:90b:4c4f:b0:358:e7bc:429 with SMTP id 98e67ed59e1d1-358e7bc080bmr4543609a91.0.1772011712956;
        Wed, 25 Feb 2026 01:28:32 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f5f29fsm837901a91.1.2026.02.25.01.28.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 01:28:32 -0800 (PST)
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
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Wed, 25 Feb 2026 17:26:50 +0800
Message-ID: <20260225092651.94689-6-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225092651.94689-1-pilgrimtao@gmail.com>
References: <20260225092651.94689-1-pilgrimtao@gmail.com>
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
 kernel/bpf/helpers.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 15 +++++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d212962d4ed6..ada14eca58ab 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2528,6 +2528,44 @@ __bpf_kfunc int bpf_list_add_impl(struct bpf_list_node *prev,
 	return __bpf_list_add_after(p, n, meta ? meta->record : NULL, off);
 }
 
+__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
+
+	if (unlikely(!h->next) || list_empty(h))
+		return false;
+
+	if (READ_ONCE(n->owner) != head)
+		return false;
+
+	return h->next == &n->list_head;
+}
+
+__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
+
+	if (unlikely(!h->next) || list_empty(h))
+		return false;
+
+	if (READ_ONCE(n->owner) != head)
+		return false;
+
+	return h->prev == &n->list_head;
+}
+
+__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	if (unlikely(!h->next))
+		return true;
+
+	return list_empty(h);
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -4598,6 +4636,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
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
index 923deb73683b..149eac5f70e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12435,6 +12435,9 @@ enum special_kfunc_type {
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_list_add_impl,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12497,6 +12500,9 @@ BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_list_add_impl)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -12973,7 +12979,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
+	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_empty];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13096,7 +13105,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-- 
2.50.1 (Apple Git-155)

