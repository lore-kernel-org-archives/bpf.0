Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E95477E4D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432460; cv=none; b=IT0DyFGPEUXbN53RWhrDg3mkASisbatiESv+XnVGIAmDsxRjKSYXrp1EEkKnxGQ8IWFZoaGLa2+oGz4Io+XOLkH+NYNxvWe65LNHOtZiDj0Pz/VjPHjUnGAwnVI8QDLzmwRJn34xB3ANUjLR4SceqFMsYYfqkyXhwMnZXBPxLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432460; c=relaxed/simple;
	bh=dJrq4PPK0cMlQ9St4R2FDlaSlWgPn+iPKi4G4xGawQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOWPyOMCdTl4I6l6QJkeb+o6SK8S1OYp4ddPXeIr9+6dC/g+/SfCnRAC7XYLaBY/V87RW4Kda9WqU/XKx/siaky+619SFaugBjR+DQnAiODljjqhEP6vBdz3GNjNm/eW8jqLlGH/WtnLD2OW3QxMi32fKIUVhE/NwShrNsLKmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXHHGyOH; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXHHGyOH"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so550609a12.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432458; x=1791037258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTwiMTgL/Vm7bMkKqC5Bs6xg7hIh84yBUUK0AMoCZDw=;
        b=AXHHGyOHLPi6z9xDBVmGmwnDd0c+b9vRej7q7S/UZF9Zw67pDIKP7H2FYK3Wji3P9v
         yCJp284zo2m9G074zg2QV8O9oxrJbBGfLlF5BMq0UREOzvO6J0UD4W8A0/J4b0I42Ywr
         HjoOMDhpV4xgCHVzt5ufoWDim19uWvlBCdmUrYUlkxvzywcA832PdwNKK6Kcccbw4/56
         vRvORF6OI3Ip6L8ZI0UKex1j4XvH3nNqeR5CNGL26ROYi08bLSVcyI/+DdHT3LA2/RCy
         OU235XaVgBzbZRC0BcF7pRPnJjjT8U5YGttLnwIZV4hGuRVTPQF9ljjQczBodXvOPShQ
         l5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432458; x=1791037258;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTwiMTgL/Vm7bMkKqC5Bs6xg7hIh84yBUUK0AMoCZDw=;
        b=sLYA4SP6HH1BjsmnDIwxoXfjovGeEHD2uaT2DLuKrvh0l/9a45nYU8SE7SqVjl0WG6
         MzLPEQGSmTrAFSEDJ/2BTaNMLdyuvGQmG9zlLGczjHKdK1w4THba5j1AxN3XTQb3hacJ
         r0ei3NfOrTgqk3Vm8K0rLYaaKqHdxG9WhbEeaayvT5Z1/E4AUv2wlBJGJ5Y7QapLCI0D
         Gx4ptQSzUwMlak0u9WESIdoAyl+QL4aHbTf4KHkl/BXcN4JjxlIBAR58if7OQk9jCBWq
         TXKqH3K/i1PuImHpXSY7Gs6WE0pUx9puKfL/aZ61gOWPAvXp4AhVYJvFsL7u4flSTFvC
         1tTw==
X-Gm-Message-State: AFq9FYLdfO25jqIWWyHw/OHeJoaQWxZ6euIDhdnnIMlAsJi39HVLDTDs
	djTPIig/d/AZV0Wyzg+L/cESFWbgUm7e6w7AzRdG36rc9CsUEkljVrkE9bVpu8Jm/FM=
