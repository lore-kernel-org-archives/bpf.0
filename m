Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60F4B95C6;
	Thu, 17 Sep 2026 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688995; cv=none; b=o9P+rZ+KzTaCr+kee7DAy7FX4eFmWL36NHcxqoG9y/qDVSNTeop8rkhTv8xmX8C1n9wbNMLN3uzALM/tMd7D1kchl5724desvnzaFEUxiJzLXVLTUbPbULpUqedrrUbkk5oCZDSoGdNW0qEQOfu3oDz8zLSxeD45305avS3NHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688995; c=relaxed/simple;
	bh=tviXEU/ZJZDB40eRUfWniY+jtid3wdgqhQNHAPU5zA8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GC+RJ4PIKNZ+g7D6NLBPGv858u4DCyUhZXL20U8z7hAb0YBfAL50xfz1Crtub3UOMEipMkKtX3VuVoBKKZjcMnCqs5wICEx+EtccTlUUBY6gz/ZcIl/JJCOygaB78m+neg3v/2CgwSF/eL5D9rgrpJOVD9rgPER8hx/tvvaSs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne6BMIa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne6BMIa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B79A1F00898;
	Thu, 17 Sep 2026 23:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789688991;
	bh=nsN+MnObPE5JbQyZhJ55IeEN7t8dHWyJ3zY4el12zro=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ne6BMIa06ffN5Tenqt0HBivViNRKdOfLaF8X5KH8sC5XJ8mVtY6bZAbd89npXJ2T/
	 /+oUcFit7bW8xokVXmqABd0XicBaDXvN0ypu7JrRCq3/8/23BxM9Ppf2ZG4NNKLVKe
	 gJZ9Ow831svvJNL9Il22We2TMYVsnVgpnhIRpccX/vyo14jr7bjd0MxPqSt4kbWaVS
	 GRuqf08jr1pHuo81ULgrjlwFMVwY7xprk3nNqUyzJq+UdnZRbyVVaPeoqQxYFrKAy3
	 VHyapLZAyoIyE6fA46A9XFnrzhKuaoAqImwyq4xw0z3abaeb9mxIZbwLpKsINDzH1a
	 UVFS8hQdhhJSg==
Content-Type: multipart/mixed; boundary="===============9216955143622942885=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7ff3f8ea537dfb920e2eb4b8a10c729d4e40014cb801472f4be848eab69da2c@mail.kernel.org>
In-Reply-To: <20260916195203.1099646-3-ihor.solodrai@linux.dev>
References: <20260916195203.1099646-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH v3 2/5] x86/cpu: Initialize boot CPU cpuinfo defaults early
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,mingo@redhat.com,tglx@kernel.org
Cc: ast@kernel.org,andrii@kernel.org,ryabinin.a.a@gmail.com,akpm@linux-foundation.org,hpa@zytor.com,andreyknvl@gmail.com,linux-kernel@vger.kernel.org,x86@kernel.org,bpf@vger.kernel.org,kasan-dev@googlegroups.com,linux-mm@kvack.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 23:49:50 +0000 (UTC)

--===============9216955143622942885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index c3dce89ba5904..66695addbdf33 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1812,16 +1812,15 @@ static void init_cpu_info(struct cpuinfo_x86 *c)
>   * Do minimum CPU detection early.
>   * Fields really needed: vendor, cpuid_level, family, model, mask,
>   * cache alignment.
> - * The others are not touched to avoid unwanted side effects.
> + * The others are reset to their defaults here and only filled in later,
> + * by identify_cpu().
                         ^^

Does this comment match what the code does? The comment says fields
outside the "really needed" list are only reset here and filled in later
by identify_cpu(), but early_identify_cpu() itself fills in most of those
fields before it returns.

After init_cpu_info() resets the fields, early_identify_cpu() continues
to call:

  cpuid_scan_cpu(c);         /* re-populates c->cpuid */
  cpu_detect(c);             /* x86_clflush_size, x86_cache_alignment */
  get_cpu_cap(c);            /* x86_capability[], extended_cpuid_level */
  get_cpu_address_sizes(c);  /* x86_phys_bits, x86_virt_bits,
                                x86_cache_alignment */

Of the twelve fields init_cpu_info() resets, only three (x86_cache_size,
x86_model_id and, under CONFIG_X86_VMX_FEATURE_NAMES, vmx_capability) are
left for identify_cpu(); the capability array, the CPUID table,
extended_cpuid_level and the address sizes are all re-established in this
function.

The sentence also contradicts the line immediately above it, which already
lists "cache alignment" among the fields early detection does produce.

This matters more than a normal comment nit because the very next paragraph
is a WARNING about what may and may not be added to this function: a reader
who believes the non-essential fields are untouched until identify_cpu()
would draw the wrong conclusion about what state is valid at this point in
boot.

Could the comment say that the architectural defaults for the remaining
fields are established here, and that only the cache size, model string
(and VMX capabilities) are filled in later by identify_cpu()?

>   *
>   * WARNING: this function is only called on the boot CPU.  Don't add code
>   * here that is supposed to run on all CPUs.
>   */
>  static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  {
> -	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
> -	memset(&c->cpuid, 0, sizeof(c->cpuid));
> -	c->extended_cpuid_level = 0;
> +	init_cpu_info(c);
>
>  	if (!cpuid_feature())
>  		identify_cpu_without_cpuid(c);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35285131592
--===============9216955143622942885==--
