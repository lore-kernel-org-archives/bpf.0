Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670704;
	b=yaDvidPv7E2e11cxKdU/1BV20fu0Bj8dfZ0DO/mPJTzVTdugrI5bhGtsPyr6/x+iEFCU
	 nga4f+U8LhxEUwMUVethSlJ3wZ3jX+nbryFY5dSm7IwqQIKKjfaNyx4lLxAbzb6MTRR2p
	 84DpStS38Olri8HUM7wUPvhbiDTLD2jTjCd7EwQeqUL+8dqC89qlpIh+REF9EMJ47I7A4
	 C6DBt5k8SnC66t6UDfwqR1jkYp3tSU/Wp4q4bgH6pc3OXyuEmDJlEKTEVWaJz3PWWMyOe
	 pMO2AUtcVyNEtlXLBXJzqtxbcjCukN3fm9EDTiORlmcxLIBzWnYhtqEVMitq2Ixor6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=EvgD/cvHKiYq1UfKKSCVgYLry4FLJfLyp6XExjU6iZ4=;
	b=Q3J0zCmV8EFkrI+/m3ki4E5surfZANbuAzKj1xkOqoTUqiqZxz3iZUJ8lgb349bz92x9
	 yqRXE4G6ZZQbb2rNOh0bNbNjMJPXg/rqffSrAE31I8rvSkLttuCbc97gYsxVzb2vIULOf
	 ea8M+EYClv3sZzoij8aeqARi3ccpR8I4j6eun2IrA8K85DNINYGZt8K7owJHvgp6H+IHY
	 IoE/7HLxtJHK9+ym2A31tf9C4EvKi/zjcTa3HDbaFGPg+/liueSHZzHcVsmS2RH6dlfbw
	 u1JqFrOnt5KfDIzyLqd5QkV/AlCyXj1hBjT/n4NjIKkVe0rw3Q4nN9nUJnna/LD1K8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FrwUaMWv;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F0606A31F
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 12:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3F0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FrwUaMWv
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso15471857b3.2
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670703; x=1793275503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvgD/cvHKiYq1UfKKSCVgYLry4FLJfLyp6XExjU6iZ4=;
        b=FrwUaMWvABGIn4oHiT7JHYBC0z8Ujc1k/l5QMLr/uC2QtEp4KoEVb0N368NT/6KwdB
         /J67xHHDxhrRaH6qQ4MlZoWyUTMt8/0bmHYaMaeGW2w1/dIzLi62KI+JfeJPwXDWN80J
         agbxGht1u0gUunDaVGktX26PmiziiNuFQklZPlzKNXZA9HQ6TnYe0EA6oGQkC5myJxfM
         OyOMiSLvzdWaUco67fC/atx+UFuY+gFCg3BRGjWpJxgIvEOmx5VRyfFqzseksjZualaD
         YQowI3QMYK6SawwuzHLbXBsbJucxGo1Rzm7VSMsoW+w3Yz4vshabzMaqInMkWZXZcWu5
         RRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670703; x=1793275503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvgD/cvHKiYq1UfKKSCVgYLry4FLJfLyp6XExjU6iZ4=;
        b=yiCdloVaRNZlY5c15cta8gUzHdtBLIWy0i1YhLAkl1Qnwo4IDYwv5+jiEPv1DAVK00
         6wINeeR3d25e2R3MH+VRwj0wI1IEE+vKHiMjdyOKNzFSzK3wwA8ErVLkBNAYV9DE6LSS
         ifdBYjzw111EqrIj4xTY9Ic3/TLDGfMHBLj1oanJZNzaFvQMFOokvFoIKNOkRWwhIHeQ
         Wmixb0KAPIfmedbR5owS8oMLVhkNJC9zBamVRjE2IpEBc2xZz2t+SWLk1IstTfBC+jKx
         DUF5+a14+cgigcHThAeK7alXzqhRDYRTh30K+aFlb8OibaHx9jc3Gb6sMnPrOZf9qToj
         vNOQ==
X-Gm-Message-State: AFq9FYKrsACRuxHoZQk5QfY+9wzugQL6jacSOGrNmfcNINJttnixIJNP
	wRf7dqdXZdlK84m6QSRv05/w00prnLQ0/UngpL37MwggWxE9uCpZCeL0
