Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56E32B103;
	Mon, 10 Aug 2026 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786328657; cv=none; b=r+CywxRVyd8z7fOi8kjPvjY9PyBPbZIeZO12chPxNxuxB+8nBKmu+0ddUsMHpdWSUqNZlJ0BYOYyH6YVmfkhSTOztfU3t18bQb97uuJtlnOfMTolRSAxZMXZYKe1dAnMLZgFlfcZaEUIBYnIV23BqRPE7OvMGWHc2G5VztnlM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786328657; c=relaxed/simple;
	bh=yv3tn92yAmb5f2fqQ6D9zpkGepWPX8jH5Odabch/9B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwUrSvEwVvZWS2vOUBqHrRfKWsczplB+m3gIyPDycZDshVvPpCecYk+8RsEm8XbsdmQLwEQxOBStppCP527mtYUTK0T3mrq1WCwo4V8j/t0BTSZsLJVRg1jBdHg1IBt8lhFzfXzR4yit3UPduXUJnI2ZvlMyZAjBOsuxSky/5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F+NpFXLw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F+NpFXLw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786328643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ow6n/yXH8/FIeGrZ5bMz0r5QZSRa7xEuAXXToOsVnZU=;
	b=F+NpFXLwyT2VBeq4AFLzGkY5ENePm20YOGQTsLH+CDJR1gyZDYf2M2rRRcHKWnyeWL5CZE
	c+GIa8p8B2APMFb1GVD6YXMbolUt1ItjM6cO9hxKj9mSZlR+B1uZGGwFDYI/Ap16HSgVX+
	zLmnZ4cbN5YypEqHizoYxRPKWwuASGA=
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
Subject: [PATCH v3] bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
Date: Mon, 10 Aug 2026 10:23:04 +0800
Message-ID: <20260810022304.211544-1-hui.zhu@linux.dev>
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

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 include/linux/bpf.h      |  9 ++++-----
 kernel/bpf/trampoline.c  | 17 ++++++++++++++---
 kernel/trace/bpf_trace.c |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

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
index ed7999ad6c66..544ab41a3c25 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1595,7 +1595,18 @@ static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
 
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
@@ -1719,7 +1730,8 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	return err;
 }
 
-int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
+void bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				 struct bpf_tracing_multi_link *link)
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_tracing_multi_node *mnode;
@@ -1749,7 +1761,6 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
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

