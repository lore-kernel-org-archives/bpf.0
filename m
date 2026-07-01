Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661A403B1F
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900219; cv=none; b=AyEPkjcLjefOhsnKyYYTPw5kh3Jrk40XzPzXFbMxtuETCs05CEy7EL7IHqkPWz2Uyfw84Mjc5m4q6szR/R/lEYV4wyXpftIThSlTGIJ1WRivEz9bUk4kl0595FQ6HPbiw9Q12IQEIMwPzLsdSe0bYztxTdJp5DBCo93fCDtaTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900219; c=relaxed/simple;
	bh=1hiG5xNLfuEU1FhaF20lZOtGhnKc2Kxuk+bBeW/hea4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8I5Fp5bHuoms83lENUzvXiNxS+FjnE40sthGhFjZq5dl3JfQVMYv+4DbRzmKVkZ+ZUaI0NZXQXlc6aY5uBr3jziJT7ZPxiq2tyWil8lPxn4M5XusrgOpMYP9iqn2WHhCkPe6xr4ERsYIcwhEw+DqLsTYJkGSLZh9BFLb2k0q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=juQPkk0h; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="juQPkk0h"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 39EA8C79ABD;
	Wed,  1 Jul 2026 10:03:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5154A60288;
	Wed,  1 Jul 2026 10:03:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86231104C9D9A;
	Wed,  1 Jul 2026 12:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JWdw38EiI9Mq6OhPMl4z+SwTGgKYfom6pjkQ6/P5SXE=;
	b=juQPkk0hCZEiJCh+rNcoTpDUYWDVLhzG/xZnyfozhpEzljoKHXgYshy8D7eN9JnyYeK/7O
	zWuDL4hB42Wp0u+RdHsdDswKYiZjEAiGC6we85Jnk9pk1uIOPxXF2NEg5p+xyjoyg7TT4F
	ZxtO5RgrwGLRW4fLKZStGaHL3d7vOYxU073NAyD/im5YYu9lv6bCgUYrUv3daeLnypCbId
	9hVSb2SEkQarNAshYqp+RQrmXLzgiO4+l6sYUppmaVoXR5hNu/LqCO/e71v4/ONMJR73I7
	wjKC3KZQ32iHMkUF8TbMvviipriwVhHlNOFFlV9n7JtcWea6dlDzBU9hJ4MfHA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 01 Jul 2026 12:02:51 +0200
Subject: [PATCH bpf-next v3 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
In-Reply-To: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
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

