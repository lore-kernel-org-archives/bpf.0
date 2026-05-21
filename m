Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BA384CEF
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333879; cv=none; b=Kq0k553bH85rtqANxPQk28W9YPzzU67fGLnYpolKulPGgdoDT/az+M+lbBpgmsnqIGKeF0fDnOwnLqtYct00KFNEDHdDHp1FDgBmhWJJ4DnM9pZ491x04KmL7ujgiIe3dSp1kj+qN2wSwusI+JEaD4s5DWsNE2n9FsLNOapJKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333879; c=relaxed/simple;
	bh=4MLpMmMkk6Xzy1pnGdy9h6hh38Q7yAzgn2oOXx8QzAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxeIlEfdcGi7+C8jfMyjVCw60vdXw8C9LT4smAL393BN/+cmXZu8OCyfphAsduACYIJWFty4yBT13dGXzG2svbte4hgI+ILzwCwj10RbJ3A+J9bMMz2IGoeVfywbO0QxSHUcg9cUTSXXxEI5kxyMwjrq85mRkyy/WryalnQz3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a3/I3SfI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a3/I3SfI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779333875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=At1YoeTWsHYJviBgCEh2Fe6MhwIuuXtFcpxRcZ3B/SU=;
	b=a3/I3SfIMisI/oV28rLOvjp+HhBtGMNyeLx1zuCo9a92qdeuSmCrGMZdD+Bziqd2mh2GJT
	KTFunknuAFHgs2fdLv5kvggxQGcg/d4mkkteAFzTvqHDQgFRh6DJcFfKto5MSFmiturYbw
	2F/4DJ/XthM42zgXLmiig8L+HSyvOSY=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v11 5/8] bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
Date: Thu, 21 May 2026 11:23:03 +0800
Message-ID: <20260521032306.97118-6-kaitao.cheng@linux.dev>
In-Reply-To: <20260521032306.97118-1-kaitao.cheng@linux.dev>
References: <20260521032306.97118-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Refactor __bpf_list_add to accept (node, head, struct list_head **prev_ptr,
..) instead of (node, head, bool tail, ..). Load prev from *prev_ptr after
INIT_LIST_HEAD(h), so we never dereference an uninitialized h->prev when
head was 0-initialized (e.g. push_back passes &h->prev).

When prev is not the list head, validate that prev is in the list via
its owner.

Prepares for bpf_list_add(head, new, prev, ..) to insert after a given
list node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 804c201c28f3..1c69476c8a09 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2478,9 +2478,11 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
 
 static int __bpf_list_add(struct bpf_list_node_kern *node,
 			  struct bpf_list_head *head,
-			  bool tail, struct btf_record *rec, u64 off)
+			  struct list_head **prev_ptr,
+			  struct btf_record *rec, u64 off)
 {
 	struct list_head *n = &node->list_head, *h = (void *)head;
+	struct list_head *prev;
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -2488,19 +2490,31 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
 
+	prev = *prev_ptr;
+
+	/* When prev is not the list head, it must be a node in this list. */
+	if (prev != h) {
+		struct bpf_list_node_kern *prev_kn =
+			container_of(prev, struct bpf_list_node_kern, list_head);
+
+		if (unlikely(READ_ONCE(prev_kn->owner) != head))
+			goto fail;
+	}
+
 	/* node->owner != NULL implies !list_empty(n), no need to separately
 	 * check the latter
 	 */
-	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
-		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl((void *)n - off, rec, false);
-		return -EINVAL;
-	}
+	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON))
+		goto fail;
 
-	tail ? list_add_tail(n, h) : list_add(n, h);
+	list_add(n, prev);
 	WRITE_ONCE(node->owner, head);
-
 	return 0;
+
+fail:
+	/* Only called from BPF prog, no need to migrate_disable */
+	__bpf_obj_drop_impl((void *)n - off, rec, false);
+	return -EINVAL;
 }
 
 /**
@@ -2521,8 +2535,9 @@ __bpf_kfunc int bpf_list_push_front(struct bpf_list_head *head,
 				    u64 off)
 {
 	struct bpf_list_node_kern *n = (void *)node;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
+	return __bpf_list_add(n, head, &h, meta ? meta->record : NULL, off);
 }
 
 __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
@@ -2550,8 +2565,9 @@ __bpf_kfunc int bpf_list_push_back(struct bpf_list_head *head,
 				   u64 off)
 {
 	struct bpf_list_node_kern *n = (void *)node;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
+	return __bpf_list_add(n, head, &h->prev, meta ? meta->record : NULL, off);
 }
 
 __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
-- 
2.50.1 (Apple Git-155)

