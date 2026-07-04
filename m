Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150C1EEA3C
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124492; cv=none; b=MFiR5eT6ut7gSMAw47bDYU3+/YhMef+63UzWzgRGb4jhKijMI6MgKmQYKAB1rVWeO9yRiDY3Bx6zINiLTINHKPaMZPHFPncEPYLg/qbeIsE+NQ8nH1f5FJyGxDDPSD0n+mbevsbjVOkf1a1XU4yDGgXfOMlkWa4aHfBIczfgW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124492; c=relaxed/simple;
	bh=5vh/amqG0wz7FR1uAOk1v0xtOA29lkcrKGoh72CHsEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB0nXX3nBjAMfRJe33/mj9zabKkVJyl6z9SjxqVWlj5urLrEEh9rcoI+kYxXUc5syqMa69ZQNLeo+A+CTY5/7KDWYf9f2K3HiKWTCI2UAh3jEAaaX16Q9SS3LcR0t3ToREVTu5+6PqCYNmfg+bHJkAJi/CHyKJShSwlbe9HV+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w9EOB3lT; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w9EOB3lT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783124485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udq3/2zgh/qo/G71V2iT9d+CQ5RvaKNE12ZPGhXw2jY=;
	b=w9EOB3lTthCQPBsNqGF0bkCe84OTmUAadNbqCqOqT6Tf04IVwAjVDBq6bEf04vFnKX2nT8
	yMb88Y1+zhV7rAqQXWZTAykCx9MzYm33aVeoJrIrbDf+C0z2gjstdeJkxBmc4aZBleuH5n
	+EJ4Ga97YxepfCd5rdwfTSQGuPRqDtA=
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
Subject: [PATCH v1 5/5] x86/cpu: Don't reset boot CPU cpuinfo in identify_cpu()
Date: Fri,  3 Jul 2026 17:20:46 -0700
Message-ID: <20260704002046.3859585-6-ihor.solodrai@linux.dev>
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

identify_cpu() used to rebuild c->x86_capability from scratch:
init_cpu_info() memsets the capability array to zero and
identify_cpu() then re-reads CPUID. On the boot CPU identify_cpu()
runs after local_irq_enable() and before alternatives are patched. An
interrupt delivered in the window between the memset() and
get_cpu_cap() therefore will observe cleared x86_capability [1].

However the boot CPU's capabilities have already been scanned, with
interrupts off, by early_identify_cpu(). So move the init_cpu_info()
call out of identify_cpu() into its callers, and skip it for the boot
CPU on 64-bit.

Secondary CPUs call init_cpu_info() then identify_cpu() from
identify_secondary_cpu(), with interrupts off, exactly as
before. 32-bit still resets in identify_boot_cpu(): it relies on the
reset for the no-CPUID cpuid_level default.

[1] https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f093c6c7ccc..cd3d7c37c174 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1986,8 +1986,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	c->loops_per_jiffy = loops_per_jiffy;
 
-	init_cpu_info(c);
-
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
@@ -2156,6 +2154,13 @@ static void identify_cpu_32(struct cpuinfo_x86 *c)
 
 static __init void identify_boot_cpu(void)
 {
+	/*
+	 * The boot CPU's capabilities were already scanned in early_identify_cpu().
+	 * However 32-bit still needs to init_cpu_info() here for the no-CPUID
+	 * cpuid_level default.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32))
+		init_cpu_info(&boot_cpu_data);
 	identify_cpu(&boot_cpu_data);
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 		pr_info("CET detected: Indirect Branch Tracking enabled\n");
@@ -2178,6 +2183,7 @@ void identify_secondary_cpu(unsigned int cpu)
 		*c = boot_cpu_data;
 	c->cpu_index = cpu;
 
+	init_cpu_info(c);
 	identify_cpu(c);
 	identify_cpu_32(c);
 	x86_spec_ctrl_setup_ap();
-- 
2.54.0

