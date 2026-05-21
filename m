Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE1383991
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333863; cv=none; b=AId7PCD2R8nl6OpzZF+UlHzFmuVHAl++2jE7cw9pfzSdK+9HCw/DMuWFcnYd/rb7jrkKhHZiAog1VWACaDrw3fDIhB7xWb26jbBxty/bGj5kvH9Y1DpsgdogimxTaitYi3wR5kwMJWDqdYgHKtTUl8xTfRCmfLS1++wqtQrzXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333863; c=relaxed/simple;
	bh=uTA/IPe0SD3xMXt47BGiypLhOKhs44rGXPEp3qX5o8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPBNWeN6PdXagpRHDjgAliKs6IAf4hlEpnnexJvn5tLAW2FxmSc1fqL+gDwo7SpRFR8nc2UZvqeXSryXcvA79hxOUo8FTRt0Dd9vWJQM9LU5KRzW98gcbgYB/yuSLRCY46H9JJ/b3RFZF05/6/ZCw3VH4CXU9Mxsnw3Sj+5tCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q/ziLl55; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q/ziLl55"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779333859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EibCAjpYj8bsk5BcAAI7Zy4bc3E7PcZnr8SoDxq6ulc=;
	b=Q/ziLl55fMtz/TMzFoyk3a5EKDsGd1AFw0qH2POzV2eSOrImf4X0GLOIm43dLqybdwmCpb
	ZaMtCgS18bdvI4cQNslKfpVWPtOnV4t+ZAFqgSJPmkuIxtjiWUZDFscvgBo3BUuO+tUl2K
	rlJTfCBY4YPbTThDHShQgdBQ6NI279Q=
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
Subject: [PATCH bpf-next v11 2/8] bpf: clear list node owner and unlink before drop
Date: Thu, 21 May 2026 11:23:00 +0800
Message-ID: <20260521032306.97118-3-kaitao.cheng@linux.dev>
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

The issue only becomes exposed once bpf_list_del() is available: callers
can pass an arbitrary bpf_list_head and bpf_list_node pair, including
nodes that are not actually linked to the supplied head, or nodes that
outlive their original head after refcount-based retention.  This was
not practically reachable for callers restricted to pop-style helpers
alone; bpf_list_del() widens the API surface.

A failure mode appears when bpf_list_head_free() runs while a program
still holds an independent refcount on a node (for example via
bpf_refcount_acquire()).  The list head value embedded in map memory can
go away while the node object survives.  If node->owner is left pointing
at the old head address until drop completes, that pointer becomes stale.
If a new bpf_list_head is later allocated at the same address and the
stale node is passed to bpf_list_del(), the owner comparison can succeed
even though the node is not really linked to the new head, and
list_del_init() will follow bogus next/prev pointers with the risk of
memory corruption.

When draining a bpf_list_head, mark each node owner with BPF_PTR_POISON
under the map spinlock while moving it to a private drain list, then
list_del_init() the node and clear owner to NULL before calling
__bpf_obj_drop_impl().  Concurrent readers therefore never observe a
node that appears linked to a head while its list_head is inconsistent,
and surviving refcounted nodes never retain a stale non-NULL owner.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 094457c3e6d3..59855b434f0b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2247,10 +2247,11 @@ EXPORT_SYMBOL_GPL(bpf_base_func_proto);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
 {
-	struct list_head *head = list_head, *orig_head = list_head;
+	struct list_head *head = list_head, drain, *pos, *n;
 
 	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
 	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
+	INIT_LIST_HEAD(&drain);
 
 	/* Do the actual list draining outside the lock to not hold the lock for
 	 * too long, and also prevent deadlocks if tracing programs end up
@@ -2261,20 +2262,30 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	__bpf_spin_lock_irqsave(spin_lock);
 	if (!head->next || list_empty(head))
 		goto unlock;
-	head = head->next;
+	list_for_each_safe(pos, n, head) {
+		struct bpf_list_node_kern *node;
+
+		node = container_of(pos, struct bpf_list_node_kern, list_head);
+		WRITE_ONCE(node->owner, BPF_PTR_POISON);
+		list_move_tail(pos, &drain);
+	}
 unlock:
-	INIT_LIST_HEAD(orig_head);
+	INIT_LIST_HEAD(head);
 	__bpf_spin_unlock_irqrestore(spin_lock);
 
-	while (head != orig_head) {
-		void *obj = head;
+	while (!list_empty(&drain)) {
+		struct bpf_list_node_kern *node;
 
-		obj -= field->graph_root.node_offset;
-		head = head->next;
+		pos = drain.next;
+		node = container_of(pos, struct bpf_list_node_kern, list_head);
+		list_del_init(pos);
+		/* Ensure __bpf_list_add() sees the node as unlinked. */
+		smp_store_release(&node->owner, NULL);
 		/* The contained type can also have resources, including a
 		 * bpf_list_head which needs to be freed.
 		 */
-		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
+		__bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
+				    field->graph_root.value_rec, false);
 	}
 }
 
-- 
2.50.1 (Apple Git-155)

