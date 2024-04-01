Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0B2E822
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014686; cv=none; b=hS4qVbq/C2fZ60tQmpmTiEqmEySR+i3LGcHwX36tYSmO5r0uSqTDE251JKQLOUZJs4ym+DXT7jO3XIE2UtahlH+Upzvdr5JA/M/FaRVM2jrn1SElLaJjxYrxSuHWMF0M5cbzPw8hFHO0+U9XGpnIRF/CW5uaCyhkxaIdU7HUTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014686; c=relaxed/simple;
	bh=h1Dcxii0c9q+Agwc8LW+EsTfR3hyriFkF4VTb6VHmdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oC2SQ6nYqCAwGxMV0W0YRvBZ93Nod5pinvylvGGiDQWAmlmXAcK1Fh4ahdbdAkEzmNhs7WUvp4kZyNSuH30Jsigv2kNbfRFPZyZ7aXH6Cjcna8qt88CAvKpGl8sQ7AuLsxhp9WVXaFHwLICHH+02uqcSXAXDf9dxPNy0hwXz/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlggvF+t; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlggvF+t"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e709e0c123so3946884b3a.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712014683; x=1712619483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp6M9zNJ3NXQ3cehTLFz4vNWCdrYXCS3WpSIO6CZgXE=;
        b=GlggvF+toMQeyIe5uOhxdCabWLnrm7AzOeMExwYIZuKeBRx+cRfEp/ev3JaykEVX/d
         FNHl+v3GLxlEp1gltdGjKepTVO8Y4RkatcdKTlsY5BsXHAP9lQ2HAl7k5gpas2g9yk7X
         SJ8nwMcP1/7OSdWm+vl33I4FBOnQC2Mj5DkikLyZVND6vzTjunEbAtOQlM3mDYBJPx2Y
         XEKpbbXkPGcui0nk5BzDTRr6LGftqPGyb1aCjLPji1DQEGAE8wuk32+NNJcbSibHnQZ9
         y7NOOgUHQCVJw9XUMJ2u/vl2McGnLj3kyWY+c7yAT2L6f3MeiRRLw0CNxKXz9S/v4icN
         EnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014683; x=1712619483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yp6M9zNJ3NXQ3cehTLFz4vNWCdrYXCS3WpSIO6CZgXE=;
        b=cPd+sTu7dAO2Y4PFItlnwFkYSl+HnAlMD8vLJW25PVQic3VuOEBJrVgvv5JFmrKRqV
         gtZ8XN7A/pbVYL84wxPa4eEOo4S8XxzLN0LUWBMEBPeJHSn8+hDlm78k+TNsWRbA7I54
         c4b4YmbZ0tRmCa8+DwCyPKQWhdO6fpE0z0KbNMNz0uMb2jilOTgRbqjEmGK6ME6iz9XN
         iGiyPA2Zfxm/JeDz2daxkWUFH7tVwxzMpCVQYKUcXCuId8YLi8E9itE85xvZ6XqL5O8f
         tAT/d9hczjEVeyN83QhCZ9dY1mB5OhuIJVPNe2lRByLzS08hX+yh4PkADMIjsDv+9IGN
         sCDA==
X-Gm-Message-State: AOJu0Ywa6JSqS2XEHphOohZomBA6aHP7zEReif3RzsuNDFEHHfA6HW3e
	UyR0K5unY6zGnYp+7+2ErIjrzRb5dJwe2611tPJSrihttTTFVlM6qxe5mghJ
X-Google-Smtp-Source: AGHT+IHUId4qM2QWksStbDwwuSgm+UYi0LjYYUgh7zXbb18zXE2xMupEPMtBWWh9gWDbInkZHYXHwQ==
X-Received: by 2002:a05:6a20:258a:b0:1a3:4d0a:35c0 with SMTP id k10-20020a056a20258a00b001a34d0a35c0mr10132675pzd.17.1712014683274;
        Mon, 01 Apr 2024 16:38:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dbca])
        by smtp.gmail.com with ESMTPSA id o11-20020a635d4b000000b005e43cb66a7asm8375296pgm.87.2024.04.01.16.38.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Apr 2024 16:38:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Optimize emit_mov_imm64().
Date: Mon,  1 Apr 2024 16:38:00 -0700
Message-Id: <20240401233800.42737-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Turned out that bpf prog callback addresses, bpf prog addresses
used in bpf_trampoline, and in other cases the 64-bit address
can be represented as sign extended 32-bit value.
According to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82339
"Skylake has 0.64c throughput for mov r64, imm64, vs. 0.25 for mov r32, imm32."
So use shorter encoding and faster instruction when possible.

Special care is needed in jit_subprogs(), since bpf_pseudo_func()
instruction cannot change its size during the last step of JIT.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c |  5 ++++-
 kernel/bpf/verifier.c       | 13 ++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 3b639d6f2f54..47abddac6dc3 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -816,9 +816,10 @@ static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
 static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
 			   const u32 imm32_hi, const u32 imm32_lo)
 {
+	u64 imm64 = ((u64)imm32_hi << 32) | (u32)imm32_lo;
 	u8 *prog = *pprog;
 
-	if (is_uimm32(((u64)imm32_hi << 32) | (u32)imm32_lo)) {
+	if (is_uimm32(imm64)) {
 		/*
 		 * For emitting plain u32, where sign bit must not be
 		 * propagated LLVM tends to load imm64 over mov32
@@ -826,6 +827,8 @@ static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
 		 * 'mov %eax, imm32' instead.
 		 */
 		emit_mov_imm32(&prog, false, dst_reg, imm32_lo);
+	} else if (is_simm32(imm64)) {
+		emit_mov_imm32(&prog, true, dst_reg, imm32_lo);
 	} else {
 		/* movabsq rax, imm64 */
 		EMIT2(add_1mod(0x48, dst_reg), add_1reg(0xB8, dst_reg));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb650667f44..d4a338e7b5e7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19145,12 +19145,19 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		env->insn_aux_data[i].call_imm = insn->imm;
 		/* point imm to __bpf_call_base+1 from JITs point of view */
 		insn->imm = 1;
-		if (bpf_pseudo_func(insn))
+		if (bpf_pseudo_func(insn)) {
+#if defined(MODULES_VADDR)
+			u64 addr = MODULES_VADDR;
+#else
+			u64 addr = VMALLOC_START;
+#endif
 			/* jit (e.g. x86_64) may emit fewer instructions
 			 * if it learns a u32 imm is the same as a u64 imm.
-			 * Force a non zero here.
+			 * Set close enough to possible prog address.
 			 */
-			insn[1].imm = 1;
+			insn[0].imm = (u32)addr;
+			insn[1].imm = addr >> 32;
+		}
 	}
 
 	err = bpf_prog_alloc_jited_linfo(prog);
-- 
2.43.0

