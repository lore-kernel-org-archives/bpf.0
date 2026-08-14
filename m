Received: from mta0.migadu.com (out-124.mta0.migadu.com [91.218.175.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B73DB31F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751568; cv=none; b=ugvPjQUfTWx6zRvFiGj8res2p8rmuE88f74eVwepfYYP92J/pl68lq4GQTQcSjWeu4N2ezKcf+qA/diMMGn+MwPCWRQsglUxACkBqmEN9M+TQKIYEulukGWFGN3tMhyYGRfZAj63iGCEuI7qKe0OHZ7UO8VqPqUvUJr649E+K8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751568; c=relaxed/simple;
	bh=AKXY3VLj5AbiyXes7sILpjywYCJvZ1tj9cAxnFQY9M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saJZvva34K7tY1mQsIBToVq8AiLzqwQKPFwD26Jz4MK+guk0k95GZMDrTRRk5befykq1/QyYn3p72b+lCNCuoUfliQX1JNi733bh3hdHw63T7l24LZ8oApc5l3+WP/ShO5Pf7jB1mj/dlBURhm34/8qwtF9TRJVEabuT2a+wWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ohgoOk1+; arc=none smtp.client-ip=91.218.175.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ohgoOk1+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AKXY3VLj5AbiyXes7sILpjywYCJvZ1tj9cAxnFQY9M4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786751565; v=1; x=1787356365;
 b=ohgoOk1+sMpuchk0BPwF0qT2Hsdmqe4RrXbNQh97KpOmExFN6JhPGVSvREjbm4mRaVon6Dhx
 I9w2mJ7oofqYEso1zp/U0bQJSaidy09v2RzhZMCMJEk19ccjz5BDekQtIounohCsyVjZ7aUDs7d
 9MWMBomuPsGl3kkURIBAm5g4=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::4:b8fe)
	by mta10.migadu.com with ESMTPS id 89459ecddee178bb;
	Fri, 14 Aug 2026 23:52:45 +0000
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
Subject: [PATCH v2 4/5] x86/cpu: Move 32-bit SEP setup into identify_cpu()
Date: Fri, 14 Aug 2026 16:51:33 -0700
Message-ID: <20260814235134.3461435-5-ihor.solodrai@linux.dev>
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

identify_boot_cpu() and identify_secondary_cpu() both call
enable_sep_cpu() under CONFIG_X86_32 immediately after identify_cpu().

Do it once and drop the ifdefs while at it.

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 08c4a0162581..671a430994ca 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2116,6 +2116,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	mcheck_cpu_init(c);
 
 	numa_add_cpu(smp_processor_id());
+
+	if (IS_ENABLED(CONFIG_X86_32))
+		enable_sep_cpu();
 }
 
 /*
@@ -2153,9 +2156,6 @@ static __init void identify_boot_cpu(void)
 	identify_cpu(&boot_cpu_data);
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 		pr_info("CET detected: Indirect Branch Tracking enabled\n");
-#ifdef CONFIG_X86_32
-	enable_sep_cpu();
-#endif
 	cpu_detect_tlb(&boot_cpu_data);
 	setup_cr_pinning();
 
@@ -2175,9 +2175,6 @@ void identify_secondary_cpu(unsigned int cpu)
 	c->cpu_index = cpu;
 
 	identify_cpu(c);
-#ifdef CONFIG_X86_32
-	enable_sep_cpu();
-#endif
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 	if (boot_cpu_has_bug(X86_BUG_GDS))
-- 
2.55.0

