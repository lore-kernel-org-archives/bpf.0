Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65480239E60
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124481; cv=none; b=PwxREiM1PuNvxywFQ+PoaGqML1h1uoKzOo6utEM7M5dHvymx/5u0zyKFS/QjWOBSH+GpbSGwA7bZdqSnr6NfecLbS0U8JYENO2wMf8wg6WDUSGIDcsbjBL4bw4v6qXtomvigMOjpZ4HXWldaG5VWfOTMnyHDG9gVlP2R8mAPvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124481; c=relaxed/simple;
	bh=JLowHrXcFONG7R4knouVB5ylAOSKMB6wv5FxaMQxN/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIh65CCkjHagwHqOJJH/J2ok66j5jeJqAu2lpsbxB1w+yAylFbjikxK7gj365tIERsImwjfmmClFBeSfILXu4XMZ76OYlAumuXjV9fq9rt5HefLv+Unii63REb0nNNeBjjYDs8qnseO0KoJW7QZ/pYxEDptCCmojMK5ijhS4lOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KhyVl8fl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KhyVl8fl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783124473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFpVxmC6lW1JIGACiGglEHWFaPfq5ymDv77uwyPpK1o=;
	b=KhyVl8flzrsYbLM8ezm8lnETvPP0ZjGAwHSCm0yGixpyiQN0XrFjIS8+I9YxvJzwM2YtFt
	nRlqCZK6QqVNFdAewDIjSZdDvuakbZAcCUuB/VeN6Dbj2IYEh+Hc/8u0gP86/ITA5g3xzR
	Ig/B6dNLIu3ZdqKVG8q9zP88mQwd0Dc=
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
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] x86/cpu: Inline generic_identify() into identify_cpu()
Date: Fri,  3 Jul 2026 17:20:43 -0700
Message-ID: <20260704002046.3859585-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
References: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

generic_identify() is only ever called from identify_cpu(),
immediately after the cpuinfo reset. Fold it into identify_cpu() so
that a single function does the job for both the boot CPU and the
secondary CPUs.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 73 +++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 505ce329e821..b9a736728a0e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1954,16 +1954,46 @@ void check_null_seg_clears_base(struct cpuinfo_x86 *c)
 	set_cpu_bug(c, X86_BUG_NULL_SEG);
 }
 
-static void generic_identify(struct cpuinfo_x86 *c)
+static void init_cpu_info(struct cpuinfo_x86 *c)
 {
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
 	c->extended_cpuid_level = 0;
+}
+
+static void identify_cpu(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	c->loops_per_jiffy = loops_per_jiffy;
+
+	init_cpu_info(c);
 
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
-	/* cyrix could have cpuid enabled via c_identify()*/
+	/* cyrix could have cpuid enabled via c_identify() */
 	if (!cpuid_feature())
-		return;
+		goto no_cpuid;
 
 	cpuid_scan_cpu(c);
 	cpu_detect(c);
@@ -1991,43 +2021,8 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	set_cpu_bug(c, X86_BUG_ESPFIX);
 #endif
-}
-
-static void init_cpu_info(struct cpuinfo_x86 *c)
-{
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
-}
-
-static void identify_cpu(struct cpuinfo_x86 *c)
-{
-	int i;
-
-	c->loops_per_jiffy = loops_per_jiffy;
-
-	init_cpu_info(c);
-
-	generic_identify(c);
 
+no_cpuid:
 	cpu_parse_topology(c);
 
 	if (this_cpu->c_identify)
-- 
2.54.0

