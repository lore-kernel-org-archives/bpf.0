Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24BD364053
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969940; cv=none; b=gKw8eJVfIGo9T1ae0Taqyh3R4fgzinWoobCdidDo3OYfCkWBEXXrWEerj0/NBLX9WyZ+jDvguq5liFWbK3IXMyprr94iVHVsRbFeYVa4yasNN5M/5S4HG8XzZrQEfw6jos68qNfBATfmg4HpfBuIfhHucewk7gPSiL13kUbJ3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969940; c=relaxed/simple;
	bh=8/7xW6H/Qz6nSF+OnD1TATcuA0rsEi9xaWUE723C4uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMtitL7OTTrO+iqvJbw2fwUqLEyo8A8I84PMjDSbOCRIIjBAbvBRTPJe/Eibn5ombsf3FERQylC21Q+rCQRd3GsR/n07GpJnxBxHn6AKwb7QdKKKdNW3vJQB6o4iE2GZ172IpSnbuxV6hR25pPrc2BDcsSlbMWlV8FbTNH4rP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2417E3B0219BD; Sat, 11 Apr 2026 21:58:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 04/18] bpf: Refactor to handle memory and size together
Date: Sat, 11 Apr 2026 21:58:47 -0700
Message-ID: <20260412045847.255351-1-yonghong.song@linux.dev>
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

Similar to the previous patch, try to pass bpf_reg_state from caller
to callee. Both mem_reg and size_reg are passed to helper functions.
This is important for stack arguments as they may be beyond registers 1-5=
.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 56 ++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c67a15c73e1..cddd39ebb40b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8499,12 +8499,12 @@ static int check_stack_range_initialized(
 	return 0;
 }
=20
-static int check_helper_mem_access(struct bpf_verifier_env *env, int reg=
no,
+static int check_helper_mem_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int regno,
 				   int access_size, enum bpf_access_type access_type,
 				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
+	struct bpf_reg_state *regs =3D cur_regs(env);
 	u32 *max_access;
=20
 	switch (base_type(reg->type)) {
@@ -8591,11 +8591,13 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, int regno,
  * containing the pointer.
  */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
-			      struct bpf_reg_state *reg, u32 regno,
+			      struct bpf_reg_state *mem_reg,
+			      struct bpf_reg_state *size_reg, u32 mem_regno,
 			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
+	int size_regno =3D mem_regno + 1;
 	int err;
=20
 	/* This is used to refine r0 return value bounds for helpers
@@ -8606,37 +8608,37 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
 	 * out. Only upper bounds can be learned because retval is an
 	 * int type and negative retvals are allowed.
 	 */
-	meta->msize_max_value =3D reg->umax_value;
+	meta->msize_max_value =3D size_reg->umax_value;
=20
 	/* The register is SCALAR_VALUE; the access check happens using
 	 * its boundaries. For unprivileged variable accesses, disable
 	 * raw mode so that the program is required to initialize all
 	 * the memory that the helper could just partially fill up.
 	 */
-	if (!tnum_is_const(reg->var_off))
+	if (!tnum_is_const(size_reg->var_off))
 		meta =3D NULL;
=20
-	if (reg->smin_value < 0) {
+	if (size_reg->smin_value < 0) {
 		verbose(env, "R%d min value is negative, either use unsigned or 'var &=
=3D const'\n",
-			regno);
+			size_regno);
 		return -EACCES;
 	}
=20
-	if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
+	if (size_reg->umin_value =3D=3D 0 && !zero_size_allowed) {
 		verbose(env, "R%d invalid zero-sized read: u64=3D[%lld,%lld]\n",
-			regno, reg->umin_value, reg->umax_value);
+			size_regno, size_reg->umin_value, size_reg->umax_value);
 		return -EACCES;
 	}
=20
-	if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
+	if (size_reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
 		verbose(env, "R%d unbounded memory access, use 'var &=3D const' or 'if=
 (var < const)'\n",
-			regno);
+			size_regno);
 		return -EACCES;
 	}
-	err =3D check_helper_mem_access(env, regno - 1, reg->umax_value,
+	err =3D check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax=
_value,
 				      access_type, zero_size_allowed, meta);
 	if (!err)
-		err =3D mark_chain_precision(env, regno);
+		err =3D mark_chain_precision(env, size_regno);
 	return err;
 }
