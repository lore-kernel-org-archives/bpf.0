Received: from mta1.migadu.com (out-190.mta1.migadu.com [95.215.58.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010DC4ABBA6
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819801; cv=none; b=irm/sYsk0Lk1/P6BCklKTItQgiInldfbuyd1DY8Us9ZHKYodnAOJHNQ7MIF4iZbbjUHPrNrIoCz7+0oy5lZ3WOW3AZRjLFGTq/BgI2M7wxLOxWtVLMUbp5hWDvHuW4cMDDA/nymkBM/rvdoU9gI1qnx4FJiYsUeVnb5fc8hq3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819801; c=relaxed/simple;
	bh=hYyC9Ma/o9rZIGPp1VMQoktXC8Csu/RqTpkIFUaXwgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrrnNOHex2dIvcGoTeu8K3R/zy5CXUm2Wudt2dHXnCt9PkZpjTkVbVH6A0oSss0HRhfpWgSNje5DDD+8gYgZBwUqAzw86FV2esBUg/WtqLYq5ENIieN2IbW39SjyPmQFXGjxSQIT57bcyun/7gDOSw9RTgWTo8GEGm7PK5vc+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fl6HztMA; arc=none smtp.client-ip=95.215.58.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fl6HztMA"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hYyC9Ma/o9rZIGPp1VMQoktXC8Csu/RqTpkIFUaXwgA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819798; v=1; x=1792424598;
 b=fl6HztMAeCEZ4P4xC1P2Tjt/8Z1Tw9R+2qJ18nyiFxF46kRd6PHYkYIbb0AGfrt1AgvH1bgS
 h4iHhkZ7ESAMKzVAE/Z7YMFAhhcHJ3Vvzy5t9NKSxUMV478rGmT6d7wV2kRbAi2Si3Zi3UShdoN
 qwHKlb9zlb9qEMElXRCwCZUg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2216aacfe707bb40;
	Mon, 12 Oct 2026 15:43:18 +0000
X-Mizu-Trace-ID: 2216aacfe707bb40
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 09/21] bpf: Add bpf_trampoline_multi_prog_attach/detach()
Date: Mon, 12 Oct 2026 23:40:11 +0800
Message-ID: <20261012154024.29423-10-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing tracing_multi helpers update ftrace-managed kernel function
targets through the ftrace direct-call API. BPF prog targets are not
ftrace-managed and require text pokes at their entry points.

Add bpf_trampoline_multi_prog_attach/detach() helpers that prepare each
target trampoline, apply the text pokes in batch, and then commit the
staged trampoline images. Roll back the added programs and trampoline
images when attach fails.

Set BPF_TRAMP_F_TAIL_CALL_CTX for tail-call-reachable target bpf progs so
the generated trampolines preserve the tail_call_cnt.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h     |  45 ++++++---
 kernel/bpf/trampoline.c | 216 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b1a189e6e89..a37f926023fd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1496,9 +1496,10 @@ struct bpf_trampoline {
 	struct bpf_tramp_image *cur_image;
 	/* Images not freed yet, cur_image and older ones still in use */
 	struct list_head images;
-	/* Used as temporary old image storage for multi_attach */
+	/* Used as temporary images storage for multi_attach */
 	struct {
 		struct bpf_tramp_image *old_image;
+		struct bpf_tramp_image *new_image;
 		u32 old_flags;
 	} multi_attach;
 };
@@ -1616,6 +1617,9 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 				struct bpf_tracing_multi_link *link);
 void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 				 struct bpf_tracing_multi_link *link);
+int bpf_trampoline_multi_prog_attach(struct bpf_prog *prog, u32 *ids, u64 *keys,
+				     struct bpf_tracing_multi_link *link);
+void bpf_trampoline_multi_prog_detach(struct bpf_tracing_multi_link *link);
 void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
 
 /*
@@ -1739,6 +1743,14 @@ static inline void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 					       struct bpf_tracing_multi_link *link)
 {
 }
+
+static inline int bpf_trampoline_multi_prog_attach(struct bpf_prog *prog, u32 *ids, u64 *keys,
+						   struct bpf_tracing_multi_link *link)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bpf_trampoline_multi_prog_detach(struct bpf_tracing_multi_link *link) {}
 static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags) {}
 #endif
 
@@ -2089,10 +2101,25 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+enum bpf_text_poke_type {
+	BPF_MOD_NOP,
+	BPF_MOD_CALL,
+	BPF_MOD_JUMP,
+};
+
+struct bpf_text_poke {
+	void *ip;
+	void *old_addr;
+	void *new_addr;
+	enum bpf_text_poke_type old_t;
+	enum bpf_text_poke_type new_t;
+};
+
 struct bpf_tracing_multi_node {
 	struct bpf_tramp_node node;
 	struct bpf_trampoline *trampoline;
 	struct ftrace_func_entry entry;
+	struct bpf_text_poke poke;
 };
 
 struct bpf_tracing_multi_data {
@@ -2107,6 +2134,8 @@ struct bpf_tracing_multi_link {
 	struct bpf_tracing_multi_data data;
 	u64 *cookies;
 	struct bpf_tramp_node *fexits;
+	struct bpf_text_poke **pokes;
+	struct bpf_prog **tgt_progs;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
@@ -4225,20 +4254,6 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 }
 #endif /* CONFIG_INET */
 
