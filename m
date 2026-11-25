Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617139;
	b=tJg7cuCFdp4rsPm1iEol7Rk5CN2KkHXww8kmehFccFps1oCBLRcr/8QCGXaMlEoWKIdf
	 cWtsW/JkWH0Pz46yrJ7Fq37i6C7d6UavLvk6bofDlqUbDM7rGUaffEo6QO28haCUT4HP1
	 2M4QKAFD50T7x1YLTnkeIwXf9ExUTUvwINCLwPwbDRuWkgwrYEb1K3iqVxVFwuCu66Cu4
	 DRaA3yvttnEGYbIMvB7ycPuecer5f03P1WxCywdqplxbaBd4IL2Rb6Y83K8MUj9ZfOLO8
	 GkW8CxDcdUdNzkvSEy5BuFMGRS33rJqvac2CqbGcdG0ZbhDJ9pVzZmyO3zukKXXmehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617139;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1iOcBbmJ/oLyBrbvR1jf7P+edq71j+hWA8Crm2xznHs=;
	b=IWQe9ArupNZAMj6CsNcgf+MKEVyT8g0ktkBi+d4wSDTNiWxPKk34QXA0MOXp1H663PJl
	 rysQ6GyqTSo5KP+UR076xxWG6C62xr0z6se8wq1zr3+4SnvFJhi4f8fC4GgVwnBa2Xlee
	 JiAKrIMORGo9TQQY6prNU9ZcwODBTgyhaYBd1r9AgAf2ZJIH2q+3vNAIhBHvdEO9SJtxO
	 YA5kE0VWaN9nQ+QGnLZOoKJGnq3+WSfcc5u0l6g5wZrZF+HZOwltGD02r/Fjlka1+5Xwe
	 Dqc/IvKgY/Cg06GAa4cDMKwLBObrJTS/s52uKYt63AaF9AiCx95AVBXJWq2Xn5ohhQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KTSLckY6;
	arc=none smtp.remote-ip=95.215.58.200
Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82279606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82279606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KTSLckY6
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mojYtiSgToeIDewLHXgu3Vl3cMY6GzuUHwVAc3+GhWg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795617136; v=1; x=1796221936;
 b=KTSLckY6oJkJcOa52cSIIAORivOSprEVLC5i/Gx7vX14ccftUMlv0hRagkLQNk3rnJVBtxR6
 UURq0t4fZVndCndOGgfGqt3fZ8PnhRstJU4OJqSmUbSX+yZW+KkpKAw2M4nVdUOhGlkrPhk4T3Q
 af26oq5+ZvJz+Ng65ojHdPJs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 06de74f4bc99a470;
	Wed, 25 Nov 2026 14:32:16 +0000
X-Mizu-Trace-ID: 06de74f4bc99a470
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 2/6] bpf: Add log support for tracing_multi link_create
Date: Wed, 25 Nov 2026 22:31:34 +0800
Message-ID: <20261125143138.47174-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125143138.47174-1-leon.hwang@linux.dev>
References: <20261125143138.47174-1-leon.hwang@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tracing_multi BPF_LINK_CREATE returns errors without identifying the
failed parameter or target check.

Report excessive counts, invalid flags and target FDs, and duplicate IDs
through the link creation log. Also report BTF target validation errors,
including unsupported prototypes, missing ftrace locations and disallowed
sleepable attachment.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h          |  6 +++--
 include/linux/bpf_verifier.h |  3 ++-
 include/linux/trace_events.h |  7 ++++--
 kernel/bpf/syscall.c         |  2 +-
 kernel/bpf/trampoline.c      |  5 ++--
 kernel/bpf/verifier.c        | 45 ++++++++++++++++++++++++++++--------
 kernel/trace/bpf_trace.c     | 27 ++++++++++++++++------
 7 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d15af0e..a1ba3f54ba6a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1640,7 +1640,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
-				struct bpf_tracing_multi_link *link);
+				struct bpf_tracing_multi_link *link,
+				struct bpf_verifier_log *log);
 void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 				 struct bpf_tracing_multi_link *link);
 void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags);
@@ -1758,7 +1759,8 @@ static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	return false;
 }
 static inline int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
