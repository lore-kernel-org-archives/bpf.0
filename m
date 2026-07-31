Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD98469822
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524881; cv=none; b=K7jHW/1LiSZLAyCFmIC791rsik5hNAqWx19oNH3JsfrOPvUyZpSMP4eYwLlhKpUwoKCskARMpiGtTr4sEC+KXmCEHrQioaAacASYzwavaTek8hKwV3S+LUfwY22YDjk4x6MoKkt29JAA1TJDeag90jIJh4GLvfC08Zhjd3xe4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524881; c=relaxed/simple;
	bh=x8MH3VLXzZ99TOg/ZAnPGLgwzDU3pCkUddzP6z5K0zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvN9HUGMjQ7H8GfGZtVwu9cbUh5dBR6a+VeV310MPXbsWae2DconzZfUB4jVv6CQC/WTKZm78VuO/wWBvRluVx61Z8HQGWYAodK2nhapnhXtZDHgOdMdsBrC/p5DbYRh3F0w0J409tgQgGXAwRBKXD0cfWPPQfwYACnlXgejCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOnL73JA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOnL73JA"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb662575d3so795163a12.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785524879; x=1786129679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L5FPno1ag+rkT0MK4SIhZOWjyJIEb/kgznQsY63Kwc4=;
        b=hOnL73JA0zqtlHunWmjXp6hW6P2Ghx6GDV6hUkInlWXDn0oiY3MEZhL9pMG2w/TVbW
         LwrcEHgKaP0VqIO2pXIPV822Oy8AkGmyNhBxR75yl3I3BVhWzZvKDS1a79CQbFChe+9Z
         +h26COHRN4/6tQKYD2ksX5RAl/MA+2/no9quZISlDVocf2NypWa0gTyNasAXkidRRp0K
         u8c1UGxzoxz/63mMXPTkJX5gQ6KsxaFZNNx3BSMhk8z+jmmwVGqUR5AiyKPP79mLpvth
         0a/dy0uVcz1ZHUoevDUkKWkXkUQPrWkPNcIWxJCSALWxfRKVK5+hvnHAaOa2SUMSKc5h
         euUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524879; x=1786129679;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5FPno1ag+rkT0MK4SIhZOWjyJIEb/kgznQsY63Kwc4=;
        b=WJMiFLJdzUC14bLpO8Dk0OtwWsq5JrjdDQO0vOHlVQLRI1DagWran6+M9cRzccdMIg
         vj1fdYEmWmVO6NoaVTLt88dhKjpC7axr8H59A+w+Q9LNVHZSp2kJVLdutHNyXAdtaIJf
         uHPqaAuc1FTqIMiJEoBxXK6Ps7NmATqg099kUp81PGA+0kwSkYa163pkfYyjdm0Nzrdv
         QuDm7Yy1t44TdHxUVRghn3OLRPuWgGBmPdrqQh/vKkRSOPJGniQGRCZEzc4bIOghoNER
         fOGkVxnMnoivZVS35Pfxefa9Bl3tu2qqteJrrbi5rjdWFKBJiL2jReFDSzgKtiDkVThZ
         1jIQ==
X-Gm-Message-State: AOJu0Yybdh6Jj1AU2+87KCrYvnGMTCY5kpsPtXiNGmCyPljKQvpew+f8
	KVOHEIrt5SJeFtYd3xRM0jH6kbXDKBbyja8TzMgVq7p/Hy02uwPB3vYuip2ELg/L
X-Gm-Gg: AR+sD11y2p1Y5TlVI3UfyYQEegHvJ1QAVMKkXVonGcrhwgzvpKUr6mQGXn4AJAImQsg
	qp4NmWAReKzydjjFkLy7mXc9VNeLdUBqkKJEwRsldxbCcgFlsMUU+kIzS07Ktuno3nzH43h2ke2
	Ioglwr18YkkF3x+iK07qc17lNUaLKSOsOIAaJMPx2lHhU29F82LnMZKrZax9lzXXb834tlVAaSm
	4MR+nwHC/Hyq6Zc9aQouFaDEJgygqTewuR5w8B9clgtraq+8y+AIaDTiDvI7ywXn0S33+hTgxoi
	R/Bb3xl1LeUZhjTROCHCkHI9/4hIYop+GRHLKBqGH0gVONIIc+0Vg9iFPZpp1/zicws+x5rqOFY
	8HvUoEMZH7reB83vnjJ+GjmVWFTACOzfA+9UY3IdTKMsClxLTQ99Q6/HyGSqYAVLoOLjQrPkgK5
	MGcRp9YL9x1A+0q+e0slZQPW+7C0UgI/PbnnVSlqpU4mWc/5FUZojR6ZbIkOpyxBqrkXJ/vE5kS
	L9AZl8vU7ilZI9BXoIeW/dyLpo54WC8Svr7IE4ctN02
