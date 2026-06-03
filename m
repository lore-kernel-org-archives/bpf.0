Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952B1E3DDE;
	Wed,  3 Jun 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484919; cv=none; b=YYonU/HxRV+W17Li5fkXlYI9yF3N0SAaOJ5eVwGDrgTX14dSo4s9q4jaAHqnmpcBNKpxQ6A6LQE8WgYY5R6DI3I4N8dWfO1pHqLLj4g02wjWBhNJQwLpXzl/rhkFHDyE8BjUnBbowpxyFHuE6Lx+AWC5QgFwPV4QUA0tK//O8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484919; c=relaxed/simple;
	bh=OqZ/edVB4m8Rin/Yjj3wY7nIJG45+RG2OXv3tPMn7F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go9jgO4gp8dQsglL+0FisGi4BnuVW+qI7ynVtiZyt/CeYAS7fBy2OI8qmqTeC7uc6NJGbHFsb104PRB2/Cty29Y7ZfHhfzJeCB73AlsTqbCPJ+tAuJiz0wZcR/5qfLzhst1eyV46xj43dtc/ZOYwD5bW8wOdfuUMKK2Ym4tLW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhe7bxBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhe7bxBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C18D1F00893;
	Wed,  3 Jun 2026 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484918;
	bh=r/YUYhnqLsPy97/WO9b04WXbpKzycSDOi8kYn+K/5PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhe7bxBGww2ITUoxCbM0URKypANL5nQS+XWeLCSpWQXailv2+hM3vXGaYrQXGBblo
	 PCfSW6tvi155Y4/TxuQ3re1OwHQyK0IrjgNp/DiImVYvvNcQR+VoVRQJmaU5LgbKXh
	 9hrl8UcmVIIYMSiE9j2uxTMYrw7Lr9JDQEDkL/bt0pCHFoyl+97wfWDFBAvNjW+SEn
	 6mejQ0pESkJS+fi3oLGiaO3uP6ks8WM++Wll4oBvvX7dIYaV+OWBYUuoyJSxXUn2v0
	 +HSyJibVfsCfcLD91a2ZdWlWIVMSjRzWIsMu0OfSa9359sRNYIwm6S9m1FodJFnyAJ
	 ysygztLJL3qWA==
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
Subject: [PATCHv7 bpf-next 15/29] bpf: Add support for tracing_multi link session
Date: Wed,  3 Jun 2026 13:05:39 +0200
Message-ID: <20260603110554.29590-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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
index 2da0de17275a..5bbd36e8f8c6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1953,6 +1953,7 @@ struct bpf_tracing_multi_link {
 	struct bpf_link link;
 	struct bpf_tracing_multi_data data;
 	u64 *cookies;
+	struct bpf_tramp_node *fexits;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
@@ -2140,7 +2141,8 @@ static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
 
 static inline bool is_tracing_multi(enum bpf_attach_type type)
 {
-	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI;
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI ||
+	       type == BPF_TRACE_FSESSION_MULTI;
 }
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
@@ -2267,6 +2269,8 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
 	for (int i = 0; i < nodes[BPF_TRAMP_FENTRY].nr_nodes; i++) {
 		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION)
 			cnt++;
+		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)
+			cnt++;
 	}
 
 	return cnt;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 39407a77133b..b49bed575ce3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1157,6 +1157,7 @@ enum bpf_attach_type {
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
index 82e982f1a0ac..63f4854a3618 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4473,6 +4473,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
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
index bf200508527c..8cb96fc37edf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16316,6 +16316,7 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 		case BPF_TRACE_FSESSION:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_TRACE_FSESSION_MULTI:
 			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -18879,7 +18880,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -18985,9 +18987,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -19142,6 +19146,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_RAW_TP:
 		case BPF_TRACE_FENTRY_MULTI:
 		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_TRACE_FSESSION_MULTI:
 			return true;
 		default:
 			return false;
@@ -19226,6 +19231,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
 		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
@@ -19265,7 +19271,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 		return -EINVAL;
 
 	/* Check noreturn attachment. */
-	if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI &&
+	if ((prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+	     prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) &&
 	     btf_id_set_contains(&noreturn_deny, btf_id))
 		return -EINVAL;
 	/* Check denied attachment. */
@@ -19548,7 +19555,9 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -19561,7 +19570,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
index 39407a77133b..b49bed575ce3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1157,6 +1157,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FSESSION,
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
+	BPF_TRACE_FSESSION_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7b99737590d1..2f5ac3e91d21 100644
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

