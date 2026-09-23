Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283413E5EF8
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157660; cv=none; b=tIsIfXphl22E+VGOkNie117iLlsjqq5xOEnil3sw6Xq7SPPI+MRNJYJwHj5ekR+NnHoAjK/GHe+jZZqCBrNaZb2NCJsk0l7HnEBpGdTniQI3JaoIyoLvOydh+MWLnb1iz6mXf4jRDn8QZVEbrCPB5hv+uk+gNS4y+MDDuVSqMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157660; c=relaxed/simple;
	bh=oTk8GgJpcL7X2Re/WTHsnTdZbBvC9y1AJTi7eZ9DNRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ul02Tbi5aZbBGBDxwiwo1Jn6stT6ak/uEtz7b6CMZelHSo9jcP+t6pg2BpSmhgDyy2RGPKdQqc23Dkbti116evcx9Y3VUQRKflVtqy9LlALZ0wfnmTX6stXsYbtH35mFJMGh+jiMXDN7ff8OiP72gi5M55d9f73Dg2mP6I7p81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf8F2THf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf8F2THf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so4699075e9.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790157657; x=1790762457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHDUEFfxohimVHdfCFbRXJJKOl1Ph3G5rHaAn0HkVG4=;
        b=Zf8F2THfX9Mz8A37HLhhIAV/StcamcTnkMz0RkS9uw3F8RgroZuUSjLd2yeWSG/9ej
         xOfvM34WIAeLrvBeGBmTr/I3NAvCBLkUgjhHu+OPS9qUw8/tZRrqabSQOeb5m8WgBjSg
         xG8Bk76D1L1Nz+4aol6WVCuy9t1lePugVw4j1a/GqwqhuJ7Cfuxb5kGZlI7izs4NbF/v
         Ct5E3xxx3NPbh0mDU0odmOuS0PICI/3w+91LU6e3wigvLfUTjRUsDePddAwrppiQ0/qW
         CTXQwht0OcsLQjf21Xi1WXx1oLJ7r1PUPTwp0KeVct7jnGx9i1zw2WQ64tV/kYvQWmcd
         RJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157657; x=1790762457;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHDUEFfxohimVHdfCFbRXJJKOl1Ph3G5rHaAn0HkVG4=;
        b=t6xS/LoPYgUkTbIXZSEEMtuPvftOLk1O0d5/Uu9FXBVXxYqSV+RTGs3Ne7Cx6DzFYD
         CW6GIWD2bb1AY3LANUki1r2vlUczb9wYu7co7YZgIv+FObzoATpQx9PcFsqG0Elp3uV9
         EcrlKCGw0Da4L1z3q/lcGzjHsEWBgkkjPaHG7TPeDsa84soR98hot9cgRdh3ednTAyEP
         dPqtVDVIDN6wx2OeuFowoUm7RqFhVZj4UEHcGW3aTz06tirxkCyeLXLaR5RgvBfHjib6
         7VnRNUDcHVYUFx0KTb4VelQP2sByU/Ob77wjyFVZmYO76Wo0Hcb4l0P7c+vRP31a6jHk
         lp3A==
X-Forwarded-Encrypted: i=1; AKwUvBzWWUYZm9vcuEpkPOHjMeYZDdP/BoVR429peL4ZGw3ZX5/EYwrJCoToPxSprjsJGwxMC6M=@vger.kernel.org
X-Gm-Message-State: AFuF++mpM4aCxojCPmojsTSQ+k/jPGEcttvxJ0nYeeVGeqHEIWUQ+2Iu
	1XdPSSXhC4PjguXE6zJ7nZM4owu/mxEQtHx/xqY/Nn6s8NydDurNXZUH
X-Gm-Gg: AYBFou059cvq3FAHeElh+o+o4jWkuuKZ/7m51aJRjKSsM3yocc9MFgIwdA5RZVocBxD
	HR3rXCG3wViFWzmoIBXgbM7PjKI9W7qVe0Y7S523sk+Qjqy7mb3ONzApqmvs2HmGB85BSPc7497
	5eMyGSiCC7/kC+8QzjXN3Hd94Y/KyNisa4Jih/sORjWdZvh0auW9NVVeG9A84+Xrnbx25uQogh0
	F/u3b6ryq3YDzJM/2l3M1Tyb3iNXWlZoPRfmelurjZ1+7MplEy9+WDdRuf26DGOiuN/mqNxXBC+
	h2kutlcTAkYDDcApJf6HJZNTMRLIR2hL94T4CJCgUIH6gxQjYqffnjNoTwMGEROj8qK1W1TEfVg
	nm5oO4sLBpamTD8aR8CtZrEAcvZ/qcXEeVBnrO/guKyFqo26wbZ/eKSOsAhdbO0IA3SsZYe3RhD
	csIw9nm2dh2j/ossuKYEdh9bxfrReCzl+yzgrabZUraiOl9xtGFSxLfceWHuTKkq5s4ivtTzJnh
	XsTOhf5/ucY5y+2tdwLAVVcBAL/6qNO3crgAZizPFvcPw==