-enum bpf_text_poke_type {
-	BPF_MOD_NOP,
-	BPF_MOD_CALL,
-	BPF_MOD_JUMP,
-};
-
-struct bpf_text_poke {
-	void *ip;
-	void *old_addr;
-	void *new_addr;
-	enum bpf_text_poke_type old_t;
-	enum bpf_text_poke_type new_t;
-};
-
 int bpf_arch_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt);
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 		       enum bpf_text_poke_type new_t, void *old_addr,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index bb832af8703f..e57c687955fd 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -81,6 +81,7 @@ static void trampoline_unlock_all(void)
 static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
 {
 	tr->multi_attach.old_image = tr->cur_image;
+	tr->multi_attach.new_image = NULL;
 	tr->multi_attach.old_flags = tr->flags;
 }
 
@@ -1708,6 +1709,7 @@ static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
 		bpf_tramp_image_put(tr->multi_attach.old_image);
 
 	tr->multi_attach.old_image = NULL;
+	tr->multi_attach.new_image = NULL;
 	tr->multi_attach.old_flags = 0;
 }
 
@@ -1719,6 +1721,7 @@ static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
 	tr->flags = tr->multi_attach.old_flags;
 
 	tr->multi_attach.old_image = NULL;
+	tr->multi_attach.new_image = NULL;
 	tr->multi_attach.old_flags = 0;
 }
 
@@ -1868,6 +1871,8 @@ void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 	  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS &&
 	  CONFIG_BPF_SYSCALL */
 
+#ifdef CONFIG_BPF_SYSCALL
+
 static int bpf_text_poke_cmp(const void *a, const void *b)
 {
 	const struct bpf_text_poke *pa = *(struct bpf_text_poke * const *)a;
@@ -1918,6 +1923,217 @@ static int bpf_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt)
 	return err;
 }
 
