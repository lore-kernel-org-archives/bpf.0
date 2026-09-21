Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC9431A5C;
	Mon, 21 Sep 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001973; cv=none; b=ipi3eiFymi1jweqWMshMwZ8NT3zs4Nmmn/JZZupE4kDy8ljiwo0X7pz9GGNqkKVs/5WdFxykWrn+0wXCGoZCg/q3em6DplDjwQ0NBCO20S0ug0FIetrzkmELBUaZnbuat8bjhg4vFT4OdxAw47n6Gxnvkff302k+h5QEhqsi22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001973; c=relaxed/simple;
	bh=nJLo/44+0JxW1XOZPveJcKhKQD+oXnp0CA/WkoFZi8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbVwwVcTBuGCLabSmhav1031b+SdKyDVgpV0wYgFcUjvYFJpjqaRlwp9H/u6jQbTZuKZqiK5I9bQpZmDC3/iYzn8BQ2Ivj6MjWFD34rJnudv9BIePPIl6biT4l3pDU3GshT8/ArmoT1848ePW57XXOH2nbc54/tpRkYK2YoRkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvey1svP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvey1svP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3051F000FF;
	Mon, 21 Sep 2026 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001971;
	bh=cKAY1MBxmdFm0Jqck0uZa6a3w9YCct6jV14FzTNbW2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vvey1svPShdVeOu17JO6My8rtY0TtlW4MIf9ycdxocSnP7zZvzXdqmnFLQQaDFMRg
	 HLz47UBOqD29yLh9zkDXxsuRJTIVumfIq+FuSPRJlLUD44fXKQ1EPSrZVWFm4ueFxF
	 fHiVBPOB12cFeVfftHKY7UJdVHHyVLZV60dzH5jgjD6etoHwe6R1AWLjUil65aOMsB
	 NdGKELnbJXGZ6qEwALv2sAsJpaQzlF4Jq0xaga6/aRMCxSmr821uae1P3GiSv/3ogv
	 RXL/DDh3TXCtsg/8qI2pzQXfGUDdq3MSylr8/poru7xdZzS/i4GKq/2buqUn4w3RBu
	 Utt3mjQp7u0bA==
Date: Mon, 21 Sep 2026 15:46:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/3] kallsyms: Accelerate symbol name lookups by ~19x
Message-ID: <arFARZCoVOYzrbTs@gremlin>
References: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>

