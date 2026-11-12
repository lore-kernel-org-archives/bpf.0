Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480266;
	b=k1PaV0sP21KRDJ6JpCJZBAQ3w1ba5r2LhC4YrP4EmMcyRRB1E55aTgVzNa88VavBB8Qd
	 gJs7j2NFTcaRr4/ndL71sUsrrzYLHsRKGw710ssgOIGUSOihV+vyVMFRKFRpfu9YpRhyp
	 cRTtwCE6Ig73aA6tbakbFOeYLP4O/dGHJMy677oe1fNhtAhg4VowKoTPFmeKtWCMpjpGA
	 Go4Ihe5pgswxG+pXN0uqB79vV5K2Smni4flVoxRsEmThmb1tmuP3hay+ecAqOYfjFF2/G
	 Ghk+DK0yybR9N6aSnDotzLupikdX2EvBnog1n+bLSiAT0BDwLkc/T50JvC6fuSmRiMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c+0NQhm/2dySRhzukgerkWXzp7x9hEGESn4jnFASt64=;
	b=z/uBDC8VWX6zil1UJxRMHEu0H+52NopiUJxSIXGih+i4TiXhJT3luFsYlYlUrW/60mf9
	 S0Pk24zp6Yruf0MXfNdAvk7SwtSsEsKTt3RbbhemPmFnue5uNOOwYpIEYB6h5gYIS8CYN
	 dg/wt53eBd/9L1Csol/4K/mcfbgOQDMIuae02cdVmrWSHDo9mX9cGOyQ5UwgkUwsrsYfZ
	 PIPwPYwi0yvnyezQM9FWW3CDdt5l1+A4nENV+yeg8YFrOv6vyYjvNE7eIt2MP1F99uyTu
	 OWFzKPuEaXLu/vSrOFSpa/AP88K/k+Wq8jcagE/G2vQT47+PZf5B0W6PaERl3JYwSBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="UhkB3/vg";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1E606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F1E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=UhkB3/vg
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so6189929eec.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480265; x=1795085065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c+0NQhm/2dySRhzukgerkWXzp7x9hEGESn4jnFASt64=;
        b=UhkB3/vgmHv1ldLwAept4ls7/dn/CpTbyqTnRB560UaGC1dXAiNPJ8gZ1/lamzscB3
         K5yR2U8pqgqbVqsufERseB9J1yXWQJadj5YCL6Ln78zq95d53/uBvuhwE2yAtvqvFV1q
         85M1MVJ37Qjcr3ezKqv5zpVTfhBMzr4NKr48UBubxvG5hY3ztCDKGIEgu44xYU4+69Zu
         iKINFioIJ+ioPs4pgQm+fGxK4DLRm1CrRH+g+loWTVfPVlpIbKX3MgtWWfGZSAGZXO1J
         FqYKOpj+6lle/5ovCPL2upQLRBU85X/0p6FJVya6IcG5W0wOMvunC4BcnBW1JW3jjg3Q
         E44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480265; x=1795085065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c+0NQhm/2dySRhzukgerkWXzp7x9hEGESn4jnFASt64=;
        b=Dz96Mi7hGJNSNYVyygbcTgw95t+chI9SPT4SgWHJPsYP3Ie8BtBUw2lzGGq/WV2a5b
         mgzknUhNWRqf88+6Qupj0p12P8c9VY2Z0WHC+X930aEVaotFEXCQBtDrro1aQPB94IqH
         8VzWEMxH45IKQRW3WEuNKGda/pcpnHAkpRa8ARkutvj6it59Db0TFu9lnSTCGVv2oH0r
         X7fIfp5ykY2Hc3a9ZUNHCMdoU+bWRk0+sYcoRewDLP7KIkupwBvdFI3KRRjhFvYgdR3n
         0be6XJVYrB8IVCRapbHXKHtBmWikcGVc6CT6DgZe5ViN1W8nam70hZS1HLNSBfq37tmk
         d6LA==
X-Forwarded-Encrypted: i=1; AL+hErEV7w89AOfgtQAPNvzyqbg/ngWPLL1SoxBxYO20P2mMMQRbTL02UcKTlzvWNn4POdncNyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z99+JV5ubphImBXjCAw0OHYquF1DEiP6tyV7i/0S4Jwa6CjIXxT
	xkgV9oRKZH67QnblXhNEZkx9+cyggCLXE03pTw9m/QAMX7qH02jDMReLyX0Prr861SI=
