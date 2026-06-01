Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4633AD8B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293616; cv=none; b=Gcm53BJEgNX/6P0nt1ZdfFq+feubAdSvHM/K+mNdbF+Y2z1+SnWk5DHQNIJehF3ejIUh4UHgaDEVnc+h75gMAwjwKSXx6xiiXighR9y9R68qDS1cW6uU0J73G4JxVcnizoVmQWxpRhfqMNlANz1i6ckmfCX0/baVnOMO/geAqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293616; c=relaxed/simple;
	bh=A+Svop1WbGg8udynMIsxYtQ04wconwHBbQRfvhRa6Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1BHYsZlXLEGu+n49qsu/hekaDW9YVfvbVlShB3dIgYDyIbnF1djiQhm5slDW3xAh6W10P7iYdq10lfH4n1GLFpelNxgiZBFl3SxJUbLUP4xhh+qlahsblawQpnOSKVXiFiZGDQZgObmGgx40ho5VCJ1ohqv2QBSW6A0LoHlb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k4bgqDmn; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k4bgqDmn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780293612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x4X+1gWL0rPvVealw38HfzYWoLJPBBMtcyi5CBs/yEs=;
	b=k4bgqDmn+3hGU2Vrz20IKePtNdFirBG8aivhIQ2r4CGeFvdyqbPOWJRUojERuvpQxTBn+W
	NVSsWLXL+e2eo3XDIZehm/0H9av6vO2IIGDzhagJS4Qzxu3uicoOPudlz72w3Bz2x7Zs2Q
	0URBm7dYSFs3mpfil2Lb0AZ4ngOO5D0=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org
Cc: davemarchevsky@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH] bpf: Clear rb node linkage when freeing bpf_rb_root
Date: Mon,  1 Jun 2026 13:58:59 +0800
Message-ID: <20260601055859.13888-1-kaitao.cheng@linux.dev>
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
---
 kernel/bpf/helpers.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9ca195104667..46e8eada463b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2307,22 +2307,30 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 {
 	struct rb_root_cached orig_root, *root = rb_root;
 	struct rb_node *pos, *n;
-	void *obj;
 
 	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
 	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
 
 	__bpf_spin_lock_irqsave(spin_lock);
 	orig_root = *root;
+	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
+		struct bpf_rb_node_kern *node;
+
+		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
+		WRITE_ONCE(node->owner, BPF_PTR_POISON);
+	}
 	*root = RB_ROOT_CACHED;
 	__bpf_spin_unlock_irqrestore(spin_lock);
 
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
-		obj = pos;
-		obj -= field->graph_root.node_offset;
+		struct bpf_rb_node_kern *node;
 
-
-		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
+		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
+		RB_CLEAR_NODE(pos);
+		/* Ensure __bpf_rbtree_add() sees the node as unlinked. */
+		smp_store_release(&node->owner, NULL);
+		__bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
+				    field->graph_root.value_rec, false);
 	}
 }
 
-- 
2.50.1 (Apple Git-155)

