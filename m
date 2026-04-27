Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDB315D43
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309184; cv=none; b=rCMw7Q5uKVYlyJSj+GdLH3/r340FO6SPevBhPtGt6diVphQym66x0nMpClUhEi3FNJrPF6ZWebaYNiaRURXwhX8XpUxdgbUM6FgfdfKUumjv/7S5uzesg7TJbR6rfj0gG4I6LWysSo+snezKLHmmozTiNW/eqC/CHfwJEuHJ95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309184; c=relaxed/simple;
	bh=/muV6dCbtwkyaf+jEkinQUctflZqYwvGPQ4RwozJAdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6q8bqsCj+dBOSHo2uG24kyR6XmKb0gJFrwOEDOMk9NXngc6jg9gOdMH18v0c1UnjYWHc1adj7YFyvlrik9P1G4ZyNRsPtBaevYfXTN+0mwLlsFjTfz+k4Cp5AuUQyt+xAFdArEata0/Lmt2vNE+/BmwNQL1HzhEUid1x75D4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oDVD3+3s; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oDVD3+3s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777309177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qshHdS20MoOXvQLCKPvaR8JOP07zv3n46ucSvb4Lric=;
	b=oDVD3+3smQUJcS9Dsi6HZWdQcNHa9nZ0Vwe/QhgM28uKbXkzNDuaXnFBeELRKTjIkiOTnX
	DRQpk8wUrLAti/t/OdinrdeHQZEnDd79LUgVteIqGU2dZo7tT3tkRXU+bjJ9oUBWoSqaLF
	GV0/30NGQsg4cBxxP+6D8/7PxgCfojo=
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
Subject: [PATCH bpf-next v10 4/8] bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
Date: Tue, 28 Apr 2026 00:59:02 +0800
Message-ID: <20260427165906.84420-5-kaitao.cheng@linux.dev>
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

Refactor __bpf_list_add to accept (node, head, struct list_head **prev_ptr,
..) instead of (node, head, bool tail, ..). Load prev from *prev_ptr after
INIT_LIST_HEAD(h), so we never dereference an uninitialized h->prev when
head was 0-initialized (e.g. push_back passes &h->prev).

When prev is not the list head, validate that prev is in the list via
its owner.

Prepares for bpf_list_add(head, new, prev, ..) to insert after a given
list node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 51b6ea4bb8cb..5388078f3171 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2471,9 +2471,11 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
 
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
@@ -2481,19 +2483,31 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
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
@@ -2514,8 +2528,9 @@ __bpf_kfunc int bpf_list_push_front(struct bpf_list_head *head,
 				    u64 off)
 {
 	struct bpf_list_node_kern *n = (void *)node;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
+	return __bpf_list_add(n, head, &h, meta ? meta->record : NULL, off);
 }
 
 __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
@@ -2543,8 +2558,9 @@ __bpf_kfunc int bpf_list_push_back(struct bpf_list_head *head,
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

