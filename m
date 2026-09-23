Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70C44AB7E;
	Wed, 23 Sep 2026 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147551; cv=none; b=PUV+bo0LNxugQ1zdfXKKStb93kl8u6pXek9ZcxY33YefF927VJdosZr1WRK/itH7S+hFqDEE22zwdgEHh+zn7RGz9SxJL84yYwUs0w2EhOXRIWUHaRY2ciXDe/7XRm1aqd28nt5kbCFXIknIElXAbnQMh+n+z+1uxBPg4PHlBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147551; c=relaxed/simple;
	bh=Y0V85kEMZ+dDLr3URjIkV4kMyt/4r6kWITfLmMWhoIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7ifHEIZKGyYlb7f64MivrToN0PR7rIGneivE21nw2jTAZ+Fonl9RvW7+d12gUjB2/gTBs0qXHHk7KtJQw6Wxi8yQ7helBSincmATOgibyIJtZBptCTazhaZ5QacUyuCOWWBIFr/qcPU6KnIgd/Plwf5muzWF0R8+d09wn/n1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U03z0s2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U03z0s2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5811F000FF;
	Wed, 23 Sep 2026 07:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790147550;
	bh=KWQhfqkSmSMAtAlI63G4adXC3E3DzyK/NbC904+wT0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U03z0s2xdkLwt9El1H5VsOxeivFFKne7GHeMDIV0zjqoJq/YD7WS6u+IUtvuX3gw9
	 K7rZs8RUEg/1aY2AeLyohp9TVZZmKgEQzZe0iIej7nBnzrufJ5gmDw2jwOZvk8JsTh
	 SfHZ69kdn/dkLPSp8djqP7QICiT5OBmh6MRw6z+br86oYt62dEfVOWU+F3uA8t8MUq
	 MA9Y2rPeyeXlmSns5MEygIMf9t7C5RurRrNTijqOAvAfuTGTwrTHYvFhnMgEQCBvJP
	 i4cm5FUE6+2asT5Zh+4dae1xo9jXkivmVYyPCNIGPohV7m7J08bBDRr1YEGmVGNDHv
	 3cmd1Rb6yOGLA==
Date: Wed, 23 Sep 2026 00:12:29 -0700
From: Kees Cook <kees@kernel.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 0/4] kallsyms: Accelerate symbol name lookups by ~19x
Message-ID: <202609221705.FE257DCFE7@keescook>
References: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>

On Tue, Sep 22, 2026 at 02:08:17PM -0600, Jim Cromie wrote:
> 2. Patch 3 introduces a dynamic u32 lookup index bracketed by
>    kallsyms_lookup_batch_start() and kallsyms_lookup_batch_end().
>    It allocates ~736 KiB in transient RAM via kvmalloc_array() only
>    while bulk workloads (BPF attach, module loading) run, resolves
>    each probe in O(1) with 0 hops, and leaves .rodata bloat at exactly
>    0 bytes while retaining kallsyms_markers[] as fallback.  Both
>    test_kallsyms_perf and kallsyms_selftest are updated to benchmark
>    batch resolution side-by-side.
> [...]
> - Dropped .rodata image footprint addition from +573 KiB to 0 KiB,
>   addressing Kees Cook's memory footprint objection.

Ah, very cool; thanks for giving the dynamic route a try! (Also, please
wait a few days between versions and give humans some time to reply.)

I spent some time trying to understand all the timings here, and with
a problem statement of "tens of thousands of functions", I'd want
to understand how common that workload is. Even module loading isn't
anywhere near that high, and AIUI, most kprobe loads of that size are
roughly one-offs, and what Jiri measured was the most extreme possible
attach we could see, and that is a synthetic workload. (And kallsyms
was ~7% of the attach.) I struggle to see a problem that needs solving.

What we have today is a 1:256 mapping, so the walk penalty in ~128 steps
per symbol lookup. With your proposed 1:1 there's no walk penalty, but
we either pay a lifetime .rodata cost or a startup/teardown cost and
temporary dynamic allocation cost.

Right now the startup time for the dynamic table appears to need ~1500
symbol look-ups to break even compared to today's 1:256 mapping.

How would a 1:8 table in .rodata compare, for example? It's not 1:1 but
it should get you something like 95% of the speed (84ns) for a 8x less
.rodata memory compared to the 1:1 in .rodata. And the table might be
small enough that cache locality helps more?

Anyway, I'd be curious to see the benchmarks at alternative densities as
there is a clear space vs time trade-off here, and moving into dynamic
allocation changes the measurements again.

But dominating all of this is the question of how common it is to do
tens of thousands of symbol lookups with a fast path need. As a 1-time
cost or even every few hours, it's hard to justify either size (1:1 in
.rodata for all Linux systems) or complexity (RCU-locked 1:1 allocation
built on the fly).

-Kees

-- 
Kees Cook
