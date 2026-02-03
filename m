Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CEF2E03F0
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085362; cv=none; b=MC7NPVRONEFZxs+5yyFVT8iPemM8NapRQQGL/a2hmEOUWguKSMb2ts25A3FzUM2lag1Yb3Znc2RbQxn7fWuiSfPSzB28tL8smylr4iPkGBssrhG1/VB1H34osPx0gR30IJBBuPumpxr9DSLINYrlxRV+1NFB/DMc5zYA/DejezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085362; c=relaxed/simple;
	bh=0Vg8OS/4259Q75LfPJHWPGpEOoD2edV81jIgY8LxxFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBh8FEEBKp0hEtVlKQFYq0flm2LweCeBRz2D24BNcIbe1aFDzLL7CBUx1RBVR2uJijl8ggsPwZue+YKby1eltO3Uu7eGQwgGmTEZZsg3Go28FGQwwSUIP2Z8DHFvh65QWYT6QX564TvyfPXa7IidXSu+gDsBfJKbnVBcVu/ckO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYTVwUaV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYTVwUaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907C8C116C6;
	Tue,  3 Feb 2026 02:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085361;
	bh=0Vg8OS/4259Q75LfPJHWPGpEOoD2edV81jIgY8LxxFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYTVwUaVWJ3lLJzguYrMXOI1+5U8giip2jWfxLK3hfRVllFLwkrEyj7CHfq4SbUlR
	 PMclCvDI8y6LeAcEfSRlSONoYTduE3EPx0vaDybeWd9fEhcFoYMZMRtQlCO4I9tQwV
	 +oV01lwtobGKLNYrG63QDnz0EL0RYXfG6X+JGwJwCuhrqZx9F6yQYHrhNqMllcrG5g
	 YYHQBg8CecrBABgmHvzRD8kI5QgmsnTrhJsWODF85hPtiF99QdwLEiPWDdENXfIArT
	 iFp8PsLsHnguT7mhZaHf7wEOePQsoQF0qsEBJeiR9Em0j4uMWoEliOAZ6VK3Z3uA/m
	 T8qyA51g5r/TA==
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
Subject: [PATCH bpf-next v2 1/5] bpf: verifier: Assign ids on stack fills
Date: Mon,  2 Feb 2026 18:22:24 -0800
Message-ID: <20260203022229.1630849-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203022229.1630849-1-puranjay@kernel.org>
References: <20260203022229.1630849-1-puranjay@kernel.org>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

