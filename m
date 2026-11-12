Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480305;
	b=CzFzcRbXk9aijk4pbDCe1Z2KthpPiJ2usP32We5hOfNplbUHSsS/vRxB2UackrjSIBbd
	 Pc0Glx3PUrOAJgLvSlqc/LE7GidVudLiIAT2/+7T878A7T7RqZhEKBp/STzIS/UEZq0Fm
	 qyo0QfUCFNShxbWHmyG7Nv8SMeXmEKEh3D9Pukb7QkAKwF4mBSfaP6QyM2ZGPoypVBJF5
	 zU0QOasZWIVtydmmIuwEzHR98PDHbjtljIMRzrSiTrZMTWjkL60Xkg3CCP6TlAvqFDTzt
	 Xc+r/A/MZDZXXyG8cBfkv0gtH1K7+sOAGgvhShn/L1Tn6VEiu4lTmwmixu654jY9lRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=INpeTcchLLbS0psUlyWopVBCXTqH0HdLEcZJcLgnzp8=;
	b=3uy+szxa+imFUDLD+1Y4P883dmRcdU3wvQdZxjKjleaY/jD4DGmW/TBsfFbw6hr4TOYG
	 8rIiRl7nc/6m1IujVBwtUD/gmoB6it04Yjq68ccGVp1n1bgM4/eize6pWHmaaXjYpn9o8
	 BDV+P1uOFt2SG989xVlIrnB8+NKzibIDwZlbVTuEcLoCw27gXryWI8yczoSqYh1S2NFzJ
	 /ohhA1y+3336WtcZcPcbpTdSg7HeAqqiDOyhGqwf38tE05vIgTKgMwjJZ2xde90Eq0PFF
	 xpte1ip3kB9QgJVdRZSTfDSgjnaxP3E9WJhy1pyf8xr1MPOWD/onQAEgrtdyE0x+qPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VhSAjEJT;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE6606A335
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAEE6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VhSAjEJT
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae58d17cd9so3188780c88.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480304; x=1795085104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=INpeTcchLLbS0psUlyWopVBCXTqH0HdLEcZJcLgnzp8=;
        b=VhSAjEJTXAaXpQdaf5y/37clY9qum96I3OhdyoKcrPdx+eQDYT1E8PzrMoO3VlQurs
         YHhhVBZNj/IgW66JlKShiypHEubXT+akNNMBoQ+k3KEI/6H8UwZ/nD3lT2xEGA643A4W
         cvW5sUY6nAGixGav8ggIG5AEFVZCoImkhfTz+k8o2a6GEfFtlfJ2uv79ocuQQsqJTSdv
         r4gQbyLtAMihEboCJCe3TbqPES8SyE5dulGcxXI9Gkwm1Xs5MVXnJcNbBpx7TB/026gt
         dAFy19CipMBI7/CGRzjPJ1NiXqXnXOl+kmn4j1w6yyjppCB+kiR/rdbYLXGvIfo0Z7+V
         HJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480304; x=1795085104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=INpeTcchLLbS0psUlyWopVBCXTqH0HdLEcZJcLgnzp8=;
        b=W5+SM0Y8uoP+0V+i6H+hYpHEBXcFufDEKDjnQyA3Crtm6fsed7VxZph8+/ou79RE8L
         bTOhZFCpGCI31AU5+lIh4q6yYeyAI/ruRKUHb2lIsLjCA4AkwgYyMW4cjyoAfoerjWkl
         uPm0xUWvaRetY32rOkXKw1fB+IJSuYd+vOVgh5Dy6aY3G5VnuxALyhTtS/cqszQa9TPP
         VnWzuZ2VR9hF3wRMFAeOEzkCWDuawhIk0OOcN0YWg8c18N89Mqjie6qvPKlpW1qKj835
         0i+whskx2VKEEgy7CoY9dhXwdZKhBeHP8uWS1SN1rn5stkWzmZQGXFCXlhXXreU8oC+l
         Q5Eg==
X-Forwarded-Encrypted: i=1; AL+hErHGI7H16h3ysvVqa1OKVII+MC14wYpHQ36eHzzEu7KHbOZn56l0nXqFsa65RBQHta3P3h8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/SHYHTrEGwxpOXbQz5Bg2FYtI3EvUjxf2tAviW6HMDTCtRjNS
	HVv/UBJPGH4ZFkMw67jTaWhm7oYLfMPuGYEx/MIeJda1vIQmgAm+VBNxlb5cgXZ42Uo=
