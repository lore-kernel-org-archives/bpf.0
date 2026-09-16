Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A2426438
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588377; cv=none; b=AicPF5cEZh/3GQabY0/BTpEviK8twLJSjiCMtULw/Xj0ad9PgKwvdbMQZtyMA7hxCOLT2IzdUSkyd5NTpwnamCr9nxQtNHfEKbGn/xCI8NA7hfXyfu4/GK96vXSghei25X2oqJRK/uROe2GCpeAB6FQpGYPkCGDK3gdFGjysSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588377; c=relaxed/simple;
	bh=c2qPDFF4kfts5j40iNg40AreFJxVYAetkHMQoD+HVsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfVJyCk+x/8TtLAgu2sn0L326Mz8ooUNiVwWJlO0P8ef0SxQJPymss22VP/ElXcxz4grYhQXz9w1pf9v7lvnpZUeLVw9RqWo+qtNBAQDx+o06iSXQKUNAgD1rHBmGz9qvZkkXyMfXS2g8ZWrlBh2df+9CNYeu9xe5wca9puLPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dzLH3eKI; arc=none smtp.client-ip=91.218.175.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dzLH3eKI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c2qPDFF4kfts5j40iNg40AreFJxVYAetkHMQoD+HVsY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789588358; v=1; x=1790193158;
 b=dzLH3eKI4Uh6rkWoSJD6vGu6fvM27SKbLD8oX6TFYEH/KRHltqKwWGTtWMJ2kafwc0o57w5j
 /I2cHbqtygzKk4P7nnAQFcPcW7hNpRe7I+HroH/VUEMhYQU8h/K5U+ytf5SOWJ2sFQ+FDtdP0iZ
 0TurEznQTi2yM8/TgfoZeEn0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c4c15b9716180eaa;
	Wed, 16 Sep 2026 19:52:38 +0000
X-Mizu-Trace-ID: c4c15b9716180eaa
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
Subject: [PATCH v3 3/5] x86/cpu: Inline generic_identify() into identify_cpu()
Date: Wed, 16 Sep 2026 12:52:01 -0700
Message-ID: <20260916195203.1099646-4-ihor.solodrai@linux.dev>
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

generic_identify() has exactly one call site: at the top of
identify_cpu(). Fold it into identify_cpu() so that a single function
does the job for both the boot CPU and the secondary CPUs.

While at it, fix up both copies of the Cyrix comment.

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 66695addbdf3..2b2a4c40ef76 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1825,7 +1825,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
-	/* cyrix could have cpuid enabled via c_identify()*/
+	/* Cyrix could have CPUID enabled via c_identify(). */
 	if (cpuid_feature()) {
 		cpuid_scan_cpu(c);
 		cpu_detect(c);
@@ -1989,14 +1989,23 @@ void check_null_seg_clears_base(struct cpuinfo_x86 *c)
 	set_cpu_bug(c, X86_BUG_NULL_SEG);
 }
 
-static void generic_identify(struct cpuinfo_x86 *c)
+/*
+ * This does the hard work of actually picking apart the CPU stuff...
+ */
+static void identify_cpu(struct cpuinfo_x86 *c)
 {
+	int i;
+
+	c->loops_per_jiffy = loops_per_jiffy;
+
+	init_cpu_info(c);
+
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
-	/* cyrix could have cpuid enabled via c_identify()*/
+	/* Cyrix could have CPUID enabled via c_identify(). */
 	if (!cpuid_feature())
-		return;
+		goto no_cpuid;
 
 	cpuid_scan_cpu(c);
 	cpu_detect(c);
@@ -2024,21 +2033,8 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	set_cpu_bug(c, X86_BUG_ESPFIX);
 #endif
-}
-
-/*
- * This does the hard work of actually picking apart the CPU stuff...
- */
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
2.55.0

