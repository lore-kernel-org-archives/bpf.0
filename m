Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118516;
	b=mETgvvAB7df18SsCH77N3FCpJ6P2zL/6gkvTPTLGUqqgTIg2mRgg/fAinJH6+hwvDspi
	 hwxobmvK1PETRsH51T0swIxFJCEJfeko043c2mve213zhKp/XXfmKZU1OAmiS+pxXAIWV
	 WMonrhOmufR4V1D/dCBooSD4fxEDtb/LObhLZEHOdUiPI+0sjeWuGsCYtFUOFyLSRAshX
	 pgwAuCrWeQBC6+LrlG1KG1z2eYts3lNcabFpepXlDJW90pxOOfwYYhijBmiTCyWYuYSKk
	 IPDEl+FH1qiLNfnMB4iVerT1yXheG7IdkNA9wviukNe/viEHsY7+NRle6KBs56+02uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Is/VigphlVNdtyVhp2O2WMOYfLCpjTzB65XWC2+VGdY=;
	b=TT7Ra+ENxo+F9o0bsfrBfrkZmpcR9P0Mr75m2e4wTdwKKj415wGRUiUCZlcA+9RNcEn7
	 msSF6pXSsyBnq2dN0cRHkzGOJ108EoEVheMJH7/X8O0o2X0u65CkgfKCxzWW7TlHXd1z2
	 plAkVFgry5prbLSpzoTWtarvMKcka0y3FGyTiM/my4jXkP/7jd0EfFb0Lavtma6xP9d3O
	 2a3ffK+pyIl+R6Rh0GyH3P+0s9t7tLL2r74gPbKtM/588wIZQdZVVW5+OFxsCAsxG+uV8
	 oh8CHVKSWlZ6eD2k6D8v8ea+yl6uVQoOjNX6Y9H44Yu6qdGSLbUnKnRaRU99QfVglJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Q8zHLuOZ;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F8606A322
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D1F8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Q8zHLuOZ
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89f639ba307so32806b3a.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118515; x=1793723315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Is/VigphlVNdtyVhp2O2WMOYfLCpjTzB65XWC2+VGdY=;
        b=Q8zHLuOZzZd4t5spy1OouZb9yAAkxNR1Emzgp3W4q92uxabvbPpIKkB4knJ56i5f2f
         6NYXsiH6eAVS/kSbAtA0nDPqE5aVDEd1gwhc/gDVTJVHzYyrLrgUdWcWeQYMPeiHunNf
         q6/NiKUqA226gBmoM6Ueq/i9gkdEN74Z+f08HwAhU9qq53d+p85iTU+cDCoZvkJUaKwM
         SLpTQl6fYoi88U9MGdYbpNaYC7GH5HvJu/P6Z2RTu1bTWB+Kfxw7j+NpaBrr1rYXxosF
         MLrN21P+rLqkdrm4NPlYrTvxGNbpT513UvBLUtPBJB1wpi4wKXfpARhWJ4ByF5TYbjj7
         Hw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118515; x=1793723315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Is/VigphlVNdtyVhp2O2WMOYfLCpjTzB65XWC2+VGdY=;
        b=Ufw+U67BHina14MAFjtVVVytAjeYJ4ry5NY0Rb01hZrhDuZzMfMAdAnmY5sXU+Nv0Z
         pPL4e9bO4zlk3nWNsLevyBt8Yh0COD6xbKc+jCmcjqzSRNHOiqjETEwA6K2qi6scIQk2
         d44Il+qTWPiY7jSu6+DpxX605QDLyVcePpn6Tk/e1JdCuGvWBg/OLcUkoJrRq5LE+fK9
         yvjssa6Yk9+Wi28hYgW7esJQ0u9dODvi2TQX5tnOiCoD3Pn4VUbCUWkWygQEr6CwNjsf
         mh4YdKj/kmy7dqZIMtEv3tkUsF6S0SNT8X4pL+TXLD7+2MlDUyLx5L4AUfujS7ey4qHo
         F9QQ==
X-Gm-Message-State: AFq9FYIOEAYKcdbmLEn3w+Isf58IagTyaOmylZ66XDGAJeVCr/Z4x/Iv
	bGlFEGy/rKgGjhlOLeIZ4Eo0VQZVB0lJduYaAVeRof+dviJ7vlYhi2qkrd9pLw/rc4DOj//6RjN
	zxrcCiIk=
