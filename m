Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391944B1475;
	Thu,  3 Sep 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443523; cv=none; b=iRssfDFaAm1NUO7bC2GclnGVCjK8lZqY34RflgbgCcXQDN6P4YKzpkAujyHuaZIe3cGJcqg2QG4d56vpUQveoaDw4407u+t4cg5XVLKR8gBja6KijPuHzsBETT9w/km1wN9/GL/pSJFFZpdSQltYETvT14xkw0/THAA5+g3cRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443523; c=relaxed/simple;
	bh=SDvaatbfmEA+vfyHK4YcbtonP+OlhZ1Hh2EBVjlAfnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QESr7b5SpzJWoCUqpttkQO65GMgfu/Gn5jzA/hTfbA82OpGOts/L+tmuWWtipDGc/OI4SFyvc43+VuwW/CWJIiOVKLBVXLrfJYS6hykXiuZMLJ7hy9sK9pdZ/8ygQk78Fs5Rt7TfwICbqIKlEJTwnFMN0zJIWZE6ypjH7qcX6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pMxKIuki; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pMxKIuki"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB41B1A197E;
	Thu,  3 Sep 2026 13:51:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A6752602B8;
	Thu,  3 Sep 2026 13:51:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 890A611C79654;
	Thu,  3 Sep 2026 15:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788443509; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WxeXPzFv/YBLi+eYLUJvJ0rhe5kb0FsKi0VdfTKstTA=;
	b=pMxKIukiRVHZzc/MP+JD6qxPmYMKdlfiH6rkSWcGVpYg2Rdhon0cAaENRTJb/VnoZNDCfI
	zbIln7Y8b6tTbEtHXnqJ+lgyn3Dq6Fjie1rsNvTsTmTIspJK7w+GT6iQ6PA5n/ptUC+s5H
	5/uKmmQJ2T9NqtVhbMXCClM+xKFsHgARmkVmPXJEqiPA2qMOydDJiuCLz/nKk6YAy1ys/W
	ReYWrMAswW+m6jMtqA11TH55wwXwzHHrDTWy+2/jQAwFH94Qf5Je0BEf+Od85CIZsfDhvD
	8QdE/FI8NYfuSinXVmbZF/qd808Gk+vpdEq3yX5eYM5IXXip3898kTZlAriX+Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 03 Sep 2026 15:51:31 +0200
Subject: [PATCH bpf-next v9 2/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-kasan-v9-2-2407fe99255a@bootlin.com>
References: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
In-Reply-To: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
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
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Yafang Shao <laoar.shao@gmail.com>
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
enabled. This new Kconfig is not a user selectable one: it is
automatically enabled if KASAN is enabled on a compatible platform. When
enabled, the JIT compiler will emit shadow memory checks before memory
loads and stores to detect use-after-free or out-of-bounds accesses at
runtime. The option is gated behind HAVE_EBPF_JIT_KASAN, as it needs
proper arch-specific implementation.

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v6:
- fix commit msg
- get rid of "if KASAN" when setting default value, already implied by
  KASAN_GENERIC

Changes in v4:
- reorganize dependencies (Andrey)
- drop VMAP_STACK dependency

Changes in v2:
- add dependency on kasan for vmalloc and vmalloc'ed stack
---
 kernel/bpf/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..d7d25477ef48 100644
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
+	default y
+	help
+	  Makes JIT compiler insert generic outline KASAN checks in BPF
+	  programs when they are inserted in the kernel. This feature is
+	  automatically enabled if the needed set of KASAN and BPF
+	  configuration options is enabled.
+
 endmenu # "BPF subsystem"

-- 
2.55.0

