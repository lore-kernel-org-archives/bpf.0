Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879235B632
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286535; cv=none; b=CsVNR3Ofgd48Kx94BBTy6SRvlxzpD7hzJMLdEK8oulTClP61zxEVsSf7rLLQslNWIZg7mzARJefcsw3UgMqkgjDT+ktoplgPY5/jmFcELm62Q9hilv4K10TodSqiadt6odyoX8JQALq2SY71OuIbd+SWZXJGdC9qEuhuEqsthno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286535; c=relaxed/simple;
	bh=ZqupyZCsEs9ejAxPG0GpCNO/OSSKdQJ/OJlopBcMuRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYXqKo3+q3ZoF0frnCRHDstn2qRBQ93whx5FS26+NPrBP5XUrybZ9qSOT1LrBOGv3uPy83fkv8FxbFeWF/hTCpbEc/fSv3mRtp7R+tTjPl4Fz+QkUq39Ft71iH1f13ohHQeOVmlWWzNNz2ksW/JYU5hc+hRzTJEjb+fZ1HsaAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 90B3425847624A; Thu, 20 Aug 2026 21:28:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2] bpf: Rewrite "rX <<= 32; rX >>= 32" into "wX = wX" to keep linked scalars
Date: Thu, 20 Aug 2026 21:28:37 -0700
Message-ID: <20260821042837.2786719-1-yonghong.song@linux.dev>
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
computes zext32(base + delta), which is what "wX =3D wX" computes as well
and which is exactly the relation BPF_ADD_CONST32 describes. So rewrite
the pair into "wX =3D wX" and let the mov turn the 64-bit link into a
32-bit one, which makes the -mcpu=3Dv2 sequence track like an alu32 one.

The rewrite has to keep the program length, so the second shift becomes
a second "wX =3D wX" rather than being removed. A "goto pc+0" nop looks
like the obvious filler, but it is a jump, and bpf_is_state_visited()
decides where to place a checkpoint based on how many jumps it has
seen. One extra jump per shift pair re-times that heuristic and moves
the checkpoints of an enclosing loop, which can lose state pruning.

For example, clear_global_array_list() in the no_alu32 flavour of the
linked_list selftest calls the always_inline clear_list(), three
256 iteration loops in a row. With the shift pair, we have

  processed 15384 insns (limit 1000000) max_states_per_insn 4 total_state=
s 260 peak_states 125 mark_read 0

With a "goto pc+0" filler the checkpoint changes its location, we have

  BPF program is too large. Processed 1000001 insn
  processed 1000001 insns (limit 1000000) max_states_per_insn 4 total_sta=
tes 19479 peak_states 148 mark_read 0

The duplicated mov keeps both the insn and the jump counts the same as
before the rewrite. It is idempotent, the second mov re-derives the
same bounds and finds the 32-bit link already in place.

With this, the llvm22 and llvm23 code verifies, R2 keeps its id across
the zero extension and the jump narrows down R1:

  3: (bf) r2 =3D r1               ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(i=
d=3D1,...)
  4: (07) r2 +=3D -5              ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=3D=
0xfffffffa)
  5: (bc) w2 =3D w2               ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=3D=
0xffffffff)
  6: (bc) w2 =3D w2               ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=3D=
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

The llvm21 sequence is rewritten as well, the rewrite is not tied to
BPF_ADD_CONST, so both its insns 4 and 5 become "w1 =3D w1". R1 carries
no id there, so the mov takes the ordinary zero extension path and ends
up with the same bounds the shift pair produced, the program verifies
as before.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260820013925.2515018-1-yonghong.s=
ong@linux.dev/
    - Replace left/right unsigned 32bit ship with 32bit mov's. This is do=
ne before
      main verification.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 821b47ac75c5..e1de442801d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15610,6 +15610,14 @@ static int adjust_scalar_min_max_vals(struct bpf=
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
 /* Handles ALU ops other than BPF_END, BPF_NEG and BPF_MOV: computes new=
 min/max
  * and var_off.
  */
@@ -15878,7 +15886,12 @@ static int check_alu_op(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
 						insn->src_reg);
 					return -EACCES;
 				} else if (src_reg->type =3D=3D SCALAR_VALUE) {
-					if (insn->off =3D=3D 0) {
+					if (insn->off =3D=3D 0 && insn->src_reg =3D=3D insn->dst_reg &&
+					    (dst_reg->id & BPF_ADD_CONST) &&
+					    linked_base_fits_u32(dst_reg)) {
+						dst_reg->id =3D (dst_reg->id & ~BPF_ADD_CONST64) |
+							      BPF_ADD_CONST32;
+					} else if (insn->off =3D=3D 0) {
 						bool is_src_reg_u32 =3D get_reg_width(src_reg) <=3D 32;
=20
 						if (is_src_reg_u32)
@@ -19183,6 +19196,36 @@ static int check_and_resolve_insns(struct bpf_ve=
rifier_env *env)
 	return 0;
 }
=20
+static bool is_shift_by_32(const struct bpf_insn *insn, u8 op)
+{
+	return insn->code =3D=3D (BPF_ALU64 | op | BPF_K) && insn->off =3D=3D 0=
 && insn->imm =3D=3D 32;
+}
+
+/* 'rX <<=3D 32; rX >>=3D 32' =3D> 'wX =3D wX; wX =3D wX' */
+static void bpf_rewrite_zext_shifts(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn =3D env->prog->insnsi;
+	int i;
+
+	for (i =3D 0; i < env->prog->len - 1; i++) {
+		if (!is_shift_by_32(&insn[i], BPF_LSH) ||
+		    !is_shift_by_32(&insn[i + 1], BPF_RSH) ||
+		    insn[i].dst_reg !=3D insn[i + 1].dst_reg)
+			continue;
+		if (bpf_is_jmp_point(env, i + 1))
+			continue;
+		/*
+		 * The second mov is redundant, but a nop (goto pc+0) cannot
+		 * be used here. A 'goto pc+0' is a jump, and the extra jump
+		 * may change where checkpoints are placed, see
+		 * bpf_is_state_visited(). The second mov avoids that.
+		 */
+		insn[i] =3D BPF_MOV32_REG(insn[i].dst_reg, insn[i].dst_reg);
+		insn[i + 1] =3D insn[i];
+		i++;
+	}
+}
+
 /* drop refcnt of maps used by the rejected program */
 static void release_maps(struct bpf_verifier_env *env)
 {
@@ -21149,6 +21192,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	/* Needs the jump point marks left by bpf_check_cfg(). */
+	bpf_rewrite_zext_shifts(env);
+
 	ret =3D bpf_compute_postorder(env);
 	if (ret < 0)
 		goto skip_full_check;
--=20
2.53.0-Meta

