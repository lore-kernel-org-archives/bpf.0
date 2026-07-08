Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585C3FC5A9
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497759; cv=none; b=OE1oiLqyGm7GdASCYOBeWrPAW/Ko+2/C8o20qoaheWKf4XYGkO6jkvioufYWvyGahUFNyrmCJAU4cPpv76FbO8bW494yj+saT+u2HGHejdL+zoLTX8pB4CUgTNZ1shZEaQ2C+gJdM9GTFNAjWLCE+0uqHThwYsVlG9YMUZcCf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497759; c=relaxed/simple;
	bh=iZZ2PBHmZPBN0aYPVqp7i+Hypr1WUjOmlCyjUh5wbxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7/nzj4KvAXOARsiJZ7PvQleBwZqK47d7JRsfuxUjUXzGnFq1lzdXaStzKBBtYOxNK/dmyNksudnbxrszVBMRJ6ZNNfbbqX1ZbzJ0tEEu3JRi6ikwigzqM9WjJXN4u0jsMcINapsG1jp4Ipw+yU/Vdooqun2Tjidkd1vJbYh/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dOHxWCLl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dOHxWCLl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BAE2CC8F455;
	Wed,  8 Jul 2026 08:02:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0EF760337;
	Wed,  8 Jul 2026 08:02:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FF1611BC325A;
	Wed,  8 Jul 2026 10:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783497750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Opkt6b3+GbYxHiyz50Ifh9CTGFN4f2m40rUrrqYk9es=;
	b=dOHxWCLlrGLrmU1tYn8arT2UOsfxXcaVvs+YyjP0uPotb8knBE8QeDUMxB6+LG9YIXB0Yp
	B4N+Glywn74GbYud3BHxnZ43SUYhQnD5GMMPr6zgJ0b97npgj05aJ32jm1NEPoJNLm/BYU
	HYdETeDbDDDLzbnUjW8yIrMGL4llVFTNNZNQHtSXO1OugmeCnRHERYz4XpqITyI95bFxY3
	6BSMb4IOK8vugBmmJ7PO1h0ZyQM3w2Am506NfoYSTO9+2yoJsgXLJcExf6bX8fVksA01n4
	2oBMx7/WAdAhNFOJZ8utN5dEyikeapafz82ktya3weuZtpbIwlsyuVX9NDwZyw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 08 Jul 2026 10:00:26 +0200
Subject: [PATCH bpf-next v4 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-kasan-v4-3-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
In-Reply-To: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
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
JIT-compiled BPF programs as well, when both KASAN (and more
specifically, generic KASAN with KASAN_VMALLOC) and JIT compiler are
enabled. This new Kconfig is not a user selectable one: it is either
automatically enabled if KASAN is enabled on a compatible platform. When
enabled, the JIT compiler will emit shadow memory checks before memory
loads and stores to detect use-after-free or out-of-bounds accesses at
runtime. The option is gated behind HAVE_EBPF_JIT_KASAN, as it needs
proper arch-specific implementation.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v4:
- reorganize dependencies (Andrey)
- drop VMAP_STACK dependency

Changes in v2:
- add dependency on kasan for vmalloc and vmalloc'ed stack
---
 kernel/bpf/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..e1f3850d2f5a 100644
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
@@ -101,4 +105,17 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_JIT_KASAN
+	bool
+	depends on HAVE_EBPF_JIT_KASAN
+	depends on KASAN_GENERIC
+	depends on KASAN_VMALLOC
+	depends on BPF_JIT
+	default y if KASAN
+	help
+	  Makes JIT compiler insert generic outline KASAN checks in BPF
+	  programs when they are inserted in the kernel. This feature is
+	  automatically enabled if the needed set of KASAN and BPF
+	  configuration options is enabled.
+
 endmenu # "BPF subsystem"

-- 
2.54.0

