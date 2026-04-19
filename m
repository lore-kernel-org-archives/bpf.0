Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD440DFA4
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616436; cv=none; b=lt9tRLeZUIX1A6Yzszrbl2voTTyGRnzHFwcvULlvIPVIf4MiJRZ5Xdg8L9/mKg72g3le+T1gGUBDsAG5eqWsqMNtsLSrM0buOYGHG/geFrf43t93L0JeJ5Ho5wxm5hLahZKBceLNLYqdk9DaXtmnz88TUHBphQBwPWqr53Dm748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616436; c=relaxed/simple;
	bh=DfZlzRfoWgft32xAwXQ3TkIlYKR0jXwdzDz1jKogY7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5aN4fTHcE64/rLPFwc73p+zqIrJ7KvImP+o0ah+MV4FSowwFcsDbSNMD00ZT6PEbodHudcLw3FgyhiMyfgYR4TAHjX8+cTn08I3On31r7fXW3el5qDV9aKdFj1uFHTmNtQjw252DSWr8oPMjqRaaaX9f1DwsiZmE/C0em7jUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E48EE42DD4D84; Sun, 19 Apr 2026 09:33:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 04/17] bpf: Prepare verifier logs for upcoming kfunc stack arguments
Date: Sun, 19 Apr 2026 09:33:36 -0700
Message-ID: <20260419163336.733654-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419163316.731019-1-yonghong.song@linux.dev>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change prepares verifier log reporting for upcoming kfunc stack
argument support.

Today verifier log code mostly assumes that an argument can be described
directly by a register number. That works for arguments passed in `R1`
to `R5`, but it does not work once kfunc arguments can also be
passed on the stack.

Introduce an internal `argno` representation such that register-passed
arguments keep using their real register numbers, while stack-passed
arguments use an encoded value above a dedicated base.
`reg_arg_name()` converts this representation into either `R%d` or
`*(R11-off)` when emitting verifier logs. If a particular `argno`
is corresponding to a stack argument, print `*(R11-off)`. Otherwise,
print `R%d`. Here R11 presents the base of stack arguments.

This keeps existing logs readable for register arguments and allows the
same log sites to handle future stack arguments without open-coding
special cases.

Update selftests accordingly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         | 649 ++++++++++--------
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
 .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
 .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
 tools/testing/selftests/bpf/progs/irq.c       |   4 +-
 tools/testing/selftests/bpf/progs/iters.c     |   6 +-
 .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
 .../selftests/bpf/progs/iters_testmod.c       |   4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
 .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
 .../selftests/bpf/progs/task_work_fail.c      |   6 +-
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
 .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
 .../bpf/progs/verifier_ref_tracking.c         |   6 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
 .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
 30 files changed, 474 insertions(+), 374 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b148f816f25b..9fbbddc40d21 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -913,6 +913,7 @@ struct bpf_verifier_env {
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
 	char tmp_str_buf[TMP_STR_BUF_LEN];
+	char tmp_reg_arg_name_buf[32];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
 	struct bpf_scc_callchain callchain_buf;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3716d9688d00..6aa4dc161a56 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1751,6 +1751,55 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
 	return &elem->st;
 }
=20
+/*
+ * Unified argument number encoding for verifier log messages.
+ * Register args (arg_idx 0-4) use their register number (R1-R5).
+ * Stack args (arg_idx 5+) are encoded as STACK_ARGNO_BASE + arg_idx
+ * to avoid collision with register numbers. reg_arg_name() decodes
+ * this back to a human-readable string like "*(R11-8)" for logs.
+ */
+#define STACK_ARGNO_BASE 100
+
+static bool is_stack_argno(int argno)
+{
+	return argno >=3D STACK_ARGNO_BASE;
+}
+
+static u32 make_argno(u32 arg_idx)
+{
+	if (arg_idx < MAX_BPF_FUNC_REG_ARGS)
+		return BPF_REG_1 + arg_idx;
+	return STACK_ARGNO_BASE + arg_idx;
+}
+
+static u32 arg_idx_from_argno(int argno)
+{
+	if (is_stack_argno(argno))
+		return argno - STACK_ARGNO_BASE;
+	return argno - BPF_REG_1;
+}
+
+static int next_argno(int argno)
+{
+	return make_argno(arg_idx_from_argno(argno) + 1);
+}
+
+static const char *reg_arg_name(struct bpf_verifier_env *env, int argno)
+{
+	char *buf =3D env->tmp_reg_arg_name_buf;
+	int len =3D sizeof(env->tmp_reg_arg_name_buf);
+	u32 idx;
+
+	if (!is_stack_argno(argno)) {
+		snprintf(buf, len, "R%d", argno);
+		return buf;
+	}
+
+	idx =3D arg_idx_from_argno(argno);
+	snprintf(buf, len, "*(R11-%u)", (idx - MAX_BPF_FUNC_REG_ARGS + 1) * BPF=
_REG_SIZE);
+	return buf;
+}
+
 static const int caller_saved[CALLER_SAVED_REGS] =3D {
 	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
 };
@@ -4250,7 +4299,7 @@ enum bpf_access_src {
 };
=20
 static int check_stack_range_initialized(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg,
-					 int regno, int off, int access_size,
+					 int argno, int off, int access_size,
 					 bool zero_size_allowed,
 					 enum bpf_access_type type,
 					 struct bpf_call_arg_meta *meta);
