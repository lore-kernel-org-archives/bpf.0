Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480227;
	b=f46p4j4Pok4P6CB+Bsth2vTfNgeRJtF0WjpvLXwD3T0iEDFiscAVq8yRuyYMuBB8r2+L
	 bkgH2F9j9At9kEslPxzTr5K/V491lpfC91lxm/i4oFRy0UvYlM8e4A+5UEmGqYW1hkClm
	 g5YkbfRjgemzvwiLVv9qpGFjkrKj1/tk+96yrSi3G9NwjZmp27+r6HoZQY9ktuGf+x2Bs
	 vU16pREG4XR9Ze45XN5VN1HqStDwITXBk+tIh0K0aALws6c5wZo2TIetM7V92RedbEUpa
	 DhYL+Vvhwx2SVRfpawxASl5qTg5A9xw2Jp1UtIKp5GOWWUtXalMeArIG1rIWx+O0yfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nqm7dJauvOPXMBy5M8ojEh1xFc+cOfNZAYHc3ZE6qCY=;
	b=XRXEkxFZT3tl6q6otpGM8qvA1n37BOUHSeXUTEXYAYJSqbrooU2TSe+f39Vles/nqzeo
	 15Q/HBkFxHz86I44E+V8hMcrio9tLSDyzXd7Z9kzn84g1/WEc6mAOIne5WayU9E+tOE3q
	 EeBRWz5RlWMI4oCTj6bninVQHlv64X20Go01ceOVFullEDHXGv3+G8t0HdJMbREDjEaWH
	 42SWHnMV2UQyGeQzyauF0ZPlKP4sihoxhxG8FWOFzTepE/wpIHNI0mptSTQODJzeJlTra
	 PZB4GCykaK3j2PJpddL2zbVRhzgUd8GliPMZVvyVmmHc9zFWNMOeNln3fOwW36gR1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VxLfj07K;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443C606A337
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9443C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VxLfj07K
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36e795af1d4so619992eec.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480227; x=1795085027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nqm7dJauvOPXMBy5M8ojEh1xFc+cOfNZAYHc3ZE6qCY=;
        b=VxLfj07KhS99RTTxzmp0X85V/TKJkhc2PKN/TDM6djyXG5B5N77/Wf5RMo+ZIQMpil
         IMNDXwsdrokLaNcDbJtT/NsFD+gSrtop2hYabP5RnEvI5oCmHSms+xDEAF+UG98Q8bFT
         V84UNdxFNBScXvLRR1WJ+pClt0TrJxipltoZceH9GNitohH3stMozxeU/VsEoucwOkSN
         /iV5+RgKTno2P5kf2TPiiU8smECKuCSp6YIPhRqMWYg7vvhhhIUc1IOnNHZ0/rdSxfLu
         vQULx2wazWXNeTiyH9/Qpw/CeAt0cS8I2huTPwpWUMgAiWwHkjFxtp5rrMd/jmy66pec
         WRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480227; x=1795085027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Nqm7dJauvOPXMBy5M8ojEh1xFc+cOfNZAYHc3ZE6qCY=;
        b=dSU1o3jeosL4KnfRhLUyUe14yaF1FB5RDJLulm2q2SlNtpsQjXTowYfT1F99pvPBNR
         FZeUMRvec4Sn+jNDMX3+Hm51xO5/xrkDDC0ztQPQ1hQ2J69EvH3u9ONGjvNmjiOar8Jz
         UimuTx6BDsC/xznmrvFarGrUOloY674z1/6bCvQc6yve0+PRPKk9t7RQl1eICRklzHi2
         zk2k20CkMfHSap38Nax+47SpCygyNCjMqShCq5mAIi8bC21W4Ls8Gr3+VZfuaska0ixN
         HHL5e7Sw/L2CzY8d/DLe6d7CpJShqoW0jWBIXy5x9vko182ru06a/H1XMmqCnWOvsppA
         LF1A==
