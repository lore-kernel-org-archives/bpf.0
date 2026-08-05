Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808338E8A7
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902712; cv=none; b=EqJb3m4jy8X1MwzKevS2pBlgcRTaCHucchIhgnTeqM+FMXW7jljd75BLZ2nmjlmvjvlrvZMdIZFQrKdCu78Gl9WIwjebgesT/k8Gd7BmQJ7YTBflYTgvoOrH6h43FIpnQB/P4xnG7vavlSi6NB1UZD1S0Y9x8GqoqBkKuvYqinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902712; c=relaxed/simple;
	bh=h7uAGJBjtGoS/ep5Zzp6kY2tjC6QbsXh10qEgOILh0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1w+x4OuHw7WJcR8yLfcxVTt6ZR+I5g3FQDS7/EAYcI2cfPnYZBl5Nq2w0g87sSxsJEwujTYr/0lJ+Ee4A+0YjubtSnityvihuTIkm3g+Elutj0NnxAEF20KiA7PrRMfw/fUSBQhrpdDwTUJajQxDW3dWSRMpU6H5ABHnVlSmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mqR+FCD7; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mqR+FCD7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785902707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYXN6Zjkj2RG7e1IZ+JvD2cu/6XXDmjjam5GabPUNes=;
	b=mqR+FCD7qPyE54X4u9cbs9fW2Kvn1ItA7Mf9fsIcFeXSOHarBU6nltmwkaCR4ZTlimgOnu
	7iA9ci3ILNDChrG9lAMNorRMb8j/c7O8DNobTdgkqH8b5k4pHdt+Km4TOa2y/52BMir2jh
	aQG4zl4PWw/NhYspFkAr5DxtbElVUqk=
From: "Hui Zhu" <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v2 1/3] bpf: Fix UAF in bpf_trampoline_multi_detach on update failure
Date: Wed,  5 Aug 2026 12:04:06 +0800
Message-ID: <0276810360a8c0e57aab95a292ff6453242b969c.1785902527.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1785902527.git.zhuhui@kylinos.cn>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Two UAF scenarios exist in bpf_trampoline_multi_detach() error paths:

1. If __bpf_trampoline_unlink_prog() fails, cur_image == old_image and
   ftrace still points to it, but bpf_trampoline_multi_attach_free()
   unconditionally frees old_image. Fix: only free old_image when it
   differs from cur_image.

2. If the batch update_ftrace_direct_del/mod() fails, ftrace still
   points to old_image, but _free() frees it. Fix: use rollback
   (restores cur_image = old_image) instead of _free() for affected
   mnodes.

Rollback keeps the image alive but the caller still frees the prog
whose call is baked into it. Pin the prog on old_image via a new
pinned_prog field in struct bpf_tramp_image (released in
bpf_tramp_image_free()).

