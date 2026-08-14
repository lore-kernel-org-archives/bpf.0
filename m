Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D463B71A4
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751544; cv=none; b=o4lfrowRw8CM6BvPcrwkHFoys+ezjzMxNJpNwbsb5WHzdzslSJLIG2XH/f9Kb3Z8SmrwibZtUyTDQExHlwhrkdkJC0fC2YUgzLjBFWkmItZ8LJSkmbrdqmlo+eESuQWeSGPJkiM9oX0bPpQ4x84cvaPMFn5akWRfPxev+GI8Piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751544; c=relaxed/simple;
	bh=XUGVDWJoU3RK9p8QNyvMPr/HlvJCp2imwGONSk/iOCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG/3IPSAnF8Qs3gtIMkecRUue/HexauElYOLH4wrqkymkKj1vMrlc8iJmIINdv+ODu4f2m8cdVI3toSE/HIzXLLbCSPMhDHbmvtH7Y1hYyNg+sJBT14+3OcGi1D8R9T90mRnXucaKSw7j5jqH5mkXOmhvnXm/nIpjC8QaKXd91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P0IJkW99; arc=none smtp.client-ip=95.215.58.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P0IJkW99"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XUGVDWJoU3RK9p8QNyvMPr/HlvJCp2imwGONSk/iOCQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786751540; v=1; x=1787356340;
 b=P0IJkW99fVmwxdaNHQfpy0kwjuTOe6Bx62MS3DaeuYLgVAdbSbWG4r1SaBIDH0nIZOZv4f6U
 TBGD4p7b9ANYp7wP2Kkc0hzJWulc2NP8GIjWI/aM0ZAorRwE9GrBPDUEhVh888jIEJRx2sPUK//
 MhfyCup/qHUex2FWxDBsgMHM=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::4:b8fe)
	by mta10.migadu.com with ESMTPS id 999b0796c06f0297;
	Fri, 14 Aug 2026 23:52:20 +0000
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
Subject: [PATCH v2 1/5] x86/cpu: Factor init_cpu_info() out of identify_cpu()
Date: Fri, 14 Aug 2026 16:51:30 -0700
Message-ID: <20260814235134.3461435-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
References: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
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

early_identify_cpu() starts using the helper in the next patch.

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 51 ++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a3df21d26460..bb4525523222 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1772,6 +1772,32 @@ static void __init cpu_parse_early_param(void)
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
@@ -1956,8 +1982,6 @@ void check_null_seg_clears_base(struct cpuinfo_x86 *c)
 
 static void generic_identify(struct cpuinfo_x86 *c)
 {
-	c->extended_cpuid_level = 0;
-
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
@@ -2001,27 +2025,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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

