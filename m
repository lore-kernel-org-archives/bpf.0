Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8A406290
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565603; cv=none; b=dirOcudhfaLKo/w5KDTQawg5VTYKK4EsqSikjNoqVtrjoxAalN8ZeqlKmTMufHbvI4CtYXGEY9aqwlLaJ8Vv2IV1zJcTs/Ex1Epo+XoZwhn8+41uiCflpRry4bJ85GfPaYBK3aMm0n9Cfux5dgap3BQpT3sQ7/GIAJ/fCVrLN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565603; c=relaxed/simple;
	bh=MOXXlwv5+jPHoFenwU0Df/VSUFEVmpOCvtOJ2sq+C0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEI6oPL9/8KczhRcpyNlI1ua9KFxxQ8bfVZexdcdMMrXoI+kDSSIe9XNC8nnVjc4TJN5cBqnPC6wmDwwy0MzUPscLt4YYR1A0J6/etOhDm+Ucjy/upwzf9XBWwult7WvsULtuSKG0z1ng15qkkLobMXWkseNnSl6Y+LsM/4K1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6Atz+E7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6Atz+E7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778565586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpRvT4uR2xbcKg4iuq0VJjzAy9PY+FmlCoNRTQS6mc=;
	b=D6Atz+E72y/TXC6e0lOQNHzZwA2GKySFNMXqOoxxsTalmaRRb0Ebs3KjT+0Zl/44bS4YSh
	u81afk/E93ByxiZPD1PtcG25NheEezEMAo9mbG4EN0dRESz3IeAjIYSoB4Y0G5481LEjn4
	Tf/ebBXaRcxFGUHeSh8AQduJilv+s8k=
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
Subject: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and unlink before drop
Date: Tue, 12 May 2026 13:59:13 +0800
Message-ID: <20260512055919.95716-3-kaitao.cheng@linux.dev>
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

When draining a BPF list_head, clear each node's owner pointer while still
holding the spinlock, so concurrent readers always see a consistent owner.

Delink each node with list_del_init() before calling __bpf_obj_drop_impl(),
preventing subsequent users who hold a reference count to the node from
acquiring an invalid next node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9cd7b028592c..1e8754877dd1 100644
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
@@ -2261,20 +2262,23 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	__bpf_spin_lock_irqsave(spin_lock);
 	if (!head->next || list_empty(head))
 		goto unlock;
-	head = head->next;
+	list_for_each_safe(pos, n, head) {
+		WRITE_ONCE(container_of(pos,
+			struct bpf_list_node_kern, list_head)->owner, NULL);
+		list_move_tail(pos, &drain);
+	}
 unlock:
-	INIT_LIST_HEAD(orig_head);
+	INIT_LIST_HEAD(head);
 	__bpf_spin_unlock_irqrestore(spin_lock);
 
-	while (head != orig_head) {
-		void *obj = head;
-
-		obj -= field->graph_root.node_offset;
-		head = head->next;
+	while (!list_empty(&drain)) {
+		pos = drain.next;
+		list_del_init(pos);
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

