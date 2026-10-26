Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983622;
	b=OjVLsHYHx21P6qZXJxehqRDQEuUGXlpQeeIn2ndY7leVQhNCzzOdmMzuVSlTTuclN/Cn
	 zRv6dYl/EYTd4WIjDebNXCk/EE9dfqbN1nw1JrDlub8u43eEJFJ+pYBct8XVxYQBtRdu7
	 J0dF+UTdj0exUyN5Zi80xKuMMP9XIJhZppDGZw7MnBXoZLYfVs1w4Mm37UIJ38WtsP1Up
	 Oy4UKE2he8DIbJCAJiT5969yXWuAgGNv3ikNLN7GaURN1GtUIhPEZ7a4KXVkoZYVAF9sF
	 a1QyW0lYNuK5D5uZIcylLkIWJWzldfRF6LvHZ4YwcgfOPsizhLWsvsg6Lthlua3jntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GDOLQZAFyg6AnWLFz2UjtHf/pV9Gd+HVQWbyn+Bu44I=;
	b=r9lvouxiN/IIWyozD6791yF8W5ydgASpjmCHvh85vGAEboDsxDquv5QvM/+6GeXPvNyP
	 iZY9YMba/faUW92UTewY26+di95su9nHvGkYsZZB/YnwpweysDgfuxtSWSH3MZ38C/Vlz
	 QNPbo5VIoVWt/w/BffQDIZ339KOUbNuHvjKlLis1p9yBtsKOlQlQgWR6QwqUsYF924HpV
	 j8yKmAB4KTV6OH9+pbxspWjiSmaMsK9dL288E9uoqHrFb7Um3GNX6bqh2Iuef4ByTfivx
	 mwK2WIjca3875l5SNawembqJA8tQB5askaBM38vD8P4anSeibMmUBZfb+eZrIB0wfkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ICbTK7sN;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6AD606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D6AD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ICbTK7sN
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so1719507a12.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983622; x=1793588422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDOLQZAFyg6AnWLFz2UjtHf/pV9Gd+HVQWbyn+Bu44I=;
        b=ICbTK7sNy0P92VclyTY22ukog7f3xQk+0gXhQQnqz+1IhHfEFfe9VesKhnaRhHKiBK
         8RKWHqdNC3oBUh9vjcZBcoy30zY5VngrcWETc8h4xH3x90P6UdnWbK++pvhx4bRpTEfK
         ctWx57PZm/iKPU2JhKDd2Hvh2KSURAc/yvgB+n3i2eViRMyRSgNySY2/DgarrN7656je
         zcbbQH04R/cM52Ld3VLrVIJmmhLDr4xTgvSZ3+smwTtPHnCnsGM0dTIKvZDZaiHFVrlU
         hAGv3lj4EHpb9E+4e6TamPyGf7xWQFcIRHkqeQ3vdnUK2nAMi7dGV9zFnB9viNf0bjx/
         v0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983622; x=1793588422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GDOLQZAFyg6AnWLFz2UjtHf/pV9Gd+HVQWbyn+Bu44I=;
        b=Dn/8PcwB7BftiloVH8l/5GUvk0Jg/jq9r8jIQI0BT3aCrYZ0TKOXNF25EuP0yhh1IL
         4/sBBJ8Hyv3ZgKG/pZEdH6VizLZbH4HV4cysOGy+LejlKfmsO4RL5zKLXvGSHc7DqDyh
         YugOdZ46P7bGhzHlMyVSc7g8bdK6Veb+dlpZ64qOWR/6EQPgRB+ISE4EoeZA7ZkhG33s
         vYSOjcWAlqLnjf91BTGGePHTkXTu4FMBUQ7GBihB/2Mgjt+gKFpcau5f8Tm/EdWTnjkS
         8YJwacOPdNIPTbKJFAjuNaSsn9bc/h1eIPPswcWekAyDLi9vpIsKowSWpQelWVCnkvMP
         BQew==
