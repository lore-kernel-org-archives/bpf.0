Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83438BF95
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089221; cv=none; b=UNsWKopvyD4/0RZX5TQNCfH3s0y6wkDnD6V9oNbuaaDbm4aQI940unctEG7Kc2CC0INVxDb4C7fWYen5sqmIXmigEKlje1vZWHB9RI2VRI2HV78v0BX2UANcAX7TW65jf74Nxcm+ek2FDF1TqeyeA9o0zmwE+mUCgQMXvd4L//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089221; c=relaxed/simple;
	bh=2iX3dKAMS1oZ5OwbOCcsitkuKGk+awvjZ2AJ28l/3ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOAGh+LHYkKc33i5HQQ4kAFS1afcBt2RPbK250OPn2ftlX+281wkmwilKY81qBz2YjuzAnpdDEiig/fUK63n3R5VoF8xGHHiCLquK5emjEtg6kLvgTtEi9ctILJn550Z+BZQ1YSWXp+QTISDrCSO+BJYZLUqLjM3m8STL8ML7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXdyJk3c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXdyJk3c"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9f2ee29aso3028575ad.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 23:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772089220; x=1772694020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3XzNgCljErU8AUCuaB5WM6VPMtS9wlKZ/3vC39jEL8=;
        b=nXdyJk3cb8NqsC3peg640XlcNNxW3ta/T5s1ZzGmQOkuSF2QO6r9mQCm5vktv8KrSN
         szfkCzTqwkXFl8fojxZ3XExH7HqOWQsRGnppSqko/a8hiYidnqSZb3HqycyQVPwi+qEJ
         I1mkT2bAqrhcEb+YAznbw0tcphtsHuuIOQXTfLK78i710f8fepuXt58wcqqvZG1G61bx
         IP8TOWvXxdWx7KP1fVAViPFSR8WTWIg0heSLkBt8+vcKsBWoCZ2+xl9KbdjQBtbiHHuy
         oDzPxZ3UTM4laKkFWKsvQq0rTPdf88fRDVCoZy8Bi84U+liV8MzL/F9FoHHOuPeXgK8v
         o1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089220; x=1772694020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3XzNgCljErU8AUCuaB5WM6VPMtS9wlKZ/3vC39jEL8=;
        b=SNJDIEYz8e3yCN9+N3pGrPO3+4zFsdB/6QYxmCguDfufxd4bkMxkiQm0zMKRWmwjtP
         4loRcVZx83ugTuT70b5ofWIsDqQkHkneZO9OJNdlQfxqlz+vIe8tyvECypOfmTiXf0bP
         rYZPTVwlyeUXT9QKh2eX9u8I7ZNbQAjAMwmx42Pvy4t/P0qcJr5MCC57vo2icNyvz9G5
         OU82bVDOBUCMTwdptSNhBbzPwN3BaAc7b8/qsWHPYtq5wQhtGTOk4O802qaBIMrn7fkk
         ra6Mo/wPPanLH2KJd5e4C9JQ28ag52gkulCtOooNOPrYzXkE9k5r41e6ecaWsL3N+uIQ
         0zww==
X-Forwarded-Encrypted: i=1; AJvYcCWHkbYd9s8Ltck2VkZ6S9/N+5fyauRbciqrSg2xa7w8JPMxdEtVkniEyQICkZkSJlS+MDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZ+7cC0lJo7Y/9dNko2uwWhmSnTIj+Pu+HPHbakF4xbJlzyK7
	Dr85aQN4DWGEpE6OvSnxJOL/e+ViS/srpQ030U7+wTbJ6hLq8P9QDFWy
X-Gm-Gg: ATEYQzxUQTHEOdaouOrTwqpjMUVg0B6WEsoDDg0oUoOb/7zW6LcFzHGJyi02d9i30Vz
	kDFHb2vdZu/Co0vbF99GgMfEISpjxiP8RRKSn17IQvWlJvT3QnPQHEUfaWta9nmD92QprqyY+eQ
	TjFx5bp5dhudF+mEVKKCHcMr64yedbX+or7mNGXWcoyNsX2l/3GdoK8M4SoMuoJdlykBbDNewSu
	yJH+DPoHvaidNJ/oDkQlR9fTDbclBU3hlQV1o/3AFOWrbOAud+qbLp3N/dz4LCEM4BRL1gpeUa2
	CvNqP1iDF5ko+vIuIsRPkJ2ptFAwM+1cMegK2E9hCZrNqBKXKcxNT332emqqQ4O/RAafFJ3gJmS
	/SIlhWDvRr+pJYPzFEd92tNucM+5DzH0NmK7MqbYasj65+kn46paXcB4cZizS4u4qH08gJDkH4q
	6Rfw9d1jggGlRMe5TI7TkaMFgnAiF3T16cmyJSlY4kOOEP8UX+ey4Au2jePmtZ59DpFmav/Q==
X-Received: by 2002:a17:903:2c5:b0:2a0:c58c:fdd2 with SMTP id d9443c01a7336-2ad74516011mr183336305ad.26.1772089216915;
        Wed, 25 Feb 2026 23:00:16 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2adfb5b2296sm14803135ad.5.2026.02.25.23.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:00:16 -0800 (PST)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	menglong8.dong@gmail.com
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH 1/3] LoongArch: BPF: Introduce emit_store_stack_imm64() helper
Date: Thu, 26 Feb 2026 06:59:49 +0000
Message-ID: <20260226065952.4082859-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226065952.4082859-1-hengqi.chen@gmail.com>
References: <20260226065952.4082859-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper to store 64-bit immediate on the trampoline stack.
The helper will be used in the next patch. Also refactor the existing
code to use this helper.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3bd89f55960d..e3deb0da6a50 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1480,6 +1480,12 @@ static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
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
@@ -1488,12 +1494,11 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
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
@@ -1726,14 +1731,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
 
 	/* store ip address of the traced function */
-	if (flags & BPF_TRAMP_F_IP_ARG) {
-		move_imm(ctx, LOONGARCH_GPR_T1, (const s64)func_addr, false);
-		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -ip_off);
-	}
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -ip_off, (u64)func_addr);
 
 	/* store nargs number */
-	move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
-	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_off);
+	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -nargs_off, nargs);
 
 	store_args(ctx, nargs, args_off);
 
-- 
2.43.5

