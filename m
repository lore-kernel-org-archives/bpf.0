Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18134383C7D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660587; cv=none; b=oGuecrDbe1QiRk/PCi0guKNFqaUDm0tLgGNYOkpmgAmJTZ8wGPZLR/CPaIo6r5vsf7Zbuz+CCQMJvQ4vXUg/5P06QOBPOYkks87NJxmlS5+pj9stERFFrpT2oSIBaUU28LT7y3tAWlqrbXX5yySewaABL4LSJpbhUx2vHEtQApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660587; c=relaxed/simple;
	bh=fkvvyCOJcW+OjU44LfyjgAgZvKAy8Us0SsZ8+/q2mLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3uaFyA2KuH9b5Y+Q0W64NwuVRp0iugViorn6VyRhgBw/9s//nN0fbS7AszKUfsjadXjz24b6ot79LjPTKWYw/nRtX5hpNx7Qas+KH4VR5BccGn2Snj/0ohz99kb6by05BSfvQWnEBeXrwM7sPC1SA267UXbiJyxLQUTJljDgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbBTNKaQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbBTNKaQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82984c077b2so2210463b3a.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660585; x=1774265385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XQhRYOi6IQvYzgEEWmUGpE0n+4jdX31PpEv2AHuppI=;
        b=CbBTNKaQjJnFYn+G6p1nEp1W2MVa6/LVBtq4TuSCCpIoshl9gCghe61/Dm6Uex6jKC
         tUTsRKOtd6/RRpP1PCKVDEOvaHtlvn+wwnXDbRB2MdMZbDs+fkdBkMa9IlwYlwSc3zxu
         L8B7AcuG3Hh86kGsGdYuALh+S6vLNJFh11GN1zmHJUeD4FmHX7N5fAUqq+sXES3iM3NU
         2DAVPXI4OodeKnl49g8wN3DVea/Ak1PWN16mQyOfdTyytOWjFtgkaYtzxp7DKBDNccpj
         YIjAVr8636+slQooj89QESuYXCRGpjZ00oZnQmzEyCxBGLDRMX89CObVC94xfnfW8/08
         peNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660585; x=1774265385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XQhRYOi6IQvYzgEEWmUGpE0n+4jdX31PpEv2AHuppI=;
        b=qc6xVWl9tnLuSIgJ6UUtk+xjhnNCALZr4eZfjPPflvq+RYXjZCrCYvqSzmlBRCsbBf
         tOmQsH6cAqZNOPtS/HuGUkFg48r3b4Vh9y65PZDCx2i8z0Rns8zyr3K4gXWlj3ox+NIi
         Lh7NAliz4UzGhWwOSKyuO7V15p8zEurRLH4SH3OsRr0OEkGLQws0TKdtHYGAc2vyuCKZ
         mE7kfdVe1rB31l4G6mJbHaKFYJUfnm23VT6/92IFXKGjXQ4mYAnAVvwVcPdEDYf+qEp3
         Y99fRILLog4mKmx825k5yo9XUVQH57ZgKDh7J/uKrN5IlkUe60u/SL0arv+pgT5MYFOE
         rVnA==
X-Gm-Message-State: AOJu0YyzzFKYulsepi9WTCnnkiwBhgg2CkpMMJK7Gfv4vXEmO2rMUmqD
	zg8l+1Hi0uajoIF1YjD/sw1D8z8y1yKkGNhkZGrixTKYv4LivwRQhMAs
X-Gm-Gg: ATEYQzw0WmZPWbyyXx+Kn7jx9pT50rTfcskJZiw7NxTY+D+IilrN/unw78weU2o5oRz
	K2oFkrQsmafEeqa/9erYu5lxLcLga4E1Jvb2RAC3TCnsIa6duzR/lhC/TCGAyJvRAyKL4Wlx57M
	6W6ssqUgdg2noeQfGsth//RVs/nFSvQVn9QVMR2v61WXFLdyJiCxjqcI+OSdOgKsHskKUXMU0w0
	DxGaXJSh+lqGTL5ELIep/ELj4NU45+Ilsv+6cv6c1zfvxEO/7eoGwqIoyqtH+IyrcJcKJ0xKVTx
	5opzZ6Z7Ha3ggrpJ6cXGjFEG1GsCwaNpphu+BhuLATQXQ3LDRluZjY/NoNMd3nlf0Q1bGwMoA0x
	0gubudog3Wmbi7kbdZV3LNIK2oSByHujHoctJE5tmrrczGzlWoVZGDVjf48GA+vPjAXfg2XOXfZ
	4vwDpvG13iNIwYs5Nm88pEA4GlttC6FDdffl7MBDgOzr69tbc5OjCGXbQ=
X-Received: by 2002:a05:6a21:494:b0:398:7d3e:95d7 with SMTP id adf61e73a8af0-398ecabc6e4mr11097936637.22.1773660585359;
        Mon, 16 Mar 2026 04:29:45 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.29.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:29:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 7/8] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Mon, 16 Mar 2026 19:28:42 +0800
Message-ID: <20260316112843.78657-8-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316112843.78657-1-pilgrimtao@gmail.com>
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
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

Currently, without these kfuncs, to implement the above functionality
it is necessary to first call bpf_list_pop_front/back to retrieve the
first or last node before checking whether the passed-in node was the
first or last one. After the check, the node had to be pushed back into
the list using bpf_list_push_front/back, which was very inefficient.

Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
check whether a node is the first, last, or whether the list is empty,
without having to first retrieve the node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 49 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dc4f8b4eec01..da70dcff4ba8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2518,6 +2518,41 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
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
@@ -4588,6 +4623,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
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
index 0a6f2e6a5d28..c2cc622bb3a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12512,6 +12512,9 @@ enum special_kfunc_type {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12574,6 +12577,9 @@ BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -12652,6 +12658,9 @@ static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 };
 
 /* Kfuncs that take a list node argument (bpf_list_node *). */
@@ -12660,6 +12669,8 @@ static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_add_impl,
 	KF_bpf_list_del,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
 };
 
 /* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
-- 
2.50.1 (Apple Git-155)

