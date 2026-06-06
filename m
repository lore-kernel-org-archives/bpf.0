Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74093793B4;
	Sat,  6 Jun 2026 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749704; cv=none; b=mV9XL54nqxAo2bk0UukUb+JQH1v4ivC2g+AvzmERdJ98p3KOoYOOBjJbgCfKRtTXHn4ZLDMD2WbUZ4XN3yE8h5dOiTUWjZFPGF2dNhWSiqEAOmhtp0lycef52507zzvby5dxciD9LeX4QKyJMgeSuIPStlnWvcFdjkwmYmFwEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749704; c=relaxed/simple;
	bh=hVvGtyFiPrGmIEH1Yed0LVlzpD/uhRPbSJzO7M6rXy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3ZtrtvA+SvbmtLEOUAZr229ahRZAQNsUA05dbP3kjb7by1V2SKbnDwNZ7jPXdaeswN0tvw5L4Xu20t94EnvLBnyVaGgf/SXi9dco4lfAOJp8TtP4+I1KF7qO+/lP7fJE2Wg/bB0gXzKKxzqbr1aCV0oXmNyWuRTFVK5xpVhNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvEWr5BH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvEWr5BH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427B01F00893;
	Sat,  6 Jun 2026 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749702;
	bh=IY4X2eMwStnjRQPRdwFVynU3d4OuWbWeYFT23/cRAFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvEWr5BHm8uOAESqacHBHtwAkbdiwMG4UJtb+hpIui1EBIuSFjFKSzm/cQcwckxDI
	 QE5iz1nX+YKLO6S0wAgpuoo1e2qit3UrcdD6ArRtWDE1xojBh3u0HqPsnyfGT/T4n+
	 D/1IRXZ7x8ln5CpiyQuiIUiqO6zAryVxISvuaMce6PR0HATiaVKelz0ZpLQzN9mWAK
	 3vtGGGGFWcbCOJxBZeb6TOcdBAdYfG2apKntfIa6ZD4+UtQ8YaKIVgSoaCLr2pm+gs
	 SkF8yhb7P7f6WGuQQFBuDJcpX3JFUTeq6fkNupZenfaYofZhnDTPCztP8F06EGxHoK
	 AQjfqpBikzsKA==
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
Subject: [PATCHv8 bpf-next 10/29] bpf: Add multi tracing attach types
Date: Sat,  6 Jun 2026 14:39:35 +0200
Message-ID: <20260606123955.345967-11-jolsa@kernel.org>
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

Adding new program attach types multi tracing attachment:
  BPF_TRACE_FENTRY_MULTI
  BPF_TRACE_FEXIT_MULTI

and their base support in verifier code.

Programs with such attach type will use specific link attachment
interface coming in following changes.

This was suggested by Andrii some (long) time ago and turned out
to be easier than having special program flag for that.

Bpf programs with such types have 'bpf_multi_func' function set as
their attach_btf_id and keep module reference when it's specified
by attach_prog_fd.

They are also accepted as sleepable programs during verification,
and the real validation for specific BTF_IDs/functions will happen
during the multi link attachment in following changes.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  5 +++++
 include/linux/btf_ids.h        |  1 +
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/fixups.c            |  1 +
 kernel/bpf/syscall.c           | 28 ++++++++++++++++++++----
 kernel/bpf/trampoline.c        |  5 ++++-
 kernel/bpf/verifier.c          | 40 +++++++++++++++++++++++++++++++++-
 net/bpf/test_run.c             |  2 ++
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/libbpf.c         |  2 ++
 10 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 428789a9e736..b52dc64ec92d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2113,6 +2113,11 @@ static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
 #endif
 }
 
+static inline bool is_tracing_multi(enum bpf_attach_type type)
+{
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI;
+}
+
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 /* This macro helps developer to register a struct_ops type and generate
  * type information correctly. Developers should use this macro to register
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index af011db39ab3..8b5a9ee92513 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -284,5 +284,6 @@ extern u32 bpf_cgroup_btf_id[];
 extern u32 bpf_local_storage_map_btf_id[];
 extern u32 btf_bpf_map_id[];
 extern u32 bpf_kmem_cache_btf_id[];
+extern u32 bpf_multi_func_btf_id[];
 
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d5238df5e5eb..28d127e5040a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1156,6 +1156,8 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
 	BPF_TRACE_FSESSION,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 5aa3f7d99ac9..0cf9735929f5 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2186,6 +2186,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
 			    eatype == BPF_TRACE_FSESSION ||
+			    eatype == BPF_TRACE_FEXIT_MULTI ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0cfc8bcb3dc9..efdd6639a598 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -41,6 +41,7 @@
 #include <linux/overflow.h>
 #include <linux/cookie.h>
 #include <linux/verification.h>
+#include <linux/btf_ids.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -2719,7 +2720,8 @@ static int
 bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 			   enum bpf_attach_type expected_attach_type,
 			   struct btf *attach_btf, u32 btf_id,
-			   struct bpf_prog *dst_prog)
+			   struct bpf_prog *dst_prog,
+			   bool multi_func)
 {
 	if (btf_id) {
 		if (btf_id > BTF_MAX_TYPE)
@@ -2739,6 +2741,14 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		}
 	}
 
+	if (multi_func) {
+		if (prog_type != BPF_PROG_TYPE_TRACING)
+			return -EINVAL;
+		if (!attach_btf || btf_id)
+			return -EINVAL;
+		return 0;
+	}
+
 	if (attach_btf && (!btf_id || dst_prog))
 		return -EINVAL;
 
@@ -2946,6 +2956,11 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 	return 0;
 }
 
+extern int bpf_multi_func(void);
+int __init __used bpf_multi_func(void) { return 0; }
+
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
@@ -2958,6 +2973,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	bool bpf_cap;
 	int err;
 	char license[128];
+	bool multi_func;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -3024,6 +3040,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
 		goto put_token;
 
+	multi_func = is_tracing_multi(attr->expected_attach_type);
+
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
 	 */
