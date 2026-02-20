Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B0337B8F;
	Fri, 20 Feb 2026 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582154; cv=none; b=WVFs+QhMTDiVjQScuLx77PjofYWubDEnoOnfWxZVpIrmHQFrgu8eK/ER3Ef0O7eNKBDwVnpJ5Fjg5VUjC+IvF2ZcUsg7CUH9m5GfexwlvVBfTOkwDIN8eQ9SchRlM+wQljIPOnDfg8SyrG119NADaggGZQ+lptFxeqE6m4y7Bqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582154; c=relaxed/simple;
	bh=wbiCdaBTXkGG0ymRzZhVn92np9q3TxuiSJmrAP3d+/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFaXo93kBjqfVrmGr20fEIyeHx8oJdU7RXazY6FKWpYSUfmLzJ/WDaNZL80l8aZQmx/9H5ZIpMeLUiD5nLejyU+r/h8Qkr8R0qo7THAYlq93d0UJ7PdPq5kx4hCEIdUzMkRIvxOMzGrlwdamLNVq6o756UA1FO0RpU2JRXwkXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv/N/KDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv/N/KDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1E8C116C6;
	Fri, 20 Feb 2026 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582153;
	bh=wbiCdaBTXkGG0ymRzZhVn92np9q3TxuiSJmrAP3d+/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bv/N/KDkQsFXZ91/i/RAl2fesXkAPqmomyvzlCoT1d4HPtI0TNclY3fFiPI28toGe
	 zuc75yniDkZSE0g8epQDGHcwXeLuxj/9lTvWqG+TgNcTbU58QWnut4RyZh03gMYQZP
	 O7TDdfYAEGksnOWWWc6XTu9clQeTz6VO0Mz0hhUf6Q0n8cGVhtD0h5fLTTc6nJrX8Q
	 AS3gt2diKClIQH2V3q+fJHsSJRCcrYKDd2/LS+NTWZdLy9WraufCRMWEF3dZ8wNaQm
	 a4orD4fyRqjrBZ7jM7DYkxTvEthtG4vqUGCY8mdwX9i0c6IEBd+dl8cfcW65FhlSdG
	 L4EAQFDj53tiw==
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
Subject: [PATCH bpf-next 10/17] bpf: Add support for tracing_multi link session
Date: Fri, 20 Feb 2026 11:06:42 +0100
Message-ID: <20260220100649.628307-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to use session attachment with tracing_multi link.

Adding new BPF_TRACE_FSESSION_MULTI program attach type, that follows
the BPF_TRACE_FSESSION behaviour but on the tracing_multi link.

Such program is called on entry and exit of the attached function
and allows to pass cookie value from entry to exit execution.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  6 ++++-
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/btf.c               |  2 ++
 kernel/bpf/syscall.c           |  2 ++
 kernel/bpf/trampoline.c        | 43 +++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c          | 17 ++++++++++----
 kernel/trace/bpf_trace.c       | 15 +++++++++++-
 net/bpf/test_run.c             |  1 +
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         |  1 +
 10 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 63a06c85103b..570c5b8c9cc2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1902,6 +1902,7 @@ struct bpf_tracing_multi_node {
 struct bpf_tracing_multi_link {
 	struct bpf_link link;
 	u64 *cookies;
+	struct bpf_tramp_node *fexits;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
@@ -2136,7 +2137,8 @@ u32 bpf_struct_ops_id(const void *kdata);
 
 static inline bool is_tracing_multi(enum bpf_attach_type type)
 {
-	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI;
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI ||
+	       type == BPF_TRACE_FSESSION_MULTI;
 }
 
 #ifdef CONFIG_NET
@@ -2213,6 +2215,8 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
 	for (int i = 0; i < nodes[BPF_TRAMP_FENTRY].nr_nodes; i++) {
 		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION)
 			cnt++;
+		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)
+			cnt++;
 	}
 
 	return cnt;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e28722ddeb5b..4520830fda06 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1156,6 +1156,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FSESSION,
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
+	BPF_TRACE_FSESSION_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 07d1e88e3524..f8e245cec369 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6221,6 +6221,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FSESSION_MULTI:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
 			/* allow u64* as ctx */
@@ -6825,6 +6826,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FSESSION_MULTI:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5892dca20b7e..1cd6c1457bd3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3611,6 +3611,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
 		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
+		    prog->expected_attach_type != BPF_TRACE_FSESSION_MULTI &&
 		    prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
@@ -4390,6 +4391,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
 	case BPF_TRACE_FENTRY_MULTI:
 	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 516c27b89701..fe0cb5048f39 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -206,7 +206,8 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 		if (eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
 		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION ||
-		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI)
+		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI ||
+		    eatype == BPF_TRACE_FSESSION_MULTI)
 			return true;
 		return false;
 	case BPF_PROG_TYPE_LSM:
@@ -808,6 +809,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	case BPF_TRACE_FEXIT_MULTI:
 		return BPF_TRAMP_FEXIT;
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
 		return BPF_TRAMP_FSESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
@@ -840,15 +842,34 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 	return 0;
 }
 