X-Gm-Gg: AYBFou36nHT8v5tTMjrIj5AqBSBM1Fb7ryS8zofvDAjqLPay5STs8sY0htyvxaqEWdI
	K22fw8LJUh7rF18EEpSBpUAsTG6p6x6fgVy+ApIjzx8hCudC+BUf8jXRJ9LifOX3VNgdhb6+iqs
	l4iCNiHtbPJC1hq42eC3JQe+ehTTi7dOwBM8ZL69SdfVCw5LPnW3o7dDr/LzuAUxTrkM1UdWKzb
	fYUNkMg/zszd/44GKbR1hqhTYR2zAb0Gd6hEQ3oRxow4JaKxsvaRb+MEpmrOt7rLIBg5ibVXayj
	r6wf/j0mnxtsR68UupXoNrcWOROga5TBPzcwgmuaF6nmbOKCPeAdE/llPQE0FuvQRNRPOUQJlq8
	7h5vlL1ZkUOgqLl3wMCfrFmv9mljRuw4+8M0Vh6Y5hQ1bP60ydyaVH+F7T5xkuaGdyVW44pLVC4
	bLYFjWPEa8vdGoI5xCzAHrsuJ+3masEpYVvsbmT5C2dE1S3MjwadAiGs66O45B2tyTK1qeAyifR
	9O8utt8cJP+EHTfPdPH6rSeVttHHzBQfPktASfDWqSw/WK8FK2/ZanKFfufmGa+WdA=
X-Received: by 2002:a05:690c:fcd:b0:8a9:b50a:bafa with SMTP id 00721157ae682-8b133d95319mr34805517b3.55.1792670702906;
        Thu, 22 Oct 2026 05:05:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13010e9afsm24598207b3.30.2026.10.22.05.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:05:02 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Oct 2026 05:04:55 -0700
Subject: [PATCH bpf-next v2 1/2] bpf: Size backward jumps by the insns they
 jump over
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-jit_size_fix-v2-1-4bee6921b218@meta.com>
References: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
In-Reply-To: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792670698; l=8561;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=fb4Xm8FQ4AMbVUnCpbXsxZr+2EhZhCI9XyyjZYNGcD4=;
 b=A9jaLxOVs9XyL24STsf5eufzAkyFkKUF8QWg1t6VUOl7aH+gqX/fcYtDamE4clp/4kXsbgm7F
 rnE/wgbfTEIAEnwc84sVfCZeI64hGUw/IEI+uKH4azCMMMV69W0cF6n
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A backward jump is sized from its target's current-pass address and its
own previous-pass address, so it can grow while other jumps shrink. Two
passes may then give the same image length with jumps still changing,
which ends in "bpf_jit: fatal error", and a jump growing in a padding
pass ends in "unexpected jmp_cond padding".

Shift the jump's previous-pass address by how far the current pass has
moved it, so a backward jump is sized by the insns it jumps over, like
a forward one. Also start every insn at BPF_MAX_INSN_SIZE instead of 64,
so none can grow in the first pass. Then no insn grows from one pass to
the next, and a repeated image length means nothing moved. The 123
limit on imm8 offsets worked around that growth and is dropped. The
ja -1 special case is subsumed, such a jump is now imm8 from the first
pass.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 arch/x86/net/bpf_jit_comp.c | 109 +++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 78 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d0039d..96336e51c1c5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -97,56 +97,6 @@ static bool is_imm8(int value)
 	return value <= 127 && value >= -128;
 }
 
-/*
- * Let us limit the positive offset to be <= 123.
- * This is to ensure eventual jit convergence For the following patterns:
- * ...
- * pass4, final_proglen=4391:
- *   ...
- *   20e:    48 85 ff                test   rdi,rdi
- *   211:    74 7d                   je     0x290
- *   213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
- *   ...
- *   289:    48 85 ff                test   rdi,rdi
- *   28c:    74 17                   je     0x2a5
- *   28e:    e9 7f ff ff ff          jmp    0x212
- *   293:    bf 03 00 00 00          mov    edi,0x3
- * Note that insn at 0x211 is 2-byte cond jump insn for offset 0x7d (-125)
- * and insn at 0x28e is 5-byte jmp insn with offset -129.
- *
- * pass5, final_proglen=4392:
- *   ...
- *   20e:    48 85 ff                test   rdi,rdi
- *   211:    0f 84 80 00 00 00       je     0x297
- *   217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
- *   ...
- *   28d:    48 85 ff                test   rdi,rdi
- *   290:    74 1a                   je     0x2ac
- *   292:    eb 84                   jmp    0x218
- *   294:    bf 03 00 00 00          mov    edi,0x3
- * Note that insn at 0x211 is 6-byte cond jump insn now since its offset
- * becomes 0x80 based on previous round (0x293 - 0x213 = 0x80).
- * At the same time, insn at 0x292 is a 2-byte insn since its offset is
- * -124.
- *
- * pass6 will repeat the same code as in pass4 and this will prevent
- * eventual convergence.
- *
- * To fix this issue, we need to break je (2->6 bytes) <-> jmp (5->2 bytes)
- * cycle in the above. In the above example je offset <= 0x7c should work.
- *
- * For other cases, je <-> je needs offset <= 0x7b to avoid no convergence
- * issue. For jmp <-> je and jmp <-> jmp cases, jmp offset <= 0x7c should
- * avoid no convergence issue.
- *
- * Overall, let us limit the positive offset for 8bit cond/uncond jmp insn
- * to maximum 123 (0x7b). This way, the jit pass can eventually converge.
- */
-static bool is_imm8_jmp_offset(int value)
-{
-	return value <= 123 && value >= -128;
-}
-
 static bool is_simm32(s64 value)
 {
 	return value == (s64)(s32)value;
@@ -2298,6 +2248,17 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
+/*
+ * addrs[] below i are from this pass, addrs[i] and above are from the previous
+ * one. 'moved' is how far back this pass moved the start of the current insn.
+ * With it a jump in either direction is sized by the insns it jumps over, plus
+ * its own previous size for a backward jump, none of which grow.
+ */
+static int jmp_distance(const int *addrs, int i, int off, int moved)
+{
+	return addrs[i + off] - addrs[i] + (off < 0 ? moved : 0);
+}
+
 #define __LOAD_TCC_PTR(off)			\
 	emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, off)
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 16] */
@@ -2588,7 +2549,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	u64 arena_vm_start = 0, user_vm_start = 0;
 	void __percpu *priv_stack_ptr;
 	int i, excnt = 0;