X-Gm-Gg: AYBFou2CbwK+xZO08Cn3nYs285ZfAczKRHlSJ48wsQAfiIWpLpwAiginxIyEQdADYEs
	muhQj94+yF7YC9ccOSo/OoLEO1BXy1EnQR4GHJP9tzSPeSbuWzV5nBU3xS0KKMVkY1ZP/yQpvbf
	xqc2BP58iFg6RvAlKpFV9Z7Hfstuc5PzP2EECPVnf5lZSeklRdwVkaxtqoR59owDLIG2VxKp+iA
	4WUw2QL1vhHrtu25OgZGEpX5MP/IA7i/XfZ29aNUa60Quo/JtkYK81NvdSJIPsgKkd+Cvf0Ov9r
	orWZUit1jMtFBLATOJl3x6csxE+W8I0Mk1SW+0NpA5cpxL3FqGx6phfX3HeJ2aL+wZ67NNgbbGM
	q+Fjlh6kxjk1KXNEdA7lnjBiYnfXQzXyt/BSl/WYD/ZCjkYmRFjFEbc5kKGa4tPCKWaz32BaZgt
	JS6Vdb+dM/BkdnugdG+S56b2gvT0sAtx6owqXLFIGlRzDXL77/DHdCitIGDlRd8eUX2Z0IA9tHM
	5Q5WEaYCGE7T7t6AtZxl8JPa6ROrheS9uOfVU5Q5w==
X-Received: by 2002:a17:90b:2686:b0:3a0:e0a5:dbc9 with SMTP id 98e67ed59e1d1-3a0e0a5df00mr1539273a91.62.1790432458068;
        Sat, 26 Sep 2026 07:20:58 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 12/36] bpf: expose comparison opcode transformations
Date: Sat, 26 Sep 2026 07:20:10 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-12-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Expose the existing helpers as bpf_rev_opcode() and bpf_flip_opcode()
and declare them in bpf_verifier.h. The helpers are used by SCEV
logic while analyzing loop conditions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/verifier.c        | 14 ++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 706fdefbc07a..075a28de2a04 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1858,4 +1858,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
 
+int bpf_flip_opcode(u32 opcode);
+u8 bpf_rev_opcode(u8 opcode);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1ec44d72a346..79aa92486154 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17249,8 +17249,6 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 
 static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
 				u8 opcode, bool is_jmp32);
-static u8 rev_opcode(u8 opcode);
-
 /*
  * Learn more information about live branches by simulating refinement on both branches.
  * regs_refine_cond_op() is sound, so producing ill-formed register bounds for the branch means
@@ -17259,7 +17257,7 @@ static u8 rev_opcode(u8 opcode);
 static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode, bool is_jmp32)
 {
 	/* Fallthrough (FALSE) branch */
-	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
+	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, bpf_rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(&env->false_reg1);
 	reg_bounds_sync(&env->false_reg2);
 	/*
@@ -17445,7 +17443,7 @@ static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_s
 	return simulate_both_branches_taken(env, opcode, is_jmp32);
 }
 
-static int flip_opcode(u32 opcode)
+int bpf_flip_opcode(u32 opcode)
 {
 	/* How can we transform "a <op> b" into "b <op> a"? */
 	static const u8 opcode_flip[16] = {
@@ -17476,7 +17474,7 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
 		pkt = dst_reg;
 	} else if (dst_reg->type == PTR_TO_PACKET_END) {
 		pkt = src_reg;
-		opcode = flip_opcode(opcode);
+		opcode = bpf_flip_opcode(opcode);
 	} else {
 		return -1;
 	}
@@ -17531,7 +17529,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 
 		/* arrange that reg2 is a scalar, and reg1 is a pointer */
 		if (!is_reg_const(reg2, is_jmp32)) {
-			opcode = flip_opcode(opcode);
+			opcode = bpf_flip_opcode(opcode);
 			swap(reg1, reg2);
 		}
 		/* and ensure that reg2 is a constant */
@@ -17565,7 +17563,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 /* Opcode that corresponds to a *false* branch condition.
  * E.g., if r1 < r2, then reverse (false) condition is r1 >= r2
  */
-static u8 rev_opcode(u8 opcode)
+u8 bpf_rev_opcode(u8 opcode)
 {
 	switch (opcode) {
 	case BPF_JEQ:		return BPF_JNE;
@@ -17600,7 +17598,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	case BPF_JGT:
 	case BPF_JSGE:
 	case BPF_JSGT:
-		opcode = flip_opcode(opcode);
+		opcode = bpf_flip_opcode(opcode);
 		swap(reg1, reg2);
 		break;
 	default:

-- 
2.55.0
