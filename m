Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082B38F649
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396939; cv=none; b=ELgCqGllBfi2+MCTFkhHoFJ2u3h09pYufYGYHO9M74jsJpvBxSJxcGPEWP3QHhqjsELXuLl+N6M/pKqns4wV2PXFPqRa5b76JWHW+w/uufJzAnO4IYmxo9LgAJCz1yJv2FLnQDlo54cjgFKrekcDsOrW157a7iTSCzPnVmCuXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396939; c=relaxed/simple;
	bh=3iQ/he8K3to5eOGg5sxY1o3HG8suDE7wrLNCdx3KbQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gncZhMIp8ZBpMTDUvuwir8BlWBmBSQo3HKLl7mwoeSERB2cZ0vet1nxMunYB8+0cKf6VAtFxcvXFHemlwCqKYcMdOfDFmmK29JvxwvQKTrFcqBBBybfmnrOWDvbYxUMgSsXCsrEUL4VEJ2+7wJSdio6kPyVIErdXF4OTSqD8AFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qFsOcU+T; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qFsOcU+T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773396932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvfFpAeEzO8mpJMgvfojf+PtfgHI/igh01b3biiWulw=;
	b=qFsOcU+T/lKC5uaoxx2i7gVwSaRAZiw5Rbuz+aBrVIORZA4ull+Uld8ft0d8CKAXDGTFq1
	aCMPZnS9tduygQS7RZNgju3rnwsBELie0lgfZvP652ap4N6jLpIfyOzQ62LSGDh16UPFAx
	hPEeo3QL69GxbPFxqQ/n4yxGag8ILs4=
From: Leon Hwang <leon.hwang@linux.dev>
To: xukuohai@huaweicloud.com
Cc: a.s.protopopov@gmail.com,
	alexis.lothore@bootlin.com,
	andrii@kernel.org,
	ast@kernel.org,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	chleroy@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	gor@linux.ibm.com,
	hbathini@linux.ibm.com,
	hca@linux.ibm.com,
	hengqi.chen@gmail.com,
	iii@linux.ibm.com,
	johan.almbladh@anyfinetworks.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	list+bpf@vahedi.org,
	luke.r.nels@gmail.com,
	martin.lau@linux.dev,
	naveen@kernel.org,
	paulburton@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	udknight@gmail.com,
	xi.wang@gmail.com,
	yangtiezhu@loongson.cn,
	yonghong.song@linux.dev,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v9 4/5] bpf, x86: Emit ENDBR for indirect jump targets
Date: Fri, 13 Mar 2026 18:15:05 +0800
Message-ID: <20260313101505.104686-1-leon.hwang@linux.dev>
In-Reply-To: <20260312170255.3427799-5-xukuohai@huaweicloud.com>
References: <20260312170255.3427799-5-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, Mar 13, 2026 at 01:02:54AM +0800, Xu Kuohai wrote:
>From: Xu Kuohai <xukuohai@huawei.com>
>
>On CPUs that support CET/IBT, the indirect jump selftest triggers
>a kernel panic because the indirect jump targets lack ENDBR
>instructions.
>
>To fix it, emit an ENDBR instruction to each indirect jump target. Since
>the ENDBR instruction shifts the position of original jited instructions,
>fix the instruction address calculation wherever the addresses are used.
>
>For reference, below is a sample panic log.
>
> Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
> ------------[ cut here ]------------
> kernel BUG at arch/x86/kernel/cet.c:133!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
>
> ...
>
>  ? 0xffffffffc00fb258
>  ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>  bpf_prog_test_run_syscall+0x110/0x2f0
>  ? fdget+0xba/0xe0
>  __sys_bpf+0xe4b/0x2590
>  ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
>  ? bpf_prog_test_run_syscall+0x215/0x2f0
>  __x64_sys_bpf+0x21/0x30
>  do_syscall_64+0x85/0x620
>  ? bpf_prog_test_run_syscall+0x1e2/0x2f0
>
>Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
>Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
>Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>---
> arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++-----------
> 1 file changed, 15 insertions(+), 11 deletions(-)
>
>diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>index 72d9a5faa230..2d29830700f1 100644
>--- a/arch/x86/net/bpf_jit_comp.c
>+++ b/arch/x86/net/bpf_jit_comp.c
>@@ -1649,8 +1649,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
> 	return 0;
> }
>
>-static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>-		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>+static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>+		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
> {
> 	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
> 	struct bpf_insn *insn = bpf_prog->insnsi;
>@@ -1663,7 +1663,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> 	void __percpu *priv_stack_ptr;
> 	int i, excnt = 0;
> 	int ilen, proglen = 0;
>-	u8 *prog = temp;
>+	u8 *ip, *prog = temp;
> 	u32 stack_depth;
> 	int err;
>
>@@ -1734,6 +1734,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> 				dst_reg = X86_REG_R9;
> 		}
>
>+#ifdef CONFIG_X86_KERNEL_IBT
>+		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>+			EMIT_ENDBR();
>+#endif

