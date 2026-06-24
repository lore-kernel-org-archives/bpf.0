Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC22857CC;
	Wed, 24 Jun 2026 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269891; cv=none; b=czoD1Z9cA2wiXjucrtBY32eFb19tOexl2zDp9DoG9krcJh9agZgz0dQff0EXNqPcHUxW/JYuJUh3HEGAevCa+6u+blt7HUUmZ4fEEmcsb014A2rm7G+DvvTn6RXw178X3bHq4WX7Yi410zAiT3gBjtA6Oh9peVx7HCMfOMqLUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269891; c=relaxed/simple;
	bh=tN51X41k19tYODr6QWUfgWuk2w33f2hnoSTexYjmjhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDuo2Ck6TqPep1VuHqnsScZKM4TTkKtFE+G7aidhxKhY0LOl6htdM95NtwknNxuprbxkOr/D4gU+YGdYH3kKGlbr4+AeGckPn4wC5vB/7DUZudTC6bNBG3UKDxYuoXQ+Jnphr5LyK/HotaljiUibvVYQn+KfGGQ/EwI/ORbhGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I/gzYan9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I/gzYan9"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1F8640E01B4;
	Wed, 24 Jun 2026 02:58:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8vuomES7BQRE; Wed, 24 Jun 2026 02:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782269876; bh=5pumt3ZhtXEP5A7/txAfIN/pYRRHkq0RSi/yjC0QK9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/gzYan9dcc6f59zVNBMGNtm/lLomcAVoGlaPz1ae8J6kyyj6uXQmVNPmUw/MN8Vt
	 p5bGnG2qc2TTMgLuWGwlECt+NhzNaySoj9ZEhew7KRUDjxnqDfZxuzhgYc/lfTMZAQ
	 116Uk+agAeqMxfWbCdPs/kVQX5hosdAi6J/gUW0npNcbdPjy5Ns78UjY0bWUmY6vpz
	 iVsjgcNy9rN0DrpdaREln6E/ZT/O28XkiqTEQEc35HCZcTc0ErbuxgdThqxpwJe9B7
	 EDNMkED9gLY29DO3zk3q7rH5+2duDr2nfOFOdMa/4mIHnMmLddAnIcd2M3HBJSrQWj
	 jPoENq3LRaqRXeEsgQLTCoViLDi0px8FGlQKTs4nBaj3sxkKEo+1eT5Gxb2wB6YWtr
	 HWs4w7x4m38HvzPVUJ39gx/WW+JlvEdp68o1HzFrgpCleOBOPD8cJ3sOiEpb8fr7Wn
	 bhdf9h/R6XvNpMuthunauRLcsrn5zC4MsYHRDn7JnXt4XOiL7EhaOG+cqPFxDU3ZtC
	 cra+nhHpMGujdSjuHpPQfyZ3lniFLRsAlVTKP4OZc05Ja7N/nZIhjrPQZRe+Lnrr/0
	 ZWGgX9lFYYgzNR0TNWSdSFkBWL9zKK4A1ATqi+SmQ1irlJkONoopGICFJqeB47j9Hi
	 xLcF2/yl9isC+GGRCGLjxNYw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A2E340E0031;
	Wed, 24 Jun 2026 02:57:37 +0000 (UTC)
Date: Tue, 23 Jun 2026 19:57:32 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
Message-ID: <20260624025732.GDajtHnB1Jc21kQnl_@fat_crate.local>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
 <20260618170913.GBajQmOQyOiBLqopUl@fat_crate.local>
 <3207a706-354c-4e9d-ba53-dded1abb1842@intel.com>
 <20260618183815.GDajQ7F-bqTHnrakoi@fat_crate.local>
 <87643862-e32e-43c7-8c81-7186f30059ea@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87643862-e32e-43c7-8c81-7186f30059ea@linux.dev>