X-Received: by 2002:a05:6a20:d43:b0:3b4:cd6:88b with SMTP id adf61e73a8af0-3c92a9c68b6mr877207637.46.1785524878749;
        Fri, 31 Jul 2026 12:07:58 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm4815801c88.3.2026.07.31.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:07:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 1/5] bpf: do not print a newline after disassembly in bpf_verbose_insn()
Date: Fri, 31 Jul 2026 12:07:42 -0700
Message-ID: <20260731-static-zext-v1-1-98a4dc73e94b@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

At the moment there are more callsites that want bpf_verbose_insn() to
not print a newline after the instruction, than callsites that want a
newline. Drop '\n' from disasm.c. Non-functional change.

The changes in bpftool are verified by writing a bpf program using a
variety of instructions and comparing `prog dump xlated` output in the
following modes: plain, opcodes, visual, visual opcodes.
The output before and after the changes is identical.

Cc: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/backtrack.c                       |  1 +
 kernel/bpf/disasm.c                          | 68 ++++++++++++++--------------
 kernel/bpf/liveness.c                        |  6 +--
 kernel/bpf/verifier.c                        |  1 +
 tools/bpf/bpftool/xlated_dumper.c            | 10 ++--
 tools/testing/selftests/bpf/disasm_helpers.c |  3 +-
 6 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 2e4ae0ef0860..7c4599e65ece 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -285,6 +285,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
 		bpf_verbose_insn(env, insn);
+		verbose(env, "\n");
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 0391b3bc0073..50b3ca5149a0 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -139,7 +139,7 @@ static void print_bpf_end_insn(bpf_insn_print_t verbose,
 			       void *private_data,
 			       const struct bpf_insn *insn)
 {
-	verbose(private_data, "(%02x) r%d = %s%d r%d\n",
+	verbose(private_data, "(%02x) r%d = %s%d r%d",
 		insn->code, insn->dst_reg,
 		BPF_SRC(insn->code) == BPF_TO_BE ? "be" : "le",
 		insn->imm, insn->dst_reg);
@@ -149,7 +149,7 @@ static void print_bpf_bswap_insn(bpf_insn_print_t verbose,
 			       void *private_data,
 			       const struct bpf_insn *insn)
 {
-	verbose(private_data, "(%02x) r%d = bswap%d r%d\n",
+	verbose(private_data, "(%02x) r%d = bswap%d r%d",
 		insn->code, insn->dst_reg,
 		insn->imm, insn->dst_reg);
 }
@@ -197,19 +197,19 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			else
 				print_bpf_end_insn(verbose, cbs->private_data, insn);
 		} else if (BPF_OP(insn->code) == BPF_NEG) {
-			verbose(cbs->private_data, "(%02x) %c%d = -%c%d\n",
+			verbose(cbs->private_data, "(%02x) %c%d = -%c%d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg);
 		} else if (is_addr_space_cast(insn)) {
-			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %u, %u)\n",
+			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %u, %u)",
 				insn->code, insn->dst_reg,
 				insn->src_reg, ((u32)insn->imm) >> 16, (u16)insn->imm);
 		} else if (is_mov_percpu_addr(insn)) {
-			verbose(cbs->private_data, "(%02x) r%d = &(void __percpu *)(r%d)\n",
+			verbose(cbs->private_data, "(%02x) r%d = &(void __percpu *)(r%d)",
 				insn->code, insn->dst_reg, insn->src_reg);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
-			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d\n",
+			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
 				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
@@ -218,7 +218,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				class == BPF_ALU ? 'w' : 'r',
 				insn->src_reg);
 		} else {
-			verbose(cbs->private_data, "(%02x) %c%d %s %d\n",
+			verbose(cbs->private_data, "(%02x) %c%d %s %d",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg,
 				is_sdiv_smod(insn) ? bpf_alu_sign_string[BPF_OP(insn->code) >> 4]
@@ -227,7 +227,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		}
 	} else if (class == BPF_STX) {
 		if (BPF_MODE(insn->code) == BPF_MEM)
-			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = r%d\n",
+			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = r%d",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
@@ -235,7 +235,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			 (insn->imm == BPF_ADD || insn->imm == BPF_AND ||
 			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
-			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
+			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
@@ -246,7 +246,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			    insn->imm == (BPF_AND | BPF_FETCH) ||
 			    insn->imm == (BPF_OR | BPF_FETCH) ||
 			    insn->imm == (BPF_XOR | BPF_FETCH))) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)\n",
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
@@ -254,7 +254,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_CMPXCHG) {
-			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)\n",
+			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)",
 				insn->code,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
