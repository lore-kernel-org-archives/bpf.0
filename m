Received: from mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CAF3B2FF6
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751577; cv=none; b=SpZfKVVWb3Ba/JzE2XiRrlYLhqQa1SnamIfHJDycVi3DPHcwABRYt1+XMMMS58qUWAY/42UzlenWnpL5oEuvmXOYvGGt2BKaJQ/LofIZtqaYr8PLvmQ6ncqOmIjebtDe8wzk4/GXbumzuJGma6Ih9/UyhDgEm5SeVojkLKTvzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751577; c=relaxed/simple;
	bh=rmmEfBECEg9NtxdBGrSrtO8BVoQ6tFM6eCk7zrNNAuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU3SPOsiAQhcVr+NkmMYJX9Tzn0NU2zFt+cg7vt2QPBwlTBdh7fidUZ/mU3jzSx7UIfHxWvmtly9cmNxq40aFKJNUjse49I/gx4+GhXg+BM0bFISE2HkaV53bifOhMcl0eLeO6B387ToCMt40oFXceXrAyETlLzGJ+y/xJdwo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dRcRUfhS; arc=none smtp.client-ip=95.215.58.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dRcRUfhS"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rmmEfBECEg9NtxdBGrSrtO8BVoQ6tFM6eCk7zrNNAuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786751573; v=1; x=1787356373;
 b=dRcRUfhSmeuiGbKwsWnWwzjZe0AKOikW5JjcBYeS4jYJKA4EKmnQiIx8tUNvL9Qty0cx+iyp
 MAo5sVhlWq0kCTPFw1KDqb/Hq+wmW2sTUbNLhvaE2/ZbiD1zFRn9a+WHAOp+//bIlJWBhK/aRQi
 UkNLcY4lPO1Q5/Wxo/JTyKGY=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::4:b8fe)
	by mta10.migadu.com with ESMTPS id 42315a227e488f5c;
	Fri, 14 Aug 2026 23:52:53 +0000
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
Subject: [PATCH v2 5/5] x86/cpu: Don't transiently clear the boot CPU's capabilities
Date: Fri, 14 Aug 2026 16:51:34 -0700
Message-ID: <20260814235134.3461435-6-ihor.solodrai@linux.dev>
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

32-bit gets the same treatment: the window is the same, and any
feature bit evaluated from interrupt context while it is open reads as
clear. Its no-CPUID cpuid_level default now comes from
early_identify_cpu(), and nothing writes cpuid_level again unless
CPUID is there to be read.

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
index 671a430994ca..e0c70a2510af 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1988,8 +1988,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	c->loops_per_jiffy = loops_per_jiffy;
 
-	init_cpu_info(c);
-
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
 
@@ -2174,6 +2172,7 @@ void identify_secondary_cpu(unsigned int cpu)
 		*c = boot_cpu_data;
 	c->cpu_index = cpu;
 
+	init_cpu_info(c);
 	identify_cpu(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
-- 
2.55.0

