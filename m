Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480208;
	b=oSWyU9DgJLfWC+28JhJzpGQr58WUyiyxPiCxI0FI3cuHONKXotnIu34lqdvJl8lxs9V4
	 OkvOej4joLx7EHf7PdQLfjaZayYXCX0hbMnOZ8oOcctTam/LtCfE5b5pUd43BX5TzJzFE
	 0dhNuLmgCL8dT5u3qYIncFwJJhr3MuoBxeO0n9ah3zv3Is+ZH/Tc3NC0AtbPxaexPEfif
	 YecYE/U62EwbxMrYovUqbnsj9PiasEnCSEYdOLuv05vjTcb88T/MUrDUs1NzNzk3UdGdt
	 sO/yxghz/dyorPAXwVpjoEP23Jycw1EN3kEYsAf1WEJciehnVKTLxps9FBmpfIyY/DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tKHbJSnTS/xgwwH8xY3FZeNU74t03Ua9SzHRVgCuNfk=;
	b=TRl2RdysB3DcsJgD5RXMJmMOWrfTR3AGGOsAfhyRl9BhB4T9csQn4QXd7pFPx/95suKK
	 lDtkCx8GGeDu3RiGFojbCyyQsAP25wXvrr3BMbBcAmBQEojw+6opaZGOvozeukRaGZi0U
	 YV70QlzOBASyBGp2Tl/dm//nfq9NeXHgfnfq55q/EHF90/60H7DbiO3w39At+6tClewgs
	 G12I9mT4QpsEpO3lrFJTgFvYLefSpp0kuSh5wIjBrf9ym+kIqK9mV/1FRauky+QJ7h9kI
	 9mAHbTQ7TdavBt+h/G+IGwh2hbI54LK9Eo0k3MBYcxHoULkwREAHNSHhRWrqWCldbAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=FCxhZTnA;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28334606A334
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28334606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=FCxhZTnA
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so7557079eec.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 02:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480207; x=1795085007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tKHbJSnTS/xgwwH8xY3FZeNU74t03Ua9SzHRVgCuNfk=;
        b=FCxhZTnAeK7n/dzZlGfF22knsUTMPuXwGQSbxR9VnkVe3ltOK6T1yguzUaHIKK2Vr7
         rjXbtbB0TyoD8eWSwZPFSE/msrGdN2FQwWdsktysafMpuWSRc9ArZ8STX8HGMDTONHsY
         jfy5b3ErpckgJQzRehMt/SpYX5rJwmWgSpmg8CSNgpaEK90R08nR/dPJWQDT+eV5nfKN
         T/Kz96UKOCz9F5DXzqEzESLKHD8y3gXh0W3l6c+sqjYAEnUT7eAh/TQrZ5r68xEB4oqL
         xerL5YQGYOR7YA1cV3TWRypuC2VcIuMPF524ziJF9beW5zLwnIy4+TWQg8WRaFVCuEzg
         K6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480207; x=1795085007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tKHbJSnTS/xgwwH8xY3FZeNU74t03Ua9SzHRVgCuNfk=;
        b=uSWT3i6pHaEWqzU0EU09/cusqGNVitoQvEdlLDG1R54xh/h+End/i1DnEjE3ZaZD5E
         TtQ3Pi4Bn+SRDIA99jPpUZ0EraL+Q3VoywVOJWO3fgUCeOU1s1WZE42r+D+anU2sHMLK
         BwF9d09Vp5q+1eSUyBLbrm49eL/ye+GFByUI5IJfbwv1VFMw1k8oCBQAKAWoKEuapzhb
         pCl/82iuX/jpQW6DrVzXDx2FkZdxyfJgZ44A0Fw5kGYt9B0S9oleCmJ/wrekM/Qhxt5V
         tJVpbHqbUZbIIwllLU14F3nE0EObyvIxHmrIwwSY0hgCj/Wuav496pLhedvJQ6SnXpKO
         Si8g==
X-Forwarded-Encrypted: i=1; AL+hErEyvEI7nDKt/PmnAEjXv/UUNvzCguKGgEK3hWYddZa0WDUObC3+8aZJ+B8/7vD2PMDxeJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UCMR80gjqWm5+pR/J69zmkpHlrVI+DW/hHod8Hhdk/4WFEOXi
	16+BVNabpNm9PgUf4P1noOPjazuEYZhSLk5ykX2Su63WffwCJfkK+wjYVxS+M9NyL4Y=
X-Gm-Gg: AYBFou1Sut76J4RbB4EPB95PDvtoa07m9DJqFSNh3kEtIPqnIWOnzKbWTvwaHxduLX3
	zpRK3Jnps6BtvTQH+DuMpo0NWdOz7JkR8twDygq6saGH+n8MjrQN63QviZnd17DBVB/UlYnvCCK
	wL0pOmiWJEwv2MbyUWJvyGpLMTiFSORJsZy92bxOZDiocI2xPwh5YZWyNZCjAQvYZm9Js/Ma5Gg
	VyKdhc5b0nXegSSDgthvJbnybNfrYxgGRSms9O/IWz9bF5JTOl7Lu2FZq72ryIa1ITljSZcuqYc
	EeiGvlBS2WXSoprt8rXs+SoKVpX8ZF0d0pHRMtKAn5oYtyDRrr9Gsd2Vd8lEkTMmFRi7dHOVTjZ
	THIWP5FSaNtWd81jlMoyB2v9wFwbJQPRYZdgRM7JuCaLF3eKVrpuBUzCPbOJuIYNpCSJn6WKEyK
	Ud1e8oiawK9jRNg4+DsUc3APHLXl8MoIMD8RDfYbB0xFPk/2op/ER+iKRf4VnZyRF890bpg6sWt
	UC+nFFGaPHPLeWEGkbo9HaFEZthydZ7yWbtYAF4bqhTOweNLQ7WqoQv0R55SljfY2TqKa/gEfbX
	H9DoTtzQR1QEm9zRMaJOW6OeckScG5FVBno8KVghvSzQLgNDGqQ/z0YfW6um8JIqvCI=