X-Gm-Gg: AYBFou2VFoEmkV5GjcMA+QuN4fCYTBL2V0LWPGgM0h0ExHLWwZ56gxk7d9EiGtD+omY
	1LzxDl1RhPOFT7N8gMpVRzccxJ21Tw2y6fAIL871dqCRzN6dq4ElL+BJz6D1p8p4PwEyLwKtDPe
	k0fi8kgFMQPOdXu41olZ77XoK/ubDWwFpKz4Xdi6JjyQs7PnyqWIY1TSrQt0MQd0dsZFr/8xu4M
	T4lKFX+nV7oCeZluQWP5kZAb93cOAcWq4HB8DSD3OIe1zH3lTdkFE8ga/Favu0EK4nVfQTYt2b8
	Najh5ytw/vDVAtVONtuYAKP+eBaxedojShsvlDCHtwHJmzK5P5IqT0AyNR/cpS1QteW5afPgOy4
	51p4c6VswcjHK0bMYR9CkRL6FpWXteRgz2Lpw9CTdIndrcJSkPqy4ly6L6ZIzjsMuDhAZ1c//l+
	fny5l2YBcRvymbyLn9wF3nuTPPQtmcD3AHqXwxA1Mry2qWmOGhDIneYuQwrVxjQtC0yuZ2m9SQQ
	5ZmU0X8n7W/ZfFYF5ALFhIT7/X9bF/eaalC/e8L5BzxX23GC28I2+BbrVibIzng3BXHUNnBUFR6
	KKh7CabJdHeW7KpzSmdSJUlhX5cG78G680kfJT9BL5E0amGsRMPb0YVMDpxHfdfez98DvPodlkr
	9GKC/c0oH1ORj
X-Received: by 2002:a05:693c:4007:b0:369:f420:8679 with SMTP id 5a478bee46e88-37687211c14mr5675144eec.38.1794480264921;
        Thu, 12 Nov 2026 02:44:24 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.44.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:44:24 -0800 (PST)
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
Subject: [PATCH v10 6/9] riscv: implement preemptible this_cpu xchg operations
Date: Thu, 12 Nov 2026 18:41:46 +0800
Message-Id: <20261112104149.38589-7-cuiyunhui@bytedance.com>
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

Apply the recoverable per-CPU address handling to exchange operations.

Use AMOSWAP for native-width and Zabha subword operations. Where Zabha is
unavailable, use a masked LR/SC sequence that preserves neighboring fields
in the same word.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 92 +++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index 9ff02f3811550..810f4c5eaa508 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -326,6 +326,81 @@ __percpu_add_return_amo_case_16(void __percpu *pcp, unsigned long val)
 	return __percpu_add_return_8_16(pcp, val, 16);
 }
 
