Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16093F1AA6
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191443; cv=none; b=cKJTFzvU8dMIjwa2c65WGatXiWkLDGlXEIEDfLQFesv8sgnV88wQhSYd+UHLxlx/fVuK27WOeg6qEyOhW57zQhcSQCgfl8NC1YAoLXJ6icehzU4XnsaNY8TTBv42tahvDXUGwHtZIv5WUPcrSzAN+bVgYK8v0fClH2GNAPeSorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191443; c=relaxed/simple;
	bh=BUB0EyKhcKQeUShMQ9ND2AJfi4caV3oUxc9/yPRbvKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re7JUFBWlDB+tWu66lrRC0fBpO1nEnsnsnijY32zS8rZ2HDjpwUpeVs7haLiJxi0ffRW2Lsvo/E9ESVP8zOffqAIrKn1PFAXhncDYJC5RNKE8SAnFBxDUUu4e9QqvgHNJlQGObRe6mbM5Za6emPt0t69+ZsJgoezPk/dmBydimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=spZ/MkTm; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="spZ/MkTm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784191439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHvaCVoxGTpef8l56Ulzg3qJv8QB8JZGTeStI/cS64c=;
	b=spZ/MkTml7u1vBJ4ojNJy2Qp/4PVW1IgmBPTQXaTF6O2p8QCuy5DPxvQ7xbD6/0tn5cqY0
	Cuos+PYp6flkuC2AGMKgdMbeI/vLKcAuwvfvE4in1bop1mNE7FubfSxyvEDk8l1MrFS7Rl
	eThpgzQzLNtYh0Ib4NSJIxpk+PRR4Pk=
From: Hui Zhu <hui.zhu@linux.dev>
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next 1/2] bpf: Fix stale old_image UAF on trampoline update failure
Date: Thu, 16 Jul 2026 16:43:38 +0800
Message-ID: <76dfd8edea81af878f52739431a218cd1d214ab2.1784191209.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1784191209.git.zhuhui@kylinos.cn>
References: <cover.1784191209.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

In bpf_trampoline_multi_detach(), if __bpf_trampoline_unlink_prog()
fails (e.g. -ENOMEM in bpf_tramp_image_alloc), bpf_trampoline_update()
returns before touching ftrace, so cur_image still equals old_image
and ftrace still points to it. The failure is only WARN_ON_ONCE'd and
the loop continues; afterwards bpf_trampoline_multi_attach_free()
unconditionally frees old_image via bpf_tramp_image_put(). Once the
RCU grace period elapses, the still-active image is freed while
ftrace keeps calling into it - a UAF that can crash the kernel or be
exploited via slab reuse.

The attach path avoids this with bpf_trampoline_multi_attach_rollback(),
but that can't be reused here: on this failure path cur_image ==
old_image, so calling it would free the active image the same way.
Re-adding the prog to the trampoline's hlist isn't safe either, since
bpf_tracing_multi_link_release() frees the link (and its embedded
tramp_node) immediately after detach returns.

Fix it by only freeing old_image in bpf_trampoline_multi_attach_free()
when it differs from cur_image. On success cur_image is updated to a
new image (or NULL), so old_image != cur_image correctly identifies a
stale image. On this failure path they're equal, so the image is left
alone until a later successful update replaces it.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 kernel/bpf/trampoline.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 6eadf64f7ec9..a78fbf726fad 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1585,7 +1585,17 @@ static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
 
 static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
 {
-	if (tr->multi_attach.old_image)
+	/* Only free old_image if it is no longer the active image.
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
-- 
2.43.0

