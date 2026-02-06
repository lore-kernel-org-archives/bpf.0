Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CD350A37
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379133; cv=none; b=DImnSfsaQQ62+GGdDz1GFftqUKpPEJSqE6+/ZAtO0tjhLUUJk83QupQjHRs3SQA/ai/kbcE/KGQOUtQDKmQMy7lP6FIcLDVPBtoDguVYSMeQXxwWg1VBQmQmUnZ61cVEHKFcj3BMbKsh0MD+6SZGU4C8fYSPrVwHjw5KpCjg29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379133; c=relaxed/simple;
	bh=w5NGJ74MU5R3R7DpzqJ2S6IYEkng2ht1IhcPzlGqqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaUVG6trwj+5nYHJwtp1XnkvnxBpBhsK2vG02sGR1N2GudGx6u9vscEDyhE5yXBc4BzAtok39I4xj29NIHkVk0QCw3blYxhM8UcBfrK3ytHlWoWSr6VAEnFOZfam/lg2PfO6I0sGiZ1dxDfKGDOf5DW+EWANJLyMWn1on6EpKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw8I63IX; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw8I63IX"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a95de4b5cbso361185ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 03:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770379133; x=1770983933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5ZW0Lp2uS+rJ6cqos6DM9CIgCyO+gQDhoGFyA1Jyks=;
        b=Yw8I63IX5uKg6zVHCvSyd3kxa+LTuAgOtLxmRdXxGBQVOejZIzYZ86sZj7Y8+BuVLY
         N+rgDmji+7lEARkZVnCH2+xtUDlcbgZ16l4uLtBRki02MQqnuqVck6U4PebR/EepPtnz
         XC2/vdWsaVUhNo1xya6pW5dDJnFWUzmvoOAM82JnECM0LJoSUMYIqsEB+vNW2n7bNJF7
         oIoQXglB5ZqzJ4EZPTpmo9arNozcc8I04u/LkiQ+V89rqOg9StEWyiQT9jVfRuQK48Kh
         vpXyDkaqejIw+zlYgqf2ev2j+jyz5yxIYin+v4VSgaK+DYY/M9G62Sy/PgnJacflBKuf
         6DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770379133; x=1770983933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5ZW0Lp2uS+rJ6cqos6DM9CIgCyO+gQDhoGFyA1Jyks=;
        b=lVE7fS3tKaYHBz7M8czjymE1/pM/e3pNpvbtVY8+vst/ODXIKEbztdJ4ph4wdvgYQ6
         jv8vx1htgjbNBe4zl/MBYJHCCLkZUbEguw36A3YiFfqUgLZVgscEtt2c0irv58DmmVTM
         5fng291lN7RDoWtvh2ww473R/0QQ16HBm99rVu0JMdy0e+JB+4kKmNV5/F0mysa/RRVN
         oeCvpd5smVZPNs986BuNiCRD2KH1ddF1B3Cj9PT2uv3vZUpSq6m9++k7KbV8bUtdIpQi
         MNKiQ8PoKXZ6LBcTSOhI4HV6qOMohVFUI2BBi8OfRF7Rifb9MbmWE8QN0fNpGjnPmht7
         eCZg==
X-Forwarded-Encrypted: i=1; AJvYcCWSMujBjuu2vZwX5jduNjvK5sg6I/wzv9fpKrvD/V+H6Jz8kMBsD0uEaBkEYp3hzxLbJHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLsH+S9hleVDvSYw93s3vi940CfUjrkMxbcYlXj9ukGW+ye3OM
	MWM+6tqb5xT3nvP4fg9dG+09S9CNCiYsK1zrfFYIbT8/z+JzTJIKWAKY
X-Gm-Gg: AZuq6aJMNy6pqvwN2DSIYsRA7xPhREumuo6Ro3RI/zWnTbW5koxhwnyEFHaqVhaYSVh
	JOzsKPQU3CXeW9eFklJDawcKU6sBTOZPMEzbeqe6jGpcCygIUIKe8I1w6AUP+TGHDHGFNrnY8Xd
	QQi4idNAY5//VwTgJa/tNU6ie6dhBlcqJyesUfDfeBm5P4CYTYbC+7gRpOQweOmo6gFVOBJJLUs
	5MQBqRolRYGjnTPgDqV/eS6XLReK62XAwMkxK6AViCdbT3P8/94XIJFd+rufZkASdDEcYLIraYc
	QgBPMhJ/rdpkPTqj2asSA58LR6sdbMALGv3sSMooCIo6t65mXiV1FoNTE0u1Vo6Wy0h5Go6hJbW
	G7dmC0uRDYRg6XCKR0GeTULqDIlhXotVGwTpIJHUAr8k9cGXJOjCCxi4H2pzvdJjjek79zvOANp
	ApFvixxJxzD4HG/w9B8vk=
X-Received: by 2002:a17:903:8c3:b0:2a7:7c72:42b6 with SMTP id d9443c01a7336-2a95162538amr31216585ad.18.1770379133082;
        Fri, 06 Feb 2026 03:58:53 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8ac5asm22856395ad.35.2026.02.06.03.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 03:58:52 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/3] bpf, riscv: introduce emit_store_stack_imm64() for trampoline
Date: Fri,  6 Feb 2026 19:58:21 +0800
Message-ID: <20260206115823.1070354-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206115823.1070354-1-dongml2@chinatelecom.cn>
References: <20260206115823.1070354-1-dongml2@chinatelecom.cn>
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