@@ -262,44 +262,44 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_XCHG) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)\n",
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_LOAD_ACQ) {
-			verbose(cbs->private_data, "(%02x) r%d = load_acquire((%s *)(r%d %+d))\n",
+			verbose(cbs->private_data, "(%02x) r%d = load_acquire((%s *)(r%d %+d))",
 				insn->code, insn->dst_reg,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->src_reg, insn->off);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   insn->imm == BPF_STORE_REL) {
-			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), r%d)\n",
+			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), r%d)",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
-			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_%02x", insn->code);
 		}
 	} else if (class == BPF_ST) {
 		if (BPF_MODE(insn->code) == BPF_MEM) {
-			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = %d\n",
+			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = %d",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
 				insn->off, insn->imm);
 		} else if (BPF_MODE(insn->code) == 0xc0 /* BPF_NOSPEC, no UAPI */) {
-			verbose(cbs->private_data, "(%02x) nospec\n", insn->code);
+			verbose(cbs->private_data, "(%02x) nospec", insn->code);
 		} else {
-			verbose(cbs->private_data, "BUG_st_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_st_%02x", insn->code);
 		}
 	} else if (class == BPF_LDX) {
 		if (BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) {
-			verbose(cbs->private_data, "BUG_ldx_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
 			return;
 		}
-		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)\n",
+		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)",
 			insn->code, insn->dst_reg,
 			BPF_MODE(insn->code) == BPF_MEM ?
 				 bpf_ldst_string[BPF_SIZE(insn->code) >> 3] :
