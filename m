Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F639FCD8;
	Tue,  4 Aug 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865555; cv=none; b=IRkwrOJ86sDf6rh0Y19ihK1qVMCgstT32bDkxhWgMKEFLteJU6ce9uGP+/NAaJcw/IL0zho/BbzfTZsbF6xEkJIPV/BS+gJH/AoJCPmFLtBsrkxJPTYVdcf5y6W91znIjlflnPEV5sqeGoIqv4e3XhTBNj8apRpA++lxFaruYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865555; c=relaxed/simple;
	bh=TRjG04w7mWvt0meMLgRPFLAn96orzE/XoR8mPYwCC5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4QP5BcWyPDdIWDBhhc+tqUJJbZKZ4CUuFevQQobxm1oUCONMoWQGL90rKO10q8cg72dZ4ourb0Eqrz31gFDzoRQs+uOdPjitHmctZoIHGMCkPJ6iwx7JfiYV0WjeIPUAKAgx+FNkdXusEtQNkdTufTUdlULHR6ZwxR6M5V5XaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B3S1L+cI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B3S1L+cI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 312291A13FE;
	Tue,  4 Aug 2026 17:45:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDBD26029E;
	Tue,  4 Aug 2026 17:45:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DA5A11C3344B;
	Tue,  4 Aug 2026 19:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785865544; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=juOUKFse6UE2abnoGgfP4CNlZQBXYfl81snCaqHEsZs=;
	b=B3S1L+cIL+wFLEI1j0FCLNKtY15rDKT86En5KJWt6B8YjiRiPgADMxCA+FR/MdQSq8LkvD
	DbPfwCr1vB/GJTF7wO7zQkFMC/lLC0p5RBNO0RBO+U+aMoo8ynR5V1MYlYVcdESJZytYMZ
	bZqSdQ4T0nILhsbaXE+1dFcfLlxooMiEIEzf2reOiSTPWVD/1YmXTPBBw+X2bGkcYgC0Y+
	Mc44/Ij0EvEPS7MRhAq7K22eLpeIe5X4a+Ci2I5ARC7sfRsLCHfdL+QiaT7twkbvc4jubW
	zbcvlGo6bOgh4meM/RJt+w37CQMfRG/vonbN9r4vXpGVDNwJWsecjHBkezAKcg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 04 Aug 2026 19:45:32 +0200
Subject: [PATCH bpf-next v6 1/9] bpf: mark instructions accessing program
 stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-kasan-v6-1-549ef845f491@bootlin.com>
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
In-Reply-To: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

In order to prepare to emit KASAN checks in JITed programs, JIT
compilers need to be aware about whether some load/store instructions
are targeting the bpf program stack, as those should not be monitored
(we already have guard pages for that, and it is difficult anyway to
correctly monitor any kind of data passed on stack).

To support this need, make the BPF verifier mark the instructions
depending on whether they could access or not memory other than stack.
As different states in the verifier could lead to different memory types
for the same access, just marking an instruction as accessing stack only
is not enough (it could be some other memory type in another verifier
state), so the algorithm rather sets by default any load/store
instruction as stack only, and if _any_ state leads to any memory access
type other than PTR_TO_STACK, it overrides this setting. It also takes
care about shifting back the instruction marking in adjust_insn_aux_data
if the verifier patches instructions. However, if the verifier generates
new BPF_ST/BPF_STX/BPF_LDX while patching some instructions, those new
ones are systematically marked as non-stack-accessing: this may
over-instrument a few memory accessing instructions, but it allows
making sure that we will not miss accidentally any.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v6:
- drop original instruction offset tracking, but add a best effort
  original insn marking preservation
- update comment style

Changes in v5:
- fix incorrect marking for single instruction patch

Changes in v4:
- include BPF_ATOMIC in is_mem_insn
- correctly mark instructions in adjust_insn_aux_data if patch generates
  a single instruction (ie replace an instruction)

Changes in v3:
- drop getter
- drop cBPF handling
- update marking shifting logic to track more precisely orignal
  instructions
