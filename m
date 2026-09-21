Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374949363E
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992021; cv=none; b=Ys8lpBp5xwdCcQ4OVg2hH8mka2wrdiwhoBrujGMfoopG3T4lyyT5obypKwKXGmAPI6q0Xyxqu63lBVXEzbTBNPsEer/NrbniZKX2mAb84Dt4xlpT38FHeOD7vS9pkx9I08frfI5vCY2urILw+DIs9b3Ow2zrfdBhe/mmMM+Yw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992021; c=relaxed/simple;
	bh=HgscCTdIhqbObj5IdkVWP+i1xbMxe2IH9fAHraLgLyM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOSzo7s0guwfEI3qSIf4tXjwB5btCwySNxSTepDnhMKAB2QaGeKMhC5zR3rxP+gjBEp1lvDmy9CmKctfM3ccw1fvLBOpy75uZ6aKG5Sq/u/Re43VzZvbw3wC0ikhUvAq+xQRDJJFupuCQyU/egQLTpK1FnaNIwCkIEv3qV3suk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCLcEXhc; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCLcEXhc"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dc83so2056865f8f.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789992018; x=1790596818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QA57d0MWfONjf/OW7F8GGaeRDnISGbQSvosg5yrwN8E=;
        b=aCLcEXhcAcbruGw8fngH97iYAZg4T/nAdF6IhqfxlkoUZFCgLUMZL6FZL2CQDxD3p5
         +d1s0Rt0Q4+SujN76o8o74w1oCyA7y1WFwY77LkyB417b4Y+lpTMBNBnXs5LWveJTP+U
         Yb4r93f3aJHuqi8xtHFcNmzcMfX00ieRXSHaCg5aBTO+Hzy1HCFpU+P0NPLYZ/CBuG13
         tfdVQX+Zy52TI36f20hVDPctyfHG7NoDwU/1A/AbuNniPzHPEqguKCvbKEb4HPElzWwo
         F9uQ7PBfe6qI0xaWFD74tAutuJ00cbXyKqTqwZcziq9603v6nzthLOsWmfQ4LBz1riDw
         PgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992018; x=1790596818;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QA57d0MWfONjf/OW7F8GGaeRDnISGbQSvosg5yrwN8E=;
        b=TV0UwHq69ovuS5+kVVXe0DuLekt5kKdsbSwWJyE+L9wx9BYzfmXDHZH0E9wO/CdEHb
         lV44y+Zz0s7ItutP4IEXBs+XloJRFovJEswNEKIki/vVQM/v8So6MoaTK/dDhWZ+brxl
         nrLQTkIbaMtQ5wutEiaNc6WuvnCfnaN2mZvM7YGY18e2Tgrs1/FyLCNmT3U4EWf6ssb5
         M6SS3m4ayyQW2Jvcedki7LVlCjt5Xh/zN42r5GVLKqn3aJurWQgsJ9MykmAhJpiE8meP
         SK5uyy4mzqcJWI58mnXxqSVtKo7a+ZYtc7bbIb50qh5sA9fkhMkJUb9ZgyvanQG8Ucs0
         aJnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxflqEQuL0zH/lQk0a4/qwBRKkYPzUykGR3fzRyY1lfDTHStXtanUmnMzHlgW0RsPmXu7g=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ7cIJ+csXbNiCgA5vvrLAnq0wduh1Upr5XJqUzUFY5JtudHvQ
	/doPsDRctlTcYu3svXXL428rATmlBwcrD/MmZkCdfV43AXKwVMSNNUEoCcu0sA==
X-Gm-Gg: AYBFou3f/G/KEre/jS9DQpL5UNjH+kSOA2halKgvfSXC5cyfYJLiB11RyFFvevPYZJ2
	UEJ4I6XyFQSeFoEFgJcisUaInWCIV7Jfdfzys0bLKOj6kb6s0SasgaICe3Z0wWXnigAZNst8KQz
	Wc7A+VU5w7Nb677OkCFjpvw2rNerRQuAhKnPTOTBoljV97JQOrb2RxRupIFX00tHLxlmdCW8e+i
	VbDQES5gWRCltuEbQDMNWVhwfyVx4uEddAd+hQmHDAjtAEDejMvc6THEw2SnyVrbdMyPtS4hHeP
	BwoFcE2Dl5HO4/HY9bIIUuPFQDWekI7FRk7T0usMDhhkdQeGvHxgeSb/JAWYIbi7IjE2gJ1LXFa
	opH9q++xTwhCpsyanV4w+l+3y2rMhqaeMkREEnIE3LtB15plyC9+qNJA8GmuqVKXfBxAuD1FOI/
	4tPmo5K7cL+4i079FoLYy1hhlmhmE2iJMNlb2EtDnfGzd2U5YRVQoDJxPas0GVxzqTr7DV
X-Received: by 2002:a05:6000:18a9:b0:486:fe41:804d with SMTP id ffacd0b85a97d-4871e3b6a68mr15005637f8f.47.1789992018016;
        Mon, 21 Sep 2026 05:00:18 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245a58a0sm20252895f8f.36.2026.09.21.05.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:00:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Sep 2026 14:00:15 +0200
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/3] kallsyms: Accelerate symbol name lookups by ~19x
Message-ID: <arEcT1iyMl0tFiIJ@krava>
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

nice, fyi I checked on tracing_multi benchmark and got bit of
speedup as well

before:

serial_test_tracing_multi_bench_attach: found 64021 functions
serial_test_tracing_multi_bench_attach: attached in   2.884s
serial_test_tracing_multi_bench_attach: detached in   1.149s

    16,515,655,329      cycles:k
    41,935,382,635      instructions:k

after:

serial_test_tracing_multi_bench_attach: found 64021 functions
serial_test_tracing_multi_bench_attach: attached in   2.633s
serial_test_tracing_multi_bench_attach: detached in   1.159s
#558     tracing_multi_bench_attach:OK

    15,880,929,751      cycles:k
    40,444,002,354      instructions:k

we call kallsyms_lookup_name for each attached symbol

jirka


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
> 