On Sat, Sep 19, 2026 at 09:58:54PM -0600, Jim Cromie wrote:
> kallsyms_lookup_names() resolves symbol names to addresses using a
> 17-step binary search over kallsyms_names[] (~191k symbols on x86_64).
> At each step of the search, two bottlenecks compound to create
> substantial lookup latency:
>
> 0. Marker scanning: get_symbol_offset() scans sequentially from the
>    nearest 256-symbol marker, decoding an average of ~128 ULEB128 record
>    headers per probe (~2,176 header decodes per lookup).
>
> 1. Redundant string expansion: kallsyms_expand_symbol() decompresses
>    the entire candidate symbol into a 512-byte stack buffer (namebuf)
>    before calling strcmp(), even though ~94% of binary search probes
>    mismatch on the first 1-2 characters.
>
> Together, these bottlenecks impose a ~4.3 us latency penalty per hit and
> ~3.8 us per miss.
>
> This 3-patch series eliminates both overheads while keeping the symbol
> table strictly in sequential address order:
>
> 0. Patch 1 adds lib/test_kallsyms_perf.ko, a microbenchmark module to
>    measure name hits, name misses, sprint_symbol(), and table iteration
>    latency, with built-in correctness validation and a sysfs trigger.
>
> 1. Patch 2 introduces kallsyms_names_offsets, a build-time 3-byte direct
>    index into kallsyms_names[].  This turns get_symbol_offset() into an
>    O(1) table lookup, dropping the ~2,176 marker hops per lookup and
>    eliminating the legacy kallsyms_markers[] table.
>
> 2. Patch 3 introduces kallsyms_strcmp_symbol() to compare ASCII queries
>    against compressed tokens incrementally on the fly, bailing out on
>    the first mismatched character without expanding subsequent tokens.
>    This drops the 512-byte namebuf buffer from the kernel stack.
>
> Context & Lineage:
>
> This series was originally developed and benchmarked on mainline (v7.3-rc3).
> To ensure compatibility with Lorenzo Stoakes' kbuild speedup series (v3),
> it has been rebased on top of commit c1c0fd58e281 ("kbuild: compress the
> kernel with pigz if available").
>
> Rebasing required only a trivial mechanical fix in scripts/kallsyms.c to
> align Patch 2 ("Add 3-byte index into compressed symbols") with Lorenzo's
> direct binary streaming path (write_incbin).
>
> Glomming onto Lorenzo's build-time acceleration push extends the speedup
> theme into runtime: his series speeds up the compile and link, and this
> series speeds up runtime symbol lookups by ~18x.
>
> Live Microbenchmark Results (via test_kallsyms_perf, 100k iters):
>
> Metric                    Baseline      Patched       Speedup
> -----------------------------------------------------------------
> Name Search Hit           4,370 ns      247 ns        17.7x
> Name Search Miss          3,860 ns      195 ns        19.8x
> sprint_symbol               440 ns      441 ns        parity
> sprint_symbol_no_offset     315 ns      307 ns        parity
> Table Full Walk           14,500 us   14,437 us       parity
>
> Address-to-name resolution (sprint_symbol) and sequential table walks
> (/proc/kallsyms) remain completely unaffected, maintaining full L1/L2
> hardware prefetching.
>
> Hardware PMU Event Counters (perf stat via sysfs run_test trigger):
>
> $ perf stat -e cycles,instructions,branches,branch-misses,cache-misses \
>     sh -c 'echo 1 > /sys/module/test_kallsyms_perf/parameters/run_test'
>
> Counter                 Baseline          Patched           Delta
> ------------------------------------------------------------------------
> Wall-clock elapsed      1.746 s           0.852 s           -51.2%
> CPU cycles              7,320,048,030     3,628,523,081     -50.4%
> Instructions            9,943,172,792     5,034,260,318     -49.4%
> Branches                2,391,663,821     1,173,258,010     -51.0%
> Branch-misses             117,241,513        99,805,938     -14.9%
> Cache-misses               84,996,149           731,025     -99.1%
>
> Dropping marker scans and avoiding redundant string expansions cuts
> 4.91 billion instructions (-49.4%) and drops 84.2 million cache misses
> (-99.1%) across the test workload.
>
> Memory footprint: +573 KiB .rodata for kallsyms_names_offsets (191k
> symbols * 3 bytes on x86_64 defconfig), minus ~2 KiB from dropping
> kallsyms_markers[].
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

All very nice :)

I'm glad this work seems to be inspiring other work in the same area! I think
there's a load of improvements to be had across the board.

I will try to have a look through through though my workload is crazy
lately and the build stuff is often taking chunks of the weekend so not
sure if I'll have time, but I did at least want to say - awesome :)

> ---
> Jim Cromie (3):
>       kallsyms: Add test_kallsyms_perf module to benchmark lookup latency
>       kallsyms: Add 3-byte index into compressed symbols to replace marker scans
>       kallsyms: Match compressed tokens on the fly during binary search
>
>  kernel/kallsyms.c          | 138 ++++++++++++++-------------
>  kernel/kallsyms_internal.h |   2 +-
>  lib/Kconfig.debug          |  10 ++
>  lib/Makefile               |   1 +
>  lib/test_kallsyms_perf.c   | 228 +++++++++++++++++++++++++++++++++++++++++++++
>  scripts/kallsyms.c         |  30 +++---
>  6 files changed, 322 insertions(+), 87 deletions(-)
> ---
> base-commit: c1c0fd58e28143fd10071f51f4dcc8249a331513
> change-id: 20260919-ksyms-tune-e22a42d8a31a
>
> Best regards,
> --
> Jim Cromie <jim.cromie@gmail.com>
>

--
Cheers, Lorenzo