- systematically mark newly generated instructions as non-stack
  accessing

Changes in v2:
- invert marking logic to cover possible different reg types when the
  verifier covers different states
- add a best-effort processing for classical bpf programs, inspecting
  directly src and dst registers since we don't have verifier env
- make sure to keep marking in sync with prog when it is patched by
  verifier
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/fixups.c          | 45 +++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        |  9 +++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2a40caca0a0..6c1376b2a3c9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -723,6 +723,8 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/* instruction can access non-stack memory */
+	bool non_stack_access;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a0bddada7964..6d69bf9db6ec 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -152,12 +152,25 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
+static bool is_mem_insn(struct bpf_insn *insn)
+{
+	if (BPF_CLASS(insn->code) != BPF_ST &&
+	    BPF_CLASS(insn->code) != BPF_STX &&
+	    BPF_CLASS(insn->code) != BPF_LDX)
+		return false;
+
+	return (BPF_MODE(insn->code) == BPF_MEM ||
+		BPF_MODE(insn->code) == BPF_MEMSX ||
+		BPF_MODE(insn->code) == BPF_ATOMIC);
+}
+
 /* single env->prog->insni[off] instruction was replaced with the range
  * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_prog *new_prog, u32 off, u32 cnt)
+				 struct bpf_prog *new_prog, u32 off, u32 cnt,
+				 struct bpf_insn *original_insn)
 {
 	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
@@ -171,8 +184,15 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 */
 	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
 
-	if (cnt == 1)
+	if (cnt == 1) {
+		/*
+		 * A non-memory accessing insn could have been replaced by a
+		 * memory accessing insn, systematically mark it for non-stack
+		 * access
+		 */
+		data[off].non_stack_access = is_mem_insn(insn + off);
 		return;
+	}
 	prog_len = new_prog->len;
 
 	memmove(data + off + cnt - 1, data + off,
@@ -182,8 +202,25 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
 		data[i].zext_dst = insn_has_def32(insn + i);
+		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
+			data[i].non_stack_access =
+				data[off + cnt - 1].non_stack_access;
+			data[off + cnt - 1].non_stack_access = false;
+		} else if (is_mem_insn(insn + i)) {
+			data[i].non_stack_access = true;
+		}
 	}
 
+	/*
+	 * Last slot instruction could be a newly generated
+	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
+	 * if it is not the original instruction, otherwise keep the
+	 * original marking
+	 */
+	if (is_mem_insn(insn + off + cnt - 1) &&
+	    memcmp(insn + off + cnt - 1, original_insn, sizeof(struct bpf_insn)))
+		data[off + cnt - 1].non_stack_access = true;
+
 	/*
 	 * The indirect_target flag of the original instruction was moved to the last of the
 	 * new instructions by the above memmove and memset, but the indirect jump target is
@@ -249,6 +286,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
+	struct bpf_insn original_insn;
 
 	if (len > 1) {
 		new_data = vrealloc(env->insn_aux_data,
@@ -261,6 +299,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 		env->insn_aux_data = new_data;
 	}
 
+	memcpy(&original_insn, env->prog->insnsi + off, sizeof(struct bpf_insn));
 	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
 	if (IS_ERR(new_prog)) {
 		if (PTR_ERR(new_prog) == -ERANGE)
@@ -269,7 +308,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_prog, off, len);
+	adjust_insn_aux_data(env, new_prog, off, len, &original_insn);
 	adjust_subprog_starts(env, off, len);
 	adjust_insn_arrays(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7439afdc851a..3392d93c73f8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3213,6 +3213,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].indirect_target = true;
 }
 
+static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].non_stack_access = true;
+}
+
 #define LR_FRAMENO_BITS	4
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -6433,6 +6438,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				clear_scalar_id(&regs[value_regno]);
 		}
 	}
+
+	if (!err && reg->type != PTR_TO_STACK)
+		mark_non_stack_access(env, insn_idx);
+
 	return err;
 }
 

-- 
2.55.0

