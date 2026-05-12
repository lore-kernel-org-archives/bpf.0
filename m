Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BC40FD98
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565619; cv=none; b=AyLg2TFLbh0sJPg+DvZ3R1nJU6nsp0LmyIgWMaP39wb6BoFSjoipdPmdWir+ezjptmzEK8JGORybnD5mIeMpGsqiB6plpqSqHvS2CFHYaYGGs53OMATxGeqBccLldXcrfd/PdWFl9JLI1ueDELoYo58yiq95Fo7v9YqY907q2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565619; c=relaxed/simple;
	bh=/muV6dCbtwkyaf+jEkinQUctflZqYwvGPQ4RwozJAdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfQwp1MToF6RDLqIb06j589q/tvS31OI5LYaF1x2Uv6E/QtkjMmtaeghVTv9jbpFD5/qNELdp2d0NQ27EhLffr4fn/zJZ1v1Y4WGYWozvV8B7BZD0cVkp44SH6Y2R7dC35qPrVikCJnCumj/fL2mjvQFTL0e8r3KpIkk4tXle4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=joCiE6Ir; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="joCiE6Ir"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778565596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qshHdS20MoOXvQLCKPvaR8JOP07zv3n46ucSvb4Lric=;
	b=joCiE6IrlOavpz3M7en68uslNinXVdSR6G0kolQQD/1WUpDmH85CD7SviQ5xkejiO+xWXt
	9e86pk2H5wz4NwINnY8pXQcVZzJTTaeRRLFOxujcgqfFGVaH/R8uolgebT0mYVRlv5a9cH
	bapHdHwfgsAfMS8NmEVAU9jiQr7XcQI=
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND bpf-next v10 4/8] bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
Date: Tue, 12 May 2026 13:59:15 +0800
Message-ID: <20260512055919.95716-5-kaitao.cheng@linux.dev>
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

