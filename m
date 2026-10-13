Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8D51FCDC
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913016; cv=none; b=FQLBTVpa5F5sK+/DM16uZLXOK89eqbOtBxW0R3EAvdwKsatOnjg7TWlwBe6LsP36tXFRmSKMMYjsG7hZmOhAUimIsr8easZOHoUDdkVQ+wN5Dal5S3y6Fjv6O0poMFIvdCJ0GQSr8FUcUaLOt51WralhGMIC8wkzz0Le+W9YPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913016; c=relaxed/simple;
	bh=FyfN4wBZKxMuKoUdxJs13pE2+Nzo8H0MJpjQB3QRTAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8UXF9Y8A4RyqtKyF6gtRF3CY3RgWuApKAaApChxssqp8vaWsgrqzMWy1wwijMiDA7E8geu/Gg9OQ7bqI5gXmQqOzgqL9a5lxUiNAiFf5eI+f6FhYIDj21bztczi+25ODWCtJFM5OPz7AvhQsAmRzIQfLF985Q3rWUnnooHx2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PN6dbqEe; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PN6dbqEe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2eq9JGlljQEd9D8sJXZQ38ivcD5GYVM1m7WXTt+/ez8=; b=PN6dbqEePrVo4I/tgMCHq709vV
	qUz6fyu0X7edoq1c2H1ZMwpgwQ0XoGCslXp+0v2mOGdTi50XZZqZOrASrsGo2ihYqNaatd6uf3Uw7
	1tzd+xwfOC8MmA1D+ZQQJT/N85/EAjMTwqM4jyhbsPrU5JU2scRtzsAYzxhNQdPIQPU2BCGhSzSqL
	k47PoYp22fhjCYwa4owpS2idZgAV726itZ+9lyo04PXxIEdyRHcIz1iIgxxIzAqetuxAi6lqYYO9t
	sQ5doZBjRQt0H77jo4WZUTGerAiNjMMwciIlOP/axa2DdlpREGw5/ugasGD9NxV0eBpaik5dBDMnq
	9IGPHKEw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3F-000PQE-0Y;
	Tue, 13 Oct 2026 19:12:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 03/18] bpf, x86: Shorten the stack adjusts and the tail call counter loads
Date: Tue, 13 Oct 2026 19:12:15 +0200
Message-ID: <20261013171230.523677-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

The prologue and the tail call sequences always used the imm32 forms
of sub/add rsp and a disp32 load of the tail call counter pointer, even
when the rounded stack depth fits into a byte. Route them through the
existing emit_sub_rsp()/emit_add_rsp() and emit_ldx() helpers which pick
the short forms, and derive the ip adjustment for the counter load in
front of a subprog call from the emitted length instead of hardcoding
the 7 bytes. Nothing depends on the size of these instructions: the tail
call entry offset covers only the code in front of the stack adjustment,
and the poke targets are computed from the emitted bytes.

Before/after for a program with 32 bytes of stack:

  48 81 ec 20 00 00 00  subq $0x20,%rsp
  48 83 ec 20           subq $0x20,%rsp

  48 8b 85 d0 ff ff ff  movq -0x30(%rbp),%rax
  48 8b 45 d0           movq -0x30(%rbp),%rax

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 70243ccbe423..c6e814f7c806 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -421,7 +421,7 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 }
 
 /* add rsp, depth */
-static void emit_add_rsp(u8 **pprog, u16 depth)
+static void emit_add_rsp(u8 **pprog, u32 depth)
 {
 	u8 *prog = *pprog;
 
@@ -435,7 +435,7 @@ static void emit_add_rsp(u8 **pprog, u16 depth)
 }
 
 /* sub rsp, depth */
-static void emit_sub_rsp(u8 **pprog, u16 depth)
+static void emit_sub_rsp(u8 **pprog, u32 depth)
 {
 	u8 *prog = *pprog;
 
@@ -472,6 +472,7 @@ static void emit_nops(u8 **pprog, int len)
  * in arch/x86/kernel/alternative.c
  */
 static int emit_call(u8 **prog, void *func, void *ip);
+static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off);
 
 static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
 {
@@ -607,8 +608,7 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
 	EMIT_ENDBR();
 
 	/* sub rsp, rounded_stack_depth */
-	if (stack_depth)
-		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
+	emit_sub_rsp(&prog, round_up(stack_depth, 8));
 	if (tail_call_reachable)
 		emit_prologue_tail_call(&prog, is_subprog);
 	*pprog = prog;
@@ -851,7 +851,8 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	/* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, tcc_ptr_off);
 	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT); /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
@@ -888,9 +889,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * Pop tail_call_cnt_ptr, if it's subprog.
 	 */
 	EMIT1(0x58);                              /* pop rax */
-	if (stack_depth)
-		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
-			    round_up(stack_depth, 8));
+	emit_add_rsp(&prog, round_up(stack_depth, 8)); /* add rsp, sd */
 
 	/* goto *(prog->bpf_func + X86_TAIL_CALL_OFFSET); */
 	EMIT4(0x48, 0x8B, 0x49,                   /* mov rcx, qword ptr [rcx + 32] */
@@ -923,7 +922,8 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	/* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, tcc_ptr_off);
 	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT);   /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
@@ -955,8 +955,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	 * Pop tail_call_cnt_ptr, if it's subprog.
 	 */
 	EMIT1(0x58);                                  /* pop rax */
-	if (stack_depth)
-		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
+	emit_add_rsp(&prog, round_up(stack_depth, 8));
 
 	emit_nops(&prog, X86_PATCH_SIZE);
 
@@ -1857,7 +1856,7 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 #define __LOAD_TCC_PTR(off)			\
-	EMIT3_off32(0x48, 0x8B, 0x85, off)
+	emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, off)
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 16] */
 #define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
@@ -2958,8 +2957,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
+				u8 *tcc_load = prog;
+
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
-				ip += 7;
+				ip += prog - tcc_load;
 			}
 			if (!imm32)
 				return -EINVAL;
-- 
2.43.0