+#define __PERCPU_XCHG_AMO_CASE(sfx, sz)					\
+static __always_inline unsigned long					\
+__percpu_xchg_case_##sz(void __percpu *pcp, unsigned long val)		\
+{									\
+	__PCPU_OP_CONTEXT();						\
+	u##sz ret;							\
+									\
+	asm volatile (__PCPU_GPRS_BEGIN					\
+		"amoswap" #sfx " %[ret], %[val], 0(%[addr])\n"		\
+		__PCPU_GPRS_END						\
+		: [gprs] "=m" (__ti->pcpu_gprs),			\
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),		\
+		  [ret] "=&r" (ret)					\
+		: [pcpu_offset] "m" (__ti->pcpu_offset),		\
+		  [pcp] "r" (pcp), [val] "r" ((u##sz)val)		\
+		: "memory");						\
+									\
+	return ret;							\
+}
+
+__PERCPU_XCHG_AMO_CASE(.w, 32)
+#ifdef CONFIG_64BIT
+__PERCPU_XCHG_AMO_CASE(.d, 64)
+#endif
+
+#define __PERCPU_8_16_XCHG_CASE(sz, sfx)				\
+static __always_inline unsigned long					\
+__percpu_xchg_case_##sz(void __percpu *pcp, unsigned long val)		\
+{									\
+	__PCPU_OP_CONTEXT();						\
+	const u32 field_mask = PERCPU_8_16_GET_MASK(sz);		\
+	const unsigned long shift = PERCPU_8_16_GET_SHIFT(pcp);		\
+	const u32 mask = field_mask << shift;				\
+	const u32 new_field = (val & field_mask) << shift;		\
+	void __percpu *pcp32 = PERCPU_8_16_GET_PCP32(pcp);		\
+	u32 old, new, rc;						\
+	u##sz ret;							\
+									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&			\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {	\
+		asm volatile (__PCPU_GPRS_BEGIN				\
+			".option push\n"				\
+			".option arch, +zabha\n"			\
+			"amoswap" #sfx " %[ret], %[val], 0(%[addr])\n"	\
+			".option pop\n"					\
+			__PCPU_GPRS_END					\
+			: [gprs] "=m" (__ti->pcpu_gprs),		\
+			  [off] "=&r" (__off), [addr] "=&r" (__addr),	\
+			  [ret] "=&r" (ret)				\
+			: [pcpu_offset] "m" (__ti->pcpu_offset),	\
+			  [pcp] "r" (pcp), [val] "r" ((u##sz)val)	\
+			: "memory");					\
+		return ret;						\
+	}								\
+									\
+	asm volatile (__PCPU_GPRS_BEGIN					\
+		"0: lr.w %[old], 0(%[addr])\n"				\
+		"and %[new], %[old], %[inv_mask]\n"			\
+		"or %[new], %[new], %[new_field]\n"			\
+		"sc.w %[rc], %[new], 0(%[addr])\n"			\
+		"bnez %[rc], 0b\n"					\
+		__PCPU_GPRS_END						\
+		: [gprs] "=m" (__ti->pcpu_gprs),			\
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),		\
+		  [old] "=&r" (old), [new] "=&r" (new), [rc] "=&r" (rc)	\
+		: [pcpu_offset] "m" (__ti->pcpu_offset),		\
+		  [pcp] "r" (pcp32), [inv_mask] "r" (~mask),		\
+		  [new_field] "r" (new_field)				\
+		: "memory");						\
+									\
+	return (old & mask) >> shift;					\
+}
+
+__PERCPU_8_16_XCHG_CASE(8, .b)
+__PERCPU_8_16_XCHG_CASE(16, .h)
 #define _pcp_wrap(op, pcp, ...)						\
 ({									\
 	op(&(pcp), __VA_ARGS__);					\
@@ -338,6 +413,14 @@ __percpu_add_return_amo_case_16(void __percpu *pcp, unsigned long val)
 	(TYPEOF_UNQUAL(*__pcp_ptr))op(__pcp_ptr, ##args);		\
 })
 
+#define _pcp_wrap_xchg(op, pcp, val)					\
+({									\
+	__auto_type __pcp_ptr = &(pcp);					\
+									\
+	(TYPEOF_UNQUAL(*__pcp_ptr))op(__pcp_ptr,			\
+					     (unsigned long)(val));	\
+})
+
 #define this_cpu_read_1(pcp)	_pcp_wrap_return(__percpu_read_8, pcp)
 #define this_cpu_read_2(pcp)	_pcp_wrap_return(__percpu_read_16, pcp)
 #define this_cpu_read_4(pcp)	_pcp_wrap_return(__percpu_read_32, pcp)
@@ -390,9 +473,18 @@ __percpu_add_return_amo_case_16(void __percpu *pcp, unsigned long val)
 	_pcp_wrap_return(__percpu_add_return_amo_case_64, pcp, val)
 #endif
 
+#define this_cpu_xchg_1(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_8, pcp, val)
+#define this_cpu_xchg_2(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_16, pcp, val)
+#define this_cpu_xchg_4(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_32, pcp, val)
+#ifdef CONFIG_64BIT
+#define this_cpu_xchg_8(pcp, val)	_pcp_wrap_xchg(__percpu_xchg_case_64, pcp, val)
+#endif
+
 #undef PERCPU_RW_OPS
 #undef __PERCPU_AMO_OP_CASE
 #undef __PERCPU_8_16_OP_CASE
+#undef __PERCPU_XCHG_AMO_CASE
+#undef __PERCPU_8_16_XCHG_CASE
 #undef PERCPU_8_16_GET_SHIFT
 #undef PERCPU_8_16_GET_MASK
 #undef PERCPU_8_16_GET_PCP32
-- 
2.39.5

