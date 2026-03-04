Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA3369973;
	Wed,  4 Mar 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662975; cv=none; b=hrb4gA7E5pWDVC0/pG0eceGubVFin2M9AqvucgvvpidNM4W4Bw8uNylVkEKkBGAkuOVwKoXL88PZKRyLSMAx3ue+X20Im9LGSdVV//EFc/wE1gnbbnp33yr6bWwpUy3x5KvtSz+xKB4QWX4vGw1LX6sL/aQZkdGNzADHPFdhTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662975; c=relaxed/simple;
	bh=RG9QPHzUPDM+fnnNw8OddgK62j9P1gAcHg/KFZExMBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwdLwc2lAjKcSyCpfg7pwMF58g2xlDcJw+hrZc4MYBS9DaWY3lLABI86x0UwT/9nnktYtH9iZc+fAwvA9IjEZGVKgh7lq8QM0YEWjRwgwNUcOxz44/5dWkl7XBiMwegmKrjJ918oG0bMsYo9/8+QFEuAl4DIdupgUXKOvQRA+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td8lrf6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td8lrf6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D3DC4CEF7;
	Wed,  4 Mar 2026 22:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662974;
	bh=RG9QPHzUPDM+fnnNw8OddgK62j9P1gAcHg/KFZExMBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=td8lrf6ICNaRYwVTKlJlvkkWTVubfpwNlZJ2FJDaZVQR502OAktFvqQ/Gmq+OwPtU
	 1SsqbXEB0BhUd/qxzrkhPyT9L24U4w8z2VPSN+5OqPnAIM4mBObHWsHimnjZktcx/P
	 qMK8XqB7jp9wjmP6hADg5MTsyVNEvIcIanWPGY5ADWzyGZpYOMH4WGmbnw7rRjtrUA
	 9lkaIWH4d/m3UzUTL4AWi8AJ0SgHEs30Y3jKMNWUjXQjd8ymrbiCS70Bq1eDHwJe/s
	 fQXuHjpELVp6GQLRwHv/0tgi1DD2QBRJWYjCotIQnncLuC+DFTYtL7H2/cj9hOVYPI
	 142q4p8Vm0QTA==
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
Subject: [PATCHv2 bpf-next 06/23] bpf: Add multi tracing attach types
Date: Wed,  4 Mar 2026 23:21:24 +0100
Message-ID: <20260304222141.497203-7-jolsa@kernel.org>
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

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  5 +++++
 include/linux/btf_ids.h        |  1 +
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/btf.c               |  2 ++
 kernel/bpf/syscall.c           | 33 +++++++++++++++++++++++++++++----
 kernel/bpf/trampoline.c        |  5 ++++-
 kernel/bpf/verifier.c          | 34 ++++++++++++++++++++++++++++++++--
 net/bpf/test_run.c             |  2 ++
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/libbpf.c         |  2 ++
 10 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d536640aef41..c401b308a325 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2116,6 +2116,11 @@ void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
 void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
 
+static inline bool is_tracing_multi(enum bpf_attach_type type)
+{
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI;
+}
+
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
 struct bpf_dummy_ops_state {
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 139bdececdcf..eb2c4432856d 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -284,5 +284,6 @@ extern u32 bpf_cgroup_btf_id[];
 extern u32 bpf_local_storage_map_btf_id[];
 extern u32 btf_bpf_map_id[];
 extern u32 bpf_kmem_cache_btf_id[];
+extern u32 bpf_multi_func_btf_id[];
 
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..68600972a778 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1154,6 +1154,8 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
 	BPF_TRACE_FSESSION,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 09fcbb125155..c8738834bbc9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6221,6 +6221,8 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 003ad95940c9..2680740e9c09 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -41,6 +41,7 @@
 #include <linux/overflow.h>
 #include <linux/cookie.h>
 #include <linux/verification.h>
+#include <linux/btf_ids.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -2653,7 +2654,8 @@ static int
 bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 			   enum bpf_attach_type expected_attach_type,
 			   struct btf *attach_btf, u32 btf_id,
-			   struct bpf_prog *dst_prog)
+			   struct bpf_prog *dst_prog,
+			   bool multi_func)
 {
 	if (btf_id) {
 		if (btf_id > BTF_MAX_TYPE)
@@ -2673,6 +2675,14 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
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
 
@@ -2865,6 +2875,16 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 	return 0;
 }
 
+#define DEFINE_BPF_MULTI_FUNC(args...)			\
+	extern int bpf_multi_func(args);		\
+	int __init bpf_multi_func(args) { return 0; }
+
+DEFINE_BPF_MULTI_FUNC(unsigned long a1, unsigned long a2,
+		      unsigned long a3, unsigned long a4,
+		      unsigned long a5, unsigned long a6)
+
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
@@ -2877,6 +2897,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	bool bpf_cap;
 	int err;
 	char license[128];
+	bool multi_func;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2943,6 +2964,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
 		goto put_token;
 
+	multi_func = is_tracing_multi(attr->expected_attach_type);
+
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
 	 */
@@ -2964,7 +2987,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				goto put_token;
 			}
 		}
-	} else if (attr->attach_btf_id) {
+	} else if (attr->attach_btf_id || multi_func) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(attach_btf)) {
@@ -2980,7 +3003,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
-				       dst_prog)) {
+				       dst_prog, multi_func)) {
 		if (dst_prog)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
@@ -3003,7 +3026,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
 	prog->aux->attach_btf = attach_btf;
-	prog->aux->attach_btf_id = attr->attach_btf_id;
+	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
 	prog->aux->dev_bound = !!attr->prog_ifindex;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
@@ -4365,6 +4388,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2de81e4369a1..e2f4a15886b0 100644
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
@@ -771,10 +772,12 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
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
index d92cf2821657..832a87da5a86 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17919,6 +17919,8 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -24108,6 +24110,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
 			    eatype == BPF_TRACE_FSESSION ||
+			    eatype == BPF_TRACE_FEXIT_MULTI ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24951,6 +24954,11 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
+{
+	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -25173,6 +25181,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
 		    !bpf_jit_supports_fsession()) {
 			bpf_log(log, "JIT does not support fsession\n");
@@ -25202,7 +25212,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (ret < 0)
 			return ret;
 
-		if (tgt_prog) {
+		/* *.multi programs don't need an address during program
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
@@ -25231,10 +25251,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			switch (prog->type) {
 			case BPF_PROG_TYPE_TRACING:
 
+				/* *.multi sleepable programs will pass initial sleepable check,
+				 * the actual attached btf ids are checked later during the link
+				 * attachment.
+				 */
+				if (is_tracing_multi_id(prog, btf_id))
+					ret = 0;
 				/* fentry/fexit/fmod_ret progs can be sleepable if they are
 				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
 				 */
-				if (!check_non_sleepable_error_inject(btf_id) &&
+				else if (!check_non_sleepable_error_inject(btf_id) &&
 				    within_error_injection_list(addr))
 					ret = 0;
 				/* fentry/fexit/fmod_ret progs can also be sleepable if they are
@@ -25345,6 +25371,8 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			return true;
 		default:
 			return false;
@@ -25414,6 +25442,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return 0;
 	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
 		return bpf_iter_prog_supported(prog);
+	} else if (is_tracing_multi(prog->expected_attach_type)) {
+		return prog->type == BPF_PROG_TYPE_TRACING ? 0 : -EINVAL;
 	}
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..3373450132f0 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -686,6 +686,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6..61f0fe5bc0aa 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1154,6 +1154,8 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
 	BPF_TRACE_FSESSION,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..1e19c7b861ec 100644
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
2.53.0

