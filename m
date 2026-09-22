Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B661ADC83
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039637; cv=none; b=DQ57pA/lNopNBzZVcROtglukz6jNaEMYPKfHzFYp15e2IN6gnrQDbBSOBwQokgja3syYe1Ut1Vfh1goVW26yYlXNZWqd7gVjJRmxnWHN2xyFJ+wejCndE5xT6U/9QaQJWRPjDSscFB/xm3Rdb8qS/BvU0BeTsT437Lmy1rLolXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039637; c=relaxed/simple;
	bh=TAFC/cmLKHbSZhcsTB26ltvn5d/yA8l9fcoCs1t5d7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryvA+9MYWKtN6/eoY2ch4r5qZX/UTpm9uT6r2RXJqc5NAw0/iv2K4IJHwrm7D9xc9FvwzBTZcR7q8K2y22hLdsqkDl3VyXYEhv1KPDQRM/W42REJaFvtVo/VCF5vKjNcCSOuE3Dg5zNYM9kSQnPFRpQODxOHNl/ZBRw1Ba3pVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpR17so8; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpR17so8"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a33c9cso4747491b3a.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039635; x=1790644435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFoiGuBnt6J1XzaYeB1dDevtaZbXLUptbco66pIIqvU=;
        b=bpR17so8wavnMe9dTUQm4tzR0InOIJF16oAzkoka9iB6gpfuYVLDy7kkriLDt2swLx
         LJ+jGCWzKWmHVE7c51UBa0og7Wjt+qS1adMRVBf3JBte+s9ZH3NWs68fHko+rOrl1EE9
         4h8ofHcjbsrV9jcEWz9UWMr7xqAAqFnXwsnE2DdZorPlT/knHqIV2Vz/yER54UMdQKym
         5bj2+vhKbRC/gea3MueCWjN7JEWpd9C5b7SBlifjZaV/yVGrr4wKQdFFwv0T4o6gjR+j
         ES7HVtbfg4kjKny+Zq8Qgn+5FAn3gIrbsQQi+Bthp3nFea1Y1zOH/i6sfSThbQc2dme1
         bIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039635; x=1790644435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFoiGuBnt6J1XzaYeB1dDevtaZbXLUptbco66pIIqvU=;
        b=vd0AoGpgYqQQtfg600OKVbxnIVOJUWlorrF7XtgOMCvnLcD+mfleRV4W2U5SBkuvF1
         cQIzeFMFeFTxkVyaLbKKyCXWnMeNXpfmvZ3Ey7jSM7BEVejSsdXOC4ElAW4GpBNzObxP
         82GgREGbE0AZPuMoMv+43cWkoHLKKtJd1OEhlydNeZku1BWEaPBTCmewUm8+2QuOvYGN
         /0zhrHf77M3cfsQuxY4EV7QEpUg8abC0qA/ZgptSaqhtrhbQoQ8zEyH1OOPYpVi/Lqm3
         0a75WpaPwHFQ4Z3N3bvLgNIhe8EsDHOZWMJi7wSi3jqVh+EdH/ezG88TiSyc7ciJ7IHJ
         taLg==
X-Gm-Message-State: AFuF++m8bIShPncdmX8Ieq7IF99FPw2p+hvop56diijSEWSpo3Wn+BXe
	GBrAz+Y+fVYGWEfDmGEYZnPTKCVribaivV4LD0d4Jg96Pe1SSKcj4uV/rfOGJw==
X-Gm-Gg: AYBFou2s58xMF3wf5JdYPm+26wmpW0I3JZWu1CjgaTkvGxH6BoMO55blSXLIYQHFrd0
	A7562LE8x/bSK7pmcgZEjBqc+at4SJCPDLr3ee3GBh9kjZr68oHSzykLSSwDvobxd4AXlqY4Kc5
	j0c3HKgO2JowpxnSDKS7BBnMNLP1ncASM9g/XfyWOADaAKEOGupon1OeALOd5DIkB+FYwPdYnJg
	HToWiIVQks66ErW0ihrern0GYSwq8yla0jDK+iUIzKiBx0WHP9QU0tEKQNnk+DJmRnN042Pjvwo
	i3Sj/YrdgOCYrACCshM9Nr8jh9EwnT27NitJzc+mNRlBh8ozszMVlfzPuBS79Df+MaomGhTltSC
	F0mKKBDDz0xaE9KfHvMDTGs/u00WPuKZf5GIcK6WFrIqlu/LiL5fMULpJFtX2iM3Mg1rpHmxmy1
	xDuKl41cAPFtYTwb8ZDX/z9wIRh2laPgbls9yVTLUPzg85vf+c/Qqi2I3HDHqy6a0qgM1GYYYb7
	ZljiWTUlYXUAw+kyy7zoj23dTIAsz9DjB9HW9ZtAdsRgaGX/Hs+7hIK40QFp4HsG3g0y82Asyix
	FH5uSCvmrYplMBILJ/2E4VkoLalOeApvsPz/TRYkidQ=