=20
@@ -8661,8 +8663,8 @@ static int check_mem_reg(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *reg
=20
 	int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem_size =
: mem_size;
=20
-	err =3D check_helper_mem_access(env, regno, size, BPF_READ, true, NULL)=
;
-	err =3D err ?: check_helper_mem_access(env, regno, size, BPF_WRITE, tru=
e, NULL);
+	err =3D check_helper_mem_access(env, reg, regno, size, BPF_READ, true, =
NULL);
+	err =3D err ?: check_helper_mem_access(env, reg, regno, size, BPF_WRITE=
, true, NULL);
=20
 	if (may_be_null)
 		*reg =3D saved_reg;
@@ -8670,16 +8672,16 @@ static int check_mem_reg(struct bpf_verifier_env =
*env, struct bpf_reg_state *reg
 	return err;
 }
=20
-static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg,
-				    u32 regno)
+static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct=
 bpf_reg_state *mem_reg,
+				    struct bpf_reg_state *size_reg,
+				    u32 mem_regno)
 {
-	struct bpf_reg_state *mem_reg =3D &cur_regs(env)[regno - 1];
 	bool may_be_null =3D type_may_be_null(mem_reg->type);
 	struct bpf_reg_state saved_reg;
 	struct bpf_call_arg_meta meta;
 	int err;
=20
-	WARN_ON_ONCE(regno < BPF_REG_2 || regno > BPF_REG_5);
+	WARN_ON_ONCE(mem_regno > BPF_REG_4);
=20
 	memset(&meta, 0, sizeof(meta));
=20
@@ -8688,8 +8690,8 @@ static int check_kfunc_mem_size_reg(struct bpf_veri=
fier_env *env, struct bpf_reg
 		mark_ptr_not_null_reg(mem_reg);
 	}
=20
-	err =3D check_mem_size_reg(env, reg, regno, BPF_READ, true, &meta);
-	err =3D err ?: check_mem_size_reg(env, reg, regno, BPF_WRITE, true, &me=
ta);
+	err =3D check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_READ,=
 true, &meta);
+	err =3D err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BP=
F_WRITE, true, &meta);
=20
 	if (may_be_null)
 		*mem_reg =3D saved_reg;
@@ -10163,7 +10165,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 			return -EFAULT;
 		}
 		key_size =3D meta->map.ptr->key_size;
-		err =3D check_helper_mem_access(env, regno, key_size, BPF_READ, false,=
 NULL);
+		err =3D check_helper_mem_access(env, reg, regno, key_size, BPF_READ, f=
alse, NULL);
 		if (err)
 			return err;
 		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
@@ -10190,7 +10192,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 			return -EFAULT;
 		}
 		meta->raw_mode =3D arg_type & MEM_UNINIT;
-		err =3D check_helper_mem_access(env, regno, meta->map.ptr->value_size,
+		err =3D check_helper_mem_access(env, reg, regno, meta->map.ptr->value_=
size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta);
 		break;
@@ -10234,7 +10236,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 		 */
 		meta->raw_mode =3D arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err =3D check_helper_mem_access(env, regno, fn->arg_size[arg],
+			err =3D check_helper_mem_access(env, reg, regno, fn->arg_size[arg],
 						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 						      false, meta);
 			if (err)
@@ -10244,13 +10246,13 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
 		}
 		break;
 	case ARG_CONST_SIZE:
-		err =3D check_mem_size_reg(env, reg, regno,
+		err =3D check_mem_size_reg(env, reg_state(env, regno - 1), reg, regno =
- 1,
 					 fn->arg_type[arg - 1] & MEM_WRITE ?
 					 BPF_WRITE : BPF_READ,
 					 false, meta);
 		break;
 	case ARG_CONST_SIZE_OR_ZERO:
-		err =3D check_mem_size_reg(env, reg, regno,
+		err =3D check_mem_size_reg(env, reg_state(env, regno - 1), reg, regno =
- 1,
 					 fn->arg_type[arg - 1] & MEM_WRITE ?
 					 BPF_WRITE : BPF_READ,
 					 true, meta);
@@ -13988,7 +13990,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			const struct btf_param *size_arg =3D &args[i + 1];
=20
 			if (!register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, =
buff_arg)) {
-				ret =3D check_kfunc_mem_size_reg(env, size_reg, regno + 1);
+				ret =3D check_kfunc_mem_size_reg(env, buff_reg, size_reg, regno);
 				if (ret < 0) {
 					verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memor=
y access\n", i, i + 1);
 					return ret;
--=20
2.52.0

