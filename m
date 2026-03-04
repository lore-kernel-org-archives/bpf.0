Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DB377EA6;
	Wed,  4 Mar 2026 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662995; cv=none; b=WuPumEZZSxL9xsnoDjgMfkSo+IHeyrx4CZSY1MAE3BXxGfvLgLwDQWTivQKJMgwe+osdidzVWHVxDfPyPmZF4UB2Nu8hvO7XjRlydTO1PN+3sVACHXdRdM8enOmzYIts5XW8LuEpThos18aPwSi1qOCXFXyOurXbTqSKK+3OaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662995; c=relaxed/simple;
	bh=brhgQm72s/WYPH4hSEFm4S25RNyIH2enZ7W9yhBsRKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQclC6FvsGPOlXbjqxoKNaQXDCf6w94Rfp10LATJo/3m3/ZVXre1e5PYZbAFZQHhvciWGFciCLPATZmp0wUMlH0ebxplYOOT5XWlDwAHPMkgMsgV9c4jy+hDL1S+gHEaDV7KJvSeTuZ2VcwW13HiUdycX2sbr/7ucd26T4S9QZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs8oKbgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs8oKbgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59304C4CEF7;
	Wed,  4 Mar 2026 22:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662995;
	bh=brhgQm72s/WYPH4hSEFm4S25RNyIH2enZ7W9yhBsRKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xs8oKbgRAWu7fGspG3lUzAXQ0m//qhakNc6fRK+7MfbkB1xZJxTHAOzVfMtqr8LwQ
	 cv/3ml0p7AhsecO9RgbAmTsDixsgpPFWyzroPhIE0sPP+QM9l+G3oXzUwekBjK5We+
	 3djnK+QeHLwh3TAtW1aHSFMA9fcJH60YIf4gpShRcBmMQhuwpWjtN+/aGXgTntKbMt
	 ehTfSDYJZUR/CRWAyzOfX8ahPDhANjQlLgdOgdDx92XDRoqS4PAX1jE6LjTEGd2eyr
	 Ud0k90OoubjdAHLePK+vStO2w6t7ah7g0xj62pWoS4T5blQraqJB1wkYiZyOexW9XB
	 yJUZ43ANNigrQ==
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
Subject: [PATCHv2 bpf-next 08/23] bpf: Add bpf_trampoline_multi_attach/detach functions
Date: Wed,  4 Mar 2026 23:21:26 +0100
Message-ID: <20260304222141.497203-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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
- the trampoline_multi_ops passed in __bpf_trampoline_link_prog gathers
  ftrace_hash (ip -> trampoline) objects
- we call update_ftrace_direct_del/mod to update needed locations
- we unlock and put all the trampolines

Adding trampoline_(un)lock_all functions to (un)lock all trampolines
to gate the tracing_multi attachment.

