Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E236481252
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875757; cv=none; b=Z8YpkqW3QG6S0o5fHGSO8YszeF+IxdfzdyQV9qEx1TlYP7oux1abcjDtvw2xnQluv4c5xlEPOyoQanB5YobIF1d7s3zpsEmZjIZhodrxMUSJAQlYXPc6KCTvRne7ZxHF1pZd18ODPv7oYf5jDiIKlAJlLShpc4+N7QJbRdEBW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875757; c=relaxed/simple;
	bh=isZbl9p4i7EXAEb0Xt3rt/vnRHzEGAHG4sVkmx1h9R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD4Ciwqx1FmmtaT1K/nt3u4GJwZF9t0MoGmZSVkI64eM3d9iRxMVIWyhMiMk9D3HyQb5QZjfbJIgXj04D1jQf/l7fqjC+4FwdZisR/Z/hPL8v8DrdOnHaLZHGJPswMzBc1jhpBnp2qdqTYHXIXyqlB9IebYf42W6YM/HK4LOP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 45B6D21FBFEDEB; Tue,  4 Aug 2026 13:35:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 05/13] bpf: Account R2 of register-pair returns in live register analysis
Date: Tue,  4 Aug 2026 13:35:48 -0700
Message-ID: <20260804203548.1872337-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804203522.1869244-1-yonghong.song@linux.dev>
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
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
pair. bpf_compute_live_registers() walks the instructions in order and
env->subprog_info[] is sorted by subprogram start, so the containing
subprogram is tracked with a running index and its return convention is
queried once per subprogram through bpf_ret_reg_pair().

Marking R2 at every exit instead would be simpler, but R2 would then stay
live backwards across any call that is not followed by a write to R2, whi=
ch
is nearly every program, and would needlessly hurt state pruning.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/liveness.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..68df6d8db4bd 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2059,10 +2059,15 @@ struct insn_live_regs {
 /* Bitmask with 1s for all caller saved registers */
 #define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
=20
-/* Compute info->{use,def} fields for the instruction */
+/*
+ * Compute info->{use,def} fields for the instruction. @ret_reg_pair tel=
ls
+ * whether the subprogram containing @insn returns its value in the R0:R=
2
+ * register pair, which matters for BPF_EXIT.
+ */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
-				   struct insn_live_regs *info)
+				   struct insn_live_regs *info,
+				   bool ret_reg_pair)
 {
 	struct bpf_call_summary cs;
 	u8 class =3D BPF_CLASS(insn->code);
@@ -2174,7 +2179,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
 			break;
 		case BPF_EXIT:
 			def =3D 0;
-			use =3D r0;
+			use =3D ret_reg_pair ? (r0 | BIT(BPF_REG_2)) : r0;
 			break;
 		case BPF_CALL:
 			def =3D ALL_CALLER_SAVED_REGS;
@@ -2209,8 +2214,8 @@ int bpf_compute_live_registers(struct bpf_verifier_=
env *env)
 	struct bpf_insn *insns =3D env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt =3D env->prog->len;
-	int err =3D 0, i, j;
-	bool changed;
+	int err =3D 0, i, j, subprog, start, end;
+	bool changed, ret_reg_pair;
=20
 	/* Use the following algorithm:
 	 * - define the following:
@@ -2237,8 +2242,14 @@ int bpf_compute_live_registers(struct bpf_verifier=
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

