Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA2364053
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969947; cv=none; b=Ax+KBScgtvYpuIGQnIANuh5gR4po3yUninD0Q5cO0XVEsxG8RGveT+/p80vuJ1twlf77AE0QAVjDkAA+HXgGEvjkb12f149aZz1spdDgwVKSun3SEYlFdfru9Y1p7naMJ3fNHofW4iH1yhczasoftgsTRhgu/1UJy5gkSsmYvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969947; c=relaxed/simple;
	bh=2V8X2TlBvTSsetw2aCzwifFrFyLxYm2gvrziuQtAQtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kT/K5h+i+hwYBONMxkrXIB5Ly7xpZczyeScdR9uahM5I1G2R45CXeZ7GgkCFybCywSVR9eSWwtUImSvItI8APYw8RCz2Txci6NCvjA5EzyWKL5yd/sRDhQqJaLyRyi5QpDWQWENn31o8QcxRYkQ5nkWIcyKHTo3PPZCydJK7V4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5B2343B0219FE; Sat, 11 Apr 2026 21:58:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 06/18] bpf: Use argument index instead of register index in kfunc verifier logs
Date: Sat, 11 Apr 2026 21:58:57 -0700
Message-ID: <20260412045857.256260-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For kfunc argument checking, use the argument index (arg#0, arg#1, ...)
instead of the register index (R1, R2, ...) in verifier log messages.
This is a preparation for future stack-based arguments where kfuncs can
accept more than 5 arguments. Stack arguments won't have a corresponding
register, so using argument index is more appropriate.

Since some functions like check_mem_access(), check_stack_read_var_off(),
and check_stack_range_initialized() are shared between kfunc argument
checking (check_kfunc_args) and other paths (check_func_arg, do_check_ins=
n, ...),
introduce a `reg_or_arg` encoding: a non-negative value represents a regi=
ster
index, while a negative value encodes an argument index as -(argno + 1).
The helper reg_arg_name() decodes this to produce either "R%d" or
"arg#%d" for log messages.

For check_func_arg() callers, in certain cases, the register index is
preserved so existing helper function logs remain unchanged (e.g., "R1", =
"R2").

Update selftests to expect the new "arg#N" format in kfunc error
messages.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         | 466 +++++++++---------
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 .../selftests/bpf/progs/cpumask_failure.c     |   4 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../selftests/bpf/progs/iters_testmod.c       |   6 +-
 .../bpf/progs/local_kptr_stash_fail.c         |   2 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   4 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
 .../bpf/progs/nested_trust_failure.c          |   2 +-
 .../selftests/bpf/progs/res_spin_lock_fail.c  |   2 +-
 .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   4 +-
 .../bpf/progs/verifier_cgroup_storage.c       |   4 +-
 .../selftests/bpf/progs/verifier_ctx.c        |   2 +-
 .../bpf/progs/verifier_ref_tracking.c         |   2 +-
 .../selftests/bpf/progs/verifier_sock.c       |   6 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   4 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
 .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  10 +-
 23 files changed, 286 insertions(+), 267 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 05b9fe98b8f8..291f11ddd176 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -910,6 +910,7 @@ struct bpf_verifier_env {
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
 	char tmp_str_buf[TMP_STR_BUF_LEN];
+	char tmp_reg_arg_name_buf[16];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
 	struct bpf_scc_callchain callchain_buf;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54296d818d35..01df990f841a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2179,6 +2179,18 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
 	return &elem->st;
 }
=20
+static const char *reg_arg_name(struct bpf_verifier_env *env, int reg_or=
_arg)
+{
+	char *buf =3D env->tmp_reg_arg_name_buf;
+	int len =3D sizeof(env->tmp_reg_arg_name_buf);
+
+	if (reg_or_arg >=3D 0)
+		snprintf(buf, len, "R%d", reg_or_arg);
+	else
+		snprintf(buf, len, "arg#%d", -(reg_or_arg + 1));
+	return buf;
+}
+
 #define CALLER_SAVED_REGS 6
 static const int caller_saved[CALLER_SAVED_REGS] =3D {
 	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
@@ -5822,7 +5834,7 @@ static struct bpf_reg_state *reg_state(struct bpf_v=
erifier_env *env, int regno)
  * instead.
  */
 static int check_stack_read_var_off(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg,
-				    int ptr_regno, int off, int size, int dst_regno)
+				    int ptr_reg_or_arg, int off, int size, int dst_regno)
 {
 	struct bpf_func_state *ptr_state =3D func(env, reg);
 	int err;
@@ -5830,7 +5842,7 @@ static int check_stack_read_var_off(struct bpf_veri=
fier_env *env, struct bpf_reg
=20
 	/* Note that we pass a NULL meta, so raw access will not be permitted.
 	 */
-	err =3D check_stack_range_initialized(env, reg, ptr_regno, off, size,
+	err =3D check_stack_range_initialized(env, reg, ptr_reg_or_arg, off, si=
ze,
 					    false, BPF_READ, NULL);
 	if (err)
 		return err;
@@ -5852,7 +5864,7 @@ static int check_stack_read_var_off(struct bpf_veri=
fier_env *env, struct bpf_reg
  * can be -1, meaning that the read value is not going to a register.
  */
 static int check_stack_read(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *reg, int ptr_regno, int off, int size,
+			    struct bpf_reg_state *reg, int ptr_reg_or_arg, int off, int size,
 			    int dst_regno)
 {
 	struct bpf_func_state *state =3D func(env, reg);
@@ -5890,7 +5902,7 @@ static int check_stack_read(struct bpf_verifier_env=
 *env,
 		 * than fixed offset ones. Note that dst_regno >=3D 0 on this
 		 * branch.
 		 */
-		err =3D check_stack_read_var_off(env, reg, ptr_regno, off, size,
+		err =3D check_stack_read_var_off(env, reg, ptr_reg_or_arg, off, size,
 					       dst_regno);
 	}
 	return err;
@@ -5950,7 +5962,7 @@ static int check_map_access_type(struct bpf_verifie=
r_env *env, struct bpf_reg_st
 }
=20
 /* check read/write into memory region (e.g., map value, ringbuf sample,=
 etc) */
-static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int regno,
+static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int reg_or_arg,
 			      int off, int size, u32 mem_size,
 			      bool zero_size_allowed)
 {
@@ -5971,8 +5983,8 @@ static int __check_mem_access(struct bpf_verifier_e=
nv *env, struct bpf_reg_state
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET_END:
-		verbose(env, "invalid access to packet, off=3D%d size=3D%d, R%d(id=3D%=
d,off=3D%d,r=3D%d)\n",
-			off, size, regno, reg->id, off, mem_size);
+		verbose(env, "invalid access to packet, off=3D%d size=3D%d, %s(id=3D%d=
,off=3D%d,r=3D%d)\n",
+			off, size, reg_arg_name(env, reg_or_arg), reg->id, off, mem_size);
 		break;
 	case PTR_TO_CTX:
 		verbose(env, "invalid access to context, ctx_size=3D%d off=3D%d size=3D=
%d\n",
@@ -5988,7 +6000,7 @@ static int __check_mem_access(struct bpf_verifier_e=
nv *env, struct bpf_reg_state
 }
=20
 /* check read/write into a memory region with possible variable offset *=
/
-static int check_mem_region_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int regno,
+static int check_mem_region_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int reg_or_arg,
 				   int off, int size, u32 mem_size,
 				   bool zero_size_allowed)
 {
@@ -6008,15 +6020,15 @@ static int check_mem_region_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 	    (reg->smin_value =3D=3D S64_MIN ||
 	     (off + reg->smin_value !=3D (s64)(s32)(off + reg->smin_value)) ||
 	      reg->smin_value + off < 0)) {
-		verbose(env, "R%d min value is negative, either use unsigned index or =
do a if (index >=3D0) check.\n",
-			regno);
+		verbose(env, "%s min value is negative, either use unsigned index or d=
o a if (index >=3D0) check.\n",
+			reg_arg_name(env, reg_or_arg));
 		return -EACCES;
 	}
-	err =3D __check_mem_access(env, reg, regno, reg->smin_value + off, size=
,
+	err =3D __check_mem_access(env, reg, reg_or_arg, reg->smin_value + off,=
 size,
 				 mem_size, zero_size_allowed);
 	if (err) {
-		verbose(env, "R%d min value is outside of the allowed memory range\n",
-			regno);
+		verbose(env, "%s min value is outside of the allowed memory range\n",
+			reg_arg_name(env, reg_or_arg));
 		return err;
 	}
=20
@@ -6025,15 +6037,15 @@ static int check_mem_region_access(struct bpf_ver=
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
+			reg_arg_name(env, reg_or_arg));
 		return -EACCES;
 	}
-	err =3D __check_mem_access(env, reg, regno, reg->umax_value + off, size=
,
+	err =3D __check_mem_access(env, reg, reg_or_arg, reg->umax_value + off,=
 size,
 				 mem_size, zero_size_allowed);
 	if (err) {
-		verbose(env, "R%d max value is outside of the allowed memory range\n",
-			regno);
+		verbose(env, "%s max value is outside of the allowed memory range\n",
+			reg_arg_name(env, reg_or_arg));
 		return err;
 	}
=20
@@ -6041,7 +6053,7 @@ static int check_mem_region_access(struct bpf_verif=
ier_env *env, struct bpf_reg_
 }
=20
 static int __check_ptr_off_reg(struct bpf_verifier_env *env,
-			       const struct bpf_reg_state *reg, int regno,
+			       const struct bpf_reg_state *reg, int reg_or_arg,
 			       bool fixed_off_ok)
 {
 	/* Access to this pointer-typed register or passing it to a helper
@@ -6058,14 +6070,14 @@ static int __check_ptr_off_reg(struct bpf_verifie=
r_env *env,
 	}
=20
 	if (reg->smin_value < 0) {
-		verbose(env, "negative offset %s ptr R%d off=3D%lld disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->var_off.value);
+		verbose(env, "negative offset %s ptr %s off=3D%lld disallowed\n",
+			reg_type_str(env, reg->type), reg_arg_name(env, reg_or_arg), reg->var=
_off.value);
 		return -EACCES;
 	}
=20
 	if (!fixed_off_ok && reg->var_off.value !=3D 0) {
-		verbose(env, "dereference of modified %s ptr R%d off=3D%lld disallowed=
\n",
-			reg_type_str(env, reg->type), regno, reg->var_off.value);
+		verbose(env, "dereference of modified %s ptr %s off=3D%lld disallowed\=
n",
+			reg_type_str(env, reg->type), reg_arg_name(env, reg_or_arg), reg->var=
_off.value);
 		return -EACCES;
 	}
=20
@@ -6330,7 +6342,7 @@ static u32 map_mem_size(const struct bpf_map *map)
 }
=20
 /* check read/write into a map element with possible variable offset */
-static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int regno,
+static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int reg_or_arg,
 			    int off, int size, bool zero_size_allowed,
 			    enum bpf_access_src src)
 {
@@ -6339,7 +6351,7 @@ static int check_map_access(struct bpf_verifier_env=
 *env, struct bpf_reg_state *
 	struct btf_record *rec;
 	int err, i;
=20
-	err =3D check_mem_region_access(env, reg, regno, off, size, mem_size, z=
ero_size_allowed);
+	err =3D check_mem_region_access(env, reg, reg_or_arg, off, size, mem_si=
ze, zero_size_allowed);
 	if (err)
 		return err;
=20
@@ -6437,17 +6449,17 @@ static bool may_access_direct_pkt_data(struct bpf=
_verifier_env *env,
 	}
 }
=20
-static int check_packet_access(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int regno, int off,
+static int check_packet_access(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int reg_or_arg, int off,
 			       int size, bool zero_size_allowed)
 {
 	int err;
=20
 	if (reg->range < 0) {
-		verbose(env, "R%d offset is outside of the packet\n", regno);
+		verbose(env, "%s offset is outside of the packet\n", reg_arg_name(env,=
 reg_or_arg));
 		return -EINVAL;
 	}
=20
-	err =3D check_mem_region_access(env, reg, regno, off, size, reg->range,=
 zero_size_allowed);
+	err =3D check_mem_region_access(env, reg, reg_or_arg, off, size, reg->r=
ange, zero_size_allowed);
 	if (err)
 		return err;
=20
@@ -6502,7 +6514,7 @@ static int __check_ctx_access(struct bpf_verifier_e=
nv *env, int insn_idx, int of
 	return -EACCES;
 }
=20
-static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, int regno,
+static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, int reg_or_arg,
 			    int off, int access_size, enum bpf_access_type t,
 			    struct bpf_insn_access_aux *info)
 {
@@ -6515,9 +6527,9 @@ static int check_ctx_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 	int err;
=20
 	if (var_off_ok)
-		err =3D check_mem_region_access(env, reg, regno, off, access_size, U16=
_MAX, false);
+		err =3D check_mem_region_access(env, reg, reg_or_arg, off, access_size=
, U16_MAX, false);
 	else
-		err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
+		err =3D __check_ptr_off_reg(env, reg, reg_or_arg, fixed_off_ok);
 	if (err)
 		return err;
 	off +=3D reg->umax_value;
@@ -6541,15 +6553,15 @@ static int check_flow_keys_access(struct bpf_veri=
fier_env *env, int off,
 }
=20
 static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
-			     struct bpf_reg_state *reg, int regno, int off, int size,
+			     struct bpf_reg_state *reg, int reg_or_arg, int off, int size,
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
+			reg_arg_name(env, reg_or_arg));
 		return -EACCES;
 	}
=20
@@ -6577,8 +6589,8 @@ static int check_sock_access(struct bpf_verifier_en=
v *env, int insn_idx,
 		return 0;
 	}
=20
-	verbose(env, "R%d invalid %s access off=3D%d size=3D%d\n",
-		regno, reg_type_str(env, reg->type), off, size);
+	verbose(env, "%s invalid %s access off=3D%d size=3D%d\n",
+		reg_arg_name(env, reg_or_arg), reg_type_str(env, reg->type), off, size=
);
=20
 	return -EACCES;
 }
@@ -7101,12 +7113,12 @@ static int get_callee_stack_depth(struct bpf_veri=
fier_env *env,
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 int regno, int off, int size)
+				 int reg_or_arg, int off, int size)
 {
 	if (off < 0) {
 		verbose(env,
-			"R%d invalid %s buffer access: off=3D%d, size=3D%d\n",
-			regno, buf_info, off, size);
+			"%s invalid %s buffer access: off=3D%d, size=3D%d\n",
+			reg_arg_name(env, reg_or_arg), buf_info, off, size);
 		return -EACCES;
 	}
 	if (!tnum_is_const(reg->var_off)) {
@@ -7114,8 +7126,8 @@ static int __check_buffer_access(struct bpf_verifie=
r_env *env,
=20
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env,
-			"R%d invalid variable buffer offset: off=3D%d, var_off=3D%s\n",
-			regno, off, tn_buf);
+			"%s invalid variable buffer offset: off=3D%d, var_off=3D%s\n",
+			reg_arg_name(env, reg_or_arg), off, tn_buf);
 		return -EACCES;
 	}
=20
@@ -7124,11 +7136,11 @@ static int __check_buffer_access(struct bpf_verif=
ier_env *env,
=20
 static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
-				  int regno, int off, int size)
+				  int reg_or_arg, int off, int size)
 {
 	int err;
=20
-	err =3D __check_buffer_access(env, "tracepoint", reg, regno, off, size)=
;
+	err =3D __check_buffer_access(env, "tracepoint", reg, reg_or_arg, off, =
size);
 	if (err)
 		return err;
=20
@@ -7140,14 +7152,14 @@ static int check_tp_buffer_access(struct bpf_veri=
fier_env *env,
=20
 static int check_buffer_access(struct bpf_verifier_env *env,
 			       const struct bpf_reg_state *reg,
-			       int regno, int off, int size,
+			       int reg_or_arg, int off, int size,
 			       bool zero_size_allowed,
 			       u32 *max_access)
 {
 	const char *buf_info =3D type_is_rdonly_mem(reg->type) ? "rdonly" : "rd=
wr";
 	int err;
=20
-	err =3D __check_buffer_access(env, buf_info, reg, regno, off, size);
+	err =3D __check_buffer_access(env, buf_info, reg, reg_or_arg, off, size=
);
 	if (err)
 		return err;
=20
@@ -7520,7 +7532,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
=20
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
-				   int regno, int off, int size,
+				   int reg_or_arg, int off, int size,
 				   enum bpf_access_type atype,
 				   int value_regno)
 {
@@ -7549,8 +7561,8 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
=20
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env,
-			"R%d is ptr_%s invalid variable offset: off=3D%d, var_off=3D%s\n",
-			regno, tname, off, tn_buf);
+			"%s is ptr_%s invalid variable offset: off=3D%d, var_off=3D%s\n",
+			reg_arg_name(env, reg_or_arg), tname, off, tn_buf);
 		return -EACCES;
 	}
=20
@@ -7558,22 +7570,22 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
=20
 	if (off < 0) {
 		verbose(env,
-			"R%d is ptr_%s invalid negative access: off=3D%d\n",
-			regno, tname, off);
+			"%s is ptr_%s invalid negative access: off=3D%d\n",
+			reg_arg_name(env, reg_or_arg), tname, off);
 		return -EACCES;
 	}
=20
 	if (reg->type & MEM_USER) {
 		verbose(env,
-			"R%d is ptr_%s access user memory: off=3D%d\n",
-			regno, tname, off);
+			"%s is ptr_%s access user memory: off=3D%d\n",
+			reg_arg_name(env, reg_or_arg), tname, off);
 		return -EACCES;
 	}
=20
 	if (reg->type & MEM_PERCPU) {
 		verbose(env,
-			"R%d is ptr_%s access percpu memory: off=3D%d\n",
-			regno, tname, off);
+			"%s is ptr_%s access percpu memory: off=3D%d\n",
+			reg_arg_name(env, reg_or_arg), tname, off);
 		return -EACCES;
 	}
