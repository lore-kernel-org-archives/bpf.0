Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39BC3672A0
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751552; cv=none; b=W6nrUCRsjy1wkiIoODuPwvJKSNCEYPUMIjXQk9CcVzN8+hyCMSyKVByi58TWKDEaZgEj483sxVwMXc1o5LhHFeBu+S0/qlDslRQV9XvGgVLFUburiDzFr1CShFS1agwHSdr0IMebhmfllKczKV0e3ZOWwfngTl08zzMu3pCXkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751552; c=relaxed/simple;
	bh=3SbJTWKQRPJhm3xT71jRLeUekhnVMPArD1wBhzIMjeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVP6dI45+b2v//r5R/3BncFO9+YMJ8cFlca7g2nrW9pzZR0uCNYeTFI/ex75hNyNK0YpRbST74jGHKX3MAX8hFhDvDvOtDoVevnQ9BENZW2AQ1P2KAvot0h4NI9nIXHiH+cvdzpyQh7/LxGzIGriqhgAfWOooWWa7L2Tr4fT+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lXV7KOmz; arc=none smtp.client-ip=91.218.175.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lXV7KOmz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3SbJTWKQRPJhm3xT71jRLeUekhnVMPArD1wBhzIMjeA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786751548; v=1; x=1787356348;
 b=lXV7KOmzqR8iGl6VoV5rXX+OFnis7m4KHdy+5IWTA86+ds9jZWZ6CUWjcz/mn/sN3AffirvW
 OwUszsqFGuOTT2g8RbkhiAGahro2O1LmQyfjdJsvVTPB+CVvBX2Chfo1JTfaEhgfNtu5SyEKC9b
 fXkG8B6whRtYKo2wHkNc5rEk=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::4:b8fe)
	by mta10.migadu.com with ESMTPS id 781dcae87522a580;
	Fri, 14 Aug 2026 23:52:28 +0000
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
Subject: [PATCH v2 2/5] x86/cpu: Initialize boot CPU cpuinfo defaults early
Date: Fri, 14 Aug 2026 16:51:31 -0700
Message-ID: <20260814235134.3461435-3-ihor.solodrai@linux.dev>
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

early_identify_cpu() clears the capability array, the CPUID table and
extended_cpuid_level, but the architectural defaults for the rest of
struct cpuinfo_x86 are set only later, in identify_cpu().

On x86_64 x86_clflush_size defaults to 64. Until that default is
applied it reads as zero, which get_cpu_address_sizes() interprets as
"not enumerated" and replaces with 32. So on a CPU which does not
enumerate CLFLUSH the boot CPU runs with an x86_clflush_size and an
x86_cache_alignment of 32 until identify_cpu() resets them to 64.

Use the same defaults from the start, so that the boot CPU does not
depend on a later reset to end up with the right ones.

The values the boot CPU ends up with do not change. Early users of
cache_line_size() on a CPU which does not enumerate CLFLUSH now see the
architectural 64 instead of the 32 fallback, which is what they should
have been seeing all along.

This change comes before the last patch because that one removes the
reset: without the defaults established here the boot CPU would be
left at 32 instead of 64 on an x86_64 CPU which does not enumerate
CLFLUSH.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 arch/x86/kernel/cpu/common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bb4525523222..f43584c8aeab 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1802,16 +1802,15 @@ static void init_cpu_info(struct cpuinfo_x86 *c)
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
  * cache alignment.
- * The others are not touched to avoid unwanted side effects.
+ * The others are reset to their defaults here and only filled in later,
+ * by identify_cpu().
  *
  * WARNING: this function is only called on the boot CPU.  Don't add code
  * here that is supposed to run on all CPUs.
  */
 static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 {
-	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
-	memset(&c->cpuid, 0, sizeof(c->cpuid));
-	c->extended_cpuid_level = 0;
+	init_cpu_info(c);
 
 	if (!cpuid_feature())
 		identify_cpu_without_cpuid(c);
-- 
2.55.0

