Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DB3DB634
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219471; cv=none; b=HEkamJzm+IEskfIu+GDGcZO1ZnrlLFVG0PzJyYNnAB5T4h62ptJEhE9nOYDtQO0PaMeMEx9g2Uz4dqGJWpac5U0IFRxS8Li89rpLMzBz/1ILbwDY/f2YoKuaLjmhtjpaqKe+dZyIMxmcqBlhCUVyAixuhxz6REcloZJ9EV/Q/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219471; c=relaxed/simple;
	bh=TAFC/cmLKHbSZhcsTB26ltvn5d/yA8l9fcoCs1t5d7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhbDvfb+5JiIwojuQxNQ1SH8eQeWYqbmc+IkL3Hg4cL0plP7wlQ8XytTCbAIxOSGvfW9T+kUaMmHKGiL+U3l1ETQPmiHH2s0O7Q2CdOAn+Ce/2QNRUXAZT5vaOMqxLwRF8I+GHf5Oqx2pJltke9NaJC1wNnHP/ukclKXaNzrM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/zTYFOJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/zTYFOJ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so718953a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219470; x=1790824270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFoiGuBnt6J1XzaYeB1dDevtaZbXLUptbco66pIIqvU=;
        b=M/zTYFOJCHn39OCcg4pGvnTuRx2JhKpOc/nxwMww82MBd3IeJZARWouBCx0rjqUEAs
         9YDF1ml7UX7jdu6aVvE3we5lmHhKsANSpk82+8ARrtPPorBRhtD6ZL+/JEnhKxppErdD
         fsadzDM8kXG8ZY2IxMvEUIq6K3NF/yYeBCAQ7FGsAezJtJ8H3JEGfmyL0syjREm69sQK
         tjf8yDHEVdaS9CKp2HxzC8MuQV41eC4yw7rhNBaAVwOO5sDvJAYh7PBKHxYPQ1a5+ZSA
         IiK+CY3cFMNs+HaycAJvAmMLKr53qUG005JubPgXxWEG5HV1BEkb/t4mIVDciBw1Q2SV
         6UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219470; x=1790824270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFoiGuBnt6J1XzaYeB1dDevtaZbXLUptbco66pIIqvU=;
        b=b5dDd+jyLsP3eVGmvwDQIlDDGbTcVNkIqGfuuqCe7qG93fF5peglxtahXQDf3BAON4
         f3+TG5zmBNnmmW7p8Y0steuC0CQSKWOLEPaOYAPTFjRB5r6GRawL4UimckyA+wvs1q6H
         XBc02GA3IIyMcf2FdyB0LebSqcqm639/wIvhomqYmNtKJPCbVhuJ950/t+D53NG1Iy08
         SYakBcTodVZkINsH6CZVyuAt1kYU3xlFwfNkoGLL3yMKdxVz2nzo/LjvD6+G1oK1F/5y
         W/iQNWKld7cBIAdxX+7+yMAVNudT8BWHuo3YSGdl3cYxr0OZvsM1YwiPwQDMNuyEKzxT
         Eyjg==
X-Gm-Message-State: AFuF++kfElTEeliJeKislnUcOkXLzBHRZ6+aN8oV/JZXmYCK/D0+yHdZ
	+LoeRrVQXnzAZ+5digGudK+Oa+zOyRGC6ijgoScC3cSqQHFxqUM2zUDOkfmZPg==
X-Gm-Gg: AYBFou2PL0t6yFTmAQ9rnrU/mj3QdHVMV/0KHrZXy2EQe3V3Bn+tk4SpAOYOJuZ5iER
	5wwmcCOt9FXSUgwOynIQ6Z41sQsdvY0AxwOC0rna6w7CHfEE4XvGslZOdOdkKTi3PnG2joAFgRO
	xnfmMa+V+IXvFpu87heGwbzp276/AzXZwZCWbCGyzjaqX2KMM70jgY1Z9P8zATDERk7Cf8jpEdU
	iPbGJ+g5lHAs9iLRer3f8DT2Oew9eIPxJ3j6BhQup3Avs/I3a6q0QYQTa3GydKr9dCqTe9Yu407
	VySDhNjnroMAoFR93BZiMK6iUwYYj46cl/SL/vQiVRFCY2OT3NdLcrFljv9VXa/3C5CK9bQtPre
	e+nvdrEI4o09tCOSWWH0tZuc87EGNiF8jNFYZkZKx4UTx/3bNQvVHT6OqGhpN2jery6Es/cytU4
	K1TXwaKAScggVX4W561au+GfHcyuZCM9ThWD6YfHyAmpj7CzrSu2VXswGLubkbNOCA1niPco81Q
	wI7c9bXHRD61YAlsYvJFPBmGqlt9ISkp6hbG2gsLMG96Xq+QyoLiFP1iKoE2f4a6/nSXmMDK2ob
	OhoqBLY62F26QKtpLvOZXhqNXZm+rN2C1mgCJ5D2OgQ1
X-Received: by 2002:a17:90b:1cce:b0:39e:6c68:fd8d with SMTP id 98e67ed59e1d1-3a098b337b3mr663982a91.34.1790219469766;
        Wed, 23 Sep 2026 20:11:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f111csm2025899a91.2.2026.09.23.20.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:08 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 07/17] bpf, x86: Add JIT support for callx
Date: Thu, 24 Sep 2026 03:10:32 +0000
Message-ID: <20260924031042.1690890-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
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