X-Gm-Message-State: AFq9FYJNdPvgYLbGU2oyQksB3Sfg5U9leVxtIV2q+vBI5Xo9DpA68EI0
	tkTXBeVDHxl6L9x051HOSw/37r4Tt++xqvFiYMvz6momy3g8Mm5T7HYTmjAxGw==
X-Gm-Gg: AYBFou1r3rbcvoJDdQ5SBSC+ehgYUzskFUDQk4yZPuob7Vazg/AxUTDyeBSAufaAkeI
	jHaBt0FDPY2Gm2h9TQstPYtUgLlv977qEfepSiQqgQycYXV/1S6sMxmxVWmqwN0Iz6Z4iLAFQkF
	Wbm4EsjPUCMpfzqg7gwONhOIOqA3RTirGerjfzSRoWSNkf4E/U0M7oue5z9y/vaTdElM6tzzf2m
	QpzafZ/ml1cQlcsjw8+5vdDOnkhTnwk3/P/ydfdRs/1Ddv+/C8nAFwDM0aw2EhQ75AUkJwzM/Vq
	RwRDxGJd7YVw0wmDP4ASyd8SxKZMxAbZ4NGoRPEKgp63k35yUBGhqixT28FYu1i3arrIqsblmUS
	36UR1pglIvsbdiNf6QWHkibqRBGpk2T9FIDgXNAPtWICJwWIvM6KxOAAmXrr1MQ9Ory1hYGUe9D
	XsI09a2seu7aWQjoWQING5o35GT+1oHC2Vi4DjT0H6mCMF1YiWJtkYuOrjHQLFsbz7KyLeGz4Ik
	CLS3xL8w93YTzhNRN2D8HaLoFeOmqeJFymO7vFAdxOUSoPKDqhrfYcALrfM6INChUtncLWKp++O
	gAKIoRWeGkmkzMJW+Cm2Awpugfa8B5HvFkEqg/6hLgeJNfoxCN5NKhredYWWlp/lKiMeCPfpFXs
	Vlb/MtFtFlwXBdfBAhHhKNwJwMmzbGg8XuSRPDLdlj9pjzQ==
X-Received: by 2002:a17:90b:291:b0:3ac:9f24:44df with SMTP id 98e67ed59e1d1-3adea1ad71dmr3582017a91.2.1792983621520;
        Sun, 25 Oct 2026 20:00:21 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0a7sm6512282a91.9.2026.10.25.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 06/81] bpf, x86: Remove r0_on_stack from fetching atomics in arena
Date: Mon, 26 Oct 2026 02:58:27 +0000
Message-ID: <20261026025943.404450-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

x86 has no fetching AND/OR/XOR. Thus the JIT emits a loop with cmpxchg.
cmpxchg uses RAX, and RAX holds BPF R0. Thus the JIT saves R0 before the
loop.

  prog                        the address is in   the JIT saves R0 in
  --------------------------  ------------------  -------------------
  without the flag            a BPF register      BPF_REG_AX
  with BPF_F_ARENA_SCALAR     BPF_REG_AX          the stack

The flag is removed. Remove the second variant.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 58 +++++++++----------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7bfb7210484e..d90b6d238b3a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1745,26 +1745,20 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
 /*
  * A fetching AND/OR/XOR can't be implemented with a single x86 insn, so do a
  * CMPXCHG loop. @index_reg is X86_REG_R12 for an arena access or -1 otherwise.
- * Unless @r0_on_stack, the caller has substituted BPF_REG_AX for R0 in
- * @dst_reg and @src_reg.
+ * The caller has saved R0 in BPF_REG_AX and has substituted BPF_REG_AX for R0
+ * in @dst_reg and @src_reg.
  *
  * Both the load and the CMPXCHG can fault when accessing the arena, so their
  * addresses are handed back in @fault[0] and @fault[1]. A fault has to resume
  * at @resume, which is past the loop and past the move that delivers the old
  * value, but before R0 is restored. Both are NULL for the non-arena case,
  * which needs no fixup.
- *
- * R0 is expected to be saved in BPF_REG_AX by the caller, or pushed on the
- * stack if @r0_on_stack. In that case an R0 operand stays in the stack slot,
- * RAX ends up holding the old value that R0 is to return, and the slot is
- * dropped rather than popped.
  */
 static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
