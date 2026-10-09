Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15839E9D6;
	Fri,  9 Oct 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519280; cv=none; b=BOJmEWIsqE8JjfqXng3RngU06yJ2Gv14icHUSEg1GWQNwx2DeoXMt/N6SWBxd77wLkIDjaMfWg/oz2HJrP48zfdRntC5kA02QVTxowLwL9tv3O7sODwIHBIpCnNuVKtfjDFRZ0OZ1lI+BaJx0q79CyAwizFgmQAfqYfOlC0/47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519280; c=relaxed/simple;
	bh=CfJLNAjGDthMVhq0Ijs4RyzWCSnHXxmQ05t5I13X7jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCA8mU/wt82Z6/67L+rkkqBdYwU6tJmBraT6dWqW1sMzaNYfYWeXbwHv8NyPXo9SArZ7EldXJqmOB/2Y93s6CzL/m4sip3VYGTil6r5ChTQzEY4/oJQnUbLPDaJUAepZw3Q9TcEakaC9MkNMqXnJh6IG2k926wWPdvw6bUIk7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TofXUxlO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TofXUxlO"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C4B440E0484;
	Fri,  9 Oct 2026 04:14:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C2ucuVuy8K4q; Fri,  9 Oct 2026 04:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791519247; bh=a/kvWz5vc+K8CURkg+Ghq4OksOZeQYTNt2jO2pxw1w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TofXUxlOd3+1p69mP0hGXsklMoEP/qFHjUjfypvkrlurUqzmh3g+XPTvjfIWnaP1c
	 XlR3BFS3phelZPi1MpakeK/iPMkf8YpkrDRR5iqCDYc61r7dInmhyvQpFPjka7J1kp
	 6Rbc2wU9BPi90EX4nE13JheWfyAM0qJwu+vj+pt0FuKEYULL3hLyqLB2VCEvFuxk8n
	 S3edApzJOtueBYJsLdRQcoTAC9V7AGm+9+zi4LL/KO6D4co/gbXG+3PjhIRZfsBDLY
	 QSj1iUU9TnFKfiLIso6VPHvwAwVxuSL6jYMocuAmk83gqjFq3n5jot0QA7lmrjYJfx
	 3QyNp8hkGANGruQOF9CnRMZ3FpKVs5IX2htkq8CehI1fhWLKpVQfx5QFGaefNVeung
	 Nol9HkU0MUcCTCiZM3ExC3qE8M1fu+KpCZBBpnqfFOQYOQKCOShST5+L4ycguQrxqY
	 8EpA2Pma7BuUw/PQMmxEWSVVkUgMzl+a1d5hJ2+cB/wUtJJsILhC268X/U2Iq2K94L
	 Zx252oo5TxKuOMrnwtpXlLUiIzFvO00W+/5DlDFyVZhxOh3Ab4asBFFqtYkWMU94/o
	 w0sw1HISsDzdZjjWPrtDHSanYlBzhhdNwtRrozhBF1+6LbhR4ORIGsUDqMgGoRYwal
	 N4uON0fKC45ld0XIG7QV/01g=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39A3440E00B9;
	Fri,  9 Oct 2026 04:13:49 +0000 (UTC)
Date: Thu, 8 Oct 2026 21:13:46 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
Message-ID: <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009024925.3169077-2-memxor@gmail.com>

On Fri, Oct 09, 2026 at 04:49:21AM +0200, Kumar Kartikeya Dwivedi wrote:
> With SMAP enabled, do_user_addr_fault() treats a kernel-mode fault on a
> user address with EFLAGS.AC clear as a kernel bug: it does not consult the
> exception table and oopses right away. That is correct for ordinary kernel
> code, where get_kernel_nofault() and the other nofault accessors never let
> a user address reach a faulting instruction.
> 
> JITed BPF programs are different. A privileged program may dereference a
> pointer the verifier cannot prove valid, and the verifier marks such loads
> PROBE_MEM. The JIT attaches an exception table entry to each PROBE_MEM
> load, so that a fault on an unmapped kernel address zeroes the destination
> register and the program continues. Since a user address would oops
> instead, the x86 JIT also emits an address range check in front of every
> PROBE_MEM load, which keeps user addresses, the guard page above
> TASK_SIZE_MAX and the vsyscall page away from the load. The check
> duplicates the fault handler's knowledge of the address space layout, got
> the vsyscall page wrong until commit b599d7d26d6a ("bpf, x86: Fix PROBE_MEM
> runtime load check"), and costs nine instructions and 32 to 39 bytes of
> code per load.

I can't parse that. Why do bpf memory accesses need to be handled differently
than any other memory accesses when SMAP is enabled?

Perhaps you should give a concrete example.

And why can't all that gunk be resolved at program load instead of going all
the way in the #PF handler?

> When the faulting instruction belongs to a BPF program, resolve its
> exception table entry instead of oopsing, exactly as is done for faults on
> kernel addresses. The is_bpf_text_address() lookup sits inside the
> unlikely() SMAP branch that currently ends in page_fault_oops(), so no path
> that does not oops today executes any additional code, and the oops itself
> is unchanged when no entry matches. Non-BPF code keeps the existing
> behaviour: a kernel-mode user access without STAC still oopses, extable
> entry or not.
> 
> The next patch uses this to drop the range check from the JIT when SMAP is

There's no next patch and previous patch in git history.

> enabled. Nothing changes about which addresses a BPF program may read: a
> user address never becomes readable, since SMAP forbids the access, and a
> PROBE_MEM load of a kernel address is handled as before. Without SMAP the
> JIT keeps its range check and this path is never reached.
> 
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  arch/x86/mm/fault.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index aa88370ce739..2060e5f35d77 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -20,6 +20,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/mm.h>			/* find_and_lock_vma() */
>  #include <linux/vmalloc.h>
> +#include <linux/filter.h>		/* is_bpf_text_address()	*/
>  
>  #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
>  #include <asm/traps.h>			/* dotraplinkage, ...		*/
> @@ -1262,6 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
>  		     !(error_code & X86_PF_USER) &&
>  		     !(regs->flags & X86_EFLAGS_AC))) {
> +		/*
> +		 * JITed BPF programs dereference untrusted pointers with loads
> +		 * that carry an exception table entry (PROBE_MEM). SMAP makes
> +		 * sure such a load cannot read user memory, so resolve the
> +		 * fault through the exception table, as for an unmapped kernel
> +		 * address, instead of oopsing.
> +		 */
> +		if (is_bpf_text_address(regs->ip) &&
> +		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
> +			return;

I'm not at all amused from this adding bpf-specific handling to the #PF
handler, TBH...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
