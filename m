Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD04C042A
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527292; cv=pass; b=lWF+mQ1/Ov9hM7iRpm0LbzN/XI3UYZz9qMrIwOOi5Dw/qvWk5O6m8iKgmNRIXFMVs/iav5EpL800gPqr0lKiEB7RpH005251uXR39MB54X9OqQ9Yitmn2IQRNnj131jaCQPZVC8pxfPWNkM3lsNRCXriGktdXE6wzTez30DVnqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527292; c=relaxed/simple;
	bh=amVnZ36epT7iGrpwWAQZfRitvbc6sA0TB3mM13HEC9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnbZ9WqadLX6lXlHFW7sruxViyyVW2GwpiTmWPVKErdRLOrnLXDYqls+c++inUmg6Uy+MD8INaBDW+sgmZvoAHTkYG7wj/mAjt4lsJ43vbQie/gBzgPXZIPchDqnpHUFeDsDIF+XV9xdDVRG/g8iD+AYUBmcjudulEh/EPhatg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLaJ9z/J; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLaJ9z/J"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso4146449f8f.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 12:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527289; cv=none;
        d=google.com; s=arc-20240605;
        b=MR9NdIqYt3RaYt8lCcqM50IsOy+ervj+un3WZYdnWkOulOiL4P1zSCkagNgZ8zH4+Y
         dXalVFQ/uaqGa0vqqblMANtadIy47x7ZWBvq/QoMqJyxHEcBCj9VNRPd0taou1D0O/0a
         oFT0S9iirHXsaTQ49+BGYut5T5HHQ35srIjbTHF5RYwFGJ/mGCMRYztNvLwsGNjkFFOX
         69jYKBbhBhOlNX2+YnKrbss4UOAUohSNTw6t4ShnDZCUdynPWw4IN4dC+D7hF78hiCUT
         HkfkDQwkgBQPcOzgEkcKCRr3hlx45Mhqh5gFA0bVUQZRIXmAUaVePUCjZ5GAmU5A/vI5
         uDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EnxWK4pNQ4PCReGdcxzezu7ZFRSFtvXpTKHYgOu/Mgo=;
        fh=LA/IUbi1Rp+wGS/icjCTu5cVzGN2hwjUf9W9U0AV52o=;
        b=DkZi0rwNzX0ddaS7VaEiwn43cAbFx0sb6uwEoJLzOkkBnXUY8iG4/9xUZ9E/ULoNsG
         AcFQtTW9KeNV4GaBDfElZ+ZaN0RSBumRbK5zI3GRlnDWbtPoLcRHwB6P3aAOOHDEptZG
         gi5MaZOjyuPFrzzflDGfY+2wruqjK5DKHEsW5jwxZ1aqiM4r6v0nsiwilifG5/pjIioH
         XbNxAzLUDHHqGElqe31oRPC7/tssjwqYsIajfyJN1SqEhFiprzTwnUNAnrS462qYa2s6
         437DPJeRLtIExO1m7UXTXPO3jV9Vv1j0DpHzz7BnLGKGFcBxFeFa345c4ZJ3I4wZwoBw
         zkiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778527289; x=1779132089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnxWK4pNQ4PCReGdcxzezu7ZFRSFtvXpTKHYgOu/Mgo=;
        b=FLaJ9z/J+mANLXQb+HyyfXnqHKs5IED3LmM8BYnlnHrI4r8PAqwQdBobbnyrPYBDoD
         0ELaUnunyZ28vUbI0qXlv7KYs73FE8PnzVe9xVziz+mg7sYS/+SGzqoTLOUXIRjML+1q
         ahCbNPtdoYLBMOjAM1PbgE2e/m6fIIfyDgFukMNjLcOabpaXnvJXqLEUyGX36jdf5arD
         0tybh/0xvdVaek75y/b5OJFIIlNwx+6KYHh/Kxmq+WXJvw3CNyRYYuD7TxKhjPGtxaKK
         gDFC35dlitDvyKaP0/mHqEuAWic6dDyViHwcMAqlwsvSQz6Qy2WwQvvcIzNjHVhvxtCC
         nUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778527289; x=1779132089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnxWK4pNQ4PCReGdcxzezu7ZFRSFtvXpTKHYgOu/Mgo=;
        b=Y2zsxGDZRDQ7WhOtTldAXF+QVU/GeRhc3eryAdiqSZQIWxrvgfpG47sky4KQW0OyIK
         ad3pKyZZBpLQuhmn6/YXjf+S4CPvmm10bOrnVmQ89/aWEdhrw3Bpt+HLaWQzxZAM5sTG
         Lu8wudpzjqbgU+9YVcuMArjEozF2iYvXiENKOzjZj7brATD3ZL4gk5zBsLAs15pcRoxa
         VSJduN7tBLydWVNBDfiIwjWGc1Idx8f15LWqVVC/cYoca+u0CsxQ/tnGd2NzuhBUGmn8
         Ix9hRFzXlhND9rJ6dv+Ar0h5ex/E2DdzdOLl3QPGWI9LFbDEzlqs0oPcijXrpsiKtNxp
         jmZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PwYgl2Znt8Tk/nkCNprVQtn7zmsA5rTOHNUnNodrJNiDbs/hnUukyvn3t2mXXBhQ+8UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydN2S8WsbMgcJrF3VtfhiFt1Ct1V3le/LVioAKkMPAgFhILyX6
	f5d8cwMamcWqSXcEd9RsWwf9AJxyZFNniVqG8dcKZVZJ4Yrpkvh4ZU5mSfBRGsGJyjvqLFPKR87
	7O0UjfuyN8w70+BNEjY8DcnU/kLj+GkE=