-				 u32 src_reg, int index_reg, bool r0_on_stack,
+				 u32 src_reg, int index_reg,
 				 u8 **fault, u8 **resume)
 {
 	bool is64 = BPF_SIZE(insn->code) == BPF_DW;
-	bool operand_on_stack = r0_on_stack && src_reg == BPF_REG_0;
 	u8 *branch_target, *prog = *pprog;
 	int err;
 
@@ -1783,15 +1777,7 @@ static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
 	 * Perform the (commutative) operation locally, put the result in
 	 * the AUX_REG.
 	 */
-	if (operand_on_stack) {
-		/* mov r11, [rsp]: the operand is the R0 saved there, RAX is the old value */
-		if (is64)
-			EMIT4(0x4C, 0x8B, 0x1C, 0x24);
-		else
-			EMIT4(0x44, 0x8B, 0x1C, 0x24);
-	} else {
-		emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
-	}
+	emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
 	maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
 	EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
 	      add_2reg(0xC0, AUX_REG, src_reg));
@@ -1810,20 +1796,14 @@ static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
 
 	/* ZF tells us whether we won the race. If it's cleared we need to try again. */
 	EMIT2(X86_JNE, -(prog - branch_target) - 2);
-	/* Return the pre-modification value, which RAX already is for R0 */
-	if (!operand_on_stack)
-		emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
+	/* Return the pre-modification value */
+	emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
 
 	if (resume)
 		*resume = prog;
 
 	/* Restore R0 after clobbering RAX */
-	if (!r0_on_stack)
-		emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
-	else if (operand_on_stack)
-		EMIT2(0x41, 0x5B); /* pop r11, dropping the operand */
-	else
-		EMIT1(0x58); /* pop rax */
+	emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
 
 	*pprog = prog;
 	return 0;
@@ -3354,7 +3334,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			if (is_atomic_fetch) {
 				err = emit_atomic_fetch_rmw(&prog, insn, real_dst_reg,
-							    real_src_reg, -1, false,
+							    real_src_reg, -1,
 							    NULL, NULL);
 				if (err)
 					return err;
@@ -3383,29 +3363,19 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 			if (is_atomic_fetch_op(insn)) {
 				u32 real_src_reg = src_reg, real_dst_reg = dst_reg;
-				/*
-				 * An access through a number has its address in
-				 * BPF_REG_AX (see arena_scalar_access()), so R0 is
-				 * saved on the stack instead, as div and mod do.
-				 */
-				bool r0_on_stack = dst_reg == BPF_REG_AX;
 				u8 *fault[2], *resume;
 				int j;
 
 				/* Will need RAX as a CMPXCHG operand so save R0 */
-				if (r0_on_stack) {
-					EMIT1(0x50); /* push rax */
-				} else {
-					emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
-					if (src_reg == BPF_REG_0)
-						real_src_reg = BPF_REG_AX;
-					if (dst_reg == BPF_REG_0)
-						real_dst_reg = BPF_REG_AX;
-				}
+				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				if (src_reg == BPF_REG_0)
+					real_src_reg = BPF_REG_AX;
+				if (dst_reg == BPF_REG_0)
+					real_dst_reg = BPF_REG_AX;
 
 				err = emit_atomic_fetch_rmw(&prog, insn, real_dst_reg,
 							    real_src_reg, X86_REG_R12,
-							    r0_on_stack, fault, &resume);
+							    fault, &resume);
 				if (err)
 					return err;
 
-- 
2.55.0

