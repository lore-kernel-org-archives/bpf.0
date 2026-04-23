Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED57DA66
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975891; cv=none; b=NWrpYkJqHRRZTgIQPPLGC7ziQ3MVlgG80neG4UNyWnqYtvMoC4jFTdv6Eor99p1y+Ql5eIc1F+t4jYZMtLxHkhvgGS6DG2tOPvM+4e4hPR2Q+UBTWGfZYPG7CafuWJNGuWhAld7a5X2O7itp5knkeVNePoZpEebXMnEwzo/JB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975891; c=relaxed/simple;
	bh=vfLhN0SiCdNis3D0NTZ/0Xow6yj5Dhc6DVDMRNJbmBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTu/rhKhrmxkSem2pukVKuaA7BXnM5zo+m5YT2UezpHOYrDl1j/LD1jClltUzpdu2vRVZVYrW4kOOH1d3uVIFDzBbfgaR8arMpgTRjOtK5c+QjFxEToB7O1gln0xwBW1fVHLHl08DB+43KuFPWIUnTQAjAUsDqu/i5qAwzuxsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qp8QooE0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qp8QooE0"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-674a44b84fcso9315285a12.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776975888; x=1777580688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZKlv5YpmybmME/ZjFGzaeQ66aLr3fRG/13wKTeDpGM=;
        b=Qp8QooE0PXn4tuCK3e/pYoRV72VBpUt77t+QpY9glRLaUEk1MX2F2LMgVW6RKu04r3
         7d7SRz9UCbJGfGwsPrbKomNKxX4N/o3ViTstgUN3LwJul2gLD42doO5DnIhCybaUiy39
         CIdykOWwe/ObAxlkCoxyilvfGKFrI9j+rBcS/T8felHEhuIoI2DjWtjrAUcwW0Q3vNcd
         Xm/XmKGMkCywl0RAHJcuyIUsUSLDAI4xrLjmYtF3bDJsyaUfEbtdDrlb7Y5118iX5fmQ
         Gm2VM+9IX4Wfq4Zx+JeCkniPs5J7qOmafeqF2bS6un+ebboWaQH8M/fyaNuPAsH5fWBS
         QR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776975888; x=1777580688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZKlv5YpmybmME/ZjFGzaeQ66aLr3fRG/13wKTeDpGM=;
        b=aw++8hsJXaCmsrQdDrYS1QuzgDvXS3Z9U/sP5lOEZohyC80+aoCS8HU1aYIlUYnimo
         iJ/wLkwvc4H4GUxMNQLhYG8dD1wDyJNv+eOKDRFfPEZdzMC4kKgTj8gXIY1iCnpQ0Q61
         W7WWB1ltF1mnI2/0crSMu0wxLB4hhy5qLQ9sMCAhdi/Os7ZkGXrA1TB32aec5rqtM99c
         pZGJYWthigxdTVVx/FmWlh076KvNqhgL6t94/oqfY+ZIlOrvJ8zwuJsqDqry1Xu/AFVY
         gS6BoBWGEvkaikKnM7gUEhIDoFE4l4JXfVM/8MYX2cuKc2MM/ziQIXieIWInV8/rQvpz
         rNcA==
X-Forwarded-Encrypted: i=1; AFNElJ/7LPrRKlvO20zfUA5H+Z60JMmBYjsw83Msc7iJfq3+cVrFpkcxdOXZkGGCMjhENJiAzEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQtNo03nBt4GvmDgJLekDxW2docIse/eVhUDN/46Hx9TfLxjf
	qE0KA/R2cr8lTte3BvI0kIs8UKh1tLzOsKLKwjmamNhKY1MGN149QY1w2TuCIVV79w==
