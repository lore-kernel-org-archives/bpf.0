Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24338F248
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762370; cv=none; b=CIiyBSaBTIFQdZxzv7+ifbYhL0dsE6nve5FwNkcj0uvcllhXQaWPtVIBu9fIFbwBf/CkTC/s4WwqcPIaX8qTi2zvFHvO5YO3JvQE2efVpWe6EWeDRij2TNc3fd0xLf7SuCPrrqDXlwG3Jt6pCb57L0Rmva99gOVjhA+ymWUzfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762370; c=relaxed/simple;
	bh=7KhnkIJZwa9VGPsdVLI4j84je4HO0c1vdBZ6x2j0PNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFygLF458YakZ4za9eYXAo9nPX1XwcVt32vKekOyVlEm0ZqSqb+fV9Z+IxzSCyXhJV37RnUWvsaMw26ut3238Qgu96KrqTmr41uosw7ozrRkml2rSDTt2T6ogRgHRB8O8uCoOntkQbut2Jk7VlXGLj9b1SA++r92gg9eo3cGl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlDTZAKK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlDTZAKK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso70440055e9.3
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778762367; x=1779367167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkMr90xM0klLW//PAoSL18NWj6plfXzo/wXgPjp1dpA=;
        b=jlDTZAKKg3nS7TTV+GYrj6LR5QY0oWdS3iZ4LESipGQgFGwYWeTS8RkswZbGdUIMg5
         U9YG94jmE9K5/rgG0+0doGaD7cSohYY+kxoR+X89VKShRHPCNObiI4m/2a7NwPL5clA3
         oERIyFIxOioxVbIHMTx08zpkNa4yxFa2GM/jNjNtt7uNr73RHW16BqOd/urW7JZj9nUZ
         bqVYsRwZjXtObHygpvIqb1xCRjg3B8J5TNZmBOBo7PGFM+zaih697AuI6eQCWvlqt9GH
         ngy1b3kkafAzWrlqImz7OEM/FkfHYYtwQK7OyKiLPvewbjd3p+BogDFwtUDZJXEt3Wfw
         R1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762367; x=1779367167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkMr90xM0klLW//PAoSL18NWj6plfXzo/wXgPjp1dpA=;
        b=l1BysXtzRDdkOildw6/Ig4dHn0I1QV1tPKAt2rZ3X4O2gOykMhtsIRdLCmyiN33J4o
         4s78HYvh8D9+XiaNwIdkP+CqUBMnzooGWO5ljINaVTeW3OmWO4DFYuQWAr6JRScqU8oG
         ga2GzHczp6KyomE02cx0zeRjywZLW73GEzIIkCEms5uB62bkPeCvMDGOuEA2PsNT7gVR
         +uSLqtV6bfEhEUhGmHwZ4stS/PF8fct6YX+EEimhzaa0rarfWm6E55dJPGNZEZ42Hcpe
         FlgBZMp8ZlGXsA5oPTSSoA7t8SkmiJ7w/X7/IP4qljsXx300q7vHXpk2l7gcQVYTfAk6
         +G6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/pXL02cxiW5qEkVx4FjV1U3IfNF1/faHADhsGS49uXSxJSX/AzHkQkkPc3SzQAkQ/TvJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVllMR+NGi6/VO55yUCjEhoVUPPlkm5hdCVBTi7B0WxR3NUSa5
	kmYBvAbR8uxElg9Sdzsa5Q3faJrx8oVDevpxE9XHL9B+6C6IY3qM2CH9
X-Gm-Gg: Acq92OGspDfpreF+drgH+aHW78PujwlSXmwAkocmJt2SBFQhyCiv+vyI25gWr1fIK6g
	Fz6pQf8neh3L6FEOgNZoIFQAv43ibKnzoBZYh7eHhc9LoFoJ3LNa1b/Koj4Lu/nwuen9okduoP7
	ZP/IL/+zCWeHtpV4vBdF84mTRRqFNGGpFSyaUnpWHPnJ3bXfwWZV5AtmhwN9ka4iMW4Dj8i15On
	Y6eTT3Vw/C2w4oi7zRkL+Umaz0X88HWm/kWL7LMw9qzBRHUjh2ghXD1K2OrhnVB6DzmCz6RnynB
	ZQg4Jf+xquQfaPHiVObCE4PbYNpPMMvyKQG4gWmirLiOp40VUDlH4d5fI5rhmK6iQGPOKSnqyHl
	u+HFjghayuk1++xUvoX26TWjNHT2R6cnSxO60jDk4/hIdxFzQaLZS2IFS8DAQ32lbL7+csfGG3I
	B1LhRTG93N0zwIyX77xZgAZIOZ/MWynKFGcR36Y1W+N74g84crKsrmLRB4xIsM
