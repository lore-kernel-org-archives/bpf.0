Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B033E34B;
	Wed, 12 Aug 2026 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515349; cv=none; b=XK+7EYkM1HO7u2+0WfB+YQqzQGTzFfgyQ2EzeRWbWKG+/ZF+oAX4fG25kN2+iiCRgHSBlPMbjDzW1J6GMht3JYonxm6gvKtmd90Cfd6eL91jqKsocoomf4XQVpn0r+wf9af2t9etU9hRWEmegZhG4DUWkc3vbJqLTFF4FmGpuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515349; c=relaxed/simple;
	bh=0Ce85bV5lT5lMzieQ5ba5sEhxcRoCubiNNv0bA4qfXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFRKNDgiv1EYfxNGUpO43/V812dOMEC0jFNp1X8QmLAzJKQr/JMi/huFwBL95VCcGn9kx+6gx/RrD8f26v3iHIk2B1S3G5Z6HsvDxs96XnJrcQPaM2f/xM3yDb1nF37T0c0EktiJEoWHLxf50KOGcFNmkkga6RxgCe5gopwT9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3bd2dc94961511f1aa26b74ffac11d73-20260812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:102c2356-60fb-4d33-8beb-edca2ad902b1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c4e4363d59d2d4125f9f078fc1ff61bd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3bd2dc94961511f1aa26b74ffac11d73-20260812
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1487058221; Wed, 12 Aug 2026 14:15:36 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Wed, 12 Aug 2026 06:15:32 +0000
Subject: [bpf-next PATCH 1/2] bpf, riscv: Add BPF stack arguments support
 for RV64 JIT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-bpf-riscv-stack-args-v1-1-67b246806e59@kylinos.cn>
References: <20260812-bpf-riscv-stack-args-v1-0-67b246806e59@kylinos.cn>
In-Reply-To: <20260812-bpf-riscv-stack-args-v1-0-67b246806e59@kylinos.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

Add bpf_jit_supports_stack_args() for the RV64 JIT so BPF subprograms
and kfuncs can receive more than 5 arguments via the stack
(BPF_REG_PARAMS / r11).

For BPF-to-BPF calls the caller writes outgoing arguments at the
bottom of its frame (SP-relative). The callee reads them with
FP-relative loads. Its FP is set to the caller SP in the prologue,
so the offsets match.

The RISC-V ABI puts arguments 6-8 in A5-A7 and arguments 9+ at
SP+0. Before each kfunc call, load arguments 6-8 from the outgoing
area into A5-A7 and copy any remaining arguments down so argument 9
lands at SP+0.

A5 (BPF_REG_0), A6 (TCC) and A7 are safe to clobber here: R0 is not
live before a call, TCC is backed up on the stack, and A7 is unused
by the JIT.

Limit the existing kfunc sign-extension loop to MAX_BPF_FUNC_REG_ARGS
iterations; otherwise idx >= 5 resolves to S1-S5 (BPF_R6-FP) and
corrupts callee-saved registers.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 arch/riscv/net/bpf_jit.h        |  1 +
 arch/riscv/net/bpf_jit_comp64.c | 75 +++++++++++++++++++++++++++++++++++++++--
 arch/riscv/net/bpf_jit_core.c   |  4 +++
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 419b9d795f2a..9eb4e149505d 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -82,6 +82,7 @@ struct rv_jit_context {
 	unsigned long flags;
 	int stack_size;
 	int tcc_offset;
+	u16 stack_arg_size;
 	u64 arena_vm_start;
 	u64 user_vm_start;
 };
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 6b9972b07c1b..b3f4bf9e1e7f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1815,18 +1815,39 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			const struct btf_func_model *fm;
-			int idx;
+			int idx, nargs;
 
 			fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
 			if (!fm)
 				return -EINVAL;
 
-			for (idx = 0; idx < fm->nr_args; idx++) {
+			nargs = min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS);
+			for (idx = 0; idx < nargs; idx++) {
 				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
 
 				if (fm->arg_size[idx] == sizeof(int))
 					emit_sextw(reg, reg, ctx);
 			}
