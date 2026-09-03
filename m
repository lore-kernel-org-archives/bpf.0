Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952A4AF177;
	Thu,  3 Sep 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443528; cv=none; b=bNxm8z0iNPeFMINKW1dylYAK9ZumDudfoYf3YL7DELEQlQxIdVZa69Dq0ty8frfqFIbwuaEk124eT/xC8bk1KEY/R3KHiqzx884nI8mU17HoKEnieJvGOdRzt24Yr3kSHgelKLQOJtqF/bQGSjcg1f3iF7p/OEBeM2ZNSFWnrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443528; c=relaxed/simple;
	bh=EfdFKAXSRk20DKM+L8/zSjvTQ317Tp42HfPM9hI+z5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWRnvvthwMpa9tqwzb/zyURvRDc6IDu4VpfO/HdhxpKoFOswKte1XeynGDPYyluM21ZuX5yAYgT13O9jgAW88A5bVWJplz3Mqh1+BDJnX9DQSkE/kgzWLIA6lthYCvU0PN2aDtmtHF207QXzukkECH4BIA7WqGWFNAUjJdmi0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xTUqRFMI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xTUqRFMI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EA3051A197D;
	Thu,  3 Sep 2026 13:51:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDE3F602B8;
	Thu,  3 Sep 2026 13:51:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6F1611C7A098;
	Thu,  3 Sep 2026 15:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788443506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B4GX6q898zWqzL1h2rZhx4pop1OA1nuHO4YuxZ5UD8M=;
	b=xTUqRFMIL5n5AZ+LMWwLfVBgCYfHu+CNzw7odYce/lb6le+2MWWRtGL7dHF+3bFEVlvtmI
	wJcssWV0WLEbPFC0TfS2zHAuxZeKXKmHl86anlAVonpEJ/YS2rSsK7wEAhhTo1bnSoFSMP
	gcaO46b0bkNE0cfelgpLXFbbZSSPmNKJ1Xg43X+G4GZ9HlVApb23YzBkSlDfC0d5MpZFip
	sjiqsJQ+RQaQqSRBhPG6uY7ei0xQYDuJRD/s6FWuJuQnV5J7kXUMANrMygOdPkAwYEDo41
	H8vErwt1VqPahAYWB7DCLrmhILjgubgzd9jm68OipGhewySaiVzA35OSqEKLRw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 03 Sep 2026 15:51:30 +0200
Subject: [PATCH bpf-next v9 1/8] bpf: mark instructions accessing program
 stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-kasan-v9-1-2407fe99255a@bootlin.com>
References: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
In-Reply-To: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
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
Changes in v9:
- turn non_stack_access into a bit field so that it does not increase
  struct insn_aux_data size
- ignore BPF_ST|BPF_NOSPEC in is_mem_insn
- move is_mem_insn into bpf_verifier.h to share it with the verifier
- do not mark non_stack_access if check_mem_insn isn't called for a mem
  accessing insn

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
 include/linux/bpf_verifier.h | 16 ++++++++++++++++
 kernel/bpf/fixups.c          | 33 ++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 10 ++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ae9f606539f4..1a3c44ab06a1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -706,6 +706,7 @@ struct bpf_insn_aux_data {
 	 */
 	u32 calls_callback:1;
 	u32 indirect_target:1; /* if it is an indirect jump target */
+	u32 non_stack_access:1; /* instruction can access non-stack memory */
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
@@ -1671,6 +1672,21 @@ static inline u64 bpf_map_key_immediate(const struct bpf_insn_aux_data *aux)
 	return aux->map_key_state & ~(BPF_MAP_KEY_SEEN | BPF_MAP_KEY_POISON);
 }
 
+static inline bool bpf_is_mem_insn(struct bpf_insn *insn)
+{
+	if (BPF_CLASS(insn->code) != BPF_ST &&
+	    BPF_CLASS(insn->code) != BPF_STX &&
+	    BPF_CLASS(insn->code) != BPF_LDX)
+		return false;
+
+	if (insn->code == (BPF_ST | BPF_NOSPEC))
+		return false;
+
+	return (BPF_MODE(insn->code) == BPF_MEM ||
+		BPF_MODE(insn->code) == BPF_MEMSX ||
+		BPF_MODE(insn->code) == BPF_ATOMIC);
+}
+
 #define MAX_PACKET_OFF 0xffff
 #define CALLER_SAVED_REGS 6
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 65b441e4a351..73fb3ffc18e3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -213,7 +213,8 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_prog *new_prog, u32 off, u32 cnt)
+				 struct bpf_prog *new_prog, u32 off, u32 cnt,
+				 struct bpf_insn *original_insn)
 {
 	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
@@ -227,8 +228,15 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 */
 	data[off].zext_dst = bpf_insn_def32(new_prog, insn + off + cnt - 1) >= 0;
 
-	if (cnt == 1)
+	if (cnt == 1) {
+		/*
+		 * A non-memory accessing insn could have been replaced by a
+		 * memory accessing insn, systematically mark it for non-stack
+		 * access
+		 */
+		data[off].non_stack_access = bpf_is_mem_insn(insn + off);
 		return;
+	}
 	prog_len = new_prog->len;
 	env->insn_aux_data_len = prog_len;
 
@@ -239,8 +247,25 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
 		data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
+		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
+			data[i].non_stack_access =
+				data[off + cnt - 1].non_stack_access;
+			data[off + cnt - 1].non_stack_access = false;
+		} else if (bpf_is_mem_insn(insn + i)) {
+			data[i].non_stack_access = true;
+		}
 	}
 
+	/*
+	 * Last slot instruction could be a newly generated
+	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
+	 * if it is not the original instruction, otherwise keep the
+	 * original marking
+	 */
+	if (bpf_is_mem_insn(insn + off + cnt - 1) &&
+	    memcmp(insn + off + cnt - 1, original_insn, sizeof(struct bpf_insn)))
+		data[off + cnt - 1].non_stack_access = true;
+
 	/*
 	 * The indirect_target flag of the original instruction was moved to the last of the
 	 * new instructions by the above memmove and memset, but the indirect jump target is
@@ -306,6 +331,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
+	struct bpf_insn original_insn;
 
 	if (len > 1) {
 		new_data = vrealloc(env->insn_aux_data,
@@ -318,6 +344,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 		env->insn_aux_data = new_data;
 	}
 
+	memcpy(&original_insn, env->prog->insnsi + off, sizeof(struct bpf_insn));
 	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
 	if (IS_ERR(new_prog)) {
 		if (PTR_ERR(new_prog) == -ERANGE)
@@ -326,7 +353,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_prog, off, len);
+	adjust_insn_aux_data(env, new_prog, off, len, &original_insn);
 	adjust_subprog_starts(env, off, len);
 	adjust_insn_arrays(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f585ceb2cd5..5b51e7ee1a3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3273,6 +3273,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
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
@@ -6417,6 +6422,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
+	enum bpf_reg_type ptr_type = reg->type;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -6655,6 +6661,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				clear_scalar_id(&regs[value_regno]);
 		}
 	}
+
+	if (!err && bpf_is_mem_insn(&env->prog->insnsi[insn_idx]) && ptr_type != PTR_TO_STACK)
+		mark_non_stack_access(env, insn_idx);
+
 	return err;
 }
 

-- 
2.55.0