X-Received: by 2002:a05:600c:354e:b0:49e:6bc7:4e1b with SMTP id 5b1f17b1804b1-49fdf0ffe67mr26722025e9.15.1790157657142;
        Wed, 23 Sep 2026 03:00:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1d978fsm58369565e9.9.2026.09.23.03.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:00:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:00:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, Masahiro
 Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 0/4] kallsyms: Accelerate symbol name lookups by ~19x
Message-ID: <20260923110054.1fc07e18@pumpkin>
In-Reply-To: <202609221705.FE257DCFE7@keescook>
References: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
	<202609221705.FE257DCFE7@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 00:12:29 -0700
Kees Cook <kees@kernel.org> wrote:

I think you are at ~15x now.

> On Tue, Sep 22, 2026 at 02:08:17PM -0600, Jim Cromie wrote:
> > 2. Patch 3 introduces a dynamic u32 lookup index bracketed by
> >    kallsyms_lookup_batch_start() and kallsyms_lookup_batch_end().
> >    It allocates ~736 KiB in transient RAM via kvmalloc_array() only
> >    while bulk workloads (BPF attach, module loading) run, resolves
> >    each probe in O(1) with 0 hops, and leaves .rodata bloat at exactly
> >    0 bytes while retaining kallsyms_markers[] as fallback.  Both
> >    test_kallsyms_perf and kallsyms_selftest are updated to benchmark
> >    batch resolution side-by-side.
> > [...]
> > - Dropped .rodata image footprint addition from +573 KiB to 0 KiB,
> >   addressing Kees Cook's memory footprint objection.  
> 
> Ah, very cool; thanks for giving the dynamic route a try! (Also, please
> wait a few days between versions and give humans some time to reply.)
> 
> I spent some time trying to understand all the timings here, and with
> a problem statement of "tens of thousands of functions", I'd want
> to understand how common that workload is. Even module loading isn't
> anywhere near that high, and AIUI, most kprobe loads of that size are
> roughly one-offs, and what Jiri measured was the most extreme possible
> attach we could see, and that is a synthetic workload. (And kallsyms
> was ~7% of the attach.) I struggle to see a problem that needs solving.
> 
> What we have today is a 1:256 mapping, so the walk penalty in ~128 steps
> per symbol lookup.

According the the commit message(s) the existing code does a full binary
chop so gets the ~128 step walk penalty for every stage.
If the new index were rounded down to a multiple of 256 (the algorithm
works with any index between the existing high and low ones) then the
walk penalty would only be needed to find the last item in the 256 entry
block.

I can think of a variety of schemes for scanning the last 256 entries.
A simple (optimised) linear scan may not be too bad.
Or save some offsets in a small on-stack u16[] array as you scan for
an item to compare against - allowing a binary chop through the scanned
items (may need a final linear scan).

David

> With your proposed 1:1 there's no walk penalty, but
> we either pay a lifetime .rodata cost or a startup/teardown cost and
> temporary dynamic allocation cost.
> 
> Right now the startup time for the dynamic table appears to need ~1500
> symbol look-ups to break even compared to today's 1:256 mapping.
> 
> How would a 1:8 table in .rodata compare, for example? It's not 1:1 but
> it should get you something like 95% of the speed (84ns) for a 8x less
> .rodata memory compared to the 1:1 in .rodata. And the table might be
> small enough that cache locality helps more?
> 
> Anyway, I'd be curious to see the benchmarks at alternative densities as
> there is a clear space vs time trade-off here, and moving into dynamic
> allocation changes the measurements again.
> 
> But dominating all of this is the question of how common it is to do
> tens of thousands of symbol lookups with a fast path need. As a 1-time
> cost or even every few hours, it's hard to justify either size (1:1 in
> .rodata for all Linux systems) or complexity (RCU-locked 1:1 allocation
> built on the fly).

Also how may lookups do you need in a batch to break even?

David

> 
> -Kees
> 