@@ -307,12 +307,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			insn->src_reg, insn->off);
 	} else if (class == BPF_LD) {
 		if (BPF_MODE(insn->code) == BPF_ABS) {
-			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[%d]\n",
+			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[%d]",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->imm);
 		} else if (BPF_MODE(insn->code) == BPF_IND) {
-			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[r%d + %d]\n",
+			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[r%d + %d]",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->src_reg, insn->imm);
@@ -332,12 +332,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			if (is_ptr && !allow_ptr_leaks)
 				imm = 0;
 
-			verbose(cbs->private_data, "(%02x) r%d = %s\n",
+			verbose(cbs->private_data, "(%02x) r%d = %s",
 				insn->code, insn->dst_reg,
 				__func_imm_name(cbs, insn, imm,
 						tmp, sizeof(tmp)));
 		} else {
-			verbose(cbs->private_data, "BUG_ld_%02x\n", insn->code);
+			verbose(cbs->private_data, "BUG_ld_%02x", insn->code);
 			return;
 		}
 	} else if (class == BPF_JMP32 || class == BPF_JMP) {
@@ -347,35 +347,35 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			char tmp[64];
 
 			if (insn->src_reg == BPF_PSEUDO_CALL) {
-				verbose(cbs->private_data, "(%02x) call pc%s\n",
+				verbose(cbs->private_data, "(%02x) call pc%s",
 					insn->code,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)));
 			} else {
 				strcpy(tmp, "unknown");
-				verbose(cbs->private_data, "(%02x) call %s#%d\n", insn->code,
+				verbose(cbs->private_data, "(%02x) call %s#%d", insn->code,
 					__func_get_name(cbs, insn,
 							tmp, sizeof(tmp)),
 					insn->imm);
 			}
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
+			verbose(cbs->private_data, "(%02x) goto pc%+d",
 				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X)) {
-			verbose(cbs->private_data, "(%02x) gotox r%d\n",
+			verbose(cbs->private_data, "(%02x) gotox r%d",
 				insn->code, insn->dst_reg);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
-			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
+			verbose(cbs->private_data, "(%02x) may_goto pc%+d",
 				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
+			verbose(cbs->private_data, "(%02x) gotol pc%+d",
 				insn->code, insn->imm);
 		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
-			verbose(cbs->private_data, "(%02x) exit\n", insn->code);
+			verbose(cbs->private_data, "(%02x) exit", insn->code);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data,
-				"(%02x) if %c%d %s %c%d goto pc%+d\n",
+				"(%02x) if %c%d %s %c%d goto pc%+d",
 				insn->code, class == BPF_JMP32 ? 'w' : 'r',
 				insn->dst_reg,
 				bpf_jmp_string[BPF_OP(insn->code) >> 4],
@@ -383,14 +383,14 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->src_reg, insn->off);
 		} else {
 			verbose(cbs->private_data,
-				"(%02x) if %c%d %s 0x%x goto pc%+d\n",
+				"(%02x) if %c%d %s 0x%x goto pc%+d",
 				insn->code, class == BPF_JMP32 ? 'w' : 'r',
 				insn->dst_reg,
 				bpf_jmp_string[BPF_OP(insn->code) >> 4],
 				(u32)insn->imm, insn->off);
 		}
 	} else {
-		verbose(cbs->private_data, "(%02x) %s\n",
+		verbose(cbs->private_data, "(%02x) %s",
 			insn->code, bpf_class_string[class]);
 	}
 }
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..ff1e68cc4bd1 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -497,7 +497,6 @@ static void print_instance(struct bpf_verifier_env *env, struct func_instance *i
 		pos = env->log.end_pos;
 		verbose(env, "%3d: ", insn_idx);
 		bpf_verbose_insn(env, &insns[insn_idx]);
-		bpf_vlog_reset(&env->log, env->log.end_pos - 1); /* remove \n */
 		insn_pos = env->log.end_pos;
 		verbose(env, "%*c;", bpf_vlog_alignment(insn_pos - pos), ' ');
 		pos = env->log.end_pos;
@@ -1043,7 +1042,6 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		if (!printed) {
 			verbose(env, "%3d: ", idx);
 			bpf_verbose_insn(env, insn);
-			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
 			printed = true;
 		}
 		verbose(env, "\tr%d: ", i); verbose_arg_track(env, &at_in[i]);
@@ -1058,7 +1056,6 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		if (!printed) {
 			verbose(env, "%3d: ", idx);
 			bpf_verbose_insn(env, insn);
-			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
 			printed = true;
 		}
 		verbose(env, "\tsa%d: ", i); verbose_arg_track(env, &at_in[ai]);
@@ -1070,7 +1067,6 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		if (!printed) {
 			verbose(env, "%3d: ", idx);
 			bpf_verbose_insn(env, insn);
-			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
 			printed = true;
 		}
 		verbose(env, "\tfp%+d: ", -(i + 1) * 8); verbose_arg_track(env, &at_stack_in[i]);
@@ -1545,6 +1541,7 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
 
 		verbose(env, "%3d: ", idx);
 		bpf_verbose_insn(env, &insns[idx]);
+		verbose(env, "\n");
 
 		/* Collect what needs printing */
 		if (is_ldx_stx_call &&
@@ -2285,6 +2282,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 					verbose(env, ".");
 			verbose(env, " ");
 			bpf_verbose_insn(env, &insns[i]);
+			verbose(env, "\n");
 			if (bpf_is_ldimm64(&insns[i]))
 				i++;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6f35f4e715b..6123e7e4a320 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17475,6 +17475,7 @@ static int do_check(struct bpf_verifier_env *env)
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
 			bpf_verbose_insn(env, insn);
+			verbose(env, "\n");
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 5e7cb8b36fef..7b33d847d800 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -129,16 +129,10 @@ print_insn_for_graph(void *private_data, const char *fmt, ...)
 static void __printf(2, 3)
 print_insn_json(void *private_data, const char *fmt, ...)
 {
-	unsigned int l = strlen(fmt);
-	char chomped_fmt[l];
 	va_list args;
 
 	va_start(args, fmt);
-	if (l > 0) {
-		strncpy(chomped_fmt, fmt, l - 1);
-		chomped_fmt[l - 1] = '\0';
-	}
-	jsonw_vprintf_enquote(json_wtr, chomped_fmt, args);
+	jsonw_vprintf_enquote(json_wtr, fmt, args);
 	va_end(args);
 }
 
@@ -351,6 +345,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
 
 		printf("%4u: ", i);
 		print_bpf_insn(&cbs, insn + i, true);
+		printf("\n");
 
 		if (opcodes) {
 			printf("       ");
@@ -417,6 +412,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 
 		printf("%u: ", insn_off);
 		print_bpf_insn(&cbs, cur, true);
+		printf("\\l\\\n");
 
 		if (opcodes) {
 			printf("\\ \\ \\ \\ ");
diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
index f529f1c8c171..30221352568d 100644
--- a/tools/testing/selftests/bpf/disasm_helpers.c
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -55,10 +55,9 @@ struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 	 * for each instruction (FF stands for instruction `code` byte).
 	 * Remove the prefix inplace, and also simplify call instructions.
 	 * E.g.: "(85) call foo#10" -> "call foo".
-	 * Also remove newline in the end (the 'max(strlen(buf) - 1, 0)' thing).
 	 */
 	pfx_end = buf + 5;
-	sfx_start = buf + max((int)strlen(buf) - 1, 0);
+	sfx_start = buf + (int)strlen(buf);
 	if (strncmp(pfx_end, "call ", 5) == 0 && (tmp = strrchr(buf, '#')))
 		sfx_start = tmp;
 	len = sfx_start - pfx_end;

-- 
2.55.0
