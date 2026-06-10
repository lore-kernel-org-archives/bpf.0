Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46130B51D
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115451; cv=none; b=GTWShwiPGmhMUD1EL/zxYJkaiLLSfApAP/YwByKgymCm8/ah0gqG2Cy4Icuo7/OUfNpwWvYP8nLfuo+v/73pGVpf51+hqE722F3hw+2LgSwtLYQkbV5i9K98ZO37QPkD/WKBX67RH5gxxxFRPk5a+efUjFg85e3CDhyDMZaWB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115451; c=relaxed/simple;
	bh=0lBpP+bR+aOT2qyg+bIEfUA9CYPchYHh/xLY648Bflo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oKjcUabdEI5M3qaH2f9iMwBEBbOqU+iY5jvxYxe1eMoSSkM17RMQqXwzDJEj86SnhkSdztk4aUke4f0mmu/FcJF+grxMZ8A1y4m1gcrq2iRWkudU/v+OKmHmH/2PiKNY40kJ+qemaSrJKwxyqeemZklLKNFXOa0LfayBtp8Ffbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/KEJF4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/KEJF4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F44C1F00893;
	Wed, 10 Jun 2026 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781115449;
	bh=IjGFqEbTO9JBJNQPWYlj8/ZJtvIUDzDTj16R5D6AZKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n/KEJF4nkqxn7TZrCO+tR5vi8t2oIM+PPz9M5hlWsoH8GnGDErnimnEx6ZisugUTX
	 LtUVEEW7clx1hzkE3lMDiuAqy5eI5sbmva4IcRCk4GFdDmsYTa5uTFtS/mmDOvhuX/
	 e9DYIW13eurMOLJ8laxQ3LtDLpxJlJuAsb8Q3giD8DgHsPfWe4xqR6mwJ9W9jb0CYR
	 0bcF6Ls5FS0o+4VOt72S3s/LyrB1TCff4wXk4OZvLdQMRJMHaVFUAV9Ch8qfofsvGt
	 2oZ87w9UPpvlIaz/2HftEgfNehx2ureQoIm+yrCrEOyqx/AQRBRK88c+E8ZA0TRY1l
	 Sqy286ZYlVX9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610175651.647515-1-ihor.solodrai@linux.dev>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 18:17:28 +0000
Message-Id: <20260610181729.7F44C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete fix and architectural layering violation via x86-spec=
ific macro in generic KASAN code.

Pre-existing issues:
- [High] Unhandled root cause: CPU feature flags are non-atomically cleared=
 while interrupts are enabled.
--

commit 5a28adbdf7cd811d1903c7692ad3799adc4606f3
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

kasan: Fix false-positive wild-memory-access on x86 under 5-level paging

This commit attempts to fix a flaky false-positive KASAN splat on x86_64
with 5-level paging. It addresses a race where the LA57 CPU feature is
temporarily cleared during boot by defining USE_EARLY_PGTABLE_L5 in the
generic KASAN code.

> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 2b8e73f5f6a70..b5f430f2dbb68 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -9,6 +9,13 @@
>   *        Andrey Konovalov <andreyknvl@gmail.com>
>   */
> =20
> +/*
> + * check_region_inline() and addr_has_metadata() can run very early.
> + * For example, in an interrupt taken while identify_cpu() has the CPU
> + * capability bits temporarily cleared.
> + */
> +#define USE_EARLY_PGTABLE_L5

[Severity: Medium]
Is it appropriate to place the x86-specific USE_EARLY_PGTABLE_L5 macro in
the generic KASAN code?

Since this macro is only defined locally in generic.c, other generic KASAN
files like mm/kasan/report.c remain unaware of it.

If a genuine KASAN bug occurs during the race window, wouldn't print_report=
()
miscalculate the shadow memory addresses:

mm/kasan/report.c:print_report() {
    ...
    if (addr_has_metadata(addr)) {
    ...
}

and fail to print the memory metadata because it uses the 4-level paging
start address instead of the 5-level one?

[ ... ]

> The root cause is in generic KASAN not seeing
> cpu_feature_enabled(X86_FEATURE_LA57) set, because the bit is cleared
> in identify_cpu() when the offending interrupt happens [1]:
>=20
>   memset(&c->x86_capability, 0, ...);   /* clears X86_FEATURE_LA57 */
>   ...
>   get_cpu_cap(c);                       /* re-reads CPUID, restores it */

[Severity: High]
This is a pre-existing issue, but does this approach leave the underlying
race condition unhandled?

In arch/x86/kernel/cpu/common.c:identify_cpu(), boot_cpu_data.x86_capability
is cleared non-atomically while local interrupts are still enabled. This
can occur because arch_cpu_finalize_init() runs after local_irq_enable().

Because alternative instructions have not yet been patched at this point in
the boot sequence, cpu_feature_enabled() dynamically checks
boot_cpu_data.x86_capability.

Could any interrupt handler that fires during this window and checks a CPU
feature spuriously see it as disabled, potentially causing core subsystems
to execute incorrect fallback paths?=20

Would it be safer to disable local interrupts during the boot_cpu_data
initialization in identify_cpu() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610175651.6475=
15-1-ihor.solodrai@linux.dev?part=3D1