bpf_trampoline_put() must not free a trampoline whose cur_image was
left behind by rollback -- ftrace may still call into it. Leak the
trampoline instead (it's already unlinked from lookup tables).

pinned_prog is a single pointer: if multiple progs need pinning on the
same image (rare), only the last is tracked and earlier refs are leaked
(not a UAF). This is an intentional trade-off.

Also make bpf_trampoline_multi_detach() return void since callers
cannot usefully react to failures.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 include/linux/bpf.h      |  20 +++++--
 kernel/bpf/trampoline.c  | 112 +++++++++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |   2 +-
 3 files changed, 118 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73bacfc6444d..cd32c6f54eeb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1372,6 +1372,17 @@ struct bpf_tramp_image {
 		struct rcu_head rcu;
 		struct work_struct work;
 	};
+	/*
+	 * Extra reference on the bpf_prog whose call is baked into this
+	 * image's machine code, held only when a required ftrace
+	 * direct-call update failed while retiring/replacing this image
+	 * (see bpf_trampoline_multi_attach()/_detach() in trampoline.c).
+	 * ftrace may still be directing calls into this image, so neither
+	 * the image nor the pinned prog can be freed until a later,
+	 * successful ftrace update proves this image is no longer in use.
+	 * Released in bpf_tramp_image_free() alongside the image itself.
+	 */
+	struct bpf_prog *pinned_prog;
 };
 
 struct bpf_trampoline {
@@ -1518,8 +1529,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 				struct bpf_tracing_multi_link *link);
-int bpf_trampoline_multi_detach(struct bpf_prog *prog,
-				struct bpf_tracing_multi_link *link);
+void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				 struct bpf_tracing_multi_link *link);
 void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
 
 /*
@@ -1639,10 +1650,9 @@ static inline int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 {
 	return -ENOTSUPP;
 }
-static inline int bpf_trampoline_multi_detach(struct bpf_prog *prog,
-					      struct bpf_tracing_multi_link *link)
+static inline void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+					       struct bpf_tracing_multi_link *link)
 {
-	return -ENOTSUPP;
 }
 static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags) {}
 #endif
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ed7999ad6c66..c08d1a09e638 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -535,6 +535,14 @@ static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 	arch_free_bpf_trampoline(im->image, im->size);
 	bpf_jit_uncharge_modmem(im->size);
 	percpu_ref_exit(&im->pcref);
+	/*
+	 * This image is confirmed no longer reachable from ftrace (that's
+	 * why we're freeing it), so it's now safe to drop the reference we
+	 * pinned on its behalf while it may have still been live - see
+	 * bpf_trampoline_multi_attach()/_detach().
+	 */
+	if (im->pinned_prog)
+		bpf_prog_put(im->pinned_prog);
 	kfree_rcu(im, rcu);
 }
 
@@ -1216,6 +1224,28 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 */
 	hlist_del(&tr->hlist_key);
 	hlist_del(&tr->hlist_ip);
+
+	/*
+	 * tr->cur_image should already be NULL here. A non-NULL value means
+	 * bpf_trampoline_multi_attach_rollback() left an image behind
+	 * because a required ftrace direct-call update failed (see
+	 * bpf_trampoline_multi_detach()), so ftrace may still be calling
+	 * into it - and, in turn, into the bpf_prog pinned in
+	 * tr->cur_image->pinned_prog. We have no reliable way to confirm
+	 * ftrace has since stopped referencing it, so freeing
+	 * tr->cur_image (and dropping the pinned prog's reference) here
+	 * would risk a use-after-free.
+	 *
+	 * tr has just been unlinked from the lookup tables above, so any
+	 * future attach to this function allocates a fresh trampoline;
+	 * this one, its stuck image, and the pinned prog reference are
+	 * deliberately leaked instead of freed. This is rare (it only
+	 * happens after a genuine ftrace direct-call update failure) and
+	 * bounded (at most one image), so it is far preferable to a UAF.
+	 */
+	if (WARN_ON_ONCE(tr->cur_image))
+		goto out;
+
 	direct_ops_free(tr);
 	kfree(tr);
 out:
@@ -1595,7 +1625,18 @@ static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
 
 static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
 {
-	if (tr->multi_attach.old_image)
+	/*
+	 * Only free old_image if it is no longer the active image.
+	 * When bpf_trampoline_update() fails before modify_fentry_multi()/
+	 * unregister_fentry_multi() is called, cur_image is unchanged
+	 * (cur_image == old_image) and ftrace still points to it. Freeing
+	 * it would cause a UAF when ftrace calls into the freed memory.
+	 * On success, cur_image is either a new image or NULL, so
+	 * old_image != cur_image correctly identifies a stale image that
+	 * is safe to free.
+	 */
+	if (tr->multi_attach.old_image &&
+	    tr->multi_attach.old_image != tr->cur_image)
 		bpf_tramp_image_put(tr->multi_attach.old_image);
 
 	tr->multi_attach.old_image = NULL;
@@ -1719,11 +1760,11 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	return err;
 }
 
