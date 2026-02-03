Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D08396B9F;
	Tue,  3 Feb 2026 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111570; cv=none; b=KfFh7ZJje5/f/3ID73/RITPmuRyE6eFjNC4zzclXl/C5mztPogZE7BaaIkJfTpWVtqHlsUcl8Joaf82CNEa8JGtv4NxLmV+xfJPuc77tznO32Yf3EMlHOv0yC0T0eQtgDPLJ5C2Ra5p2C2ej2HufuCVq5Z7U4J0MkQEC9GB05xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111570; c=relaxed/simple;
	bh=zOI37iL81roP7QI4NdjxPrCxlorjmUZBURPKH2lZkhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m70DRMuQR/7+ar7M8Ly8l6L9ZouRRxh5U02mmzXWG9hOcbGIEVjmmema3c7Tev9o9u2UciV8biDx70hqxF4c7/7V0IfjBOm+ouvt0wjKGDIVTu2BsWfOFT6JetUktrzj3GXeOxvDgkRjQ3fGaSO5xDLjAY7X2Ld8keGd8waJELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtErkwN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtErkwN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666ACC19421;
	Tue,  3 Feb 2026 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111570;
	bh=zOI37iL81roP7QI4NdjxPrCxlorjmUZBURPKH2lZkhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtErkwN8Mlk8sdeWbvyMaBmZOQSe5cPcBr+qwdOY1cNaeReAafkYXAM4K5brIZ+2K
	 O0aRLejJTo45fF3t0T2LAR2evEbrkJOVN9mow9KpPbrMVGRWSQ9nGbFa7+1W9HSNQx
	 YOUifFs+Y++z31+QWpOY1HnIgTsL8wEH8SHGohAq2iQRS6lD5roKsy0lhJUQ1YewWA
	 fL9S2Yoj3iJdf9+zn/VkBdR54zu5KJ5fx4ksLixJcpp/WOXOo2k30A/gDfaRFEnsiZ
	 HDTAGemNyIRQxAi0uxLydAnb6gRVwfERPcBJwXuGpYTDOkJYE9A0OLq12gaMyYnpzh
	 XMYuWKojyMq0Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [RFC bpf-next 06/12] bpf: Add bpf_trampoline_multi_attach/detach functions
Date: Tue,  3 Feb 2026 10:38:13 +0100
Message-ID: <20260203093819.2105105-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_trampoline_multi_attach/detach functions that allows
to attach/detach multi tracing trampoline.

The attachment is defined with bpf_program and array of BTF ids
of functions to attach the bpf program to.

The attachment will allocate or use currently existing trampoline
for function to attach and link it with the bpf program.

The attach works as follows:
- we get all the needed trampolines
- lock them and add the bpf program to each (__bpf_trampoline_link_prog)
- the trampoline_multi_ops passed in __bpf_trampoline_link_prog gather needed
  ftrace_hash ip->trampoline data
- we call update_ftrace_direct_add/mod to update needed locations
- we unlock all the trampolines

The detach works as follows:
- we lock all the needed trampolines
- remove the program from each (__bpf_trampoline_unlink_prog)
- the trampoline_multi_ops passed in __bpf_trampoline_link_prog gather needed
  ftrace_hash ip->trampoline data
- we call update_ftrace_direct_del/mod to update needed locations
- we unlock and put all the trampolines

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  18 ++++
 kernel/bpf/trampoline.c | 186 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f06f0a11ccb7..5591660da6e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1466,6 +1466,12 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 