-	int ilen, proglen = 0;
+	int ilen, moved, proglen = 0;
 	u8 *ip, *prog = temp;
 	u32 stack_depth;
 	int callee_saved_size;
@@ -2702,6 +2663,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
 	proglen += ilen;
+	moved = addrs[0] - proglen;
 	addrs[0] = proglen;
 	prog = temp;
 
@@ -3747,8 +3709,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			default: /* to silence GCC warning */
 				return -EFAULT;
 			}
-			jmp_offset = addrs[i + insn->off] - addrs[i];
-			if (is_imm8_jmp_offset(jmp_offset)) {
+			jmp_offset = jmp_distance(addrs, i, insn->off, moved);
+			if (is_imm8(jmp_offset)) {
 				if (jmp_padding) {
 					/* To keep the jmp_offset valid, the extra bytes are
 					 * padded before the jump insn, so we subtract the
@@ -3788,23 +3750,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
-			if (BPF_CLASS(insn->code) == BPF_JMP) {
-				if (insn->off == -1)
-					/* -1 jmp instructions will always jump
-					 * backwards two bytes. Explicitly handling
-					 * this case avoids wasting too many passes
-					 * when there are long sequences of replaced
-					 * dead code.
-					 */
-					jmp_offset = -2;
-				else
-					jmp_offset = addrs[i + insn->off] - addrs[i];
-			} else {
-				if (insn->imm == -1)
-					jmp_offset = -2;
-				else
-					jmp_offset = addrs[i + insn->imm] - addrs[i];
-			}
+			if (BPF_CLASS(insn->code) == BPF_JMP)
+				jmp_offset = jmp_distance(addrs, i, insn->off, moved);
+			else
+				jmp_offset = jmp_distance(addrs, i, insn->imm, moved);
 
 			if (!jmp_offset) {
 				/*
@@ -3833,7 +3782,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				break;
 			}
 emit_jmp:
-			if (is_imm8_jmp_offset(jmp_offset)) {
+			if (is_imm8(jmp_offset)) {
 				if (jmp_padding) {
 					/* To avoid breaking jmp_offset, the extra bytes
 					 * are padded before the actual jmp insn, so
@@ -3869,7 +3818,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			    emit_unwind_ret_addr(&prog, ip))
 				return -EINVAL;
 			if (seen_exit) {
-				jmp_offset = ctx->cleanup_addr - addrs[i];
+				jmp_offset = ctx->cleanup_addr - addrs[i] + moved;
 				goto emit_jmp;
 			}
 			seen_exit = true;
@@ -3930,6 +3879,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			memcpy(rw_image + proglen, temp, ilen);
 		}
 		proglen += ilen;
+		moved = addrs[i] - proglen;
 		addrs[i] = proglen;
 		prog = temp;
 	}
@@ -4967,20 +4917,23 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	/*
 	 * Before first pass, make a rough estimation of addrs[]
-	 * each BPF instruction is translated to less than 64 bytes
+	 * each BPF instruction is translated to at most BPF_MAX_INSN_SIZE
+	 * bytes, so no insn grows in the first pass
 	 */
 	for (proglen = 0, i = 0; i <= prog->len; i++) {
-		proglen += 64;
+		proglen += BPF_MAX_INSN_SIZE;
 		addrs[i] = proglen;
 	}
 	ctx.cleanup_addr = proglen;
 skip_init_addrs:
 
 	/*
-	 * JITed image shrinks with every pass and the loop iterates
-	 * until the image stops shrinking. Very large BPF programs
-	 * may converge on the last pass. In such case do one more
-	 * pass to emit the final image.
+	 * Jumps are sized by the insns they jump over, which start at
+	 * their maximum size, so no insn grows from one pass to the
+	 * next. The loop iterates until the image stops shrinking, at
+	 * which point no insn has moved. Very large BPF programs may
+	 * converge on the last pass. In such case do one more pass to
+	 * emit the final image.
 	 */
 	for (pass = 0; pass < MAX_PASSES || image; pass++) {
 		if (!padding && pass >= PADDING_PASSES)

-- 
2.53.0-Meta

