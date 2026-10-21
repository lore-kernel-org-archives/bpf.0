Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620911;
	b=O2n/YdPZSXETjW8/45xCm4C2bT+WjK/XyUtv6Bg/8+mgbPGEKfzegbT0b5dv5jPPMyoA
	 naovudFoP+fZ5+Ir1Yk9smWqSHCrvvvdbuLKQlw9TNWqvmnXl9UB5tZhGpLGsfcGC7c/a
	 QIgvxSlxeCUadDuZkPpBd574bfqgsUQ6TCZc7FRYVEZtGZCz8D6v3ruqbx7yvaPitiNtC
	 0YOuYP+N6gub+WgIWwZ5WqIFF9BTcFfii6CsQb9cDYdNHmokSqRs4ZiouJU6cx6AAHeKL
	 5aq0sg99J0Vdcqk7cKg+OdFGKt8aREqGVoh3fqjwiuGC62Bhksi3YojG8F18/QD6PXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=dYt+v3d4zDqJFN4Ri4+WFnFd29nEbE0xgJbNmPnLwBs=;
	b=Pdj+mreRsuo7BUmINQiBIck78ON741XwIq3nzyzbox0QdNJzvKNDIRCaYeEX6+cSek2m
	 1t+aG8hyq3Uk1B0vu2UxlSF/uRNX3kLMcWS7o+Yjxyx2JFHcZaDa7o+k3oa9/t6BXmYBp
	 vuP1mme+rWoHV2Lo2dbRdBkGUjqlFUEMqy+ZLtRbOe2A+pE+paw2i/I/CkfTk5rXJgHH+
	 flKlIqqLlL+CmW8Hyhen8NN7I6faZ6aP3dyk2iWoh9QHLfUYVQRuGvbLCuOEyqFZwARFZ
	 yiP+7SbPfroRwa0K97UFOX1JPy2LGuMUInCKVPv2wptCP1j+AYQmWj1mltEfu5wryhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=on+TGkqn;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F7606A31E
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D3F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=on+TGkqn
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a058f74a54so523143b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620910; x=1793225710; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYt+v3d4zDqJFN4Ri4+WFnFd29nEbE0xgJbNmPnLwBs=;
        b=on+TGkqnvafel5vxblV1HvRJAdnvnVsuHfVoFe9tflvlvaVssK5hVtUM2ZnWRoNivD
         iDIskbNDo6cDB4K0j6tI9kRfs3bBq/5CzxG/GLzPxjgiAcW81pepFwomfMpXc64ZEmIV
         lcecIGgxuUfUvSp7aYqBR/SKoTN/6fxqI6uDUj95yjVnSxAHcN7aORD3SfhoNc26DJ5n
         JyoukSSZzEPNQN1KvX8ByL2dFP6JyEVlhnMRBrwP9alm7HozJipEgO4j21M7Hteuo7f7
         oSzbYY2sscZuJPGPqxIwVt8fL7K1Too0QqpAIGMukJbU3m+of/YjjbXWdj2I+P+xnzqg
         8Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620910; x=1793225710;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYt+v3d4zDqJFN4Ri4+WFnFd29nEbE0xgJbNmPnLwBs=;
        b=VtYxEIilvWAY8v80IawkKzNPfCx2DShvURWcWptlcCPSgayj8gguXR+sDJwWcKGQms
         Ua8Xio5h2JKQ+2nyE4gKBLvN2UFRAw6UQDap4HO/avbSMyQs1EzGfsOh32mne+4CTyFI
         u5cp1p5AeRkTYuUc0LEPh/zNV/lSdVCsZ4ulYyPTJNeTrvGneqogQJlf1/zpTat6/pAi
         A4r6Mj1j5gjCH09QScdWHKQtDnjGJAbfoT4oznrbQikeIiwG+igLc+tTkMS6yzTQ/79k
         ZCKuk+KJob0oL8TkoUUONXjWWT7bxbPNvr+xSOP2dmEl/c6PFXrmU81xyPHGvC5kWZ2p
         BHzA==
X-Forwarded-Encrypted: i=1; AKwUvBw4keDwVQBSccLxWPoFIRHo/QPlB6lTbtTuMN7DJ52OdMsyLkaieIUTD4SDwql7HxjDoyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYItvBGiGWaBq3GyCh/zm2v/UxyE8LaMGNzXkrLx3jOhTUbNxSPX
	fvPZsfGji78dEasM38XQNACRyaDletNnzScib6zQ5pPvI1AoVkDqPTwG+bwuFQ==
