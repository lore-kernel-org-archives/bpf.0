Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F523845B2;
	Tue,  7 Apr 2026 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543005; cv=none; b=XJog6ERWIMA0Chjou/SMk5j6hMp3Rs0Pek3p5qUr+tXGHk0P/NQzGk964/XwJ23hdJA5ue/81NlwBJzswbsMMPAWGTf/ZqOHOKWgdCWMxVY+NGVYIDcNHW9c9RhPHcMIRqHZlakpe+1V2cvs6NagIBtAjfdP4leaIlTfH56RZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543005; c=relaxed/simple;
	bh=rReepHq7KJlPcFJI7aQOVGblgJL+zctFwmGpX1l0cB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL1wRAY+3145YtQ49waPGKroWZScDlWRCd31+KA0brtGmGimF1LraSVCedhqKB3KLYQQsToLqbuKTD+KrlqKfgO/+8VJF7wOvgBm+uonOEzdELXnN6ofdszpvTfzAx3GTvNqZTEjTKodcgbYcQU5Cwkjn3MuEeFJe+RkUkLOulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxccDSotRptaUiAA--.37698S3;
	Tue, 07 Apr 2026 14:23:14 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx_8LLotRpYh5nAA--.54S3;
	Tue, 07 Apr 2026 14:23:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] LoongArch: Define format for AM{SWAP/ADD}.{B/H}, DBAR and BSTRINS.D
Date: Tue,  7 Apr 2026 14:23:02 +0800
Message-ID: <20260407062306.8915-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260407062306.8915-1-yangtiezhu@loongson.cn>
References: <20260407062306.8915-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx_8LLotRpYh5nAA--.54S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFyxXF1xCF1UJw4rKFyDArc_yoWxJFW7pF
	9Fyr4kXrWrWrn3Ka4Dt3W3ur47Jan7Cry2qF17ZaySyFW3Xa48Xw1kKrnxZFs8Jan5Z3WF
	9rn5Xwn0vas8J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1LiSJUUUUU==

The 8 and 16 bit read-modify-write atomic instructions amadd.{b/h} and
amswap.{b/h} were newly added in the latest LoongArch Reference Manual,
define the instruction format and check whether support via cpucfg.

Furthermore, define the instruction format for DBAR which will be used
to support BPF load-acquire and store-release instructions.

The last thing is to define the instruction format for BSTRINS.D which
will be used to clear some bits.

This is preparation for later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/cpu-features.h |  1 +
 arch/loongarch/include/asm/cpu.h          |  2 ++
 arch/loongarch/include/asm/inst.h         | 11 +++++++++++
 arch/loongarch/include/uapi/asm/hwcap.h   |  1 +
 arch/loongarch/kernel/cpu-probe.c         |  4 ++++
 arch/loongarch/kernel/proc.c              |  2 ++
 6 files changed, 21 insertions(+)

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
index f9f207082d0e..59482d8f3cd9 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -36,6 +36,7 @@
 
 enum reg0i15_op {
 	break_op	= 0x54,
+	dbar_op		= 0x70e4,
 };
 
 enum reg0i26_op {
@@ -194,6 +195,10 @@ enum reg3_op {
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
@@ -543,6 +548,7 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 }
 
 DEF_EMIT_REG0I15_FORMAT(break, break_op)
+DEF_EMIT_REG0I15_FORMAT(dbar, dbar_op)
 
 /* like emit_break(imm) but returns a constant expression */
 #define __emit_break(imm)	((u32)((imm) | (break_op << 15)))
@@ -722,6 +728,7 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 }
 
 DEF_EMIT_REG2BSTRD_FORMAT(bstrpickd, bstrpickd_op)
+DEF_EMIT_REG2BSTRD_FORMAT(bstrinsd, bstrinsd_op)
 
 #define DEF_EMIT_REG3_FORMAT(NAME, OP)					\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
@@ -763,6 +770,8 @@ DEF_EMIT_REG3_FORMAT(stxb, stxb_op)
 DEF_EMIT_REG3_FORMAT(stxh, stxh_op)
 DEF_EMIT_REG3_FORMAT(stxw, stxw_op)
 DEF_EMIT_REG3_FORMAT(stxd, stxd_op)
+DEF_EMIT_REG3_FORMAT(amaddb, amaddb_op)
+DEF_EMIT_REG3_FORMAT(amaddh, amaddh_op)
 DEF_EMIT_REG3_FORMAT(amaddw, amaddw_op)
 DEF_EMIT_REG3_FORMAT(amaddd, amaddd_op)
 DEF_EMIT_REG3_FORMAT(amandw, amandw_op)
@@ -771,6 +780,8 @@ DEF_EMIT_REG3_FORMAT(amorw, amorw_op)
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
diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
index a8127e83da65..d4ce5b585453 100644
--- a/arch/loongarch/kernel/proc.c
+++ b/arch/loongarch/kernel/proc.c
@@ -64,6 +64,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_puts(m, " cpucfg");
 	if (cpu_has_lam)
 		seq_puts(m, " lam");
+	if (cpu_has_lam_bh)
+		seq_puts(m, " lam_bh");
 	if (cpu_has_scq)
 		seq_puts(m, " scq");
 	if (cpu_has_ual)
-- 
2.42.0

