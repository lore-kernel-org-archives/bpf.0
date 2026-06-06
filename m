Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF22383C67;
	Sat,  6 Jun 2026 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749724; cv=none; b=ttWdaH5UAeW9yAHeizVIz06wlj0jLxwS/BmraMvGnydoJV2xXw8VFNAIvSdgn03WfLCAdRRsJRL9mg3hVNXZHSXjRpW2pJdHwXAz9Go2mb8Ej2eKac2kygko9OC3acTOtMjluXj0wSamY9Ev8dMkb22XWGab+N1B1OopQQLbPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749724; c=relaxed/simple;
	bh=RxztAXtPhKYvuHw96FGqU6ppN+R7tv3OUhuFjhv0B24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILMihkkrxN8KVhOnuNZV71xXVfnfLtoZ9iJ+Ia9d5O76I/n98xCIrhi1kFQIDVBKWVI7qKUsaUKahAPceDnnkcmrZoCRncn8pvZ6ZHi79QHGJG6lv8ARTZ2fmw9hLiWW1IoUgajKCrSenouo0GDJYzKc96ao9ofWNw3VpL5Q/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxfeKydP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxfeKydP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C921F00893;
	Sat,  6 Jun 2026 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749722;
	bh=CK+c31XnSkDhUQrL6SAn2sF8RHFGHI/UBtzt0SY0BfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxfeKydP4vec4B6666m6iBi/As+03z7U3vZihtKB0S0r0vjHPkJMtk3W89X6T5hcU
	 Vcrf7vjxI3owyoIkKdpPsYZk8FysgBvu2wOPAEl6rIc6GTgGyzx0dAQ5kupkvy0PYK
	 qXGfbTnFcno7VsH01JLNtVm5gjI7OQg+LQopZG9hPJ96czrh6jszW9EQWYaUdF2vkB
	 IGXSCR/TS7JfmwXU7EUpZ52odui+uBBGnf6u6MoeIlC12j1Gy9+weZULIUs9JQz3Ao
	 4AK1FVANynul8MJ+SMfWgQZ8R0Ix2y2UiMCYOkvpP+QoF2H+6dzvddI0yu59chLwMN
	 QX+/4p7MUig5Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 12/29] bpf: Add bpf_trampoline_multi_attach/detach functions
Date: Sat,  6 Jun 2026 14:39:37 +0200
Message-ID: <20260606123955.345967-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_trampoline_multi_attach/detach functions that allows to
attach/detach tracing program to multiple functions/trampolines.

The attachment is defined with bpf_program and array of BTF ids of
functions to attach the bpf program to.

Adding bpf_tracing_multi_link object that holds all the attached
trampolines and is initialized in attach and used in detach.

The attachment allocates or uses currently existing trampoline
for each function to attach and links it with the bpf program.

The attach works as follows:
- we get all the needed trampolines
- lock them and add the bpf program to each (__bpf_trampoline_link_prog)
- the trampoline_multi_ops passed in __bpf_trampoline_link_prog gathers
  ftrace_hash (ip -> trampoline) objects
- we call update_ftrace_direct_add/mod to update needed locations
- we unlock all the trampolines

The detach works as follows:
- we lock all the needed trampolines
- remove the program from each (__bpf_trampoline_unlink_prog)
- the trampoline_multi_ops passed in __bpf_trampoline_unlink_prog gathers
  ftrace_hash (ip -> trampoline) objects
- we call update_ftrace_direct_del/mod to update needed locations
- we unlock and put all the trampolines

We store the old image/flags in the trampoline before the update
and use it in case we need to rollback the attachment.

We keep the ftrace_hash objects allocated during attach in the link
so they can be used for detach as well.

Adding trampoline_(un)lock_all functions to (un)lock all trampolines
to gate the tracing_multi attachment.

Note this is supported only for archs (x86_64) with ftrace direct and
have single ops support.

  CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS &&
  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS

It also needs CONFIG_BPF_SYSCALL enabled.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h          |  43 ++++++
 include/linux/bpf_verifier.h |   4 +
 kernel/bpf/trampoline.c      | 271 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  55 +++++++
 4 files changed, 373 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b52dc64ec92d..bcf70f810d2c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -33,6 +33,7 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <linux/key.h>
