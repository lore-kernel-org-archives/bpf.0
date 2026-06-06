Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8273AE183;
	Sat,  6 Jun 2026 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749754; cv=none; b=HNwPPTmLFOQ+kcmGOdbTM05WJd2VXSOUJ+6INmaNdrM4iQqgVd7PyZZIsAPKlLy+uSDfSIfROWjcqAUFm/vzXv3/oyMHyzP5ubif7rVQjAu1V5hlUYpcY6Z3u0FlUBBIZxz2LjNgQEsAO6ZnuoV1417LJj0z9l/70cUMIc3o9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749754; c=relaxed/simple;
	bh=aznfcaH79DYT1gJrY0IbpYalBYuMnbGclZb1p3zjsUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3ysv9Adz5IpxeRbR3lSQbZujB3ZJAzR7AISiboUdQmYtcYcqH8ttdzcea1z8a4bSgdKX5/1WO1IaYIqImmdimKLB0hb10g4arfIXb8gbxLdiEadAVdVtJGJuKpAegae5vWtL6NxPH+P4u6NjydZlsiGZ+TsZ7LHLkPI8xh7Y8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft+VknGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft+VknGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A1C1F00898;
	Sat,  6 Jun 2026 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749752;
	bh=7GigfTesLtQfcYGzPS+I3Ir7bcLgMT23E4cyGbqJ07M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ft+VknGpQLiFEhpmb3nmv1gFksNV/JWqkDiT9Qol+VmhRw81h328YrlfmEGNBXloN
	 z7p1+tDvPU2Kw8xp7gsVXsjxbCzQCiUuxUeuUMNfp3rZ8p90gBRjHLJAM8U43y1OIR
	 BB+oOrlSDynpu87e9YzxCahObae2QE1sM5R+H7IJCBJP2IBDeazH81VHcpFtyoywBc
	 NM1YB8KFVjNRAGvMmihyJLAJ+XMAizbRXhnnkbSOIqClIF7UrYAZQz5N63irTB/Y3f
	 25iun+6xpK5j/NZRf9fifnGANH+YswdMYOzNnJUQCvz+qN4n21z5S8SyZ7TsJH3Hwp
	 hKrBh3JbMobvw==
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
Subject: [PATCHv8 bpf-next 15/29] bpf: Add support for tracing_multi link session
Date: Sat,  6 Jun 2026 14:39:40 +0200
Message-ID: <20260606123955.345967-16-jolsa@kernel.org>
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

Adding support to use session attachment with tracing_multi link.

Adding new BPF_TRACE_FSESSION_MULTI program attach type, that follows
the BPF_TRACE_FSESSION behaviour but on the tracing_multi link.

Such program is called on entry and exit of the attached function
and allows to pass cookie value from entry to exit execution.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  6 ++++-
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/fixups.c            |  1 +
 kernel/bpf/syscall.c           |  1 +
 kernel/bpf/trampoline.c        | 44 +++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c          | 20 ++++++++++++----
 kernel/trace/bpf_trace.c       | 15 +++++++++++-
 net/bpf/test_run.c             |  1 +
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         |  1 +
 10 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e9d2b42a3981..62bba7a4876f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1972,6 +1972,7 @@ struct bpf_tracing_multi_link {
 	struct bpf_link link;
 	struct bpf_tracing_multi_data data;
 	u64 *cookies;
+	struct bpf_tramp_node *fexits;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
@@ -2159,7 +2160,8 @@ static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
 
 static inline bool is_tracing_multi(enum bpf_attach_type type)
 {
-	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI;
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI ||
+	       type == BPF_TRACE_FSESSION_MULTI;
 }
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
@@ -2286,6 +2288,8 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
 	for (int i = 0; i < nodes[BPF_TRAMP_FENTRY].nr_nodes; i++) {
 		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION)
 			cnt++;
+		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)
+			cnt++;
 	}
 
 	return cnt;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 569c15e1cae3..11dd610fa5fa 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1158,6 +1158,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FSESSION,
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
+	BPF_TRACE_FSESSION_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 0cf9735929f5..3cf2cc6e3ab6 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2187,6 +2187,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			if (eatype == BPF_TRACE_FEXIT ||
 			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_TRACE_FEXIT_MULTI ||
+			    eatype == BPF_TRACE_FSESSION_MULTI ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d551b9da0cfb..d4188a992bd8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4498,6 +4498,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
 	case BPF_TRACE_FENTRY_MULTI:
 	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index a3537fda50cf..1a721fc4bef5 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -183,7 +183,8 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 		if (eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
 		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION ||
-		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI)
+		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI ||
+		    eatype == BPF_TRACE_FSESSION_MULTI)
 			return true;
 		return false;
 	case BPF_PROG_TYPE_LSM:
@@ -790,6 +791,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	case BPF_TRACE_FEXIT_MULTI:
 		return BPF_TRAMP_FEXIT;
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
 		return BPF_TRAMP_FSESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