Note this is supported only for archs (x86_64) with ftrace direct and
have single ops support.

  CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS &&
  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  17 +++
 kernel/bpf/trampoline.c | 243 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 260 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c401b308a325..f22b9400a915 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1464,6 +1464,12 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
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
@@ -1888,6 +1894,17 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+struct bpf_tracing_multi_node {
+	struct bpf_tramp_node node;
+	struct bpf_trampoline *trampoline;
+};
+
+struct bpf_tracing_multi_link {
+	struct bpf_link link;
+	int nodes_cnt;
+	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
+};
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e2f4a15886b0..c42bf16b6807 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -88,6 +88,22 @@ static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsig
 	mutex_unlock(&trampoline_mutex);
 	return tr;
 }
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
 #else
 static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
 {
@@ -1426,6 +1442,233 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return -ENOTSUPP;
 }
 
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
+    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
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
+	unsigned long addr = (unsigned long) new_addr;
+	unsigned long ip = ftrace_location(tr->ip);
+	struct fentry_multi_data *data = ptr;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+	return add_ftrace_hash_entry_direct(data->reg, ip, addr) ? 0 : -ENOMEM;
+}
+
+static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
+				   void *ptr)
+{
+	unsigned long addr = (unsigned long) old_addr;
+	unsigned long ip = ftrace_location(tr->ip);
+	struct fentry_multi_data *data = ptr;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+	return add_ftrace_hash_entry_direct(data->unreg, ip, addr) ? 0 : -ENOMEM;
+}
+
+static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
+			       void *new_addr, bool lock_direct_mutex, void *ptr)
+{
+	unsigned long addr = (unsigned long) new_addr;
+	unsigned long ip = ftrace_location(tr->ip);
+	struct fentry_multi_data *data = ptr;
+
+	if (bpf_trampoline_use_jmp(tr->flags))
+		addr = ftrace_jmp_set(addr);
+	return add_ftrace_hash_entry_direct(data->modify, ip, addr) ? 0 : -ENOMEM;
+}
+
+static struct bpf_trampoline_ops trampoline_multi_ops = {
+	.register_fentry   = register_fentry_multi,
+	.unregister_fentry = unregister_fentry_multi,
+	.modify_fentry     = modify_fentry_multi,
+};
+
+static int bpf_get_btf_id_target(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
+				 struct bpf_attach_target_info *tgt_info)
+{
+	const struct btf_type *t;
+	unsigned long addr;
+	const char *tname;
+	int err;
+
+	if (!btf_id || !btf)
+		return -EINVAL;
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
+		/* The bpf program already holds refference to module. */
+		if (WARN_ON_ONCE(!prog->aux->mod))
+			return -EINVAL;
+		addr = find_kallsyms_symbol_value(prog->aux->mod, tname);
+	} else {
+		addr = kallsyms_lookup_name(tname);
+	}
+	if (!addr || !ftrace_location(addr))
+		return -ENOENT;
+	tgt_info->tgt_addr = addr;
+	return 0;
+}
+
+int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+				struct bpf_tracing_multi_link *link)
+{
+	struct bpf_attach_target_info tgt_info = {};
+	struct btf *btf = prog->aux->attach_btf;
+	struct bpf_tracing_multi_node *mnode;
+	int j, i, err, cnt = link->nodes_cnt;
+	struct fentry_multi_data data;
+	struct bpf_trampoline *tr;
+	u32 btf_id;
+	u64 key;
+
+	data.reg    = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	data.unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+
+	if (!data.reg || !data.unreg || !data.modify) {
+		free_fentry_multi_data(&data);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		btf_id = ids[i];
+
+		err = bpf_get_btf_id_target(btf, prog, btf_id, &tgt_info);
+		if (err)
+			goto rollback_put;
+
+		if (prog->sleepable) {
+			err = btf_id_allow_sleepable(btf_id, tgt_info.tgt_addr, prog, btf);
+			if (err)
+				goto rollback_put;
+		}
+
+		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, btf_id);
+
+		tr = bpf_trampoline_get(key, &tgt_info);
+		if (!tr) {
+			err = -ENOMEM;
+			goto rollback_put;
+		}
+
+		mnode = &link->nodes[i];
+		mnode->trampoline = tr;
+		mnode->node.link = &link->link;
+	}
+
+	trampoline_lock_all();
+
+	for (i = 0; i < cnt; i++) {
+		mnode = &link->nodes[i];
+		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
+						 &trampoline_multi_ops, &data);
+		if (err)
+			goto rollback_unlink;
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
+	trampoline_unlock_all();
+
+	free_fentry_multi_data(&data);
+	return 0;
+
+rollback_unlink:
+	for (j = 0; j < i; j++) {
+		mnode = &link->nodes[j];
+		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
+					NULL, &trampoline_multi_ops, &data));
+	}
+	trampoline_unlock_all();
+
+	i = cnt;
+
+rollback_put:
+	for (j = 0; j < i; j++)
+		bpf_trampoline_put(link->nodes[j].trampoline);
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
+
+	data.unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+
+	if (!data.unreg || !data.modify) {
+		free_ftrace_hash(data.unreg);
+		return -ENOMEM;
+	}
+
+	trampoline_lock_all();
+
+	for (i = 0; i < cnt; i++) {
+		mnode = &link->nodes[i];
+		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
+					NULL, &trampoline_multi_ops, &data));
+	}
+
+	if (ftrace_hash_count(data.unreg))
+		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data.unreg));
+	if (ftrace_hash_count(data.modify))
+		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data.modify, true));
+
+	trampoline_unlock_all();
+
+	for (i = 0; i < cnt; i++)
+		bpf_trampoline_put(link->nodes[i].trampoline);
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
2.53.0

