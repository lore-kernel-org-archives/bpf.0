Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0180156F45
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029096; cv=none; b=fkDPiI6BDm4+toma5LfY2/eBOAfmap6IfFZYHHzT40xHEFnIYj/WFOkZSSRcEyQJc1ux4BoBVpJNS28G9n1qibdTFlAAOlQGnB5xQ1i0g4ipzaqzjz4c0sEGXXjuKC1K29S/evYEEursjyiSW1lxuEAv4CNDoFAybX9ACWGkRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029096; c=relaxed/simple;
	bh=onDA3jMDLVOiC/AOs5Phu+dyFuEv8xAFx9m2wEdN/iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h98Au/1O+K7CXX/XkfIHlT9+mIK6Cdb8mhePB03YfN6XJIvHfpW0Y0hF7mhtMb0EB0k626594YgT2jSNGTSa9nIEiKV3FtkjrJ9trS0yX1Q8pwqlnVfGUVddJJArGStEElx4jfIbA8w+sr6zc8jUBxoWb/BRduPV/90R838Jse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU/49PGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU/49PGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D6BC116C6;
	Mon,  2 Feb 2026 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770029096;
	bh=onDA3jMDLVOiC/AOs5Phu+dyFuEv8xAFx9m2wEdN/iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WU/49PGiYTXMOhlVexzzp5RTDm8XrRGcW9ZodWy/73XOqDqIEq9TR85LvA/lSVRJb
	 B9OJ2aMMNrTR4eWG7cEMbe4RtycD7slo5Niou0uCxRlfUD5lY5l5arHyUZ4jYk835p
	 pAzaHnryhRdvQ/SZ8ZbDA9B5x6urDEH3l5Fa9mLrPEjTLrxLQpr+SQviGqfDlIa2Qz
	 XREnY1TobRMIF+lEoyLjl0yTqQG0LRyzOZhTUkPoQ7g7egOq5gYuFr+p2eJNCBO50S
	 Y0ECJ9YtCAwCMB7R4v47ZC1Pd5YwopGTSPsO+o8G25AOKzahgKZWk3AXcFx6S+tC4F
	 uXV1ShoSAOBHw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 1/4] bpf: verifier: Assign ids on stack fills
Date: Mon,  2 Feb 2026 02:44:03 -0800
Message-ID: <20260202104414.3103323-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202104414.3103323-1-puranjay@kernel.org>
References: <20260202104414.3103323-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will allow clearing of scalar ids if no other
register/stack slot has that id. This is because if only one register
has a unique id, it can't participate in bounds propagation and is
equivalent to having no id.

But if the id of a stack slot is cleared by clear_singular_ids() in the
next commit, reading that stack slot into a register will not establish
a link because the stack slot's id is cleared.

This can happen in a situation where a register is spilled and later
loses its id due to a multiply operation (for example) and then the
stack slot's id becomes singular and can be cleared.

Make sure that scalar stack slots have an id before we read them into a
register.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b62b6d57175..17b499956156 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5518,6 +5518,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 */
 				s32 subreg_def = state->regs[dst_regno].subreg_def;
 
+				if (env->bpf_capable && size == 4 && spill_size == 4 &&
+				    get_reg_width(reg) <= 32)
+					/* Ensure stack slot has an ID to build a relation
+					 * with the destination register on fill.
+					 */
+					assign_scalar_id_before_mov(env, reg);
 				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def = subreg_def;
 
@@ -5563,6 +5569,11 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			}
 		} else if (dst_regno >= 0) {
 			/* restore register state from stack */
+			if (env->bpf_capable)
+				/* Ensure stack slot has an ID to build a relation
+				 * with the destination register on fill.
+				 */
+				assign_scalar_id_before_mov(env, reg);
 			copy_register_state(&state->regs[dst_regno], reg);
 			/* mark reg as written since spilled pointer state likely
 			 * has its liveness marks cleared by is_state_visited()
-- 
2.47.3

