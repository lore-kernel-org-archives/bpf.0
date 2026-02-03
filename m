Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042D394465;
	Tue,  3 Feb 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111560; cv=none; b=Jnt06RZ4413oTNJO4hegRyEyQtRvSh/1q3QJaBjaZSigKmkwsTb/1tsuAnun3oiYvlZEXgshc1Z10+nkaijsFpEnJMJIbDRrQx4MHCtqd56nyzlqOqJOPVy3EnI2CLwY6CB6Tp5Kh4Fz940BtRVYoe328KZjz0zDWxeBl9zx8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111560; c=relaxed/simple;
	bh=4m/qSj+Vc7e7GcyDZSbvg3K5CzBTeyTc2jZqU14/14Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2VPBPMHcrYaPvz4bEAFZTe95ItRzgR70/oB4hEYEOc8iX+XBhtndSMZrmuLae/DW+98vqBQ/jigZLMwZPwJ+5ScXttq6SJlGCOCHmivCwUwzQyIJkvCZCY+NtZ0MUY4SKHF3b8XdM3Ce6knJFIhpcwa4bvHIzn4g0r3TEGWM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqdv40MY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqdv40MY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80D7C116D0;
	Tue,  3 Feb 2026 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111560;
	bh=4m/qSj+Vc7e7GcyDZSbvg3K5CzBTeyTc2jZqU14/14Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqdv40MY198KE9jDIG5fxPqTsACKG3ur6c44kGroGoy5RoG6WkxEuzIn4ejJGGHug
	 O/cLtl0ROpDqA1A1Nnl1CgIPd8NkUDNlXz/op4HRgmKeLSrVbO7PTmM6JRQ4Biq3/t
	 6Cu5BVHYvw5KKNaO+3CDxkBBypVuC1ckzqTxI7ixFQhA+FULnYGqjfY5ZzW0p9FKqd
	 h0vyU1LX/n5ZYDecEbusH57eMND3uZxZCaYyIi5016u9d3Rf3bvzg3waLLxhlU9gU9
	 dEGcgu/MjRG6+9osviHhIosBWV1U8s366hbxI9pEeBVcoNBsU3vCISEwZEFbz9iHe2
	 e4E8LpVtbWOAQ==
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
Subject: [RFC bpf-next 05/12] bpf: Add multi tracing attach types
Date: Tue,  3 Feb 2026 10:38:12 +0100
Message-ID: <20260203093819.2105105-6-jolsa@kernel.org>
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

Adding new attach type to identify multi tracing attachment:
  BPF_TRACE_FENTRY_MULTI
  BPF_TRACE_FEXIT_MULTI

Programs with such attach type will use specific link attachment
interface coming in following changes.

This was suggested by Andrii some (long) time ago and turned out
to be easier than having special program flag for that.

Bpf programs with such types have 'bpf_multi_func' function set
as their attach_btf_id.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  5 +++++
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           | 35 ++++++++++++++++++++++++++++++----
 kernel/bpf/trampoline.c        |  5 ++++-
 kernel/bpf/verifier.c          |  8 +++++++-
 net/bpf/test_run.c             |  2 ++
 tools/include/uapi/linux/bpf.h |  2 ++
 7 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4aee54e6a8ca..f06f0a11ccb7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2126,6 +2126,11 @@ void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
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
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec10d6d1997f..2f8932addf96 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -40,6 +40,7 @@
 #include <linux/overflow.h>
 #include <linux/cookie.h>
 #include <linux/verification.h>
+#include <linux/btf_ids.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -2652,7 +2653,8 @@ static int
 bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 			   enum bpf_attach_type expected_attach_type,
 			   struct btf *attach_btf, u32 btf_id,
-			   struct bpf_prog *dst_prog)
+			   struct bpf_prog *dst_prog,
+			   bool multi_func)
 {
 	if (btf_id) {
 		if (btf_id > BTF_MAX_TYPE)
@@ -2672,6 +2674,14 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
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
 
@@ -2857,6 +2867,16 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
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
+BTF_ID_LIST_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
@@ -2869,6 +2889,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	bool bpf_cap;
 	int err;
 	char license[128];
+	bool multi_func;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
 		return -EINVAL;
@@ -2935,6 +2956,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
 		goto put_token;
 
+	multi_func = is_tracing_multi(attr->expected_attach_type);
+
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
 	 */
@@ -2956,7 +2979,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				goto put_token;
 			}
 		}
-	} else if (attr->attach_btf_id) {
+	} else if (attr->attach_btf_id || multi_func) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(attach_btf)) {
@@ -2972,7 +2995,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
-				       dst_prog)) {
+				       dst_prog, multi_func)) {
 		if (dst_prog)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
@@ -2995,7 +3018,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
 	prog->aux->attach_btf = attach_btf;
-	prog->aux->attach_btf_id = attr->attach_btf_id;
+	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
 	prog->aux->dev_bound = !!attr->prog_ifindex;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
@@ -3571,6 +3594,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
 		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
+		    prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
+		    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -4360,6 +4385,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9b8e036a3b2d..2be2f1d0b7d7 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -149,7 +149,8 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	switch (ptype) {
 	case BPF_PROG_TYPE_TRACING:
 		if (eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION)
+		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION ||
+		    eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI)
 			return true;
 		return false;
 	case BPF_PROG_TYPE_LSM:
@@ -744,10 +745,12 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
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
index 6b62b6d57175..fb52ba2f7f7a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17809,6 +17809,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23771,6 +23773,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
 			    eatype == BPF_TRACE_FSESSION ||
+			    eatype == BPF_TRACE_FEXIT_MULTI ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24828,6 +24831,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
 		    !bpf_jit_supports_fsession()) {
 			bpf_log(log, "JIT does not support fsession\n");
@@ -25069,7 +25074,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return 0;
 	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
 		return bpf_iter_prog_supported(prog);
-	}
+	} else if (is_tracing_multi(prog->expected_attach_type))
+		return prog->type == BPF_PROG_TYPE_TRACING ? 0 : -EINVAL;
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
 		ret = bpf_lsm_verify_prog(&env->log, prog);
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
 
-- 
2.52.0