X-Gm-Gg: AeBDievJFBfa87zpk2+abUkJjYE3/bsgbOfFa0KUx2Tx7WLF/aUolS1OBsAyVXQVSiM
	E+cfuOLJ3sQlH2FV+QAJO2RhvJp1jaA7CWa/ESRsrKtLX9jwo8shwh0aYk5DadXJ3q3VebD1uES
	d4gQ8Ar0uNmC/+1uhqLtt6FKsV7lcke/P0Sex3cZCRYVRrMUN5yu2PBiYAA89Z8O/6SPH/wr1nT
	sIxIcmR6Ke1ctRMSDsHZTbOwGFcckHj14HLBfxpTtTSDO47Q9yifq6A6W/cV3mK9qTLs3LU7Ujz
	SBhM5uFb2ZbgiGY3GiyaLiXubB6fIFmswPBbyKW2o646A1kbrrVEIYW2SkTSPhba/Ptdc8F4q3v
	jhU+ThKY9CVF0N+oftJ2LZMjwEjdq2SWmPET7Fw+KkmKAY4hcdY7pXEMpNPVMYhuNiOlJ1PP5Ip
	av/i8wJQBGO2QhZQ9h+qMJU17+UvvfMzQct19TwJ2CpGsovejOe/v1e6c1RO2qufKXWsRAyOMyr
	U7uYPHjwVgC
X-Received: by 2002:a17:906:4fc5:b0:b97:9636:5aac with SMTP id a640c23a62f3a-ba418e8affemr1504646466b.13.1776975887170;
        Thu, 23 Apr 2026 13:24:47 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45503c435sm695441266b.43.2026.04.23.13.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:24:46 -0700 (PDT)
Date: Thu, 23 Apr 2026 20:24:43 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, song@kernel.org
Subject: Re: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for
 libarena
Message-ID: <aeqACzTZKohGZnuo@google.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
 <20260421165037.4736-7-emil@etsalapatis.com>
 <aenb_fGyhCxiNBPY@google.com>
 <CAP01T75q0_9k2W46_ibNrbYeZwpQO-nO=ysqX1Do+CHd+rE8Hw@mail.gmail.com>
 <DI0OO269VLZY.1M86OGAGEQTRU@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI0OO269VLZY.1M86OGAGEQTRU@etsalapatis.com>

On Thu, Apr 23, 2026 at 12:43:13PM -0400, Emil Tsalapatis wrote:
> On Thu Apr 23, 2026 at 10:00 AM EDT, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 23 Apr 2026 at 10:44, Matt Bobrowski <mattbobrowski@google.com> wrote:
> >>
> >> On Tue, Apr 21, 2026 at 12:50:35PM -0400, Emil Tsalapatis wrote:
> >> > Add a byte-oriented buddy allocator for libarena. The buddy
> >> > allocator provides an alloc/free interface for small arena allocations
> >> > ranging from 16 bytes to 512 KiB. Lower allocations values are rounded
> >> > up to 16 bytes. The buddy allocator does not handle larger allocations
> >> > that can instead use the existing bpf_arena_{alloc, free}_pages() kfunc.
> >> >
> >> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >>
> >> The implementation of this BPF arena backed buddy allocator looks
> >> rather solid. I noticed that we have a single global lock being used
> >> here to synchronize metadata structure modifications. Have you thought
> >> about how this might be a high contention point, particularly when
> >> dealing with systems with incredibly high CPU core counts? Did you
> >> consider possibly making use of localized per-CPU caches for the most
> >> common/small allocation sizes or something like that? This is
> >> something that definitely crossed my mind when I was initially
> >> thinking about implementing something like this a while back. I
> >> understand that this is an initial implementation, so it doesn't
> >> necessarily carry all the bells and whistles, but I was curious to
> >> know whether this had also crossed your mind and what your thoughts
> >> were on it.
> >
> > Yes, both reentrancy protection and a per-CPU caches are things Emil
> > is planning to work on next.
> >
> >>
> >> [...]
> 
> Can confirm. This is basically just the first version of the allocator
> just so we have some way to manage arena memory without hacks. The first
> thing to optimize is adding per-CPU caches to avoid contention. I've
> avoided adding them until now for two reasons:
> 
> 1) We don't really have arena workloads we can test optimizations
> against. I am working on porting microbenchmarks from userspace
> allocators so we can concretely see the effect of any features we add.
> I'm also working on adding data structures to libarena, and since they
> may do allocations/frees during regular operations we can use them for
> benchmarking.

Both sound like relatively good ideas to me. Notably, this point has
sparked another thing that I was kinda curious about. Do you envision
libarena being hosted outside of the Linux kernel source tree at some
point? TBH, I think it'd be quite nice if it was. I definitely
envision something like libarena being a submodule within numerous
other BPF-enabled projects.

Also, I kindly request that you CC me on any future revisions and
changes to libarena.
