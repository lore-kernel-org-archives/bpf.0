Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BC2222D0;
	Fri, 28 Aug 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908902; cv=none; b=u1R777+G11cobaIy7WvXIgyuEhrGuJm56PJQQK9IAjN/Xwje7yHPkHorU8dxPMh4Bj6D4KHtV5pefHhK5o02/KAhexayUY6KEtX/9DRarNLZKUFqYABRGXpnymocgm095nfnt18upoUn3Y4Va+JnFjMupO8AW2jG9VfUGM7ocQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908902; c=relaxed/simple;
	bh=SDvaatbfmEA+vfyHK4YcbtonP+OlhZ1Hh2EBVjlAfnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBJLrUItesfuUFf2Lv4+YaR3ygDk1eZ/lvDqHdMLzyFgwR+JbNlcxg01fb9iy6jX1dZcL2QN/YaioXoJLUBbIEoJ7aMaQw2Zpcrr6e9eZqE7cv95IYg7+Pr/wphXnByw5R6QPiNSZiNHv5bqAP4Wxck5BpwNiglENl5IucOuHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VJj8cvTf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VJj8cvTf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1BA0F1A189D;
	Fri, 28 Aug 2026 09:21:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2F4260537;
	Fri, 28 Aug 2026 09:21:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA27011C78028;
	Fri, 28 Aug 2026 11:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787908897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WxeXPzFv/YBLi+eYLUJvJ0rhe5kb0FsKi0VdfTKstTA=;
	b=VJj8cvTfNG9QgkrFPtWFdQ3VOc9rL//ZE9+JCzIQImHrwtXRb4iVS2hU6s81JIqdXh41AI
	yENn/MJSqfU10/LxT+faP9yL0z+S0eVAK3DPxs7v3DzztYZ9GejmgiKpxFgKZ0VaYj7FbU
	BSehSVCooQHHJHHrA9dwF1v+Tew1HZKVTMTTiT2kbAA7me9V/9XxDQo2/lvHS+C5qZxWEB
	A3W0gRb5if4zIIiyebqWT1q+rdZgRTl4OvNALE9VWMrLO8bHTfEySkl345eBrglmFWwT4a
	KOM65osgLZRVGHMFZjxFjbOex0MZuVoS/aL2WWyPvAkT7PKc9EHUIsFQn+/WJg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 28 Aug 2026 11:21:10 +0200
Subject: [PATCH bpf-next v8 2/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-kasan-v8-2-7c1c0fdb9d7f@bootlin.com>
References: <20260828-kasan-v8-0-7c1c0fdb9d7f@bootlin.com>
In-Reply-To: <20260828-kasan-v8-0-7c1c0fdb9d7f@bootlin.com>
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

