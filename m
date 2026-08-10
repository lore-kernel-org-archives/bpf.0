Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771C37F32A
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342441; cv=none; b=CqUBC98altnqurP8hLdzoFZ69RHv6qIeaJFwYy7Gru8WbJ1x41kWdEATli1UYl8E4CT18jzDX533W3n2OTyPILI3RPRTi6JDEe1RN/YP0kfl8mrFDj8CLXVrgstxJQcgjmMs9OZUMs1t3ToC4xNVLzBxR7xI3kxUinrbHCyucBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342441; c=relaxed/simple;
	bh=3kdNeUY+t/kFBqYbrh/MfIaV9XrnVsNXkVq0RMLHU1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+JfuCA1octhWLgylY1ZYNUSfezkzDS8WaINT4Foox/CwmjlUdHnbxm6OAkGYQg+Ab2PMBhiddifC/Eu7OTxY42bHzek4vVVvNjuAeNb0vIfjrHMUdLdoEEYK4AJWdRDw1nRvhVjWY8UQTrm6fPvA6d8UHdB1qCk4si/3M3sxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZNzakP1H; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZNzakP1H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786342425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nwVYmsqkZEiQlGwfKTmbx4LsFnCpdg3YKsT26FZwP7w=;
	b=ZNzakP1Hw2zC/FVoF2MzyzObPo/SX0U1X+m8ToVsQ+FNNGFMLFBVUy9s7Wt9QgpZE4zYzF
	/91/fT82kBBNaJsiPnNQsObouydbfQrhDD5O8KxzBoTx4gRKF3KVlUKbiLSgby35CGRZ30
	yXjs2a49RGVVBVreph4xA1RCXnfFYeU=
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
Subject: [PATCH v4] bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
Date: Mon, 10 Aug 2026 14:13:29 +0800
Message-ID: <20260810061329.224276-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

When bpf_trampoline_update() fails before modify_fentry_multi()/
unregister_fentry_multi() is called, cur_image is unchanged
(cur_image == old_image) and ftrace still calls into it.  Freeing
old_image in that case causes a UAF.

Only free old_image when it differs from cur_image.

Also change bpf_trampoline_multi_detach() to return void and drop
the WARN_ON_ONCE at its call site.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
Changelog:
v4:
According to the comments of bot+bpf-ci, add Fixes: and update comments
of bpf_trampoline_multi_attach_free.
v3:
According to the comments of Jiri Olsa, drop patches 2/3 and the
prog-side machinery.
keep only the simplified image-side fix in
bpf_trampoline_multi_attach_free() and make
bpf_trampoline_multi_detach() return void.
v2:
Folded v1's two detach patches into patch 1.
According to the comments of Jiri Olsa, Pin the prog (pinned_prog) on
cur_image so it stays alive while ftrace may still call into it.
Make bpf_trampoline_multi_detach() return void.
Fix the same UAF in standard (non-multi) trampolines.
According to the comments of sashiko, Fix the prog UAF in
bpf_trampoline_multi_attach() rollback.
Leak the trampoline in bpf_trampoline_put() when cur_image is left
by a rollback.

 include/linux/bpf.h      |  9 ++++-----
 kernel/bpf/trampoline.c  | 16 +++++++++++++---
 kernel/trace/bpf_trace.c |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73bacfc6444d..3255c6f5ea6b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1518,8 +1518,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 				struct bpf_tracing_multi_link *link);
-int bpf_trampoline_multi_detach(struct bpf_prog *prog,
-				struct bpf_tracing_multi_link *link);
+void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				 struct bpf_tracing_multi_link *link);
 void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
 
 /*
@@ -1639,10 +1639,9 @@ static inline int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
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
index ed7999ad6c66..e30425789487 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1595,7 +1595,17 @@ static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
 
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
+	 * old_image != cur_image means the image is stale.
+	 */
+	if (tr->multi_attach.old_image &&
+	    tr->multi_attach.old_image != tr->cur_image)
 		bpf_tramp_image_put(tr->multi_attach.old_image);
 
 	tr->multi_attach.old_image = NULL;
@@ -1719,7 +1729,8 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	return err;
 }
 
-int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
+void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				 struct bpf_tracing_multi_link *link)
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_tracing_multi_node *mnode;
@@ -1749,7 +1760,6 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
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

