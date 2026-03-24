Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592AB3D9051
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342874; cv=none; b=WUG2YvzjhySWwbZCSGi2+BPvQbv1wqmnJ3DGRgxSfTv7yEpXw/kwHd7amOCIV/QCY4NRq8NFAw37KBZBlr3TnHwjEM/BZAP9C9anEwbjxcfnBNvowadA7pYvkMswIfLaZZVl2h4TdTkeGxFasy6vd0obZEg+SUAIfdYuWs6kUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342874; c=relaxed/simple;
	bh=gflZGwX5A73py29S5DGQ+A/Bt9FXLv90xRTT8UrHOzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5lTr1Jfy1/MpMRTEh4oBxRMOuFyTJIjALpdKdvbc5c8CTjBnxrjgacPk6+yxxSSvDr+Jwwi8PS/CXJryllChCWiWUWVfZb402YDAyxyoAIC1TkCbuq1TCP74wcaEY8tdVLGJx44yUBK0zeCXucKQKpP1f3a1l65gRaarHk9qok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxHMPWUsJpkCAeAA--.20274S3;
	Tue, 24 Mar 2026 17:01:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LTUsJpmxVcAA--.43301S3;
	Tue, 24 Mar 2026 17:01:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC PATCH 1/7] LoongArch: Add some code related with AM{SWAP/ADD}.{B/H}
Date: Tue, 24 Mar 2026 17:01:00 +0800
Message-ID: <20260324090106.13527-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxC8LTUsJpmxVcAA--.43301S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw1rKFy5uw1fCrW8uw17urX_yoWrtFyDpF
	1qyrs7WrWrWF1Skas0q3Wa9r4UJa1kCry2qF17Aa92yFW7XFy8Xw18KFnxuFs8Jan8Za4F
	9rn5uw1Yva45J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZUUUUU=

The 8-bit and 16-bit atomic instructions amadd.{b/h} and amswap.{b/h} were
newly added in the latest LoongArch Reference Manual, add some definitions
of the instruction code and also check whether support these instructions.

This is preparation for later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/cpu-features.h | 1 +
 arch/loongarch/include/asm/cpu.h          | 2 ++
 arch/loongarch/include/asm/inst.h         | 8 ++++++++
 arch/loongarch/include/uapi/asm/hwcap.h   | 1 +
 arch/loongarch/kernel/cpu-probe.c         | 4 ++++
 5 files changed, 16 insertions(+)

diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index 8eefe7a2098b..f9d3188accfc 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -68,5 +68,6 @@
 #define cpu_has_msgint		cpu_opt(LOONGARCH_CPU_MSGINT)
 #define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
 #define cpu_has_redirectint	cpu_opt(LOONGARCH_CPU_REDIRECTINT)
+#define cpu_has_lam_bh		cpu_opt(LOONGARCH_CPU_LAM_BH)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index 1e60ab264cd0..b423b1f41145 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -126,6 +126,7 @@ static inline char *id_to_core_name(unsigned int id)
 #define CPU_FEATURE_MSGINT		30	/* CPU has MSG interrupt */
 #define CPU_FEATURE_AVECINT		31	/* CPU has AVEC interrupt */
 #define CPU_FEATURE_REDIRECTINT		32	/* CPU has interrupt remapping */
+#define CPU_FEATURE_LAM_BH		33	/* CPU has AM{SWAP/ADD}[_DB].{B/H} instructions */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -160,5 +161,6 @@ static inline char *id_to_core_name(unsigned int id)
 #define LOONGARCH_CPU_MSGINT		BIT_ULL(CPU_FEATURE_MSGINT)
 #define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
 #define LOONGARCH_CPU_REDIRECTINT	BIT_ULL(CPU_FEATURE_REDIRECTINT)
+#define LOONGARCH_CPU_LAM_BH		BIT_ULL(CPU_FEATURE_LAM_BH)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index f9f207082d0e..2dc7f9d78f2b 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -194,6 +194,10 @@ enum reg3_op {
 	fstxs_op	= 0x7070,
 	fstxd_op	= 0x7078,
 	scq_op		= 0x70ae,
+	amswapb_op	= 0x70b8,
+	amswaph_op	= 0x70b9,
+	amaddb_op	= 0x70ba,
+	amaddh_op	= 0x70bb,
 	amswapw_op	= 0x70c0,
 	amswapd_op	= 0x70c1,
 	amaddw_op	= 0x70c2,
@@ -763,6 +767,8 @@ DEF_EMIT_REG3_FORMAT(stxb, stxb_op)
 DEF_EMIT_REG3_FORMAT(stxh, stxh_op)
 DEF_EMIT_REG3_FORMAT(stxw, stxw_op)
 DEF_EMIT_REG3_FORMAT(stxd, stxd_op)
+DEF_EMIT_REG3_FORMAT(amaddb, amaddb_op)
+DEF_EMIT_REG3_FORMAT(amaddh, amaddh_op)
 DEF_EMIT_REG3_FORMAT(amaddw, amaddw_op)
 DEF_EMIT_REG3_FORMAT(amaddd, amaddd_op)
 DEF_EMIT_REG3_FORMAT(amandw, amandw_op)
@@ -771,6 +777,8 @@ DEF_EMIT_REG3_FORMAT(amorw, amorw_op)
 DEF_EMIT_REG3_FORMAT(amord, amord_op)
 DEF_EMIT_REG3_FORMAT(amxorw, amxorw_op)
 DEF_EMIT_REG3_FORMAT(amxord, amxord_op)
+DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
+DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
 DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
 DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
 
diff --git a/arch/loongarch/include/uapi/asm/hwcap.h b/arch/loongarch/include/uapi/asm/hwcap.h
index 49519b4362c6..90e96113ba51 100644
--- a/arch/loongarch/include/uapi/asm/hwcap.h
+++ b/arch/loongarch/include/uapi/asm/hwcap.h
@@ -19,5 +19,6 @@
 #define HWCAP_LOONGARCH_PTW		(1 << 13)
 #define HWCAP_LOONGARCH_LSPW		(1 << 14)
 #define HWCAP_LOONGARCH_SCQ		(1 << 15)
+#define HWCAP_LOONGARCH_LAM_BH		(1 << 16)
 
 #endif /* _UAPI_ASM_HWCAP_H */
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 657bbae6c1c7..93466fc7d33d 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -177,6 +177,10 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_LAM;
 		elf_hwcap |= HWCAP_LOONGARCH_LAM;
 	}
+	if (config & CPUCFG2_LAM_BH) {
+		c->options |= LOONGARCH_CPU_LAM_BH;
+		elf_hwcap |= HWCAP_LOONGARCH_LAM_BH;
+	}
 	if (config & CPUCFG2_SCQ) {
 		c->options |= LOONGARCH_CPU_SCQ;
 		elf_hwcap |= HWCAP_LOONGARCH_SCQ;
-- 
2.42.0