X-Received: by 2002:a05:6300:68ca:20b0:3dd:a197:edfa with SMTP id adf61e73a8af0-3dda197f7e9mr8047673637.73.1790039634582;
        Mon, 21 Sep 2026 18:13:54 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a30002sm37740a12.13.2026.09.21.18.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:53 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 07/17] bpf, x86: Add JIT support for callx
Date: Tue, 22 Sep 2026 01:13:13 +0000
Message-ID: <20260922011323.1298619-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Emit indirect call via the register that holds the address of bpf subprog.
ld_imm64 BPF_PSEUDO_FUNC is resolved to func[i]->bpf_func by
jit_subprogs() already. It's the same address that is passed to helpers
as a callback.

Add emit_indirect_call() similar to emit_indirect_jump() used by tail
calls and gotox: use ITS or retpoline thunks when enabled.
Save/restore r9 around the call when private stack is used, like direct
calls do.

The verifier guarantees that callees of callx are not tail call
reachable, so don't pass tail call counter in rax, which may hold
the callee address.

FineIBT expects indirect callers to go through CFI preamble. Not done
yet. Return false from bpf_jit_supports_callx() in this mode, so such
progs are rejected at load time.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4a980140b48..9fbef7504e51 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -749,6 +749,46 @@ static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
 	*pprog = prog;
 }
 
+static void __emit_indirect_call(u8 **pprog, int reg, bool ereg)
+{
+	u8 *prog = *pprog;
+
+	if (ereg)
+		EMIT1(0x41);
+
+	EMIT2(0xFF, 0xD0 + reg);
+
+	*pprog = prog;
+}
+
+/* call *bpf_reg */
+static int emit_indirect_call(u8 **pprog, int bpf_reg, u8 *ip)
+{
+	u8 *prog = *pprog;
+	int reg = reg2hex[bpf_reg];
+	bool ereg = is_ereg(bpf_reg);
+	int err = 0;
+
+	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
+		OPTIMIZER_HIDE_VAR(reg);
+		err = emit_call(&prog, its_static_thunk(reg + 8*ereg), ip);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+		EMIT_LFENCE();
+		__emit_indirect_call(&prog, reg, ereg);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		OPTIMIZER_HIDE_VAR(reg);
+		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+			err = emit_call(&prog, &__x86_indirect_call_thunk_array[reg + 8*ereg], ip);
+		else
+			err = emit_call(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], ip);
+	} else {
+		__emit_indirect_call(&prog, reg, ereg);
+	}
+
+	*pprog = prog;
+	return err;
+}
+
 static void emit_return(u8 **pprog, u8 *ip)
 {
 	u8 *prog = *pprog;
@@ -2941,6 +2981,24 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			break;
 		}
 
+			/* callx: call of a bpf subprog whose address is in dst_reg */
+		case BPF_JMP | BPF_CALL | BPF_X:
+			/*
+			 * The verifier makes sure that callees of callx are
+			 * not tail call reachable, hence unlike a direct call
+			 * of a subprog there is no need to pass
+			 * tail_call_cnt_ptr in rax.
+			 */
+			if (priv_frame_ptr) {
+				push_r9(&prog);
+				ip += 2;
+			}
+			if (emit_indirect_call(&prog, insn->dst_reg, ip))
+				return -EINVAL;
+			if (priv_frame_ptr)
+				pop_r9(&prog);
+			break;
+
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
 				emit_bpf_tail_call_direct(bpf_prog,
@@ -4414,6 +4472,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	return prog;
 }
 
+bool bpf_jit_supports_callx(void)
+{
+	/*
+	 * FineIBT poisons ENDBR at the entry of a JITed function and expects
+	 * indirect callers to go through the CFI preamble instead.
+	 * callx doesn't do that yet.
+	 */
+	return cfi_mode != CFI_FINEIBT;
+}
+
 bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
-- 
2.55.0

