Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B94C042E;
	Thu,  4 Jun 2026 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604556; cv=none; b=BsVdkutkMY1lBDHJ65/30+HAJOlK0Ah4krpcV1Ml3OUSk0cvn67sQM5bbeEmVn6w8V+KUmKjXX0GxWS4qxBFvglzwegaZ0X2js0Id0VWqZCE7E2SzNuf0J1eUdVH+SCh3/oGjXJoxjvtmWGTFQuSdE0XoaNLvsriJvNpYxFA1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604556; c=relaxed/simple;
	bh=1hiG5xNLfuEU1FhaF20lZOtGhnKc2Kxuk+bBeW/hea4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3wHQnXggMRZwpLYr9/dwCp9X53mqWsJqReh7p+G8IBHUrllxormvPeEk3Zlv6iRFnOwwxpAifjWBvtmNF1icJBVNEFqTPdcwtJd3H+4fIrvDSwizV4HelHvg7ps6DxlxkrcqgmWHJP6pB+z5c6S/F4vtrvCImD77JWSYxJVW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W43bDU6s; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W43bDU6s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 85A301A07A0;
	Thu,  4 Jun 2026 20:22:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 515805FED1;
	Thu,  4 Jun 2026 20:22:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8066106A1D0E;
	Thu,  4 Jun 2026 22:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780604551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JWdw38EiI9Mq6OhPMl4z+SwTGgKYfom6pjkQ6/P5SXE=;
	b=W43bDU6svXn0gZBV6DoqwOqs70uuSW0/XAyd2Q078jgcmbCzxIVTV2GdZ088o38TOj3oJ5
	4WAEW3fsczlFsEm5sGkFHT1clJKkfTDLxlfeQSVs/WLMsdKg2uWpFbiv0chnu4U+NBXTBZ
	0GAbixyfx8SqaMATSvIiSEL2CugVww/xt2ulqMPJ2kv74PE3oGqpm6lykWwUklGQPeAjVk
	/bMTlpyI/FubabCtktk0KuDFD++Q7gcMqaD3VIQg5VtuBKLk85tR/Mb6F1uOr0QnTsSb3Q
	s9kuqKANfXlFUoXBE7gH/IflXPCLYJu0Lw65kC/e4YUrHE0hndD9YUlHuj7F/Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 04 Jun 2026 22:22:00 +0200
Subject: [PATCH bpf-next v2 2/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-kasan-v2-2-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
In-Reply-To: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
generic KASAN (Kernel Address SANitizer) memory access checks for
JIT-compiled BPF programs as well, when both KASAN_GENERIC and JIT
compiler are enabled. This new Kconfig is not a user selectable one: it
is either automatically enabled if KASAN is enabled on a compatible
platform, or disabled. When enabled, the JIT compiler will emit shadow
memory checks before memory loads and stores to detect use-after-free or
out-of-bounds accesses at runtime. The option is gated behind
HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.

As KASAN instrumentation for eBPF program will depend on the info that
can be accessed during each instruction verification, there may be
instructions that will be instrumented even if they don't really need to
(eg: global subprograms that access caller stack memory passed as
argument). To make sure that those additional checks do not trigger any
crash, make sure that VMAP_STACK is enabled so that programs stack has
shadow memory allocated.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- add dependency on kasan for vmalloc and vmalloc'ed stack
---
 kernel/bpf/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..a8e004f88b92 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
 config HAVE_EBPF_JIT
 	bool
 
+# KASAN support for JIT compiler
+config HAVE_EBPF_JIT_KASAN
+	bool
+
 # Used by archs to tell that they want the BPF JIT compiler enabled by
 # default for kernels that were compiled with BPF JIT support.
 config ARCH_WANT_DEFAULT_BPF_JIT
@@ -101,4 +105,9 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_JIT_KASAN
+	bool
+	depends on HAVE_EBPF_JIT_KASAN
+	default y if BPF_JIT && KASAN_GENERIC && KASAN_VMALLOC && VMAP_STACK
+
 endmenu # "BPF subsystem"

-- 
2.54.0