X-Gm-Gg: AYBFou0snC/Mrg43x8Md/1lcLd1hu/4HuXooQq9kzfHB/OAImxd2X8M1AOTaSDn+XfZ
	PP1gkKa1jbEEAnoF9pILZ+jq+JuVuD1CVcw3AM39E1O+gGa66/c5tx2zbR9wfXC9FFxAJOEBJ/Z
	9D9nOJH1RPuu+wXC/8zsHdoHvll9y0cK6ZvBiqKqLCC58yvXGcHNmxu8zovPDIpDB3xx+jCaEEb
	reuqUPQ6wy32hrjZlZ7erL3krYW7QCu5heQ4Iv8btdBsi6GBcccBsBWoW2BDsY4ONKTFMJgxqlN
	EAMz4t1s/OiXgBHxYaxgbUMUQ0WyNyzYwnn2lnWhP6gArSmDSmfFrf8zy9xj07W5HkYcFr/vlOT
	CqnWhfQZnvveBZ8OY3yOikVdawLRh29kIRpHPoFrb38E35lF18PTr5CEmRQIDe/4h5GwECQzrhp
	8dE8STrwmyPV1VGkAoPJYuofJSH6oKDExHmpU37xDtvIo4lTJafbCrziJs9K2P1dJirxUl+4v8D
	Lld9xtlNNzWMu8MVhcLMMKeULAUf1xXU/hs2kXZakWvueQViOdVltC5HdaqNqy8rtBQbOO+zpwn
	y5398xHLCidAelbkH5B1JxRT7YR2XhhcWhU2d1BAQJ37Xg5nMAfpo1RNy+13m2p6/0g=
X-Received: by 2002:a05:701a:ca05:b0:166:5552:780a with SMTP id a92af1059eb24-1b3c02f379amr4916378c88.8.1794480303681;
        Thu, 12 Nov 2026 02:45:03 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.44.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:45:02 -0800 (PST)
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
Subject: [PATCH v10 8/9] riscv: implement preemptible this_cpu cmpxchg128
Date: Thu, 12 Nov 2026 18:41:48 +0800
Message-Id: <20261112104149.38589-9-cuiyunhui@bytedance.com>
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

Extend the preemptible compare-and-exchange support to 128-bit values on
systems with native AMOCAS.Q support.

AMOCAS.Q implicitly consumes register pairs, so keep both halves of the new
value in fixed registers even when either half is zero. Retain the
local-IRQ-protected fallback when native cmpxchg128 is unavailable.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 66 +++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index 4d2fc10cbdab1..1d35fc89eeeb2 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -9,10 +9,12 @@
 #include <linux/thread_info.h>
 
 #include <asm/asm.h>
+#include <asm/cmpxchg.h>
 #include <asm/cpufeature-macros.h>
 #include <asm/current.h>
 #include <asm/gpr-num.h>
 #include <asm/hwcap.h>
+#include <asm/irqflags.h>
 
 #define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
 
@@ -518,6 +520,65 @@ __percpu_cmpxchg_case_##sz(void __percpu *pcp, unsigned long old,	\
 
 __PERCPU_8_16_CMPXCHG_CASE(8, .b)
 __PERCPU_8_16_CMPXCHG_CASE(16, .h)
+
+#ifdef system_has_cmpxchg128
+static __always_inline u128
+__percpu_cmpxchg128_case(void __percpu *pcp, u128 old, u128 new)
+{
+	__PCPU_OP_CONTEXT();
+	union __u128_halves old_halves = { .full = old };
+	union __u128_halves new_halves = { .full = new };
+
+	register unsigned long new_lo asm("t1") = new_halves.low;
+	register unsigned long new_hi asm("t2") = new_halves.high;
+	register unsigned long old_lo asm("t3") = old_halves.low;
+	register unsigned long old_hi asm("t4") = old_halves.high;
+
+	asm volatile (__PCPU_GPRS_BEGIN
+		".option push\n"
+		".option arch, +zacas\n"
+		"amocas.q %[old_lo], %[new_lo], 0(%[addr])\n"
+		".option pop\n"
+		__PCPU_GPRS_END
+		: [gprs] "=m" (__ti->pcpu_gprs),
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),
+		  [old_lo] "+&r" (old_lo), [old_hi] "+&r" (old_hi)
+		: [pcpu_offset] "m" (__ti->pcpu_offset),
+		  [pcp] "r" (pcp), [new_lo] "r" (new_lo),
+		  [new_hi] "r" (new_hi)
+		: "memory");
+
+	return ((u128)old_hi << 64) | old_lo;
+}
+
+static __always_inline u128
+__percpu_generic_cmpxchg128(void __percpu *pcp, u128 old, u128 new)
+{
+	unsigned long flags;
+	u128 *ptr;
+	u128 ret;
+
+	flags = arch_local_irq_save();
+	ptr = (u128 *)((__force unsigned long)pcp +
+			 __my_cpu_offset);
+	ret = *ptr;
+	if (ret == old)
+		*ptr = new;
+	arch_local_irq_restore(flags);
+
+	return ret;
+}
+
+static __always_inline u128
+__percpu_cmpxchg128(void __percpu *pcp, u128 old, u128 new)
+{
+	if (system_has_cmpxchg128())
+		return __percpu_cmpxchg128_case(pcp, old, new);
+
+	return __percpu_generic_cmpxchg128(pcp, old, new);
+}
+#endif
+
 #define _pcp_wrap(op, pcp, ...)						\
 ({									\
 	op(&(pcp), __VA_ARGS__);					\
@@ -618,6 +679,11 @@ __PERCPU_8_16_CMPXCHG_CASE(16, .h)
 #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
 #endif
 
+#ifdef system_has_cmpxchg128
+#define this_cpu_cmpxchg128(pcp, o, n)					\
+	_pcp_wrap_return(__percpu_cmpxchg128, pcp, (u128)(o), (u128)(n))
+#endif
+
 #undef PERCPU_RW_OPS
 #undef __PERCPU_AMO_OP_CASE
 #undef __PERCPU_8_16_OP_CASE
-- 
2.39.5

