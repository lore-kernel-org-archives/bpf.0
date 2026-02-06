Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39015333427
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380450; cv=none; b=VYNsIDH94Pb1SLKGNCwq4suqSu+0JVGog/ItagUvUlSpUFvZ+wJ2w+r30yCig08g53bzaD00J3Gmy8drdonly8ldbnLF1fMyhOT8g9YQcGGGL1vbxUwM2QgZytmOuFE5xEVpHuzxjgk8dJQT6g1+k+A/ZZ9Kr6VBMqdtF+YcbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380450; c=relaxed/simple;
	bh=BXCB5O0lsl1KDgarrow3CKKlQStgrGqr3H/LA/binx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv9gir2tHYao+NrE8mQw0vkVapzf70w/qRb/7XBA0yIZVwzD+dzCeTEqRNL2H9eDpZthzg2WrRjhA39eP94sopsVX6kzvBPW6763lgQvI98NrjcBWkTnplxr+dKEEqqlzHMF4Rph10b5YA3MeE2iyAO7mCnnHpGyIRfMtGhI6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljvEQZHl; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljvEQZHl"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso1628041b3a.3
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 04:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770380450; x=1770985250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4ky1VoxCCm0IDNE+FK0hSWCiQy7VCZX/E43cmszfqY=;
        b=ljvEQZHlKAnxTO/S5Kr0bYZr9oo6wIUPFJJ81JVaGFa38nzGVZjVenHOx7y+C1oQNp
         /wwA+LzuyEPEFlC7O+imx/0GyBaXMmSTqcnkAD5QwUiuLBe6nGjmJ3zaCKYDpVcN5fYn
         Tmbo0eqS+EjI9dpmgoiAvOCdg7cayW8dFcK1kCYLNzyGRmxrtwVY5zuiPnN5Pu75eeN2
         5K3KhmvgnAgsM7qtthlUlGNqoV1aH3QdGUlHN/hxYfKDYnK/6wbswcTUpNvb7f5yUhGx
         5FCoID/kBZxIR96irJf1QNnJn8md6M1UlHlQ409Zjg80+g2io7jNFQG+N1uJOLZ3V/5B
         v3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380450; x=1770985250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4ky1VoxCCm0IDNE+FK0hSWCiQy7VCZX/E43cmszfqY=;
        b=YlfbBDrVT5zgkX2LQWpeLUrBVnJh43dKgpIDUIyb9509XNC9BP/XiJzU5UhNkWBz20
         5HAFEEyIwP65F2oGhVepeoeKtVXeOivDh/elVbnR7OwGaGhYIp6uGYbSq9escQYbiPyh
         w0k/RGOxt9gGM0jGVKi9aBtrYV6tYPFuwAQgnV4RE2rou3WfLU5LSCpPLrlwgl+bcEyA
         HaR0IbjdfnO8SeZIXHPNfPIa62oPDoif+jdgoK15aif1GWvOGdVv8SpVYNOndb/szObS
         9lsPu67Z+K9ZYVhuR027Ihv5SibgRkk+MqSGzXHk035OuaJXHWNUHTQSEUtLNu/7TAJs
         Qcfw==
X-Forwarded-Encrypted: i=1; AJvYcCXopPUs+x1evFQsPcR6LaESLzaQOdnn+/WO9ZR+Ba1MtnSmA8v12su9teGEUhwfhfsgvZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65NO/oRxjVY+YV1xdhAAF6RJexkNhwU0i0gBxlGrwzn2xjXw5
	kvNOgJvBQMlrjXNmYf1NJMX7JD6Giuae4fwYeMGmBqp+W6LoAJ9Cgj+N
X-Gm-Gg: AZuq6aLEsk8t5mj3lCNG5p/WqZEyN73xqmN6TQBqCKsi73nGIcRSFoziC8BJYa3zSLr
	TeMqNKEg7UVzsbr8Vx4dNbSmecHaO8XHLy5p4h1g3ATjnz1/FM46iZ2Q6xnYCQ5ma+4qXrTalYQ
	xGpKOVGvjxS91L95OmeJajSyEv51r46o0YufIMGL/WBgMw9vt3OFm+zyWTf7jTk4hL3qDkHlAIq
	aJLfMwHd8rS36/A/5W4okiLSl0khZ7oO5CVtlB890HgDgmiZl8BbOd7eULUUPFGHBOJQ7zqKLDO
	U/Kcv6LfxB7+WZDqhAQHiKnR7zeF/eTuO6pmQS2H/4Q/p1xeuoC6A19jUrJgYUZ3s9B4btNArHH
	5eynk102qUguxjXtbu575GrxNXUNeiHt2Mbxd7gvRY4zzBHnv6C1BA/g2tsN8iyvQbN8lbywKwm
	uGsliTOLBFTv9riRhfrqQ=
X-Received: by 2002:a05:6a21:150c:b0:384:d0fc:f518 with SMTP id adf61e73a8af0-393ad44eef8mr2481014637.79.1770380449503;
        Fri, 06 Feb 2026 04:20:49 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b301d93bsm1528222a91.1.2026.02.06.04.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:20:49 -0800 (PST)
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
Subject: [PATCH bpf-next v3 2/3] bpf, riscv: add fsession support for trampolines
Date: Fri,  6 Feb 2026 20:20:01 +0800
Message-ID: <20260206122002.1494125-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
References: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement BPF_TRACE_FSESSION support in the RISC-V trampoline JIT. The
logic here is similar to what we did in x86_64.

In order to simply the logic, we factor out the function invoke_bpf() for
fentry and fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Tested-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
v3:
- remove the "always" from the comment

v2:
- use bpf_prog_calls_session_cookie() in invoke_bpf()
---
 arch/riscv/net/bpf_jit_comp64.c | 74 ++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index e4f45e2e7e2f..d45fa9c6a7dd 100644
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
+		if (bpf_prog_calls_session_cookie(&tl->links[i])) {
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
+	 * FP - func_meta_off [ regs count, etc ]
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
2.53.0