@@ -4274,7 +4323,7 @@ static struct bpf_reg_state *reg_state(struct bpf_v=
erifier_env *env, int regno)
  * instead.
  */
 static int check_stack_read_var_off(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg,
-				    int ptr_regno, int off, int size, int dst_regno)
+				    int ptr_argno, int off, int size, int dst_regno)
 {
 	struct bpf_func_state *ptr_state =3D bpf_func(env, reg);
 	int err;
@@ -4282,7 +4331,7 @@ static int check_stack_read_var_off(struct bpf_veri=
fier_env *env, struct bpf_reg
=20
 	/* Note that we pass a NULL meta, so raw access will not be permitted.
 	 */
-	err =3D check_stack_range_initialized(env, reg, ptr_regno, off, size,
+	err =3D check_stack_range_initialized(env, reg, ptr_argno, off, size,
 					    false, BPF_READ, NULL);
 	if (err)
 		return err;
@@ -4304,7 +4353,7 @@ static int check_stack_read_var_off(struct bpf_veri=
fier_env *env, struct bpf_reg
  * can be -1, meaning that the read value is not going to a register.
  */
 static int check_stack_read(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *reg, int ptr_regno, int off, int size,
+			    struct bpf_reg_state *reg, int ptr_argno, int off, int size,
 			    int dst_regno)
 {
 	struct bpf_func_state *state =3D bpf_func(env, reg);
@@ -4342,7 +4391,7 @@ static int check_stack_read(struct bpf_verifier_env=
 *env,
 		 * than fixed offset ones. Note that dst_regno >=3D 0 on this
 		 * branch.
 		 */
-		err =3D check_stack_read_var_off(env, reg, ptr_regno, off, size,
+		err =3D check_stack_read_var_off(env, reg, ptr_argno, off, size,
 					       dst_regno);
 	}
 	return err;
@@ -4380,7 +4429,7 @@ static int check_stack_write(struct bpf_verifier_en=
v *env,
 	return err;
 }
=20
-static int check_map_access_type(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg, u32 regno,
+static int check_map_access_type(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg, u32 argno,
 				 int off, int size, enum bpf_access_type type)
 {
 	struct bpf_map *map =3D reg->map_ptr;
@@ -4402,7 +4451,7 @@ static int check_map_access_type(struct bpf_verifie=
r_env *env, struct bpf_reg_st
 }
=20
 /* check read/write into memory region (e.g., map value, ringbuf sample,=
 etc) */
-static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int regno,
+static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int argno,
 			      int off, int size, u32 mem_size,
 			      bool zero_size_allowed)
 {
@@ -4423,8 +4472,8 @@ static int __check_mem_access(struct bpf_verifier_e=
nv *env, struct bpf_reg_state
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET_END:
-		verbose(env, "invalid access to packet, off=3D%d size=3D%d, R%d(id=3D%=
d,off=3D%d,r=3D%d)\n",
-			off, size, regno, reg->id, off, mem_size);
+		verbose(env, "invalid access to packet, off=3D%d size=3D%d, %s(id=3D%d=
,off=3D%d,r=3D%d)\n",
+			off, size, reg_arg_name(env, argno), reg->id, off, mem_size);
 		break;
 	case PTR_TO_CTX:
 		verbose(env, "invalid access to context, ctx_size=3D%d off=3D%d size=3D=
%d\n",
@@ -4440,7 +4489,7 @@ static int __check_mem_access(struct bpf_verifier_e=
nv *env, struct bpf_reg_state
 }
=20
 /* check read/write into a memory region with possible variable offset *=
/
-static int check_mem_region_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, u32 regno,
+static int check_mem_region_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, u32 argno,
 				   int off, int size, u32 mem_size,
 				   bool zero_size_allowed)
 {
@@ -4460,15 +4509,15 @@ static int check_mem_region_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 	    (reg->smin_value =3D=3D S64_MIN ||
 	     (off + reg->smin_value !=3D (s64)(s32)(off + reg->smin_value)) ||
 	      reg->smin_value + off < 0)) {
-		verbose(env, "R%d min value is negative, either use unsigned index or =
do a if (index >=3D0) check.\n",
-			regno);
+		verbose(env, "%s min value is negative, either use unsigned index or d=
o a if (index >=3D0) check.\n",
+			reg_arg_name(env, argno));
 		return -EACCES;
 	}
-	err =3D __check_mem_access(env, reg, regno, reg->smin_value + off, size=
,
+	err =3D __check_mem_access(env, reg, argno, reg->smin_value + off, size=
,
 				 mem_size, zero_size_allowed);
 	if (err) {
-		verbose(env, "R%d min value is outside of the allowed memory range\n",
-			regno);
+		verbose(env, "%s min value is outside of the allowed memory range\n",
+			reg_arg_name(env, argno));
 		return err;
 	}
=20
@@ -4477,15 +4526,15 @@ static int check_mem_region_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 	 * If reg->umax_value + off could overflow, treat that as unbounded too=
.
 	 */
 	if (reg->umax_value >=3D BPF_MAX_VAR_OFF) {
-		verbose(env, "R%d unbounded memory access, make sure to bounds check a=
ny such access\n",
-			regno);
+		verbose(env, "%s unbounded memory access, make sure to bounds check an=
y such access\n",
+			reg_arg_name(env, argno));
 		return -EACCES;
 	}
-	err =3D __check_mem_access(env, reg, regno, reg->umax_value + off, size=
,
+	err =3D __check_mem_access(env, reg, argno, reg->umax_value + off, size=
,
 				 mem_size, zero_size_allowed);
 	if (err) {
-		verbose(env, "R%d max value is outside of the allowed memory range\n",
-			regno);
+		verbose(env, "%s max value is outside of the allowed memory range\n",
+			reg_arg_name(env, argno));
 		return err;
 	}
=20
@@ -4493,7 +4542,7 @@ static int check_mem_region_access(struct bpf_verif=
ier_env *env, struct bpf_reg_
 }
=20
 static int __check_ptr_off_reg(struct bpf_verifier_env *env,
-			       const struct bpf_reg_state *reg, int regno,
+			       const struct bpf_reg_state *reg, u32 argno,
 			       bool fixed_off_ok)
 {
 	/* Access to this pointer-typed register or passing it to a helper
@@ -4510,14 +4559,14 @@ static int __check_ptr_off_reg(struct bpf_verifie=
r_env *env,
 	}
=20
 	if (reg->smin_value < 0) {
-		verbose(env, "negative offset %s ptr R%d off=3D%lld disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->var_off.value);
+		verbose(env, "negative offset %s ptr %s off=3D%lld disallowed\n",
+			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.=
value);
 		return -EACCES;
 	}
=20
 	if (!fixed_off_ok && reg->var_off.value !=3D 0) {
-		verbose(env, "dereference of modified %s ptr R%d off=3D%lld disallowed=
\n",
-			reg_type_str(env, reg->type), regno, reg->var_off.value);
+		verbose(env, "dereference of modified %s ptr %s off=3D%lld disallowed\=
n",
+			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.=
value);
 		return -EACCES;
 	}
=20
@@ -4890,17 +4939,17 @@ static bool may_access_direct_pkt_data(struct bpf=
_verifier_env *env,
 	}
 }
=20
-static int check_packet_access(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, u32 regno, int off,
+static int check_packet_access(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, u32 argno, int off,
 			       int size, bool zero_size_allowed)
 {
 	int err;
=20
 	if (reg->range < 0) {
-		verbose(env, "R%d offset is outside of the packet\n", regno);
+		verbose(env, "%s offset is outside of the packet\n", reg_arg_name(env,=
 argno));
 		return -EINVAL;
 	}
=20
-	err =3D check_mem_region_access(env, reg, regno, off, size, reg->range,=
 zero_size_allowed);
+	err =3D check_mem_region_access(env, reg, argno, off, size, reg->range,=
 zero_size_allowed);
 	if (err)
 		return err;
=20
@@ -4955,7 +5004,7 @@ static int __check_ctx_access(struct bpf_verifier_e=
nv *env, int insn_idx, int of
 	return -EACCES;
 }
=20
-static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 regno,
+static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 argno,
 			    int off, int access_size, enum bpf_access_type t,
 			    struct bpf_insn_access_aux *info)
 {
@@ -4968,9 +5017,9 @@ static int check_ctx_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 	int err;
=20
 	if (var_off_ok)
-		err =3D check_mem_region_access(env, reg, regno, off, access_size, U16=
_MAX, false);
+		err =3D check_mem_region_access(env, reg, argno, off, access_size, U16=
_MAX, false);
 	else
-		err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
+		err =3D __check_ptr_off_reg(env, reg, argno, fixed_off_ok);
 	if (err)
 		return err;
 	off +=3D reg->umax_value;
@@ -4994,15 +5043,15 @@ static int check_flow_keys_access(struct bpf_veri=
fier_env *env, int off,
 }
=20
 static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
-			     struct bpf_reg_state *reg, u32 regno, int off, int size,
+			     struct bpf_reg_state *reg, u32 argno, int off, int size,
 			     enum bpf_access_type t)
 {
 	struct bpf_insn_access_aux info =3D {};
 	bool valid;
=20
 	if (reg->smin_value < 0) {
-		verbose(env, "R%d min value is negative, either use unsigned index or =
do a if (index >=3D0) check.\n",
-			regno);
+		verbose(env, "%s min value is negative, either use unsigned index or d=
o a if (index >=3D0) check.\n",
+			reg_arg_name(env, argno));
 		return -EACCES;
 	}
=20
@@ -5030,8 +5079,8 @@ static int check_sock_access(struct bpf_verifier_en=
v *env, int insn_idx,
 		return 0;
 	}
=20
-	verbose(env, "R%d invalid %s access off=3D%d size=3D%d\n",
-		regno, reg_type_str(env, reg->type), off, size);
+	verbose(env, "%s invalid %s access off=3D%d size=3D%d\n",
+		reg_arg_name(env, argno), reg_type_str(env, reg->type), off, size);
=20
 	return -EACCES;
 }
@@ -5541,12 +5590,12 @@ static int check_max_stack_depth(struct bpf_verif=
ier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 int regno, int off, int size)
+				 int argno, int off, int size)
 {
 	if (off < 0) {
 		verbose(env,
-			"R%d invalid %s buffer access: off=3D%d, size=3D%d\n",
-			regno, buf_info, off, size);
+			"%s invalid %s buffer access: off=3D%d, size=3D%d\n",
+			reg_arg_name(env, argno), buf_info, off, size);
 		return -EACCES;
 	}
 	if (!tnum_is_const(reg->var_off)) {
@@ -5554,8 +5603,8 @@ static int __check_buffer_access(struct bpf_verifie=
r_env *env,
=20
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env,
-			"R%d invalid variable buffer offset: off=3D%d, var_off=3D%s\n",
-			regno, off, tn_buf);
+			"%s invalid variable buffer offset: off=3D%d, var_off=3D%s\n",
+			reg_arg_name(env, argno), off, tn_buf);
 		return -EACCES;
 	}
=20
@@ -5564,11 +5613,11 @@ static int __check_buffer_access(struct bpf_verif=
ier_env *env,
=20
 static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
-				  int regno, int off, int size)
+				  int argno, int off, int size)
 {
 	int err;
=20
-	err =3D __check_buffer_access(env, "tracepoint", reg, regno, off, size)=
;
+	err =3D __check_buffer_access(env, "tracepoint", reg, argno, off, size)=
;
 	if (err)
 		return err;
=20
@@ -5580,14 +5629,14 @@ static int check_tp_buffer_access(struct bpf_veri=
fier_env *env,
=20
 static int check_buffer_access(struct bpf_verifier_env *env,
 			       const struct bpf_reg_state *reg,
-			       int regno, int off, int size,
+			       int argno, int off, int size,
 			       bool zero_size_allowed,
 			       u32 *max_access)
 {
 	const char *buf_info =3D type_is_rdonly_mem(reg->type) ? "rdonly" : "rd=
wr";
 	int err;
=20
-	err =3D __check_buffer_access(env, buf_info, reg, regno, off, size);
+	err =3D __check_buffer_access(env, buf_info, reg, argno, off, size);
 	if (err)
 		return err;
=20
@@ -5960,7 +6009,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
=20
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
-				   int regno, int off, int size,
+				   int argno, int off, int size,
 				   enum bpf_access_type atype,
 				   int value_regno)
 {
@@ -5989,8 +6038,8 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
=20
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env,
-			"R%d is ptr_%s invalid variable offset: off=3D%d, var_off=3D%s\n",
-			regno, tname, off, tn_buf);
+			"%s is ptr_%s invalid variable offset: off=3D%d, var_off=3D%s\n",
+			reg_arg_name(env, argno), tname, off, tn_buf);
 		return -EACCES;
 	}
=20
@@ -5998,22 +6047,22 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
=20
 	if (off < 0) {
 		verbose(env,
-			"R%d is ptr_%s invalid negative access: off=3D%d\n",
-			regno, tname, off);
+			"%s is ptr_%s invalid negative access: off=3D%d\n",
+			reg_arg_name(env, argno), tname, off);
 		return -EACCES;
 	}
=20
 	if (reg->type & MEM_USER) {
 		verbose(env,
-			"R%d is ptr_%s access user memory: off=3D%d\n",
-			regno, tname, off);
+			"%s is ptr_%s access user memory: off=3D%d\n",
+			reg_arg_name(env, argno), tname, off);
 		return -EACCES;
 	}
=20
 	if (reg->type & MEM_PERCPU) {
 		verbose(env,
-			"R%d is ptr_%s access percpu memory: off=3D%d\n",
-			regno, tname, off);
+			"%s is ptr_%s access percpu memory: off=3D%d\n",
+			reg_arg_name(env, argno), tname, off);
 		return -EACCES;
 	}
=20
@@ -6116,7 +6165,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
=20
 static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
-				   int regno, int off, int size,
+				   int argno, int off, int size,
 				   enum bpf_access_type atype,
 				   int value_regno)
 {
@@ -6150,8 +6199,8 @@ static int check_ptr_to_map_access(struct bpf_verif=
ier_env *env,
 	}
=20
 	if (off < 0) {
-		verbose(env, "R%d is %s invalid negative access: off=3D%d\n",
-			regno, tname, off);
+		verbose(env, "%s is %s invalid negative access: off=3D%d\n",
+			reg_arg_name(env, argno), tname, off);
 		return -EACCES;
 	}
=20
@@ -6209,7 +6258,7 @@ static int check_stack_slot_within_bounds(struct bp=
f_verifier_env *env,
  */
 static int check_stack_access_within_bounds(
 		struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-		int regno, int off, int access_size,
+		int argno, int off, int access_size,
 		enum bpf_access_type type)
 {
 	struct bpf_func_state *state =3D bpf_func(env, reg);
@@ -6228,8 +6277,8 @@ static int check_stack_access_within_bounds(
 	} else {
 		if (reg->smax_value >=3D BPF_MAX_VAR_OFF ||
 		    reg->smin_value <=3D -BPF_MAX_VAR_OFF) {
-			verbose(env, "invalid unbounded variable-offset%s stack R%d\n",
-				err_extra, regno);
+			verbose(env, "invalid unbounded variable-offset%s stack %s\n",
+				err_extra, reg_arg_name(env, argno));
 			return -EACCES;
 		}
 		min_off =3D reg->smin_value + off;
@@ -6247,14 +6296,14 @@ static int check_stack_access_within_bounds(
=20
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
-			verbose(env, "invalid%s stack R%d off=3D%lld size=3D%d\n",
-				err_extra, regno, min_off, access_size);
+			verbose(env, "invalid%s stack %s off=3D%lld size=3D%d\n",
+				err_extra, reg_arg_name(env, argno), min_off, access_size);
 		} else {
 			char tn_buf[48];
=20
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "invalid variable-offset%s stack R%d var_off=3D%s off=3D=
%d size=3D%d\n",
-				err_extra, regno, tn_buf, off, access_size);
+			verbose(env, "invalid variable-offset%s stack %s var_off=3D%s off=3D%=
d size=3D%d\n",
+				err_extra, reg_arg_name(env, argno), tn_buf, off, access_size);
 		}
 		return err;
 	}
@@ -6299,7 +6348,7 @@ static void add_scalar_to_reg(struct bpf_reg_state =
*dst_reg, s64 val)
  * if t=3D=3Dwrite && value_regno=3D=3D-1, some unknown value is stored =
into memory
  * if t=3D=3Dread && value_regno=3D=3D-1, don't care what we read from m=
emory
  */
-static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 regno,
+static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 argno,
 			    int off, int bpf_size, enum bpf_access_type t,
 			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
@@ -6316,11 +6365,12 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
=20
 	if (reg->type =3D=3D PTR_TO_MAP_KEY) {
 		if (t =3D=3D BPF_WRITE) {
-			verbose(env, "write to change key R%d not allowed\n", regno);
+			verbose(env, "write to change key %s not allowed\n",
+				reg_arg_name(env, argno));
 			return -EACCES;
 		}
=20
-		err =3D check_mem_region_access(env, reg, regno, off, size,
+		err =3D check_mem_region_access(env, reg, argno, off, size,
 					      reg->map_ptr->key_size, false);
 		if (err)
 			return err;
@@ -6334,10 +6384,10 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
 			verbose(env, "R%d leaks addr into map\n", value_regno);
 			return -EACCES;
 		}
-		err =3D check_map_access_type(env, reg, regno, off, size, t);
+		err =3D check_map_access_type(env, reg, argno, off, size, t);
 		if (err)
 			return err;
-		err =3D check_map_access(env, reg, regno, off, size, false, ACCESS_DIR=
ECT);
+		err =3D check_map_access(env, reg, argno, off, size, false, ACCESS_DIR=
ECT);
 		if (err)
 			return err;
 		if (tnum_is_const(reg->var_off))
@@ -6384,14 +6434,14 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
 		bool rdonly_untrusted =3D rdonly_mem && (reg->type & PTR_UNTRUSTED);
=20
 		if (type_may_be_null(reg->type)) {
-			verbose(env, "R%d invalid mem access '%s'\n", regno,
+			verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno)=
,
 				reg_type_str(env, reg->type));
 			return -EACCES;
 		}
=20
 		if (t =3D=3D BPF_WRITE && rdonly_mem) {
-			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str(env, reg->type));
+			verbose(env, "%s cannot write into %s\n",
+				reg_arg_name(env, argno), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
=20
@@ -6406,7 +6456,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 		 * instructions, hence no need to check bounds in that case.
 		 */
 		if (!rdonly_untrusted)
-			err =3D check_mem_region_access(env, reg, regno, off, size,
+			err =3D check_mem_region_access(env, reg, argno, off, size,
 						      reg->mem_size, false);
 		if (!err && value_regno >=3D 0 && (t =3D=3D BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
@@ -6424,7 +6474,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 			return -EACCES;
 		}
=20
-		err =3D check_ctx_access(env, insn_idx, reg, regno, off, size, t, &inf=
o);
+		err =3D check_ctx_access(env, insn_idx, reg, argno, off, size, t, &inf=
o);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
 			/* ctx access returns either a scalar, or a
 			 * PTR_TO_PACKET[_META,_END]. In the latter
@@ -6461,12 +6511,12 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
=20
 	} else if (reg->type =3D=3D PTR_TO_STACK) {
 		/* Basic bounds checks. */
-		err =3D check_stack_access_within_bounds(env, reg, regno, off, size, t=
);
+		err =3D check_stack_access_within_bounds(env, reg, argno, off, size, t=
);
 		if (err)
 			return err;
=20
 		if (t =3D=3D BPF_READ)
-			err =3D check_stack_read(env, reg, regno, off, size,
+			err =3D check_stack_read(env, reg, argno, off, size,
 					       value_regno);
 		else
 			err =3D check_stack_write(env, reg, off, size,
@@ -6482,7 +6532,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 				value_regno);
 			return -EACCES;
 		}
-		err =3D check_packet_access(env, reg, regno, off, size, false);
+		err =3D check_packet_access(env, reg, argno, off, size, false);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type =3D=3D PTR_TO_FLOW_KEYS) {
@@ -6498,23 +6548,23 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (type_is_sk_pointer(reg->type)) {
 		if (t =3D=3D BPF_WRITE) {
-			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str(env, reg->type));
+			verbose(env, "%s cannot write into %s\n",
+				reg_arg_name(env, argno), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
-		err =3D check_sock_access(env, insn_idx, reg, regno, off, size, t);
+		err =3D check_sock_access(env, insn_idx, reg, argno, off, size, t);
 		if (!err && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type =3D=3D PTR_TO_TP_BUFFER) {
-		err =3D check_tp_buffer_access(env, reg, regno, off, size);
+		err =3D check_tp_buffer_access(env, reg, argno, off, size);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID &&
 		   !type_may_be_null(reg->type)) {
-		err =3D check_ptr_to_btf_access(env, regs, reg, regno, off, size, t,
+		err =3D check_ptr_to_btf_access(env, regs, reg, argno, off, size, t,
 					      value_regno);
 	} else if (reg->type =3D=3D CONST_PTR_TO_MAP) {
-		err =3D check_ptr_to_map_access(env, regs, reg, regno, off, size, t,
+		err =3D check_ptr_to_map_access(env, regs, reg, argno, off, size, t,
 					      value_regno);
 	} else if (base_type(reg->type) =3D=3D PTR_TO_BUF &&
 		   !type_may_be_null(reg->type)) {
@@ -6523,8 +6573,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
=20
 		if (rdonly_mem) {
 			if (t =3D=3D BPF_WRITE) {
-				verbose(env, "R%d cannot write into %s\n",
-					regno, reg_type_str(env, reg->type));
+				verbose(env, "%s cannot write into %s\n",
+					reg_arg_name(env, argno), reg_type_str(env, reg->type));
 				return -EACCES;
 			}
 			max_access =3D &env->prog->aux->max_rdonly_access;
@@ -6532,7 +6582,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 			max_access =3D &env->prog->aux->max_rdwr_access;
 		}
=20
-		err =3D check_buffer_access(env, reg, regno, off, size, false,
+		err =3D check_buffer_access(env, reg, argno, off, size, false,
 					  max_access);
=20
 		if (!err && value_regno >=3D 0 && (rdonly_mem || t =3D=3D BPF_READ))
@@ -6541,7 +6591,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 		if (t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
-		verbose(env, "R%d invalid mem access '%s'\n", regno,
+		verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 			reg_type_str(env, reg->type));
 		return -EACCES;
 	}
@@ -6795,7 +6845,7 @@ static int check_atomic(struct bpf_verifier_env *en=
v, struct bpf_insn *insn)
  * read offsets are marked as read.
  */
 static int check_stack_range_initialized(
-		struct bpf_verifier_env *env, struct bpf_reg_state *reg, int regno, in=
t off,
+		struct bpf_verifier_env *env, struct bpf_reg_state *reg, int argno, in=
t off,
 		int access_size, bool zero_size_allowed,
 		enum bpf_access_type type, struct bpf_call_arg_meta *meta)
 {
@@ -6820,7 +6870,7 @@ static int check_stack_range_initialized(
 		return -EACCES;
 	}
=20
-	err =3D check_stack_access_within_bounds(env, reg, regno, off, access_s=
ize, type);
+	err =3D check_stack_access_within_bounds(env, reg, argno, off, access_s=
ize, type);
 	if (err)
 		return err;
=20
@@ -6837,8 +6887,8 @@ static int check_stack_range_initialized(
 			char tn_buf[48];
=20
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "R%d variable offset stack access prohibited for !root, =
var_off=3D%s\n",
-				regno, tn_buf);
+			verbose(env, "%s variable offset stack access prohibited for !root, v=
ar_off=3D%s\n",
+				reg_arg_name(env, argno), tn_buf);
 			return -EACCES;
 		}
 		/* Only initialized buffer on stack is allowed to be accessed
@@ -6881,7 +6931,7 @@ static int check_stack_range_initialized(
 			}
 		}
 		meta->access_size =3D access_size;
-		meta->regno =3D regno;
+		meta->regno =3D argno;
 		return 0;
 	}
=20
@@ -6921,17 +6971,17 @@ static int check_stack_range_initialized(
 		if (*stype =3D=3D STACK_POISON) {
 			if (allow_poison)
 				goto mark;
-			verbose(env, "reading from stack R%d off %d+%d size %d, slot poisoned=
 by dead code elimination\n",
-				regno, min_off, i - min_off, access_size);
+			verbose(env, "reading from stack %s off %d+%d size %d, slot poisoned =
by dead code elimination\n",
+				reg_arg_name(env, argno), min_off, i - min_off, access_size);
 		} else if (tnum_is_const(reg->var_off)) {
-			verbose(env, "invalid read from stack R%d off %d+%d size %d\n",
-				regno, min_off, i - min_off, access_size);
+			verbose(env, "invalid read from stack %s off %d+%d size %d\n",
+				reg_arg_name(env, argno), min_off, i - min_off, access_size);
 		} else {
 			char tn_buf[48];
=20
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "invalid read from stack R%d var_off %s+%d size %d\n",
-				regno, tn_buf, i - min_off, access_size);
+			verbose(env, "invalid read from stack %s var_off %s+%d size %d\n",
+				reg_arg_name(env, argno), tn_buf, i - min_off, access_size);
 		}
 		return -EACCES;
 mark:
@@ -6940,7 +6990,7 @@ static int check_stack_range_initialized(
 	return 0;
 }
=20
-static int check_helper_mem_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int regno,
+static int check_helper_mem_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int argno,
 				   int access_size, enum bpf_access_type access_type,
 				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
@@ -6951,37 +7001,37 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
-		return check_packet_access(env, reg, regno, 0, access_size,
+		return check_packet_access(env, reg, argno, 0, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
 		if (access_type =3D=3D BPF_WRITE) {
-			verbose(env, "R%d cannot write into %s\n", regno,
-				reg_type_str(env, reg->type));
+			verbose(env, "%s cannot write into %s\n",
+				reg_arg_name(env, argno), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
-		return check_mem_region_access(env, reg, regno, 0, access_size,
+		return check_mem_region_access(env, reg, argno, 0, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access_type(env, reg, regno, 0, access_size, access_type=
))
+		if (check_map_access_type(env, reg, argno, 0, access_size, access_type=
))
 			return -EACCES;
-		return check_map_access(env, reg, regno, 0, access_size,
+		return check_map_access(env, reg, argno, 0, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
 			if (access_type =3D=3D BPF_WRITE) {
-				verbose(env, "R%d cannot write into %s\n", regno,
-					reg_type_str(env, reg->type));
+				verbose(env, "%s cannot write into %s\n",
+					reg_arg_name(env, argno), reg_type_str(env, reg->type));
 				return -EACCES;
 			}
 		}
-		return check_mem_region_access(env, reg, regno, 0,
+		return check_mem_region_access(env, reg, argno, 0,
 					       access_size, reg->mem_size,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
 		if (type_is_rdonly_mem(reg->type)) {
 			if (access_type =3D=3D BPF_WRITE) {
-				verbose(env, "R%d cannot write into %s\n", regno,
-					reg_type_str(env, reg->type));
+				verbose(env, "%s cannot write into %s\n",
+					reg_arg_name(env, argno), reg_type_str(env, reg->type));
 				return -EACCES;
 			}
=20
@@ -6989,21 +7039,21 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 		} else {
 			max_access =3D &env->prog->aux->max_rdwr_access;
 		}
-		return check_buffer_access(env, reg, regno, 0,
+		return check_buffer_access(env, reg, argno, 0,
 					   access_size, zero_size_allowed,
 					   max_access);
 	case PTR_TO_STACK:
 		return check_stack_range_initialized(
 				env, reg,
-				regno, 0, access_size,
+				argno, 0, access_size,
 				zero_size_allowed, access_type, meta);
 	case PTR_TO_BTF_ID:
-		return check_ptr_to_btf_access(env, regs, reg, regno, 0,
+		return check_ptr_to_btf_access(env, regs, reg, argno, 0,
 					       access_size, BPF_READ, -1);
 	case PTR_TO_CTX:
 		/* Only permit reading or writing syscall context using helper calls. =
*/
 		if (is_var_ctx_off_allowed(env->prog)) {
-			int err =3D check_mem_region_access(env, reg, regno, 0, access_size, =
U16_MAX,
+			int err =3D check_mem_region_access(env, reg, argno, 0, access_size, =
U16_MAX,
 							  zero_size_allowed);
 			if (err)
 				return err;
@@ -7018,7 +7068,7 @@ static int check_helper_mem_access(struct bpf_verif=
ier_env *env, struct bpf_reg_
 		    bpf_register_is_null(reg))
 			return 0;
=20
-		verbose(env, "R%d type=3D%s ", regno,
+		verbose(env, "%s type=3D%s ", reg_arg_name(env, argno),
 			reg_type_str(env, reg->type));
 		verbose(env, "expected=3D%s\n", reg_type_str(env, PTR_TO_STACK));
 		return -EACCES;
@@ -7033,12 +7083,12 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
  */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *mem_reg,
-			      struct bpf_reg_state *size_reg, u32 mem_regno,
+			      struct bpf_reg_state *size_reg, u32 mem_argno,
 			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
-	int size_regno =3D mem_regno + 1;
+	int size_argno =3D next_argno(mem_argno);
 	int err;
=20
 	/* This is used to refine r0 return value bounds for helpers
@@ -7060,31 +7110,31 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
 		meta =3D NULL;
=20
 	if (size_reg->smin_value < 0) {
-		verbose(env, "R%d min value is negative, either use unsigned or 'var &=
=3D const'\n",
-			size_regno);
+		verbose(env, "%s min value is negative, either use unsigned or 'var &=3D=
 const'\n",
+			reg_arg_name(env, size_argno));
 		return -EACCES;
 	}
=20
 	if (size_reg->umin_value =3D=3D 0 && !zero_size_allowed) {
-		verbose(env, "R%d invalid zero-sized read: u64=3D[%lld,%lld]\n",
-			size_regno, size_reg->umin_value, size_reg->umax_value);
+		verbose(env, "%s invalid zero-sized read: u64=3D[%lld,%lld]\n",
+			reg_arg_name(env, size_argno), size_reg->umin_value, size_reg->umax_v=
alue);
 		return -EACCES;
 	}
=20
 	if (size_reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
-		verbose(env, "R%d unbounded memory access, use 'var &=3D const' or 'if=
 (var < const)'\n",
-			size_regno);
+		verbose(env, "%s unbounded memory access, use 'var &=3D const' or 'if =
(var < const)'\n",
+			reg_arg_name(env, size_argno));
 		return -EACCES;
 	}
-	err =3D check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax=
_value,
+	err =3D check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax=
_value,
 				      access_type, zero_size_allowed, meta);
-	if (!err)
-		err =3D mark_chain_precision(env, size_regno);
+	if (!err && !is_stack_argno(size_argno))
+		err =3D mark_chain_precision(env, size_argno);
 	return err;
 }
=20
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_st=
ate *reg,
-			 u32 regno, u32 mem_size)
+			 u32 argno, u32 mem_size)
 {
 	bool may_be_null =3D type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -7104,8 +7154,8 @@ static int check_mem_reg(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *reg
=20
 	int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem_size =
: mem_size;
=20
-	err =3D check_helper_mem_access(env, reg, regno, size, BPF_READ, true, =
NULL);
-	err =3D err ?: check_helper_mem_access(env, reg, regno, size, BPF_WRITE=
, true, NULL);
+	err =3D check_helper_mem_access(env, reg, argno, size, BPF_READ, true, =
NULL);
+	err =3D err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE=
, true, NULL);
=20
 	if (may_be_null)
 		*reg =3D saved_reg;
@@ -7114,14 +7164,15 @@ static int check_mem_reg(struct bpf_verifier_env =
*env, struct bpf_reg_state *reg
 }
=20
 static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct=
 bpf_reg_state *mem_reg,
-				    struct bpf_reg_state *size_reg, u32 mem_regno)
+				    struct bpf_reg_state *size_reg, u32 mem_argno)
 {
 	bool may_be_null =3D type_may_be_null(mem_reg->type);
 	struct bpf_reg_state saved_reg;
 	struct bpf_call_arg_meta meta;
+	u32 argno =3D make_argno(mem_argno);
 	int err;
=20
-	WARN_ON_ONCE(mem_regno > BPF_REG_4);
+	WARN_ON_ONCE(mem_argno > BPF_REG_3);
=20
 	memset(&meta, 0, sizeof(meta));
=20
@@ -7130,8 +7181,8 @@ static int check_kfunc_mem_size_reg(struct bpf_veri=
fier_env *env, struct bpf_reg
 		mark_ptr_not_null_reg(mem_reg);
 	}
=20
-	err =3D check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_READ,=
 true, &meta);
-	err =3D err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BP=
F_WRITE, true, &meta);
+	err =3D check_mem_size_reg(env, mem_reg, size_reg, argno, BPF_READ, tru=
e, &meta);
+	err =3D err ?: check_mem_size_reg(env, mem_reg, size_reg, argno, BPF_WR=
ITE, true, &meta);
=20
 	if (may_be_null)
 		*mem_reg =3D saved_reg;
@@ -7167,7 +7218,7 @@ enum {
  * env->cur_state->active_locks remembers which map value element or all=
ocated
  * object got locked and clears it after bpf_spin_unlock.
  */
-static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg, int regno, int flags)
+static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg, int argno, int flags)
 {
 	bool is_lock =3D flags & PROCESS_SPIN_LOCK, is_res_lock =3D flags & PRO=
CESS_RES_LOCK;
 	const char *lock_str =3D is_res_lock ? "bpf_res_spin" : "bpf_spin";
@@ -7183,8 +7234,8 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, struct bpf_reg_state
=20
 	if (!is_const) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s_lock has to be at the constant =
offset\n",
-			regno, lock_str);
+			"%s doesn't have constant offset. %s_lock has to be at the constant o=
ffset\n",
+			reg_arg_name(env, argno), lock_str);
 		return -EINVAL;
 	}
 	if (reg->type =3D=3D PTR_TO_MAP_VALUE) {
@@ -7283,7 +7334,7 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, struct bpf_reg_state
 }
=20
 /* Check if @regno is a pointer to a specific field in a map value */
-static int check_map_field_pointer(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, u32 regno,
+static int check_map_field_pointer(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, u32 argno,
 				   enum btf_field_type field_type,
 				   struct bpf_map_desc *map_desc)
 {
@@ -7295,8 +7346,8 @@ static int check_map_field_pointer(struct bpf_verif=
ier_env *env, struct bpf_reg_
=20
 	if (!is_const) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
-			regno, struct_name);
+			"%s doesn't have constant offset. %s has to be at the constant offset=
\n",
+			reg_arg_name(env, argno), struct_name);
 		return -EINVAL;
 	}
 	if (!map->btf) {
@@ -7336,26 +7387,26 @@ static int check_map_field_pointer(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 	return 0;
 }
=20
-static int process_timer_func(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int regno,
+static int process_timer_func(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int argno,
 			      struct bpf_map_desc *map)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
-	return check_map_field_pointer(env, reg, regno, BPF_TIMER, map);
+	return check_map_field_pointer(env, reg, argno, BPF_TIMER, map);
 }
=20
-static int process_timer_helper(struct bpf_verifier_env *env, struct bpf=
_reg_state *reg, int regno,
+static int process_timer_helper(struct bpf_verifier_env *env, struct bpf=
_reg_state *reg, int argno,
 				struct bpf_call_arg_meta *meta)
 {
-	return process_timer_func(env, reg, regno, &meta->map);
+	return process_timer_func(env, reg, argno, &meta->map);
 }
=20
-static int process_timer_kfunc(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int regno,
+static int process_timer_kfunc(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int argno,
 			       struct bpf_kfunc_call_arg_meta *meta)
 {
-	return process_timer_func(env, reg, regno, &meta->map);
+	return process_timer_func(env, reg, argno, &meta->map);
 }
=20
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
@@ -7431,15 +7482,15 @@ static int process_kptr_func(struct bpf_verifier_=
env *env, int regno,
  * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their ar=
gument
  * type, and declare it as 'const struct bpf_dynptr *' in their prototyp=
e.
  */
-static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int regno, int insn_idx,
+static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int argno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
 	int err;
=20
 	if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DYNPTR) =
{
 		verbose(env,
-			"arg#%d expected pointer to stack or const struct bpf_dynptr\n",
-			regno - 1);
+			"%s expected pointer to stack or const struct bpf_dynptr\n",
+			reg_arg_name(env, argno));
 		return -EINVAL;
 	}
=20
@@ -7476,7 +7527,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, struct bpf_reg_stat
=20
 		/* we write BPF_DW bits (8 bytes) at a time */
 		for (i =3D 0; i < BPF_DYNPTR_SIZE; i +=3D 8) {
-			err =3D check_mem_access(env, insn_idx, reg, regno,
+			err =3D check_mem_access(env, insn_idx, reg, argno,
 					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
@@ -7491,17 +7542,16 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, struct bpf_reg_stat
 		}
=20
 		if (!is_dynptr_reg_valid_init(env, reg)) {
-			verbose(env,
-				"Expected an initialized dynptr as arg #%d\n",
-				regno - 1);
+			verbose(env, "Expected an initialized dynptr as %s\n",
+				reg_arg_name(env, argno));
 			return -EINVAL;
 		}
=20
 		/* Fold modifiers (in this case, MEM_RDONLY) when checking expected ty=
pe */
 		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
-			verbose(env,
-				"Expected a dynptr of type %s as arg #%d\n",
-				dynptr_type_str(arg_to_dynptr_type(arg_type)), regno - 1);
+			verbose(env, "Expected a dynptr of type %s as %s\n",
+				dynptr_type_str(arg_to_dynptr_type(arg_type)),
+				reg_arg_name(env, argno));
 			return -EINVAL;
 		}
=20
@@ -7546,14 +7596,16 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_ca=
ll_arg_meta *meta, int arg_idx,
 	return btf_param_match_suffix(meta->btf, arg, "__iter");
 }
=20
-static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int regno, int insn_idx,
+static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int argno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
 	const struct btf_type *t;
+	u32 arg_idx =3D arg_idx_from_argno(argno);
 	int spi, err, i, nr_slots, btf_id;
=20
 	if (reg->type !=3D PTR_TO_STACK) {
-		verbose(env, "arg#%d expected pointer to an iterator on stack\n", regn=
o - 1);
+		verbose(env, "%s expected pointer to an iterator on stack\n",
+			reg_arg_name(env, argno));
 		return -EINVAL;
 	}
=20
@@ -7563,9 +7615,10 @@ static int process_iter_arg(struct bpf_verifier_en=
v *env, struct bpf_reg_state *
 	 * to any kfunc, if arg has "__iter" suffix, we need to be a bit more
 	 * conservative here.
 	 */
-	btf_id =3D btf_check_iter_arg(meta->btf, meta->func_proto, regno - 1);
+	btf_id =3D btf_check_iter_arg(meta->btf, meta->func_proto, arg_idx);
 	if (btf_id < 0) {
-		verbose(env, "expected valid iter pointer as arg #%d\n", regno - 1);
+		verbose(env, "expected valid iter pointer as %s\n",
+			reg_arg_name(env, argno));
 		return -EINVAL;
 	}
 	t =3D btf_type_by_id(meta->btf, btf_id);
@@ -7574,13 +7627,13 @@ static int process_iter_arg(struct bpf_verifier_e=
nv *env, struct bpf_reg_state *
 	if (is_iter_new_kfunc(meta)) {
 		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
-			verbose(env, "expected uninitialized iter_%s as arg #%d\n",
-				iter_type_str(meta->btf, btf_id), regno - 1);
+			verbose(env, "expected uninitialized iter_%s as %s\n",
+				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
 			return -EINVAL;
 		}
=20
 		for (i =3D 0; i < nr_slots * 8; i +=3D BPF_REG_SIZE) {
-			err =3D check_mem_access(env, insn_idx, reg, regno,
+			err =3D check_mem_access(env, insn_idx, reg, argno,
 					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
@@ -7598,8 +7651,8 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, struct bpf_reg_state *
 		case 0:
 			break;
 		case -EINVAL:
-			verbose(env, "expected an initialized iter_%s as arg #%d\n",
-				iter_type_str(meta->btf, btf_id), regno - 1);
+			verbose(env, "expected an initialized iter_%s as %s\n",
+				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
@@ -8019,7 +8072,7 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_DYNPTR]		=3D &dynptr_types,
 };
=20
-static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_s=
tate *reg, u32 regno,
+static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_s=
tate *reg, u32 argno,
 			  enum bpf_arg_type arg_type,
 			  const u32 *arg_btf_id,
 			  struct bpf_call_arg_meta *meta)
@@ -8054,7 +8107,8 @@ static int check_reg_type(struct bpf_verifier_env *=
env, struct bpf_reg_state *re
 		type &=3D ~DYNPTR_TYPE_FLAG_MASK;
=20
 	/* Local kptr types are allowed as the source argument of bpf_kptr_xchg=
 */
-	if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type) && r=
egno =3D=3D BPF_REG_2) {
+	if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type) &&
+	    !is_stack_argno(argno) && argno =3D=3D BPF_REG_2) {
 		type &=3D ~MEM_ALLOC;
 		type &=3D ~MEM_PERCPU;
 	}
@@ -8068,7 +8122,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, struct bpf_reg_state *re
 			goto found;
 	}
=20
-	verbose(env, "R%d type=3D%s expected=3D", regno, reg_type_str(env, reg-=
>type));
+	verbose(env, "%s type=3D%s expected=3D", reg_arg_name(env, argno), reg_=
type_str(env, reg->type));
 	for (j =3D 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
@@ -8081,9 +8135,9 @@ static int check_reg_type(struct bpf_verifier_env *=
env, struct bpf_reg_state *re
 	if (compatible =3D=3D &mem_types) {
 		if (!(arg_type & MEM_RDONLY)) {
 			verbose(env,
-				"%s() may write into memory pointed by R%d type=3D%s\n",
+				"%s() may write into memory pointed by %s type=3D%s\n",
 				func_id_name(meta->func_id),
-				regno, reg_type_str(env, reg->type));
+				reg_arg_name(env, argno), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
 		return 0;
@@ -8106,7 +8160,8 @@ static int check_reg_type(struct bpf_verifier_env *=
env, struct bpf_reg_state *re
=20
 		if (type_may_be_null(reg->type) &&
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
-			verbose(env, "Possibly NULL pointer passed to helper arg%d\n", regno)=
;
+			verbose(env, "Possibly NULL pointer passed to helper %s\n",
+				reg_arg_name(env, argno));
 			return -EACCES;
 		}
=20
@@ -8119,25 +8174,26 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, struct bpf_reg_state *re
 		}
=20
 		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg) {
-			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
+			if (map_kptr_match_type(env, meta->kptr_field, reg, argno))
 				return -EACCES;
 		} else {
 			if (arg_btf_id =3D=3D BPF_PTR_POISON) {
 				verbose(env, "verifier internal error:");
-				verbose(env, "R%d has non-overwritten BPF_PTR_POISON type\n",
-					regno);
+				verbose(env, "%s has non-overwritten BPF_PTR_POISON type\n",
+					reg_arg_name(env, argno));
 				return -EACCES;
 			}
=20
-			err =3D __check_ptr_off_reg(env, reg, regno, true);
+			err =3D __check_ptr_off_reg(env, reg, argno, true);
 			if (err)
 				return err;
=20
 			if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id,
 						  reg->var_off.value, btf_vmlinux, *arg_btf_id,
 						  strict_type_match)) {
-				verbose(env, "R%d is of type %s but %s is expected\n",
-					regno, btf_type_name(reg->btf, reg->btf_id),
+				verbose(env, "%s is of type %s but %s is expected\n",
+					reg_arg_name(env, argno),
+					btf_type_name(reg->btf, reg->btf_id),
 					btf_type_name(btf_vmlinux, *arg_btf_id));
 				return -EACCES;
 			}
@@ -8154,8 +8210,9 @@ static int check_reg_type(struct bpf_verifier_env *=
env, struct bpf_reg_state *re
 			return -EFAULT;
 		}
 		/* Check if local kptr in src arg matches kptr in dst arg */
-		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && regno =3D=3D BPF_REG_2)=
 {
-			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
+		if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg &&
+		    !is_stack_argno(argno) && argno =3D=3D BPF_REG_2) {
+			if (map_kptr_match_type(env, meta->kptr_field, reg, argno))
 				return -EACCES;
 		}
 		break;
@@ -8189,7 +8246,7 @@ reg_find_field_offset(const struct bpf_reg_state *r=
eg, s32 off, u32 fields)
 }
=20
 static int check_func_arg_reg_off(struct bpf_verifier_env *env,
-				  const struct bpf_reg_state *reg, int regno,
+				  const struct bpf_reg_state *reg, int argno,
 				  enum bpf_arg_type arg_type)
 {
 	u32 type =3D reg->type;
@@ -8215,8 +8272,8 @@ static int check_func_arg_reg_off(struct bpf_verifi=
er_env *env,
 		 * to give the user a better error message.
 		 */
 		if (!tnum_is_const(reg->var_off) || reg->var_off.value !=3D 0) {
-			verbose(env, "R%d must have zero offset when passed to release func o=
r trusted arg to kfunc\n",
-				regno);
+			verbose(env, "%s must have zero offset when passed to release func or=
 trusted arg to kfunc\n",
+				reg_arg_name(env, argno));
 			return -EINVAL;
 		}
 	}
@@ -8252,7 +8309,7 @@ static int check_func_arg_reg_off(struct bpf_verifi=
er_env *env,
 		 * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
 		 * still need to do checks instead of returning.
 		 */
-		return __check_ptr_off_reg(env, reg, regno, true);
+		return __check_ptr_off_reg(env, reg, argno, true);
 	case PTR_TO_CTX:
 		/*
 		 * Allow fixed and variable offsets for syscall context, but
@@ -8264,7 +8321,7 @@ static int check_func_arg_reg_off(struct bpf_verifi=
er_env *env,
 			return 0;
 		fallthrough;
 	default:
-		return __check_ptr_off_reg(env, reg, regno, false);
+		return __check_ptr_off_reg(env, reg, argno, false);
 	}
 }
=20
@@ -8334,8 +8391,8 @@ static enum bpf_dynptr_type dynptr_get_type(struct =
bpf_verifier_env *env,
 	return state->stack[spi].spilled_ptr.dynptr.type;
 }
=20
-static int check_reg_const_str(struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg, u32 regno)
+static int check_arg_const_str(struct bpf_verifier_env *env,
+			       struct bpf_reg_state *reg, u32 argno)
 {
 	struct bpf_map *map =3D reg->map_ptr;
 	int err;
@@ -8347,17 +8404,18 @@ static int check_reg_const_str(struct bpf_verifie=
r_env *env,
 		return -EINVAL;
=20
 	if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY) {
-		verbose(env, "R%d points to insn_array map which cannot be used as con=
st string\n", regno);
+		verbose(env, "%s points to insn_array map which cannot be used as cons=
t string\n",
+			reg_arg_name(env, argno));
 		return -EACCES;
 	}
=20
 	if (!bpf_map_is_rdonly(map)) {
-		verbose(env, "R%d does not point to a readonly map'\n", regno);
+		verbose(env, "%s does not point to a readonly map'\n", reg_arg_name(en=
v, argno));
 		return -EACCES;
 	}
=20
 	if (!tnum_is_const(reg->var_off)) {
-		verbose(env, "R%d is not a constant address'\n", regno);
+		verbose(env, "%s is not a constant address'\n", reg_arg_name(env, argn=
o));
 		return -EACCES;
 	}
=20
@@ -8366,7 +8424,7 @@ static int check_reg_const_str(struct bpf_verifier_=
env *env,
 		return -EACCES;
 	}
=20
-	err =3D check_map_access(env, reg, regno, 0,
+	err =3D check_map_access(env, reg, argno, 0,
 			       map->value_size - reg->var_off.value, false,
 			       ACCESS_HELPER);
 	if (err)
@@ -8705,7 +8763,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		break;
 	case ARG_PTR_TO_CONST_STR:
 	{
-		err =3D check_reg_const_str(env, reg, regno);
+		err =3D check_arg_const_str(env, reg, regno);
 		if (err)
 			return err;
 		break;
@@ -9294,13 +9352,14 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 	 * verifier sees.
 	 */
 	for (i =3D 0; i < sub->arg_cnt; i++) {
+		u32 argno =3D make_argno(i);
 		u32 regno =3D i + 1;
 		struct bpf_reg_state *reg =3D &regs[regno];
 		struct bpf_subprog_arg_info *arg =3D &sub->args[i];
=20
 		if (arg->arg_type =3D=3D ARG_ANYTHING) {
 			if (reg->type !=3D SCALAR_VALUE) {
-				bpf_log(log, "R%d is not a scalar\n", regno);
+				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 		} else if (arg->arg_type & PTR_UNTRUSTED) {
@@ -9310,24 +9369,26 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 			 * invalid memory access.
 			 */
 		} else if (arg->arg_type =3D=3D ARG_PTR_TO_CTX) {
-			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_CTX);
+			ret =3D check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
 			if (ret < 0)
 				return ret;
 			/* If function expects ctx type in BTF check that caller
 			 * is passing PTR_TO_CTX.
 			 */
 			if (reg->type !=3D PTR_TO_CTX) {
-				bpf_log(log, "arg#%d expects pointer to ctx\n", i);
+				bpf_log(log, "%s expects pointer to ctx\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
-			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+			ret =3D check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, regno, arg->mem_size))
+			if (check_mem_reg(env, reg, argno, arg->mem_size))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)=
) {
-				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
+				bpf_log(log, "%s is expected to be non-NULL\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_ARENA) {
@@ -9339,15 +9400,16 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 			 * run-time debug nightmare.
 			 */
 			if (reg->type !=3D PTR_TO_ARENA && reg->type !=3D SCALAR_VALUE) {
-				bpf_log(log, "R%d is not a pointer to arena or scalar.\n", regno);
+				bpf_log(log, "%s is not a pointer to arena or scalar.\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 		} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
-			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_DYNPTR);
+			ret =3D check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_DYNPTR);
 			if (ret)
 				return ret;
=20
-			ret =3D process_dynptr_func(env, reg, regno, -1, arg->arg_type, 0);
+			ret =3D process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
@@ -9358,12 +9420,13 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 				continue;
=20
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
-			err =3D check_reg_type(env, reg, regno, arg->arg_type, &arg->btf_id, =
&meta);
-			err =3D err ?: check_func_arg_reg_off(env, reg, regno, arg->arg_type)=
;
+			err =3D check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, =
&meta);
+			err =3D err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type)=
;
 			if (err)
 				return err;
 		} else {
-			verifier_bug(env, "unrecognized arg#%d type %d", i, arg->arg_type);
+			verifier_bug(env, "unrecognized %s type %d",
+				     reg_arg_name(env, argno), arg->arg_type);
 			return -EFAULT;
 		}
 	}
@@ -11406,8 +11469,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
=20
 	if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_type=
(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
-			verbose(env, "kernel function %s args#%d pointer type %s %s is not su=
pported\n",
-				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
+			verbose(env, "kernel function %s %s pointer type %s %s is not support=
ed\n",
+				meta->func_name, reg_arg_name(env, make_argno(argno)),
+				btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
 		return KF_ARG_PTR_TO_BTF_ID;
@@ -11423,8 +11487,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
 	 */
 	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, met=
a->btf, ref_t, 0) &&
 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
-		verbose(env, "arg#%d pointer type %s %s must point to %sscalar, or str=
uct with scalar\n",
-			argno, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct =
with scalar\n",
+			reg_arg_name(env, make_argno(argno)),
+			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
 		return -EINVAL;
 	}
 	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
@@ -11493,15 +11558,16 @@ static int process_kf_arg_ptr_to_btf_id(struct =
bpf_verifier_env *env,
 	 */
 	taking_projection =3D btf_is_projection_of(ref_tname, reg_ref_tname);
 	if (!taking_projection && !struct_same) {
-		verbose(env, "kernel function %s args#%d expected pointer to %s %s but=
 R%d has a pointer to %s %s\n",
-			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
+		verbose(env, "kernel function %s %s expected pointer to %s %s but %s h=
as a pointer to %s %s\n",
+			meta->func_name, reg_arg_name(env, make_argno(argno)),
+			btf_type_str(ref_t), ref_tname, reg_arg_name(env, make_argno(argno)),
 			btf_type_str(reg_ref_t), reg_ref_tname);
 		return -EINVAL;
 	}
 	return 0;
 }
=20
-static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int regno,
+static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int argno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
 	int err, kfunc_class =3D IRQ_NATIVE_KFUNC;
@@ -11524,11 +11590,13 @@ static int process_irq_flag(struct bpf_verifier=
_env *env, struct bpf_reg_state *
=20
 	if (irq_save) {
 		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
-			verbose(env, "expected uninitialized irq flag as arg#%d\n", regno - 1=
);
+			verbose(env, "expected uninitialized irq flag as %s\n",
+				reg_arg_name(env, argno));
 			return -EINVAL;
 		}
=20
-		err =3D check_mem_access(env, env->insn_idx, reg, regno, 0, BPF_DW, BP=
F_WRITE, -1, false, false);
+		err =3D check_mem_access(env, env->insn_idx, reg, argno, 0, BPF_DW,
+				       BPF_WRITE, -1, false, false);
 		if (err)
 			return err;
=20
@@ -11538,7 +11606,8 @@ static int process_irq_flag(struct bpf_verifier_e=
nv *env, struct bpf_reg_state *
 	} else {
 		err =3D is_irq_flag_reg_valid_init(env, reg);
 		if (err) {
-			verbose(env, "expected an initialized irq flag as arg#%d\n", regno - =
1);
+			verbose(env, "expected an initialized irq flag as %s\n",
+				reg_arg_name(env, argno));
 			return err;
 		}
=20
@@ -11829,7 +11898,7 @@ static bool check_kfunc_is_graph_node_api(struct =
bpf_verifier_env *env,
=20
 static int
 __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
-				   struct bpf_reg_state *reg, u32 regno,
+				   struct bpf_reg_state *reg, u32 argno,
 				   struct bpf_kfunc_call_arg_meta *meta,
 				   enum btf_field_type head_field_type,
 				   struct btf_field **head_field)
@@ -11850,8 +11919,8 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_ver=
ifier_env *env,
 	head_type_name =3D btf_field_type_name(head_field_type);
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
-			regno, head_type_name);
+			"%s doesn't have constant offset. %s has to be at the constant offset=
\n",
+			reg_arg_name(env, argno), head_type_name);
 		return -EINVAL;
 	}
=20
@@ -11879,24 +11948,24 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_v=
erifier_env *env,
 }
=20
 static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
-					   struct bpf_reg_state *reg, u32 regno,
+					   struct bpf_reg_state *reg, u32 argno,
 					   struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_graph_root(env, reg, regno, meta, BPF_LI=
ST_HEAD,
+	return __process_kf_arg_ptr_to_graph_root(env, reg, argno, meta, BPF_LI=
ST_HEAD,
 							  &meta->arg_list_head.field);
 }
=20
 static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *en=
v,
-					     struct bpf_reg_state *reg, u32 regno,
+					     struct bpf_reg_state *reg, u32 argno,
 					     struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_graph_root(env, reg, regno, meta, BPF_RB=
_ROOT,
+	return __process_kf_arg_ptr_to_graph_root(env, reg, argno, meta, BPF_RB=
_ROOT,
 							  &meta->arg_rbtree_root.field);
 }
=20
 static int
 __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
-				   struct bpf_reg_state *reg, u32 regno,
+				   struct bpf_reg_state *reg, u32 argno,
 				   struct bpf_kfunc_call_arg_meta *meta,
 				   enum btf_field_type head_field_type,
 				   enum btf_field_type node_field_type,
@@ -11918,8 +11987,8 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_ver=
ifier_env *env,
 	node_type_name =3D btf_field_type_name(node_field_type);
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
-			regno, node_type_name);
+			"%s doesn't have constant offset. %s has to be at the constant offset=
\n",
+			reg_arg_name(env, argno), node_type_name);
 		return -EINVAL;
 	}
=20
@@ -11960,19 +12029,19 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_v=
erifier_env *env,
 }
=20
 static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
-					   struct bpf_reg_state *reg, u32 regno,
+					   struct bpf_reg_state *reg, u32 argno,
 					   struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+	return __process_kf_arg_ptr_to_graph_node(env, reg, argno, meta,
 						  BPF_LIST_HEAD, BPF_LIST_NODE,
 						  &meta->arg_list_head.field);
 }
=20
 static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *en=
v,
-					     struct bpf_reg_state *reg, u32 regno,
+					     struct bpf_reg_state *reg, u32 argno,
 					     struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
+	return __process_kf_arg_ptr_to_graph_node(env, reg, argno, meta,
 						  BPF_RB_ROOT, BPF_RB_NODE,
 						  &meta->arg_rbtree_root.field);
 }
@@ -12024,6 +12093,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 		struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[i + 1];
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
+		u32 argno =3D make_argno(i);
 		u32 regno =3D i + 1, ref_id, type_size;
 		bool is_ret_buf_sz =3D false;
 		int kf_arg_type;
@@ -12046,7 +12116,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
=20
 		if (btf_type_is_scalar(t)) {
 			if (reg->type !=3D SCALAR_VALUE) {
-				verbose(env, "R%d is not a scalar\n", regno);
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
 				return -EINVAL;
 			}
=20
@@ -12056,7 +12126,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					return -EFAULT;
 				}
 				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "R%d must be a known constant\n", regno);
+					verbose(env, "%s must be a known constant\n",
+						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 				ret =3D mark_chain_precision(env, regno);
@@ -12078,7 +12149,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				}
=20
 				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "R%d is not a const\n", regno);
+					verbose(env, "%s is not a const\n",
+						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
=20
@@ -12091,20 +12163,22 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 		}
=20
 		if (!btf_type_is_ptr(t)) {
-			verbose(env, "Unrecognized arg#%d type %s\n", i, btf_type_str(t));
+			verbose(env, "Unrecognized %s type %s\n",
+				reg_arg_name(env, argno), btf_type_str(t));
 			return -EINVAL;
 		}
=20
 		if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
-			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
+			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
+				reg_arg_name(env, argno));
 			return -EACCES;
 		}
=20
 		if (reg->ref_obj_id) {
 			if (is_kfunc_release(meta) && meta->ref_obj_id) {
-				verifier_bug(env, "more than one arg with ref_obj_id R%d %u %u",
-					     regno, reg->ref_obj_id,
+				verifier_bug(env, "more than one arg with ref_obj_id %s %u %u",
+					     reg_arg_name(env, argno), reg->ref_obj_id,
 					     meta->ref_obj_id);
 				return -EFAULT;
 			}
@@ -12125,7 +12199,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			continue;
 		case KF_ARG_PTR_TO_MAP:
 			if (!reg->map_ptr) {
-				verbose(env, "pointer in R%d isn't map pointer\n", regno);
+				verbose(env, "pointer in %s isn't map pointer\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (meta->map.ptr && (reg->map_ptr->record->wq_off >=3D 0 ||
@@ -12163,11 +12238,13 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
-					verbose(env, "R%d must be referenced or trusted\n", regno);
+					verbose(env, "%s must be referenced or trusted\n",
+						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
-					verbose(env, "R%d must be a rcu pointer\n", regno);
+					verbose(env, "%s must be a rcu pointer\n",
+						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 			}
@@ -12199,15 +12276,15 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
=20
 		if (is_kfunc_release(meta) && reg->ref_obj_id)
 			arg_type |=3D OBJ_RELEASE;
-		ret =3D check_func_arg_reg_off(env, reg, regno, arg_type);
+		ret =3D check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
 			return ret;
=20
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type !=3D PTR_TO_CTX) {
-				verbose(env, "arg#%d expected pointer to ctx, but got %s\n",
-					i, reg_type_str(env, reg->type));
+				verbose(env, "%s expected pointer to ctx, but got %s\n",
+					reg_arg_name(env, argno), reg_type_str(env, reg->type));
 				return -EINVAL;
 			}
=20
@@ -12221,16 +12298,19 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 			if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
-					verbose(env, "arg#%d expected for bpf_obj_drop()\n", i);
+					verbose(env, "%s expected for bpf_obj_drop()\n",
+						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 			} else if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU))=
 {
 				if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
-					verbose(env, "arg#%d expected for bpf_percpu_obj_drop()\n", i);
+					verbose(env, "%s expected for bpf_percpu_obj_drop()\n",
+						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 			} else {
-				verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				verbose(env, "%s expected pointer to allocated object\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (!reg->ref_obj_id) {
@@ -12281,7 +12361,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				}
 			}
=20
-			ret =3D process_dynptr_func(env, reg, regno, insn_idx, dynptr_arg_typ=
e, clone_ref_obj_id);
+			ret =3D process_dynptr_func(env, reg, argno, insn_idx,
+						  dynptr_arg_type, clone_ref_obj_id);
 			if (ret < 0)
 				return ret;
=20
@@ -12306,55 +12387,59 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
-			ret =3D process_iter_arg(env, reg, regno, insn_idx, meta);
+			ret =3D process_iter_arg(env, reg, argno, insn_idx, meta);
 			if (ret < 0)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_LIST_HEAD:
 			if (reg->type !=3D PTR_TO_MAP_VALUE &&
 			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "arg#%d expected pointer to map value or allocated obje=
ct\n", i);
+				verbose(env, "%s expected pointer to map value or allocated object\n=
",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id)=
 {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
-			ret =3D process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_list_head(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_ROOT:
 			if (reg->type !=3D PTR_TO_MAP_VALUE &&
 			    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "arg#%d expected pointer to map value or allocated obje=
ct\n", i);
+				verbose(env, "%s expected pointer to map value or allocated object\n=
",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (reg->type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id)=
 {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
-			ret =3D process_kf_arg_ptr_to_rbtree_root(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_rbtree_root(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_LIST_NODE:
 			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
-				verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				verbose(env, "%s expected pointer to allocated object\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (!reg->ref_obj_id) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
-			ret =3D process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_list_node(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_NODE:
 			if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
 				if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
-					verbose(env, "arg#%d expected pointer to allocated object\n", i);
+					verbose(env, "%s expected pointer to allocated object\n",
+						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
 				if (!reg->ref_obj_id) {
@@ -12372,7 +12457,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				}
 			}
=20
-			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12387,7 +12472,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
 			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) =
&&
 			    !reg2btf_ids[base_type(reg->type)]) {
-				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
+				verbose(env, "%s is %s ", reg_arg_name(env, argno),
+					reg_type_str(env, reg->type));
 				verbose(env, "expected %s or socket\n",
 					reg_type_str(env, base_type(reg->type) |
 							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
@@ -12400,11 +12486,12 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_MEM:
 			resolve_ret =3D btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
-				verbose(env, "arg#%d reference type('%s %s') size cannot be determin=
ed: %ld\n",
-					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
+				verbose(env, "%s reference type('%s %s') size cannot be determined: =
%ld\n",
+					reg_arg_name(env, argno), btf_type_str(ref_t),
+					ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret =3D check_mem_reg(env, reg, regno, type_size);
+			ret =3D check_mem_reg(env, reg, argno, type_size);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12416,9 +12503,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 			const struct btf_param *size_arg =3D &args[i + 1];
=20
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->b=
tf, buff_arg)) {
-				ret =3D check_kfunc_mem_size_reg(env, buff_reg, size_reg, regno);
+				ret =3D check_kfunc_mem_size_reg(env, buff_reg, size_reg, i);
 				if (ret < 0) {
-					verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memor=
y access\n", i, i + 1);
+					verbose(env, "%s and ", reg_arg_name(env, argno));
+					verbose(env, "%s memory, len pair leads to invalid memory access\n"=
,
+						reg_arg_name(env, next_argno(argno)));
 					return ret;
 				}
 			}
@@ -12429,7 +12518,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					return -EFAULT;
 				}
 				if (!tnum_is_const(size_reg->var_off)) {
-					verbose(env, "R%d must be a known constant\n", regno + 1);
+					verbose(env, "%s must be a known constant\n",
+						reg_arg_name(env, next_argno(argno)));
 					return -EINVAL;
 				}
 				meta->arg_constant.found =3D true;
@@ -12442,14 +12532,16 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 		}
 		case KF_ARG_PTR_TO_CALLBACK:
 			if (reg->type !=3D PTR_TO_FUNC) {
-				verbose(env, "arg%d expected pointer to func\n", i);
+				verbose(env, "%s expected pointer to func\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			meta->subprogno =3D reg->subprogno;
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
-				verbose(env, "arg#%d is neither owning or non-owning ref\n", i);
+				verbose(env, "%s is neither owning or non-owning ref\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			if (!type_is_non_owning_ref(reg->type))
@@ -12462,7 +12554,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			}
=20
 			if (rec->refcount_off < 0) {
-				verbose(env, "arg#%d doesn't point to a type with bpf_refcount field=
\n", i);
+				verbose(env, "%s doesn't point to a type with bpf_refcount field\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
=20
@@ -12471,46 +12564,51 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_CONST_STR:
 			if (reg->type !=3D PTR_TO_MAP_VALUE) {
-				verbose(env, "arg#%d doesn't point to a const string\n", i);
+				verbose(env, "%s doesn't point to a const string\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			ret =3D check_reg_const_str(env, reg, regno);
+			ret =3D check_arg_const_str(env, reg, argno);
 			if (ret)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_WORKQUEUE:
 			if (reg->type !=3D PTR_TO_MAP_VALUE) {
-				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				verbose(env, "%s doesn't point to a map value\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			ret =3D check_map_field_pointer(env, reg, regno, BPF_WORKQUEUE, &meta=
->map);
+			ret =3D check_map_field_pointer(env, reg, argno, BPF_WORKQUEUE, &meta=
->map);
 			if (ret < 0)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_TIMER:
 			if (reg->type !=3D PTR_TO_MAP_VALUE) {
-				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				verbose(env, "%s doesn't point to a map value\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			ret =3D process_timer_kfunc(env, reg, regno, meta);
+			ret =3D process_timer_kfunc(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_TASK_WORK:
 			if (reg->type !=3D PTR_TO_MAP_VALUE) {
-				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				verbose(env, "%s doesn't point to a map value\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			ret =3D check_map_field_pointer(env, reg, regno, BPF_TASK_WORK, &meta=
->map);
+			ret =3D check_map_field_pointer(env, reg, argno, BPF_TASK_WORK, &meta=
->map);
 			if (ret < 0)
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 			if (reg->type !=3D PTR_TO_STACK) {
-				verbose(env, "arg#%d doesn't point to an irq flag on stack\n", i);
+				verbose(env, "%s doesn't point to an irq flag on stack\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			ret =3D process_irq_flag(env, reg, regno, meta);
+			ret =3D process_irq_flag(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12519,7 +12617,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			int flags =3D PROCESS_RES_LOCK;
=20
 			if (reg->type !=3D PTR_TO_MAP_VALUE && reg->type !=3D (PTR_TO_BTF_ID =
| MEM_ALLOC)) {
-				verbose(env, "arg#%d doesn't point to map value or allocated object\=
n", i);
+				verbose(env, "%s doesn't point to map value or allocated object\n",
+					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
=20
@@ -12531,7 +12630,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqs=
ave] ||
 			    meta->func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock_ir=
qrestore])
 				flags |=3D PROCESS_LOCK_IRQ;
-			ret =3D process_spin_lock(env, reg, regno, flags);
+			ret =3D process_spin_lock(env, reg, argno, flags);
 			if (ret < 0)
 				return ret;
 			break;
@@ -18747,7 +18846,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
 				mark_reg_unknown(env, regs, i);
 			} else {
 				verifier_bug(env, "unhandled arg#%d type %d",
-					     i - BPF_REG_1, arg->arg_type);
+					     i - BPF_REG_1 + 1, arg->arg_type);
 				ret =3D -EFAULT;
 				goto out;
 			}
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/test=
ing/selftests/bpf/prog_tests/bpf_nf.c
index 215878ea04de..b33dba4b126e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -11,18 +11,18 @@ struct {
 	const char *prog_name;
 	const char *err_msg;
 } test_bpf_nf_fail_tests[] =3D {
-	{ "alloc_release", "kernel function bpf_ct_release args#0 expected poin=
ter to STRUCT nf_conn but" },
-	{ "insert_insert", "kernel function bpf_ct_insert_entry args#0 expected=
 pointer to STRUCT nf_conn___init but" },
-	{ "lookup_insert", "kernel function bpf_ct_insert_entry args#0 expected=
 pointer to STRUCT nf_conn___init but" },
-	{ "set_timeout_after_insert", "kernel function bpf_ct_set_timeout args#=
0 expected pointer to STRUCT nf_conn___init but" },
-	{ "set_status_after_insert", "kernel function bpf_ct_set_status args#0 =
expected pointer to STRUCT nf_conn___init but" },
-	{ "change_timeout_after_alloc", "kernel function bpf_ct_change_timeout =
args#0 expected pointer to STRUCT nf_conn but" },
-	{ "change_status_after_alloc", "kernel function bpf_ct_change_status ar=
gs#0 expected pointer to STRUCT nf_conn but" },
+	{ "alloc_release", "kernel function bpf_ct_release R1 expected pointer =
to STRUCT nf_conn but" },
+	{ "insert_insert", "kernel function bpf_ct_insert_entry R1 expected poi=
nter to STRUCT nf_conn___init but" },
+	{ "lookup_insert", "kernel function bpf_ct_insert_entry R1 expected poi=
nter to STRUCT nf_conn___init but" },
+	{ "set_timeout_after_insert", "kernel function bpf_ct_set_timeout R1 ex=
pected pointer to STRUCT nf_conn___init but" },
+	{ "set_status_after_insert", "kernel function bpf_ct_set_status R1 expe=
cted pointer to STRUCT nf_conn___init but" },
+	{ "change_timeout_after_alloc", "kernel function bpf_ct_change_timeout =
R1 expected pointer to STRUCT nf_conn but" },
+	{ "change_status_after_alloc", "kernel function bpf_ct_change_status R1=
 expected pointer to STRUCT nf_conn but" },
 	{ "write_not_allowlisted_field", "no write support to nf_conn at off" }=
,
-	{ "lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted arg=
1" },
-	{ "lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted arg3=
" },
-	{ "xdp_lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted=
 arg1" },
-	{ "xdp_lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted =
arg3" },
+	{ "lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted R2"=
 },
+	{ "lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted R4" =
},
+	{ "xdp_lookup_null_bpf_tuple", "Possibly NULL pointer passed to trusted=
 R2" },
+	{ "xdp_lookup_null_bpf_opts", "Possibly NULL pointer passed to trusted =
R4" },
 };
=20
 enum {
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/tes=
ting/selftests/bpf/prog_tests/cb_refs.c
index c40df623a8f7..6300b67a3a84 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -12,7 +12,7 @@ struct {
 	const char *err_msg;
 } cb_refs_tests[] =3D {
 	{ "underflow_prog", "must point to scalar, or struct with scalar" },
-	{ "leak_prog", "Possibly NULL pointer passed to helper arg2" },
+	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
 	{ "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /* alloc=
_insn=3D2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=3D1" }=
, /* alloc_insn=3D1{1,2} */
 };
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/=
testing/selftests/bpf/prog_tests/kfunc_call.c
index 62f3fb79f5d1..3df07680f9e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -68,7 +68,7 @@ static struct kfunc_test_params kfunc_tests[] =3D {
 	TC_FAIL(kfunc_call_test_get_mem_fail_oob, 0, "min value is outside of t=
he allowed memory range"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_not_const, 0, "is not a const"),
 	TC_FAIL(kfunc_call_test_mem_acquire_fail, 0, "acquire kernel function d=
oes not return PTR_TO_BTF_ID"),
-	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "arg#0 expected p=
ointer to ctx, but got scalar"),
+	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "R1 expected poin=
ter to ctx, but got scalar"),
=20
 	/* success cases */
 	TC_TEST(kfunc_call_test1, 12),
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 6f25b5f39a79..dbff099860ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -81,8 +81,8 @@ static struct {
 	{ "direct_write_node", "direct access to bpf_list_node is disallowed" }=
,
 	{ "use_after_unlock_push_front", "invalid mem access 'scalar'" },
 	{ "use_after_unlock_push_back", "invalid mem access 'scalar'" },
-	{ "double_push_front", "arg#1 expected pointer to allocated object" },
-	{ "double_push_back", "arg#1 expected pointer to allocated object" },
+	{ "double_push_front", "R2 expected pointer to allocated object" },
+	{ "double_push_back", "R2 expected pointer to allocated object" },
 	{ "no_node_value_type", "bpf_list_node not found at offset=3D0" },
 	{ "incorrect_value_type",
 	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=3D4=
8 in struct foo, "
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index 9fe9c4a4e8f6..a875ba8e5007 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -29,7 +29,7 @@ static struct __cgrps_kfunc_map_value *insert_lookup_cg=
rp(struct cgroup *cgrp)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgroup *cgrp, const ch=
ar *path)
 {
 	struct cgroup *acquired;
@@ -48,7 +48,7 @@ int BPF_PROG(cgrp_kfunc_acquire_untrusted, struct cgrou=
p *cgrp, const char *path
 }
=20
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(cgrp_kfunc_acquire_no_null_check, struct cgroup *cgrp, cons=
t char *path)
 {
 	struct cgroup *acquired;
@@ -64,7 +64,7 @@ int BPF_PROG(cgrp_kfunc_acquire_no_null_check, struct c=
group *cgrp, const char *
 }
=20
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("arg#0 pointer type STRUCT cgroup must point")
+__failure __msg("R1 pointer type STRUCT cgroup must point")
 int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp, const char *pat=
h)
 {
 	struct cgroup *acquired, *stack_cgrp =3D (struct cgroup *)&path;
@@ -106,7 +106,7 @@ int BPF_PROG(cgrp_kfunc_acquire_trusted_walked, struc=
t cgroup *cgrp, const char
 }
=20
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(cgrp_kfunc_acquire_null, struct cgroup *cgrp, const char *p=
ath)
 {
 	struct cgroup *acquired;
@@ -175,7 +175,7 @@ int BPF_PROG(cgrp_kfunc_rcu_get_release, struct cgrou=
p *cgrp, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const ch=
ar *path)
 {
 	struct __cgrps_kfunc_map_value *v;
@@ -191,7 +191,7 @@ int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgr=
oup *cgrp, const char *path
 }
=20
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("arg#0 pointer type STRUCT cgroup must point")
+__failure __msg("R1 pointer type STRUCT cgroup must point")
 int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *pat=
h)
 {
 	struct cgroup *acquired =3D (struct cgroup *)&path;
@@ -203,7 +203,7 @@ int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cg=
rp, const char *path)
 }
=20
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *p=
ath)
 {
 	struct __cgrps_kfunc_map_value local, *v;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/=
testing/selftests/bpf/progs/cpumask_failure.c
index 61c32e91e8c3..4c45346fe6f7 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -45,7 +45,7 @@ int BPF_PROG(test_alloc_no_release, struct task_struct =
*task, u64 clone_flags)
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("NULL pointer passed to trusted arg0")
+__failure __msg("NULL pointer passed to trusted R1")
 int BPF_PROG(test_alloc_double_release, struct task_struct *task, u64 cl=
one_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -73,7 +73,7 @@ int BPF_PROG(test_acquire_wrong_cpumask, struct task_st=
ruct *task, u64 clone_fla
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("bpf_cpumask_set_cpu args#1 expected pointer to STRUCT b=
pf_cpumask")
+__failure __msg("bpf_cpumask_set_cpu R2 expected pointer to STRUCT bpf_c=
pumask")
 int BPF_PROG(test_mutate_cpumask, struct task_struct *task, u64 clone_fl=
ags)
 {
 	/* Can't set the CPU of a non-struct bpf_cpumask. */
@@ -107,7 +107,7 @@ int BPF_PROG(test_insert_remove_no_release, struct ta=
sk_struct *task, u64 clone_
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("NULL pointer passed to trusted arg0")
+__failure __msg("NULL pointer passed to trusted R1")
 int BPF_PROG(test_cpumask_null, struct task_struct *task, u64 clone_flag=
s)
 {
   /* NULL passed to kfunc. */
@@ -151,7 +151,7 @@ int BPF_PROG(test_global_mask_out_of_rcu, struct task=
_struct *task, u64 clone_fl
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("NULL pointer passed to trusted arg1")
+__failure __msg("NULL pointer passed to trusted R2")
 int BPF_PROG(test_global_mask_no_null_check, struct task_struct *task, u=
64 clone_flags)
 {
 	struct bpf_cpumask *local, *prev;
@@ -179,7 +179,7 @@ int BPF_PROG(test_global_mask_no_null_check, struct t=
ask_struct *task, u64 clone
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to helper arg2")
+__failure __msg("Possibly NULL pointer passed to helper R2")
 int BPF_PROG(test_global_mask_rcu_no_null_check, struct task_struct *tas=
k, u64 clone_flags)
 {
 	struct bpf_cpumask *prev, *curr;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219..dbd97add5a5a 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -149,7 +149,7 @@ int ringbuf_release_uninit_dynptr(void *ctx)
=20
 /* A dynptr can't be used after it has been invalidated */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as R3")
 int use_after_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -448,7 +448,7 @@ int invalid_helper2(void *ctx)
=20
 /* A bpf_dynptr is invalidated if it's been written into */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as R1")
 int invalid_write1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1642,7 +1642,7 @@ int invalid_slice_rdwr_rdonly(struct __sk_buff *skb=
)
=20
 /* bpf_dynptr_adjust can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as R1")
 int dynptr_adjust_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1655,7 +1655,7 @@ int dynptr_adjust_invalid(void *ctx)
=20
 /* bpf_dynptr_is_null can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as R1")
 int dynptr_is_null_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1668,7 +1668,7 @@ int dynptr_is_null_invalid(void *ctx)
=20
 /* bpf_dynptr_is_rdonly can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as R1")
 int dynptr_is_rdonly_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1681,7 +1681,7 @@ int dynptr_is_rdonly_invalid(void *ctx)
=20
 /* bpf_dynptr_size can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as R1")
 int dynptr_size_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1694,7 +1694,7 @@ int dynptr_size_invalid(void *ctx)
=20
 /* Only initialized dynptrs can be cloned */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as R1")
 int clone_invalid1(void *ctx)
 {
 	struct bpf_dynptr ptr1 =3D {};
@@ -1728,7 +1728,7 @@ int clone_invalid2(struct xdp_md *xdp)
=20
 /* Invalidating a dynptr should invalidate its clones */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as R3")
 int clone_invalidate1(void *ctx)
 {
 	struct bpf_dynptr clone;
@@ -1749,7 +1749,7 @@ int clone_invalidate1(void *ctx)
=20
 /* Invalidating a dynptr should invalidate its parent */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as R3")
 int clone_invalidate2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1770,7 +1770,7 @@ int clone_invalidate2(void *ctx)
=20
 /* Invalidating a dynptr should invalidate its siblings */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as R3")
 int clone_invalidate3(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1981,7 +1981,7 @@ __noinline long global_call_bpf_dynptr(const struct=
 bpf_dynptr *dynptr)
 }
=20
 SEC("?raw_tp")
-__failure __msg("arg#0 expected pointer to stack or const struct bpf_dyn=
ptr")
+__failure __msg("R1 expected pointer to stack or const struct bpf_dynptr=
")
 int test_dynptr_reg_type(void *ctx)
 {
 	struct task_struct *current =3D NULL;
diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools=
/testing/selftests/bpf/progs/file_reader_fail.c
index 32fe28ed2439..0739620dea8a 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -30,7 +30,7 @@ int on_nanosleep_unreleased_ref(void *ctx)
=20
 SEC("xdp")
 __failure
-__msg("Expected a dynptr of type file as arg #0")
+__msg("Expected a dynptr of type file as R1")
 int xdp_wrong_dynptr_type(struct xdp_md *xdp)
 {
 	struct bpf_dynptr dynptr;
@@ -42,7 +42,7 @@ int xdp_wrong_dynptr_type(struct xdp_md *xdp)
=20
 SEC("xdp")
 __failure
-__msg("Expected an initialized dynptr as arg #0")
+__msg("Expected an initialized dynptr as R1")
 int xdp_no_dynptr_type(struct xdp_md *xdp)
 {
 	struct bpf_dynptr dynptr;
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/self=
tests/bpf/progs/irq.c
index e11e82d98904..a4a007866a33 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -15,7 +15,7 @@ struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
 struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
=20
 SEC("?tc")
-__failure __msg("arg#0 doesn't point to an irq flag on stack")
+__failure __msg("R1 doesn't point to an irq flag on stack")
 int irq_save_bad_arg(struct __sk_buff *ctx)
 {
 	bpf_local_irq_save(&global_flags);
@@ -23,7 +23,7 @@ int irq_save_bad_arg(struct __sk_buff *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("arg#0 doesn't point to an irq flag on stack")
+__failure __msg("R1 doesn't point to an irq flag on stack")
 int irq_restore_bad_arg(struct __sk_buff *ctx)
 {
 	bpf_local_irq_restore(&global_flags);
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
index 86b74e3579d9..0fa70b133d93 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1605,7 +1605,7 @@ int iter_subprog_check_stacksafe(const void *ctx)
 struct bpf_iter_num global_it;
=20
 SEC("raw_tp")
-__failure __msg("arg#0 expected pointer to an iterator on stack")
+__failure __msg("R1 expected pointer to an iterator on stack")
 int iter_new_bad_arg(const void *ctx)
 {
 	bpf_iter_num_new(&global_it, 0, 1);
@@ -1613,7 +1613,7 @@ int iter_new_bad_arg(const void *ctx)
 }
=20
 SEC("raw_tp")
-__failure __msg("arg#0 expected pointer to an iterator on stack")
+__failure __msg("R1 expected pointer to an iterator on stack")
 int iter_next_bad_arg(const void *ctx)
 {
 	bpf_iter_num_next(&global_it);
@@ -1621,7 +1621,7 @@ int iter_next_bad_arg(const void *ctx)
 }
=20
 SEC("raw_tp")
-__failure __msg("arg#0 expected pointer to an iterator on stack")
+__failure __msg("R1 expected pointer to an iterator on stack")
 int iter_destroy_bad_arg(const void *ctx)
 {
 	bpf_iter_num_destroy(&global_it);
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/too=
ls/testing/selftests/bpf/progs/iters_state_safety.c
index d273b46dfc7c..af8f9ec1ea98 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -73,7 +73,7 @@ int create_and_forget_to_destroy_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as R1")
 int destroy_without_creating_fail(void *ctx)
 {
 	/* init with zeros to stop verifier complaining about uninit stack */
@@ -91,7 +91,7 @@ int destroy_without_creating_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as R1")
 int compromise_iter_w_direct_write_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -143,7 +143,7 @@ int compromise_iter_w_direct_write_and_skip_destroy_f=
ail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as R1")
 int compromise_iter_w_helper_write_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -230,7 +230,7 @@ int valid_stack_reuse(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected uninitialized iter_num as arg #0")
+__failure __msg("expected uninitialized iter_num as R1")
 int double_create_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -258,7 +258,7 @@ int double_create_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as R1")
 int double_destroy_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -284,7 +284,7 @@ int double_destroy_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as R1")
 int next_without_new_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -305,7 +305,7 @@ int next_without_new_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as R1")
 int next_after_destroy_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/te=
sting/selftests/bpf/progs/iters_testmod.c
index 5379e9960ffd..76012dbbdb41 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -29,7 +29,7 @@ int iter_next_trusted(const void *ctx)
 }
=20
 SEC("raw_tp/sys_enter")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_trusted_or_null(const void *ctx)
 {
 	struct task_struct *cur_task =3D bpf_get_current_task_btf();
@@ -67,7 +67,7 @@ int iter_next_rcu(const void *ctx)
 }
=20
 SEC("raw_tp/sys_enter")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_rcu_or_null(const void *ctx)
 {
 	struct task_struct *cur_task =3D bpf_get_current_task_btf();
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tool=
s/testing/selftests/bpf/progs/iters_testmod_seq.c
index 83791348bed5..9b760dac333e 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -79,7 +79,7 @@ int testmod_seq_truncated(const void *ctx)
=20
 SEC("?raw_tp")
 __failure
-__msg("expected an initialized iter_testmod_seq as arg #1")
+__msg("expected an initialized iter_testmod_seq as R2")
 int testmod_seq_getter_before_bad(const void *ctx)
 {
 	struct bpf_iter_testmod_seq it;
@@ -89,7 +89,7 @@ int testmod_seq_getter_before_bad(const void *ctx)
=20
 SEC("?raw_tp")
 __failure
-__msg("expected an initialized iter_testmod_seq as arg #1")
+__msg("expected an initialized iter_testmod_seq as R2")
 int testmod_seq_getter_after_bad(const void *ctx)
 {
 	struct bpf_iter_testmod_seq it;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/te=
sting/selftests/bpf/progs/map_kptr_fail.c
index ee053b24e6ca..8f36e74fd8f9 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -364,7 +364,7 @@ int kptr_xchg_ref_state(struct __sk_buff *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to helper arg2")
+__failure __msg("Possibly NULL pointer passed to helper R2")
 int kptr_xchg_possibly_null(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tool=
s/testing/selftests/bpf/progs/percpu_alloc_fail.c
index 81813c724fa9..08379c3b6a03 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -110,7 +110,7 @@ int BPF_PROG(test_array_map_3)
 }
=20
 SEC("?fentry.s/bpf_fentry_test1")
-__failure __msg("arg#0 expected for bpf_percpu_obj_drop()")
+__failure __msg("R1 expected for bpf_percpu_obj_drop()")
 int BPF_PROG(test_array_map_4)
 {
 	struct val_t __percpu_kptr *p;
@@ -124,7 +124,7 @@ int BPF_PROG(test_array_map_4)
 }
=20
 SEC("?fentry.s/bpf_fentry_test1")
-__failure __msg("arg#0 expected for bpf_obj_drop()")
+__failure __msg("R1 expected for bpf_obj_drop()")
 int BPF_PROG(test_array_map_5)
 {
 	struct val_t *p;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/test=
ing/selftests/bpf/progs/rbtree_fail.c
index 70b7baf9304b..555379952dcc 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -134,7 +134,7 @@ long rbtree_api_remove_no_drop(void *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("arg#1 expected pointer to allocated object")
+__failure __msg("R2 expected pointer to allocated object")
 long rbtree_api_add_to_multiple_trees(void *ctx)
 {
 	struct node_data *n;
@@ -153,7 +153,7 @@ long rbtree_api_add_to_multiple_trees(void *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to trusted arg1")
+__failure __msg("Possibly NULL pointer passed to trusted R2")
 long rbtree_api_use_unchecked_remove_retval(void *ctx)
 {
 	struct bpf_rb_node *res;
@@ -281,7 +281,7 @@ long add_with_cb(bool (cb)(struct bpf_rb_node *a, con=
st struct bpf_rb_node *b))
 }
=20
 SEC("?tc")
-__failure __msg("arg#1 expected pointer to allocated object")
+__failure __msg("R2 expected pointer to allocated object")
 long rbtree_api_add_bad_cb_bad_fn_call_add(void *ctx)
 {
 	return add_with_cb(less__bad_fn_call_add);
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index b2808bfcec29..7247a20c0a3b 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -54,7 +54,7 @@ long rbtree_refcounted_node_ref_escapes(void *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 long refcount_acquire_maybe_null(void *ctx)
 {
 	struct node_acquire *n, *m;
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/test=
ing/selftests/bpf/progs/stream_fail.c
index 8e8249f3521c..21428bb1ee59 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -23,7 +23,7 @@ int stream_vprintk_scalar_arg(void *ctx)
 }
=20
 SEC("syscall")
-__failure __msg("arg#1 doesn't point to a const string")
+__failure __msg("R2 doesn't point to a const string")
 int stream_vprintk_string_arg(void *ctx)
 {
 	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0);
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
index 4c07ea193f72..41047d81ec42 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -28,7 +28,7 @@ static struct __tasks_kfunc_map_value *insert_lookup_ta=
sk(struct task_struct *ta
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64=
 clone_flags)
 {
 	struct task_struct *acquired;
@@ -49,7 +49,7 @@ int BPF_PROG(task_kfunc_acquire_untrusted, struct task_=
struct *task, u64 clone_f
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 pointer type STRUCT task_struct must point")
+__failure __msg("R1 pointer type STRUCT task_struct must point")
 int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_=
flags)
 {
 	struct task_struct *acquired, *stack_task =3D (struct task_struct *)&cl=
one_flags;
@@ -100,7 +100,7 @@ int BPF_PROG(task_kfunc_acquire_unsafe_kretprobe_rcu,=
 struct task_struct *task,
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clon=
e_flags)
 {
 	struct task_struct *acquired;
@@ -149,7 +149,7 @@ int BPF_PROG(task_kfunc_xchg_unreleased, struct task_=
struct *task, u64 clone_fla
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_acquire_release_no_null_check, struct task_struc=
t *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -162,7 +162,7 @@ int BPF_PROG(task_kfunc_acquire_release_no_null_check=
, struct task_struct *task,
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64=
 clone_flags)
 {
 	struct __tasks_kfunc_map_value *v;
@@ -178,7 +178,7 @@ int BPF_PROG(task_kfunc_release_untrusted, struct tas=
k_struct *task, u64 clone_f
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 pointer type STRUCT task_struct must point")
+__failure __msg("R1 pointer type STRUCT task_struct must point")
 int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_=
flags)
 {
 	struct task_struct *acquired =3D (struct task_struct *)&clone_flags;
@@ -190,7 +190,7 @@ int BPF_PROG(task_kfunc_release_fp, struct task_struc=
t *task, u64 clone_flags)
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clon=
e_flags)
 {
 	struct __tasks_kfunc_map_value local, *v;
@@ -234,7 +234,7 @@ int BPF_PROG(task_kfunc_release_unacquired, struct ta=
sk_struct *task, u64 clone_
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task=
, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -248,7 +248,7 @@ int BPF_PROG(task_kfunc_from_pid_no_null_check, struc=
t task_struct *task, u64 cl
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_from_vpid_no_null_check, struct task_struct *tas=
k, u64 clone_flags)
 {
 	struct task_struct *acquired;
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/t=
esting/selftests/bpf/progs/task_work_fail.c
index 82e4b8913333..3186e7b4b24e 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -58,7 +58,7 @@ int mismatch_map(struct pt_regs *args)
 }
=20
 SEC("perf_event")
-__failure __msg("arg#1 doesn't point to a map value")
+__failure __msg("R2 doesn't point to a map value")
 int no_map_task_work(struct pt_regs *args)
 {
 	struct task_struct *task;
@@ -70,7 +70,7 @@ int no_map_task_work(struct pt_regs *args)
 }
=20
 SEC("perf_event")
-__failure __msg("Possibly NULL pointer passed to trusted arg1")
+__failure __msg("Possibly NULL pointer passed to trusted R2")
 int task_work_null(struct pt_regs *args)
 {
 	struct task_struct *task;
@@ -81,7 +81,7 @@ int task_work_null(struct pt_regs *args)
 }
=20
 SEC("perf_event")
-__failure __msg("Possibly NULL pointer passed to trusted arg2")
+__failure __msg("Possibly NULL pointer passed to trusted R3")
 int map_null(struct pt_regs *args)
 {
 	struct elem *work;
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c b/tools=
/testing/selftests/bpf/progs/test_bpf_nf_fail.c
index 2c156cd166af..332cda89caba 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
@@ -152,7 +152,7 @@ int change_status_after_alloc(struct __sk_buff *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to trusted arg1")
+__failure __msg("Possibly NULL pointer passed to trusted R2")
 int lookup_null_bpf_tuple(struct __sk_buff *ctx)
 {
 	struct bpf_ct_opts___local opts =3D {};
@@ -165,7 +165,7 @@ int lookup_null_bpf_tuple(struct __sk_buff *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to trusted arg3")
+__failure __msg("Possibly NULL pointer passed to trusted R4")
 int lookup_null_bpf_opts(struct __sk_buff *ctx)
 {
 	struct bpf_sock_tuple tup =3D {};
@@ -178,7 +178,7 @@ int lookup_null_bpf_opts(struct __sk_buff *ctx)
 }
=20
 SEC("?xdp")
-__failure __msg("Possibly NULL pointer passed to trusted arg1")
+__failure __msg("Possibly NULL pointer passed to trusted R2")
 int xdp_lookup_null_bpf_tuple(struct xdp_md *ctx)
 {
 	struct bpf_ct_opts___local opts =3D {};
@@ -191,7 +191,7 @@ int xdp_lookup_null_bpf_tuple(struct xdp_md *ctx)
 }
=20
 SEC("?xdp")
-__failure __msg("Possibly NULL pointer passed to trusted arg3")
+__failure __msg("Possibly NULL pointer passed to trusted R4")
 int xdp_lookup_null_bpf_opts(struct xdp_md *ctx)
 {
 	struct bpf_sock_tuple tup =3D {};
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c =
b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index d249113ed657..41da6e619940 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -45,7 +45,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr =
*attr, unsigned int size,
 }
=20
 SEC("?lsm.s/bpf")
-__failure __msg("arg#0 expected pointer to stack or const struct bpf_dyn=
ptr")
+__failure __msg("R1 expected pointer to stack or const struct bpf_dynptr=
")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned i=
nt size, bool kernel)
 {
 	static struct bpf_dynptr val;
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.=
c b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
index 967081bbcfe1..ca35b92ea095 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
@@ -29,7 +29,7 @@ int kfunc_dynptr_nullable_test2(struct __sk_buff *skb)
 }
=20
 SEC("tc")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int kfunc_dynptr_nullable_test3(struct __sk_buff *skb)
 {
 	struct bpf_dynptr data;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/too=
ls/testing/selftests/bpf/progs/verifier_bits_iter.c
index 8bcddadfc4da..dd97f2027505 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -32,7 +32,7 @@ int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, st=
ruct cgroup *cgrp)
=20
 SEC("iter/cgroup")
 __description("uninitialized iter in ->next()")
-__failure __msg("expected an initialized iter_bits as arg #0")
+__failure __msg("expected an initialized iter_bits as R1")
 int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgr=
p)
 {
 	struct bpf_iter_bits it =3D {};
@@ -43,7 +43,7 @@ int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, s=
truct cgroup *cgrp)
=20
 SEC("iter/cgroup")
 __description("uninitialized iter in ->destroy()")
-__failure __msg("expected an initialized iter_bits as arg #0")
+__failure __msg("expected an initialized iter_bits as R1")
 int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *=
cgrp)
 {
 	struct bpf_iter_bits it =3D {};
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/=
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
index 910365201f68..139f70bb3595 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -263,7 +263,7 @@ l0_%=3D:	r0 =3D 0;						\
=20
 SEC("lsm.s/bpf")
 __description("reference tracking: release user key reference without ch=
eck")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void user_key_reference_without_check(void)
 {
 	asm volatile ("					\
@@ -282,7 +282,7 @@ __naked void user_key_reference_without_check(void)
=20
 SEC("lsm.s/bpf")
 __description("reference tracking: release system key reference without =
check")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void system_key_reference_without_check(void)
 {
 	asm volatile ("					\
@@ -300,7 +300,7 @@ __naked void system_key_reference_without_check(void)
=20
 SEC("lsm.s/bpf")
 __description("reference tracking: release with NULL key pointer")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void release_with_null_key_pointer(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/to=
ols/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 4b392c6c8fc4..0990de076844 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -13,7 +13,7 @@
 static char buf[PATH_MAX];
=20
 SEC("lsm.s/file_open")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(get_task_exe_file_kfunc_null)
 {
 	struct file *acquired;
@@ -28,7 +28,7 @@ int BPF_PROG(get_task_exe_file_kfunc_null)
 }
=20
 SEC("lsm.s/inode_getxattr")
-__failure __msg("arg#0 pointer type STRUCT task_struct must point to sca=
lar, or struct with scalar")
+__failure __msg("R1 pointer type STRUCT task_struct must point to scalar=
, or struct with scalar")
 int BPF_PROG(get_task_exe_file_kfunc_fp)
 {
 	u64 x;
@@ -89,7 +89,7 @@ int BPF_PROG(put_file_kfunc_unacquired, struct file *fi=
le)
 }
=20
 SEC("lsm.s/file_open")
-__failure __msg("Possibly NULL pointer passed to trusted arg0")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(path_d_path_kfunc_null)
 {
 	/* Can't pass NULL value to bpf_path_d_path() kfunc. */
@@ -128,7 +128,7 @@ int BPF_PROG(path_d_path_kfunc_untrusted_from_current=
)
 }
=20
 SEC("lsm.s/file_open")
-__failure __msg("kernel function bpf_path_d_path args#0 expected pointer=
 to STRUCT path but R1 has a pointer to STRUCT file")
+__failure __msg("kernel function bpf_path_d_path R1 expected pointer to =
STRUCT path but R1 has a pointer to STRUCT file")
 int BPF_PROG(path_d_path_kfunc_type_mismatch, struct file *file)
 {
 	bpf_path_d_path((struct path *)&file->f_task_work, buf, sizeof(buf));
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/test=
ing/selftests/bpf/progs/wq_failures.c
index 3767f5595bbc..32dc8827e128 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -98,7 +98,7 @@ __failure
  * is a correct bpf_wq pointer.
  */
 __msg(": (85) call bpf_wq_set_callback#") /* anchor message */
-__msg("arg#0 doesn't point to a map value")
+__msg("R1 doesn't point to a map value")
 long test_wrong_wq_pointer(void *ctx)
 {
 	int key =3D 0;
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing=
/selftests/bpf/verifier/calls.c
index c3164b9b2be5..0bb4337552c8 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -31,7 +31,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "arg#0 pointer type STRUCT prog_test_fail1 must point to sc=
alar",
+	.errstr =3D "R1 pointer type STRUCT prog_test_fail1 must point to scala=
r",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_test_fail1", 2 },
 	},
@@ -46,7 +46,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "max struct nesting depth exceeded\narg#0 pointer type STRU=
CT prog_test_fail2",
+	.errstr =3D "max struct nesting depth exceeded\nR1 pointer type STRUCT =
prog_test_fail2",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_test_fail2", 2 },
 	},
@@ -61,7 +61,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "arg#0 pointer type STRUCT prog_test_fail3 must point to sc=
alar",
+	.errstr =3D "R1 pointer type STRUCT prog_test_fail3 must point to scala=
r",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_test_fail3", 2 },
 	},
@@ -76,7 +76,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "arg#0 expected pointer to ctx, but got fp",
+	.errstr =3D "R1 expected pointer to ctx, but got fp",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_test_pass_ctx", 2 },
 	},
@@ -91,7 +91,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "arg#0 pointer type UNKNOWN  must point to scalar",
+	.errstr =3D "R1 pointer type UNKNOWN  must point to scalar",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_test_mem_len_fail1", 2 },
 	},
@@ -109,7 +109,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "Possibly NULL pointer passed to trusted arg0",
+	.errstr =3D "Possibly NULL pointer passed to trusted R1",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_test_acquire", 3 },
 		{ "bpf_kfunc_call_test_release", 5 },
@@ -152,7 +152,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "kernel function bpf_kfunc_call_memb1_release args#0 expect=
ed pointer",
+	.errstr =3D "kernel function bpf_kfunc_call_memb1_release R1 expected p=
ointer",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_memb_acquire", 1 },
 		{ "bpf_kfunc_call_memb1_release", 5 },
--=20
2.52.0

