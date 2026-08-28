Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547D397944;
	Fri, 28 Aug 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908899; cv=none; b=kDENGp5tXwKzITL5hmPdVZ35O+OKWDh8xcQFatlBldiJZ+XTu5niHvESpSytFo7P75ZYq66fwnjxqn75PFsl98yaF3y3jJmVWFixXi61N8Y7CTEJZbq/rfdAJJNFW0ZyXPq/9iXJ3dkD4B+RiJLdzcTkDSzGCGQvy8jPzSxfEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908899; c=relaxed/simple;
	bh=r9Tf3LQhxIwUeGxu8TgrJKOO9ZMJvJxvwLQxkV8Zsgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4jJvNJ9WVb7rK1yJRf7vxtiRw/nbuTz65TLw9d466ufaG9wwPiO8kfcUttSgmcEcMKimU/EnVSiB/cPszXrY87X8c7/FMeQy8XGIhjQt27SeM69wWWvCzsjsRZNptp5sbC7NYTK3s3I1eZUK6LnOkNSRNvBXgzLtRcCtvWv1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KloZ7ebu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KloZ7ebu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 99E204E413FD;
	Fri, 28 Aug 2026 09:21:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CB6460537;
	Fri, 28 Aug 2026 09:21:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 059AD11C78144;
	Fri, 28 Aug 2026 11:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787908893; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=erLWjolmSCAEr7dci0bwAWu7wzN6cI8xC9N8Rqbe1h4=;
	b=KloZ7ebu1XTrwueYq0QyoLedJkMT3nqzSSJALG0GCwMzC86oqfrFTiAxnm+zrwgAfoSfyg
	gIWt7GSykM3oGe05LcaLaYTMy2/I944JcOSB1MbzZenMV9Ai2PgKUp4nL4zMh8nPBUoY0A
	wff4NNbLbVT5Z2aHWQzQ7UoKpragegrVPaxzwfTim+jWYJkvVX4XKTOqqreeShFOwuszQA
	x6+SMLnTnmc2nZk+jDgiYBPlTSCzDql1Rp19nveiliTpY4leeI3952EGwvomrK2nr+9RFY
	BSFMPyerOcV3mVzf5NYI+5soYhGIT4wQTajcdUd5/S0krrtpXgDXJuxmBpP/YQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 28 Aug 2026 11:21:09 +0200
Subject: [PATCH bpf-next v8 1/8] bpf: mark instructions accessing program
 stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-kasan-v8-1-7c1c0fdb9d7f@bootlin.com>
References: <20260828-kasan-v8-0-7c1c0fdb9d7f@bootlin.com>
In-Reply-To: <20260828-kasan-v8-0-7c1c0fdb9d7f@bootlin.com>
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
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Yafang Shao <laoar.shao@gmail.com>
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
Changes in v8:
- make sure to test the original register type rather than a possibly
  verifier-mutated value in check_mem_access

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
 kernel/bpf/verifier.c        | 10 ++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 004b06785521..412a13a664fa 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -725,6 +725,8 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/* instruction can access non-stack memory */
+	bool non_stack_access;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 65b441e4a351..edcb0cbbb13d 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -208,12 +208,25 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
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
@@ -227,8 +240,15 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 */
 	data[off].zext_dst = bpf_insn_def32(new_prog, insn + off + cnt - 1) >= 0;
 
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
 	env->insn_aux_data_len = prog_len;
 
@@ -239,8 +259,25 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
 		data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
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
@@ -306,6 +343,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
+	struct bpf_insn original_insn;
 
 	if (len > 1) {
 		new_data = vrealloc(env->insn_aux_data,
@@ -318,6 +356,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 		env->insn_aux_data = new_data;
 	}
 
+	memcpy(&original_insn, env->prog->insnsi + off, sizeof(struct bpf_insn));
 	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
 	if (IS_ERR(new_prog)) {
 		if (PTR_ERR(new_prog) == -ERANGE)
@@ -326,7 +365,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_prog, off, len);
+	adjust_insn_aux_data(env, new_prog, off, len, &original_insn);
 	adjust_subprog_starts(env, off, len);
 	adjust_insn_arrays(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..364332eb4185 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3272,6 +3272,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
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
@@ -6416,6 +6421,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
+	enum bpf_reg_type ptr_type = reg->type;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -6654,6 +6660,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				clear_scalar_id(&regs[value_regno]);
 		}
 	}
+
+	if (!err && ptr_type != PTR_TO_STACK)
+		mark_non_stack_access(env, insn_idx);
+
 	return err;
 }
 

-- 
2.55.0