X-Forwarded-Encrypted: i=1; AL+hErEz3sVmKwW7wXUt432VHtI2nI58R9MZR66io2AHf/ynLWObE01SNCYc/jFE0p0WYMK++jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ujoa5lh/eHwDZ5DPGH4gzR4KXnTfR6HSYRCzyB+IrcGekZyQg
	chOIYieXdU1NWnK/wlPe5HdxdZq4diCoFuND1uINW4f65CJri6nziPHvcmWrh1UuiaA=
X-Gm-Gg: AYBFou3D+PkQcaFfWsPi0R6MmlPiw3VQnmtIexba9yQ20Splp0H4p1SN1scL2zKzdJx
	o9gjuCQ7cYJdSaIVc8rOxfR56bkXQETfiCgSo6ZudvYCcsJXuWPn6gg3Hyj+09Dg+yjF5b6RN1R
	wG1oWW0uMhKt7g7CmY+Z6RR3XfOMxLq7uXerEKD/u60eaU2uD2+7pj1q+C5zxNgzHlTSe1kyfWY
	42rnoFEf2+ksuqCCv5e1t7bw9RZA862o+KCWmsUWYBYbId8UIwvhJQH3ett4Goo+1Lml82fKdya
	WucumkPq1GriYbiHn3p4g9uX7JrfXUrW1m1W46BLs6c8Q45m1t9g4DSppZy0P/PHXPSn1WR/uOb
	v3As2ssdWu2mLz2VFjCGQlowinp6KDYSgUFbE48uBwFzsIGyUzMCkcuGEHi9qLBW/PWZg8HWY49
	ZKiLy8MerbkGirZX51LAgfc154lYpq/W0e4SVtLB9u4zKjjaa4cxuC+go7v8gBTmCWedL8vGQmg
	S1uXYgxC+W05sgNg8PyrFpKmGGJUJY/ltNeKIwfP+tuWgwTEQ51gMpNGFl0Mw62oAxK3oC+Yqjk
	/jFeDTJmMfvRI5YUydYfsIMpgGorLFpvnDigLVYsR84Y2/BR7v5H1Wx3WSexomV1lMc=
X-Received: by 2002:a05:7300:560d:b0:36c:a1bc:6102 with SMTP id 5a478bee46e88-377db5d8963mr1895745eec.0.1794480226338;
        Thu, 12 Nov 2026 02:43:46 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.43.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:43:45 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	oleg@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	broonie@kernel.org,
	cuiyunhui@bytedance.com,
	dave@stgolabs.net,
	david.laight.linux@gmail.com,
	jszhang@kernel.org,
	tglx@kernel.org,
	conor.dooley@microchip.com,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v10 4/9] riscv: implement preemptible this_cpu void RMW operations
Date: Thu, 12 Nov 2026 18:41:44 +0800
Message-Id: <20261112104149.38589-5-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261112104149.38589-1-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
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

Apply the recoverable per-CPU address handling to void read-modify-write
operations.

Use relaxed AMOs for native-width operations, and Zabha or a masked LR/SC
sequence for subword operations. Use value-returning AMOs even when the old
value is unused so CPU-local operations remain likely to execute near the
CPU.

Link: https://lore.kernel.org/r/20260826010748.zphu3wh2hlm4t4o2@offworld
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 127 ++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index ae7c123a48093..46eafa1ef02a1 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -9,8 +9,10 @@
 #include <linux/thread_info.h>
 
 #include <asm/asm.h>
+#include <asm/cpufeature-macros.h>
 #include <asm/current.h>
 #include <asm/gpr-num.h>
+#include <asm/hwcap.h>
 
 #define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
 
@@ -102,6 +104,105 @@ PERCPU_RW_OPS("ld", "sd", 64)
 PERCPU_RW_OPS("lw", "sw", 32)
 #endif
 