X-Gm-Gg: Acq92OFCKok7Jd/pJtPG9XI/IAj9eVXaCJD3RI9wQppdHNzlWxgaquded4kJINy3Rdm
	5SdaIz++bsoeHMifMC3AL2Ke/1zlSjTA7HlriSxuvQl9b8zz/0yKgJhZHnv2Eg7e5PFQfwvHj45
	0zi5oFziIXD7BD7tth0gO8o5lwnxWLOnuYIkKa21kRGeoYuaDmw2IAwen0N3rDWGUZtDUFFO2Gv
	UBjQkoKaeGuB0tm7NyCirz97zoe10GQUzRtikgdm1GcadLYfDNWsEd2UrmWO6Tgq5s7R9dVTfwA
	J+SfZpKVVexNzMt1DYZY0S0/pQUjNpgUiGGrncfknbCsY3dSNPAhEbCcCOVaR2DHEF07jKy38zW
	6Yy44518bJ7m5Lu7+0Fy1nK9TMBiCwbuITjvy7v2rwl8lP1GFIYzE9dUzOw==
X-Received: by 2002:a05:6000:3110:b0:43f:e934:50ac with SMTP id
 ffacd0b85a97d-4515b057350mr39791243f8f.7.1778527288955; Mon, 11 May 2026
 12:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
 <20260410-patch-set-v4-10-5d4eecb343db@gmail.com> <af0gXEqD3FPFYZDj@mail.gmail.com>
 <639f1b0f97330c98668c00244c0a7bae19e30e3c.camel@gmail.com>
 <agIVpXzC_bXgJ44N@mail.gmail.com> <b063ec89e7ab548d93a892c44ede2824040ebf10.camel@gmail.com>
In-Reply-To: <b063ec89e7ab548d93a892c44ede2824040ebf10.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 May 2026 21:20:52 +0200
X-Gm-Features: AVHnY4Jh_pUp2PAF_auzUuwCAGkQgbdbRfBcyjwKqlaOLNy_whtqHe57XPUuVbo
Message-ID: <CAP01T76nb17=8eugBG9tPgTY5p-_G4Y9=cq16eiCkFdVujChKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/14] bpf: change logging scheme for live
 stack analysis
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 20:54, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Mon, 2026-05-11 at 19:45 +0200, Paul Chaignon wrote:
>
> [...]
>
> > > > I'm wondering if maybe there are other opportunities to reduce
> > > > verbosity here (besides [1]). Maybe we don't need to print the
> > > > fixed-point iterations if we're already printing the results? Or maybe
> > > > we could put the more detailed liveness-related logs behind
> > > > BPF_LOG_LEVEL3 or BPF_LOG_LIVENESS?
> > >
> > > Had this been a normal compiler or jit engine, I'd vote for
> > > BPF_LOG_LIVENESS log channel, I'm not sure what our stance regarding
> > > user visible ABI here.
> >
> > IIUC, it was only released in an RC and the logs themselves are not
> > really part of the ABI, no? Or is there some other concern I'm missing?
>
> I mean the valid flag values themselves. I hope log is not an ABI,
> given the number of times we changed it. If BPF_LOG_LEVEL2 is considered
> a kernel development only thing, then splitting it into multiple channels
> would actually help the developer, imo.
>
> > > Regarding BPF_LOG_LEVEL3, I think that the original idea behind
> > > BPF_LOG_LEVEL2 is that it would serve as a "debug log" that regular
> > > users won't need to consume. What is the motivation behind collecting
> > > level 2 log on your CI? Is it to infer clues regarding programs
> > > hitting 1M instructions limit?
> >
> > At the moment, we collect this (1) in case of failures due to the 1M
> > limit and (2) to compute the maximum combined stack depth using the
> > per-subprog stack depths and the callgraph. (1) is not expected to be
> > happening often and isn't much of an issue. For (2), I'm planning to
> > send a patch to have the verifier report the max stack depth itself.
> >
> > Overall, this isn't an issue for us. We're just using a bit more memory
> > and disk space. I just though the sudden increase was unexpected and
> > thought I'd have a look :)
>
> For 1M instructions, I have the code to identify loop headers, so
> error reporting here can be changed as follows:
> - count the number of times each loop header is visited
> - when 1M instructions limit is hit, identify the "hottest" loop
> - print info about the loop
> - if loop is supposed to converge (e.g. it is an iterator based loop)
>   print out the samples from states cache, noting which registers
>   differ between samples.
>
> Alongside your future patch to printout stack depth this should make
> log level 3 not needed for now, I think.
>
> Kartikeya, do we plan to do something about 1M reporting or are we now
> pivoting towards rust2bpf vision?

The main thing I'm changing is more context around an error (by
relating it to the source), categorization, and mitigation
information. For now all of this will just be appended to the existing
logs at the end, once I share something we can discuss specifics.

I do think convergence failures can use more summarized output, right
now, the huge volume of information makes it difficult for most users
to figure out why the loop fails to converge. If you have something
lying around for that, you should go ahead and share it. I was
wondering if we could avoid emitting a huge volume of info upfront by
identifying cases of failed loop convergence, instead of logging a lot
by default and then pruning it later only when the 1M limit is hit.

Rust-BPF stuff is orthogonal; we will have and still need useful
verification errors from the in-kernel verifier with or without the
Rust frontend. It is just likely a lot of the errors will be caught
ahead of time by encoding a lot of invariants into the Rust type
system, but the specifics of the solutions there are too speculative
right now.
