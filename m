Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6253234964
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787189979; cv=none; b=hSu3gUBimpIj61vQFr6u6TNcdib3YTxGaRIzYlnnUAVFqzI5bTmAdp7uHKQvEsiKklxS9FrN15zmM0PKJ3ZrZ8xM0Cleub51s/RGGWicqoiUaLC68QrbYaeGH/MvWnnHHNwuZaVR0SE3F1iJ0qUSxeiqK8Ko6IU0A4mCVOJJSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787189979; c=relaxed/simple;
	bh=4mf+tyaToZYXSgQ7BdHDY4OYxALc6HdAIjIyAfYYZVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naw4GvhtoK+rYRdWWdQN8UFkLozZ5yfVebwLBeuMpI3s9FkOAsN0pWY672Z5txRYrUzoP6Jssm+CuRUzTEaHjzSNgFBSj/ymLKvtPxRHeezZlYSsGsQl4a+rUVREiOI3E+7WlTFELJ9uY3YwlhTPbjoKid7Oey1gRfdQFdF24pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8A447253858F07; Wed, 19 Aug 2026 18:39:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Track linked scalars across a "rX <<= 32; rX >>= 32" zero extension
Date: Wed, 19 Aug 2026 18:39:25 -0700
Message-ID: <20260820013925.2515018-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For the following test in
tools/testing/selftests/bpf/progs/verifier_linked_scalars.c:

	void alu32_negative_offset(void)
	{
		volatile char path[5];
		volatile int offset =3D bpf_get_prandom_u32();
		int off =3D offset;

		if (off >=3D 5 && off < 10)
			path[off - 5] =3D '.';

		/* So compiler doesn't say: error: variable 'path' set but not used */
		__sink(path[0]);
	}

Without alu32 (-mcpu=3Dv2), the test
verifier_linked_scalars/alu32_negative_offset will fail with llvm22 and
llvm23 like below.

  3: (bf) r2 =3D r1               ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(i=
d=3D1,...)
  4: (07) r2 +=3D -5              ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=3D=
0xfffffffa)
  5: (67) r2 <<=3D 32             ; R2=3Dscalar(smax=3D0x7fffffff00000000=
,...)
  6: (77) r2 >>=3D 32             ; R2=3Dscalar(smin=3D0,umax=3D0xfffffff=
f,...)
  7: (25) if r2 > 0x4 goto pc+5 ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D4,..=
.)
  8: (bf) r2 =3D r10
  9: (07) r2 +=3D -5
 10: (0f) r2 +=3D r1              ; R1=3Dscalar(id=3D1,smin=3D0,umax=3D0x=
ffffffff)
                                ; R2=3Dfp(smin=3D-5,smax=3D0xfffffffa)
 11: (b7) r1 =3D 46               ; R1=3D46
 12: (73) *(u8 *)(r2 -5) =3D r1
 invalid unbounded variable-offset write to stack R2

R1 is never narrowed down, so the address stays unbounded and the store
is rejected.

The test is okay for llvm21 with -mcpu=3Dv2, see below:

  3: (07) r1 +=3D -5              ; R1=3Dscalar(smin=3D-5,smax=3D0xffffff=
fa)
  4: (67) r1 <<=3D 32             ; R1=3Dscalar(smax=3D0x7fffffff00000000=
,...)
  5: (77) r1 >>=3D 32             ; R1=3Dscalar(smin=3D0,umax=3D0xfffffff=
f,...)
  6: (25) if r1 > 0x4 goto pc+5 ; R1=3Dscalar(smin=3D0,smax=3Dumax=3D4,..=
.)
  7: (bf) r2 =3D r10
  8: (07) r2 +=3D -5
  9: (0f) r2 +=3D r1              ; R2=3Dfp(smin=3D-5,smax=3D-1)
 10: (b7) r1 =3D 46               ; R1=3D46
 11: (73) *(u8 *)(r2 +0) =3D r1   ; fp-8=3Dppppm???

To fix the test issue with llvm22 and llvm23, note that the shift pair
computes zext32(base + delta), which is exactly the relation
BPF_ADD_CONST32 describes. So keep the link alive across the first
shift and turn it from a 64-bit into a 32-bit one at the second, which
makes the -mcpu=3Dv2 sequence track like an alu32 one.

Two conditions guard this. First, a 32-bit link requires the linked
value to fit into u32, because sync_linked_regs() zero extends the
bounds it propagates through such a link. linked_base_fits_u32() checks
that on the register state before the shift, mirroring the dst_umax
check the alu32 add path already does. Second, in between the two
shifts the register does not hold the value its id and delta describe,
so the second shift must have a single incoming edge, otherwise the
intermediate state could be checkpointed and another path pruned
against it.

