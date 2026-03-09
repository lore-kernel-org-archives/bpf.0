Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024F26E709
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030511; cv=none; b=N/oBnkNNSvM2Y6HKHm1SQs83DLAbVJiGQSlveQF/DZPCpuN77W2waruuj3Yn1LRVME2sBJxr2OCxIR02D5WtnWywyQOrhCpP0ykoZwsUFytHC7zHF3hi/Wd1vf1NnvhjmhRNm1b1grEaF4sxMW8pT9wTnPT+nZ5IERK/8KO2uSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030511; c=relaxed/simple;
	bh=CpHNRn9ClhXHnFLwswm0BL2sJ4mN12oQ3+j2i82LUEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg0gVhEAfs7WaeukpUlSCVrn195bfMZUXIg0eSh/NuV/gaMQh7Kqr/QW30E0q3yABYuw8xs5uM6zV8KfZ0aDwJouson+83rfFM7qgYKefgw30CEMtZEoVD35Wb1PZ4LXacZ2PPt+Ej8aZeHIbPVq3TH08cQV6SuGuoFtDfwzMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YQTK/fhB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YQTK/fhB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so6334375e9.2
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773030508; x=1773635308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=piCeylkqyHEQATfBmT/NFsXYPAtqgoki2CUunrgONSQ=;
        b=YQTK/fhBq052II4/70/9Jb9wYA7MBeVLJ3PxWZWslBg5dPFNP3vdkUL/26Vj68jUL9
         3c2MCST6AYeXWkvTOE5WRPyQ5u2GOpQh5FMDcwQMuQp40q6P/Hiq5/F3snyV+HnwTrBE
         HYLivooh19IZsL2EXy8NBSL/5/1CH2P1d+CNqHVbr+YFgW0Hr9qDX4ZpfMQx4Tmt7tov
         HjJOt8+LUafVv3mi7j40ILEWRUWk/t9Fp8e4BKjarex56QbHoqGqcpNIcEqXgbyKV2ul
         sumlCw5ixOkqUNtABCN993Tb3NupFvcpCOj9Ud8XuwxzLp36d9zuwnf/xdswcIgy05/q
         DWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773030508; x=1773635308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piCeylkqyHEQATfBmT/NFsXYPAtqgoki2CUunrgONSQ=;
        b=CYMcL4ulb0KBVz3XtM198kby4pIn/PCMKa/xk9lVk5Px18Abbabe1G0iDc9v/p3Y+Y
         pT6tIhiptbEU/jz5/9ApCAZDbOwrn2XNCBITaDkBR3c3W19YH6EpMW+3Q0xwrDxI57iS
         hO66tl5QwpHyKyDaThiOKU1zG20/dICFoK7vF5vvgn6IXROjlA9zJJXfrsX9Kw/oCTQ0
         Oex+w8f57NLjk1si2hwamGpZgjHS9NwP/N2WwdUr4Mdj7FqosT9LkeHTQLjbJ7FvFJrw
         cpatHv5G0GFUMikJDKIgNdTvvuG9MNw8zLELmYNH++e9PR6HKkrWdv95TojPcpLA7RH0
         kYqg==
X-Forwarded-Encrypted: i=1; AJvYcCViz3Pu+QrCgalL8P67Ml2kNbHXFx9CUmIbgimS0Hu2Ir0RBTSqgj7bwP7CUMW9ajmGPuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+0H9Eu7adzkGCeWWOahdrVN3KC6mf6t+NXGjfUFjMtq/GLKi
	xcDSKEVxjnLqfTo2ynvHBWtpBDZgZc/Kuvp/prqok42wmOfNTGCbXsZ2j69M6Ox1N4o=
X-Gm-Gg: ATEYQzw2pYex35rUTjg11sk9yX2lDqb/jucpub05+48JlWJ4BFONt1WhfuAOiiGu8Hy
	U0zIyDDwBiW65BdNTS2DpHB2WAbBlWza+41G3klWPxWhrCfYkCO3H5hazFnrE56hnLivkR3DRpJ
	HZ/Hk7D1u3UXoAcX7iBdey75e5j19So6RaIZyk47BHqpdVWhoEtQXJe51vAsAjToprZVbKO348p
	arxYAoDP1yQwtHzt5hxHdaDrml1VF8JIQwIHvPCXhQWc/LErP7Tr4ZPm18xLql0wit8XAg8b7t5
	ty9fg/u7W/ER8v+2b7MfQ29FnJ37PutczjjBxafTosWp8ePvzXwDhSJDvlctadBKRE1DqRvv/sY
	nR19xkx6bBx//eNx1x+m5aSArrmsjVq1EQOkQbkXBOn1HbYskvbCe+mHHVm71icYNlV/QC4gm1m
	YoodsmukiRbrUP65uyVw==
X-Received: by 2002:a05:600c:1c29:b0:485:3e00:9452 with SMTP id 5b1f17b1804b1-4853e009514mr10032265e9.24.1773030508005;
        Sun, 08 Mar 2026 21:28:28 -0700 (PDT)
Received: from u94a ([2401:e180:8d01:1fb3:e42c:360:78fd:1fec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc9d4392sm4531346a91.4.2026.03.08.21.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:28:26 -0700 (PDT)
Date: Mon, 9 Mar 2026 12:28:20 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <bnc3dzuokotxhgeurxymf5hfsfr6q7fbzvbjdixlz7z5chz646@lkdfozc4ldcp>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
 <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
 <ff92fa059a5f5427fec24be6758afa033ee43af2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff92fa059a5f5427fec24be6758afa033ee43af2.camel@gmail.com>

On Thu, Mar 05, 2026 at 03:10:00AM -0800, Eduard Zingerman wrote:
> On Thu, 2026-03-05 at 14:54 +0800, Shung-Hsi Yu wrote:
> > On Wed, Mar 04, 2026 at 04:48:43PM -0800, Ihor Solodrai wrote:
[...]
> > > Side note: you might be interested to know that Eduard is working on
> > > consolidating signed and unsigned domains [1].
> > 
> > \o/
> > 
> > When I last look into this[1] there's was the "Interval Analysis and
> > Machine Arithmetic: Why Signedness Ignorance Is Bliss" paper[2] that
> > looks rather promising. And lately there was also "Program Analysis
> > Combining Generalized Bit-Level and Word-Level Abstractions"[3] (haven't
> > read) that seems more specific to BPF verifier.
> 
> Thank you for the links, I've only seen [1].
> I was about to send [a], feeling really smug about cbmc tests.
> But then a much simpler solution [b] occurred when figuring out why
> 64-bit test can't be written.
> 
> I'll probably continue playing with cnums at leisure pace.

LGTM, I like the cnum name, and cnum_intersect returning the more
precise of the two looks just like what should be done, I wasn't able to
figure that out.

I do hope the cbmc tests could make it into the kernel codebase, too[2].
srcu used to do that, but it got removed some time ago.

I was able to ask Paul McKenney asked about the removal back at LPC
2025, and IIRC the problem wasn't with cbmc itself[1], but rather the
code-extraction script wasn't able to keep up with the source code. I
think that should be less of problem for cnum.

1: It was mentioned cbmc would take a very long time to run for complex
   code, which is innate to anything SAT/SMT-based
2: Elephant in the room being -- Agni already doing very well; but being
   able to write these kinds of tests with just C still seems benefitial

> [a] https://github.com/eddyz87/bpf/tree/cnum-sync-bounds
> [b] https://github.com/eddyz87/bpf/tree/32-bit-range-overflow