X-Received: by 2002:a05:600c:6219:b0:48f:e230:2a1f with SMTP id 5b1f17b1804b1-48fe2302b76mr13360145e9.30.1778762367174;
        Thu, 14 May 2026 05:39:27 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5c5e:8180:a47c:53d9? ([2620:10d:c092:500::4:7c71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6301bd1sm20044205e9.11.2026.05.14.05.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 05:39:25 -0700 (PDT)
Message-ID: <c5130e06-d81e-4511-a5de-1fcbde6674ce@gmail.com>
Date: Thu, 14 May 2026 13:39:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Use array_map_meta_equal for percpu array inner
 map replacement
To: Guannan Wang <wgnbuaa@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, gregkh@linuxfoundation.org, ast@kernel.org,
 andrii@kernel.org, xlabai@tencent.com
References: <20260514074454.77491-1-wgnbuaa@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260514074454.77491-1-wgnbuaa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 8:44 AM, Guannan Wang wrote:
> percpu_array_map_ops.map_meta_equal points to the generic
> bpf_map_meta_equal(), which does not compare max_entries.  When a
> percpu array serves as an inner map, replacing it with one that has
> fewer max_entries bypasses the check.  Since percpu_array_map_gen_lookup()
> inlines the original template's index_mask as a JIT immediate, a lookup
> on the replacement map can access pptrs[] out of bounds.
> 
> Point percpu_array_map_ops.map_meta_equal to array_map_meta_equal(),
> which already enforces the max_entries equality check.
> 
> Add a selftest to verify that replacing a percpu array inner map with
> a differently-sized one is rejected.
> 
> Fixes: db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps")
> Signed-off-by: Guannan Wang <wgnbuaa@gmail.com>
> ---
>  kernel/bpf/arraymap.c                         |  2 +-
>  .../bpf/prog_tests/percpu_array_inner_map.c   | 57 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 5e25e0353..dfb2110ab 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -827,7 +827,7 @@ const struct bpf_map_ops array_map_ops = {
>  };
>  
>  const struct bpf_map_ops percpu_array_map_ops = {
> -	.map_meta_equal = bpf_map_meta_equal,
> +	.map_meta_equal = array_map_meta_equal,

It looks like the patch f4d05259213ff ("bpf: Add map_meta_equal map ops")
introduced map_meta_equal op and set bpf_map_meta_equal for percpu_array_map_ops,
correct at that time.

But as db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps")
introduced inlined lookup that uses max_elements, the map_meta_equal should have
been aligned to check for that.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  	.map_alloc_check = array_map_alloc_check,
>  	.map_alloc = array_map_alloc,
>  	.map_free = array_map_free,
> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c b/tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c
> new file mode 100644
> index 000000000..2a8b23813
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +/*
> + * Test that replacing an inner percpu array map with one that has different
> + * max_entries is rejected.  percpu_array_map_gen_lookup() inlines the
> + * template's index_mask, so allowing a smaller replacement would cause OOB.
> + */
> +void test_percpu_array_inner_map(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	int outer_fd, tmpl_fd, good_fd, bad_fd, err;
> +	int zero = 0;
> +
> +	/* Create template: percpu array with 8 entries */
> +	tmpl_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "tmpl",
> +				 sizeof(int), sizeof(long), 8, NULL);
> +	if (!ASSERT_OK_FD(tmpl_fd, "create_tmpl"))
> +		return;
> +
> +	/* Create outer array-of-maps using template */
> +	opts.inner_map_fd = tmpl_fd;
> +	outer_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "outer",
> +				  sizeof(int), sizeof(int), 1, &opts);
> +	if (!ASSERT_OK_FD(outer_fd, "create_outer"))
> +		goto close_tmpl;
> +
> +	/* Insert template as initial inner map */
> +	err = bpf_map_update_elem(outer_fd, &zero, &tmpl_fd, 0);
> +	if (!ASSERT_OK(err, "insert_tmpl"))
> +		goto close_outer;
> +
> +	/* Replacement with same max_entries should succeed */
> +	good_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "good",
> +				 sizeof(int), sizeof(long), 8, NULL);
> +	if (!ASSERT_OK_FD(good_fd, "create_good"))
> +		goto close_outer;
> +
> +	err = bpf_map_update_elem(outer_fd, &zero, &good_fd, 0);
> +	ASSERT_OK(err, "replace_same_max_entries");
> +	close(good_fd);
> +
> +	/* Replacement with fewer max_entries must fail */
> +	bad_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "bad",
> +				sizeof(int), sizeof(long), 2, NULL);
> +	if (!ASSERT_OK_FD(bad_fd, "create_bad"))
> +		goto close_outer;
> +
> +	err = bpf_map_update_elem(outer_fd, &zero, &bad_fd, 0);
> +	ASSERT_ERR(err, "replace_smaller_max_entries");
> +	close(bad_fd);
> +
> +close_outer:
> +	close(outer_fd);
> +close_tmpl:
> +	close(tmpl_fd);
> +}

