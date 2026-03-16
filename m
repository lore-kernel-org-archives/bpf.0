Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244F24E4AF;
	Mon, 16 Mar 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647625; cv=none; b=hWCyndcGIoilvDeb+R9kKy34HkZWXT01vyr5cLWiw2OacqASLBHFJuxcsayTLBjBBvCI91mf5A3/9aEMe5jsiNsNUbfkScIYhxU9oaYyFqPPyR0iglrFsRc6N1oklu4iNbk7SiPiUSnL2JmM2ypSXaSpmG07IzXQeNzpr5dcypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647625; c=relaxed/simple;
	bh=fGWK5x0bhwFYNlx9peGEaI7bRB08N3tSrwCijsLGehs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iy/dqPPXeCL1becSh7XY8tDF2li5EBTdOklr8YOi4K9hxaz3wBw0+mPZn4lP2QvdMUMABLvv7KuL5XLvdcRekHRYXi2h+FAepP2ZgpzQu5NBRAhpWAuOK+wGw/qQPb2JMNmR48xLhscES+/DxEVB2FRBIsygXcbMj21AwUHE3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyijss7R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyijss7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C86C19424;
	Mon, 16 Mar 2026 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647624;
	bh=fGWK5x0bhwFYNlx9peGEaI7bRB08N3tSrwCijsLGehs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lyijss7RyGWOisg9PaAuSZkim54HAwpAZSCDkrZ5pJhFvAr6s2I0DaUbU8ZlV7Z5A
	 YtMPG0hMrArQT76gC6XWiToZvKsQ7ixgRp9TcvvWIJUmQrv46ofve95PdHd5IntOUe
	 SQ5wsb6k211vsKdBMu1M2PE9yA1dirPT3E8SXTbE81iHa1MgyR1RwadXRo4CSwDrtq
	 whP7N7KXvyy/XTLF9z7GuS/Fzra+hOUis8pmsAo54doM9KMJKsZWSNV3tArQ2/ABTw
	 /J+X2tGGdiTadylfX+hn94jEuzdZt5jMK0dr3zCKZAvJ29tNvxaUKJyf+LuPTTty59
	 nAhRScuBdcz+A==
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
Subject: [PATCHv3 bpf-next 11/24] bpf: Add support for tracing_multi link session
Date: Mon, 16 Mar 2026 08:51:25 +0100
Message-ID: <20260316075138.465430-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
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
 kernel/bpf/syscall.c           |  1 +
 kernel/bpf/trampoline.c        | 43 +++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c          | 17 ++++++++++----
 kernel/trace/bpf_trace.c       | 15 +++++++++++-
 net/bpf/test_run.c             |  1 +
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         |  1 +
 10 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a919143a8b35..55f373464da3 100644
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
index c8738834bbc9..668a31952510 100644
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
index 94c6a9c81ef0..c13cb812a1d3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4388,6 +4388,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
 	case BPF_TRACE_FENTRY_MULTI:
 	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c0450fb16bd4..24bedf84c767 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -199,7 +199,8 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 		if (eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
 		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION ||
-		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI)
+		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI ||
+		    eatype == BPF_TRACE_FSESSION_MULTI)
 			return true;
 		return false;
 	case BPF_PROG_TYPE_LSM:
@@ -796,6 +797,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	case BPF_TRACE_FEXIT_MULTI:
 		return BPF_TRAMP_FEXIT;
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
 		return BPF_TRAMP_FSESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
@@ -828,15 +830,34 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
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
@@ -884,8 +905,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
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
@@ -895,7 +916,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		hlist_del_init(&node->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
 			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
-			hlist_del_init(&tr_link->fexit.tramp_hlist);
+			hlist_del_init(&fexit->tramp_hlist);
 			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		} else {
 			tr->progs_cnt[kind]--;
@@ -936,10 +957,9 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
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
@@ -1580,6 +1600,11 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
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
index 7085688eb719..aa25e5bbcd1e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17959,6 +17959,7 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 		case BPF_TRACE_FSESSION:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_TRACE_FSESSION_MULTI:
 			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23348,7 +23349,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		   (env->prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		    env->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 		/*
 		 * inline the bpf_session_is_return() for fsession:
 		 *   bool bpf_session_is_return(void *ctx)
@@ -23361,7 +23363,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		   (env->prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		    env->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 		/*
 		 * inline bpf_session_cookie() for fsession:
 		 *   __u64 *bpf_session_cookie(void *ctx)
@@ -24149,6 +24152,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			if (eatype == BPF_TRACE_FEXIT ||
 			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_TRACE_FEXIT_MULTI ||
+			    eatype == BPF_TRACE_FSESSION_MULTI ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -25229,7 +25233,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -25329,9 +25334,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -25482,6 +25489,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FSESSION_MULTI:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
 			return true;
@@ -25566,6 +25574,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
 		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5e3ff9ffc0ab..761501ce3a5f 100644
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
@@ -3612,6 +3613,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->fexits);
 	kvfree(tr_link->cookies);
 	kvfree(tr_link);
 }
@@ -3624,6 +3626,7 @@ static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
 int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 {
 	struct bpf_tracing_multi_link *link = NULL;
+	struct bpf_tramp_node *fexits = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
 	u64 __user *ucookies;
@@ -3663,6 +3666,14 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		}
 	}
 
+	if (prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) {
+		fexits = kvmalloc_objs(*fexits, cnt);
+		if (!fexits) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
 	link = kvzalloc_flex(*link, nodes, cnt);
 	if (!link) {
 		err = -ENOMEM;
@@ -3678,6 +3689,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 
 	link->nodes_cnt = cnt;
 	link->cookies = cookies;
+	link->fexits = fexits;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3688,6 +3700,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(fexits);
 	kvfree(cookies);
 	kvfree(ids);
 	kvfree(link);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index df7ae2c28a3b..fad293f03e0c 100644
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
index 9f26ad0d7bce..06fb382557b4 100644
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
2.53.0

