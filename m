Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF943D4E0
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588385; cv=none; b=a0br2Nb+spx7Me0ChdZphcguK+J6cGh8blg+YBQnparDxa2ZUFQYnSiCtaqwdIX7f13dGWIYcYR3GFMr3aOvFh8+ZNpLmEA058PjPplYF9E+kDizePZjr1IhfG4hUXuRoafRm/Y77lw/o+bil8hWJfkcb3+aFPZEmsP1hihrEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588385; c=relaxed/simple;
	bh=NkwRWssGXzQfAtXSgywsv6pvQ9Jdw4rpWWvy40Z4lEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su4gWjGewztZDAwutsirH2hNL38j4crtGaVM1aBc+mUzd1VtiW78cnsipCkyuausNZqtZFdDjERvurJgavvmKbPK1y/PY7KTi/mC0PsrlNbkUUZsCDj3XG888LpOGbDE1THxYuzRxteAako7UNAJ8BUD/WnYHB3u/o6iAhdfxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFQef9Gt; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFQef9Gt"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NkwRWssGXzQfAtXSgywsv6pvQ9Jdw4rpWWvy40Z4lEU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789588367; v=1; x=1790193167;
 b=JFQef9Gt3KpXMJmayecRqz418APz6tHDMrFI4RZZCL/FjpDUGXoGTfWhJqRr/j8kbdi5j9UA
 6c2OkuEUhnUeICRlmKpy2gUoGI6oyPo5/kxNlFz7H3U7zWy3iOAC0Zk+4tNTjaIka2FZ5pa3Ym8
 PeRphGun1jYq2mcE2By96a9g=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 4af099ac9b2f47f6;
	Wed, 16 Sep 2026 19:52:46 +0000
X-Mizu-Trace-ID: 4af099ac9b2f47f6
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
Subject: [PATCH v3 4/5] x86/cpu: Move 32-bit SEP setup into identify_cpu()
Date: Wed, 16 Sep 2026 12:52:02 -0700
Message-ID: <20260916195203.1099646-5-ihor.solodrai@linux.dev>
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

identify_boot_cpu() and identify_secondary_cpu() both call
enable_sep_cpu() under CONFIG_X86_32 immediately after identify_cpu().

Do it once and drop the ifdefs while at it.

No functional changes.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2b2a4c40ef76..83d613d07997 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2126,6 +2126,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	mcheck_cpu_init(c);
 
 	numa_add_cpu(smp_processor_id());
+
+	if (IS_ENABLED(CONFIG_X86_32))
+		enable_sep_cpu();
 }
 
 /*
@@ -2163,9 +2166,6 @@ static __init void identify_boot_cpu(void)
 	identify_cpu(&boot_cpu_data);
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 		pr_info("CET detected: Indirect Branch Tracking enabled\n");
-#ifdef CONFIG_X86_32
-	enable_sep_cpu();
-#endif
 	cpu_detect_tlb(&boot_cpu_data);
 	setup_cr_pinning();
 
@@ -2185,9 +2185,6 @@ void identify_secondary_cpu(unsigned int cpu)
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

