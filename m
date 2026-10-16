Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70241A561;
	Fri, 16 Oct 2026 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138234; cv=none; b=o0au8/8dMkMwVO65eopQd0xg/+eSL+NSDYRe5PR/J7GyW5iuhZzVCxK1wMXoO4HZhL2gIcmZ4wkRj/JhiDaOx2Ac1KQAIIdwFZePZkSWnegj0vsaNCoxfCh0CddFN7jS4Rd/ooQWs8PxDqYzQHN8qYGmqT3Yd/QFHnE9ma/UZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138234; c=relaxed/simple;
	bh=xkf8q9poQuGaHCrGFbxZDlKjeEY4PXUr/d/GMPvTNFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaY/haqTs/Wy1xoU9CfzYJWqmlkcNiKfmNDeaiNVbRSev1qfedajbBSHj7rolMe87xOvSeUBl/q+7sd+mJ2nFB77t7UbRWxa53hw7LBzv5xNLrxzZlBRWwCPtoWegNpNnp2RjcDgPh4AEJFb81kw9LegOoDvKg4qg59BNg99/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxntLx29FqL3AWAA--.65205S3;
	Fri, 16 Oct 2026 16:10:25 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBx5czi29FqOAwtAA--.2269S3;
	Fri, 16 Oct 2026 16:10:23 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] LoongArch: Add CPUCFG2 DIV32 feature detection
Date: Fri, 16 Oct 2026 16:10:04 +0800
Message-ID: <20261016081006.26069-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261016081006.26069-1-yangtiezhu@loongson.cn>
References: <20261016081006.26069-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5czi29FqOAwtAA--.2269S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW8Zr15Kr1DAF4xXFW8AFc_yoWrZr4kpF
	ZrAF4kJrWUWr4Skayqqan09r1DGa1kCw4aqa4UCFWUAF1UXry8Xr1vkFZxZFn0qws3Xa40
	9rn5u34YqFyDXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=

The LoongArch Architecture Manual defines a hardware capability bit
CPUCFG2_DIV32 (bit 26 of CPUCFG 0x2). When this bit is set to 1, it
indicates that on 64-bit machines, the division and mod instructions
(DIV.W[U] and MOD.W[U]) will ignore the upper 32 bits of the input
registers and only compute based on the lower 32 bits.

On certain CPU cores without this feature, these 32-bit instructions
require both input operands to be properly sign-extended. Otherwise,
the hardware execution results can be randomly meaningless values.

Add CPU_FEATURE_DIV32 to detect and export this hardware capability
via elf_hwcap and cpu_has_div32. This provides the infrastructure
for subsystems like BPF JIT to safely choose either native 32-bit
instructions or fallback instruction sequences based on the actual
CPU hardware capabilities.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/cpu-features.h | 1 +
 arch/loongarch/include/asm/cpu.h          | 2 ++
 arch/loongarch/include/uapi/asm/hwcap.h   | 1 +
 arch/loongarch/kernel/cpu-probe.c         | 4 ++++
 arch/loongarch/kernel/proc.c              | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index 62059c5551b9..3e7cf1987171 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -69,5 +69,6 @@
 #define cpu_has_msgint		cpu_opt(LOONGARCH_CPU_MSGINT)
 #define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
 #define cpu_has_redirectint	cpu_opt(LOONGARCH_CPU_REDIRECTINT)
+#define cpu_has_div32		cpu_opt(LOONGARCH_CPU_DIV32)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index 91b96938861e..d1cf5dd5eceb 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -127,6 +127,7 @@ static inline char *id_to_core_name(unsigned int id)
 #define CPU_FEATURE_MSGINT		31	/* CPU has MSG interrupt */
 #define CPU_FEATURE_AVECINT		32	/* CPU has AVEC interrupt */
 #define CPU_FEATURE_REDIRECTINT		33	/* CPU has interrupt remapping */
+#define CPU_FEATURE_DIV32		34	/* CPU has DIV32 feature */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -162,5 +163,6 @@ static inline char *id_to_core_name(unsigned int id)
 #define LOONGARCH_CPU_MSGINT		BIT_ULL(CPU_FEATURE_MSGINT)
 #define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
 #define LOONGARCH_CPU_REDIRECTINT	BIT_ULL(CPU_FEATURE_REDIRECTINT)
+#define LOONGARCH_CPU_DIV32		BIT_ULL(CPU_FEATURE_DIV32)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/uapi/asm/hwcap.h b/arch/loongarch/include/uapi/asm/hwcap.h
index 90e96113ba51..00bf93683c74 100644
--- a/arch/loongarch/include/uapi/asm/hwcap.h
+++ b/arch/loongarch/include/uapi/asm/hwcap.h
@@ -20,5 +20,6 @@
 #define HWCAP_LOONGARCH_LSPW		(1 << 14)
 #define HWCAP_LOONGARCH_SCQ		(1 << 15)
 #define HWCAP_LOONGARCH_LAM_BH		(1 << 16)
+#define HWCAP_LOONGARCH_DIV32		(1 << 17)
 
 #endif /* _UAPI_ASM_HWCAP_H */
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 74d31f260dfd..c50fcba805f7 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -236,6 +236,10 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		elf_hwcap |= HWCAP_LOONGARCH_LBT_MIPS;
 	}
 #endif
+	if (config & CPUCFG2_DIV32) {
+		c->options |= LOONGARCH_CPU_DIV32;
+		elf_hwcap |= HWCAP_LOONGARCH_DIV32;
+	}
 
 	config = read_cpucfg(LOONGARCH_CPUCFG6);
 	if (config & CPUCFG6_PMP)
diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
index d4ce5b585453..c8d6f397de55 100644
--- a/arch/loongarch/kernel/proc.c
+++ b/arch/loongarch/kernel/proc.c
@@ -94,6 +94,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_puts(m, " lbt_arm");
 	if (cpu_has_lbt_mips)
 		seq_puts(m, " lbt_mips");
+	if (cpu_has_div32)
+		seq_puts(m, " div32");
 	seq_puts(m, "\n");
 
 	seq_printf(m, "Hardware Watchpoint\t: %s", str_yes_no(cpu_has_watch));
-- 
2.42.0

