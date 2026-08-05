Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D93C4172
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902715; cv=none; b=qeQo1GsFaPH5E0n1f1chpIN1Q58XWPTb+zDM+FLZW1Heevg/ZLDLl/gIyM1TZJq0SDZmUmC1TlOpLZUEkqkXFGGnb28RnMfsGEM4fOvcF236z/bIVqSrMZbIy+sQ/FqipVufueG50XE5TaGsPvfa9CrlffrWngdxmJK9vSGwr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902715; c=relaxed/simple;
	bh=hp3BxxjQXqMUl4xCXaHkuCNKHzH71oiL+uOouF/16Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZAWfYkc5itOYXwm7LQb8zjEH1OBxISqRejxewY3wijuDMHahM9JKm/N13mtzbrxvEV4HnDNSWr2o8OkD9iY/NUxMVBCwPsSxEyl/WSf1yY1suYilSXVxsXBtbxSX6cEmT7JRCLXIPinKe/vMnMNpjf8wLSqk9t33OsLtpzRs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rreJZX/w; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rreJZX/w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785902711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cf+NSdykdJD4K4q6YC2i5+/xG5MrJMnjBSYsMFeGNQk=;
	b=rreJZX/wn9AqowKmJpMhI/vw1qNff5JAKHiIJqSBVDLqtwcOkBBlWRMG6bFl5rnrjfpK9V
	6esH6Kf12l787ETLs8Hk9nZrfcEJwt723GbXrsr0hpdTJALRPXO+iM9XWUWYCkJIMZSWjx
	U4znrYxsh8ewVhLFf0ogk7fr6qRjbk0=
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
Subject: [PATCH bpf-next v2 2/3] bpf: Fix prog UAF in bpf_trampoline_multi_attach() register-path rollback
Date: Wed,  5 Aug 2026 12:04:07 +0800
Message-ID: <6edcc3d19ab91511372a9c3f00d90fdc66a31d83.1785902527.git.zhuhui@kylinos.cn>
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

In bpf_trampoline_multi_attach(), if update_ftrace_direct_mod() fails,
the rollback tries to undo update_ftrace_direct_add() for register-path
mnodes via update_ftrace_direct_del(). If that undo also fails, ftrace
still calls into rtr->cur_image, but the unconditional rollback frees
it -- a UAF of both the image and the prog baked into it.

Fix: for register-path mnodes (old_image == NULL) whose undo failed
while cur_image is set, pin the prog on cur_image instead of rolling
back, reusing the pinned_prog mechanism from the detach path.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 kernel/bpf/trampoline.c | 51 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c08d1a09e638..7fac27374ece 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1668,7 +1668,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	struct btf *btf = prog->aux->attach_btf;
 	struct bpf_tracing_multi_node *mnode;
 	struct bpf_trampoline *tr;
-	int i, err, rollback_cnt;
+	int i, err, rollback_cnt, err_undo_reg = 0;
 	u64 key;
 
 	for_each_mnode(mnode, link) {
@@ -1728,8 +1728,10 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	if (ftrace_hash_count(data->modify)) {
 		err = update_ftrace_direct_mod(&direct_ops, data->modify, true);
 		if (err) {
-			if (ftrace_hash_count(data->reg))
-				WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
+			if (ftrace_hash_count(data->reg)) {
+				err_undo_reg = update_ftrace_direct_del(&direct_ops, data->reg);
+				WARN_ON_ONCE(err_undo_reg);
+			}
 			goto rollback_unlink;
 		}
 	}
@@ -1744,8 +1746,47 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 
 rollback_unlink:
 	for_each_mnode_cnt(mnode, link, rollback_cnt) {
-		bpf_trampoline_remove_prog(mnode->trampoline, &mnode->node);
-		bpf_trampoline_multi_attach_rollback(mnode->trampoline);
+		struct bpf_trampoline *rtr = mnode->trampoline;
+		/*
+		 * register_fentry_multi()/modify_fentry_multi() set
+		 * rtr->cur_image before any ftrace call is made, and
+		 * bpf_trampoline_multi_attach_init() captured whatever was
+		 * live before that into rtr->multi_attach.old_image. A NULL
+		 * old_image means this ip had no prior direct caller, i.e.
+		 * this mnode went through the "register" (data->reg) path
+		 * rather than "modify" (data->modify).
+		 */
+		bool via_register = !rtr->multi_attach.old_image;
+
+		bpf_trampoline_remove_prog(rtr, &mnode->node);
+
+		/*
+		 * If this mnode used the register path and the
+		 * update_ftrace_direct_del() above meant to undo its
+		 * earlier, successful update_ftrace_direct_add() failed,
+		 * ftrace is still actually calling into rtr->cur_image
+		 * (which has @prog's call baked into its machine code) even
+		 * though this attach is being reported as failed. Freeing
+		 * rtr->cur_image via the normal rollback (which would also
+		 * let the caller free @prog once this function returns its
+		 * error) would be a use-after-free, so instead pin @prog on
+		 * it and leave rtr->cur_image untouched: rtr->multi_attach
+		 * is a scratch area only meaningful between _init() and
+		 * _free()/_rollback(), so skipping _rollback() here does
+		 * not leave it in an inconsistent state (old_image is NULL
+		 * on the register path anyway). This image (and the pinned
+		 * prog reference) is subsequently either properly retired by
+		 * a later, successful update on the same trampoline, or
+		 * safely leaked when the trampoline is torn down - see
+		 * bpf_trampoline_multi_attach_free() and bpf_trampoline_put().
+		 */
+		if (via_register && err_undo_reg && rtr->cur_image) {
+			WARN_ON_ONCE(rtr->cur_image->pinned_prog);
+			bpf_prog_inc(prog);
+			rtr->cur_image->pinned_prog = prog;
+		} else {
+			bpf_trampoline_multi_attach_rollback(rtr);
+		}
 	}
 
 	trampoline_unlock_all();
-- 
2.53.0