+#include <linux/ftrace.h>
 #include <asm/rqspinlock.h>
 
 struct bpf_verifier_env;
@@ -1373,6 +1374,11 @@ struct bpf_trampoline {
 	int progs_cnt[BPF_TRAMP_MAX];
 	/* Executable image of trampoline */
 	struct bpf_tramp_image *cur_image;
+	/* Used as temporary old image storage for multi_attach */
+	struct {
+		struct bpf_tramp_image *old_image;
+		u32 old_flags;
+	} multi_attach;
 };
 
 struct bpf_attach_target_info {
@@ -1470,6 +1476,8 @@ static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u6
 	return 0;
 }
 
+struct bpf_tracing_multi_link;
+
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 			     struct bpf_trampoline *tr,
@@ -1482,6 +1490,11 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 
+int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+				struct bpf_tracing_multi_link *link);
+int bpf_trampoline_multi_detach(struct bpf_prog *prog,
+				struct bpf_tracing_multi_link *link);
+
 /*
  * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
  * indirection with a direct call to the bpf program. If the architecture does
@@ -1594,6 +1607,16 @@ static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 {
 	return false;
 }
+static inline int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+					      struct bpf_tracing_multi_link *link)
+{
+	return -ENOTSUPP;
+}
+static inline int bpf_trampoline_multi_detach(struct bpf_prog *prog,
+					      struct bpf_tracing_multi_link *link)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 struct bpf_func_info_aux {
@@ -1932,6 +1955,26 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+struct bpf_tracing_multi_node {
+	struct bpf_tramp_node node;
+	struct bpf_trampoline *trampoline;
+	struct ftrace_func_entry entry;
+};
+
+struct bpf_tracing_multi_data {
+	struct ftrace_hash *unreg;
+	struct ftrace_hash *modify;
+	struct ftrace_hash *reg;
+	struct ftrace_func_entry *entry;
+};
+
+struct bpf_tracing_multi_link {
+	struct bpf_link link;
+	struct bpf_tracing_multi_data data;
+	int nodes_cnt;
+	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
+};
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c248ff41f42a..d57b339a8cb8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1591,6 +1591,10 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset);
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			 struct bpf_insn *insn_buf, int insn_idx, int *cnt);
 
+/* Functions exported from verifier.c, used by trampoline.c */
+int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
+				  struct bpf_attach_target_info *tgt_info);
+
 /* Functions in fixups.c, called from bpf_check() */
 int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env);
 int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ae7e4fdfe2a3..957e5d7f9554 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1447,6 +1447,277 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return -ENOTSUPP;
 }
 
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
+    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS) && \
+    defined(CONFIG_BPF_SYSCALL)
+
+static void trampoline_lock_all(void)
+{
+	int i;
+
+	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
+		mutex_lock(&trampoline_locks[i].mutex);
+}
+
+static void trampoline_unlock_all(void)
+{
+	int i;
+
+	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
+		mutex_unlock(&trampoline_locks[i].mutex);
+}
+
+static void remove_tracing_multi_data(struct bpf_tracing_multi_data *data)
+{
+	ftrace_hash_remove(data->reg);
+	ftrace_hash_remove(data->unreg);
+	ftrace_hash_remove(data->modify);
+}
+
+static void clear_tracing_multi_data(struct bpf_tracing_multi_data *data)
+{
+	remove_tracing_multi_data(data);
+
+	free_ftrace_hash(data->reg);
+	free_ftrace_hash(data->unreg);
+	free_ftrace_hash(data->modify);
+}
+
+static int init_tracing_multi_data(struct bpf_tracing_multi_data *data)
+{
+	data->reg    = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	data->unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	data->modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+
+	if (!data->reg || !data->unreg || !data->modify) {
+		clear_tracing_multi_data(data);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void ftrace_hash_add(struct ftrace_hash *hash, struct ftrace_func_entry *entry,
+			    unsigned long ip, unsigned long direct)
+{
+	entry->ip = ip;
+	entry->direct = direct;
+	add_ftrace_hash_entry(hash, entry);
+}
+
+static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *ptr)
+{
+	unsigned long addr = (unsigned long) im->image;
+	unsigned long ip = ftrace_location(tr->ip);
+	struct bpf_tracing_multi_data *data = ptr;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+
+	ftrace_hash_add(data->reg, data->entry, ip, addr);
+	tr->cur_image = im;
+	return 0;
+}
+
+static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *ptr)
+{
+	unsigned long addr = (unsigned long) tr->cur_image->image;
+	unsigned long ip = ftrace_location(tr->ip);
+	struct bpf_tracing_multi_data *data = ptr;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+
+	ftrace_hash_add(data->unreg, data->entry, ip, addr);
+	tr->cur_image = NULL;
+	return 0;
+}
+
+static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, struct bpf_tramp_image *im,
+			       bool lock_direct_mutex, void *ptr)
+{
+	unsigned long addr = (unsigned long) im->image;
+	unsigned long ip = ftrace_location(tr->ip);
+	struct bpf_tracing_multi_data *data = ptr;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+
+	ftrace_hash_add(data->modify, data->entry, ip, addr);
+	tr->cur_image = im;
+	return 0;
+}
+
+static const struct bpf_trampoline_ops trampoline_multi_ops = {
+	.register_fentry   = register_fentry_multi,
+	.unregister_fentry = unregister_fentry_multi,
+	.modify_fentry     = modify_fentry_multi,
+};
+
+static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
+{
+	tr->multi_attach.old_image = tr->cur_image;
+	tr->multi_attach.old_flags = tr->flags;
+}
+
+static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
+{
+	if (tr->multi_attach.old_image)
+		bpf_tramp_image_put(tr->multi_attach.old_image);
+
+	tr->multi_attach.old_image = NULL;
+	tr->multi_attach.old_flags = 0;
+}
+
+static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
+{
+	if (tr->cur_image)
+		bpf_tramp_image_put(tr->cur_image);
+	tr->cur_image = tr->multi_attach.old_image;
+	tr->flags = tr->multi_attach.old_flags;
+
+	tr->multi_attach.old_image = NULL;
+	tr->multi_attach.old_flags = 0;
+}
+
+#define for_each_mnode_cnt(mnode, link, cnt) \
+	for (i = 0, mnode = &link->nodes[i]; i < cnt; i++, mnode = &link->nodes[i])
+
+#define for_each_mnode(mnode, link) \
+	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
+
+int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+				struct bpf_tracing_multi_link *link)
+{
+	struct bpf_tracing_multi_data *data = &link->data;
+	struct bpf_attach_target_info tgt_info = {};
+	struct btf *btf = prog->aux->attach_btf;
+	struct bpf_tracing_multi_node *mnode;
+	struct bpf_trampoline *tr;
+	int i, err, rollback_cnt;
+	u64 key;
+
+	for_each_mnode(mnode, link) {
+		rollback_cnt = i;
+
+		err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
+		if (err)
+			goto rollback_put;
+
+		key = bpf_trampoline_compute_key(NULL, btf, ids[i]);
+
+		tr = bpf_trampoline_get(key, &tgt_info);
+		if (!tr) {
+			err = -ENOMEM;
+			goto rollback_put;
+		}
+
+		mnode->trampoline = tr;
+		mnode->node.link = &link->link;
+
+		cond_resched();
+	}
+
+	err = init_tracing_multi_data(data);
+	if (err) {
+		rollback_cnt = link->nodes_cnt;
+		goto rollback_put;
+	}
+
+	trampoline_lock_all();
+
+	for_each_mnode(mnode, link) {
+		bpf_trampoline_multi_attach_init(mnode->trampoline);
+
+		data->entry = &mnode->entry;
+		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
+						 &trampoline_multi_ops, data);
+		if (err) {
+			rollback_cnt = i;
+			goto rollback_unlink;
+		}
+	}
+
+	rollback_cnt = link->nodes_cnt;
+	if (ftrace_hash_count(data->reg)) {
+		err = update_ftrace_direct_add(&direct_ops, data->reg);
+		if (err)
+			goto rollback_unlink;
+	}
+
+	if (ftrace_hash_count(data->modify)) {
+		err = update_ftrace_direct_mod(&direct_ops, data->modify, true);
+		if (err) {
+			if (ftrace_hash_count(data->reg))
+				WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
+			goto rollback_unlink;
+		}
+	}
+
+	for_each_mnode(mnode, link)
+		bpf_trampoline_multi_attach_free(mnode->trampoline);
+
+	trampoline_unlock_all();
+
+	remove_tracing_multi_data(data);
+	return 0;
+
+rollback_unlink:
+	for_each_mnode_cnt(mnode, link, rollback_cnt) {
+		bpf_trampoline_remove_prog(mnode->trampoline, &mnode->node);
+		bpf_trampoline_multi_attach_rollback(mnode->trampoline);
+	}
+
+	trampoline_unlock_all();
+
+	clear_tracing_multi_data(data);
+	rollback_cnt = link->nodes_cnt;
+
+rollback_put:
+	for_each_mnode_cnt(mnode, link, rollback_cnt)
+		bpf_trampoline_put(mnode->trampoline);
+
+	return err;
+}
+
+int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
+{
+	struct bpf_tracing_multi_data *data = &link->data;
+	struct bpf_tracing_multi_node *mnode;
+	int i;
+
+	trampoline_lock_all();
+
+	for_each_mnode(mnode, link) {
+		data->entry = &mnode->entry;
+		bpf_trampoline_multi_attach_init(mnode->trampoline);
+		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
+					NULL, &trampoline_multi_ops, data));
+	}
+
+	if (ftrace_hash_count(data->unreg))
+		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
+	if (ftrace_hash_count(data->modify))
+		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data->modify, true));
+
+	for_each_mnode(mnode, link)
+		bpf_trampoline_multi_attach_free(mnode->trampoline);
+
+	trampoline_unlock_all();
+
+	for_each_mnode(mnode, link)
+		bpf_trampoline_put(mnode->trampoline);
+
+	clear_tracing_multi_data(data);
+	return 0;
+}
+
+#undef for_each_mnode_cnt
+#undef for_each_mnode
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS &&
+	  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS &&
+	  CONFIG_BPF_SYSCALL */
+
 static int __init init_trampolines(void)
 {
 	int i;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf9ada761539..40770bbf9b08 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19314,6 +19314,61 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	return 0;
 }
 