-					      struct bpf_tracing_multi_link *link)
+					      struct bpf_tracing_multi_link *link,
+					      struct bpf_verifier_log *log)
 {
 	return -ENOTSUPP;
 }
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 151b5781606d..f86b95da1b1e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2492,7 +2492,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			 struct bpf_insn *insn_buf, int insn_idx, int *cnt);
 
 /* Functions exported from verifier.c, used by trampoline.c */
-int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
+int bpf_check_attach_btf_id_multi(struct bpf_verifier_log *log, struct btf *btf,
+				  struct bpf_prog *prog, u32 btf_id,
 				  struct bpf_attach_target_info *tgt_info);
 
 /* Functions in fixups.c, called from bpf_check() */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 321f2f3a6c8e..bb825ea5d09c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -16,6 +16,7 @@ struct tracer;
 struct dentry;
 struct bpf_prog;
 union bpf_attr;
+struct bpf_verifier_log;
 
 /* Used for event string fields when they are NULL */
 #define EVENT_NULL_STR		"(null)"
@@ -796,7 +797,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr);
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -855,7 +857,8 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	return -EOPNOTSUPP;
 }
 static inline int
-bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			 struct bpf_verifier_log *log)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b563ff5b5736..e53df528b09d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5954,7 +5954,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
 		else if (is_tracing_multi(prog->expected_attach_type))
-			ret = bpf_tracing_multi_attach(prog, attr);
+			ret = bpf_tracing_multi_attach(prog, attr, log);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5f2b792de8f9..96454443441b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1723,7 +1723,8 @@ static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
 	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
-				struct bpf_tracing_multi_link *link)
+				struct bpf_tracing_multi_link *link,
+				struct bpf_verifier_log *log)
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_attach_target_info tgt_info = {};
@@ -1736,7 +1737,7 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	for_each_mnode(mnode, link) {
 		rollback_cnt = i;
 
-		err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
+		err = bpf_check_attach_btf_id_multi(log, btf, prog, ids[i], &tgt_info);
 		if (err)
 			goto rollback_put;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67a7bffbdbd7..0bfb3b413beb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24151,8 +24151,12 @@ btf_attach_func_proto(struct bpf_verifier_log *log, struct btf *btf, u32 func_id
 	int implicit;
 
 	func = btf_type_by_id(btf, func_id);
-	if (!func || !btf_type_is_func(func))
+	if (!func)
+		return NULL;
+	if (!btf_type_is_func(func)) {
+		bpf_log(log, "Type of id %u is not function.\n", func_id);
 		return NULL;
+	}
 	name = btf_name_by_offset(btf, func->name_off);
 
 	/*
@@ -24907,7 +24911,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	return 0;
 }
 
-int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
+int bpf_check_attach_btf_id_multi(struct bpf_verifier_log *log, struct btf *btf,
+				  struct bpf_prog *prog, u32 btf_id,
 				  struct bpf_attach_target_info *tgt_info)
 {
 	const struct btf_type *t;
@@ -24921,28 +24926,40 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 	/* Check noreturn attachment. */
 	if ((prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
 	     prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) &&
-	     btf_id_set_contains(&noreturn_deny, btf_id))
+	     btf_id_set_contains(&noreturn_deny, btf_id)) {
+		bpf_log(log,
+			"Cannot attach fexit/fsession_multi prog to noreturn btf id %u.\n",
+			btf_id);
 		return -EINVAL;
+	}
 	/* Check denied attachment. */
-	if (btf_id_set_contains(&btf_id_deny, btf_id))
+	if (btf_id_set_contains(&btf_id_deny, btf_id)) {
+		bpf_log(log, "Cannot attach to denylist btf id %u.\n", btf_id);
 		return -EINVAL;
+	}
 
 	/* Check and get function target data. */
 	t = btf_type_by_id(btf, btf_id);
-	if (!t)
+	if (!t) {
+		bpf_log(log, "Cannot resolve type of btf id %u.\n", btf_id);
 		return -EINVAL;
+	}
 	tname = btf_name_by_offset(btf, t->name_off);
 	if (!tname)
 		return -EINVAL;
-	t = btf_attach_func_proto(NULL, btf, btf_id);
+	t = btf_attach_func_proto(log, btf, btf_id);
 	if (!t || !btf_type_is_func_proto(t))
 		return -EINVAL;
-	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
+	err = btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
 	if (err < 0)
 		return err;
 	if (tgt_info->fmodel.ret_size > 8 &&
-	    attach_uses_trampoline_retval(prog->expected_attach_type))
+	    attach_uses_trampoline_retval(prog->expected_attach_type)) {
+		bpf_log(log,
+			"Attach to target %u:%s with a >8 byte return value is not supported for this attach type.\n",
+			btf_id, tname);
 		return -EOPNOTSUPP;
+	}
 	if (btf_is_module(btf)) {
 		/* The bpf program already holds reference to module. */
 		if (WARN_ON_ONCE(!prog->aux->mod))
@@ -24951,14 +24968,22 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 	} else {
 		addr = kallsyms_lookup_name(tname);
 	}