-int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
+void bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_tracing_multi_node *mnode;
-	int i, err;
+	int i, err, err_unreg = 0, err_mod = 0;
 
 	trampoline_lock_all();
 
@@ -1735,13 +1776,65 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 		WARN_ONCE(err, "__bpf_trampoline_unlink_prog failed: %d\n", err);
 	}
 
-	if (ftrace_hash_count(data->unreg))
-		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
-	if (ftrace_hash_count(data->modify))
-		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data->modify, true));
+	if (ftrace_hash_count(data->unreg)) {
+		err_unreg = update_ftrace_direct_del(&direct_ops, data->unreg);
+		WARN_ON_ONCE(err_unreg);
+	}
+	if (ftrace_hash_count(data->modify)) {
+		err_mod = update_ftrace_direct_mod(&direct_ops, data->modify, true);
+		WARN_ON_ONCE(err_mod);
+	}
 
-	for_each_mnode(mnode, link)
-		bpf_trampoline_multi_attach_free(mnode->trampoline);
+	for_each_mnode(mnode, link) {
+		struct bpf_trampoline *tr = mnode->trampoline;
+
+		/* If the batch ftrace update failed for this mnode's path,
+		 * ftrace still points to old_image. Use rollback to restore
+		 * cur_image to old_image (putting the new cur_image if any)
+		 * so the trampoline keeps the image ftrace is calling.
+		 *
+		 * A link only reaches detach after a successful attach, so
+		 * tr->cur_image (captured above as old_image) is always
+		 * non-NULL here; the NULL check only mirrors the one in
+		 * bpf_trampoline_multi_attach_free()/_rollback()'s shared
+		 * pattern and guards against tr->multi_attach being reused
+		 * without a prior _init() call.
+		 *
+		 * This relies on update_ftrace_direct_del/mod being atomic:
+		 * on failure, NO IPs in the hash are modified in ftrace (all
+		 * validation/allocation happens before any ftrace record is
+		 * touched). If this assumption is broken in the future (i.e.,
+		 * partial success becomes possible), this rollback logic would
+		 * need to be revisited.
+		 *
+		 * cur_image == NULL indicates the unreg path (total == 0);
+		 * cur_image != NULL indicates the modify path (total > 0).
+		 *
+		 * Rollback alone only prevents freeing the trampoline image
+		 * while ftrace may still branch into it; it does not keep
+		 * the underlying bpf_prog alive, and the caller tears down
+		 * link->prog once this function returns. So pin @prog (whose
+		 * call is baked into old_image's machine code) on old_image
+		 * before restoring it as cur_image: the pin is released once
+		 * old_image is eventually retired for real by a later,
+		 * successful update on this trampoline (see
+		 * bpf_trampoline_multi_attach_free() and
+		 * bpf_tramp_image_free()), or safely leaked alongside the
+		 * image if the trampoline is torn down first instead (see
+		 * bpf_trampoline_put()).
+		 */
+		if (tr->multi_attach.old_image &&
+		    tr->multi_attach.old_image != tr->cur_image &&
+		    ((err_unreg && !tr->cur_image) ||
+		     (err_mod && tr->cur_image))) {
+			WARN_ON_ONCE(tr->multi_attach.old_image->pinned_prog);
+			bpf_prog_inc(prog);
+			tr->multi_attach.old_image->pinned_prog = prog;
+			bpf_trampoline_multi_attach_rollback(tr);
+		} else {
+			bpf_trampoline_multi_attach_free(tr);
+		}
+	}
 
 	trampoline_unlock_all();
 
@@ -1749,7 +1842,6 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 		bpf_trampoline_put(mnode->trampoline);
 
 	clear_tracing_multi_data(data);
-	return 0;
 }
 
 #undef for_each_mnode_cnt
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 891897f8a1b3..29260951aa87 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3687,7 +3687,7 @@ static void bpf_tracing_multi_link_release(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
-	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
+	bpf_trampoline_multi_detach(link->prog, tr_link);
 }
 
 static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
-- 
2.53.0