@@ -3045,7 +3063,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 				goto put_token;
 			}
 		}
-	} else if (attr->attach_btf_id) {
+	} else if (attr->attach_btf_id || multi_func) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(attach_btf)) {
@@ -3061,7 +3079,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
-				       dst_prog)) {
+				       dst_prog, multi_func)) {
 		if (dst_prog)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
@@ -3084,7 +3102,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
 	prog->aux->attach_btf = attach_btf;
-	prog->aux->attach_btf_id = attr->attach_btf_id;
+	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
 	prog->aux->dev_bound = !!attr->prog_ifindex;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
@@ -4480,6 +4498,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5776d2b8e36e..ae7e4fdfe2a3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -182,7 +182,8 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	switch (ptype) {
 	case BPF_PROG_TYPE_TRACING:
 		if (eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION)
+		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION ||
+		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI)
 			return true;
 		return false;
 	case BPF_PROG_TYPE_LSM:
@@ -781,10 +782,12 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FENTRY_MULTI:
 		return BPF_TRAMP_FENTRY;
 	case BPF_MODIFY_RETURN:
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FEXIT_MULTI:
 		return BPF_TRAMP_FEXIT;
 	case BPF_TRACE_FSESSION:
 		return BPF_TRAMP_FSESSION;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 935595138aa0..091c9606d961 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16370,6 +16370,8 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -18760,6 +18762,11 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
 
 #endif /* CONFIG_FUNCTION_ERROR_INJECTION */
 
+static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
+{
+	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -18882,6 +18889,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
 		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
@@ -18988,6 +18997,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
 		    !bpf_jit_supports_fsession()) {
 			bpf_log(log, "JIT does not support fsession\n");
@@ -19017,7 +19028,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (ret < 0)
 			return ret;
 
-		if (tgt_prog) {
+		/*
+		 * *.multi programs don't need an address during program
+		 * verification, we just take the module ref if needed.
+		 */
+		if (is_tracing_multi_id(prog, btf_id)) {
+			if (btf_is_module(btf)) {
+				mod = btf_try_get_module(btf);
+				if (!mod)
+					return -ENOENT;
+			}
+			addr = 0;
+		} else if (tgt_prog) {
 			if (subprog == 0)
 				addr = (long) tgt_prog->bpf_func;
 			else
@@ -19045,6 +19067,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			ret = -EINVAL;
 			switch (prog->type) {
 			case BPF_PROG_TYPE_TRACING:
+				/* *.multi sleepable programs will pass initial sleepable check,
+				 * the actual attached btf ids are checked later during the link
+				 * attachment.
+				 */
+				if (is_tracing_multi_id(prog, btf_id))
+					ret = 0;
 				if (!check_attach_sleepable(btf_id, addr, tname))
 					ret = 0;
 				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
@@ -19155,6 +19183,8 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
 		case BPF_TRACE_RAW_TP:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			return true;
 		default:
 			return false;
@@ -19246,6 +19276,14 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	/*
+	 * We don't get trampoline for tracing_multi programs at this point,
+	 * it's done when tracing_multi link is created.
+	 */
+	if (prog->type == BPF_PROG_TYPE_TRACING &&
+	    is_tracing_multi(prog->expected_attach_type))
+		return 0;
+
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
 	tr = bpf_trampoline_get(key, &tgt_info);
 	if (!tr)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c9aea7052ba7..67769c700cae 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -703,6 +703,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3829db087449..1b9aacf468e5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1156,6 +1156,8 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
 	BPF_TRACE_FSESSION,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1354bcbc8b30..1b09381d16ff 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -136,6 +136,8 @@ static const char * const attach_type_name[] = {
 	[BPF_NETKIT_PEER]		= "netkit_peer",
 	[BPF_TRACE_KPROBE_SESSION]	= "trace_kprobe_session",
 	[BPF_TRACE_UPROBE_SESSION]	= "trace_uprobe_session",
+	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
+	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
 };
 
 static const char * const link_type_name[] = {
-- 
2.54.0

