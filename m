Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A044C646
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588391; cv=none; b=lJBtkQbUR9uispxNJ/EVaQXk9mSR5mAA+o8y70IlTqEx2DBdNZUT/7hARcYOnSe6TJw9gOv8vM1aToZ0fDXjVJm4kQ1zy8Tp11obiiH9cWILdqylpEtHGCuUd+sjjIay5P7Eaa91UlD90UYI/DSKsYHrZ5d5FgXPu1El4UQjjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588391; c=relaxed/simple;
	bh=NALIzAyd257Q9XRdPDmwZcj4GGaZ5ZdrW+pWs0t+wH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvp9F0hyO+bdBwBCjLBwIzvUm9WxS5hybl31KptA/EqKrDH0cVRENQLZzlFFMpBkFvL0VXoDko+YWH0a47KojHIyWCGG5z4Jo0pPwqhyNgxBHPn17TSTGhbHsi5WwC95pM/72QRLL7o5yWb9/KaEkpjL5qnbHka3TtyJPAPzlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nj75s8lu; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nj75s8lu"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NALIzAyd257Q9XRdPDmwZcj4GGaZ5ZdrW+pWs0t+wH0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789588373; v=1; x=1790193173;
 b=Nj75s8luQiePcDHUhOJVN9Qwz62YCYi2E1I9K+KT/omQ4z98CsRkHNkTZITIjTz8aEWqlFs+
 O7O62kfXqKOJ+1l8wMFWKaMGf3I5My20sua/6UBq41dTfUMoSeOQ09E8MB6bcrHh+tWvVuX+XRs
 +tjKKOyvgVnl9DlRU8gJSyBE=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a2265ddc4010ca96;
	Wed, 16 Sep 2026 19:52:53 +0000
X-Mizu-Trace-ID: a2265ddc4010ca96
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
Subject: [PATCH v3 5/5] x86/cpu: Don't transiently clear the boot CPU's capabilities
Date: Wed, 16 Sep 2026 12:52:03 -0700
Message-ID: <20260916195203.1099646-6-ihor.solodrai@linux.dev>
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

On the boot CPU identify_cpu() runs from arch_cpu_finalize_init(),
with interrupts enabled and before alternatives are patched. So
cpu_feature_enabled() still evaluates against boot_cpu_data.

identify_cpu() rebuilds c->x86_capability from scratch: the reset
zeroes the array and the CPUID rescan fills it in again. An interrupt
delivered in that window finds X86_FEATURE_LA57 clear in
boot_cpu_data, so pgtable_l5_enabled() is false and KASAN checks a
5-level address against the 4-level addressability limit. The result
is a bogus "wild-memory-access" report, and under kasan_multi_shot a
report storm that wedges the boot.

The boot CPU has already been scanned by early_identify_cpu(), with
interrupts disabled, and its capabilities cannot have changed
since. Reset only the CPUs which have not been scanned yet.

The window is as old as identify_cpu() rebuilding the capabilities.
Commit 39b9552281ab ("x86/mm: Optimize boot-time paging mode switching
cost") merely let KASAN notice it by making pgtable_l5_enabled() read
the feature bit. So no Fixes: tag.

Closes: https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 83d613d07997..496ffe429496 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1998,8 +1998,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	c->loops_per_jiffy = loops_per_jiffy;
 
-	init_cpu_info(c);
-
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
@@ -2184,6 +2182,7 @@ void identify_secondary_cpu(unsigned int cpu)
 		*c = boot_cpu_data;
 	c->cpu_index = cpu;
 
+	init_cpu_info(c);
 	identify_cpu(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
-- 
2.55.0