+/*
+ * Use value-returning AMOs even when the old value is unused.  Avoiding x0
+ * as rd makes an AMO more likely to execute near the CPU, which better suits
+ * CPU-local data that is commonly accessed again by the same CPU.
+ */
+#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\
+static __always_inline void						\
+__percpu_##name##_amo_case_##sz(void __percpu *pcp, unsigned long val)	\
+{									\
+	__PCPU_OP_CONTEXT();						\
+	u##sz tmp;							\
+									\
+	asm volatile (__PCPU_GPRS_BEGIN					\
+		"amo" #amo_insn #sfx " %[tmp], %[val], 0(%[addr])\n"	\
+		__PCPU_GPRS_END						\
+		: [gprs] "=m" (__ti->pcpu_gprs),			\
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),		\
+		  [tmp] "=&r" (tmp)					\
+		: [pcpu_offset] "m" (__ti->pcpu_offset),		\
+		  [pcp] "r" (pcp), [val] "r" ((u##sz)val)		\
+		: "memory");						\
+}
+
+__PERCPU_AMO_OP_CASE(.w, add, 32, add)
+__PERCPU_AMO_OP_CASE(.w, and, 32, and)
+__PERCPU_AMO_OP_CASE(.w, or, 32, or)
+
+#ifdef CONFIG_64BIT
+__PERCPU_AMO_OP_CASE(.d, add, 64, add)
+__PERCPU_AMO_OP_CASE(.d, and, 64, and)
+__PERCPU_AMO_OP_CASE(.d, or, 64, or)
+#endif
+
+#define PERCPU_8_16_GET_SHIFT(pcp)					\
+	(((__force unsigned long)(pcp) & 0x3) * BITS_PER_BYTE)
+#define PERCPU_8_16_GET_MASK(sz)	GENMASK((sz) - 1, 0)
+#define PERCPU_8_16_GET_PCP32(pcp)					\
+	((void __percpu *)((__force unsigned long)(pcp) & ~0x3UL))
+
+#define __PERCPU_8_16_OP_CASE(name, sz, sfx, amo_insn, op_insn)		\
+static __always_inline void						\
+__percpu_##name##_amo_case_##sz(void __percpu *pcp, unsigned long val)	\
+{									\
+	__PCPU_OP_CONTEXT();						\
+	const u32 field_mask = PERCPU_8_16_GET_MASK(sz);		\
+	const unsigned long shift = PERCPU_8_16_GET_SHIFT(pcp);		\
+	const u32 mask = field_mask << shift;				\
+	const u32 val_trunc = val & field_mask;				\
+	void __percpu *pcp32 = PERCPU_8_16_GET_PCP32(pcp);		\
+	u32 old, new, field;						\
+	u##sz tmp;							\
+									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&			\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {	\
+		asm volatile (__PCPU_GPRS_BEGIN				\
+			".option push\n"				\
+			".option arch, +zabha\n"			\
+			"amo" #amo_insn #sfx " %[tmp], %[val], 0(%[addr])\n"	\
+			".option pop\n"					\
+			__PCPU_GPRS_END					\
+			: [gprs] "=m" (__ti->pcpu_gprs),		\
+			  [off] "=&r" (__off), [addr] "=&r" (__addr),	\
+			  [tmp] "=&r" (tmp)				\
+			: [pcpu_offset] "m" (__ti->pcpu_offset),	\
+			  [pcp] "r" (pcp), [val] "r" ((u##sz)val)	\
+			: "memory");					\
+	} else {							\
+		asm volatile (__PCPU_GPRS_BEGIN				\
+			"0: lr.w %[old], 0(%[addr])\n"			\
+			"and %[field], %[old], %[mask]\n"		\
+			"srl %[field], %[field], %[shift]\n"		\
+			op_insn " %[field], %[field], %[val]\n"		\
+			"and %[field], %[field], %[field_mask]\n"	\
+			"sll %[field], %[field], %[shift]\n"		\
+			"and %[new], %[old], %[inv_mask]\n"		\
+			"or %[new], %[new], %[field]\n"			\
+			"sc.w %[new], %[new], 0(%[addr])\n"		\
+			"bnez %[new], 0b\n"				\
+			__PCPU_GPRS_END					\
+			: [gprs] "=m" (__ti->pcpu_gprs),		\
+			  [off] "=&r" (__off), [addr] "=&r" (__addr),	\
+			  [old] "=&r" (old), [new] "=&r" (new),		\
+			  [field] "=&r" (field)				\
+			: [pcpu_offset] "m" (__ti->pcpu_offset),	\
+			  [pcp] "r" (pcp32), [mask] "r" (mask),		\
+			  [shift] "r" (shift), [val] "r" (val_trunc),	\
+			  [field_mask] "r" (field_mask),		\
+			  [inv_mask] "r" (~mask)			\
+			: "memory");					\
+	}								\
+}
+
+__PERCPU_8_16_OP_CASE(add, 8, .b, add, "add")
+__PERCPU_8_16_OP_CASE(add, 16, .h, add, "add")
+__PERCPU_8_16_OP_CASE(and, 8, .b, and, "and")
+__PERCPU_8_16_OP_CASE(and, 16, .h, and, "and")
+__PERCPU_8_16_OP_CASE(or, 8, .b, or, "or")
+__PERCPU_8_16_OP_CASE(or, 16, .h, or, "or")
+
 #define _pcp_wrap(op, pcp, ...)						\
 ({									\
 	op(&(pcp), __VA_ARGS__);					\
@@ -134,7 +235,33 @@ PERCPU_RW_OPS("lw", "sw", 32)
 	_pcp_wrap(__percpu_write_64, pcp, (unsigned long)(val))
 #endif
 
+#define this_cpu_add_1(pcp, val)	_pcp_wrap(__percpu_add_amo_case_8, pcp, val)
+#define this_cpu_add_2(pcp, val)	_pcp_wrap(__percpu_add_amo_case_16, pcp, val)
+#define this_cpu_add_4(pcp, val)	_pcp_wrap(__percpu_add_amo_case_32, pcp, val)
+#ifdef CONFIG_64BIT
+#define this_cpu_add_8(pcp, val)	_pcp_wrap(__percpu_add_amo_case_64, pcp, val)
+#endif
+
+#define this_cpu_and_1(pcp, val)	_pcp_wrap(__percpu_and_amo_case_8, pcp, val)
+#define this_cpu_and_2(pcp, val)	_pcp_wrap(__percpu_and_amo_case_16, pcp, val)
+#define this_cpu_and_4(pcp, val)	_pcp_wrap(__percpu_and_amo_case_32, pcp, val)
+#ifdef CONFIG_64BIT
+#define this_cpu_and_8(pcp, val)	_pcp_wrap(__percpu_and_amo_case_64, pcp, val)
+#endif
+
+#define this_cpu_or_1(pcp, val)		_pcp_wrap(__percpu_or_amo_case_8, pcp, val)
+#define this_cpu_or_2(pcp, val)		_pcp_wrap(__percpu_or_amo_case_16, pcp, val)
+#define this_cpu_or_4(pcp, val)		_pcp_wrap(__percpu_or_amo_case_32, pcp, val)
+#ifdef CONFIG_64BIT
+#define this_cpu_or_8(pcp, val)		_pcp_wrap(__percpu_or_amo_case_64, pcp, val)
+#endif
+
 #undef PERCPU_RW_OPS
+#undef __PERCPU_AMO_OP_CASE
+#undef __PERCPU_8_16_OP_CASE
+#undef PERCPU_8_16_GET_SHIFT
+#undef PERCPU_8_16_GET_MASK
+#undef PERCPU_8_16_GET_PCP32
 #undef __PCPU_OP_CONTEXT
 
 #include <asm-generic/percpu.h>
-- 
2.39.5

