Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253F35AC16;
	Thu, 30 Jul 2026 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446811; cv=none; b=Pb5zyHszsZw6fGC6soqq0PHiTo9mmWju4xiZcAQQjR6fXre2bkf1K3rgcvXO8Mema+2k5ftQix+mUnj1B6iAp3malubIWhzTxdBX8E/qjxWfcD0DDg6aSSgaif8Co7CW45dLwonCisbzd+HiozTaeUjjp39sFFKm1Unqgt7+Ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446811; c=relaxed/simple;
	bh=2SCuZOqKAdpoa0BhbxQUQzzzpHbhr3HvDOex/0THDAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjxphNVQL8HAcLg4JSdugOvnx2uaNbqFCw6fl8hb+Fpr1ueDgvg5zW6br7gVQ7v9ETZ4xwXdhGMvd44HhX4Zmt1oXpkI5eOjj5b/w+aHpXbc6owDW+rIw0lZF+v7ybfJyFXluR0oxXyMJ5usUuKyndgfWkG41PcMD2SYsFGJ7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hzwLx8/N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hzwLx8/N"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A246440E014C;
	Thu, 30 Jul 2026 21:26:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z5j5ovdkJOp4; Thu, 30 Jul 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785446792; bh=/UfwfMQb84HOLsF5rxaMcowx7tLIOiJ1m0KFTpO5g5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzwLx8/NxVyYc2ZU91vSepHfJ0kTKRdNfB/swQ/gtxoViqb+9nhMeHFve2yG3EBsK
	 LpbyVCmZ4sVijqY4pseFE1/yhEIkJgiR1/pwKNBs+BYz+nFgGCrLBHkPsiyHKfFMTB
	 XXD5ZYP1q7HmB7sjOHrD/0dlfTtZJ3+qZLd1glMTKCQiO9Aac46JIgfLN0JPLJeFPy
	 LSVlbV915O0ojrU8eSpiW1wFdtus37f7nhtvXOrhzPTOt5ISd/y/WjSOousRgwamhD
	 CPG5J+1r1aDXvhL6ca2xSyDO41neVbc5+5GEgYPOflquh0YsWaCqUbRq5VVXSkSQsd
	 Y75vKiqBd0MpL/FX90z5aq1nBxXK0wsozBkgZ/Ptk/WFQDj5dfSOTGJwDqB+1aIhLK
	 0pyoalk+evpySz2wtUc+i1eH/n6gfRQlPA72tVN3hUs47DXNicflwqKkYizFS/D1tf
	 TWAW3jh61wYYLITD6XSGtKGAzyR4Eh/IcQfZCxwbGvcp63Ak9lgiY2/1KQQF9Isp4E
	 02+zXHfY0gUctcekGRIGtJn6IQkZmQ0AKhXeDCpiIPy5oxQnfFcBrTFW6Uwg6OxYIh
	 lLnw1dwxnA39WkcTmJuHBZoZp4JhhOyuxmDOKlV4P0b7Guh8n1ULhqInzVXGW3C5lf
	 Tc3NoQnoTLaM3cJ9gTbSCz5A=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FF2740E00C4;
	Thu, 30 Jul 2026 21:26:16 +0000 (UTC)
Date: Thu, 30 Jul 2026 14:26:13 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, bpf@vger.kernel.org,
	kernel-team@meta.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] x86/cpu: Don't reset boot CPU cpuinfo in
 identify_cpu()
Message-ID: <20260730212613.GJamvBdRJ5H98hTWS8@fat_crate.local>
References: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
 <20260704002046.3859585-6-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260704002046.3859585-6-ihor.solodrai@linux.dev>

On Fri, Jul 03, 2026 at 05:20:46PM -0700, Ihor Solodrai wrote:
> identify_cpu() used to rebuild c->x86_capability from scratch:
> init_cpu_info() memsets the capability array to zero and
> identify_cpu() then re-reads CPUID. On the boot CPU identify_cpu()
> runs after local_irq_enable() and before alternatives are patched. An
> interrupt delivered in the window between the memset() and
> get_cpu_cap() therefore will observe cleared x86_capability [1].
> 
> However the boot CPU's capabilities have already been scanned, with
> interrupts off, by early_identify_cpu(). So move the init_cpu_info()
> call out of identify_cpu() into its callers, and skip it for the boot
> CPU on 64-bit.
> 
> Secondary CPUs call init_cpu_info() then identify_cpu() from
> identify_secondary_cpu(), with interrupts off, exactly as
> before. 32-bit still resets in identify_boot_cpu(): it relies on the
> reset for the no-CPUID cpuid_level default.

Ok, this commit message is all over the place. Please structure it something
like this:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

Also, do not talk about what your patches do - that should (hopefully) be
visible from the diff itself. Rather, talk about *why* you're doing what
you're doing.

In the patches where you do only mechanical movement, add

"No functional changes."

to the commit message to denote that.


> [1] https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  arch/x86/kernel/cpu/common.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 8f093c6c7ccc..cd3d7c37c174 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1986,8 +1986,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  
>  	c->loops_per_jiffy = loops_per_jiffy;
>  
> -	init_cpu_info(c);
> -
>  	if (!cpuid_feature())
>  		identify_cpu_without_cpuid(c);
>  
> @@ -2156,6 +2154,13 @@ static void identify_cpu_32(struct cpuinfo_x86 *c)
>  
>  static __init void identify_boot_cpu(void)
>  {
> +	/*
> +	 * The boot CPU's capabilities were already scanned in early_identify_cpu().
> +	 * However 32-bit still needs to init_cpu_info() here for the no-CPUID
> +	 * cpuid_level default.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_32))
> +		init_cpu_info(&boot_cpu_data);
>  	identify_cpu(&boot_cpu_data);
>  	if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
>  		pr_info("CET detected: Indirect Branch Tracking enabled\n");
> @@ -2178,6 +2183,7 @@ void identify_secondary_cpu(unsigned int cpu)
>  		*c = boot_cpu_data;
>  	c->cpu_index = cpu;
>  
> +	init_cpu_info(c);
>  	identify_cpu(c);
>  	identify_cpu_32(c);

Also, when you look at the final version, do you see how identify_cpu() and
identify_cpu_32() are soo close together so that you can basically move the
body of identify_cpu_32() to the end of identify_cpu() and then you don't need
that helper either.

Other than that, the flows do look better. 32-bit still needs dealing with the
no-CPUID case but that's for another day. I can't really find it in me to
care, actually, 32-bit needs to go away and we'll simplify a looot of code. Oh
well.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
