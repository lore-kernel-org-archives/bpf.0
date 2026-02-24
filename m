Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6937D11B
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938742; cv=none; b=CO2Jylvt1533Uu89HK4Fqe2l+bTj6wsIiVqSCI3XywiqiKHb3+RlqgnuSif4EbTEG2Ct2PG3m7IzAs+vHyPGE8grHKCiQmnfPykWUlvXsvk01sOdOSj2CQt2vPq5h053GeBfV5ElR6py5rvh1C0Z+8OAG/n4cfSfBgptzIbDho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938742; c=relaxed/simple;
	bh=cdIly0vAT8ublrU8eHTrgYHCsMW1WnW9wyEyab7AKG4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngNYJZf+615qWwDwF6Ja0VvezJQW4FyxLJU0TthEjp6TvWmrku/0+iKvg/rTrIzeRwJMQLCxnp6UCDyG6FORQL7xkVU/Nh0KjdwXAaCHt8xljUaIXvmN2ZJO+mYlvSMMiriyRWUeH25614N9d40au04wCgfbJau6+R3oFN2OM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml7MZ7Za; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml7MZ7Za"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48069a48629so56500215e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 05:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938739; x=1772543539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2FgcbIbzhcMcTglC96arKp5lanpIvh4ZU7tb8HuFqc=;
        b=ml7MZ7ZahM6OzDn+iT2R/hqsn0uXIhp7CiWOwmQN0enJUKXTRllSJKKyxPoFKEzNa3
         qrXt9JUsF90NN5X62Ri7FVEOAU2ZFDVk4EHHVgKF5cG2fSA+ZzrarCr/+wxej9KoXBlC
         NPq1wZXyd8rH/VgbhWpoH5RAWJaI9vg1jPOIf+TRxvBmOl8E+3Y0e4ERCIF4SjI9b3S7
         v54mCrLcicNf5iGLMmDcMHVAQ4Yo9ZhnZ/TX/KJ7+Z14SQBbGWq4YqaAzhjzXVj2Kjv7
         mTCRgrKZFShstA0XhPP9i6FoNnyRneuGNqvqjEOX01uNeXv5FmHPF25lUEelREApBQ39
         dcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938739; x=1772543539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2FgcbIbzhcMcTglC96arKp5lanpIvh4ZU7tb8HuFqc=;
        b=HY47gAf0dUUUvwhglgH+NVQeiJf5apGafC5NjIUS/1kWofrnT6A2NuGB8Lq/TTf4J2
         eXD86h0SiHdvKEBP8tNK39Ky+wNN71v3quQTvEoOm7U5ph+/esX9St/XReBYWfeR0qH1
         EIPuh4U0FhoD8O4U5knhuvRxVqe+qnJI1ArHtghmeldAJ8mvfYAkIc0gmK7Mrb8gkI0S
         PdiXkP/etB7YCzNojhmp+XqnNtAV+XIpaY4TgKkfeC7uAlagIOTJSiJicmDV65jEKKtq
         uV6iOGeEpPfDh22Y9A+lTT7JmCcfA/N6UPHCBqLRtbClF+C32RzdQYuFk7wZJDN4iN0l
         Y2lA==
X-Gm-Message-State: AOJu0Yy8Yh4ay2OAl3HBPtfO4RXXZh2GgmWycPknQqUatcMJqDoSVXyM
	mVbuFKjakUDJfaJWZj1vaLVWyRRL3HsxAUhyimlk7XcWAmiq5omB8onT
X-Gm-Gg: AZuq6aL4KqSRRKaE2nlbPqeIEkm+LNR1JJPv6S19gx7k+n54epZ1mxofeB8MUdX4XYU
	TzRim4gb37TbDw2IecbjgXN2F9S1GKgN2Dsznj9v0z8uPFBb2zNx2RnZL8sjhfjt2HrRv7SZDnD
	nrrb8LMaZS4h34U5fJIuBHEtnxqzOLaQzFnvIUZsArkYOUFwysAGopxgQDTne3dK6p5xVmi/DrG
	hGKMJxKK60Zi5Ky5OS6WIWtbA2YqDDKaOEpqaBcKvt2ryNSHvYEPxHUm/I1Du4sXcYPNJveonxr
	rFya78aKWeSEy4xUGHcdx1tfaUBxpVF+16MvXiYkVZiXhg2+8dN3YaQLjzeQCkXWAvotQBf7SKd
	Hu4ZvPpY++V/q2EFRLo6LtAFZP5BgYdbdHQl19a2x7oCUN35tXxC2xWY35ugyru8fkxTagj0c