X-Received: by 2002:a05:7300:bf9c:b0:36e:1fbe:3571 with SMTP id 5a478bee46e88-3768366a461mr5368073eec.3.1794480207004;
        Thu, 12 Nov 2026 02:43:27 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.43.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:43:26 -0800 (PST)
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
Subject: [PATCH v10 3/9] riscv: implement preemptible this_cpu read and write operations
Date: Thu, 12 Nov 2026 18:41:43 +0800
Message-Id: <20261112104149.38589-4-cuiyunhui@bytedance.com>
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

Apply the recoverable per-CPU address handling to read and write
operations.

Keep the address calculation and memory access in the same inline assembly
block, and use naturally sized loads and stores while preserving the type
semantics of the generic percpu API.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index 59f7d44f7d3fe..ae7c123a48093 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -4,6 +4,7 @@
 #define __ASM_PERCPU_H
 
 #include <linux/bits.h>
+#include <linux/compiler.h>
 #include <linux/stringify.h>
 #include <linux/thread_info.h>
 
@@ -52,6 +53,90 @@
 #define __PCPU_GPRS_END							\
 	"sh zero, %[gprs]\n"
 
+#define __PCPU_OP_CONTEXT()						\
+	struct thread_info *__ti = (struct thread_info *)current;	\
+	unsigned long __off, __addr
+
+#define PERCPU_RW_OPS(load, store, sz)					\
+static __always_inline unsigned long					\
+__percpu_read_##sz(const void __percpu *pcp)				\
+{									\
+	__PCPU_OP_CONTEXT();						\
+	unsigned long val;						\
+									\
+	asm volatile (__PCPU_GPRS_BEGIN					\
+		load " %[val], 0(%[addr])\n"				\
+		__PCPU_GPRS_END						\
+		: [gprs] "=m" (__ti->pcpu_gprs),			\
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),		\
+		  [val] "=&r" (val)					\
+		: [pcpu_offset] "m" (__ti->pcpu_offset),		\
+		  [pcp] "r" (pcp)					\
+		: "memory");						\
+									\
+	return (u##sz)val;						\
+}									\
+									\
+static __always_inline void __percpu_write_##sz(void __percpu *pcp,	\
+				       unsigned long val)		\
+{									\
+	__PCPU_OP_CONTEXT();						\
+									\
+	asm volatile (__PCPU_GPRS_BEGIN					\
+		store " %[val], 0(%[addr])\n"				\
+		__PCPU_GPRS_END						\
+		: [gprs] "=m" (__ti->pcpu_gprs),			\
+		  [off] "=&r" (__off), [addr] "=&r" (__addr)		\
+		: [pcpu_offset] "m" (__ti->pcpu_offset),		\
+		  [pcp] "r" (pcp), [val] "r" ((u##sz)val)		\
+		: "memory");						\
+}
+
+PERCPU_RW_OPS("lbu", "sb", 8)
+PERCPU_RW_OPS("lhu", "sh", 16)
+
+#ifdef CONFIG_64BIT
+PERCPU_RW_OPS("lwu", "sw", 32)
+PERCPU_RW_OPS("ld", "sd", 64)
+#else
+PERCPU_RW_OPS("lw", "sw", 32)
+#endif
+
+#define _pcp_wrap(op, pcp, ...)						\
+({									\
+	op(&(pcp), __VA_ARGS__);					\
+})
+
+#define _pcp_wrap_return(op, pcp, args...)				\
+({									\
+	__auto_type __pcp_ptr = &(pcp);					\
+									\
+	(TYPEOF_UNQUAL(*__pcp_ptr))op(__pcp_ptr, ##args);		\
+})
+
+#define this_cpu_read_1(pcp)	_pcp_wrap_return(__percpu_read_8, pcp)
+#define this_cpu_read_2(pcp)	_pcp_wrap_return(__percpu_read_16, pcp)
+#define this_cpu_read_4(pcp)	_pcp_wrap_return(__percpu_read_32, pcp)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_read_8(pcp)	_pcp_wrap_return(__percpu_read_64, pcp)
+#endif
+
+#define this_cpu_write_1(pcp, val)					\
+	_pcp_wrap(__percpu_write_8, pcp, (unsigned long)(val))
+#define this_cpu_write_2(pcp, val)					\
+	_pcp_wrap(__percpu_write_16, pcp, (unsigned long)(val))
+#define this_cpu_write_4(pcp, val)					\
+	_pcp_wrap(__percpu_write_32, pcp, (unsigned long)(val))
+
+#ifdef CONFIG_64BIT
+#define this_cpu_write_8(pcp, val)					\
+	_pcp_wrap(__percpu_write_64, pcp, (unsigned long)(val))
+#endif
+
+#undef PERCPU_RW_OPS
+#undef __PCPU_OP_CONTEXT
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ASM_PERCPU_H */
-- 
2.39.5

