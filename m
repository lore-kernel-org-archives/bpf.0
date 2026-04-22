Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9A1D6DA9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900266; cv=none; b=Flm6yMtfiM7Lk4Lkag1/XBhtdhYkZXbUVyxtqXcZwVo19v1hfvdJvjHRGjSs8oIWBclqHg7DobLn0/0JFBvq0fpwA660KmCjh4yctOStG36t7b83fQY+UYk0BzAJ/KOk43i2gLNje4a2v56yn06H6yOQRquAO8aUbiz1kuqnsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900266; c=relaxed/simple;
	bh=JwpPiWcxvNYKN4lMFNrdi3d/uL9NCRLy0XsGhPfvJ9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prSc5SmAasDSMqU5SqkkZrD5ukfSbamXHHLuD+CRVNtu79mVMpNarcINArQuod6jGcyP+GPY/k+D1pjuo8lzJTKTgsVPuMaG0nguo+Y8QQQnsoxzOux3FqGlkwSXHOsle94fx7F/1Agd5+h6GTwP3vYTjVCLEwJwVVyCeWDOYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIerEnwS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIerEnwS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d965648a2so5236914a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776900265; x=1777505065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTdBaz5QYX32iuAyyTR0YlGvwz+tmN7qZW8Yt7w0+5s=;
        b=aIerEnwSzCrb/WUa9z7yjjuIYMxsNqpmO1Br8HFXC4eY0xDkuy0DigubqmoQhdEElo
         Aay8kf6/z/SpaFBkre0ch0vAVI4eyRaWew+32jmdfqRsjILCTcqIvX4QXxqsSFv0ts9j
         OA7Asxva6+oqyMZfclysck+kpPUBvPtDsQsSTokOAZV1X9FuC1JS8gV0yaX80tIrxqsi
         pFk5EN1GgMFO0+3AT8ulWRRm9JAQsRmVeUxu9Oa57F/lmqBQ9r1nunbXa1m2ebPC+DlD
         8XIPgOCnThGAPg3LxC3yOt8T+5WMCUwvCBLwPJbDYimdBU83wLm7rD3S+WiT/wMZWgNl
         eHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776900265; x=1777505065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTdBaz5QYX32iuAyyTR0YlGvwz+tmN7qZW8Yt7w0+5s=;
        b=AUb9vfewnF/SzUEn3rF/GSTns7okpnY9EHXSSvcV3/b+J1YKKYqMLVXA9/7kVYjruk
         ZJLOqg1HUvok2xcn4D9gwb4Ji7lwhFKwtOaVU86iSOrGGAkY6KRssRu0Z/kf37cI0Vty
         oqZPUtNbmyyRj4jVbj87lw19n0np/D+Ep8otP5B9WEthbs+gKTWbi2SAs6Xv8rSv848R
         EBp5PJIlshLbsLE9rGpLpIODaM1AVLShEyidQ2w3jsr6ruVscTdctY8kXr7UtjcjyMQL
         V3vP0oPqj1RaWIR2E6nkB3y7ZZlKcAsPccNfTYusoGUH7H2kV0/KfkyveAbBvgRErgv8
         PYoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8J8xsGjxZalAbKqWNWlJAl0fHbyK2MBekLk24E1sLy0NVorogqdjmHZR/NZsvUAYVWe3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlTWsfE4fMPNH7cTKrQU37w0ny1cCaKZTJSYkOBhaj87a+h6N
	+cA+CaeX8fPlUgEpWBjYF6K6R2g4g6Gx2svLxVqZ8A8FmNOkYEBoAGGW
X-Gm-Gg: AeBDiesnkd9FOayVlyJVLQ8fvUsIGYhFm/m0Ly7BYPJQpl/ILVdWTmlGuj5nxtH5wAc
	UxKu85tmsXEMrqCHF48kiLyjUZq4Gya4fpprjqhSwvnEkaB9GKX4q4+l99QSOScCoHXAo/eKr+D
	rJLZ3W75R9d+tkSTn8HPWhrlmzb4jP4R16Zfzxehq3zYh6+7ifXL4k9AaSwnAsWRXEczmQ0i7R5
	8zMofhHe03vuHsYwJYopWzlvXgC5RG1KSoft5Ao22dYcybKJUlYTWvwRID8QRsoxqbHunmYCJ/w
	C6fYqGN1dWjdyYO7ZNGFbj5A8kbAipIckb+ACBRL7T3LTTuY5/cLMJLd/uXOUJVGLK6fpr2qyPC
	4CWEyRqAT4nG5ioF3fupVBZ3mFPIVK7obRiKGALAV7xjvXcg+9cmFbEMa3bk0SXfTBOpPxKb46H
	BorFIJ2/CU9i+PzjfOXtKC4khVP28xE9UQ7206LMC3KA==
X-Received: by 2002:a17:90b:1809:b0:35d:a3b4:2f00 with SMTP id 98e67ed59e1d1-361403d53bdmr24978742a91.8.1776900265019;
        Wed, 22 Apr 2026 16:24:25 -0700 (PDT)
Received: from VM-0-17-ubuntu.. ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f920e1sm13776248a12.2.2026.04.22.16.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:24:24 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
X-Google-Original-From: Hengqi Chen <chenhengqi@outlook.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	menglong8.dong@gmail.com
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 1/2] LoongArch: BPF: Introduce emit_store_stack_imm64() helper
Date: Thu, 23 Apr 2026 07:24:06 +0800
Message-Id: <20260422232407.3862942-2-chenhengqi@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422232407.3862942-1-chenhengqi@outlook.com>
References: <20260422232407.3862942-1-chenhengqi@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengqi Chen <hengqi.chen@gmail.com>

Introduce a helper to store 64-bit immediate on the trampoline stack.
The helper will be used in the next patch. Also refactor the existing
code to use this helper.

Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 215c5fb339b0..49dd3e1fedfe 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1668,6 +1668,12 @@ static void restore_stk_args(struct jit_ctx *ctx, int nr_stk_args, int args_off,
 	}
 }
 
+static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off, u64 imm64)
+{
+	move_imm(ctx, reg, imm64, false);
+	emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
+}
+
 static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
 {
@@ -1676,12 +1682,11 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	struct bpf_prog *p = l->link.prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
-	if (l->cookie) {
-		move_imm(ctx, LOONGARCH_GPR_T1, l->cookie, false);
-		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
-	} else {
+	if (l->cookie)
+		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1,
+				      -run_ctx_off + cookie_off, l->cookie);
+	else
 		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
-	}
 
 	/* arg1: prog */
 	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
@@ -1920,14 +1925,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
 
 	/* store ip address of the traced function */
-	if (flags & BPF_TRAMP_F_IP_ARG) {
-		move_imm(ctx, LOONGARCH_GPR_T1, (const s64)func_addr, false);
-		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -ip_off);
-	}
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -ip_off, (u64)func_addr);
 
 	/* store arg regs count */
-	move_imm(ctx, LOONGARCH_GPR_T1, nr_arg_slots, false);
-	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nregs_off);
+	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -nregs_off, nr_arg_slots);
 
 	store_args(ctx, nr_arg_slots, args_off);
 
-- 
2.43.5