NIT: is this CONFIG check necessary?

EMIT_ENDBR already checks it.

#ifdef CONFIG_X86_KERNEL_IBT
#define EMIT_ENDBR()		EMIT(gen_endbr(), 4)
#define EMIT_ENDBR_POISON()	EMIT(gen_endbr_poison(), 4)
#else
#define EMIT_ENDBR()
#define EMIT_ENDBR_POISON()
#endif

Thanks,
Leon

>+
>+		ip = image + addrs[i - 1] + (prog - temp);
>+
> 		switch (insn->code) {
> 			/* ALU */
> 		case BPF_ALU | BPF_ADD | BPF_X:
>@@ -2440,8 +2447,6 @@ st:			if (is_imm8(insn->off))
>
> 			/* call */
> 		case BPF_JMP | BPF_CALL: {
>-			u8 *ip = image + addrs[i - 1];
>-
> 			func = (u8 *) __bpf_call_base + imm32;
> 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
> 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
>@@ -2465,7 +2470,8 @@ st:			if (is_imm8(insn->off))
> 			if (imm32)
> 				emit_bpf_tail_call_direct(bpf_prog,
> 							  &bpf_prog->aux->poke_tab[imm32 - 1],
>-							  &prog, image + addrs[i - 1],
>+							  &prog,
>+							  ip,
> 							  callee_regs_used,
> 							  stack_depth,
> 							  ctx);
>@@ -2474,7 +2480,7 @@ st:			if (is_imm8(insn->off))
> 							    &prog,
> 							    callee_regs_used,
> 							    stack_depth,
>-							    image + addrs[i - 1],
>+							    ip,
> 							    ctx);
> 			break;
>
>@@ -2639,7 +2645,7 @@ st:			if (is_imm8(insn->off))
> 			break;
>
> 		case BPF_JMP | BPF_JA | BPF_X:
>-			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
>+			emit_indirect_jump(&prog, insn->dst_reg, ip);
> 			break;
> 		case BPF_JMP | BPF_JA:
> 		case BPF_JMP32 | BPF_JA:
>@@ -2729,8 +2735,6 @@ st:			if (is_imm8(insn->off))
> 			ctx->cleanup_addr = proglen;
> 			if (bpf_prog_was_classic(bpf_prog) &&
> 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>-				u8 *ip = image + addrs[i - 1];
>-
> 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
> 					return -EINVAL;
> 			}
>@@ -3791,7 +3795,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
> 	for (pass = 0; pass < MAX_PASSES || image; pass++) {
> 		if (!padding && pass >= PADDING_PASSES)
> 			padding = true;
>-		proglen = do_jit(prog, addrs, image, rw_image, oldproglen, &ctx, padding);
>+		proglen = do_jit(env, prog, addrs, image, rw_image, oldproglen, &ctx, padding);
> 		if (proglen <= 0) {
> out_image:
> 			image = NULL;