@@ -822,13 +824,30 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
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
+	return NULL;
+}
+
 static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 				   struct bpf_tramp_node *node,
 				   int cnt)
 {
-	struct bpf_tracing_link *tr_link = NULL;
 	enum bpf_tramp_prog_type kind;
-	struct bpf_tramp_node *node_existing;
+	struct bpf_tramp_node *node_existing, *fexit;
 	struct hlist_head *prog_list;
 
 	kind = bpf_attach_type_to_tramp(node->link->prog);
@@ -853,8 +872,10 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 	hlist_add_head(&node->tramp_hlist, prog_list);
 	if (kind == BPF_TRAMP_FSESSION) {
 		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
-		tr_link = container_of(node, struct bpf_tracing_link, link.node);
-		hlist_add_head(&tr_link->fexit.tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		fexit = fsession_exit(node);
+		if (WARN_ON_ONCE(!fexit))
+			return -EINVAL;
+		hlist_add_head(&fexit->tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
 	} else {
 		tr->progs_cnt[kind]++;
@@ -865,13 +886,15 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 static void bpf_trampoline_remove_prog(struct bpf_trampoline *tr,
 				       struct bpf_tramp_node *node)
 {
-	struct bpf_tracing_link *tr_link;
 	enum bpf_tramp_prog_type kind;
+	struct bpf_tramp_node *fexit;
 
 	kind = bpf_attach_type_to_tramp(node->link->prog);
 	if (kind == BPF_TRAMP_FSESSION) {
-		tr_link = container_of(node, struct bpf_tracing_link, link.node);
-		hlist_del_init(&tr_link->fexit.tramp_hlist);
+		fexit = fsession_exit(node);
+		if (WARN_ON_ONCE(!fexit))
+			return;
+		hlist_del_init(&fexit->tramp_hlist);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		kind = BPF_TRAMP_FENTRY;
 	}
@@ -1615,6 +1638,11 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 		mnode->node.link = &link->link;
 		mnode->node.cookie = link->cookies ? link->cookies[i] : 0;
 
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) {
+			link->fexits[i].link = &link->link;
+			link->fexits[i].cookie = link->cookies ? link->cookies[i] : 0;
+		}
+
 		cond_resched();
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 40770bbf9b08..9f62d61db08f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16372,6 +16372,7 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 		case BPF_TRACE_FSESSION:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_TRACE_FSESSION_MULTI:
 			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -18940,7 +18941,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -19046,9 +19048,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -19203,6 +19207,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_RAW_TP:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_TRACE_FSESSION_MULTI:
 			return true;
 		default:
 			return false;
@@ -19287,6 +19292,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
 		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
@@ -19326,7 +19332,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 		return -EINVAL;
 
 	/* Check noreturn attachment. */
-	if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI &&
+	if ((prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+	     prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) &&
 	     btf_id_set_contains(&noreturn_deny, btf_id))
 		return -EINVAL;
 	/* Check denied attachment. */
@@ -19609,7 +19616,9 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		   (env->prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		    env->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
+
 		/*
 		 * inline the bpf_session_is_return() for fsession:
 		 *   bool bpf_session_is_return(void *ctx)
@@ -19622,7 +19631,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		   (env->prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		    env->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 		/*
 		 * inline bpf_session_cookie() for fsession:
 		 *   __u64 *bpf_session_cookie(void *ctx)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e33492739ed1..a0d688fffc5a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1334,7 +1334,8 @@ static inline bool is_uprobe_session(const struct bpf_prog *prog)
 static inline bool is_trace_fsession(const struct bpf_prog *prog)
 {
 	return prog->type == BPF_PROG_TYPE_TRACING &&
-	       prog->expected_attach_type == BPF_TRACE_FSESSION;
+	       (prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI);
 }
 
 static const struct bpf_func_proto *
@@ -3659,6 +3660,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->fexits);
 	kvfree(tr_link->cookies);
 	kvfree(tr_link);
 }
@@ -3718,6 +3720,7 @@ static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 {
 	struct bpf_tracing_multi_link *link = NULL;
+	struct bpf_tramp_node *fexits = NULL;
 	struct bpf_link_primer link_primer;
 	u32 cnt, *ids = NULL;
 	u64 __user *ucookies;
@@ -3761,6 +3764,14 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	if (err)
 		goto error;
 
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
@@ -3776,6 +3787,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 
 	link->nodes_cnt = cnt;
 	link->cookies = cookies;
+	link->fexits = fexits;
 
 	err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
@@ -3786,6 +3798,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	return bpf_link_settle(&link_primer);
 
 error:
+	kvfree(fexits);
 	kvfree(cookies);
 	kvfree(ids);
 	kvfree(link);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 67769c700cae..a831682ee982 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -705,6 +705,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	case BPF_TRACE_FSESSION:
 	case BPF_TRACE_FENTRY_MULTI:
 	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION_MULTI:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 569c15e1cae3..11dd610fa5fa 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1158,6 +1158,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FSESSION,
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
+	BPF_TRACE_FSESSION_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 59405d318624..62f088359c5e 100644
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
2.54.0