+static enum bpf_text_poke_type bpf_trampoline_poke_type(const struct bpf_tramp_image *im, u32 flags)
+{
+	if (!im)
+		return BPF_MOD_NOP;
+
+	return bpf_trampoline_use_jmp(flags) ? BPF_MOD_JUMP : BPF_MOD_CALL;
+}
+
+static void bpf_text_poke_init(struct bpf_text_poke *poke, struct bpf_trampoline *tr)
+{
+	struct bpf_tramp_image *old_image = tr->multi_attach.old_image;
+	struct bpf_tramp_image *new_image = tr->multi_attach.new_image;
+
+	poke->ip = tr->func.addr;
+	poke->old_addr = old_image ? old_image->image : NULL;
+	poke->new_addr = new_image ? new_image->image : NULL;
+	poke->old_t = bpf_trampoline_poke_type(old_image, tr->multi_attach.old_flags);
+	poke->new_t = bpf_trampoline_poke_type(new_image, tr->flags);
+}
+
+static int register_fentry_multi_prog(struct bpf_trampoline *tr,
+				      struct bpf_tramp_image *im,
+				      void *data __maybe_unused)
+{
+	tr->multi_attach.new_image = im;
+	return 0;
+}
+
+static int unregister_fentry_multi_prog(struct bpf_trampoline *tr,
+					u32 orig_flags __maybe_unused,
+					void *data __maybe_unused)
+{
+	tr->multi_attach.new_image = NULL;
+	return 0;
+}
+
+static int modify_fentry_multi_prog(struct bpf_trampoline *tr,
+				    u32 orig_flags __maybe_unused,
+				    struct bpf_tramp_image *im,
+				    bool lock_direct_mutex __maybe_unused,
+				    void *data __maybe_unused)
+{
+	tr->multi_attach.new_image = im;
+	return 0;
+}
+
+static const struct bpf_trampoline_ops trampoline_multi_prog_ops = {
+	.register_fentry   = register_fentry_multi_prog,
+	.unregister_fentry = unregister_fentry_multi_prog,
+	.modify_fentry     = modify_fentry_multi_prog,
+};
+
+static void bpf_trampoline_multi_prog_commit(struct bpf_trampoline *tr)
+{
+	struct bpf_tramp_image *old_image = tr->multi_attach.old_image;
+
+	tr->cur_image = tr->multi_attach.new_image;
+	tr->multi_attach.old_image = NULL;
+	tr->multi_attach.new_image = NULL;
+	tr->multi_attach.old_flags = 0;
+
+	if (old_image)
+		bpf_tramp_image_put(old_image);
+}
+
+static void bpf_trampoline_multi_prog_rollback(struct bpf_trampoline *tr)
+{
+	if (tr->multi_attach.new_image)
+		bpf_tramp_image_put(tr->multi_attach.new_image);
+
+	tr->flags = tr->multi_attach.old_flags;
+	tr->multi_attach.old_image = NULL;
+	tr->multi_attach.new_image = NULL;
+	tr->multi_attach.old_flags = 0;
+}
+
+#define for_each_mnode_cnt(mnode, link, cnt) \
+	for (i = 0, mnode = &link->nodes[i]; i < cnt; i++, mnode = &link->nodes[i])
+
+#define for_each_mnode(mnode, link) \
+	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
+
+static int bpf_trampoline_multi_prog_prepare(struct bpf_prog *prog, u32 *ids, u64 *keys,
+					     struct bpf_tracing_multi_link *link)
+{
+	struct bpf_attach_target_info tgt_info = {};
+	struct bpf_tracing_multi_node *mnode;
+	struct bpf_trampoline *tr;
+	int i, cnt, err;
+
+	for_each_mnode(mnode, link) {
+		err = bpf_check_attach_target(NULL, prog, link->tgt_progs[i], ids[i], &tgt_info);
+		if (err)
+			goto put_trampolines;
+
+		tr = bpf_trampoline_get(keys[i], &tgt_info);
+		if (!tr) {
+			err = -ENOMEM;
+			goto put_trampolines;
+		}
+
+		mnode->trampoline = tr;
+		mnode->node.link = &link->link;
+		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
+
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) {
+			link->fexits[i].link = &link->link;
+			link->fexits[i].cookie = link->cookies ? link->cookies[i] : 0;
+		}
+	}
+
+	return 0;
+
+put_trampolines:
+	cnt = i;
+	for_each_mnode_cnt(mnode, link, cnt)
+		bpf_trampoline_put(mnode->trampoline);
+	return err;
+}
+
+int bpf_trampoline_multi_prog_attach(struct bpf_prog *prog, u32 *ids, u64 *keys,
+				     struct bpf_tracing_multi_link *link)
+{
+	struct bpf_tracing_multi_node *mnode;
+	int i, err, linked_cnt = 0;
+
+	err = bpf_trampoline_multi_prog_prepare(prog, ids, keys, link);
+	if (err)
+		return err;
+
+	trampoline_lock_all();
+
+	for_each_mnode(mnode, link) {
+		bpf_trampoline_multi_attach_init(mnode->trampoline);
+
+		if (link->tgt_progs[i]->aux->tail_call_reachable)
+			mnode->trampoline->flags |= BPF_TRAMP_F_TAIL_CALL_CTX;
+
+		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
+						 &trampoline_multi_prog_ops, NULL);
+		if (err) {
+			bpf_trampoline_multi_prog_rollback(mnode->trampoline);
+			goto rollback;
+		}
+		linked_cnt++;
+	}
+
+	for_each_mnode(mnode, link) {
+		link->pokes[i] = &mnode->poke;
+		bpf_text_poke_init(link->pokes[i], mnode->trampoline);
+	}
+
+	err = bpf_text_poke_batch(link->pokes, link->nodes_cnt);
+	if (err)
+		goto rollback;
+
+	for_each_mnode(mnode, link)
+		bpf_trampoline_multi_prog_commit(mnode->trampoline);
+
+	trampoline_unlock_all();
+	return 0;
+
+rollback:
+	for_each_mnode_cnt(mnode, link, linked_cnt) {
+		bpf_trampoline_remove_prog(mnode->trampoline, &mnode->node);
+		bpf_trampoline_multi_prog_rollback(mnode->trampoline);
+	}
+
+	trampoline_unlock_all();
+
+	for_each_mnode(mnode, link)
+		bpf_trampoline_put(mnode->trampoline);
+	return err;
+}
+
+void bpf_trampoline_multi_prog_detach(struct bpf_tracing_multi_link *link)
+{
+	struct bpf_tracing_multi_node *mnode;
+	int i, err;
+
+	trampoline_lock_all();
+
+	for_each_mnode(mnode, link) {
+		bpf_trampoline_multi_attach_init(mnode->trampoline);
+		err = __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline, NULL,
+						   &trampoline_multi_prog_ops, NULL);
+		if (WARN_ONCE(err, "__bpf_trampoline_unlink_prog failed: %d\n", err))
+			bpf_trampoline_multi_prog_rollback(mnode->trampoline);
+	}
+
+	for_each_mnode(mnode, link) {
+		link->pokes[i] = &mnode->poke;
+		bpf_text_poke_init(link->pokes[i], mnode->trampoline);
+	}
+
+	WARN_ON_ONCE(bpf_text_poke_batch(link->pokes, link->nodes_cnt));
+
+	for_each_mnode(mnode, link)
+		bpf_trampoline_multi_prog_commit(mnode->trampoline);
+
+	trampoline_unlock_all();
+
+	for_each_mnode(mnode, link)
+		bpf_trampoline_put(mnode->trampoline);
+}
+
+#undef for_each_mnode_cnt
+#undef for_each_mnode
+
+#endif /* CONFIG_BPF_SYSCALL */
+
 static int __init init_trampolines(void)
 {
 	int i;
-- 
2.55.0