+int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
+				  struct bpf_attach_target_info *tgt_info)
+{
+	const struct btf_type *t;
+	unsigned long addr;
+	const char *tname;
+	int err;
+
+	if (!btf_id || !btf)
+		return -EINVAL;
+
+	/* Check noreturn attachment. */
+	if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI &&
+	     btf_id_set_contains(&noreturn_deny, btf_id))
+		return -EINVAL;
+	/* Check denied attachment. */
+	if (btf_id_set_contains(&btf_id_deny, btf_id))
+		return -EINVAL;
+
+	/* Check and get function target data. */
+	t = btf_type_by_id(btf, btf_id);
+	if (!t)
+		return -EINVAL;
+	tname = btf_name_by_offset(btf, t->name_off);
+	if (!tname)
+		return -EINVAL;
+	if (!btf_type_is_func(t))
+		return -EINVAL;
+	t = btf_type_by_id(btf, t->type);
+	if (!btf_type_is_func_proto(t))
+		return -EINVAL;
+	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
+	if (err < 0)
+		return err;
+	if (btf_is_module(btf)) {
+		/* The bpf program already holds reference to module. */
+		if (WARN_ON_ONCE(!prog->aux->mod))
+			return -EINVAL;
+		addr = find_kallsyms_symbol_value(prog->aux->mod, tname);
+	} else {
+		addr = kallsyms_lookup_name(tname);
+	}
+	if (!addr || !ftrace_location(addr))
+		return -ENOENT;
+
+	/* Check sleepable program attachment. */
+	if (prog->sleepable) {
+		err = btf_id_allow_sleepable(btf_id, addr, prog, btf);
+		if (err)
+			return err;
+	}
+	tgt_info->tgt_addr = addr;
+	return 0;
+}
+
 struct btf *bpf_get_btf_vmlinux(void)
 {
 	if (!btf_vmlinux && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-- 
2.54.0