With this, the llvm22 and llvm23 code verifies, R2 keeps its id through
both shifts and the jump narrows down R1:

  3: (bf) r2 =3D r1               ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(i=
d=3D1,...)
  4: (07) r2 +=3D -5              ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=3D=
0xfffffffa)
  5: (67) r2 <<=3D 32             ; R2=3Dscalar(id=3D1-5,smax=3D0x7ffffff=
f00000000)
  6: (77) r2 >>=3D 32             ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=3D=
0xffffffff)
  7: (25) if r2 > 0x4 goto pc+5 ; R1=3Dscalar(id=3D1,smin=3D5,smax=3D9,..=
.)
                                ; R2=3Dscalar(id=3D1-5,smin=3D0,smax=3D4,=
...)
  8: (bf) r2 =3D r10
  9: (07) r2 +=3D -5
 10: (0f) r2 +=3D r1              ; R2=3Dfp(smin=3D0,smax=3D4)
 11: (b7) r1 =3D 46               ; R1=3D46
 12: (73) *(u8 *)(r2 -5) =3D r1   ; fp-8=3Dppppm???

The llvm21 log is unchanged, R1 carries no id there so the new code
does not apply to it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e421ea2b80c3..0fded097505e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15584,6 +15584,50 @@ static int adjust_scalar_min_max_vals(struct bpf=
_verifier_env *env,
 	return 0;
 }
=20
+static bool linked_base_fits_u32(const struct bpf_reg_state *reg)
+{
+	if (reg->id & BPF_ADD_CONST32)
+		return true;
+	return reg_smin(reg) >=3D (s64)reg->delta &&
+	       reg_smax(reg) <=3D (s64)U32_MAX + (s64)reg->delta;
+}
+
+static bool is_shift32_insn(const struct bpf_insn *insn, u8 op)
+{
+	return insn->code =3D=3D (BPF_ALU64 | op | BPF_K) && insn->off =3D=3D 0=
 && insn->imm =3D=3D 32;
+}
+
+/* Handle "rX <<=3D 32; rX >>=3D 32", which zero extends the lower 32 bi=
ts. */
+static bool is_zext_pair_lsh(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
+			     const struct bpf_reg_state *dst_reg)
+{
+	struct bpf_insn *next;
+	int insn_idx =3D env->insn_idx;
+
+	if (!dst_reg->id || !is_shift32_insn(insn, BPF_LSH))
+		return false;
+	/* check_subprogs() guarantees a shift is never the last insn. */
+	next =3D &env->prog->insnsi[insn_idx + 1];
+	if (!is_shift32_insn(next, BPF_RSH) || next->dst_reg !=3D insn->dst_reg=
)
+		return false;
+	/* Ensure the next insn has a single incoming edge. */
+	return !bpf_is_prune_point(env, insn_idx + 1);
+}
+
+static bool is_zext_pair_rsh(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
+			     const struct bpf_reg_state *dst_reg)
+{
+	struct bpf_insn *prev;
+	int insn_idx =3D env->insn_idx;
+
+	if (!dst_reg->id || insn_idx =3D=3D 0 || env->prev_insn_idx !=3D insn_i=
dx - 1)
+		return false;
+	if (!is_shift32_insn(insn, BPF_RSH))
+		return false;
+	prev =3D &env->prog->insnsi[insn_idx - 1];
+	return is_shift32_insn(prev, BPF_LSH) && prev->dst_reg =3D=3D insn->dst=
_reg;
+}
+
 /* Handles ALU ops other than BPF_END, BPF_NEG and BPF_MOV: computes new=
 min/max
  * and var_off.
  */
@@ -15694,6 +15738,7 @@ static int adjust_reg_min_max_vals(struct bpf_ver=
ifier_env *env,
 	 * alu32 ops will have zero-extended the result, making umax_value <=3D=
 U32_MAX.
 	 */
 	u64 dst_umax =3D reg_umax(dst_reg);
+	bool base_fits_u32 =3D linked_base_fits_u32(dst_reg);
=20
 	err =3D adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
 	if (err)
@@ -15743,6 +15788,11 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
 				dst_reg->id |=3D BPF_ADD_CONST64;
 			dst_reg->delta =3D off;
 		}
+	} else if (base_fits_u32 && is_zext_pair_lsh(env, insn, dst_reg)) {
+		/* Keep id and delta, the next insn completes the pair. */
+	} else if (is_zext_pair_rsh(env, insn, dst_reg)) {
+		if (dst_reg->id & BPF_ADD_CONST64)
+			dst_reg->id =3D (dst_reg->id & ~BPF_ADD_CONST64) | BPF_ADD_CONST32;
 	} else {
 		/*
 		 * Make sure ID is cleared otherwise dst_reg min/max could be
--=20
2.53.0-Meta

