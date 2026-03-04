Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF7364E9E
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594221; cv=none; b=PkTSV41HXWihW18DOjIz7fIH63sK6rJGFHnWsFDFcsUqNfF77F0lowj32JLK0T7plUusoOw+5vLKL2GsNKJ3LTr/gErb/B4YCBphkhYOMJVIiVuPb4QywweMJa9kIofvS1dQ83w5X2lSabRMioZrMJuLLfSRuTWddoi0VqD/WH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594221; c=relaxed/simple;
	bh=HopDCi0sbWCcdqt4Jw69CbirnGVcxekQLyoHw0pn5RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzjMDssuucUgh2D3bJzqTEVg5/VMPAFZA/fVOXfEHVkC4SoipgWD+3QYxmJnZ+fAKw5ffi19CLqnwjdcARV0uj1OSd8epiiRQrMukWZsrDBA0Nu/xl5FSbb90Wsh2NOiLpsulSS8U5Mn+npTRLhXoASbgc9HMmhtewwDlA8IWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+MNQdKV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+MNQdKV"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82746ed8cb1so3480924b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594219; x=1773199019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm2SHq3+Zj/eoKZLqHKZUZv1dCI3xGgt9SMEzJ+vyvQ=;
        b=G+MNQdKVI6841q7E075nTBz2/7n6dMzLG3QMHxNmlaAyzjzhiXrq/eHHvmSbMHvTVd
         EhU4zzxjlxOp/pNBTflxnjYFTG5GQurGVDskV1WSRxNlHeyadO3SjUU8oBT8fviD0SZ7
         IAbJ8KFa4eZ/XUl0VwZKK9HYYDeoNwCIyRXZgB6k+mtmV8uemjyBp/f/VdLyOlf5JeR0
         2PRs0wJ9PRXrFGWsICQdzhswGIy6m7u+YtARyLGRF/uxFcYsE5nxvs4cT6Y/2coOgQVR
         QtckOv0mRSeJsJOJimDTeUY1d4QDrlOW3mNGOFpgzu+1xnJz8boTNNPURIKSiygJ69I2
         Zttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594219; x=1773199019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hm2SHq3+Zj/eoKZLqHKZUZv1dCI3xGgt9SMEzJ+vyvQ=;
        b=ERKuP7PByac3XOGOGpvMm+gH+WOIxRcpg/C4EJHrcH6aglE6IsW6DxN/8nAuoNRm3u
         So4DGHXvK31N+uTHUd4U8Q8+GJlTpvfFaEDZVEmStBO+9ECNfnd/hMdW8KfkuUmg6ZLr
         fIFTS+q5j6Cs2xBNpkq33YJaNUSaffF/gdkECGvrloRzrTa5w2sreuTLME7k9D93dxXo
         ExlpLYgURudwPrUiiYTe2CN9UzdMLHkazcUB55PP5y+tG+n+5RH5PAozK8x7Oq6EvKrY
         JWsBXZ8fJQ8R0NI+UbEHq0r5Kj55jW1PZYBbnyvqIk+VCrym82bEsLUo1Jo2jLOn4hXP
         rb0Q==
X-Gm-Message-State: AOJu0YyLDSOwX6lrPoYiVwj6mk9UA2WcQqSEWWUXdNun8eqHDzDumPX8
	A20/VMGObFRlS8P7zVymckow9wg40OLdgbBxFQ3Chg2mSl5gEDIR74SU
X-Gm-Gg: ATEYQzwPX7hR0XJPCZMBoRMHEcjQFeOWtucwKp/rj3zzzwPxb+sV5XxhDhGqSWutpqz
	aj9SP8DHsSoOfBSRX6w5Q6fw135ex+bwgTAJ11ahwg9w5VEzJ5O/IvlRBiy7oMnxReaKFdYAaB8
	LRG1R+hvXVsBcPJtNxAkQezdB61LxRDMEFfyr4BJm5jWATu6L35z8lf995qKNijnsxb79vdEKsm
	AvKUWy2SWWCBtfX7LXMgxvR8hYAn3h/2x02oTRZptC6V42oB+3+zGa3JM+BFacEQ+K45Y+ReYgl
	SgDAY7z/l8aUzZIflNh/d9a61fLWVZxM93NZDxAVUeQQ2iWR42Fq2rCLVL7ysecpQeCk5WO9CGH
	vb21C8hD3hR/NZ98B+CKArWfynDZaXk9o5EqgJNH/SL+dThHQohRKkC2jU33xD+0A1/jjGa5Zje
	WJtiSgnhVzVWa0J2v8GMNbrNqGI8b9TKXXfik5PZGRs39R/RxN4g==
X-Received: by 2002:a05:6a21:b93:b0:38e:9938:9a80 with SMTP id adf61e73a8af0-3982e19b2d0mr492689637.47.1772594219037;
        Tue, 03 Mar 2026 19:16:59 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3ab946sm3610648a91.13.2026.03.03.19.16.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 19:16:58 -0800 (PST)
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
Subject: [PATCH v5 5/6] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Wed,  4 Mar 2026 11:16:05 +0800
Message-ID: <20260304031606.43884-6-pilgrimtao@gmail.com>
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
index 188840057c7d..2b9f30a36c63 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2521,6 +2521,44 @@ __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
 	return -EINVAL;
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
@@ -4591,6 +4629,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
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
index 197b972e79a2..e97c7e11bf65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12465,6 +12465,9 @@ enum special_kfunc_type {
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_list_add_impl,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12527,6 +12530,9 @@ BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_list_add_impl)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -13003,7 +13009,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
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
@@ -13126,7 +13135,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
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