X-Gm-Gg: AYBFou2Jn6AHMX8HNmP7i3irIWDqIvIEGSS9YVCDD9OXCS1kbH4sH+O4bn9zPGCngwy
	X6EKOB9Oto9pfhQnoVg3mT7cWrWEE3d5TyP2AfuELyYPd9xGELriTyPpFTOmNmQCX5vYRDcnuc7
	OIN2Xv0b+pSFtJ6sym8qI79yZnOxtBT/iDhiu6SU0AE1HOLfaasMu6VchBHJ2AuQsYRffivWcp5
	kHkHld2vx3kfbQkVhnDI1GpbXdzRAC1j9Mmoa74+6Ml9fCpEP0IhRaxabQ3JGeRlQB0zjxrhfMc
	rdiaGBwHe7Ruv6Qhub88sQFAbliGaH/jfvwKVvHczU1J2aCa7LIzfxYYLOaktIKWmYH2HL+nW9q
	edAR9iKj7tawwgwaMbrnPjcObxaUcT/Q/TUPdenRfZ3grWRSOxSVdzrbwWhd1dNafoOeQvwFf78
	4gQr7H3Qj8chI1zjDf0ZUc6ylhStDBM5BWQtjUcsK86jmtxK9WVVD1CjimrMGT8fdJN35Bioto9
	wOM2CfbYD8M/oez/0eSWbhDmzQqDILKYdubMXS+Z1yiHtYpVM50dVTyXh7rB0EOz31dF3LefzCj
	X3jqZP8SmrAmsTl3UhW9/2luWaldIFY4TZgQ2pEgCmniTrWM054FBRQWRtPY/A==
X-Received: by 2002:a05:6a20:9154:b0:3e2:4350:1528 with SMTP id adf61e73a8af0-3e287b9f8demr2780685637.7.1792620909702;
        Wed, 21 Oct 2026 15:15:09 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b84b6ffbsm444937a12.15.2026.10.21.15.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:15:07 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:15:06 +0000
Message-Id: <DMAV2RFTNVWP.26B5N5NZ3TCEL@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Stop JIT passes only when no insn
 moves
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <kernel-team@meta.com>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
In-Reply-To: <20261021-jit_size_fix-v1-1-b89fd32cafd6@meta.com>
References: <20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com> <20261021-jit_size_fix-v1-1-b89fd32cafd6@meta.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 07:21 AM Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
> A backward jump is sized from its target's current-pass address and its
> own previous-pass address, so it can grow while other jumps shrink. Two
> passes may then give the same image length with jumps still changing,
> and the image pass fails with "bpf_jit: fatal error".

can we fix the sizing of the backward jump instead ?

It's the third time it bites us.
commit 1612a981b766 ("bpf, x64: fix JIT emission for dead code")
special cased ja -1 and
commit c8831bdbfbab ("bpf, x64: Fix a jit convergence issue")
limited imm8 to 123 because of it.
With this patch jumps still grow, and the one that grows in a padding
pass still ends in "unexpected jmp_cond padding: -4 bytes".

do_jit() knows how far the current pass moved insn i. With that taken
into account a backward jump is sized by the insns it jumps over, the
same way as a forward one. Insn sizes start at 64 and only go down, so
the image shrinks with every pass like the comment in
bpf_int_jit_compile() says, and proglen == oldproglen means that
nothing moved.
Then no need for addrs_changed, for the ja -1 special case and
for is_imm8_jmp_offset().

Something like this (compile tested only):

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d..c20d7d3 100644
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
+ * one. 'moved' is how far this pass moved the start of insn i. With it a jump
+ * in either direction is sized by the insns it jumps over. All insns start at
+ * 64 bytes, so none of them ever grows and the image shrinks with every pass.
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

@@ -3747,8 +3709,8 @@ emit_cond_jmp:		/* Convert BPF opcode to x86 */
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
@@ -3788,23 +3750,10 @@ emit_cond_jmp:		/* Convert BPF opcode to x86 */
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
@@ -3833,7 +3782,7 @@ emit_cond_jmp:		/* Convert BPF opcode to x86 */
 				break;
 			}
 emit_jmp:
-			if (is_imm8_jmp_offset(jmp_offset)) {
+			if (is_imm8(jmp_offset)) {
 				if (jmp_padding) {
 					/* To avoid breaking jmp_offset, the extra bytes
 					 * are padded before the actual jmp insn, so
@@ -3869,7 +3818,7 @@ emit_jmp:
 			    emit_unwind_ret_addr(&prog, ip))
 				return -EINVAL;
 			if (seen_exit) {
-				jmp_offset = ctx->cleanup_addr - addrs[i];
+				jmp_offset = ctx->cleanup_addr - addrs[i] + moved;
 				goto emit_jmp;
 			}
 			seen_exit = true;
@@ -3930,6 +3879,7 @@ emit_jmp:
 			memcpy(rw_image + proglen, temp, ilen);
 		}
 		proglen += ilen;
+		moved = addrs[i] - proglen;
 		addrs[i] = proglen;
 		prog = temp;
 	}

pw-bot: cr
