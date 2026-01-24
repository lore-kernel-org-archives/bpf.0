Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C826E719
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235677; cv=none; b=liKit08jhFWsPq21aaGWjy9dFx/QG83Ix9NPTsuOAr8pJcBCw8eD5Kzjh0J78Mxq5D99i60MbyC5MQUkJA4I9+jot92C5c7iEX2BpHQKY+DuyrDCSkDGdwu+eOOdVSWY9FRG1pzyg8aXl0Hk5msZZV1FPGSYsFshScS8o2Z2iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235677; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6MhsX1KGUjkrSnI0GnczR2zH9WqocPMHCD9q4uT+9AAtiEtAZB6BZsdNnedbPmRGAlXTXb9KYhOAxoEjzibJ3z2PKZRGx4qtxoG7I/eGcUUFOwB2+p1TnRlttGJfFuR9KJKtqbQMaS7WcvUIMdcDfxC4WuJF6xpLy+GyugpPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAnOG9jN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAnOG9jN"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a12ebe4b74so31152795ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235675; x=1769840475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=GAnOG9jNJ2TOgwjjI475jP2tsUk1AIN1smo/Qyx34s+JXA9DgjvdBcYZZzZlssUDrx
         mvE5RIwQkVQhRXtkKdOZ/wR0s+8/TDJ/u8odXMpIuJX15/9gb+g7xu1cCUbgzgmQhaT7
         jF+9mLVLsyoHDe88oIdhOW01CsG5Kev8REsm5ZZyJVeGWsvQ8vp3AhLe6x2zX5jjpgPi
         2kg7RfNdPxxOVa2XsAMcRoO9LzgPmkUG3r3niNphoRSHHtqypgKT4aljQRxm2N7WqOaG
         6/xDkQ1VFR+D7PO40wHhmFC3SPI7Npd81Rlk4nnM1fD7N9HCbdag8hAbbftldrNm9YwD
         RAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235675; x=1769840475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=qqPGn1nA5LvkGD0OAzPV2z+qhY1lzsbiygK9bhqHl4QmWAj7OL1DtxLKlXOGsV9Anj
         W5OaJ98bwenZdASRgWrSTTxtgt+DeiI1Y+EEzSYfgJ0hvDWZP3W3+x44U50tGc/o2/dQ
         x+2z3hKIUS9sV8yWIktCtK9O9+XHdE1vmbe6kZRio3n0xy0HmUsUeC0Xi9/mJyburjV/
         sIXmLI7FvARK6OgdLuyOwy99cv27ktPuHhC8w91mMr7BGZMQofpE4lIOXtB5bDG5ZtKT
         B6CIuXHcDoOtjblHEh/PiIrMH5kuXn08ihwPv2MqFscyWx9ZWlulPZxHj75YRKWqDeSG
         6QPg==
X-Forwarded-Encrypted: i=1; AJvYcCVhywOkXYKFxq7mlKXwKJGe36tveJy6wyNZdJK6AFspOVGzyRFK2RGwrkgHIntXEXaBp1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBR42/kJcsJs4inos6w1+wX+qjUlfOhJeN6YmKsy5TeEKlG5PQ
	jIr1iDWjdyPJSTHGId4EseZburiOQ63D7AVed0GP3rs1trfCCERUt0Fw
X-Gm-Gg: AZuq6aKBoLEtVw6sa6vlBOnsPjRlxS4GrsPIaztqAF1z96P82C3TK02Dh0Lz/7GJuIn
	lH2ge7o6IxOa7+wT6xXApMwk3SruhXHFJBF41yE8kTxwP8rA2AtuRygtAC7LfCGsPP4+tSoNCzB
	eQAOp0k5c/8tuja+OTYoXVWUKWlrGpANDIaXlILNrtrQICUHXPbdCl6GTIpkFwOvqK+PFh+OH4p
	a+AsMQQlpAtQpZpRHSd28blkhIznAh7GMOHEepvsjevHRLRCbym1zaWt+3/QIL0zMwcU20j5qg2
	zUGEajyvU2MsBakQ7jaxEEcMhiXPKSke67sECWJdFyIegphQIo5on87qeuvcX7Ch/U/QAFKMABh
	viuxOIRpgPhG0TxAWwob4EdPYWKI3LKVfn2C6kSGIKPrzuBwEVEDmmc729E0EuaV+u8CRgSQw83
	o9I52JBO5R
X-Received: by 2002:a17:90b:4c4b:b0:34e:5aa2:cf61 with SMTP id 98e67ed59e1d1-35368c436e7mr4201938a91.28.1769235675250;
        Fri, 23 Jan 2026 22:21:15 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 06/13] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Sat, 24 Jan 2026 14:20:01 +0800
Message-ID: <20260124062008.8657-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the helper emit_store_stack_imm64(), which is used to store a
imm64 to the stack with the help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- add the "reg" to the function arguments of emit_store_stack_imm64()
- use the positive offset in emit_store_stack_imm64()
- remove some unnecessary comment, as we already have proper comment in
  emit_store_stack_imm64()

v9:
- rename emit_st_r0_imm64() to emit_store_stack_imm64()
---
 arch/x86/net/bpf_jit_comp.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..2f31331955b5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,16 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_store_stack_imm64(u8 **pprog, int reg, int stack_off, u64 imm64)
+{
+	/*
+	 * mov reg, imm64
+	 * mov QWORD PTR [rbp + stack_off], reg
+	 */
+	emit_mov_imm64(pprog, reg, imm64 >> 32, (u32) imm64);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3348,20 +3358,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
-	/* Store number of argument registers of the traced function:
-	 *   mov rax, nr_regs
-	 *   mov QWORD PTR [rbp - nregs_off], rax
-	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	/* Store number of argument registers of the traced function */
+	emit_store_stack_imm64(&prog, BPF_REG_0, -nregs_off, nr_regs);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
-		/* Store IP address of the traced function:
-		 * movabsq rax, func_addr
-		 * mov QWORD PTR [rbp - ip_off], rax
-		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		/* Store IP address of the traced function */
+		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0

