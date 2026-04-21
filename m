Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CA2F3C13
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792001; cv=none; b=O29ot5hmbZVjMIkr+HJ8HEj8XO4BQHe2aL+CNHHPuemYZeuub5CTSZeQAWdVt2wzuf7SnJst1o8gE0yF+Nd0Q7SR2jhhtT60KBAL4qPVmPO8gvGi0NEiGvJSZLe7Om0HJxtflZi41sL15ru1BFwxqaIw6o18EeHxN0s35x04OAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792001; c=relaxed/simple;
	bh=Otro8RXUfA5RVZTyiJrMW58QDLB6E/OppHmFDr+VgnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf1E9BhHQo51IaMp9O3AFsCyGUCRzUMWGRW8xJ/1SscRb7GYsMJjixXgU9Lq3SOu3tyA4aksxHr3LYHmuMng1muwP4a+XxflRe7POXMZM8PdAGjcQXrOOpWoto72L0ZESrxi3r/8AfYsZyIm8N77IJPZXFgRyeLXx/K7/yxGU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 89BD744B27983; Tue, 21 Apr 2026 10:19:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next 4/9] bpf: Refactor to avoid redundant calculation of bpf_reg_state
Date: Tue, 21 Apr 2026 10:19:47 -0700
Message-ID: <20260421171947.3509118-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421171927.3507554-1-yonghong.song@linux.dev>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In many cases, once a bpf_reg_state is defined, it can pass to
callee's. Otherwise, callee will need to get bpf_reg_state again
based on regno. More importantly, this is needed for later stack
arguments for kfuncs since the register state for stack arguments does
not have a corresponding regno. So it makes sense to pass reg state
for callee's.

The following is the only change to avoid compilation warning:
   static int sanitize_check_bounds(struct bpf_verifier_env *env,
                                   const struct bpf_insn *insn,
  -                                const struct bpf_reg_state *dst_reg)
  +                                struct bpf_reg_state *dst_reg)

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 213 ++++++++++++++++++------------------------
 1 file changed, 93 insertions(+), 120 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed04fef49f6c..b56a11fc3856 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3929,13 +3929,13 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
 static int check_stack_write_var_off(struct bpf_verifier_env *env,
 				     /* func where register points to */
 				     struct bpf_func_state *state,
-				     int ptr_regno, int off, int size,
+				     struct bpf_reg_state *ptr_reg, int off, int size,
 				     int value_regno, int insn_idx)
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int min_off, max_off;
 	int i, err;
-	struct bpf_reg_state *ptr_reg =3D NULL, *value_reg =3D NULL;
+	struct bpf_reg_state *value_reg =3D NULL;
 	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
 	bool writing_zero =3D false;
 	/* set if the fact that we're writing a zero is used to let any
@@ -3944,7 +3944,6 @@ static int check_stack_write_var_off(struct bpf_ver=
ifier_env *env,
 	bool zero_used =3D false;
=20
 	cur =3D env->cur_state->frame[env->cur_state->curframe];
-	ptr_reg =3D &cur->regs[ptr_regno];
 	min_off =3D ptr_reg->smin_value + off;
 	max_off =3D ptr_reg->smax_value + off + size;
 	if (value_regno >=3D 0)
@@ -4241,7 +4240,7 @@ enum bpf_access_src {
 	ACCESS_HELPER =3D 2,  /* the access is performed by a helper */
 };
