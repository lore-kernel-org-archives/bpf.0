Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA93D522B;
	Thu,  4 Jun 2026 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604552; cv=none; b=nS+NVyZ6WoL2ya6HORpVaqhbfuKF32zG/wd77eQltNpVfEYMzwSD8IcgZJSRRWvEKG4b2iikImRFSA0FXD1iuEkKWqUryQXD7BIglZmAQJstbwPgGGfs0AjS0jiBHNibZVpvkMEpZ7r6h8Bv/L7QJbaSLPhR+piNueBDE1jxSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604552; c=relaxed/simple;
	bh=JfSh90vAuZgkaaHACVBUPe2vqK+R+VcbdXjwcArV0rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gfj0E8I9whk8BDDyCCv9kSceFeOgmQa6N2Blk/13h1mEzki4ZkgBdxLq+AZMamJajvSFRZY+6gvu36gMVBb0oVk3sF1GNFKWXBMux2QHyz8OGII0HWI5uF90WQNBK20GgegNwQDLCg2NAXD1TZoFFG7tDoBr8nSWntqDMJ+tJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g9hZECUL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g9hZECUL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0777CC63453;
	Thu,  4 Jun 2026 20:22:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E7C55FED1;
	Thu,  4 Jun 2026 20:22:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 191B6106A1D38;
	Thu,  4 Jun 2026 22:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780604547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zgpTqib293PeJ1HPHKW/oMt7J0hcVujaLGWwpfesc9M=;
	b=g9hZECULy4U0Df6PU535oPXEz1CTdnLpDUaLPDCdFKUW1EzbMzT3vnSCPj1Yz1RL5AmWSw
	aSWz5Znay4r7aREbuSDeR+Uh/v61xzxZO35IwbqtZxAaEsp2a5e0UmDDpi2XsYzVaUtCm5
	lfZ2Q3W0l5yc3R2qafhW3f0mniN/TSe0qVuzAf0KGzyhpB8kS237iGmDLI3JToKcQzlg0W
	NeLWsZ4ocsKBcL6ySdJOVP8GN9uSnQcE8o6fouYfdU1O/+9osSHF89kp4yrpNH67+3o8fD
	EfolbKvwNMOUdcWT46wWKHkcSO3D+RyfIGff/Aei3m0bt2+XnvBg68mkvOTGgg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 04 Jun 2026 22:21:59 +0200
Subject: [PATCH bpf-next v2 1/8] bpf: mark instructions accessing program
 stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-kasan-v2-1-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
In-Reply-To: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

In order to prepare to emit KASAN checks in JITed programs, JIT
compilers need to be aware about whether some load/store instructions
are targeting the bpf program stack, as those should not be monitored
(we already have guard pages for that, and it is difficult anyway to
correctly monitor any kind of data passed on stack).

To support this need, make the BPF verifier mark the instructions
depending on whether they could access or not memory other than stack:
- add a setter that allows the verifier to mark instructions accessing
  non-stack memory
- add a getter that allows JIT compilers to check whether instructions
  being JITed are accessing the stack _and only_ the stack. If no env is
  provided (eg this is a cBPF program), do a best-effort check based on
  source and destination registers.

As different states in the verifier could lead to different memory types
for the same access, just marking an instruction as accessing stack only
is not enough (it could be some other memory type in another verifier
state), so the algorithm rather sets by default any load/store
instruction as stack only, and if _any_ state leads to any memory access
type other than PTR_TO_STACK, it overrides this setting. It also takes
care about shifting back the instruction marking in adjust_insn_aux_data
if the verifier patches instructions.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- invert marking logic to cover possible different reg types when the
  verifier covers different states
- add a best-effort processing for classical bpf programs, inspecting
  directly src and dst registers since we don't have verifier env
- make sure to keep marking in sync with prog when it is patched by
  verifier
---
 include/linux/bpf.h          |  2 ++
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/core.c            | 17 +++++++++++++++++
 kernel/bpf/fixups.c          | 16 +++++++++++-----
 kernel/bpf/verifier.c        |  9 +++++++++
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8599b451dd7a..ff80d1d62bff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1560,6 +1560,8 @@ void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
 				 int insn_idx);
+bool bpf_insn_accesses_stack_only(const struct bpf_verifier_env *env,
+				  const struct bpf_prog *prog, int insn_idx);
 u16 bpf_out_stack_arg_cnt(const struct bpf_verifier_env *env, const struct bpf_prog *prog);
 #else
 static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c248ff41f42a..0f3f055d6c14 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -722,6 +722,8 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/* instruction can access non-stack memory */
+	bool non_stack_access;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a656a8572bdb..393d9eacd215 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1583,6 +1583,22 @@ bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struc
 	return env->insn_aux_data[insn_idx].indirect_target;
 }
 
+bool bpf_insn_accesses_stack_only(const struct bpf_verifier_env *env,
+				  const struct bpf_prog *prog, int insn_idx)
+{
+	struct bpf_insn *insn;
+
+	/* cBPF: we have no verifier state, do a best-effort check based on
+	 * dst/src reg
+	 */
+	insn_idx += prog->aux->subprog_start;
+	insn = (struct bpf_insn *)prog->insnsi + insn_idx;
+	if (!env)
+		return insn->dst_reg == BPF_REG_FP ||
+		       insn->src_reg == BPF_REG_FP;
+	return !env->insn_aux_data[insn_idx].non_stack_access;
+}
+
 u16 bpf_out_stack_arg_cnt(const struct bpf_verifier_env *env, const struct bpf_prog *prog)
 {
 	const struct bpf_subprog_info *sub;
@@ -1592,6 +1608,7 @@ u16 bpf_out_stack_arg_cnt(const struct bpf_verifier_env *env, const struct bpf_p
 	sub = &env->subprog_info[prog->aux->func_idx];
 	return sub->stack_arg_cnt - bpf_in_stack_arg_cnt(sub);
 }
+
 #endif /* CONFIG_BPF_JIT */
 
 /* Base function for offset calculation. Needs to go into .text section,
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 5aa3f7d99ac9..5228c910fbf5 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -185,16 +185,22 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	}
 
 	/*
-	 * The indirect_target flag of the original instruction was moved to the last of the
-	 * new instructions by the above memmove and memset, but the indirect jump target is
-	 * actually the first instruction, so move it back. This also matches with the behavior
-	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
-	 * instruction.
+	 * The indirect_target and non_stack_access flags of the original
+	 * instruction were moved to the last of the new instructions by the
+	 * above memmove and memset, but those actually match the first
+	 * instruction, so move them back. This also matches with the behavior
+	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to
+	 * the first new instruction.
 	 */
 	if (data[off + cnt - 1].indirect_target) {
 		data[off].indirect_target = 1;
 		data[off + cnt - 1].indirect_target = 0;
 	}
+
+	if (data[off + cnt - 1].non_stack_access) {
+		data[off].non_stack_access = 1;
+		data[off + cnt - 1].non_stack_access = 0;
+	}
 }
 
 static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..b3f0f430ad6a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3143,6 +3143,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].indirect_target = true;
 }
 
+static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].non_stack_access = true;
+}
+
 #define LR_FRAMENO_BITS	3
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -6300,6 +6305,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		else
 			coerce_reg_to_size_sx(&regs[value_regno], size);
 	}
+
+	if (!err && reg->type != PTR_TO_STACK)
+		mark_non_stack_access(env, insn_idx);
+
 	return err;
 }
 

-- 
2.54.0

