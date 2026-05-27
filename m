Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5F17745;
	Wed, 27 May 2026 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916317; cv=none; b=o0XsUlIPpSUZiKfSKsn42ENb1dJATDQklUPVliw+E0C+kcRpGun6gD4VG4e7GmiqKh1IzsBw9A1G8AIcENqv8QRtV0KseTVhSz0FHNAdB4xQpMGxmZkdAPxR/W2urityE/1DQskubhFlUYMtxBu/R/vjivMjzaEW+STMZIAccu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916317; c=relaxed/simple;
	bh=+tdvtZybaTGdkUt2cSFxQLxVTezSuX3ZQ3CkK5l8g94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw0++dD6VFAhx0CdMa7YOBlK9jqnaTbC80j/vRn+kOIdqzbNkerRwvjLgE0GvuzNNeFF0yNB6jEjXcTaMOQ6vwtkUr/UMzlFy2UBTtAYNtp64TsluR/omcLeMA4YcdpCgjiSx1+NC+jPjmSpjSNr9sfi4vp8p3ChWuXSWxLQG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dydfSLim; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dydfSLim"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wiNTn2pYeyuyayfVhMFJ/aFf1jF3wRjZNYIMEvLzZ0s=; b=dydfSLimwyfPmigTBMCujAZICg
	qiZ0DnjS6QG5mT3Xk7JmeCbY9l3lK8w4Hg6IBjWOagNnNb/tjdIjhrED3/HIZNpa27AiZsxClWJUu
	7+ZkJIqL/DPa2/qxPdbQWY2meXtnJTSis/iW1v1TIYSkgABqdAeywEB7FDhc0Oh1pMFPPqFO1diWC
	bOsS46TNcQd1HZLkWMwlOm9FGpviLHCzdLbrGVxa5HLQstifo2FK0uWYvG/z9eHiGi+F91D12dOIf
	CT00pVaw3wKVttGJjReynVf/k0ksQTZeqoNQ879jtzuEeHLm0remU3BnRkoKuw0RttTlQQDOmdYaI
	gHHwJtTw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSLXM-00000003MQT-2jnq;
	Wed, 27 May 2026 21:11:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28A03300673; Wed, 27 May 2026 23:11:35 +0200 (CEST)
Date: Wed, 27 May 2026 23:11:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH bpf-next] x86/ftrace: relocate %rip-relative percpu refs
 in dynamic trampolines
Message-ID: <20260527211135.GA343181@noisy.programming.kicks-ass.net>
References: <20260527-fix_call_depth_in_trampoline-v1-1-1c1abc8ae310@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527-fix_call_depth_in_trampoline-v1-1-1c1abc8ae310@bootlin.com>

On Wed, May 27, 2026 at 09:12:31PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> With CONFIG_CALL_DEPTH_TRACKING enabled on an x86 retbleed-affected
> platform (eg: Skylake), with retbleed=stuff, registering a dynamic
> ftrace trampoline crashes on the first call into the traced function:
> 

> 
> This small reproducer allows to easily trigger the crash:
> 
>   # echo 'p __x64_sys_clock_nanosleep' > /sys/kernel/tracing/kprobe_events
>   # echo 1 > /sys/kernel/tracing/events/kprobes/p___x64_sys_clock_nanosleep_0/enable
>   # usleep 1
> 
> Monitoring the crash under GDB points to the exact instruction in charge
> of incrementing the call depth:
> 
>   sarq $5, %gs:__x86_call_depth(%rip)
> 
> This instruction matches the one inserted by the ftrace_regs_caller from
> ftrace_64.S. This emitted code was likely working fine until the
> introduction of commit 59bec00ace28 ("x86/percpu: Introduce
> %rip-relative addressing to PER_CPU_VAR()"): it has made the call depth
> accounting addressing relative to $rip, instead of being based on an
> absolute address. As this code exact location depends on where the
> trampoline lives in memory, the corresponding displacement needs to be
> adjusted at runtime to actually correctly find the per-cpu
> __x86_call_depth value, otherwise the targeted address is wrong, leading
> to the page fault seen above.
> 
> Fix the %rip-relative displacement of the copied CALL_DEPTH_ACCOUNT
> instruction (from ftrace_regs_caller) by calling
> text_poke_apply_relocation(), as it is done for example by the x86 BPF
> JIT compiler through x86_call_depth_emit_accounting(). This corrects
> both CALL_DEPTH_ACCOUNT slots, in ftrace_caller and ftrace_regs_caller.
> 
> Fixes: 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()")
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  arch/x86/kernel/ftrace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 0543b57f54ee..357df1b2922c 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -375,6 +375,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  			goto fail;
>  	}
>  
> +	/*
> +	 * Generated trampoline may contain rip-relative addressing which
> +	 * displacement needs to be fixed
> +	 */
> +	text_poke_apply_relocation(trampoline, trampoline, size,
> +				   (void *)start_offset, size);
> +
>  	/*
>  	 * The address of the ftrace_ops that is used for this trampoline
>  	 * is stored at the end of the trampoline. This will be used to

I went and had a quick grep through the tree to see if there are more
sites that were missed in the conversion (commit 17bce3b2ae2d), but I
couldn't find another one.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

