Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD230BF6B
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153796; cv=none; b=s0ICyfmPKBJGkv1zY1bJTJHicdLRyoK7iTvCazMUYMwGhF+sf4ObP6MjjE3vALh7spLjaVxdsRikisS/Epe8lTNilusruCRZiMrts/+4spyzzwknlqPx4fvSWVX1Ocv7+wBLcj73ORe3mS5qeYCPCsc2KCOko+cbU3CXbwUCpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153796; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOdgMW5cHZHfGRWtyxoxdEjG64HBUtOwSwSM/8SIK2Ges9loEu8yZovx9fxfx5s9YHGMvFP0mKY5HchiOiMPUv2Y3oHKkLUB2qZ8ZZgIukFdKtQPKuC+Rngo9id4jCxjc4INJP1mdztrFgTX1qQvx/3fy/ZSGYMJJUDCnKQAW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSX2aH+e; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSX2aH+e"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-823075fed75so975763b3a.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153794; x=1769758594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=TSX2aH+eQo/qTm1BTEihbNC/pzELdZetpmmGdTUozZgukN5dWxV2b3cSuSFBBYaz8a
         wTHa3BvJdKy/9AyOTn14g6zSKbZpcwP5KS43PYMPQ69fVZnNTBQIWKpZxVRzzMqJpE0/
         O972XNZp70wnSmz+qD06KvbJ17I8o+AQSq/crp6i/hns1NJ8vkSwI0Drs/3K9I5q4Zer
         LElU/JAgesR/05of76UwKkVMCKY3uCZ/ucbXHkdjNK09lcB/naMLszs/i5JvihvfBqnX
         KO2+NXYh1O2oqdIYFleaCgGJWaP8nMeaArsl51LvFzcjfhw5N+xZW6egbGPjvR4DVUNz
         56JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153794; x=1769758594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=vergKC4W0c9Nnnk5NHwSuuujG9NQ24OyErip1nbJag0pxt/eV2mFmGnWgi2oXbvHva
         W3cUUDTrJgCMqIep/K33cX8S1e0CZyfMfnFWxLM9XBWsT4uFNYU+94lKHeLEbwZp4wnH
         5MrN0IkLd5sxApF9KyjXji3DZPZG7WJzdFLZAs5QD1R+kgo41t71zh98NWgPyPv04cxF
         cDTm2FAReNitMl8/8fpsCHuuJ9rLgZGuLiTpSVpT/re5lRWBNvSl8brULuvFV6ab1l94
         QvbOgN/4hntoukvQStfKY4oXt3zHcZ+0IhrrdqOCAnWQeEIHUkNGrSQGH5tnh0TirsPg
         CRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX88+rA5IrH2hWwXI0ZCr3RqsXkTPxt6ag0Tl9Tte6z4efFx5fnD08OLt7QomQG4mjYGTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7urOXFNp7/PNZmj1pgD+YRBe26YWNKj/YfYc+Cm7l8Z65HRa
	1OQ/ngXZw63QDc9+KCoKF8/NmM7XrLQfDqeq15MH8yApcHiKPc89CfUj
X-Gm-Gg: AZuq6aLYXKeMgBkXPOdS6Y0mGu5FDGkVGcOyf+6IlV6e4xJw+6cbCg7GFeSxz4LzNIw
	ujuSVyiNxkL+kGDluSRvaE6Qtdl95E7g9h5txAxIdZSjmsYs+IOO3QaFEwMQILtF1lr4I+0vUbl
	ogLCA8/uFBdUuvzUONce+jMSuQBs48x/8hdfYTMJT2h1mq8+Jt0cTbi6AiU5AByNFh/0rLpcsI+
	m9WdkIv5M7BzPdya5JW7+MEwXNyUULOTQ+aJw0XM55Bo9QN/3Bm7rQOGRepj1te0QLXCvS4QLbm
	IeXd0N+XXeZIgUKf0u3P7uIgNJn2/ncX3GwYL8kgTxpgs4flszylNFEMCOKlWlBGxhv9kP2DRTk
	j4zCmamD28FWcpjBeOHQluJpIBWIdG+Rcyy9Q0cP7Wt+PwC6YaubmILKVCkNQab4HIKXoKNgZGz
	zt8lZgdfXP
X-Received: by 2002:a05:6a00:1825:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-8219ede8a3emr5462181b3a.19.1769153794191;
        Thu, 22 Jan 2026 23:36:34 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:33 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v11 06/12] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Fri, 23 Jan 2026 15:35:26 +0800
Message-ID: <20260123073532.238985-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
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