+
+			/* BPF stack args -> RISC-V ABI: args 6-8 in A5-A7, 9+ at SP+0 */
+			if (fm->nr_args > MAX_BPF_FUNC_REG_ARGS) {
+				int n_stack = fm->nr_args - MAX_BPF_FUNC_REG_ARGS;
+				int n_reg = min_t(int, n_stack,
+						  RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS);
+
+				for (idx = 0; idx < n_reg; idx++) {
+					int sz = fm->arg_size[MAX_BPF_FUNC_REG_ARGS + idx];
+
+					emit_ld(RV_REG_A5 + idx, idx * 8, RV_REG_SP, ctx);
+					if (sz == sizeof(int))
+						emit_sextw(RV_REG_A5 + idx, RV_REG_A5 + idx, ctx);
+				}
+
+				for (idx = 0; idx < n_stack - n_reg; idx++) {
+					emit_ld(RV_REG_T1, (n_reg + idx) * 8, RV_REG_SP, ctx);
+					emit_sd(RV_REG_SP, idx * 8, RV_REG_T1, ctx);
+				}
+			}
 		}
 
 		/* restore TCC to RV_REG_TCC before bpf2bpf call */
@@ -1891,6 +1912,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_W:
 	case BPF_LDX | BPF_MEM | BPF_DW:
+		if (insn->src_reg == BPF_REG_PARAMS) {
+			int idx = off / 8 - 1;
+
+			if (is_12b_int(idx * 8)) {
+				emit_ldx_insn(rd, idx * 8, RV_REG_FP, BPF_SIZE(code), false, ctx);
+			} else {
+				emit_imm(RV_REG_T1, idx * 8, ctx);
+				emit_add(RV_REG_T1, RV_REG_T1, RV_REG_FP, ctx);
+				emit_ldx_insn(rd, 0, RV_REG_T1, BPF_SIZE(code), false, ctx);
+			}
+			if (BPF_SIZE(code) != BPF_DW && insn_is_zext(&insn[1]))
+				return 1;
+			break;
+		}
+		fallthrough;
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
@@ -1938,6 +1974,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ST | BPF_MEM | BPF_H:
 	case BPF_ST | BPF_MEM | BPF_W:
 	case BPF_ST | BPF_MEM | BPF_DW:
+		if (insn->dst_reg == BPF_REG_PARAMS) {
+			int idx = -off / 8 - 1;
+
+			emit_imm(RV_REG_T1, imm, ctx);
+			if (is_12b_int(idx * 8)) {
+				emit_stx_insn(RV_REG_SP, idx * 8, RV_REG_T1, BPF_SIZE(code), ctx);
+			} else {
+				emit_imm(RV_REG_T2, idx * 8, ctx);
+				emit_add(RV_REG_T2, RV_REG_SP, RV_REG_T2, ctx);
+				emit_stx_insn(RV_REG_T2, 0, RV_REG_T1, BPF_SIZE(code), ctx);
+			}
+			break;
+		}
+		fallthrough;
 	/* ST | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = imm */
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
@@ -1960,6 +2010,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_W:
 	case BPF_STX | BPF_MEM | BPF_DW:
+		if (insn->dst_reg == BPF_REG_PARAMS) {
+			int idx = -off / 8 - 1;
+
+			if (is_12b_int(idx * 8)) {
+				emit_stx_insn(RV_REG_SP, idx * 8, rs, BPF_SIZE(code), ctx);
+			} else {
+				emit_imm(RV_REG_T1, idx * 8, ctx);
+				emit_add(RV_REG_T1, RV_REG_SP, RV_REG_T1, ctx);
+				emit_stx_insn(RV_REG_T1, 0, rs, BPF_SIZE(code), ctx);
+			}
+			break;
+		}
+		fallthrough;
 	/* STX | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = src */
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
@@ -2036,6 +2099,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 
 	stack_adjust = round_up(stack_adjust, STACK_ALIGN);
 	stack_adjust += bpf_stack_adjust;
+	stack_adjust += ctx->stack_arg_size;
 
 	store_offset = stack_adjust - 8;
 
@@ -2093,7 +2157,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
 	if (bpf_stack_adjust)
-		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
+		emit_addi(RV_REG_S5, RV_REG_SP, ctx->stack_arg_size + bpf_stack_adjust, ctx);
 
 	ctx->stack_size = stack_adjust;
 
@@ -2171,3 +2235,8 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_stack_args(void)
+{
+	return true;
+}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index cbfcd287ea16..844a0f3e0fa9 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -72,6 +72,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx->prog = prog;
+
+	ctx->stack_arg_size = round_up(bpf_out_stack_arg_cnt(env, prog) *
+				       sizeof(u64), STACK_ALIGN);
+
 	ctx->offset = kvzalloc_objs(int, prog->len);
 	if (!ctx->offset)
 		goto out_offset;

-- 
2.53.0

