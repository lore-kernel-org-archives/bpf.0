Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BBC493657
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141803; cv=none; b=TkS01XZrRUK40b8lUir1CUPc8V+F6+pCVSUWgWJ6G6JNd/FCtFmqQNy+rBkZutfjGuwxtbaOI3ziveTcBUESI09YHB45ll72OLlcY+ZqdLvDTg8CwaTRQAuZAE8sjsB/SEA+IjE2YpCLfCD0pLDsuWjn/eBN6mrkuWV+J0ltofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141803; c=relaxed/simple;
	bh=JV1OchikxMGDOJV3oLdNh//RdVJ8eh6Yyj1YUythJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzM5c4Ji+DveYdBZyxXa9nNwalpbxI85/d1hGM8spplUUyhr0uoikPn0fAZnF85lqB4DjqCM7eLqVpfGg6Nn0LmNGF2amvoSTZAMuhFVerI4BbCQCpuv0KRPcZtEeGMbglak1Cn9Ny0VdmDGwtNKzN/PUrjJQ2OY8ma5FIn2Okk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DA15B2A1843033; Fri, 11 Sep 2026 08:49:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 07/15] bpf: Rename bpf_call_summary::num_params to arg_slot_cnt
Date: Fri, 11 Sep 2026 08:49:49 -0700
Message-ID: <20260911154949.2008169-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911154914.2004336-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The field 'num_params' counts the argument registers and outgoing
stack slots a helper or kfunc call takes. The next patch gives a
16-byte parameter two slots, so the name stops describing what the
field holds.

Rename 'num_params' to 'arg_slot_cnt'. No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/liveness.c        | 10 +++++-----
 kernel/bpf/verifier.c        |  8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index edb904424aba..64dfa29f6b45 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1066,7 +1066,7 @@ static inline bool bpf_ret_reg_pair(struct bpf_veri=
fier_env *env, int subprog)
 }
=20
 struct bpf_call_summary {
-	u8 num_params;
+	u8 arg_slot_cnt;
 	bool is_void;
 	bool fastcall;
 };
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 7165ea325961..44ecdc5b4ec2 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1434,21 +1434,21 @@ static int record_call_access(struct bpf_verifier=
_env *env,
 {
 	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
 	struct bpf_call_summary cs;
-	int r, err, num_params =3D 5;
+	int r, err, arg_slot_cnt =3D 5;
=20
 	if (bpf_pseudo_call(insn))
 		return 0;
=20
 	if (bpf_get_call_summary(env, insn, &cs))
-		num_params =3D cs.num_params;
+		arg_slot_cnt =3D cs.arg_slot_cnt;
=20
-	for (r =3D BPF_REG_1; r < BPF_REG_1 + min(num_params, MAX_BPF_FUNC_REG_=
ARGS); r++) {
+	for (r =3D BPF_REG_1; r < BPF_REG_1 + min(arg_slot_cnt, MAX_BPF_FUNC_RE=
G_ARGS); r++) {
 		err =3D record_arg_access(env, instance, insn, &at[r], r - 1, insn_idx=
);
 		if (err)
 			return err;
 	}
=20
-	for (r =3D 0; r < MAX_STACK_ARG_SLOTS && r < num_params - MAX_BPF_FUNC_=
REG_ARGS; r++) {
+	for (r =3D 0; r < MAX_STACK_ARG_SLOTS && r < arg_slot_cnt - MAX_BPF_FUN=
C_REG_ARGS; r++) {
 		err =3D record_arg_access(env, instance, insn, &at[MAX_BPF_REG + r],
 					r + MAX_BPF_FUNC_REG_ARGS, insn_idx);
 		if (err)
@@ -2199,7 +2199,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
 			def =3D ALL_CALLER_SAVED_REGS;
 			use =3D def & ~BIT(BPF_REG_0);
 			if (bpf_get_call_summary(env, insn, &cs))
-				use =3D GENMASK(min_t(u8, cs.num_params, MAX_BPF_FUNC_REG_ARGS), 1);
+				use =3D GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1=
);
 			def =3D mask_widen(def);
 			use =3D mask_widen(use);
 			break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 500092a2c924..c520c37bb3c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17973,11 +17973,11 @@ bool bpf_get_call_summary(struct bpf_verifier_e=
nv *env, struct bpf_insn *call,
 			       (bpf_verifier_inlines_helper_call(env, call->imm) ||
 				bpf_jit_inlines_helper_call(call->imm));
 		cs->is_void =3D fn->ret_type =3D=3D RET_VOID;
-		cs->num_params =3D 0;
+		cs->arg_slot_cnt =3D 0;
 		for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
 			if (fn->arg_type[i] =3D=3D ARG_DONTCARE)
 				break;
-			cs->num_params++;
+			cs->arg_slot_cnt++;
 		}
 		return true;
 	}
@@ -17989,7 +17989,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env=
 *env, struct bpf_insn *call,
 		if (err < 0)
 			/* error would be reported later */
 			return false;
-		cs->num_params =3D btf_type_vlen(meta.func_proto);
+		cs->arg_slot_cnt =3D btf_type_vlen(meta.func_proto);
 		cs->fastcall =3D meta.kfunc_flags & KF_FASTCALL;
 		cs->is_void =3D btf_type_is_void(btf_type_by_id(meta.btf, meta.func_pr=
oto->type));
 		return true;
@@ -18098,7 +18098,7 @@ static void mark_fastcall_pattern_for_call(struct=
 bpf_verifier_env *env,
 	 * - includes R1-R5 if corresponding parameter has is described
 	 *   in the function prototype.
 	 */
-	clobbered_regs_mask =3D GENMASK(cs.num_params, cs.is_void ? 1 : 0);
+	clobbered_regs_mask =3D GENMASK(cs.arg_slot_cnt, cs.is_void ? 1 : 0);
 	/* e.g. if helper call clobbers r{0,1}, expect r{2,3,4,5} in the patter=
n */
 	expected_regs_mask =3D ~clobbered_regs_mask & ALL_CALLER_SAVED_REGS;
=20
--=20
2.52.0

