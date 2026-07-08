Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70E2D97A6
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541422; cv=none; b=UJqKRNbLHkP+jDHEfcQShODtHxK6bqV6+yQ5sn5Z2LJhqy45MOxmRVRn2lB4zcR7kNSQa6xgrdwfKx81rtVAEKyHl1VMjw/YYo5MIKdUc6tWay+GZyuCU7CwAu39DEDpIknQV38sdEUWg8hh9oR8v2uFIJmQK3/lOLzrsM3jv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541422; c=relaxed/simple;
	bh=GaaCrSCTEGRLCDAwfB6Tr7xWNZhEbJwAQrlDSiechgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttbE2qg1rgozuMOQs9QYCiyHdNwGwfcMy3yKJ6f1ZadtfYAv0cTKWPtEeIuiuVnSR6C711a24ijowTPJRsEilTPyZNDzOOObsQFQLPPfejRV2h792GjKkV35cENp4qiJBItm9FHvzWEbQUf1f2p5PSpzBFfKeLm123WzQ+jUoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4D90C1D0B6F838; Wed,  8 Jul 2026 13:10:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 05/12] bpf: Account R2 of register-pair returns in live register analysis
Date: Wed,  8 Jul 2026 13:10:05 -0700
Message-ID: <20260708201005.2158063-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
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
marked R0 used at exit, so the callee's R2 could be considered dead and
cleaned from checkpointed states, which would allow unsound state pruning=
.

Mark R2 used at a BPF_EXIT when the enclosing subprogram returns via the
R0:R2 register pair. The call site already treats the caller-saved
registers R0-R5 as clobbered, so R2 as a result register is covered there=
.

For example, for a subprogram returning an __int128, the live-registers
dump (log level 2) shows both R0 and R2 live before the callee's exit
(insn 5):

  Live regs before insn:
        0: .12345.... (85) call pc+2
        1: ..2....... (bf) r0 =3D r2
        2: 0......... (95) exit
        3: .......... (b7) r0 =3D 1
        4: 0......... (b7) r2 =3D 2
        5: 0.2....... (95) exit

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/liveness.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..0977d32fcf01 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2062,7 +2062,8 @@ struct insn_live_regs {
 /* Compute info->{use,def} fields for the instruction */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
-				   struct insn_live_regs *info)
+				   struct insn_live_regs *info,
+				   int subprog)
 {
 	struct bpf_call_summary cs;
 	u8 class =3D BPF_CLASS(insn->code);
@@ -2175,6 +2176,8 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
 		case BPF_EXIT:
 			def =3D 0;
 			use =3D r0;
+			if (bpf_ret_reg_pair(env, subprog))
+				use |=3D BIT(BPF_REG_2);
 			break;
 		case BPF_CALL:
 			def =3D ALL_CALLER_SAVED_REGS;
@@ -2237,8 +2240,12 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
 		goto out;
 	}
=20
-	for (i =3D 0; i < insn_cnt; ++i)
-		compute_insn_live_regs(env, &insns[i], &state[i]);
+	for (i =3D 0, j =3D 0; i < insn_cnt; ++i) {
+		/* Advance to the subprog that contains instruction i. */
+		while (j + 1 < env->subprog_cnt && env->subprog_info[j + 1].start <=3D=
 i)
+			j++;
+		compute_insn_live_regs(env, &insns[i], &state[i], j);
+	}
=20
 	/* Forward pass: resolve stack access through FP-derived pointers */
 	err =3D bpf_compute_subprog_arg_access(env);
--=20
2.53.0-Meta

