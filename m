Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C63DA7CD
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309176; cv=none; b=l4B0ZUGVeGMhQaJU8tU1CR0ndM0OLh5OSDK0pp2qOJ14UiuuPlHNh9vNazYU16c2Ij9WEZsb9/mBBHXniRcC21SNgzrzYOw96P/2+K1qX0j/TA3cxVEK0sw6uY02DhxOQsdBdD2mQ6CT3XPIEGlxI8houShe0GK78vKi4aF4o8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309176; c=relaxed/simple;
	bh=MOXXlwv5+jPHoFenwU0Df/VSUFEVmpOCvtOJ2sq+C0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alZ9/hYvI3oLNxXVJdnZJGIKlKuYNHUnEi8Xou0Fh7sNzo0mkl0sqrlwcSJrQXquWddsnN8eIpICQV+8O0gR90v3TJoIHEC4zw3SaEldLXVQHTi5pEnsp7GIPinxZSVhUDVL21AEQJ7WuhUTK7ZP/Lxg6QyXU6s3W0g5H48k0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OKgnb+T5; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OKgnb+T5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777309168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpRvT4uR2xbcKg4iuq0VJjzAy9PY+FmlCoNRTQS6mc=;
	b=OKgnb+T5qr64syIE9uMG6QOu0GvbC7CxuSFC90rkxWZiOdcW632iaRirknfcSMHnZFjc+c
	Hg9mgPNGMhkvD1z9ay8Qk9ArTYzBFey+mIK2PfDI4ZgSvXz5smtBGXrYi5ESbkteKey50v
	7NKQ+OCFSoO49fKMzbHPg78zcg4r7xM=
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
Subject: [PATCH bpf-next v10 2/8] bpf: clear list node owner and unlink before drop
Date: Tue, 28 Apr 2026 00:59:00 +0800
Message-ID: <20260427165906.84420-3-kaitao.cheng@linux.dev>
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

