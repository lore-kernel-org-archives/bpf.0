Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E8377EBC
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174573; cv=none; b=nVmyHqvE8ue4h4zjCbv3SGc9+9tfTN3qXba0kX+b1hlCFFzwLag1l18FOeZ3pvGKzpfUbFsGhITaQLhbgg86hzSxZN1IdMQY7ROF36cNdoGOhx8/ML2UgzLBSnC6oSvUzqpxSn1/OenZPkRLTpNev72xLHFimnnXyDgPSyft2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174573; c=relaxed/simple;
	bh=2guNGex4qcI1TQ71JHbLIsLYH6GejGcGE4pdluu90do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF6vpDeIVf95yWxL7c930XswFHQKibwFKtlUaQ4urPhJG87tfsH+xsUD6km0gdpG6ZD2LDOvS1wPUmP4nx9Z/Gw8wTWmVKmf4tMcsZ2SprYbZvIEZJB6Lg41748k2V/YvfuMykfHfpR4ch0Og6JwSq+pnknNpp/tmvZNsPhYbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtCd3XDx; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtCd3XDx"
Message-ID: <87643862-e32e-43c7-8c81-7186f30059ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782174559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lef+zbZlC2cznmfkqDRBusiikF7Bb2MGAD4tRP3lvcI=;
	b=ZtCd3XDxWg0myslgDTzVk2YO2R3BnwFZmpAoKhA9z0ZIMsOrDnQFedfzaW0FuaQqSny/iB
	XYlbpSnXAQeic22gwrkLt2R1F+7zT6puwWjkHkLl5TFtCsOwVRS72C9j/kCFMUDkbruCSU
	VyCQm9v69Zf0f83gU9SARBWTZqxzVHE=
Date: Mon, 22 Jun 2026 17:29:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrey Konovalov <andreyknvl@gmail.com>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
 <20260618170913.GBajQmOQyOiBLqopUl@fat_crate.local>
 <3207a706-354c-4e9d-ba53-dded1abb1842@intel.com>
 <20260618183815.GDajQ7F-bqTHnrakoi@fat_crate.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618183815.GDajQ7F-bqTHnrakoi@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 11:38 AM, Borislav Petkov wrote:
> On Thu, Jun 18, 2026 at 11:12:09AM -0700, Dave Hansen wrote:
>> On 6/18/26 10:09, Borislav Petkov wrote:
>>> On Wed, Jun 17, 2026 at 03:13:33PM -0700, Ihor Solodrai wrote:
>>>> So my question to maintainers is what approach seems best?
>>> The CPUID stuff is being rewritten currently and it should address your issue
>>> too. If not, then we need to rewrite it better.
>>>
>>> Can you reproduce with this set applied ontop:
>>>
>>> https://lore.kernel.org/r/20260528153923.403473-1-darwi@linutronix.de
>>
>> Thinking about this a bit more... If Ahmed's series does fix this, I
>> think it will be accidental. It still uses identify_cpu() and also does
>> a memset() of the new c->cpuid structure in addition to the old
>> c->x86_capability structure.
>>
>> I'm not knocking Ahmed's series by any means. It just probably won't fix
>> this issue.
>>
>> In a perfect world early_identify_cpu() and identify_cpu() would either
>> get consolidated into one thing. Or at least become two discrete things
>> that initialize two completely disjoint sets of data. That way,
>> identify_cpu() wouldn't memset() anything.
>>
>> Isn't that the _real_ fix? Instead of trying to hide the inconsistency
>> when good data is blown away, we stop blowing it away in the first place?
> 
> early_ is only on the BSP and you want to scan all CPUs.
> 
> AFAIR, the last time I was looking at how we scan the CPUID leafs, we do have
> cases where there's blips in time when cap bits get disappeared to be
> rescanned again. The toggling of MSR bits which control feature flags is one
> thing that comes to mind.
> 
> But I'm with you on the consolidation approach. I think this is what we should

Hello Dave, Boris. Thank you for the input.

I tried a slight refactoring of the identify_cpu() machinery to
eliminate the memset(x86_capability) from the boot cpu, and it fixes
the splat that I reported.

identify_cpu() is split into two parts:
  * identify_cpu_scan() - the top part, up to and including the
    generic_identify() call
  * identify_cpu() proper with the rest, no memset here

Then (gated on x86_64) identify_boot_cpu() *skips* the
identify_cpu_scan() call, only executing the bottom part of current
identify_cpu(). We can do that because boot cpu already did the _scan
part in early_identify_cpu(), when interrupts are still disabled.

One caveat: get_model_name() is moved from generic_identify() into
identify_cpu(), otherwise it wouldn't be called on boot cpu. Same for
c->loops_per_jiffy = loops_per_jiffy; - it's moved to the "bottom"
identify_cpu().

The behavior for secondary cpus is unchanged: identify_secondary_cpu()
calls identify_cpu_scan() then immediately identify_cpu().

Please take a look at the diff below and let me know if this is a good
way to proceed. I don't know exactly what I'm doing, so concerns and
corrections are welcome.


diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a4268c47f2bc..4a655109cacf 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1978,8 +1978,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_cpu_address_sizes(c);
 
-	get_model_name(c); /* Default name */
-
 	/*
 	 * ESPFIX is a strange bug.  All real CPUs have it.  Paravirt
 	 * systems that run Linux at CPL > 0 may or may not have the
@@ -1999,13 +1997,12 @@ static void generic_identify(struct cpuinfo_x86 *c)
 }
 
 /*
- * This does the hard work of actually picking apart the CPU stuff...
+ * Rebuild capability set from CPUID and re-apply the forced-cap overrides
+ * through generic_identify(). This *should* run with interrupts off, otherwise
+ * an interrupt handler might see the capability bits cleared.
  */
-static void identify_cpu(struct cpuinfo_x86 *c)
+static void identify_cpu_scan(struct cpuinfo_x86 *c)
 {
-	int i;
-
-	c->loops_per_jiffy = loops_per_jiffy;
 	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
@@ -2028,6 +2025,19 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #endif
 
 	generic_identify(c);
+}
+
+/*
+ * This is safe to run with interrupts on.
+ * The boot CPU can run just this from arch_cpu_finalize_init(), because
+ * the scan part already happened in early_identify_cpu().
+ */
+static void identify_cpu(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	c->loops_per_jiffy = loops_per_jiffy;
+	get_model_name(c); /* Default name */
 
 	cpu_parse_topology(c);
 
@@ -2154,6 +2164,17 @@ void enable_sep_cpu(void)
 
 static __init void identify_boot_cpu(void)
 {
+	/*
+	 * The boot CPU's capabilities were already scanned by early_identify_cpu().
+	 * Here identify_cpu() only finalizes them.
+	 *
+	 * 32-bit still needs the full scan here: it sets X86_BUG_ESPFIX (via
+	 * generic_identify()) and the no-CPUID cpuid_level default, which the early
+	 * path does not.
+	 */
+#ifndef CONFIG_X86_64
+	identify_cpu_scan(&boot_cpu_data);
+#endif
 	identify_cpu(&boot_cpu_data);
 	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
 		pr_info("CET detected: Indirect Branch Tracking enabled\n");
@@ -2178,6 +2199,7 @@ void identify_secondary_cpu(unsigned int cpu)
 		*c = boot_cpu_data;
 	c->cpu_index = cpu;
 
+	identify_cpu_scan(c);
 	identify_cpu(c);
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
-- 
2.53.0-Meta

