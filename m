Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD973D1A81;
	Tue, 29 Sep 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707557; cv=none; b=QcKBiymvnxLbz8YsRIrT4m84auWnqnL19fWOb9lo3Vja8JcbrHMj8rMHeX8hfxJyDawxboeHlz+f+o9v5KoTmcJb8+BjUA95FIaZ7jN/HMJr/Sqiefh7bO6mE4mutWrlH2CpDcoOlsHR+6VJ55EEIhMyKmc95WmK1IY3NWvsSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707557; c=relaxed/simple;
	bh=3N4KdQxJoGPz1hgxzgdGAufrbd1lUAKVW8XZBxY+qxQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r0aRMFrVDBuEoiSyP/dVKmpkm0TzchRczm6guwrXnMm8fPsykUu/RsjWScxybM4eVYd1iSWH2CeBecbjcsKiTyAj16tHJWG7CPsuwZBalzey0uDev2wG46s/cms3CqiNUnUy4G1sm9ICiLIyBRUMWwD+ckNSkb3hlx1u73/KLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=s9zy8G7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="s9zy8G7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892AD1F000FF;
	Tue, 29 Sep 2026 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790707556;
	bh=ckBKRlY57E9QCcqLcWEZ4zI8fs+c1MX2N526ah8gQys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=s9zy8G7w8bhgas9xFv6Zm5M/+579DY/4L6zBXisIITWbS1mKLEFbEFImbFSqNhsia
	 xSP2bGnMuXzf8CtK5oPnbKlXQSmVm7ZH5yG8TDBmMm5HjZqPAxZsIbqtwqn8iaCjps
	 J0V+84ucQiOjU8QQyRoAIlTrT3hBXaY3wKX8pZv8=
Date: Tue, 29 Sep 2026 11:45:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jim.cromie@gmail.com
Cc: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Zhen Lei <thunder.leizhen@huawei.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Andrey Grodzovsky
 <andrey.grodzovsky@crowdstrike.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, David Laight
 <david.laight.linux@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: Re: [PATCH v7 0/3] kallsyms: Accelerate symbol name lookups by ~7x
Message-Id: <20260929114554.571ba4899639db50f71fafa5@linux-foundation.org>
In-Reply-To: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
References: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 12:07:29 -0600 Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:

> In 2022, commit 60443c88f3a8 ("kallsyms: Improve the performance of
> kallsyms_lookup_name()") introduced kallsyms_seqs_of_names[] (+550 KiB
> .rodata), transforming an O(N) linear scan into an O(log N) binary
> search (5.2 ms -> ~7.2 us).  While this was a major step forward,
> the binary search inner loop was left decompressing full candidate
> names and scanning across sparse 256:1 markers on every probe.
> 
> Modern fleet observability, security daemons (e.g. CrowdStrike Falcon,
> Cilium, Datadog, Falco), and tracing tools resolve thousands of kernel
> functions by name at boot or service start.
> 
> CrowdStrike recently hit this in production:
> 
> commit 93e8fd1a565e ("ftrace: Use kallsyms binary search for single-symbol lookup")
> 
> Attaching just 50 kprobe.session programs caused an 858 ms attach
> stall with 25% CPU burned in kallsyms.  That commit routed single-symbol
> libbpf attach directly to kallsyms_lookup_name().  In larger workloads
> (such as the BPF selftest serial_test_kprobe_multi_bench_attach across
> 64,000 symbols), kallsyms_lookup_names() spends ~390 ms in raw CPU spin.
> 
> This series accelerates kallsyms_lookup_names() by 7.0x (from 6,102 ns
> down to 866 ns per lookup), cutting 64k-symbol attach from ~390 ms to
> ~55 ms, by fixing two inner-loop bottlenecks:

Thanks, this is awesome.

> 0. Candidate symbols are fully decompressed into a 512-byte stack buffer
>    before calling strcmp(), even though ~16 of the 17 search steps
>    mismatch at the first differing character (0..N-1, heavily
>    front-loaded toward 0-2).
> 
> 1. Probes scan sequentially from 256:1 markers in kallsyms_names[],
>    decoding an average of 127.5 symbols per probe (~2,170 hops across a
>    17-step search).
> 
> The 3-patch progression:
> 
> 0. Patch 1 introduces kallsyms_strcmp_symbol() to compare ASCII queries
>    against compressed tokens on the fly, bailing out on first mismatch.
>    Drops the 512-byte stack buffer and saves ~530 ns.
> 
> 1. Patch 2 increases marker density from 256:1 to 16:1, cutting average
>    scan distance from 127.5 to 7.5 hops and dropping lookup latency from
>    6,102 ns to 866 ns for +42.2 KiB of .rodata.
> 
> 2. Patch 3 inlines and unrolls get_symbol_seq() 24-bit reconstruction.
> 
> Results (CONFIG_KALLSYMS_SELFTEST across ~184k symbols):
> - Baseline (256:1):  6,102 ns
> - Patch 1 (strcmp):  5,572 ns (-530 ns)
> - Patch 2 (16:1):      866 ns (7.0x faster)
> 
> Trade-offs:
> - .rodata footprint: +42.2 KiB (+10,782 u32 entries for ~184k symbols,
>   ~0.1% of loaded kernel image).

That's the bad news.  Can anything be done to reduce this aspect?

> ---
> Jim Cromie (3):
>       kallsyms: Match compressed tokens on the fly during binary search
>       kallsyms: Increase marker density to 16:1 to accelerate lookups
>       kallsyms: Unroll 24-bit sequence reconstruction in get_symbol_seq()

I'll queue this in mm.git for testing, would prefer not to go further
without third-party review, please.