=20
@@ -7676,7 +7688,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
=20
 static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
-				   int regno, int off, int size,
+				   int reg_or_arg, int off, int size,
 				   enum bpf_access_type atype,
 				   int value_regno)
 {
@@ -7710,8 +7722,8 @@ static int check_ptr_to_map_access(struct bpf_verif=
ier_env *env,
 	}
=20
 	if (off < 0) {
-		verbose(env, "R%d is %s invalid negative access: off=3D%d\n",
-			regno, tname, off);
+		verbose(env, "%s is %s invalid negative access: off=3D%d\n",
+			reg_arg_name(env, reg_or_arg), tname, off);
 		return -EACCES;
 	}
=20
@@ -7769,7 +7781,7 @@ static int check_stack_slot_within_bounds(struct bp=
f_verifier_env *env,
  */
 static int check_stack_access_within_bounds(
 		struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-		int regno, int off, int access_size,
+		int reg_or_arg, int off, int access_size,
 		enum bpf_access_type type)
 {
 	struct bpf_func_state *state =3D func(env, reg);
@@ -7788,8 +7800,8 @@ static int check_stack_access_within_bounds(
 	} else {
 		if (reg->smax_value >=3D BPF_MAX_VAR_OFF ||
 		    reg->smin_value <=3D -BPF_MAX_VAR_OFF) {
-			verbose(env, "invalid unbounded variable-offset%s stack R%d\n",
-				err_extra, regno);
+			verbose(env, "invalid unbounded variable-offset%s stack %s\n",
+				err_extra, reg_arg_name(env, reg_or_arg));
 			return -EACCES;
 		}
 		min_off =3D reg->smin_value + off;
@@ -7807,14 +7819,14 @@ static int check_stack_access_within_bounds(
=20
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
-			verbose(env, "invalid%s stack R%d off=3D%lld size=3D%d\n",
-				err_extra, regno, min_off, access_size);
+			verbose(env, "invalid%s stack %s off=3D%lld size=3D%d\n",
+				err_extra, reg_arg_name(env, reg_or_arg), min_off, access_size);
 		} else {
 			char tn_buf[48];
=20
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "invalid variable-offset%s stack R%d var_off=3D%s off=3D=
%d size=3D%d\n",
-				err_extra, regno, tn_buf, off, access_size);
+			verbose(env, "invalid variable-offset%s stack %s var_off=3D%s off=3D%=
d size=3D%d\n",
+				err_extra, reg_arg_name(env, reg_or_arg), tn_buf, off, access_size);
 		}
 		return err;
 	}
@@ -7859,7 +7871,7 @@ static void add_scalar_to_reg(struct bpf_reg_state =
*dst_reg, s64 val)
  * if t=3D=3Dwrite && value_regno=3D=3D-1, some unknown value is stored =
into memory
  * if t=3D=3Dread && value_regno=3D=3D-1, don't care what we read from m=
emory
  */
-static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, int regno,
+static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, int reg_or_arg,
 			    int off, int bpf_size, enum bpf_access_type t,
 			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
@@ -7876,11 +7888,11 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
=20
 	if (reg->type =3D=3D PTR_TO_MAP_KEY) {
 		if (t =3D=3D BPF_WRITE) {
-			verbose(env, "write to change key R%d not allowed\n", regno);
+			verbose(env, "write to change key %s not allowed\n", reg_arg_name(env=
, reg_or_arg));
 			return -EACCES;
 		}
=20
-		err =3D check_mem_region_access(env, reg, regno, off, size,
+		err =3D check_mem_region_access(env, reg, reg_or_arg, off, size,
 					      reg->map_ptr->key_size, false);
 		if (err)
 			return err;
@@ -7897,7 +7909,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 		err =3D check_map_access_type(env, reg, off, size, t);
 		if (err)
 			return err;
-		err =3D check_map_access(env, reg, regno, off, size, false, ACCESS_DIR=
ECT);
+		err =3D check_map_access(env, reg, reg_or_arg, off, size, false, ACCES=
S_DIRECT);
 		if (err)
 			return err;
 		if (tnum_is_const(reg->var_off))
@@ -7944,14 +7956,14 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
 		bool rdonly_untrusted =3D rdonly_mem && (reg->type & PTR_UNTRUSTED);
=20
 		if (type_may_be_null(reg->type)) {
-			verbose(env, "R%d invalid mem access '%s'\n", regno,
+			verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, reg_or=
_arg),
 				reg_type_str(env, reg->type));
 			return -EACCES;
 		}
=20
 		if (t =3D=3D BPF_WRITE && rdonly_mem) {
-			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str(env, reg->type));
+			verbose(env, "%s cannot write into %s\n",
+				reg_arg_name(env, reg_or_arg), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
=20
@@ -7966,7 +7978,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 		 * instructions, hence no need to check bounds in that case.
 		 */
 		if (!rdonly_untrusted)
-			err =3D check_mem_region_access(env, reg, regno, off, size,
+			err =3D check_mem_region_access(env, reg, reg_or_arg, off, size,
 						      reg->mem_size, false);
 		if (!err && value_regno >=3D 0 && (t =3D=3D BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
@@ -7984,7 +7996,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 			return -EACCES;
 		}
=20
-		err =3D check_ctx_access(env, insn_idx, reg, regno, off, size, t, &inf=
o);
+		err =3D check_ctx_access(env, insn_idx, reg, reg_or_arg, off, size, t,=
 &info);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
 			/* ctx access returns either a scalar, or a
 			 * PTR_TO_PACKET[_META,_END]. In the latter
@@ -8021,12 +8033,12 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
=20
 	} else if (reg->type =3D=3D PTR_TO_STACK) {
 		/* Basic bounds checks. */
-		err =3D check_stack_access_within_bounds(env, reg, regno, off, size, t=
);
+		err =3D check_stack_access_within_bounds(env, reg, reg_or_arg, off, si=
ze, t);
 		if (err)
 			return err;
=20
 		if (t =3D=3D BPF_READ)
-			err =3D check_stack_read(env, reg, regno, off, size,
+			err =3D check_stack_read(env, reg, reg_or_arg, off, size,
 					       value_regno);
 		else
 			err =3D check_stack_write(env, reg, off, size,
@@ -8042,7 +8054,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 				value_regno);
 			return -EACCES;
 		}
-		err =3D check_packet_access(env, reg, regno, off, size, false);
+		err =3D check_packet_access(env, reg, reg_or_arg, off, size, false);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type =3D=3D PTR_TO_FLOW_KEYS) {
@@ -8058,23 +8070,23 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (type_is_sk_pointer(reg->type)) {
 		if (t =3D=3D BPF_WRITE) {
-			verbose(env, "R%d cannot write into %s\n",
-				regno, reg_type_str(env, reg->type));
+			verbose(env, "%s cannot write into %s\n",
+				reg_arg_name(env, reg_or_arg), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
-		err =3D check_sock_access(env, insn_idx, reg, regno, off, size, t);
+		err =3D check_sock_access(env, insn_idx, reg, reg_or_arg, off, size, t=
);
 		if (!err && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type =3D=3D PTR_TO_TP_BUFFER) {
-		err =3D check_tp_buffer_access(env, reg, regno, off, size);
+		err =3D check_tp_buffer_access(env, reg, reg_or_arg, off, size);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID &&
 		   !type_may_be_null(reg->type)) {
-		err =3D check_ptr_to_btf_access(env, regs, reg, regno, off, size, t,
+		err =3D check_ptr_to_btf_access(env, regs, reg, reg_or_arg, off, size,=
 t,
 					      value_regno);
 	} else if (reg->type =3D=3D CONST_PTR_TO_MAP) {
-		err =3D check_ptr_to_map_access(env, regs, reg, regno, off, size, t,
+		err =3D check_ptr_to_map_access(env, regs, reg, reg_or_arg, off, size,=
 t,
 					      value_regno);
 	} else if (base_type(reg->type) =3D=3D PTR_TO_BUF &&
 		   !type_may_be_null(reg->type)) {
@@ -8083,8 +8095,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
=20
 		if (rdonly_mem) {
 			if (t =3D=3D BPF_WRITE) {
-				verbose(env, "R%d cannot write into %s\n",
-					regno, reg_type_str(env, reg->type));
+				verbose(env, "%s cannot write into %s\n",
+					reg_arg_name(env, reg_or_arg), reg_type_str(env, reg->type));
 				return -EACCES;
 			}
 			max_access =3D &env->prog->aux->max_rdonly_access;
@@ -8092,7 +8104,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 			max_access =3D &env->prog->aux->max_rdwr_access;
 		}
=20
-		err =3D check_buffer_access(env, reg, regno, off, size, false,
+		err =3D check_buffer_access(env, reg, reg_or_arg, off, size, false,
 					  max_access);
=20
 		if (!err && value_regno >=3D 0 && (rdonly_mem || t =3D=3D BPF_READ))
@@ -8101,7 +8113,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 		if (t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
-		verbose(env, "R%d invalid mem access '%s'\n", regno,
+		verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, reg_or_=
arg),
 			reg_type_str(env, reg->type));
 		return -EACCES;
 	}
@@ -8355,7 +8367,7 @@ static int check_atomic(struct bpf_verifier_env *en=
v, struct bpf_insn *insn)
  * read offsets are marked as read.
  */
 static int check_stack_range_initialized(
-		struct bpf_verifier_env *env, struct bpf_reg_state *reg,int regno, int=
 off,
+		struct bpf_verifier_env *env, struct bpf_reg_state *reg,int reg_or_arg=
, int off,
 		int access_size, bool zero_size_allowed,
 		enum bpf_access_type type, struct bpf_call_arg_meta *meta)
 {
@@ -8380,7 +8392,7 @@ static int check_stack_range_initialized(
 		return -EACCES;
 	}
=20
-	err =3D check_stack_access_within_bounds(env, reg, regno, off, access_s=
ize, type);
+	err =3D check_stack_access_within_bounds(env, reg, reg_or_arg, off, acc=
ess_size, type);
 	if (err)
 		return err;
=20
@@ -8396,8 +8408,8 @@ static int check_stack_range_initialized(
 			char tn_buf[48];
=20
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "R%d variable offset stack access prohibited for !root, =
var_off=3D%s\n",
-				regno, tn_buf);
+			verbose(env, "%s variable offset stack access prohibited for !root, v=
ar_off=3D%s\n",
+				reg_arg_name(env, reg_or_arg), tn_buf);
 			return -EACCES;
 		}
 		/* Only initialized buffer on stack is allowed to be accessed
@@ -8440,7 +8452,12 @@ static int check_stack_range_initialized(
 			}
 		}
 		meta->access_size =3D access_size;
-		meta->regno =3D regno;
+
+		/*
+		 * reg_or_arg should always be non-negative as meta->raw_mode is set i=
n
+		 * check_func_arg().
+		 */
+		meta->regno =3D reg_or_arg;
 		return 0;
 	}
=20
@@ -8480,17 +8497,17 @@ static int check_stack_range_initialized(
 		if (*stype =3D=3D STACK_POISON) {
 			if (allow_poison)
 				goto mark;
-			verbose(env, "reading from stack R%d off %d+%d size %d, slot poisoned=
 by dead code elimination\n",
-				regno, min_off, i - min_off, access_size);
+			verbose(env, "reading from stack %s off %d+%d size %d, slot poisoned =
by dead code elimination\n",
+				reg_arg_name(env, reg_or_arg), min_off, i - min_off, access_size);
 		} else if (tnum_is_const(reg->var_off)) {
-			verbose(env, "invalid read from stack R%d off %d+%d size %d\n",
-				regno, min_off, i - min_off, access_size);
+			verbose(env, "invalid read from stack %s off %d+%d size %d\n",
+				reg_arg_name(env, reg_or_arg), min_off, i - min_off, access_size);
 		} else {
 			char tn_buf[48];
=20
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "invalid read from stack R%d var_off %s+%d size %d\n",
-				regno, tn_buf, i - min_off, access_size);
+			verbose(env, "invalid read from stack %s var_off %s+%d size %d\n",
+				reg_arg_name(env, reg_or_arg), tn_buf, i - min_off, access_size);
 		}
 		return -EACCES;
 mark:
@@ -8499,7 +8516,7 @@ static int check_stack_range_initialized(
 	return 0;
 }
=20
-static int check_helper_mem_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int regno,
+static int check_helper_mem_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int reg_or_arg,
 				   int access_size, enum bpf_access_type access_type,
 				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
@@ -8510,36 +8527,36 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
-		return check_packet_access(env, reg, regno, 0, access_size,
+		return check_packet_access(env, reg, reg_or_arg, 0, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
 		if (access_type =3D=3D BPF_WRITE) {
-			verbose(env, "R%d cannot write into %s\n", regno,
+			verbose(env, "%s cannot write into %s\n", reg_arg_name(env, reg_or_ar=
g),
 				reg_type_str(env, reg->type));
 			return -EACCES;
 		}
-		return check_mem_region_access(env, reg, regno, 0, access_size,
+		return check_mem_region_access(env, reg, reg_or_arg, 0, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
 		if (check_map_access_type(env, reg, 0, access_size, access_type))
 			return -EACCES;
-		return check_map_access(env, reg, regno, 0, access_size,
+		return check_map_access(env, reg, reg_or_arg, 0, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
 			if (access_type =3D=3D BPF_WRITE) {
-				verbose(env, "R%d cannot write into %s\n", regno,
+				verbose(env, "%s cannot write into %s\n", reg_arg_name(env, reg_or_a=
rg),
 					reg_type_str(env, reg->type));
 				return -EACCES;
 			}
 		}
-		return check_mem_region_access(env, reg, regno, 0,
+		return check_mem_region_access(env, reg, reg_or_arg, 0,
 					       access_size, reg->mem_size,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
 		if (type_is_rdonly_mem(reg->type)) {
 			if (access_type =3D=3D BPF_WRITE) {
-				verbose(env, "R%d cannot write into %s\n", regno,
+				verbose(env, "%s cannot write into %s\n", reg_arg_name(env, reg_or_a=
rg),
 					reg_type_str(env, reg->type));
 				return -EACCES;
 			}
@@ -8548,21 +8565,21 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
 		} else {
 			max_access =3D &env->prog->aux->max_rdwr_access;
 		}
-		return check_buffer_access(env, reg, regno, 0,
+		return check_buffer_access(env, reg, reg_or_arg, 0,
 					   access_size, zero_size_allowed,
 					   max_access);
 	case PTR_TO_STACK:
 		return check_stack_range_initialized(
 				env, reg,
-				regno, 0, access_size,
+				reg_or_arg, 0, access_size,
 				zero_size_allowed, access_type, meta);
 	case PTR_TO_BTF_ID:
-		return check_ptr_to_btf_access(env, regs, reg, regno, 0,
+		return check_ptr_to_btf_access(env, regs, reg, reg_or_arg, 0,
 					       access_size, BPF_READ, -1);
 	case PTR_TO_CTX:
 		/* Only permit reading or writing syscall context using helper calls. =
*/
 		if (is_var_ctx_off_allowed(env->prog)) {
-			int err =3D check_mem_region_access(env, reg, regno, 0, access_size, =
U16_MAX,
+			int err =3D check_mem_region_access(env, reg, reg_or_arg, 0, access_s=
ize, U16_MAX,
 							  zero_size_allowed);
 			if (err)
 				return err;
@@ -8577,7 +8594,7 @@ static int check_helper_mem_access(struct bpf_verif=
ier_env *env, struct bpf_reg_
 		    register_is_null(reg))
 			return 0;
=20
-		verbose(env, "R%d type=3D%s ", regno,
+		verbose(env, "%s type=3D%s ", reg_arg_name(env, reg_or_arg),
 			reg_type_str(env, reg->type));
 		verbose(env, "expected=3D%s\n", reg_type_str(env, PTR_TO_STACK));
 		return -EACCES;
@@ -8592,12 +8609,12 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, struct bpf_reg_
  */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *mem_reg,
-			      struct bpf_reg_state *size_reg, int mem_regno,
+			      struct bpf_reg_state *size_reg, int reg_or_arg,
 			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
-	int size_regno =3D mem_regno + 1;
+	int size_reg_or_arg =3D (reg_or_arg >=3D 0) ? reg_or_arg + 1 : reg_or_a=
rg - 1;
 	int err;
=20
 	/* This is used to refine r0 return value bounds for helpers
@@ -8619,31 +8636,31 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
 		meta =3D NULL;
=20
 	if (size_reg->smin_value < 0) {
-		verbose(env, "R%d min value is negative, either use unsigned or 'var &=
=3D const'\n",
-			size_regno);
+		verbose(env, "%s min value is negative, either use unsigned or 'var &=3D=
 const'\n",
+			reg_arg_name(env, size_reg_or_arg));
 		return -EACCES;
 	}
=20
 	if (size_reg->umin_value =3D=3D 0 && !zero_size_allowed) {
-		verbose(env, "R%d invalid zero-sized read: u64=3D[%lld,%lld]\n",
-			size_regno, size_reg->umin_value, size_reg->umax_value);
+		verbose(env, "%s invalid zero-sized read: u64=3D[%lld,%lld]\n",
+			reg_arg_name(env, size_reg_or_arg), size_reg->umin_value, size_reg->u=
max_value);
 		return -EACCES;
 	}
=20
 	if (size_reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
-		verbose(env, "R%d unbounded memory access, use 'var &=3D const' or 'if=
 (var < const)'\n",
-			size_regno);
+		verbose(env, "%s unbounded memory access, use 'var &=3D const' or 'if =
(var < const)'\n",
+			reg_arg_name(env, size_reg_or_arg));
 		return -EACCES;
 	}
-	err =3D check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax=
_value,
+	err =3D check_helper_mem_access(env, mem_reg, reg_or_arg, size_reg->uma=
x_value,
 				      access_type, zero_size_allowed, meta);
-	if (!err)
-		err =3D mark_chain_precision(env, size_regno);
+	if (!err && size_reg_or_arg > 0)
+		err =3D mark_chain_precision(env, size_reg_or_arg);
 	return err;
 }
=20
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_st=
ate *reg,
-			 int regno, u32 mem_size)
+			 int reg_or_arg, u32 mem_size)
 {
 	bool may_be_null =3D type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -8663,8 +8680,8 @@ static int check_mem_reg(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *reg
=20
 	int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem_size =
: mem_size;
=20
-	err =3D check_helper_mem_access(env, reg, regno, size, BPF_READ, true, =
NULL);
-	err =3D err ?: check_helper_mem_access(env, reg, regno, size, BPF_WRITE=
, true, NULL);
+	err =3D check_helper_mem_access(env, reg, reg_or_arg, size, BPF_READ, t=
rue, NULL);
+	err =3D err ?: check_helper_mem_access(env, reg, reg_or_arg, size, BPF_=
WRITE, true, NULL);
=20
 	if (may_be_null)
 		*reg =3D saved_reg;
@@ -8674,14 +8691,15 @@ static int check_mem_reg(struct bpf_verifier_env =
*env, struct bpf_reg_state *reg
=20
 static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct=
 bpf_reg_state *mem_reg,
 				    struct bpf_reg_state *size_reg,
-				    u32 mem_regno)
+				    u32 mem_argno)
 {
+	int reg_or_arg =3D -(int)(mem_argno + 1);
 	bool may_be_null =3D type_may_be_null(mem_reg->type);
 	struct bpf_reg_state saved_reg;
 	struct bpf_call_arg_meta meta;
 	int err;
=20
-	WARN_ON_ONCE(mem_regno > BPF_REG_4);
+	WARN_ON_ONCE(mem_argno > BPF_REG_3);
=20
 	memset(&meta, 0, sizeof(meta));
=20
@@ -8690,8 +8708,8 @@ static int check_kfunc_mem_size_reg(struct bpf_veri=
fier_env *env, struct bpf_reg
 		mark_ptr_not_null_reg(mem_reg);
 	}
=20
-	err =3D check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_READ,=
 true, &meta);
-	err =3D err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BP=
F_WRITE, true, &meta);
+	err =3D check_mem_size_reg(env, mem_reg, size_reg, reg_or_arg, BPF_READ=
, true, &meta);
+	err =3D err ?: check_mem_size_reg(env, mem_reg, size_reg, reg_or_arg, B=
PF_WRITE, true, &meta);
=20
 	if (may_be_null)
 		*mem_reg =3D saved_reg;
@@ -8727,7 +8745,7 @@ enum {
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
@@ -8743,8 +8761,8 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, struct bpf_reg_state
=20
 	if (!is_const) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s_lock has to be at the constant =
offset\n",
-			regno, lock_str);
+			"arg#%d doesn't have constant offset. %s_lock has to be at the consta=
nt offset\n",
+			argno, lock_str);
 		return -EINVAL;
 	}
 	if (reg->type =3D=3D PTR_TO_MAP_VALUE) {
@@ -8843,7 +8861,7 @@ static int process_spin_lock(struct bpf_verifier_en=
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
@@ -8855,8 +8873,8 @@ static int check_map_field_pointer(struct bpf_verif=
ier_env *env, struct bpf_reg_
=20
 	if (!is_const) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
-			regno, struct_name);
+			"arg#%d doesn't have constant offset. %s has to be at the constant of=
fset\n",
+			argno, struct_name);
 		return -EINVAL;
 	}
 	if (!map->btf) {
@@ -8896,26 +8914,26 @@ static int check_map_field_pointer(struct bpf_ver=
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
reg_state *reg, u32 argno,
 			       struct bpf_kfunc_call_arg_meta *meta)
 {
-	return process_timer_func(env, reg, regno, &meta->map);
+	return process_timer_func(env, reg, argno, &meta->map);
 }
=20
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
@@ -8991,7 +9009,7 @@ static int process_kptr_func(struct bpf_verifier_en=
v *env, int regno,
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
@@ -8999,7 +9017,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, struct bpf_reg_stat
 	if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DYNPTR) =
{
 		verbose(env,
 			"arg#%d expected pointer to stack or const struct bpf_dynptr\n",
-			regno - 1);
+			argno);
 		return -EINVAL;
 	}
=20
@@ -9036,7 +9054,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, struct bpf_reg_stat
=20
 		/* we write BPF_DW bits (8 bytes) at a time */
 		for (i =3D 0; i < BPF_DYNPTR_SIZE; i +=3D 8) {
-			err =3D check_mem_access(env, insn_idx, reg, regno,
+			err =3D check_mem_access(env, insn_idx, reg, -(argno + 1),
 					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
@@ -9053,7 +9071,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, struct bpf_reg_stat
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg#%d\n",
-				regno - 1);
+				argno);
 			return -EINVAL;
 		}
=20
@@ -9061,7 +9079,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, struct bpf_reg_stat
 		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
 			verbose(env,
 				"Expected a dynptr of type %s as arg#%d\n",
-				dynptr_type_str(arg_to_dynptr_type(arg_type)), regno - 1);
+				dynptr_type_str(arg_to_dynptr_type(arg_type)), argno);
 			return -EINVAL;
 		}
=20
@@ -9110,14 +9128,14 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_ca=
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
 	int spi, err, i, nr_slots, btf_id;
=20
 	if (reg->type !=3D PTR_TO_STACK) {
-		verbose(env, "arg#%d expected pointer to an iterator on stack\n", regn=
o - 1);
+		verbose(env, "arg#%d expected pointer to an iterator on stack\n", argn=
o);
 		return -EINVAL;
 	}
=20
@@ -9127,9 +9145,9 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, struct bpf_reg_state *
 	 * to any kfunc, if arg has "__iter" suffix, we need to be a bit more
 	 * conservative here.
 	 */
-	btf_id =3D btf_check_iter_arg(meta->btf, meta->func_proto, regno - 1);
+	btf_id =3D btf_check_iter_arg(meta->btf, meta->func_proto, argno);
 	if (btf_id < 0) {
-		verbose(env, "expected valid iter pointer as arg#%d\n", regno - 1);
+		verbose(env, "expected valid iter pointer as arg#%d\n", argno);
 		return -EINVAL;
 	}
 	t =3D btf_type_by_id(meta->btf, btf_id);
@@ -9139,12 +9157,12 @@ static int process_iter_arg(struct bpf_verifier_e=
nv *env, struct bpf_reg_state *
 		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as arg#%d\n",
-				iter_type_str(meta->btf, btf_id), regno - 1);
+				iter_type_str(meta->btf, btf_id), argno);
 			return -EINVAL;
 		}
=20
 		for (i =3D 0; i < nr_slots * 8; i +=3D BPF_REG_SIZE) {
-			err =3D check_mem_access(env, insn_idx, reg, regno,
+			err =3D check_mem_access(env, insn_idx, reg, -(argno + 1),
 					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
@@ -9163,7 +9181,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, struct bpf_reg_state *
 			break;
 		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as arg#%d\n",
-				iter_type_str(meta->btf, btf_id), regno - 1);
+				iter_type_str(meta->btf, btf_id), argno);
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
@@ -9676,7 +9694,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
=20
 		if (type_may_be_null(reg->type) &&
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
-			verbose(env, "Possibly NULL pointer passed to helper arg%d\n", regno)=
;
+			verbose(env, "Possibly NULL pointer passed to helper R%d\n", regno);
 			return -EACCES;
 		}
=20
@@ -9759,7 +9777,7 @@ reg_find_field_offset(const struct bpf_reg_state *r=
eg, s32 off, u32 fields)
 }
=20
 static int check_func_arg_reg_off(struct bpf_verifier_env *env,
-				  const struct bpf_reg_state *reg, int regno,
+				  const struct bpf_reg_state *reg, int reg_or_arg,
 				  enum bpf_arg_type arg_type)
 {
 	u32 type =3D reg->type;
@@ -9785,8 +9803,8 @@ static int check_func_arg_reg_off(struct bpf_verifi=
er_env *env,
 		 * to give the user a better error message.
 		 */
 		if (!tnum_is_const(reg->var_off) || reg->var_off.value !=3D 0) {
-			verbose(env, "R%d must have zero offset when passed to release func o=
r trusted arg to kfunc\n",
-				regno);
+			verbose(env, "%s must have zero offset when passed to release func or=
 trusted arg to kfunc\n",
+				reg_arg_name(env, reg_or_arg));
 			return -EINVAL;
 		}
 	}
@@ -9822,7 +9840,7 @@ static int check_func_arg_reg_off(struct bpf_verifi=
er_env *env,
 		 * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
 		 * still need to do checks instead of returning.
 		 */
-		return __check_ptr_off_reg(env, reg, regno, true);
+		return __check_ptr_off_reg(env, reg, reg_or_arg, true);
 	case PTR_TO_CTX:
 		/*
 		 * Allow fixed and variable offsets for syscall context, but
@@ -9834,7 +9852,7 @@ static int check_func_arg_reg_off(struct bpf_verifi=
er_env *env,
 			return 0;
 		fallthrough;
 	default:
-		return __check_ptr_off_reg(env, reg, regno, false);
+		return __check_ptr_off_reg(env, reg, reg_or_arg, false);
 	}
 }
=20
@@ -9905,7 +9923,7 @@ static enum bpf_dynptr_type dynptr_get_type(struct =
bpf_verifier_env *env,
 }
=20
 static int check_reg_const_str(struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg, int regno)
+			       struct bpf_reg_state *reg, int reg_or_arg)
 {
 	struct bpf_map *map =3D reg->map_ptr;
 	int err;
@@ -9917,17 +9935,17 @@ static int check_reg_const_str(struct bpf_verifie=
r_env *env,
 		return -EINVAL;
=20
 	if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY) {
-		verbose(env, "R%d points to insn_array map which cannot be used as con=
st string\n", regno);
+		verbose(env, "%s points to insn_array map which cannot be used as cons=
t string\n", reg_arg_name(env, reg_or_arg));
 		return -EACCES;
 	}
=20
 	if (!bpf_map_is_rdonly(map)) {
-		verbose(env, "R%d does not point to a readonly map'\n", regno);
+		verbose(env, "%s does not point to a readonly map'\n", reg_arg_name(en=
v, reg_or_arg));
 		return -EACCES;
 	}
=20
 	if (!tnum_is_const(reg->var_off)) {
-		verbose(env, "R%d is not a constant address'\n", regno);
+		verbose(env, "%s is not a constant address'\n", reg_arg_name(env, reg_=
or_arg));
 		return -EACCES;
 	}
=20
@@ -9936,7 +9954,7 @@ static int check_reg_const_str(struct bpf_verifier_=
env *env,
 		return -EACCES;
 	}
=20
-	err =3D check_map_access(env, reg, regno, 0,
+	err =3D check_map_access(env, reg, reg_or_arg, 0,
 			       map->value_size - reg->var_off.value, false,
 			       ACCESS_HELPER);
 	if (err)
@@ -10042,8 +10060,8 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
=20
 	if (arg_type =3D=3D ARG_ANYTHING) {
 		if (is_pointer_value(env, regno)) {
-			verbose(env, "R%d leaks addr into helper function\n",
-				regno);
+			verbose(env, "arg#%d leaks addr into helper function\n",
+				arg);
 			return -EACCES;
 		}
 		return 0;
@@ -10094,7 +10112,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 			if (reg->type =3D=3D PTR_TO_STACK) {
 				spi =3D dynptr_get_spi(env, reg);
 				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
-					verbose(env, "arg %d is an unacquired reference\n", regno);
+					verbose(env, "arg#%d is an unacquired reference\n", arg);
 					return -EINVAL;
 				}
 			} else {
@@ -10102,8 +10120,8 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 				return -EINVAL;
 			}
 		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
-			verbose(env, "R%d must be referenced when passed to release function\=
n",
-				regno);
+			verbose(env, "arg#%d must be referenced when passed to release functi=
on\n",
+				arg);
 			return -EINVAL;
 		}
 		if (meta->release_regno) {
@@ -10115,8 +10133,8 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
=20
 	if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DEST) {
 		if (meta->ref_obj_id) {
-			verbose(env, "more than one arg with ref_obj_id R%d %u %u",
-				regno, reg->ref_obj_id,
+			verbose(env, "more than one arg with ref_obj_id arg#%d %u %u",
+				arg, reg->ref_obj_id,
 				meta->ref_obj_id);
 			return -EACCES;
 		}
@@ -10198,7 +10216,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
-			verbose(env, "Helper has invalid btf_id in R%d\n", regno);
+			verbose(env, "Helper has invalid btf_id in arg#%d\n", arg);
 			return -EACCES;
 		}
 		meta->ret_btf =3D reg->btf;
@@ -10210,11 +10228,11 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
 			return -EACCES;
 		}
 		if (meta->func_id =3D=3D BPF_FUNC_spin_lock) {
-			err =3D process_spin_lock(env, reg, regno, PROCESS_SPIN_LOCK);
+			err =3D process_spin_lock(env, reg, arg, PROCESS_SPIN_LOCK);
 			if (err)
 				return err;
 		} else if (meta->func_id =3D=3D BPF_FUNC_spin_unlock) {
-			err =3D process_spin_lock(env, reg, regno, 0);
+			err =3D process_spin_lock(env, reg, arg, 0);
 			if (err)
 				return err;
 		} else {
@@ -10223,7 +10241,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err =3D process_timer_helper(env, reg, regno, meta);
+		err =3D process_timer_helper(env, reg, arg, meta);
 		if (err)
 			return err;
 		break;
@@ -10258,14 +10276,14 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err =3D process_dynptr_func(env, reg, regno, insn_idx, arg_type, 0);
+		err =3D process_dynptr_func(env, reg, arg, insn_idx, arg_type, 0);
 		if (err)
 			return err;
 		break;
 	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
 		if (!tnum_is_const(reg->var_off)) {
-			verbose(env, "R%d is not a known constant'\n",
-				regno);
+			verbose(env, "arg#%d is not a known constant'\n",
+				arg);
 			return -EACCES;
 		}
 		meta->mem_size =3D reg->var_off.value;
@@ -10870,7 +10888,7 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
=20
 		if (arg->arg_type =3D=3D ARG_ANYTHING) {
 			if (reg->type !=3D SCALAR_VALUE) {
-				bpf_log(log, "R%d is not a scalar\n", regno);
+				bpf_log(log, "arg#%d is not a scalar\n", i);
 				return -EINVAL;
 			}
 		} else if (arg->arg_type & PTR_UNTRUSTED) {
@@ -10909,7 +10927,7 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 			 * run-time debug nightmare.
 			 */
 			if (reg->type !=3D PTR_TO_ARENA && reg->type !=3D SCALAR_VALUE) {
-				bpf_log(log, "R%d is not a pointer to arena or scalar.\n", regno);
+				bpf_log(log, "arg#%d is not a pointer to arena or scalar.\n", i);
 				return -EINVAL;
 			}
 		} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
@@ -10917,7 +10935,7 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 			if (ret)
 				return ret;
=20
-			ret =3D process_dynptr_func(env, reg, regno, -1, arg->arg_type, 0);
+			ret =3D process_dynptr_func(env, reg, i, -1, arg->arg_type, 0);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
@@ -13067,15 +13085,15 @@ static int process_kf_arg_ptr_to_btf_id(struct =
bpf_verifier_env *env,
 	 */
 	taking_projection =3D btf_is_projection_of(ref_tname, reg_ref_tname);
 	if (!taking_projection && !struct_same) {
-		verbose(env, "kernel function %s args#%d expected pointer to %s %s but=
 R%d has a pointer to %s %s\n",
-			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
+		verbose(env, "kernel function %s args#%d expected pointer to %s %s but=
 has a pointer to %s %s\n",
+			meta->func_name, argno, btf_type_str(ref_t), ref_tname,
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
@@ -13098,11 +13116,11 @@ static int process_irq_flag(struct bpf_verifier=
_env *env, struct bpf_reg_state *
=20
 	if (irq_save) {
 		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
-			verbose(env, "expected uninitialized irq flag as arg#%d\n", regno - 1=
);
+			verbose(env, "expected uninitialized irq flag as arg#%d\n", argno);
 			return -EINVAL;
 		}
=20
-		err =3D check_mem_access(env, env->insn_idx, reg, regno, 0, BPF_DW, BP=
F_WRITE, -1, false, false);
+		err =3D check_mem_access(env, env->insn_idx, reg, -(argno + 1), 0, BPF=
_DW, BPF_WRITE, -1, false, false);
 		if (err)
 			return err;
=20
@@ -13112,7 +13130,7 @@ static int process_irq_flag(struct bpf_verifier_e=
nv *env, struct bpf_reg_state *
 	} else {
 		err =3D is_irq_flag_reg_valid_init(env, reg);
 		if (err) {
-			verbose(env, "expected an initialized irq flag as arg#%d\n", regno - =
1);
+			verbose(env, "expected an initialized irq flag as arg#%d\n", argno);
 			return err;
 		}
=20
@@ -13403,7 +13421,7 @@ static bool check_kfunc_is_graph_node_api(struct =
bpf_verifier_env *env,
=20
 static int
 __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
-				   struct bpf_reg_state *reg, u32 regno,
+				   struct bpf_reg_state *reg, u32 argno,
 				   struct bpf_kfunc_call_arg_meta *meta,
 				   enum btf_field_type head_field_type,
 				   struct btf_field **head_field)
@@ -13424,8 +13442,8 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_ver=
ifier_env *env,
 	head_type_name =3D btf_field_type_name(head_field_type);
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
-			regno, head_type_name);
+			"arg#%d doesn't have constant offset. %s has to be at the constant of=
fset\n",
+			argno, head_type_name);
 		return -EINVAL;
 	}
=20
@@ -13453,24 +13471,24 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_v=
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
@@ -13492,8 +13510,8 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_ver=
ifier_env *env,
 	node_type_name =3D btf_field_type_name(node_field_type);
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
-			"R%d doesn't have constant offset. %s has to be at the constant offse=
t\n",
-			regno, node_type_name);
+			"arg#%d doesn't have constant offset. %s has to be at the constant of=
fset\n",
+			argno, node_type_name);
 		return -EINVAL;
 	}
=20
@@ -13534,19 +13552,19 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_v=
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
@@ -13620,7 +13638,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
=20
 		if (btf_type_is_scalar(t)) {
 			if (reg->type !=3D SCALAR_VALUE) {
-				verbose(env, "R%d is not a scalar\n", regno);
+				verbose(env, "arg#%d is not a scalar\n", i);
 				return -EINVAL;
 			}
=20
@@ -13630,7 +13648,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					return -EFAULT;
 				}
 				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "R%d must be a known constant\n", regno);
+					verbose(env, "arg#%d must be a known constant\n", i);
 					return -EINVAL;
 				}
 				ret =3D mark_chain_precision(env, regno);
@@ -13652,7 +13670,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				}
=20
 				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "R%d is not a const\n", regno);
+					verbose(env, "arg#%d is not a const\n", i);
 					return -EINVAL;
 				}
=20
@@ -13677,8 +13695,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
=20
 		if (reg->ref_obj_id) {
 			if (is_kfunc_release(meta) && meta->ref_obj_id) {
-				verifier_bug(env, "more than one arg with ref_obj_id R%d %u %u",
-					     regno, reg->ref_obj_id,
+				verifier_bug(env, "more than one arg with ref_obj_id arg#%d %u %u",
+					     i, reg->ref_obj_id,
 					     meta->ref_obj_id);
 				return -EFAULT;
 			}
@@ -13699,7 +13717,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			continue;
 		case KF_ARG_PTR_TO_MAP:
 			if (!reg->map_ptr) {
-				verbose(env, "pointer in R%d isn't map pointer\n", regno);
+				verbose(env, "pointer in arg#%d isn't map pointer\n", i);
 				return -EINVAL;
 			}
 			if (meta->map.ptr && (reg->map_ptr->record->wq_off >=3D 0 ||
@@ -13737,11 +13755,11 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
-					verbose(env, "R%d must be referenced or trusted\n", regno);
+					verbose(env, "arg#%d must be referenced or trusted\n", i);
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
-					verbose(env, "R%d must be a rcu pointer\n", regno);
+					verbose(env, "arg#%d must be a rcu pointer\n", i);
 					return -EINVAL;
 				}
 			}
@@ -13773,7 +13791,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
=20
 		if (is_kfunc_release(meta) && reg->ref_obj_id)
 			arg_type |=3D OBJ_RELEASE;
-		ret =3D check_func_arg_reg_off(env, reg, regno, arg_type);
+		ret =3D check_func_arg_reg_off(env, reg, -(i + 1), arg_type);
 		if (ret < 0)
 			return ret;
=20
@@ -13855,7 +13873,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				}
 			}
=20
-			ret =3D process_dynptr_func(env, reg, regno, insn_idx, dynptr_arg_typ=
e, clone_ref_obj_id);
+			ret =3D process_dynptr_func(env, reg, i, insn_idx, dynptr_arg_type, c=
lone_ref_obj_id);
 			if (ret < 0)
 				return ret;
=20
@@ -13880,7 +13898,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
-			ret =3D process_iter_arg(env, reg, regno, insn_idx, meta);
+			ret =3D process_iter_arg(env, reg, i, insn_idx, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13894,7 +13912,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
-			ret =3D process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_list_head(env, reg, i, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13908,7 +13926,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
-			ret =3D process_kf_arg_ptr_to_rbtree_root(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_rbtree_root(env, reg, i, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13921,7 +13939,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
-			ret =3D process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_list_node(env, reg, i, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13946,7 +13964,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				}
 			}
=20
-			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
+			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, i, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13978,7 +13996,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret =3D check_mem_reg(env, reg, regno, type_size);
+			ret =3D check_mem_reg(env, reg, -(i + 1), type_size);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13990,7 +14008,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			const struct btf_param *size_arg =3D &args[i + 1];
=20
 			if (!register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, =
buff_arg)) {
-				ret =3D check_kfunc_mem_size_reg(env, buff_reg, size_reg, regno);
+				ret =3D check_kfunc_mem_size_reg(env, buff_reg, size_reg, i);
 				if (ret < 0) {
 					verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memor=
y access\n", i, i + 1);
 					return ret;
@@ -14003,7 +14021,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					return -EFAULT;
 				}
 				if (!tnum_is_const(size_reg->var_off)) {
-					verbose(env, "R%d must be a known constant\n", regno + 1);
+					verbose(env, "arg#%d must be a known constant\n", i + 1);
 					return -EINVAL;
 				}
 				meta->arg_constant.found =3D true;
@@ -14048,7 +14066,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a const string\n", i);
 				return -EINVAL;
 			}
-			ret =3D check_reg_const_str(env, reg, regno);
+			ret =3D check_reg_const_str(env, reg, -(i + 1));
 			if (ret)
 				return ret;
 			break;
@@ -14057,7 +14075,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret =3D check_map_field_pointer(env, reg, regno, BPF_WORKQUEUE, &meta=
->map);
+			ret =3D check_map_field_pointer(env, reg, i, BPF_WORKQUEUE, &meta->ma=
p);
 			if (ret < 0)
 				return ret;
 			break;
@@ -14066,7 +14084,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret =3D process_timer_kfunc(env, reg, regno, meta);
+			ret =3D process_timer_kfunc(env, reg, i, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -14075,7 +14093,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret =3D check_map_field_pointer(env, reg, regno, BPF_TASK_WORK, &meta=
->map);
+			ret =3D check_map_field_pointer(env, reg, i, BPF_TASK_WORK, &meta->ma=
p);
 			if (ret < 0)
 				return ret;
 			break;
@@ -14084,7 +14102,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to an irq flag on stack\n", i);
 				return -EINVAL;
 			}
-			ret =3D process_irq_flag(env, reg, regno, meta);
+			ret =3D process_irq_flag(env, reg, i, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -14105,7 +14123,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqs=
ave] ||
 			    meta->func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock_ir=
qrestore])
 				flags |=3D PROCESS_LOCK_IRQ;
-			ret =3D process_spin_lock(env, reg, regno, flags);
+			ret =3D process_spin_lock(env, reg, i, flags);
 			if (ret < 0)
 				return ret;
 			break;
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
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 6f25b5f39a79..f817e0968d72 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -68,7 +68,7 @@ static struct {
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_M=
AX]" },
 	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argum=
ent must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument=
 must be of a struct" },
-	{ "obj_drop_non_zero_off", "R1 must have zero offset when passed to rel=
ease func" },
+	{ "obj_drop_non_zero_off", "arg#0 must have zero offset when passed to =
release func" },
 	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
 	{ "obj_new_acq", "Unreleased reference id=3D" },
 	{ "use_after_drop", "invalid mem access 'scalar'" },
@@ -91,7 +91,7 @@ static struct {
 	{ "incorrect_node_off1", "bpf_list_node not found at offset=3D49" },
 	{ "incorrect_node_off2", "arg#1 offset=3D0, but expected bpf_list_node =
at offset=3D48 in struct foo" },
 	{ "no_head_type", "bpf_list_head not found at offset=3D0" },
-	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
+	{ "incorrect_head_var_off1", "arg#0 doesn't have constant offset" },
 	{ "incorrect_head_var_off2", "variable ptr_ access var_off=3D(0x0; 0x1f=
fffffff) disallowed" },
 	{ "incorrect_head_off1", "bpf_list_head not found at offset=3D25" },
 	{ "incorrect_head_off2", "bpf_list_head not found at offset=3D1" },
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/=
testing/selftests/bpf/progs/cpumask_failure.c
index 61c32e91e8c3..588fa15e71ef 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -117,7 +117,7 @@ int BPF_PROG(test_cpumask_null, struct task_struct *t=
ask, u64 clone_flags)
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("R2 must be a rcu pointer")
+__failure __msg("arg#1 must be a rcu pointer")
 int BPF_PROG(test_global_mask_out_of_rcu, struct task_struct *task, u64 =
clone_flags)
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
index d552117b001e..381072d5152f 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -136,7 +136,7 @@ int ringbuf_missing_release_callback(void *ctx)
=20
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dyn=
ptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("arg#0 is an unacquired reference")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -650,7 +650,7 @@ int invalid_offset(void *ctx)
=20
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("arg#0 is an unacquired reference")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -677,7 +677,7 @@ static int release_twice_callback_fn(__u32 index, voi=
d *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("arg#0 is an unacquired reference")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/te=
sting/selftests/bpf/progs/iters_testmod.c
index 5379e9960ffd..60d28220df2a 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -85,7 +85,7 @@ int iter_next_rcu_or_null(const void *ctx)
 }
=20
 SEC("raw_tp/sys_enter")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("arg#0 must be referenced or trusted")
 int iter_next_rcu_not_trusted(const void *ctx)
 {
 	struct task_struct *cur_task =3D bpf_get_current_task_btf();
@@ -105,8 +105,8 @@ int iter_next_rcu_not_trusted(const void *ctx)
 }
=20
 SEC("raw_tp/sys_enter")
-__failure __msg("R1 cannot write into rdonly_mem")
-/* Message should not be 'R1 cannot write into rdonly_trusted_mem' */
+__failure __msg("arg#0 cannot write into rdonly_mem")
+/* Message should not be 'arg#0 cannot write into rdonly_trusted_mem' */
 int iter_next_ptr_mem_not_trusted(const void *ctx)
 {
 	struct bpf_iter_num num_it;
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/=
tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
index fcf7a7567da2..9c817aca03e1 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
@@ -63,7 +63,7 @@ long stash_rb_nodes(void *ctx)
 }
=20
 SEC("tc")
-__failure __msg("R1 must have zero offset when passed to release func")
+__failure __msg("arg#0 must have zero offset when passed to release func=
")
 long drop_rb_node_off(void *ctx)
 {
 	struct map_value *mapval;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/te=
sting/selftests/bpf/progs/map_kptr_fail.c
index 6443b320c732..ea765ac4fedb 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -252,7 +252,7 @@ int reject_untrusted_store_to_ref(struct __sk_buff *c=
tx)
 }
=20
 SEC("?tc")
-__failure __msg("R2 must be referenced")
+__failure __msg("arg#1 must be referenced")
 int reject_untrusted_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -364,7 +364,7 @@ int kptr_xchg_ref_state(struct __sk_buff *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to helper arg2")
+__failure __msg("Possibly NULL pointer passed to helper R2")
 int kptr_xchg_possibly_null(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/t=
ools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 5b4453747c23..02386da6bbc3 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -118,7 +118,7 @@ int atomic_rmw_not_ok(void *ctx)
 SEC("socket")
 __failure
 __msg("invalid access to memory, mem_size=3D0 off=3D0 size=3D4")
-__msg("R1 min value is outside of the allowed memory range")
+__msg("arg#0 min value is outside of the allowed memory range")
 int kfunc_param_not_ok(void *ctx)
 {
 	int *p;
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_failure.c b/t=
ools/testing/selftests/bpf/progs/nested_trust_failure.c
index 3568ec450100..ebfc86af31f0 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_failure.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
@@ -24,7 +24,7 @@ struct {
  */
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("R2 must be")
+__failure __msg("arg#1 must be")
 int BPF_PROG(test_invalid_nested_user_cpus, struct task_struct *task, u6=
4 clone_flags)
 {
 	bpf_cpumask_test_cpu(0, task->user_cpus_ptr);
diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c b/too=
ls/testing/selftests/bpf/progs/res_spin_lock_fail.c
index 330682a88c16..dc26c1e52320 100644
--- a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
@@ -203,7 +203,7 @@ int res_spin_lock_bad_off(struct __sk_buff *ctx)
 }
=20
 SEC("?tc")
-__failure __msg("R1 doesn't have constant offset. bpf_res_spin_lock has =
to be at the constant offset")
+__failure __msg("arg#0 doesn't have constant offset. bpf_res_spin_lock h=
as to be at the constant offset")
 int res_spin_lock_var_off(struct __sk_buff *ctx)
 {
 	struct arr_elem *elem;
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/test=
ing/selftests/bpf/progs/stream_fail.c
index 8e8249f3521c..7a88a670dee0 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -15,7 +15,7 @@ int stream_vprintk_null_arg(void *ctx)
 }
=20
 SEC("syscall")
-__failure __msg("R3 type=3Dscalar expected=3D")
+__failure __msg("arg#2 type=3Dscalar expected=3D")
 int stream_vprintk_scalar_arg(void *ctx)
 {
 	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0);
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
index 4c07ea193f72..055fb1d83a75 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -262,7 +262,7 @@ int BPF_PROG(task_kfunc_from_vpid_no_null_check, stru=
ct task_struct *task, u64 c
 }
=20
 SEC("lsm/task_free")
-__failure __msg("R1 must be a rcu pointer")
+__failure __msg("arg#0 must be a rcu pointer")
 int BPF_PROG(task_kfunc_from_lsm_task_free, struct task_struct *task)
 {
 	struct task_struct *acquired;
@@ -313,7 +313,7 @@ int BPF_PROG(task_access_comm4, struct task_struct *t=
ask, const char *buf, bool
 }
=20
 SEC("tp_btf/task_newtask")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("arg#0 must be referenced or trusted")
 int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 cl=
one_flags)
 {
 	struct task_struct *local;
diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c =
b/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
index 9a13f5c11ac7..e96d632fc1d8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
@@ -149,7 +149,7 @@ __naked void invalid_cgroup_storage_access_5(void)
 SEC("cgroup/skb")
 __description("invalid cgroup storage access 6")
 __failure __msg("get_local_storage() doesn't support non-zero flags")
-__msg_unpriv("R2 leaks addr into helper function")
+__msg_unpriv("arg#1 leaks addr into helper function")
 __naked void invalid_cgroup_storage_access_6(void)
 {
 	asm volatile ("					\
@@ -288,7 +288,7 @@ __naked void cpu_cgroup_storage_access_5(void)
 SEC("cgroup/skb")
 __description("invalid per-cpu cgroup storage access 6")
 __failure __msg("get_local_storage() doesn't support non-zero flags")
-__msg_unpriv("R2 leaks addr into helper function")
+__msg_unpriv("arg#1 leaks addr into helper function")
 __naked void cpu_cgroup_storage_access_6(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/tes=
ting/selftests/bpf/progs/verifier_ctx.c
index 7856dad3d1f3..86f0cf1f1dca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -844,7 +844,7 @@ int syscall_ctx_kfunc_zero_sized(void *ctx)
 	}								\
 	SEC("?" type)							\
 	__description(type ": reject kfunc zero-sized ctx access")	\
-	__failure __msg("R1 type=3Dctx expected=3Dfp")			\
+	__failure __msg("arg#0 type=3Dctx expected=3Dfp")			\
 	int no_rewrite_##name##_kfunc_zero(void *ctx)			\
 	{								\
 		bpf_kfunc_call_test_mem_len_pass1(ctx, 0);		\
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/=
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
index 910365201f68..630f40ac9e5a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -1288,7 +1288,7 @@ l1_%=3D:	r1 =3D r6;					\
=20
 SEC("tc")
 __description("reference tracking: bpf_sk_release(listen_sk)")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("arg#0 must be referenced when passed to release functio=
n")
 __naked void bpf_sk_release_listen_sk(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/te=
sting/selftests/bpf/progs/verifier_sock.c
index a2132c72d3b8..45f44a5d9b60 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -603,7 +603,7 @@ l2_%=3D:	r0 =3D *(u32*)(r0 + %[bpf_tcp_sock_snd_cwnd]=
);	\
=20
 SEC("tc")
 __description("bpf_sk_release(skb->sk)")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("arg#0 must be referenced when passed to release functio=
n")
 __naked void bpf_sk_release_skb_sk(void)
 {
 	asm volatile ("					\
@@ -620,7 +620,7 @@ l0_%=3D:	r0 =3D 0;						\
=20
 SEC("tc")
 __description("bpf_sk_release(bpf_sk_fullsock(skb->sk))")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("arg#0 must be referenced when passed to release functio=
n")
 __naked void bpf_sk_fullsock_skb_sk(void)
 {
 	asm volatile ("					\
@@ -644,7 +644,7 @@ l1_%=3D:	r1 =3D r0;					\
=20
 SEC("tc")
 __description("bpf_sk_release(bpf_tcp_sock(skb->sk))")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("arg#0 must be referenced when passed to release functio=
n")
 __naked void bpf_tcp_sock_skb_sk(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
index c16f8382cf17..97eab23d7480 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -175,7 +175,7 @@ __naked void check_that_printk_is_disallowed(void)
=20
 SEC("socket")
 __description("unpriv: pass pointer to helper function")
-__success __failure_unpriv __msg_unpriv("R4 leaks addr")
+__success __failure_unpriv __msg_unpriv("arg#3 leaks addr")
 __retval(0)
 __naked void pass_pointer_to_helper_function(void)
 {
@@ -607,7 +607,7 @@ __naked void unpriv_partial_copy_of_pointer(void)
=20
 SEC("socket")
 __description("unpriv: pass pointer to tail_call")
-__success __failure_unpriv __msg_unpriv("R3 leaks addr into helper")
+__success __failure_unpriv __msg_unpriv("arg#2 leaks addr into helper")
 __retval(0)
 __naked void pass_pointer_to_tail_call(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/to=
ols/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 4b392c6c8fc4..b3e34c9c30a3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -46,7 +46,7 @@ int BPF_PROG(get_task_exe_file_kfunc_fp)
 }
=20
 SEC("lsm.s/file_open")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("arg#0 must be referenced or trusted")
 int BPF_PROG(get_task_exe_file_kfunc_untrusted)
 {
 	struct file *acquired;
@@ -98,7 +98,7 @@ int BPF_PROG(path_d_path_kfunc_null)
 }
=20
 SEC("lsm.s/task_alloc")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("arg#0 must be referenced or trusted")
 int BPF_PROG(path_d_path_kfunc_untrusted_from_argument, struct task_stru=
ct *task)
 {
 	struct path *root;
@@ -112,7 +112,7 @@ int BPF_PROG(path_d_path_kfunc_untrusted_from_argumen=
t, struct task_struct *task
 }
=20
 SEC("lsm.s/file_open")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("arg#0 must be referenced or trusted")
 int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
 {
 	struct path *pwd;
@@ -128,7 +128,7 @@ int BPF_PROG(path_d_path_kfunc_untrusted_from_current=
)
 }
=20
 SEC("lsm.s/file_open")
-__failure __msg("kernel function bpf_path_d_path args#0 expected pointer=
 to STRUCT path but R1 has a pointer to STRUCT file")
+__failure __msg("kernel function bpf_path_d_path args#0 expected pointer=
 to STRUCT path but has a pointer to STRUCT file")
 int BPF_PROG(path_d_path_kfunc_type_mismatch, struct file *file)
 {
 	bpf_path_d_path((struct path *)&file->f_task_work, buf, sizeof(buf));
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/test=
ing/selftests/bpf/progs/wq_failures.c
index 3767f5595bbc..15fff10b6892 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -48,7 +48,7 @@ __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __failure
 __msg(": (85) call bpf_wq_init#") /* anchor message */
-__msg("pointer in R2 isn't map pointer")
+__msg("pointer in arg#1 isn't map pointer")
 long test_wq_init_nomap(void *ctx)
 {
 	struct bpf_wq *wq;
@@ -147,7 +147,7 @@ SEC("tc")
 __log_level(2)
 __failure
 __msg(": (85) call bpf_wq_init#")
-__msg("R1 doesn't have constant offset. bpf_wq has to be at the constant=
 offset")
+__msg("arg#0 doesn't have constant offset. bpf_wq has to be at the const=
ant offset")
 long test_bad_wq_off(void *ctx)
 {
 	struct elem *val;
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing=
/selftests/bpf/verifier/calls.c
index c3164b9b2be5..fdcbaf3193d4 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -132,7 +132,7 @@
 	},
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.result =3D REJECT,
-	.errstr =3D "R1 must have zero offset when passed to release func",
+	.errstr =3D "arg#0 must have zero offset when passed to release func",
 	.fixup_kfunc_btf_id =3D {
 		{ "bpf_kfunc_call_test_acquire", 3 },
 		{ "bpf_kfunc_call_memb_release", 8 },
@@ -220,7 +220,7 @@
 	},
 	.result_unpriv =3D REJECT,
 	.result =3D REJECT,
-	.errstr =3D "R1 must have zero offset when passed to release func or tr=
usted arg to kfunc",
+	.errstr =3D "arg#0 must have zero offset when passed to release func or=
 trusted arg to kfunc",
 },
 {
 	"calls: invalid kfunc call: referenced arg needs refcounted PTR_TO_BTF_=
ID",
@@ -247,7 +247,7 @@
 	},
 	.result_unpriv =3D REJECT,
 	.result =3D REJECT,
-	.errstr =3D "R1 must be",
+	.errstr =3D "arg#0 must be",
 },
 {
 	"calls: valid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID=
",
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/test=
ing/selftests/bpf/verifier/map_kptr.c
index 4b39f8472f9b..bfb3835bb68b 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -100,7 +100,7 @@
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr =3D { 1 },
 	.result =3D REJECT,
-	.errstr =3D "R1 doesn't have constant offset. kptr has to be at the con=
stant offset",
+	.errstr =3D "arg#0 doesn't have constant offset. kptr has to be at the =
constant offset",
 },
 {
 	"map_kptr: unaligned boundary load/store",
@@ -176,7 +176,7 @@
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr =3D { 1 },
 	.result =3D REJECT,
-	.errstr =3D "invalid kptr access, R1 type=3Duntrusted_ptr_prog_test_ref=
_kfunc expected=3Dptr_prog_test",
+	.errstr =3D "invalid kptr access, arg#0 type=3Duntrusted_ptr_prog_test_=
ref_kfunc expected=3Dptr_prog_test",
 },
 {
 	"map_kptr: unref: loaded pointer marked as untrusted",
@@ -244,7 +244,7 @@
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr =3D { 1 },
 	.result =3D REJECT,
-	.errstr =3D "R1 type=3Duntrusted_ptr_ expected=3Dpercpu_ptr_",
+	.errstr =3D "arg#0 type=3Duntrusted_ptr_ expected=3Dpercpu_ptr_",
 },
 {
 	"map_kptr: unref: no reference state created",
@@ -311,7 +311,7 @@
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr =3D { 1 },
 	.result =3D REJECT,
-	.errstr =3D "R1 type=3Drcu_ptr_or_null_ expected=3Dpercpu_ptr_",
+	.errstr =3D "arg#0 type=3Drcu_ptr_or_null_ expected=3Dpercpu_ptr_",
 },
 {
 	"map_kptr: ref: reject off !=3D 0",
@@ -342,7 +342,7 @@
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr =3D { 1 },
 	.result =3D REJECT,
-	.errstr =3D "invalid kptr access, R2 type=3Dptr_prog_test_ref_kfunc exp=
ected=3Dptr_prog_test_member",
+	.errstr =3D "invalid kptr access, arg#1 type=3Dptr_prog_test_ref_kfunc =
expected=3Dptr_prog_test_member",
 },
 {
 	"map_kptr: ref: reference state created and released on xchg",
--=20
2.52.0