X-Received: by 2002:a05:600c:a418:b0:483:b3d7:2e80 with SMTP id 5b1f17b1804b1-483b3d72f30mr83552035e9.33.1771938739030;
        Tue, 24 Feb 2026 05:12:19 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm290470575e9.13.2026.02.24.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:12:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Feb 2026 14:12:16 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms binary search for
 single-symbol lookup
Message-ID: <aZ2jsL0Tzdno_ZvD@krava>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>

On Mon, Feb 23, 2026 at 04:51:12PM -0500, Andrey Grodzovsky wrote:
> When ftrace_lookup_symbols() is called with a single symbol (cnt == 1),
> use kallsyms_lookup_name() for O(log N) binary search instead of the
> full linear scan via kallsyms_on_each_symbol().
> 
> ftrace_lookup_symbols() was designed for batch resolution of many
> symbols in a single pass.  For large cnt this is efficient: a single
> O(N) walk over all symbols with O(log cnt) binary search into the
> sorted input array.  But for cnt == 1 it still decompresses all ~200K
> kernel symbols only to match one.
> 
> kallsyms_lookup_name() uses the sorted kallsyms index and needs only
> ~17 decompressions for a single lookup.
> 
> This is the common path for kprobe.session with exact function names,
> where libbpf sends one symbol per BPF_LINK_CREATE syscall.
> 
> If binary lookup fails (duplicate symbol names where the first match
> is not ftrace-instrumented, or module symbols), the function falls
> through to the existing linear scan path.
> 
> Before (cnt=1, 50 kprobe.session programs):
>   Attach: 858 ms  (kallsyms_expand_symbol 25% of CPU)
> 
> After:
>   Attach:  52 ms  (16x faster)
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  kernel/trace/ftrace.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 827fb9a0bf0d..bfd7670669c2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -9263,6 +9263,19 @@ static int kallsyms_callback(void *data, const char *name, unsigned long addr)
>   * @addrs array, which needs to be big enough to store at least @cnt
>   * addresses.
>   *
> + * For a single symbol (cnt == 1), uses kallsyms_lookup_name() which
> + * performs an O(log N) binary search via the sorted kallsyms index.
> + * This avoids the full O(N) linear scan over all kernel symbols that
> + * the multi-symbol path requires.
> + *
> + * For multiple symbols, uses a single-pass linear scan via
> + * kallsyms_on_each_symbol() with binary search into the sorted input
> + * array.  While individual lookups are O(log N), doing K lookups
> + * totals O(K * log N) which loses to a single sequential O(N) pass
> + * at scale due to cache-friendly memory access patterns of the linear
> + * walk.  Empirical testing shows the linear scan is faster for batch
> + * lookups even well below 10K symbols.
> + *
>   * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
>   */
>  int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
> @@ -9270,6 +9283,21 @@ int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *a
>  	struct kallsyms_data args;
>  	int found_all;
>  
> +	/* Fast path: single symbol uses O(log N) binary search */
> +	if (cnt == 1) {
> +		addrs[0] = kallsyms_lookup_name(sorted_syms[0]);
> +		if (addrs[0])
> +			addrs[0] = ftrace_location(addrs[0]);

the kallsyms_callback callback code does not take the address
from ftrace_location, just checks it exists .. I think it is
done later in the fprobe layer .. let's keep it the same

jirka

> +		if (addrs[0])
> +			return 0;
> +		/*
> +		 * Binary lookup can fail for duplicate symbol names
> +		 * where the first match is not ftrace-instrumented,
> +		 * or for module symbols.  Retry with linear scan.
> +		 */
> +	}
> +
> +	/* Batch path: single-pass O(N) linear scan */
>  	memset(addrs, 0, sizeof(*addrs) * cnt);
>  	args.addrs = addrs;
>  	args.syms = sorted_syms;
> -- 
> 2.34.1
> 
