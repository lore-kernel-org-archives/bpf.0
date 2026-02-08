Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671F13E02A
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 05:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770528819; cv=none; b=CJW+CkHtIoCUYYD3JNWAS/D/1MY3TlY45cJqPBJOv2T6wwzVTEGKYXikW/o8tAKXo/EnHo9fjOEog4D+JfMW9+jEU2fV8ZyjbJUDAiRDBymidyi+91U0fJvcNBU/w+J3OSW0T+6cuEwcasYD7mrgqi5Dh7XczysS9PJMbn4lC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770528819; c=relaxed/simple;
	bh=w5NGJ74MU5R3R7DpzqJ2S6IYEkng2ht1IhcPzlGqqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2SDchJSOhAtbu97HRZnP1gg+Cga3bT7ZlYWC44l0NwmAgVMeq9l4F7wEvtO9vuxeZiQrLcMs3BTP444vD61Zj7mw7yTaNi+mlRvzV35ffjyMe9f1H2SOGPv0ResPBmLMo6YyV6o1fjNIraC7FvVUX8GUCBBecIhlNaQiVSnPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHUyP4NB; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHUyP4NB"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8230d228372so2033388b3a.1
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 21:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770528819; x=1771133619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5ZW0Lp2uS+rJ6cqos6DM9CIgCyO+gQDhoGFyA1Jyks=;
        b=EHUyP4NBoGN4+XwzfP5woCcMdB9jBrh8cpVos3rrhvHMorS6Ke4mgh9UzE8+RwBJkl
         V0rIz/slOaF3Gguyetsx+dJor55wlQbzKd+CANNPtPzNzFrs9c5Ym6sFHhbvbpOTaooh
         vNuyzPMbzB9Gg+lCEVxmM7duuYUWQ+GK3TZb4qAtotRMWu7Pxi3YumI9lv8a8A3rQY0o
         yJGxhnNFjrsbWOuxMwRKHY/nkTOty0iHmxnrzTbmslqTxC3gWXReg3pKHvzF2FGDaUEu
         jBner1dvUQLaG21c6A9yyeTEkpjxq2hcpx1SthWkgUBy1FbpJV8FDPaz35Cz/VoQX7aK
         md4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770528819; x=1771133619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5ZW0Lp2uS+rJ6cqos6DM9CIgCyO+gQDhoGFyA1Jyks=;
        b=A4Cpd/Mkm+9osMQJcu+iPl42MvCVCB99xB6S8PFfq/IQBxsOC+f1lzBqEZyGU8QugM
         2J0qVHPHcCTr9rxlDBSvwKkG4Y4BR+A/9F3y95fHUtLIQ3WHmmgoMXKIeFWsXbD/pzMB
         szIrlr9mYBpSI0k4Yhsf4Vi3LlEpMOjGatvt9thJFrFs2zAYGH+vUxENf5JolsLssiAZ
         zzzcoBdRGd3EPN/uohpzQLidm1kPhPm0g0aP5e4t/GbneB/UfvFxPmRxPckcGkHN3VR3
         G+1IfRM0L7QHGi9Kuo8iqcupGuc441poLQs+E13A+qTP8gCKny71So6iIVWkeQq7xaP5
         SQfg==
X-Forwarded-Encrypted: i=1; AJvYcCX+svzrDvcxSMDJLmf9CFaV9fz7uw1T9p0oOW8WD1nEzFxNbd8nvWfm80brLMh6MrKhubI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2nFjZBn8tu6l30csO6ZjQRGrrJ+o4KFesmMgQ18/LAnjsGfT
	U88ZBI5JLPkAx7KfZyW/cRq6dGzlGVEvlRhfHel1uvI6yU2NHMG20w82
X-Gm-Gg: AZuq6aJFyiysxDgKQJbbShSyKz9m6a8ob1dsajAAgPKRNhddtoEV5MTh8f7pStmOoko
	ASMVqblRjbo+o3idnh9BLSloV918kkBwMZlCbBWUW8RlP7UZ2XPiUOd1CTVy6aHc6ZhFjMq7drm
	RUJ2ywmqHwU/2SDQPICkuJ62tNoj5hIyUIEHZ7YpwEOaqclz7arqvR0Y19AdB9FP72NAO4QWDb4
	yRL7L4GkEY8S26h0xQHXKJ+3d45HbYC7dAdOYavFHsjPAxNztVrVMDUOdPjDu4lobwxbsv8+9iE
	ArBTVqDt5jQEPbdrSjqH8I94OMiP2T7ZVs1wwBAM4m1haZkpYzcgrpbYniviqC58pdMivGchBui
	OjxpkGOLnNPxW5T9XMMClHD5QTPrG70/FhVRCf8evZ2R+VqOxkt7p7sbk94XG41yOBgN0no6+NR
	Hj9u27kxs/
X-Received: by 2002:a05:6a00:bb88:b0:81f:8084:7ea0 with SMTP id d2e1a72fcca58-824416005d3mr7456957b3a.7.1770528818761;
        Sat, 07 Feb 2026 21:33:38 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418de80dsm6067700b3a.62.2026.02.07.21.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 21:33:38 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v4 1/3] bpf, riscv: introduce emit_store_stack_imm64() for trampoline
Date: Sun,  8 Feb 2026 13:33:09 +0800
Message-ID: <20260208053311.698352-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260208053311.698352-1-dongml2@chinatelecom.cn>
References: <20260208053311.698352-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a helper to store 64-bit immediate on the trampoline stack with
a help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Tested-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 37888abee70c..e4f45e2e7e2f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -926,6 +926,14 @@ static void restore_stack_args(int nr_stack_args, int args_off, int stk_arg_off,
 	}
 }
 
+static void emit_store_stack_imm64(u8 reg, int stack_off, u64 imm64,
+				   struct rv_jit_context *ctx)
+{
+	/* Load imm64 into reg and store it at [FP + stack_off]. */
+	emit_imm(reg, (s64)imm64, ctx);
+	emit_sd(RV_REG_FP, stack_off, reg, ctx);
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
@@ -933,12 +941,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	struct bpf_prog *p = l->link.prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
-	if (l->cookie) {
-		emit_imm(RV_REG_T1, l->cookie, ctx);
-		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_T1, ctx);
-	} else {
+	if (l->cookie)
+		emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cookie, ctx);
+	else
 		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
-	}
 
 	/* arg1: prog */
 	emit_imm(RV_REG_A0, (const s64)p, ctx);
@@ -1123,13 +1129,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
 
 	/* store ip address of the traced function */
-	if (flags & BPF_TRAMP_F_IP_ARG) {
-		emit_imm(RV_REG_T1, (const s64)func_addr, ctx);
-		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
-	}
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx);
 
-	emit_li(RV_REG_T1, nr_arg_slots, ctx);
-	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
+	emit_store_stack_imm64(RV_REG_T1, -nregs_off, nr_arg_slots, ctx);
 
 	store_args(nr_arg_slots, args_off, ctx);
 
-- 
2.53.0

