Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979653DA5B5
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309177; cv=none; b=SZkkZkJTG4HMA3SdVD8LIWXsXnigOpTa2EFAt+o72yoZMKdxXd2l/qVeSZHcjNNsgzYp1vcbVE1bpj8dU685JZYN5r7nKApuPClglLEFW6A//Sdd6qoudSpO93GKgZPx1c3yHOZxfbS54Cab0rnYTu5VBaPVFUYkYvcxOEUdj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309177; c=relaxed/simple;
	bh=anDkAin6bRlzRMPVlynK7/7TJNEy5a/mdefQRK4EtCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIONGwDnK1yR58lpw9zUZRA4oEmGr+SD1MRawUzZB7bussCWF6p5Gie5vrxkf5EbhEIUqWkwlCZ6iW0z2nczhT49ZrSXYxOxfXx7VuAMJOB3oh8x9IMk2t26NC8oCEaCZUL27bpxvrk5HWNLnFx9VvUDMJtZJR2nn1B4iKeoL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GGXHLS5T; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GGXHLS5T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777309172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfDNacsy6+YXnBjKQmcVLo7bpaOxccX77oa8AMBMhws=;
	b=GGXHLS5TXucOhrenOIYkaGeOMCXp4O5iJufAwYC0x0xTZGdim/TGxbsJsknemUBVkzjqJ8
	kNkqvyorx3bYF51SMuDM8PTgMKzw/Trbn3VEkRoWApDvaMHXZA45kYpuJ18EUEBkRUGI/q
	9mbUKi5XudTuWjG1Qn18AWohvNilr2w=
From: Kaitao cheng <kaitao.cheng@linux.dev>
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
Subject: [PATCH bpf-next v10 3/8] bpf: Introduce the bpf_list_del kfunc.
Date: Tue, 28 Apr 2026 00:59:01 +0800
Message-ID: <20260427165906.84420-4-kaitao.cheng@linux.dev>
In-Reply-To: <20260427165906.84420-1-kaitao.cheng@linux.dev>
References: <20260427165906.84420-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Allow users to remove any node from a linked list.

We have added an additional parameter bpf_list_head *head to
bpf_list_del, as the verifier requires the head parameter to
check whether the lock is being held.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 10 ++++++++++
 kernel/bpf/verifier.c |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1e8754877dd1..51b6ea4bb8cb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2593,6 +2593,15 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, h->prev);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+					       struct bpf_list_node *node)
+{
+	struct bpf_list_node_kern *kn = (void *)node;
+
+	/* verifier guarantees node is a list node rather than list head */
+	return __bpf_list_del(head, &kn->list_head);
+}
+
 __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
 {
 	struct list_head *h = (struct list_head *)head;
@@ -4725,6 +4734,7 @@ BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03f9e16c2abe..3c0e0076bd69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10744,6 +10744,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
@@ -10812,6 +10813,7 @@ BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_push_back)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
@@ -11334,6 +11336,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	return is_bpf_list_push_kfunc(btf_id) ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_back];
 }
@@ -11456,7 +11459,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
-		ret = is_bpf_list_push_kfunc(kfunc_btf_id);
+		ret = is_bpf_list_push_kfunc(kfunc_btf_id) ||
+		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del];
 		break;
 	case BPF_RB_NODE:
 		ret = (is_bpf_rbtree_add_kfunc(kfunc_btf_id) ||
-- 
2.50.1 (Apple Git-155)

