Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952A21D5B0
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124483; cv=none; b=qvYcXf4UJMbVeMvX6DnJTIbJr8+FxAJNiYm/UPDZnj3fRoCXO1NcU4w634NyibX6sKSgAKv3Fze+GQbaVFqNhVHarNClkamBFlvBGxRu1Huj0m8jbfUQJHaW+q+jiebtBTIaDBefhf4aD7ZB4M3TYlaBHjzmYykd8VWa/8DJQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124483; c=relaxed/simple;
	bh=HHuSh/oidKXCSLb8JkieSG0KvMqIPVm/gNW1C7HspJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8e2+FyYiTNjqkMDd4eHF/Wis8Q2Tb7fI3+c+70SLG/jSet+GhNohJNBc4h3NjDziifRhamN9AiX9ZPtAWyn2IT2WfrCnTAcYmTxY7891WdEto0SMoCl3i9tMV4/HpMD52N82tRRBVzUCDGasobPQYBBvEI+U7wk55AVzdRCh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qxR95fJB; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qxR95fJB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783124477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuMw32Syx9wqhPoQjtOxdSm4SDxWM6dpur5hV6NT1WU=;
	b=qxR95fJB2K4bXaf3wuOKm2B76E/cL8QEbgT3oEwbpDqrGyLWJP5v+oOZ2UTs8AEl44q7SU
	AQ9/f89btaR4TnfXHhVkYHlJhNlFU/FVWSab9HtK8RIT6syO/xIggvD7uqxerThgYoYlij
	ofKlpCOc3rwwFSVt6CxkmdFf7dai8hc=
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
Subject: [PATCH v1 3/5] x86/cpu: Introduce identify_cpu_32() helper
Date: Fri,  3 Jul 2026 17:20:44 -0700
Message-ID: <20260704002046.3859585-4-ihor.solodrai@linux.dev>
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

Both identify_boot_cpu() and identify_secondary_cpu() call enable_sep_cpu()
under a CONFIG_X86_32 #ifdef. Move that into a new identify_cpu_32() helper
guarded by IS_ENABLED(CONFIG_X86_32).

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b9a736728a0e..519e495c4a14 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2146,14 +2146,20 @@ void enable_sep_cpu(void)
 }
 #endif
 
+static void identify_cpu_32(struct cpuinfo_x86 *c)
+{
+	if (!IS_ENABLED(CONFIG_X86_32))
+		return;
+
+	enable_sep_cpu();
+}
+
 static __init void identify_boot_cpu(void)
 {
 	identify_cpu(&boot_cpu_data);
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 		pr_info("CET detected: Indirect Branch Tracking enabled\n");
-#ifdef CONFIG_X86_32
-	enable_sep_cpu();
-#endif
+	identify_cpu_32(&boot_cpu_data);
 	cpu_detect_tlb(&boot_cpu_data);
 	setup_cr_pinning();
 
@@ -2173,9 +2179,7 @@ void identify_secondary_cpu(unsigned int cpu)
 	c->cpu_index = cpu;
 
 	identify_cpu(c);
-#ifdef CONFIG_X86_32
-	enable_sep_cpu();
-#endif
+	identify_cpu_32(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 	if (boot_cpu_has_bug(X86_BUG_GDS))
-- 
2.54.0

