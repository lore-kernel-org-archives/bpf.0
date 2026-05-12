Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE63406268
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565624; cv=none; b=ajP0P0POxnUXwRLzSi5dHH4k4i9I1zHkspBovkzQh15RO/oE1zgVF0YfHXm5Qd52HVJd5UYhPsj+QPHiPtyGFvvZtes9hNmiD3kQJOwgJ1Sn91ZlkqnPFuMXDSIgi45Juyvc/E1hE0NFTcga550b5SLmjXevMT0mLck8CCEOPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565624; c=relaxed/simple;
	bh=BE+YmEUt2JlQE2gs3eOXXlXi3+oQVNhffbC4hhexUgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTBMv8+qtiDkPKrJjl0kz93IPJwHnMXDiNdE+X2Z5cLES0Pt4/SXZhhNW6hFSQwhcX5jtewLdoLuM4faTuXXV6geufI6KHUUmUC6S7HqL6IyIO9rBWQAiwR0Nd8V3rRIRfFbvecMQLACXUB/m/gjFJfSCcWQkk/POL8rMbhWhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fBesmGYR; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fBesmGYR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778565606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viZAzy5wHOfBg6qG2TFSvCcCTYkJmVz3UMaSUgtttXI=;
	b=fBesmGYRsFxpoMwMuWmpFQwBVWnOuSzq3/u3hSl5CBAWP0dcnJZn4PtAAx9yT1lZsBlmLt
	zJ7THcDjat7AEVuo50SEiVIsGM6y956cG4tyVPB4Ze2Hb9RobkQRJHw9J8CpojNkwLobRn
	NWN2cW3T5VqnRNbtRdiI2oR/B7nWGqg=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: ast@kernel.org,
	corbet@lwn.net,
	martin.lau@linux.dev,
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
	skhan@linuxfoundation.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	vmalik@redhat.com,
	linux-kselftest@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH RESEND bpf-next v10 6/8] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Tue, 12 May 2026 13:59:17 +0800
Message-ID: <20260512055919.95716-7-kaitao.cheng@linux.dev>
In-Reply-To: <20260512055919.95716-1-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/helpers.c  | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 15 +++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2b8e8d4284a5..dfd465badd9d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2648,6 +2648,41 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
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
@@ -4764,6 +4799,9 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_is_first)
+BTF_ID_FLAGS(func, bpf_list_is_last)
+BTF_ID_FLAGS(func, bpf_list_empty)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 50f8732aa065..ca33f35bc3eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10748,6 +10748,9 @@ enum special_kfunc_type {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -10818,6 +10821,9 @@ BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -11341,7 +11347,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
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
@@ -11463,7 +11472,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
 		ret = is_bpf_list_push_kfunc(kfunc_btf_id) ||
-		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del];
+		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
+		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
+		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last];
 		break;
 	case BPF_RB_NODE:
 		ret = (is_bpf_rbtree_add_kfunc(kfunc_btf_id) ||
-- 
2.50.1 (Apple Git-155)

