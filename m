Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FB202F65
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097989; cv=none; b=KbukOrHK8ym3Qzs3c8/MQ0Nz7DmndfOFIWKr9O3IGbz3lt5eaGKUVeUdk37n8/QiAsmCYYybL9H4nTwZe7soXdxWlzpDvP/9YDsbPWHSO1LbxjrWpsc5S98zxkdUK86EvjwQyONusZHa/EL65rrehzwpx2hZcZGPztIpis6FIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097989; c=relaxed/simple;
	bh=TyHw5ip8J9ZAZ/E83UrWMPtW7dVE94KjxJUkg16mWxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmp/J6ACP55Ssuwok/3xdIuPIuTB0FFZy8ytdZREF84MG7uK7UgVZMWpTHMCm5RlnaNg4eUIdPr4dBxba4Y1HGXJd7jkXqPNyAdOIZhwGJwCE4z9VtSldEO/OMG2uMipnCCWpILmhgdf/f5+4Ts6PfYfcUa7Ahi+G0wdQ35oN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdMBh2rE; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdMBh2rE"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8947ddce09fso42765886d6.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 21:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770097987; x=1770702787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uxGWuC9y0ak4TPgoWK6c0g9IlENP1gQKqGkKB74Ees=;
        b=jdMBh2rE6yUuw1UDd8xXDKb474JO1VECATxb0k2oEOS1nei5mzI0MoNzReTlpstjbq
         C+Pc0yAQyK/xC1Elm/hssrOVt0WfM5E1v16MKokoW1S33HWtxivxQMgJAynJcSTBjyNN
         jq7a8YoPcRlM3cYT2hUXtArqN34wtOjGRaLF7MQ5CXQ36Vhv3P/0WNre5FHv+e0biyuc
         Nuh0HqjpYSb1OUxDD6JtcKWNZP3kifa99id3Yn608p9vC1HEeKGurF58BnQ75QHyqBCl
         ANhhxqsdYlZzmvQ0YI0427TXnz0Smwp9DuETC5cPDv2p6SXkFhKmfZJULdPZBtqA5Q1A
         ECvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770097987; x=1770702787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uxGWuC9y0ak4TPgoWK6c0g9IlENP1gQKqGkKB74Ees=;
        b=GldS4xIpl2pDbZtxJ6n3roxc4RiQug0wmVC6hWvfSp6SFZ54LFFxNB+xe0lEtqBDqC
         CDwZXMj03QJgoC5By6ZOuBiJqqg5qBo4vfkEWIbFOl1iWpk9YAyg3m4OoreQW8alAZtu
         SHP0ZOMz+4elfPeV4ZSl9v5tOxXlxEuvUvJf1OREd6UA/MUfcGZV1Ivjo88/CFXxsJh8
         wtJT/dO8UIbDfryGV3fPJ/oyY49UEdPDD4cNKgLtLJggMw5jd/lVbv/tMIBve0ZARsFc
         wB81n2iG7OyKKgviUUgZEW7gMqXl2YjCulkUw0b00QnWJ5VzUa4JIKw8Cnph8v+Ee1cU
         PrnA==
X-Forwarded-Encrypted: i=1; AJvYcCV0LDO+CAXve0tSfL79Lg2vYla2g9OtZhWy3FzGqBcwsJrRKQOff4NtJxTWyBQI7ge4FI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrwcdcasM2GZFwUgbX0fsidCur4QAiU4MT4W8U1tUewWHK0M0
	9W1uC0Yt34UL2yetAvDmM929lm4J6eC9qt8kwMB/KdHI+k78psNpxLlP
X-Gm-Gg: AZuq6aLC4R3MbEG/8LAfkq+1CQIAgC6WLbe10biIQV1xyY4sMjlP/BCvY4w2PTl5IVu
	Y7rgaATDv9pnWmXpUdi7+eFraTRbecEwcytAxKEQhczmrAHcAiYQ9J5SFCabZeObjN/kEDloHNm
	OZoX5JyGKpvvPnanGM9BmLdwV64+8ye8GpGptqlooohnTtZZFdfGfb80dpQV2irpEOZJTy0ns5J
	fxxBHLag3rst9ehfBVUxEfi3cUp9mTcVmcd5zOqGJbtsYQYOSBGsRb5ohf97IAFmDxtTYOvXAxv
	77mvFJFEeE03OzLNdSo4WWcl0PtByvKnSBZi2Rr488SQquA1KOAY4hTosLmIjij9fTYWtIv7b3O
	NVWsNyqGKeOw/Ax0hXlHmzEsnynxGMqoigMYlaYTSVmve+z+B17WyQH06KlPPWfklp0xU1emtqA
	YnGLbGM3dGSscqX7vUpg==