+static struct bpf_tramp_node *fsession_exit(struct bpf_tramp_node *node)
+{
+	if (node->link->type == BPF_LINK_TYPE_TRACING) {
+		struct bpf_tracing_link *link;
+
+		link = container_of(node->link, struct bpf_tracing_link, link.link);
+		return &link->fexit;
+	} else if (node->link->type == BPF_LINK_TYPE_TRACING_MULTI) {
+		struct bpf_tracing_multi_link *link;
+		struct bpf_tracing_multi_node *mnode;
+
+		link = container_of(node->link, struct bpf_tracing_multi_link, link);
+		mnode = container_of(node, struct bpf_tracing_multi_node, node);
+		return &link->fexits[mnode - link->nodes];
+	}
+
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
 static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 				      struct bpf_trampoline *tr,
 				      struct bpf_prog *tgt_prog,
 				      struct bpf_trampoline_ops *ops,
 				      void *data)
 {
-	struct bpf_tracing_link *tr_link = NULL;
 	enum bpf_tramp_prog_type kind;
-	struct bpf_tramp_node *node_existing;
+	struct bpf_tramp_node *node_existing, *fexit;
 	struct hlist_head *prog_list;
 	int err = 0;
 	int cnt = 0, i;
@@ -896,8 +917,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 	hlist_add_head(&node->tramp_hlist, prog_list);
 	if (kind == BPF_TRAMP_FSESSION) {
 		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
-		tr_link = container_of(node, struct bpf_tracing_link, link.node);
-		hlist_add_head(&tr_link->fexit.tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		fexit = fsession_exit(node);
+		hlist_add_head(&fexit->tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
 	} else {
 		tr->progs_cnt[kind]++;
@@ -907,7 +928,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		hlist_del_init(&node->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
 			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
-			hlist_del_init(&tr_link->fexit.tramp_hlist);
+			hlist_del_init(&fexit->tramp_hlist);
 			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		} else {
 			tr->progs_cnt[kind]--;
@@ -948,10 +969,9 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 		tgt_prog->aux->is_extended = false;
 		return err;
 	} else if (kind == BPF_TRAMP_FSESSION) {
-		struct bpf_tracing_link *tr_link =
-			container_of(node, struct bpf_tracing_link, link.node);
+		struct bpf_tramp_node *fexit = fsession_exit(node);
 
-		hlist_del_init(&tr_link->fexit.tramp_hlist);
+		hlist_del_init(&fexit->tramp_hlist);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		kind = BPF_TRAMP_FENTRY;
 	}
@@ -1547,6 +1567,11 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 		mnode->trampoline = tr;
 		mnode->node.link = &link->link;
 		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
+
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) {
+			link->fexits[i].link = &link->link;
+			link->fexits[i].cookie = link->cookies ? link->cookies[i] : 0;
+		}
 	}
 
 	trampoline_lock_all();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c9303103a9c..1f5c675be51b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17913,6 +17913,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		case BPF_TRACE_FSESSION:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_TRACE_FSESSION_MULTI:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23163,7 +23164,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		   (env->prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		    env->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 		/*
 		 * inline the bpf_session_is_return() for fsession:
 		 *   bool bpf_session_is_return(void *ctx)
@@ -23176,7 +23178,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		   (env->prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		    env->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 		/*
 		 * inline bpf_session_cookie() for fsession:
 		 *   __u64 *bpf_session_cookie(void *ctx)
@@ -23964,6 +23967,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			if (eatype == BPF_TRACE_FEXIT ||
 			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_TRACE_FEXIT_MULTI ||
+			    eatype == BPF_TRACE_FSESSION_MULTI ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24921,7 +24925,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -25021,9 +25026,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
 	case BPF_TRACE_FENTRY_MULTI:
 	case BPF_TRACE_FEXIT_MULTI:
-		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
+		if ((prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		    prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) &&
 		    !bpf_jit_supports_fsession()) {
 			bpf_log(log, "JIT does not support fsession\n");
 			return -EOPNOTSUPP;
@@ -25195,6 +25202,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FSESSION_MULTI:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
 			return true;
@@ -25281,6 +25289,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
 		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 927fa622c5ea..76ce756f6210 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1306,7 +1306,8 @@ static inline bool is_uprobe_session(const struct bpf_prog *prog)
 static inline bool is_trace_fsession(const struct bpf_prog *prog)
 {
 	return prog->type == BPF_PROG_TYPE_TRACING &&
-	       prog->expected_attach_type == BPF_TRACE_FSESSION;
+	       (prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI);
 }
 
 static const struct bpf_func_proto *
@@ -3609,6 +3610,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->fexits);
 	kvfree(tr_link->cookies);
 	kfree(tr_link);
 }
@@ -3621,6 +3623,7 @@ static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
 int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 {
 	struct bpf_tracing_multi_link *link = NULL;
+	struct bpf_tramp_node *fexits = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
 	u64 *cookies = NULL;
@@ -3658,6 +3661,14 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		}
 	}
 
+	if (prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) {
+		fexits = kvmalloc_array(cnt, sizeof(*fexits), GFP_KERNEL);
+		if (!fexits) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
 	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
 	if (!link) {
 		err = -ENOMEM;
@@ -3673,6 +3684,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 
 	link->nodes_cnt = cnt;
 	link->cookies = cookies;
+	link->fexits = fexits;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3683,6 +3695,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(fexits);
 	kvfree(cookies);
 	kvfree(ids);
 	kfree(link);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 3373450132f0..1aa07d40c80c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -688,6 +688,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	case BPF_TRACE_FSESSION:
 	case BPF_TRACE_FENTRY_MULTI:
 	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION_MULTI:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e28722ddeb5b..4520830fda06 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1156,6 +1156,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FSESSION,
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
+	BPF_TRACE_FSESSION_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 74e579d7f310..1eb3869e3444 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -138,6 +138,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_UPROBE_SESSION]	= "trace_uprobe_session",
 	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
 	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
+	[BPF_TRACE_FSESSION_MULTI]	= "trace_fsession_multi",
 };
 
 static const char * const link_type_name[] = {
-- 
2.52.0