=20
-static int check_stack_range_initialized(struct bpf_verifier_env *env,
+static int check_stack_range_initialized(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg,
 					 int regno, int off, int access_size,
 					 bool zero_size_allowed,
 					 enum bpf_access_type type,
@@ -4265,18 +4264,16 @@ static struct bpf_reg_state *reg_state(struct bpf=
_verifier_env *env, int regno)
  * offset; for a fixed offset check_stack_read_fixed_off should be used
  * instead.
  */
-static int check_stack_read_var_off(struct bpf_verifier_env *env,
+static int check_stack_read_var_off(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg,
 				    int ptr_regno, int off, int size, int dst_regno)
 {
-	/* The state of the source register. */
-	struct bpf_reg_state *reg =3D reg_state(env, ptr_regno);
 	struct bpf_func_state *ptr_state =3D bpf_func(env, reg);
 	int err;
 	int min_off, max_off;
=20
 	/* Note that we pass a NULL meta, so raw access will not be permitted.
 	 */
-	err =3D check_stack_range_initialized(env, ptr_regno, off, size,
+	err =3D check_stack_range_initialized(env, reg, ptr_regno, off, size,
 					    false, BPF_READ, NULL);
 	if (err)
 		return err;
@@ -4298,10 +4295,9 @@ static int check_stack_read_var_off(struct bpf_ver=
ifier_env *env,
  * can be -1, meaning that the read value is not going to a register.
  */
 static int check_stack_read(struct bpf_verifier_env *env,
-			    int ptr_regno, int off, int size,
+			    struct bpf_reg_state *reg, int ptr_regno, int off, int size,
 			    int dst_regno)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, ptr_regno);
 	struct bpf_func_state *state =3D bpf_func(env, reg);
 	int err;
 	/* Some accesses are only permitted with a static offset. */
@@ -4337,7 +4333,7 @@ static int check_stack_read(struct bpf_verifier_env=
 *env,
 		 * than fixed offset ones. Note that dst_regno >=3D 0 on this
 		 * branch.
 		 */
-		err =3D check_stack_read_var_off(env, ptr_regno, off, size,
+		err =3D check_stack_read_var_off(env, reg, ptr_regno, off, size,
 					       dst_regno);
 	}
 	return err;
@@ -4354,10 +4350,9 @@ static int check_stack_read(struct bpf_verifier_en=
v *env,
  * The caller must ensure that the offset falls within the maximum stack=
 size.
  */
 static int check_stack_write(struct bpf_verifier_env *env,
-			     int ptr_regno, int off, int size,
+			     struct bpf_reg_state *reg, int off, int size,
 			     int value_regno, int insn_idx)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, ptr_regno);
 	struct bpf_func_state *state =3D bpf_func(env, reg);
 	int err;
=20
@@ -4370,16 +4365,15 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
 		 * than fixed offset ones.
 		 */
 		err =3D check_stack_write_var_off(env, state,
-						ptr_regno, off, size,
+						reg, off, size,
 						value_regno, insn_idx);
 	}
 	return err;
 }
=20
-static int check_map_access_type(struct bpf_verifier_env *env, u32 regno=
,
+static int check_map_access_type(struct bpf_verifier_env *env, struct bp=
f_reg_state *reg, u32 regno,
 				 int off, int size, enum bpf_access_type type)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	struct bpf_map *map =3D reg->map_ptr;
 	u32 cap =3D bpf_map_flags_to_cap(map);
=20
@@ -4399,17 +4393,15 @@ static int check_map_access_type(struct bpf_verif=
ier_env *env, u32 regno,
 }
=20
 /* check read/write into memory region (e.g., map value, ringbuf sample,=
 etc) */
-static int __check_mem_access(struct bpf_verifier_env *env, int regno,
+static int __check_mem_access(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int regno,
 			      int off, int size, u32 mem_size,
 			      bool zero_size_allowed)
 {
 	bool size_ok =3D size > 0 || (size =3D=3D 0 && zero_size_allowed);
-	struct bpf_reg_state *reg;
=20
 	if (off >=3D 0 && size_ok && (u64)off + size <=3D mem_size)
 		return 0;
=20
-	reg =3D &cur_regs(env)[regno];
 	switch (reg->type) {
 	case PTR_TO_MAP_KEY:
 		verbose(env, "invalid access to map key, key_size=3D%d off=3D%d size=3D=
%d\n",
@@ -4439,13 +4431,10 @@ static int __check_mem_access(struct bpf_verifier=
_env *env, int regno,
 }
=20
 /* check read/write into a memory region with possible variable offset *=
/
-static int check_mem_region_access(struct bpf_verifier_env *env, u32 reg=
no,
+static int check_mem_region_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, u32 regno,
 				   int off, int size, u32 mem_size,
 				   bool zero_size_allowed)
 {
-	struct bpf_verifier_state *vstate =3D env->cur_state;
-	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
-	struct bpf_reg_state *reg =3D &state->regs[regno];
 	int err;
=20
 	/* We may have adjusted the register pointing to memory region, so we
@@ -4466,7 +4455,7 @@ static int check_mem_region_access(struct bpf_verif=
ier_env *env, u32 regno,
 			regno);
 		return -EACCES;
 	}
-	err =3D __check_mem_access(env, regno, reg->smin_value + off, size,
+	err =3D __check_mem_access(env, reg, regno, reg->smin_value + off, size=
,
 				 mem_size, zero_size_allowed);
 	if (err) {
 		verbose(env, "R%d min value is outside of the allowed memory range\n",
@@ -4483,7 +4472,7 @@ static int check_mem_region_access(struct bpf_verif=
ier_env *env, u32 regno,
 			regno);
 		return -EACCES;
 	}
-	err =3D __check_mem_access(env, regno, reg->umax_value + off, size,
+	err =3D __check_mem_access(env, reg, regno, reg->umax_value + off, size=
,
 				 mem_size, zero_size_allowed);
 	if (err) {
 		verbose(env, "R%d max value is outside of the allowed memory range\n",
@@ -4787,19 +4776,16 @@ static u32 map_mem_size(const struct bpf_map *map=
)
 }
=20
 /* check read/write into a map element with possible variable offset */
-static int check_map_access(struct bpf_verifier_env *env, u32 regno,
+static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, u32 regno,
 			    int off, int size, bool zero_size_allowed,
 			    enum bpf_access_src src)
 {
-	struct bpf_verifier_state *vstate =3D env->cur_state;
-	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
-	struct bpf_reg_state *reg =3D &state->regs[regno];
 	struct bpf_map *map =3D reg->map_ptr;
 	u32 mem_size =3D map_mem_size(map);
 	struct btf_record *rec;
 	int err, i;
=20
-	err =3D check_mem_region_access(env, regno, off, size, mem_size, zero_s=
ize_allowed);
+	err =3D check_mem_region_access(env, reg, regno, off, size, mem_size, z=
ero_size_allowed);
 	if (err)
 		return err;
=20
@@ -4895,10 +4881,9 @@ static bool may_access_direct_pkt_data(struct bpf_=
verifier_env *env,
 	}
 }
=20
-static int check_packet_access(struct bpf_verifier_env *env, u32 regno, =
int off,
+static int check_packet_access(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, u32 regno, int off,
 			       int size, bool zero_size_allowed)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	int err;
=20
 	if (reg->range < 0) {
@@ -4906,7 +4891,7 @@ static int check_packet_access(struct bpf_verifier_=
env *env, u32 regno, int off,
 		return -EINVAL;
 	}
=20
-	err =3D check_mem_region_access(env, regno, off, size, reg->range, zero=
_size_allowed);
+	err =3D check_mem_region_access(env, reg, regno, off, size, reg->range,=
 zero_size_allowed);
 	if (err)
 		return err;
=20
@@ -4961,7 +4946,7 @@ static int __check_ctx_access(struct bpf_verifier_e=
nv *env, int insn_idx, int of
 	return -EACCES;
 }
=20
-static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
u32 regno,
+static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 regno,
 			    int off, int access_size, enum bpf_access_type t,
 			    struct bpf_insn_access_aux *info)
 {
@@ -4971,12 +4956,10 @@ static int check_ctx_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
 	 */
 	bool var_off_ok =3D is_var_ctx_off_allowed(env->prog);
 	bool fixed_off_ok =3D !env->ops->convert_ctx_access;
-	struct bpf_reg_state *regs =3D cur_regs(env);
-	struct bpf_reg_state *reg =3D regs + regno;
 	int err;
=20
 	if (var_off_ok)
-		err =3D check_mem_region_access(env, regno, off, access_size, U16_MAX,=
 false);
+		err =3D check_mem_region_access(env, reg, regno, off, access_size, U16=
_MAX, false);
 	else
 		err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 	if (err)
@@ -5002,10 +4985,9 @@ static int check_flow_keys_access(struct bpf_verif=
ier_env *env, int off,
 }
=20
 static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
-			     u32 regno, int off, int size,
+			     struct bpf_reg_state *reg, u32 regno, int off, int size,
 			     enum bpf_access_type t)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	struct bpf_insn_access_aux info =3D {};
 	bool valid;
=20
@@ -5971,12 +5953,11 @@ static bool type_is_trusted_or_null(struct bpf_ve=
rifier_env *env,
 }
=20
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
-				   struct bpf_reg_state *regs,
+				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
 				   int regno, int off, int size,
 				   enum bpf_access_type atype,
 				   int value_regno)
 {
-	struct bpf_reg_state *reg =3D regs + regno;
 	const struct btf_type *t =3D btf_type_by_id(reg->btf, reg->btf_id);
 	const char *tname =3D btf_name_by_offset(reg->btf, t->name_off);
 	const char *field_name =3D NULL;
@@ -6128,12 +6109,11 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
 }
=20
 static int check_ptr_to_map_access(struct bpf_verifier_env *env,
-				   struct bpf_reg_state *regs,
+				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
 				   int regno, int off, int size,
 				   enum bpf_access_type atype,
 				   int value_regno)
 {
-	struct bpf_reg_state *reg =3D regs + regno;
 	struct bpf_map *map =3D reg->map_ptr;
 	struct bpf_reg_state map_reg;
 	enum bpf_type_flag flag =3D 0;
@@ -6222,11 +6202,10 @@ static int check_stack_slot_within_bounds(struct =
bpf_verifier_env *env,
  * 'off' includes `regno->offset`, but not its dynamic part (if any).
  */
 static int check_stack_access_within_bounds(
-		struct bpf_verifier_env *env,
+		struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		int regno, int off, int access_size,
 		enum bpf_access_type type)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	struct bpf_func_state *state =3D bpf_func(env, reg);
 	s64 min_off, max_off;
 	int err;
@@ -6314,12 +6293,11 @@ static void add_scalar_to_reg(struct bpf_reg_stat=
e *dst_reg, s64 val)
  * if t=3D=3Dwrite && value_regno=3D=3D-1, some unknown value is stored =
into memory
  * if t=3D=3Dread && value_regno=3D=3D-1, don't care what we read from m=
emory
  */
-static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
u32 regno,
+static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 regno,
 			    int off, int bpf_size, enum bpf_access_type t,
 			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
 	struct bpf_reg_state *regs =3D cur_regs(env);
-	struct bpf_reg_state *reg =3D regs + regno;
 	int size, err =3D 0;
=20
 	size =3D bpf_size_to_bytes(bpf_size);
@@ -6336,7 +6314,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
=20
-		err =3D check_mem_region_access(env, regno, off, size,
+		err =3D check_mem_region_access(env, reg, regno, off, size,
 					      reg->map_ptr->key_size, false);
 		if (err)
 			return err;
@@ -6350,10 +6328,10 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
 			verbose(env, "R%d leaks addr into map\n", value_regno);
 			return -EACCES;
 		}
-		err =3D check_map_access_type(env, regno, off, size, t);
+		err =3D check_map_access_type(env, reg, regno, off, size, t);
 		if (err)
 			return err;
-		err =3D check_map_access(env, regno, off, size, false, ACCESS_DIRECT);
+		err =3D check_map_access(env, reg, regno, off, size, false, ACCESS_DIR=
ECT);
 		if (err)
 			return err;
 		if (tnum_is_const(reg->var_off))
@@ -6422,7 +6400,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		 * instructions, hence no need to check bounds in that case.
 		 */
 		if (!rdonly_untrusted)
-			err =3D check_mem_region_access(env, regno, off, size,
+			err =3D check_mem_region_access(env, reg, regno, off, size,
 						      reg->mem_size, false);
 		if (!err && value_regno >=3D 0 && (t =3D=3D BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
@@ -6440,7 +6418,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
=20
-		err =3D check_ctx_access(env, insn_idx, regno, off, size, t, &info);
+		err =3D check_ctx_access(env, insn_idx, reg, regno, off, size, t, &inf=
o);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
 			/* ctx access returns either a scalar, or a
 			 * PTR_TO_PACKET[_META,_END]. In the latter
@@ -6477,15 +6455,15 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
=20
 	} else if (reg->type =3D=3D PTR_TO_STACK) {
 		/* Basic bounds checks. */
-		err =3D check_stack_access_within_bounds(env, regno, off, size, t);
+		err =3D check_stack_access_within_bounds(env, reg, regno, off, size, t=
);
 		if (err)
 			return err;
=20
 		if (t =3D=3D BPF_READ)
-			err =3D check_stack_read(env, regno, off, size,
+			err =3D check_stack_read(env, reg, regno, off, size,
 					       value_regno);
 		else
-			err =3D check_stack_write(env, regno, off, size,
+			err =3D check_stack_write(env, reg, off, size,
 						value_regno, insn_idx);
 	} else if (reg_is_pkt_pointer(reg)) {
 		if (t =3D=3D BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
@@ -6498,7 +6476,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 				value_regno);
 			return -EACCES;
 		}
-		err =3D check_packet_access(env, regno, off, size, false);
+		err =3D check_packet_access(env, reg, regno, off, size, false);
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type =3D=3D PTR_TO_FLOW_KEYS) {
@@ -6518,7 +6496,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 				regno, reg_type_str(env, reg->type));
 			return -EACCES;
 		}
-		err =3D check_sock_access(env, insn_idx, regno, off, size, t);
+		err =3D check_sock_access(env, insn_idx, reg, regno, off, size, t);
 		if (!err && value_regno >=3D 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type =3D=3D PTR_TO_TP_BUFFER) {
@@ -6527,10 +6505,10 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID &&
 		   !type_may_be_null(reg->type)) {
-		err =3D check_ptr_to_btf_access(env, regs, regno, off, size, t,
+		err =3D check_ptr_to_btf_access(env, regs, reg, regno, off, size, t,
 					      value_regno);
 	} else if (reg->type =3D=3D CONST_PTR_TO_MAP) {
-		err =3D check_ptr_to_map_access(env, regs, regno, off, size, t,
+		err =3D check_ptr_to_map_access(env, regs, reg, regno, off, size, t,
 					      value_regno);
 	} else if (base_type(reg->type) =3D=3D PTR_TO_BUF &&
 		   !type_may_be_null(reg->type)) {
@@ -6599,7 +6577,7 @@ static int check_load_mem(struct bpf_verifier_env *=
env, struct bpf_insn *insn,
 	/* Check if (src_reg + off) is readable. The state of dst_reg will be
 	 * updated by this call.
 	 */
-	err =3D check_mem_access(env, env->insn_idx, insn->src_reg, insn->off,
+	err =3D check_mem_access(env, env->insn_idx, regs + insn->src_reg, insn=
->src_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
 			       strict_alignment_once, is_ldsx);
 	err =3D err ?: save_aux_ptr_type(env, src_reg_type,
@@ -6629,7 +6607,7 @@ static int check_store_reg(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 	dst_reg_type =3D regs[insn->dst_reg].type;
=20
 	/* Check if (dst_reg + off) is writeable. */
-	err =3D check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
+	err =3D check_mem_access(env, env->insn_idx, regs + insn->dst_reg, insn=
->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
 			       strict_alignment_once, false);
 	err =3D err ?: save_aux_ptr_type(env, dst_reg_type, false);
@@ -6640,6 +6618,7 @@ static int check_store_reg(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
 static int check_atomic_rmw(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn)
 {
+	struct bpf_reg_state *dst_reg;
 	int load_reg;
 	int err;
=20
@@ -6701,13 +6680,15 @@ static int check_atomic_rmw(struct bpf_verifier_e=
nv *env,
 		load_reg =3D -1;
 	}
=20
+	dst_reg =3D cur_regs(env) + insn->dst_reg;
+
 	/* Check whether we can read the memory, with second call for fetch
 	 * case to simulate the register fill.
 	 */
-	err =3D check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
+	err =3D check_mem_access(env, env->insn_idx, dst_reg, insn->dst_reg, in=
sn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
 	if (!err && load_reg >=3D 0)
-		err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
+		err =3D check_mem_access(env, env->insn_idx, dst_reg, insn->dst_reg,
 				       insn->off, BPF_SIZE(insn->code),
 				       BPF_READ, load_reg, true, false);
 	if (err)
@@ -6719,7 +6700,7 @@ static int check_atomic_rmw(struct bpf_verifier_env=
 *env,
 			return err;
 	}
 	/* Check whether we can write into the same memory. */
-	err =3D check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
+	err =3D check_mem_access(env, env->insn_idx, dst_reg, insn->dst_reg, in=
sn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
@@ -6808,11 +6789,10 @@ static int check_atomic(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
  * read offsets are marked as read.
  */
 static int check_stack_range_initialized(
-		struct bpf_verifier_env *env, int regno, int off,
+		struct bpf_verifier_env *env, struct bpf_reg_state *reg, int regno, in=
t off,
 		int access_size, bool zero_size_allowed,
 		enum bpf_access_type type, struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	struct bpf_func_state *state =3D bpf_func(env, reg);
 	int err, min_off, max_off, i, j, slot, spi;
 	/* Some accesses can write anything into the stack, others are
@@ -6834,7 +6814,7 @@ static int check_stack_range_initialized(
 		return -EACCES;
 	}
=20
-	err =3D check_stack_access_within_bounds(env, regno, off, access_size, =
type);
+	err =3D check_stack_access_within_bounds(env, reg, regno, off, access_s=
ize, type);
 	if (err)
 		return err;
=20
@@ -6965,7 +6945,7 @@ static int check_helper_mem_access(struct bpf_verif=
ier_env *env, int regno,
 	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
-		return check_packet_access(env, regno, 0, access_size,
+		return check_packet_access(env, reg, regno, 0, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
 		if (access_type =3D=3D BPF_WRITE) {
@@ -6973,12 +6953,12 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, int regno,
 				reg_type_str(env, reg->type));
 			return -EACCES;
 		}
-		return check_mem_region_access(env, regno, 0, access_size,
+		return check_mem_region_access(env, reg, regno, 0, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access_type(env, regno, 0, access_size, access_type))
+		if (check_map_access_type(env, reg, regno, 0, access_size, access_type=
))
 			return -EACCES;
-		return check_map_access(env, regno, 0, access_size,
+		return check_map_access(env, reg, regno, 0, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
@@ -6988,7 +6968,7 @@ static int check_helper_mem_access(struct bpf_verif=
ier_env *env, int regno,
 				return -EACCES;
 			}
 		}
-		return check_mem_region_access(env, regno, 0,
+		return check_mem_region_access(env, reg, regno, 0,
 					       access_size, reg->mem_size,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
@@ -7008,16 +6988,16 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, int regno,
 					   max_access);
 	case PTR_TO_STACK:
 		return check_stack_range_initialized(
-				env,
+				env, reg,
 				regno, 0, access_size,
 				zero_size_allowed, access_type, meta);
 	case PTR_TO_BTF_ID:
-		return check_ptr_to_btf_access(env, regs, regno, 0,
+		return check_ptr_to_btf_access(env, regs, reg, regno, 0,
 					       access_size, BPF_READ, -1);
 	case PTR_TO_CTX:
 		/* Only permit reading or writing syscall context using helper calls. =
*/
 		if (is_var_ctx_off_allowed(env->prog)) {
-			int err =3D check_mem_region_access(env, regno, 0, access_size, U16_M=
AX,
+			int err =3D check_mem_region_access(env, reg, regno, 0, access_size, =
U16_MAX,
 							  zero_size_allowed);
 			if (err)
 				return err;
@@ -7178,11 +7158,10 @@ enum {
  * env->cur_state->active_locks remembers which map value element or all=
ocated
  * object got locked and clears it after bpf_spin_unlock.
  */
-static int process_spin_lock(struct bpf_verifier_env *env, int regno, in=
t flags)
+static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg, int regno, int flags)
 {
 	bool is_lock =3D flags & PROCESS_SPIN_LOCK, is_res_lock =3D flags & PRO=
CESS_RES_LOCK;
 	const char *lock_str =3D is_res_lock ? "bpf_res_spin" : "bpf_spin";
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	struct bpf_verifier_state *cur =3D env->cur_state;
 	bool is_const =3D tnum_is_const(reg->var_off);
 	bool is_irq =3D flags & PROCESS_LOCK_IRQ;
@@ -7295,11 +7274,10 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno, int flags)
 }
=20
 /* Check if @regno is a pointer to a specific field in a map value */
-static int check_map_field_pointer(struct bpf_verifier_env *env, u32 reg=
no,
+static int check_map_field_pointer(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, u32 regno,
 				   enum btf_field_type field_type,
 				   struct bpf_map_desc *map_desc)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	bool is_const =3D tnum_is_const(reg->var_off);
 	struct bpf_map *map =3D reg->map_ptr;
 	u64 val =3D reg->var_off.value;
@@ -7349,26 +7327,26 @@ static int check_map_field_pointer(struct bpf_ver=
ifier_env *env, u32 regno,
 	return 0;
 }
=20
-static int process_timer_func(struct bpf_verifier_env *env, int regno,
+static int process_timer_func(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg, int regno,
 			      struct bpf_map_desc *map)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
-	return check_map_field_pointer(env, regno, BPF_TIMER, map);
+	return check_map_field_pointer(env, reg, regno, BPF_TIMER, map);
 }
=20
-static int process_timer_helper(struct bpf_verifier_env *env, int regno,
+static int process_timer_helper(struct bpf_verifier_env *env, struct bpf=
_reg_state *reg, int regno,
 				struct bpf_call_arg_meta *meta)
 {
-	return process_timer_func(env, regno, &meta->map);
+	return process_timer_func(env, reg, regno, &meta->map);
 }
=20
-static int process_timer_kfunc(struct bpf_verifier_env *env, int regno,
+static int process_timer_kfunc(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int regno,
 			       struct bpf_kfunc_call_arg_meta *meta)
 {
-	return process_timer_func(env, regno, &meta->map);
+	return process_timer_func(env, reg, regno, &meta->map);
 }
=20
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
@@ -7433,10 +7411,9 @@ static int process_kptr_func(struct bpf_verifier_e=
nv *env, int regno,
  * use case. The second level is tracked using the upper bit of bpf_dynp=
tr->size
  * and checked dynamically during runtime.
  */
-static int process_dynptr_func(struct bpf_verifier_env *env, int regno, =
int insn_idx,
+static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int regno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	int err;
=20
 	if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DYNPTR) =
{
@@ -7470,7 +7447,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, int regno, int insn
=20
 		/* we write BPF_DW bits (8 bytes) at a time */
 		for (i =3D 0; i < BPF_DYNPTR_SIZE; i +=3D 8) {
-			err =3D check_mem_access(env, insn_idx, regno,
+			err =3D check_mem_access(env, insn_idx, reg, regno,
 					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
@@ -7540,10 +7517,9 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_cal=
l_arg_meta *meta, int arg_idx,
 	return btf_param_match_suffix(meta->btf, arg, "__iter");
 }
=20
-static int process_iter_arg(struct bpf_verifier_env *env, int regno, int=
 insn_idx,
+static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int regno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
=20
@@ -7575,7 +7551,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
 		}
=20
 		for (i =3D 0; i < nr_slots * 8; i +=3D BPF_REG_SIZE) {
-			err =3D check_mem_access(env, insn_idx, regno,
+			err =3D check_mem_access(env, insn_idx, reg, regno,
 					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
@@ -8014,12 +7990,11 @@ static const struct bpf_reg_types *compatible_reg=
_types[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_DYNPTR]		=3D &dynptr_types,
 };
=20
-static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
+static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_s=
tate *reg, u32 regno,
 			  enum bpf_arg_type arg_type,
 			  const u32 *arg_btf_id,
 			  struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	enum bpf_reg_type expected, type =3D reg->type;
 	const struct bpf_reg_types *compatible;
 	int i, j, err;
@@ -8362,7 +8337,7 @@ static int check_reg_const_str(struct bpf_verifier_=
env *env,
 		return -EACCES;
 	}
=20
-	err =3D check_map_access(env, regno, 0,
+	err =3D check_map_access(env, reg, regno, 0,
 			       map->value_size - reg->var_off.value, false,
 			       ACCESS_HELPER);
 	if (err)
@@ -8498,7 +8473,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 	    base_type(arg_type) =3D=3D ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id =3D fn->arg_btf_id[arg];
=20
-	err =3D check_reg_type(env, regno, arg_type, arg_btf_id, meta);
+	err =3D check_reg_type(env, reg, regno, arg_type, arg_btf_id, meta);
 	if (err)
 		return err;
=20
@@ -8636,11 +8611,11 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 			return -EACCES;
 		}
 		if (meta->func_id =3D=3D BPF_FUNC_spin_lock) {
-			err =3D process_spin_lock(env, regno, PROCESS_SPIN_LOCK);
+			err =3D process_spin_lock(env, reg, regno, PROCESS_SPIN_LOCK);
 			if (err)
 				return err;
 		} else if (meta->func_id =3D=3D BPF_FUNC_spin_unlock) {
-			err =3D process_spin_lock(env, regno, 0);
+			err =3D process_spin_lock(env, reg, regno, 0);
 			if (err)
 				return err;
 		} else {
@@ -8649,7 +8624,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err =3D process_timer_helper(env, regno, meta);
+		err =3D process_timer_helper(env, reg, regno, meta);
 		if (err)
 			return err;
 		break;
@@ -8684,7 +8659,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err =3D process_dynptr_func(env, regno, insn_idx, arg_type, 0);
+		err =3D process_dynptr_func(env, reg, regno, insn_idx, arg_type, 0);
 		if (err)
 			return err;
 		break;
@@ -9343,7 +9318,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 			if (ret)
 				return ret;
=20
-			ret =3D process_dynptr_func(env, regno, -1, arg->arg_type, 0);
+			ret =3D process_dynptr_func(env, reg, regno, -1, arg->arg_type, 0);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
@@ -9354,7 +9329,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 				continue;
=20
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
-			err =3D check_reg_type(env, regno, arg->arg_type, &arg->btf_id, &meta=
);
+			err =3D check_reg_type(env, reg, regno, arg->arg_type, &arg->btf_id, =
&meta);
 			err =3D err ?: check_func_arg_reg_off(env, reg, regno, arg->arg_type)=
;
 			if (err)
 				return err;
@@ -10312,18 +10287,18 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
 	if (err)
 		return err;
=20
+	regs =3D cur_regs(env);
+
 	/* Mark slots with STACK_MISC in case of raw mode, stack offset
 	 * is inferred from register state.
 	 */
 	for (i =3D 0; i < meta.access_size; i++) {
-		err =3D check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
+		err =3D check_mem_access(env, insn_idx, regs + meta.regno, meta.regno,=
 i, BPF_B,
 				       BPF_WRITE, -1, false, false);
 		if (err)
 			return err;
 	}
=20
-	regs =3D cur_regs(env);
-
 	if (meta.release_regno) {
 		err =3D -EINVAL;
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) =
{
@@ -11327,11 +11302,10 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env,
 		       struct bpf_kfunc_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
-		       int argno, int nargs)
+		       int argno, int nargs, struct bpf_reg_state *reg)
 {
 	u32 regno =3D argno + 1;
 	struct bpf_reg_state *regs =3D cur_regs(env);
-	struct bpf_reg_state *reg =3D &regs[regno];
 	bool arg_mem_size =3D false;
=20
 	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
@@ -11498,10 +11472,9 @@ static int process_kf_arg_ptr_to_btf_id(struct b=
pf_verifier_env *env,
 	return 0;
 }
=20
-static int process_irq_flag(struct bpf_verifier_env *env, int regno,
+static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int regno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	int err, kfunc_class =3D IRQ_NATIVE_KFUNC;
 	bool irq_save;
=20
@@ -11526,7 +11499,7 @@ static int process_irq_flag(struct bpf_verifier_e=
nv *env, int regno,
 			return -EINVAL;
 		}
=20
-		err =3D check_mem_access(env, env->insn_idx, regno, 0, BPF_DW, BPF_WRI=
TE, -1, false, false);
+		err =3D check_mem_access(env, env->insn_idx, reg, regno, 0, BPF_DW, BP=
F_WRITE, -1, false, false);
 		if (err)
 			return err;
=20
@@ -12114,7 +12087,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
=20
-		kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,=
 args, i, nargs);
+		kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,=
 args, i, nargs, reg);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
=20
@@ -12276,7 +12249,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				}
 			}
=20
-			ret =3D process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, cl=
one_ref_obj_id);
+			ret =3D process_dynptr_func(env, reg, regno, insn_idx, dynptr_arg_typ=
e, clone_ref_obj_id);
 			if (ret < 0)
 				return ret;
=20
@@ -12301,7 +12274,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
-			ret =3D process_iter_arg(env, regno, insn_idx, meta);
+			ret =3D process_iter_arg(env, reg, regno, insn_idx, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12478,7 +12451,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret =3D check_map_field_pointer(env, regno, BPF_WORKQUEUE, &meta->map=
);
+			ret =3D check_map_field_pointer(env, reg, regno, BPF_WORKQUEUE, &meta=
->map);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12487,7 +12460,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret =3D process_timer_kfunc(env, regno, meta);
+			ret =3D process_timer_kfunc(env, reg, regno, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12496,7 +12469,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to a map value\n", i);
 				return -EINVAL;
 			}
-			ret =3D check_map_field_pointer(env, regno, BPF_TASK_WORK, &meta->map=
);
+			ret =3D check_map_field_pointer(env, reg, regno, BPF_TASK_WORK, &meta=
->map);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12505,7 +12478,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to an irq flag on stack\n", i);
 				return -EINVAL;
 			}
-			ret =3D process_irq_flag(env, regno, meta);
+			ret =3D process_irq_flag(env, reg, regno, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12526,7 +12499,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqs=
ave] ||
 			    meta->func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock_ir=
qrestore])
 				flags |=3D PROCESS_LOCK_IRQ;
-			ret =3D process_spin_lock(env, regno, flags);
+			ret =3D process_spin_lock(env, reg, regno, flags);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13660,7 +13633,7 @@ static int check_stack_access_for_ptr_arithmetic(
=20
 static int sanitize_check_bounds(struct bpf_verifier_env *env,
 				 const struct bpf_insn *insn,
-				 const struct bpf_reg_state *dst_reg)
+				 struct bpf_reg_state *dst_reg)
 {
 	u32 dst =3D insn->dst_reg;
=20
@@ -13677,7 +13650,7 @@ static int sanitize_check_bounds(struct bpf_verif=
ier_env *env,
 			return -EACCES;
 		break;
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access(env, dst, 0, 1, false, ACCESS_HELPER)) {
+		if (check_map_access(env, dst_reg, dst, 0, 1, false, ACCESS_HELPER)) {
 			verbose(env, "R%d pointer arithmetic of map value goes out of range, =
"
 				"prohibited for !root\n", dst);
 			return -EACCES;
@@ -17563,7 +17536,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
=20
 		dst_reg_type =3D cur_regs(env)[insn->dst_reg].type;
=20
-		err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
+		err =3D check_mem_access(env, env->insn_idx, cur_regs(env) + insn->dst=
_reg, insn->dst_reg,
 				       insn->off, BPF_SIZE(insn->code),
 				       BPF_WRITE, -1, false, false);
 		if (err)
--=20
2.52.0

