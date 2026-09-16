Received: from mta0.migadu.com (out-139.mta0.migadu.com [91.218.175.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986541443A
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588369; cv=none; b=C9lrrMsBeEjR3Sx+MFwEDj54Ea9+X9O+jHt4dYP940eOk6VRC4EsBeC4junUSitVrBbJhC2km87S5deD14ZIPChq3b/ujS9zznAmRVCBjd2HLBRdTqZ+wx5RvaopyL5h/tFjNkJLaMzyThNahCoTT+CGwqz6yrh4/DYe3qM1Er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588369; c=relaxed/simple;
	bh=O01c+GQ4RowTdd0nGzCiaa7gltnKZNWMU/WFRv+w2yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUmtG5+8gNKhJZRawzmEattSR/C5wDvwfMsCtnfm8ZygmHvhTTmddghkmwrzbXMGpyaCzz8C1lODIJutkSxX1DW9kpdzQTnkRG0aNLcEfb6nqit3GmxfF15dJfpXngcaKt+NEeOV+l0/6k2q/wgTu2LyoYqgBAk0mapblZxWkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iuRJwyTY; arc=none smtp.client-ip=91.218.175.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iuRJwyTY"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O01c+GQ4RowTdd0nGzCiaa7gltnKZNWMU/WFRv+w2yg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789588346; v=1; x=1790193146;
 b=iuRJwyTYbJqmYg0/m6AZzgvyFil+xK8e1wek8Squ8C2AWubFaZzFwP3jpe9tfSm5q5dC9jAs
 gYptK7WWDcicTGL+1ZQAAe7tjwwvYoCaERgyaKIIkXieXI+InLFM7ALDE/Ol/BawQDGAzcSNR7s
 Huuk0cljP4fas3y7JJ4Yc0D4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b5c48faab47fc563;
	Wed, 16 Sep 2026 19:52:26 +0000
X-Mizu-Trace-ID: b5c48faab47fc563
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v3 1/5] x86/cpu: Factor init_cpu_info() out of identify_cpu()
Date: Wed, 16 Sep 2026 12:51:59 -0700
Message-ID: <20260916195203.1099646-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916195203.1099646-1-ihor.solodrai@linux.dev>
References: <20260916195203.1099646-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

identify_cpu() unconditionally resets the struct cpuinfo_x86 fields to
their default values and clears the capability arrays with memset()
before rescanning the CPU to fill it in again.

However the boot CPU capabilities have already been scanned by
early_identify_cpu(), with interrupts disabled.

Introduce init_cpu_info() helper in preparation for letting the
callers decide whether the reset is needed.

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 51 ++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7352827f491..c3dce89ba590 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1782,6 +1782,32 @@ static void __init cpu_parse_early_param(void)
 	}
 }
 
+static void init_cpu_info(struct cpuinfo_x86 *c)
+{
+	c->x86_cache_size = 0;
+	c->x86_vendor = X86_VENDOR_UNKNOWN;
+	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
+	c->x86_vendor_id[0] = '\0'; /* Unset */
+	c->x86_model_id[0] = '\0';  /* Unset */
+#ifdef CONFIG_X86_64
+	c->x86_clflush_size = 64;
+	c->x86_phys_bits = 36;
+	c->x86_virt_bits = 48;
+#else
+	c->cpuid_level = -1;	/* CPUID not detected */
+	c->x86_clflush_size = 32;
+	c->x86_phys_bits = 32;
+	c->x86_virt_bits = 32;
+#endif
+	c->x86_cache_alignment = c->x86_clflush_size;
+	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
+	memset(&c->cpuid, 0, sizeof(c->cpuid));
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
+#endif
+	c->extended_cpuid_level = 0;
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -1966,8 +1992,6 @@ void check_null_seg_clears_base(struct cpuinfo_x86 *c)
 
 static void generic_identify(struct cpuinfo_x86 *c)
 {
-	c->extended_cpuid_level = 0;
-
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
@@ -2011,27 +2035,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = 0;
-	c->x86_vendor = X86_VENDOR_UNKNOWN;
-	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
-	c->x86_vendor_id[0] = '\0'; /* Unset */
-	c->x86_model_id[0] = '\0';  /* Unset */
-#ifdef CONFIG_X86_64
-	c->x86_clflush_size = 64;
-	c->x86_phys_bits = 36;
-	c->x86_virt_bits = 48;
-#else
-	c->cpuid_level = -1;	/* CPUID not detected */
-	c->x86_clflush_size = 32;
-	c->x86_phys_bits = 32;
-	c->x86_virt_bits = 32;
-#endif
-	c->x86_cache_alignment = c->x86_clflush_size;
-	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
-	memset(&c->cpuid, 0, sizeof(c->cpuid));
-#ifdef CONFIG_X86_VMX_FEATURE_NAMES
-	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
-#endif
+
+	init_cpu_info(c);
 
 	generic_identify(c);
 
-- 
2.55.0