On Mon, Jun 22, 2026 at 05:29:12PM -0700, Ihor Solodrai wrote:
> On 6/18/26 11:38 AM, Borislav Petkov wrote:
> > On Thu, Jun 18, 2026 at 11:12:09AM -0700, Dave Hansen wrote:
> >> On 6/18/26 10:09, Borislav Petkov wrote:
> >>> On Wed, Jun 17, 2026 at 03:13:33PM -0700, Ihor Solodrai wrote:
> >>>> So my question to maintainers is what approach seems best?
> >>> The CPUID stuff is being rewritten currently and it should address your issue
> >>> too. If not, then we need to rewrite it better.
> >>>
> >>> Can you reproduce with this set applied ontop:
> >>>
> >>> https://lore.kernel.org/r/20260528153923.403473-1-darwi@linutronix.de
> >>
> >> Thinking about this a bit more... If Ahmed's series does fix this, I
> >> think it will be accidental. It still uses identify_cpu() and also does
> >> a memset() of the new c->cpuid structure in addition to the old
> >> c->x86_capability structure.
> >>
> >> I'm not knocking Ahmed's series by any means. It just probably won't fix
> >> this issue.
> >>
> >> In a perfect world early_identify_cpu() and identify_cpu() would either
> >> get consolidated into one thing. Or at least become two discrete things
> >> that initialize two completely disjoint sets of data. That way,
> >> identify_cpu() wouldn't memset() anything.
> >>
> >> Isn't that the _real_ fix? Instead of trying to hide the inconsistency
> >> when good data is blown away, we stop blowing it away in the first place?
> > 
> > early_ is only on the BSP and you want to scan all CPUs.
> > 
> > AFAIR, the last time I was looking at how we scan the CPUID leafs, we do have
> > cases where there's blips in time when cap bits get disappeared to be
> > rescanned again. The toggling of MSR bits which control feature flags is one
> > thing that comes to mind.
> > 
> > But I'm with you on the consolidation approach. I think this is what we should
> 
> Hello Dave, Boris. Thank you for the input.
> 
> I tried a slight refactoring of the identify_cpu() machinery to
> eliminate the memset(x86_capability) from the boot cpu, and it fixes
> the splat that I reported.
> 
> identify_cpu() is split into two parts:
>   * identify_cpu_scan() - the top part, up to and including the
>     generic_identify() call
>   * identify_cpu() proper with the rest, no memset here
> 
> Then (gated on x86_64) identify_boot_cpu() *skips* the
> identify_cpu_scan() call, only executing the bottom part of current
> identify_cpu(). We can do that because boot cpu already did the _scan
> part in early_identify_cpu(), when interrupts are still disabled.
> 
> One caveat: get_model_name() is moved from generic_identify() into
> identify_cpu(), otherwise it wouldn't be called on boot cpu. Same for
> c->loops_per_jiffy = loops_per_jiffy; - it's moved to the "bottom"
> identify_cpu().
> 
> The behavior for secondary cpus is unchanged: identify_secondary_cpu()
> calls identify_cpu_scan() then immediately identify_cpu().
> 
> Please take a look at the diff below and let me know if this is a good
> way to proceed. I don't know exactly what I'm doing, so concerns and
> corrections are welcome.
> 
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index a4268c47f2bc..4a655109cacf 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1978,8 +1978,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
>  
>  	get_cpu_address_sizes(c);
>  
> -	get_model_name(c); /* Default name */
> -
>  	/*
>  	 * ESPFIX is a strange bug.  All real CPUs have it.  Paravirt
>  	 * systems that run Linux at CPL > 0 may or may not have the
> @@ -1999,13 +1997,12 @@ static void generic_identify(struct cpuinfo_x86 *c)
>  }
>  
>  /*
> - * This does the hard work of actually picking apart the CPU stuff...
> + * Rebuild capability set from CPUID and re-apply the forced-cap overrides
> + * through generic_identify(). This *should* run with interrupts off, otherwise
> + * an interrupt handler might see the capability bits cleared.

And yet it doesn't run with IRQs off. So that comment doesn't need to be here.
The point of the whole exercise is to not disable ugly interrupts in that path
at all.

>   */
> -static void identify_cpu(struct cpuinfo_x86 *c)
> +static void identify_cpu_scan(struct cpuinfo_x86 *c)
>  {
> -	int i;
> -
> -	c->loops_per_jiffy = loops_per_jiffy;
>  	c->x86_cache_size = 0;
>  	c->x86_vendor = X86_VENDOR_UNKNOWN;
>  	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
> @@ -2028,6 +2025,19 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  #endif
>  
>  	generic_identify(c);
> +}
> +
> +/*
> + * This is safe to run with interrupts on.
> + * The boot CPU can run just this from arch_cpu_finalize_init(), because
> + * the scan part already happened in early_identify_cpu().
> + */
> +static void identify_cpu(struct cpuinfo_x86 *c)
> +{
> +	int i;
> +
> +	c->loops_per_jiffy = loops_per_jiffy;
> +	get_model_name(c); /* Default name */
>  
>  	cpu_parse_topology(c);
>  
> @@ -2154,6 +2164,17 @@ void enable_sep_cpu(void)
>  
>  static __init void identify_boot_cpu(void)
>  {
> +	/*
> +	 * The boot CPU's capabilities were already scanned by early_identify_cpu().
> +	 * Here identify_cpu() only finalizes them.
> +	 *
> +	 * 32-bit still needs the full scan here: it sets X86_BUG_ESPFIX (via
> +	 * generic_identify()) and the no-CPUID cpuid_level default, which the early
> +	 * path does not.
> +	 */
> +#ifndef CONFIG_X86_64
> +	identify_cpu_scan(&boot_cpu_data);
> +#endif
>  	identify_cpu(&boot_cpu_data);
>  	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
>  		pr_info("CET detected: Indirect Branch Tracking enabled\n");
> @@ -2178,6 +2199,7 @@ void identify_secondary_cpu(unsigned int cpu)
>  		*c = boot_cpu_data;
>  	c->cpu_index = cpu;
>  
> +	identify_cpu_scan(c);
>  	identify_cpu(c);
>  #ifdef CONFIG_X86_32
>  	enable_sep_cpu();
> -- 

Ok, thanks for that, that's a good first try. I did poke at it a bit and
here's what I think should happen:

1. The part which initializes struct cpuinfo_x86 up and including the memsets
   should be one function called init_cpu_info() or so.

2. Then, generic_identify() should be merged into identify_cpu() basically
   turning the latter into a single function which does a generic CPU
   identification both on the BSP and on the APs.

3. #ifdef CONFIG_X86_32
        enable_sep_cpu();
#endif 
	that gunk should be stuck into a function called identify_cpu_32() and
	you'll have at the beginning of it

	if (!IS_ENABLED(CONFIG_X86_32))
		return;

   and then you call that function both in identify_boot_cpu() and
   identify_secondary_cpu(). This way you streamline the paths and drop all
   that ugly ifdeffery.

4. When you do 3. above, you should be able to move this gunk

	#ifdef CONFIG_X86_32
        set_cpu_bug(c, X86_BUG_ESPFIX);
	#endif

to it too. And now everything is nicely encapsulated and straight-forward.

5. The above will allow you to have the init_cpu_info() only on 32-bit.

Oh and, looking at the ifdeffery on identify_cpu():

	#ifdef CONFIG_X86_64
	        c->x86_clflush_size = 64;
	        c->x86_phys_bits = 36;
	        c->x86_virt_bits = 48;
	#else

you could probably add a identify_cpu_64() too. Or maybe the init parts should
be called separately init_cpu_info_32() and init_cpu_info_64(). You probably
need to see how it looks like when you write it.

Oh, and each 1., 2., ...step above is a single patch. This'll make the review
very easy too.

How does that sound? Willing to give it a try? :-)

If not, I could try to find some time and do it myself but I thought you might
be willing to try it...

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
