Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAA3D9035
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342876; cv=none; b=SJk8mlxmxrQEVQc+cbdS4++v1CXQvT305uiisVZ/nwWTGw3clnWyMgOTBIImeSmmZT0svfjgD1Biy0jfKLro/RKa52JN3R7RAk7v2LH2Qf2AenCLxCT7lipjFkOtnlafTBt5OvLpJ9J5U1Fl/1cM5PuSauShHTwsY+58jW4+/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342876; c=relaxed/simple;
	bh=6bTOKpJUu3mLkeV+jloDiFyvGWHRv1PuScS91Awj4/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTuzNWeod62AykUHEPTvTaBQ56ACKiwj9oQmgJJPvLyBuVJJtOlM/ND65C4+n/JG+aN1EddJarmVu/iJi52v7vHog6laWQQdeX+7wvJLDJyW+oa8yKYRio8R9Mi83Wt0Zbgaxhd6FV8BKt0yXkwtNjPsodGJ67LG/mbMOnmofWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx48DYUsJpkiAeAA--.26894S3;
	Tue, 24 Mar 2026 17:01:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LTUsJpmxVcAA--.43301S4;
	Tue, 24 Mar 2026 17:01:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC PATCH 2/7] LoongArch: Add some code related with {LLACQ/SCREL}.{W/D}
Date: Tue, 24 Mar 2026 17:01:01 +0800
Message-ID: <20260324090106.13527-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260324090106.13527-1-yangtiezhu@loongson.cn>
References: <20260324090106.13527-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxC8LTUsJpmxVcAA--.43301S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFW7Gw1fCF13CFyfCw4kGrX_yoWrAw17pF
	yqyr4kXFWrWrnaka4qqF4Y9r4UJa1kCrWaqF1UCa1vyF1UX34UZw1vkr9xZFyDta1kXa40
	9rn3uw1YqF15JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=

The load-acquire and store-release instructions {LLACQ/SCREL}.{W/D} were
newly added in the latest LoongArch Reference Manual, add the definitions
of the instruction code and also check whether support these instructions.

This is preparation for later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/cpu-features.h | 1 +
 arch/loongarch/include/asm/cpu.h          | 2 ++
 arch/loongarch/include/asm/inst.h         | 4 ++++
 arch/loongarch/include/uapi/asm/hwcap.h   | 1 +
 arch/loongarch/kernel/cpu-probe.c         | 4 ++++
 5 files changed, 12 insertions(+)

diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index f9d3188accfc..54cd5c552116 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -69,5 +69,6 @@
 #define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
 #define cpu_has_redirectint	cpu_opt(LOONGARCH_CPU_REDIRECTINT)
 #define cpu_has_lam_bh		cpu_opt(LOONGARCH_CPU_LAM_BH)
+#define cpu_has_llacq_screl	cpu_opt(LOONGARCH_CPU_LLACQ_SCREL)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index b423b1f41145..7cb485de083b 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -127,6 +127,7 @@ static inline char *id_to_core_name(unsigned int id)
 #define CPU_FEATURE_AVECINT		31	/* CPU has AVEC interrupt */
 #define CPU_FEATURE_REDIRECTINT		32	/* CPU has interrupt remapping */
 #define CPU_FEATURE_LAM_BH		33	/* CPU has AM{SWAP/ADD}[_DB].{B/H} instructions */
+#define CPU_FEATURE_LLACQ_SCREL		34	/* CPU has {LLACQ/SCREL}.{W/D} instructions */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -162,5 +163,6 @@ static inline char *id_to_core_name(unsigned int id)
 #define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
 #define LOONGARCH_CPU_REDIRECTINT	BIT_ULL(CPU_FEATURE_REDIRECTINT)
 #define LOONGARCH_CPU_LAM_BH		BIT_ULL(CPU_FEATURE_LAM_BH)
+#define LOONGARCH_CPU_LLACQ_SCREL	BIT_ULL(CPU_FEATURE_LLACQ_SCREL)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 2dc7f9d78f2b..9d3962cd797b 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -597,6 +597,10 @@ DEF_EMIT_REG2_FORMAT(revb2w, revb2w_op)
 DEF_EMIT_REG2_FORMAT(revbd, revbd_op)
 DEF_EMIT_REG2_FORMAT(extwh, extwh_op)
 DEF_EMIT_REG2_FORMAT(extwb, extwb_op)
+DEF_EMIT_REG2_FORMAT(llacqw, llacqw_op)
+DEF_EMIT_REG2_FORMAT(screlw, screlw_op)
+DEF_EMIT_REG2_FORMAT(llacqd, llacqd_op)
+DEF_EMIT_REG2_FORMAT(screld, screld_op)
 
 #define DEF_EMIT_REG2I5_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
diff --git a/arch/loongarch/include/uapi/asm/hwcap.h b/arch/loongarch/include/uapi/asm/hwcap.h
index 90e96113ba51..b90d743b177c 100644
--- a/arch/loongarch/include/uapi/asm/hwcap.h
+++ b/arch/loongarch/include/uapi/asm/hwcap.h
@@ -20,5 +20,6 @@
 #define HWCAP_LOONGARCH_LSPW		(1 << 14)
 #define HWCAP_LOONGARCH_SCQ		(1 << 15)
 #define HWCAP_LOONGARCH_LAM_BH		(1 << 16)
+#define HWCAP_LOONGARCH_LLACQ_SCREL	(1 << 17)
 
 #endif /* _UAPI_ASM_HWCAP_H */
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 93466fc7d33d..2fb7e99b6916 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -181,6 +181,10 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_LAM_BH;
 		elf_hwcap |= HWCAP_LOONGARCH_LAM_BH;
 	}
+	if (config & CPUCFG2_LLACQ_SCREL) {
+		c->options |= LOONGARCH_CPU_LLACQ_SCREL;
+		elf_hwcap |= HWCAP_LOONGARCH_LLACQ_SCREL;
+	}
 	if (config & CPUCFG2_SCQ) {
 		c->options |= LOONGARCH_CPU_SCQ;
 		elf_hwcap |= HWCAP_LOONGARCH_SCQ;
-- 
2.42.0