X-Gm-Gg: AYBFou0thHbIFmTcISMAG5TtAe2rdYe4HKgFGHaNaINR5UtBn/Q/G0zQcqQ0k55x9Co
	14diGtvWKFG7aooItpMUgOaqaX0OQtkj2V5bsNW66Zi8+DB+INiy87jbG8CAU+CVKD4FXVHM+hb
	folkbLZ+pnEWnMdlx6DZsfmaLr7c0hYPlZO7446QXTQUoqDbwZwEnqQPWyWmcLohgdN6Q7fTtEY
	O/L9qpjBgaYAywR9jlRYqYhPjWBiJjDDBFuQuvRW8c5N3Hbx4+gwCNCpyyu4aHoZh9VonobcosJ
	/sznBXls3fnwKd0yMFSnIjGqFWPuv4IHOWIIXiD7MtvkyKJ1/FuRnOOvqnisO+abLwRtdtxyGze
	HxOV9AO7mD1diND4DSElqG4F7qNNe1Tpnz/RMvJLMfhEFKwwdaBWucwbdt2wKxYvUCuxHBrpbjX
	1DZooMq6ddjfFXBw8M4rk8rb8SpDnR8fyJnOGboH5ESTUTDtIIeZjMaupBFzw5Mwf/juMJ3B89G
	291fXc22WbyUqJDp+Jin3UE9MBEhivyGf8NQjacmrIbN5aT9mwiAk2rK7UUq7jLh30yxErN9tvi
	sr3JF+XrUn8f0990i38=
X-Received: by 2002:a05:6a20:3944:b0:3e2:ae03:b298 with SMTP id adf61e73a8af0-3e7bfac0de7mr8746985637.41.1793118515275;
        Tue, 27 Oct 2026 09:28:35 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 3/7] arm64, bpf: JIT internal IRQ save and restore instructions
Date: Tue, 27 Oct 2026 16:28:16 +0000
Message-ID: <20261027162820.10887-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
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

Implement the internal IRQ save/restore instruction in the arm64 JIT,
using the encoded destination register as the flags pointer.

Support both DAIF masking and GIC priority masking. Preserve the existing
priority-mask synchronization requirements when restoring interrupt
state, and decline inlining when IRQ tracing or priority-mask debugging
is enabled.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 arch/arm64/net/bpf_jit.h      |  8 ++++++++
 arch/arm64/net/bpf_jit_comp.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b2fe6e6dcf44..23cbc38510a0 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -8,6 +8,7 @@
 #define _BPF_JIT_H
 
 #include <asm/insn.h>
+#include <asm/sysreg.h>
 
 /* 5-bit Register Operand */
 #define A64_R(x)	AARCH64_INSN_REG_##x
@@ -338,6 +339,13 @@
 #define A64_MRS_SP_EL0(Rt) \
 	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_SP_EL0)
 
+#define A64_MRS_SYSREG(Rt, SysReg) \
+	(aarch64_insn_get_mrs_value() | (SysReg) | (Rt))
+#define A64_MSR_SYSREG(Rt, SysReg) \
+	(aarch64_insn_get_msr_reg_value() | (SysReg) | (Rt))
+#define A64_MSR_DAIFSET(Imm) \
+	(aarch64_insn_get_msr_imm_value() | pstate_field(3, 6) | ((Imm) << PSTATE_Imm_shift))
+
 /* Barriers */
 #define A64_SB aarch64_insn_get_sb_value()
 #define A64_DSB_NSH (aarch64_insn_get_dsb_base_value() | 0x7 << 8)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 326e9e1dea0a..b7f4e4b68e9d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -22,6 +22,7 @@
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/irqflags.h>
 #include <asm/text-patching.h>
 
 #include "bpf_jit.h"
@@ -2031,6 +2032,33 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		}
 		break;
 
+	case BPF_ST | BPF_IRQ:
+	{
+		bool pmr = system_uses_irq_prio_masking();
+		u32 sysreg = pmr ? SYS_ICC_PMR_EL1 : sys_reg(3, 3, 4, 2, 1);
+
+		if (imm == BPF_IRQ_SAVE) {
+			emit(A64_MRS_SYSREG(tmp, sysreg), ctx);
+			if (pmr) {
+				emit(A64_CMP_I(1, tmp, GIC_PRIO_IRQON), ctx);
+				emit(A64_B_(A64_COND_NE, 3), ctx);
+				emit_a64_mov_i(1, tmp2, GIC_PRIO_IRQOFF, ctx);
+				emit(A64_MSR_SYSREG(tmp2, sysreg), ctx);
+			} else {
+				emit(A64_MSR_DAIFSET(3), ctx);
+			}
+			emit(A64_STR64I(tmp, dst, 0), ctx);
+		} else if (imm == BPF_IRQ_RESTORE) {
+			emit(A64_LDR64I(tmp, dst, 0), ctx);
+			emit(A64_MSR_SYSREG(tmp, sysreg), ctx);
+			if (pmr && !alternative_has_cap_likely(ARM64_HAS_GIC_PRIO_RELAXED_SYNC))
+				emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_SY), ctx);
+		} else {
+			return -EINVAL;
+		}
+		break;
+	}
+
 	/* ST: *(size *)(dst + off) = imm */
 	case BPF_ST | BPF_MEM | BPF_W:
 	case BPF_ST | BPF_MEM | BPF_H:
@@ -3537,6 +3565,12 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_supports_irq_save_restore(void)
+{
+	return !IS_ENABLED(CONFIG_TRACE_IRQFLAGS) &&
+	       !IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING);
+}
+
 bool bpf_jit_bypass_spec_v4(void)
 {
 	/* In case of arm64, we rely on the firmware mitigation of Speculative
-- 
2.52.0

