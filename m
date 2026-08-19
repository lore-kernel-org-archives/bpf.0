Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33B3955FB
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118798; cv=none; b=JhglsR4gdDKU8/GVAqi9B5CpyEs4YBqhL+vwDhWUdbnGnLmhinFA5UJ4iDf8z6piZYYkeFB1K4q9UfDEU56C9n8DBbtt1JjTTB6u1p1e8KKSUK6RedNrTbuN8c5bIdIwxPbS94NH+K0skSo7Seqwd0GdovBCUZnDiZRCTfTiXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118798; c=relaxed/simple;
	bh=1HU6aWke/FMDdwfTFIrp6htusJcwQxqwl6PziKfKBI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIZ+hyZwnuDkjNAT4bZUVm4A8cBaB2c5zl38jiM4NaJ9RSCPDjdQhmSi/nNnWQ8DQeGijLoEgOD0bPdEd1p5QZzjAUnjkaszu+5h3Vtz/Qb+KvEj9l2B7WVLqYV5TAAGSV/vQc1OFU+bOicS9IVXxip2nGvj0EJZNW1Yqu1ZfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id ACDE1250AA38F7; Tue, 18 Aug 2026 22:53:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 05/10] bpf: Account R2 of register-pair returns in live register analysis
Date: Tue, 18 Aug 2026 22:53:04 -0700
Message-ID: <20260819055304.3296353-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819055239.3293449-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
struct/union or an __int128) reads R2 as well as R0, since the second hal=
f
of the return value is passed back in R2. compute_insn_live_regs() only
marked R0 used at exit, so a callee's R2 could be considered dead and
cleaned from checkpointed states, which would allow unsound state pruning=
.

Mark R2 as read at the BPF_EXIT of a subprogram that does return a regist=
er
pair. bpf_compute_live_registers() now loops over the subprograms and, fo=
r
each, over the [start, end) instruction range from env->subprog_info[], s=
o
the return convention is queried once per subprogram through
bpf_ret_reg_pair() rather than once per instruction.

Marking R2 at every exit instead would be simpler, but R2 would then stay
live backwards across any call that is not followed by a write to R2, whi=
ch
is nearly every program, and would needlessly hurt state pruning.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/liveness.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 74fc4b3f80d6..71f998c6eb88 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2060,7 +2060,8 @@ static inline u16 mask_hi(u32 m) { return (u16)(m >=
> 16); }
 /* Compute info->{use,def} fields for the instruction */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
-				   struct insn_live_regs *info)
+				   struct insn_live_regs *info,
+				   bool ret_reg_pair)
 {
 	struct bpf_call_summary cs;
 	const u8 class =3D BPF_CLASS(insn->code);
@@ -2072,6 +2073,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
 	const u32 src32 =3D mask_lo(src);
 	const u32 dst32 =3D mask_lo(dst);
 	const u32 r0  =3D reg64_mask(0);
+	const u32 r2  =3D reg64_mask(BPF_REG_2);
 	u32 def =3D 0;
 	u32 use =3D U32_MAX;
=20
@@ -2191,7 +2193,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
 			break;
 		case BPF_EXIT:
 			def =3D 0;
-			use =3D r0;
+			use =3D ret_reg_pair ? (r0 | r2) : r0;
 			break;
 		case BPF_CALL:
 			def =3D ALL_CALLER_SAVED_REGS;
@@ -2228,8 +2230,8 @@ int bpf_compute_live_registers(struct bpf_verifier_=
env *env)
 	struct insn_live_regs *state;
 	int insn_cnt =3D env->prog->len;
 	u64 pos, insn_pos;
-	int err =3D 0, i, j;
-	bool changed;
+	int err =3D 0, i, j, subprog, start, end;
+	bool changed, ret_reg_pair;
=20
 	/* Use the following algorithm:
 	 * - define the following:
@@ -2256,8 +2258,14 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
 		goto out;
 	}
=20
-	for (i =3D 0; i < insn_cnt; ++i)
-		compute_insn_live_regs(env, &insns[i], &state[i]);
+	for (subprog =3D 0; subprog < env->subprog_cnt; subprog++) {
+		start =3D env->subprog_info[subprog].start;
+		end =3D env->subprog_info[subprog + 1].start;
+		ret_reg_pair =3D bpf_ret_reg_pair(env, subprog);
+
+		for (i =3D start; i < end; ++i)
+			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
+	}
=20
 	/* Forward pass: resolve stack access through FP-derived pointers */
 	err =3D bpf_compute_subprog_arg_access(env);
--=20
2.53.0-Meta

