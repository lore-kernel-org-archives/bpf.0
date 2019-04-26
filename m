Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60A6C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7810B2077B
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 19:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZTsm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:48:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:60882 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDZTsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 15:48:42 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hK6ps-0004dH-5A; Fri, 26 Apr 2019 21:48:40 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     will.deacon@arm.com, jean-philippe.brucker@arm.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 2/2] bpf, arm64: use more scalable stadd over ldxr / stxr loop in xadd
Date:   Fri, 26 Apr 2019 21:48:22 +0200
Message-Id: <20190426194822.7328-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190426194822.7328-1-daniel@iogearbox.net>
References: <20190426194822.7328-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25431/Fri Apr 26 09:57:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since ARMv8.1 supplement introduced LSE atomic instructions back in 2016,
lets add support for STADD and use that in favor of LDXR / STXR loop for
the XADD mapping if available. STADD is encoded as an alias for LDADD with
XZR as the destination register, therefore add LDADD to the instruction
encoder along with STADD as special case and use it in the JIT for CPUs
that advertise LSE atomics in CPUID register. If immediate offset in the
BPF XADD insn is 0, then use dst register directly instead of temporary
one.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/insn.h |  8 ++++++++
 arch/arm64/kernel/insn.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit.h      |  4 ++++
 arch/arm64/net/bpf_jit_comp.c | 28 +++++++++++++++++++---------
 4 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 9c01f04..ec894de 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -277,6 +277,7 @@ __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
 __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
+__AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0xB8200000)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
@@ -394,6 +395,13 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register state,
 				   enum aarch64_insn_size_type size,
 				   enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
+			   enum aarch64_insn_register address,
+			   enum aarch64_insn_register value,
+			   enum aarch64_insn_size_type size);
+u32 aarch64_insn_gen_stadd(enum aarch64_insn_register address,
+			   enum aarch64_insn_register value,
+			   enum aarch64_insn_size_type size);
 u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
 				 enum aarch64_insn_register src,
 				 int imm, enum aarch64_insn_variant variant,
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 7820a4a..9e2b588 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -734,6 +734,46 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 					    state);
 }
 
+u32 aarch64_insn_gen_ldadd(enum aarch64_insn_register result,
+			   enum aarch64_insn_register address,
+			   enum aarch64_insn_register value,
+			   enum aarch64_insn_size_type size)
+{
+	u32 insn = aarch64_insn_get_ldadd_value();
+
+	switch (size) {
+	case AARCH64_INSN_SIZE_32:
+	case AARCH64_INSN_SIZE_64:
+		break;
+	default:
+		pr_err("%s: unimplemented size encoding %d\n", __func__, size);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
+					    result);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    address);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
+					    value);
+}
+
+u32 aarch64_insn_gen_stadd(enum aarch64_insn_register address,
+			   enum aarch64_insn_register value,
+			   enum aarch64_insn_size_type size)
+{
+	/*
+	 * STADD is simply encoded as an alias for LDADD with XZR as
+	 * the destination register.
+	 */
+	return aarch64_insn_gen_ldadd(AARCH64_INSN_REG_ZR, address,
+				      value, size);
+}
+
 static u32 aarch64_insn_encode_prfm_imm(enum aarch64_insn_prfm_type type,
 					enum aarch64_insn_prfm_target target,
 					enum aarch64_insn_prfm_policy policy,
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 6c88165..76606e8 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -100,6 +100,10 @@
 #define A64_STXR(sf, Rt, Rn, Rs) \
 	A64_LSX(sf, Rt, Rn, Rs, STORE_EX)
 
+/* LSE atomics */
+#define A64_STADD(sf, Rn, Rs) \
+	aarch64_insn_gen_stadd(Rn, Rs, A64_SIZE(sf))
+
 /* Add/subtract (immediate) */
 #define A64_ADDSUB_IMM(sf, Rd, Rn, imm12, type) \
 	aarch64_insn_gen_add_sub_imm(Rd, Rn, imm12, \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a1420626..df845ce 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -365,7 +365,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64 ||
 			  BPF_CLASS(code) == BPF_JMP;
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
-	u8 jmp_cond;
+	u8 jmp_cond, reg;
 	s32 jmp_offset;
 
 #define check_imm(bits, imm) do {				\
@@ -756,18 +756,28 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			break;
 		}
 		break;
+
 	/* STX XADD: lock *(u32 *)(dst + off) += src */
 	case BPF_STX | BPF_XADD | BPF_W:
 	/* STX XADD: lock *(u64 *)(dst + off) += src */
 	case BPF_STX | BPF_XADD | BPF_DW:
-		emit_a64_mov_i(1, tmp, off, ctx);
-		emit(A64_ADD(1, tmp, tmp, dst), ctx);
-		emit(A64_LDXR(isdw, tmp2, tmp), ctx);
-		emit(A64_ADD(isdw, tmp2, tmp2, src), ctx);
-		emit(A64_STXR(isdw, tmp2, tmp, tmp3), ctx);
-		jmp_offset = -3;
-		check_imm19(jmp_offset);
-		emit(A64_CBNZ(0, tmp3, jmp_offset), ctx);
+		if (!off) {
+			reg = dst;
+		} else {
+			emit_a64_mov_i(1, tmp, off, ctx);
+			emit(A64_ADD(1, tmp, tmp, dst), ctx);
+			reg = tmp;
+		}
+		if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS)) {
+			emit(A64_STADD(isdw, reg, src), ctx);
+		} else {
+			emit(A64_LDXR(isdw, tmp2, reg), ctx);
+			emit(A64_ADD(isdw, tmp2, tmp2, src), ctx);
+			emit(A64_STXR(isdw, tmp2, reg, tmp3), ctx);
+			jmp_offset = -3;
+			check_imm19(jmp_offset);
+			emit(A64_CBNZ(0, tmp3, jmp_offset), ctx);
+		}
 		break;
 
 	default:
-- 
2.9.5

