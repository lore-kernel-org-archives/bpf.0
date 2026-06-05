Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D53B71DA
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652576; cv=none; b=Ubc/qo6U0xlDXuJpOtFQ1oaXYlouLFONjgQQZCR4NEwo1GgacBgVOjLyUgYKVncaOoWk8rOjHqOf+gi2nbzpiHM33KpPd5bIZ+vScGieNfJ3/U+Oew56FRimw8fNIHHws70ZNAkNo7y0Q2p4V456+UcntfTWF2GwYHmP5IXKA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652576; c=relaxed/simple;
	bh=fJ220f+Er87zRDfl8LDmOFgfo2otqq/56IiqC/NOZjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ud/onToUwZLZfZWUi0WuVcGJE5rVN6ylIobhoxrv5G/8/sTPtjdT5s2ebnRZ/uz9W/Ke6zhVoUkxE91ZtmrNcvmwAe0p9GvkQ0PcaxhoBwQSGE0k53P3lP9q7LdLc92K0oxaVVAyKu2RoMfXZ3xhnmoI947aSjC3DwTC3T8Wd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ku9sREOU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ku9sREOU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780652562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tcbI5oMdHfrZMmfJmEO2u5fdYdlkgLeMh+rHDAyJk7o=;
	b=ku9sREOU0m/e17nrxJ/Hw9MhGNwZ6UdX7bI9Hr7iE2VqZ4Ch8201C52ZCx3e3B9Eyk62Qk
	rVmnIS3+v3YumOiTyae/Lv4+t0HnAiMiReVwXlG3Qk/686zi6i5YF3q4esT+3XJEzx5S15
	popexIu0IJ2lLHWAkym6s61Etxpbzx4=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaitao.cheng@linux.dev,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next v2] bpf: Clear rb node linkage when freeing bpf_rb_root
Date: Fri,  5 Jun 2026 17:41:43 +0800
Message-ID: <20260605094143.5509-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf_rb_root_free() detaches the root by copying the current rb_root_cached
and then replacing the live root with RB_ROOT_CACHED. It then walks the
copied root and drops each object contained in the tree.

This leaves the rb node state intact while dropping the object. If the
object is refcounted and survives the drop, its bpf_rb_node_kern still
contains an owner pointer to the freed root and stale rb tree linkage. If
a later bpf_rb_root allocation reuses the same address, bpf_rbtree_remove()
can incorrectly pass the owner check and call rb_erase_cached() on a node
whose rb pointers belong to the old tree.

Mirror the list draining behavior by marking nodes as busy while the root
is being detached, then clear the rb node and release the owner before
dropping the containing object. This makes surviving nodes unowned and
safe to reject from remove or accept for a later add.

Fixes: 9c395c1b99bd ("bpf: Add basic bpf_rb_{root,node} support")
Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
Changes in v2:
 - Use [PATCH bpf-next] tag
 - Minimized code churn

Link to v1:
https://lore.kernel.org/all/20260601055859.13888-1-kaitao.cheng@linux.dev/

---
 kernel/bpf/helpers.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 03004e4451f5..8ba2b8965caf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2306,6 +2306,7 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 		      struct bpf_spin_lock *spin_lock)
 {
 	struct rb_root_cached orig_root, *root = rb_root;
+	struct bpf_rb_node_kern *node;
 	struct rb_node *pos, *n;
 	void *obj;
 
@@ -2314,14 +2315,20 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 	__bpf_spin_lock_irqsave(spin_lock);
 	orig_root = *root;
+	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
+		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
+		WRITE_ONCE(node->owner, BPF_PTR_POISON);
+	}
 	*root = RB_ROOT_CACHED;
 	__bpf_spin_unlock_irqrestore(spin_lock);
 
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
 		obj = pos;
 		obj -= field->graph_root.node_offset;
-
-
+		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
+		RB_CLEAR_NODE(pos);
+		/* Ensure __bpf_rbtree_add() sees the node as unlinked. */
+		smp_store_release(&node->owner, NULL);
 		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
 	}
 }
-- 
2.50.1 (Apple Git-155)