-	if (!addr || !ftrace_location(addr))
+	if (!addr) {
+		bpf_log(log, "Cannot resolve address of target %u:%s.\n", btf_id, tname);
+		return -ENOENT;
+	}
+	if (!ftrace_location(addr)) {
+		bpf_log(log, "Target %u:%s is not ftrace attachable.\n", btf_id, tname);
 		return -ENOENT;
+	}
 
 	/* Check sleepable program attachment. */
 	if (prog->sleepable) {
 		err = btf_id_allow_sleepable(btf_id, addr, prog, btf);
-		if (err)
+		if (err) {
+			bpf_log(log, "Target %u:%s is not sleepable.\n", btf_id, tname);
 			return err;
+		}
 	}
 	tgt_info->tgt_addr = addr;
 	return 0;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ee1860c71e2e..5f3b2be3a896 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3842,7 +3842,7 @@ static void ids_swap_r(void *a, void *b, int size __maybe_unused,
 	swap(*id_a, *id_b);
 }
 
-static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
+static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt, struct bpf_verifier_log *log)
 {
 	void *data[2] = { ids, cookies };
 	int err = 0;
@@ -3856,6 +3856,7 @@ static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 
 	for (int i = 1; i < cnt; i++) {
 		if (ids[i] == ids[i - 1]) {
+			bpf_log(log, "id %u is in tracing_multi.ids more than once.\n", ids[i]);
 			err = -EINVAL;
 			break;
 		}
@@ -3863,7 +3864,8 @@ static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 	return err;
 }
 
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log)
 {
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_tramp_node *fexits = NULL;
@@ -3879,10 +3881,19 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 
 	if (!cnt || !uids)
 		return -EINVAL;
-	if (cnt > MAX_TRACING_MULTI_CNT)
+	if (cnt > MAX_TRACING_MULTI_CNT) {
+		bpf_log(log, "tracing_multi.cnt %u is above the limit %u.\n",
+			cnt, MAX_TRACING_MULTI_CNT);
 		return -E2BIG;
-	if (attr->link_create.flags || attr->link_create.target_fd)
+	}
+	if (attr->link_create.flags) {
+		bpf_log(log, "flags must be zero.\n");
+		return -EINVAL;
+	}
+	if (attr->link_create.target_fd) {
+		bpf_log(log, "target_fd must be zero.\n");
 		return -EINVAL;
+	}
 
 	ids = kvmalloc_objs(*ids, cnt);
 	if (!ids)
@@ -3906,7 +3917,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		}
 	}
 
-	err = check_dup_ids(ids, cookies, cnt);
+	err = check_dup_ids(ids, cookies, cnt, log);
 	if (err)
 		goto error;
 
@@ -3935,7 +3946,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	link->cookies = cookies;
 	link->fexits = fexits;
 
-	err = bpf_trampoline_multi_attach(prog, ids, link);
+	err = bpf_trampoline_multi_attach(prog, ids, link, log);
 	kvfree(ids);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
@@ -3953,8 +3964,10 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 
 #else
 
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log)
 {
+	bpf_log(log, "This kernel does not support tracing_multi.\n");
 	return -EOPNOTSUPP;
 }
 
-- 
2.55.0