+struct bpf_tracing_multi_link;
+int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+				struct bpf_tracing_multi_link *link);
+int bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				struct bpf_tracing_multi_link *link);
+
 /*
  * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
  * indirection with a direct call to the bpf program. If the architecture does
@@ -1898,6 +1904,18 @@ struct bpf_fsession_link {
 	struct bpf_tramp_link fexit;
 };
 
+struct bpf_tracing_multi_node {
+	struct bpf_tramp_node node;
+	struct bpf_trampoline *trampoline;
+};
+
+struct bpf_tracing_multi_link {
+	struct bpf_link link;
+	enum bpf_attach_type attach_type;
+	int nodes_cnt;
+	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
+};
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2be2f1d0b7d7..b76bb545077b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -367,7 +367,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist_ip, head);
 	refcount_set(&tr->refcnt, 1);
+#ifdef CONFIG_LOCKDEP
+	mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
+#else
 	mutex_init(&tr->mutex);
+#endif
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
 out:
@@ -1400,6 +1404,188 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return -ENOTSUPP;
 }
 
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
+
+struct fentry_multi_data {
+	struct ftrace_hash *unreg;
+	struct ftrace_hash *modify;
+	struct ftrace_hash *reg;
+};
+
+static void free_fentry_multi_data(struct fentry_multi_data *data)
+{
+	free_ftrace_hash(data->reg);
+	free_ftrace_hash(data->unreg);
+	free_ftrace_hash(data->modify);
+}
+
+static int register_fentry_multi(struct bpf_trampoline *tr, void *new_addr, void *ptr)
+{
+	struct fentry_multi_data *data = ptr;
+	unsigned long ip = ftrace_location(tr->ip);
+
+	return add_ftrace_hash_entry_direct(data->reg, ip,
+					    (unsigned long) new_addr) ? 0 : -ENOMEM;
+}
+
+static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr, void *ptr)
+{
+	struct fentry_multi_data *data = ptr;
+	unsigned long ip = ftrace_location(tr->ip);
+
+	return add_ftrace_hash_entry_direct(data->unreg, ip,
+					    (unsigned long) old_addr) ? 0 : -ENOMEM;
+}
+
+static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr, void *new_addr,
+			       bool lock_direct_mutex, void *ptr)
+{
+	struct fentry_multi_data *data = ptr;
+	unsigned long ip = ftrace_location(tr->ip);
+
+	return add_ftrace_hash_entry_direct(data->modify, ip,
+					    (unsigned long) new_addr) ? 0 : -ENOMEM;
+}
+
+static struct bpf_trampoline_ops trampoline_multi_ops = {
+	.register_fentry   = register_fentry_multi,
+	.unregister_fentry = unregister_fentry_multi,
+	.modify_fentry     = modify_fentry_multi,
+};
+
+int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+				struct bpf_tracing_multi_link *link)
+{
+	struct bpf_attach_target_info tgt_info = {};
+	struct bpf_tracing_multi_node *mnode;
+	int j, i, err, cnt = link->nodes_cnt;
+	struct fentry_multi_data data = {};
+	struct bpf_trampoline *tr;
+	u64 key;
+
+	data.reg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!data.reg)
+		return -ENOMEM;
+
+	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!data.modify) {
+		free_ftrace_hash(data.reg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		mnode = &link->nodes[i];
+		err = bpf_check_attach_target(NULL, prog, NULL, ids[i], &tgt_info);
+		if (err)
+			goto rollback_put;
+
+		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, ids[i]);
+
+		tr = bpf_trampoline_get(key, &tgt_info);
+		if (!tr)
+			goto rollback_put;
+
+		mnode->trampoline = tr;
+		mnode->node.prog = prog;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		mnode = &link->nodes[i];
+		tr = mnode->trampoline;
+
+		mutex_lock(&tr->mutex);
+
+		err = __bpf_trampoline_link_prog(&mnode->node, tr, NULL, &trampoline_multi_ops, &data);
+		if (err) {
+			mutex_unlock(&tr->mutex);
+			goto rollback_unlink;
+		}
+	}
+
+	if (ftrace_hash_count(data.reg)) {
+		err = update_ftrace_direct_add(&direct_ops, data.reg);
+		if (err)
+			goto rollback_unlink;
+	}
+
+	if (ftrace_hash_count(data.modify)) {
+		err = update_ftrace_direct_mod(&direct_ops, data.modify, true);
+		if (err) {
+			WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data.reg));
+			goto rollback_unlink;
+		}
+	}
+
+	for (i = 0; i < cnt; i++) {
+		tr = link->nodes[i].trampoline;
+		mutex_unlock(&tr->mutex);
+	}
+
+	free_fentry_multi_data(&data);
+	return 0;
+
+rollback_unlink:
+	for (j = 0; j < i; j++) {
+		mnode = &link->nodes[j];
+		tr = mnode->trampoline;
+		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, tr, NULL,
+			     &trampoline_multi_ops, &data));
+		mutex_unlock(&tr->mutex);
+	}
+
+rollback_put:
+	for (j = 0; j < i; j++) {
+		mnode = &link->nodes[j];
+		bpf_trampoline_put(mnode->trampoline);
+	}
+
+	free_fentry_multi_data(&data);
+	return err;
+}
+
+int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
+{
+	struct bpf_tracing_multi_node *mnode;
+	struct fentry_multi_data data = {};
+	int i, cnt = link->nodes_cnt;
+	struct bpf_trampoline *tr;
+
+	data.unreg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!data.unreg)
+		return -ENOMEM;
+
+	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!data.modify) {
+		free_ftrace_hash(data.unreg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		mnode = &link->nodes[i];
+		tr = link->nodes[i].trampoline;
+
+		mutex_lock(&tr->mutex);
+		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, tr, NULL,
+							  &trampoline_multi_ops, &data));
+	}
+
+	if (ftrace_hash_count(data.unreg))
+		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data.unreg));
+	if (ftrace_hash_count(data.modify))
+		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data.modify, true));
+
+	for (i = 0; i < cnt; i++) {
+		tr = link->nodes[i].trampoline;
+		mutex_unlock(&tr->mutex);
+		bpf_trampoline_put(tr);
+	}
+
+	free_fentry_multi_data(&data);
+	return 0;
+}
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
+
 static int __init init_trampolines(void)
 {
 	int i;
-- 
2.52.0