X-Received: by 2002:a05:6214:1c0f:b0:888:7ba5:6b35 with SMTP id 6a1803df08f44-894e9f818e5mr209940796d6.19.1770097986889;
        Mon, 02 Feb 2026 21:53:06 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e65bsm129844996d6.55.2026.02.02.21.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:53:06 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
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
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/3] bpf, riscv: add fsession support for trampolines
Date: Tue,  3 Feb 2026 13:52:30 +0800
Message-ID: <20260203055231.1088479-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
References: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement BPF_TRACE_FSESSION support in the RISC-V trampoline JIT. The
logic here is similar to what we did in x86_64.

In order to simply the logic, we factor out the function invoke_bpf() for
fentry and fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/riscv/net/bpf_jit_comp64.c | 74 ++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index e4f45e2e7e2f..f10418ff6a9b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -996,6 +996,29 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	return ret;
 }
 
+static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
+		      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
+		      int cookie_off, struct rv_jit_context *ctx)
+{
+	int i, cur_cookie = (cookie_off - args_off) / 8;
+
+	for (i = 0; i < tl->nr_links; i++) {
+		int err;
+
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
+			cur_cookie--;
+		}
+		err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
+				      save_ret, ctx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 					 const struct btf_func_model *m,
 					 struct bpf_tramp_links *tlinks,
@@ -1005,13 +1028,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	int i, ret, offset;
 	int *branches_off = NULL;
 	int stack_size = 0, nr_arg_slots = 0;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
+	int retval_off, args_off, func_meta_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
+	int cookie_off, cookie_cnt;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
 	bool save_ret;
+	u64 func_meta;
 	u32 insn;
 
 	/* Two types of generated trampoline stack layout:
@@ -1042,10 +1067,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 *                  [ ...               ]
 	 * FP - args_off    [ arg1              ]
 	 *
-	 * FP - nregs_off   [ regs count        ]
+	 * FP - func_meta_off [ regs count, etc ]  always
 	 *
 	 * FP - ip_off      [ traced func	] BPF_TRAMP_F_IP_ARG
 	 *
+	 *                  [ stack cookie N    ]
+	 *                  [ ...               ]
+	 * FP - cookie_off  [ stack cookie 1    ]
+	 *
 	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
 	 *
 	 * FP - sreg_off    [ callee saved reg	]
@@ -1077,14 +1106,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
+	/* function metadata, such as regs count */
 	stack_size += 8;
-	nregs_off = stack_size;
+	func_meta_off = stack_size;
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		stack_size += 8;
 		ip_off = stack_size;
 	}
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
 	run_ctx_off = stack_size;
 
@@ -1132,10 +1167,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx);
 
-	emit_store_stack_imm64(RV_REG_T1, -nregs_off, nr_arg_slots, ctx);
+	func_meta = nr_arg_slots;
+	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
 
 	store_args(nr_arg_slots, args_off, ctx);
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all session cookies' value */
+		for (i = 0; i < cookie_cnt; i++)
+			emit_sd(RV_REG_FP, -cookie_off + 8 * i, RV_REG_ZERO, ctx);
+		/* clear return value to make sure fentry always get 0 */
+		emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
+	}
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
@@ -1143,9 +1187,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			return ret;
 	}
 
-	for (i = 0; i < fentry->nr_links; i++) {
-		ret = invoke_bpf_prog(fentry->links[i], args_off, retval_off, run_ctx_off,
-				      flags & BPF_TRAMP_F_RET_FENTRY_RET, ctx);
+	if (fentry->nr_links) {
+		ret = invoke_bpf(fentry, args_off, retval_off, run_ctx_off, func_meta_off,
+				 flags & BPF_TRAMP_F_RET_FENTRY_RET, func_meta, cookie_off, ctx);
 		if (ret)
 			return ret;
 	}
@@ -1192,9 +1236,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		*(u32 *)(ctx->insns + branches_off[i]) = insn;
 	}
 
-	for (i = 0; i < fexit->nr_links; i++) {
-		ret = invoke_bpf_prog(fexit->links[i], args_off, retval_off,
-				      run_ctx_off, false, ctx);
+	/* set "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (bpf_fsession_cnt(tlinks))
+		emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
+
+	if (fexit->nr_links) {
+		ret = invoke_bpf(fexit, args_off, retval_off, run_ctx_off, func_meta_off,
+				 false, func_meta, cookie_off, ctx);
 		if (ret)
 			goto out;
 	}
@@ -2094,3 +2143,8 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 		return false;
 	}
 }
+
+bool bpf_jit_supports_fsession(void)
+{
+	return true;
+}
-- 
2.52.0

