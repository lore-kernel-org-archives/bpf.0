Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E06227B94
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398762; cv=none; b=gWt9AYLJLohYswOWnLRRxGI59D8hSU/0RkYF6GFKIK4lADsD/FcaiKhtiLAvVZkMUSppsi0XcW8Hy51ed8PBb9zAaS79IqFsxMLaSs/j9T3ydn7WVL6w7cmcqHp67gpib9vnL2h5YD63xc2czEDfQJyrVbDrZULhjSemvY5gWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398762; c=relaxed/simple;
	bh=Uwzvol3XJhuoHgWLPxWbvlkd7DkJhTYWn6YehkJXCLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO3suilrgylQ0D1ju+IYDk05vLhyYAAfFZi6ey2BaaVtHEaJYe9E2M7eWVNtwhfnaGcsdpGUSQhvwWBLl/9+X/5CaM7BWuWIFy2tP5xvLMKDNikLOjIHwwT/7ScxoVl36kkkuupLVSnw/EOLVDOwmjt7BctIcQkFRWKqP3r1Fqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efc2hSds; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efc2hSds"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1596350f8f.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 03:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773398759; x=1774003559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6K7aNPlluh4KsXeXk3zH96Wn9cIn09HGGeL+pxk1t0=;
        b=Efc2hSds1q46H/8vfRiMbkbORsRsVoZr4xHOqxSvNZY2g3A4W+l1r49He2s2iu42Ei
         /27YGvdGBOZ8yu8FeZGAahKvkVKbISlYAaip5SBsLHGAdK8ES662IzEI90jJvLKvSy+t
         mg2XGzx5KEWsZkR5lQV8PV2yhXUZurpTNZ7T1ea4eSiPKp4/6lMMnmTu7Pc6pSky3n8p
         QwqVZ2GuxVfuWqW+cOLI+qMo/REvRls7UFfYN9LpyFkFI/OMVHaC5fRkCTHXN4NRalnL
         vBA8+DLIov7nNcyA7jwl5Xqf0AnUVtIily8/ULKj3V9gYT1DBcLKZzU2ZVh4az9N4YCF
         /nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398759; x=1774003559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6K7aNPlluh4KsXeXk3zH96Wn9cIn09HGGeL+pxk1t0=;
        b=jB7fE7Vp2L6WD2O0cKCLKUAmtweH7FYftd7jALNaa9Z3NQb87KQ8x/YtiMDDWKzvV0
         pfu7IJFXD0ajncq2GXqaN53jqz99SnLzkr5wtOSfH9iRSxip5puJ419oNZw2hyfeJTxP
         ZNyX/ZyTSew7JJpmsX6xBhcI+DrW6Wi27TwGGyO8LSPkJ2f4Kx1Uk7w4b7vJ03gXCjR1
         AmZH9Q7FUoYOFOUb9eKVNbs1mP8keZYMxidE90Cp2G7bQPYtgB0KVgNEx0lWg7ADMUPN
         XTGtlLUrlaHnLbWSvCcCAdEpZEKvL4/CRcfLZfeE9lyAzjXp+PAPJ7HZBLhXkNOiwbII
         pDUg==
X-Forwarded-Encrypted: i=1; AJvYcCX2zL0MXvZ4z3XYsiMmp759wq3EtaWhQq9o3RK1OwKNgfNoR6448rbIqnoubf3k+EICXmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9B7+oD2pNwyIk8CwoTVd1aD+jXhMtO7IHKKhY+TbR65AxuvV5
	Lxa8iWMZfE/fPrU29qhbj5RjnDE4312uLWFV9XjYxZqMoYONOxSVR2XF
X-Gm-Gg: ATEYQzw4d3aH7D5uJ6DYD5BV5UMc8C58zpEPkgNKunWRD0ghp0X7/DgqAVLeOtBotjN
	dbi0p+hNonLFDOvAMJPeHiuEmBe5Z/9uqetVePiRKj0ZxQF2K4+3/+ZlBm//Q5vMXJUDtTLvROX
	fQJfuaz+qr23rlTGIKJovTXPnzNZkbW8AE/JvasXBIweYnujg+Oj/kMcMI7b+Ww7d4Kay9LC3OV
	r/vaSPt+2g/ZcdGEPqIOpsQQDoG6fmiBAnZbRDXd5IuTDhY1Kx9AFQNmi80c/0a9ESpq26sV2t9
	mrwVQbH05uJckPN3LZj3MNUtG2iVZB6hZyFDWrTTbewjmAgPIkcPEHQTbuaHsYmhAgUaZDAvr+N
	M2cnzIlY7dI08q0iGCoGEd0ELFKM5dQby4qwUCkYudKDgsTW4d4aW4pzFf2Iy5p3ttBNpSj4HHr
	EcKB0aBdVxNp7oVQlmLxlKVIvz2tyq/YVzsbGRj16+RZkJUdMzv7UAJSbffD6NHu46oPWi21h45
	0KXdj8XPEal3BlGXN+ypH9wZbBBIRcxoJL8dtuRo5UkDpEfsymAmPSNK0pdA5exMtzsHz5meHlC
	GVvIoQ3PdUQ=
X-Received: by 2002:a05:6000:420c:b0:439:abcd:b312 with SMTP id ffacd0b85a97d-43a04d868cemr5343056f8f.7.1773398758974;
        Fri, 13 Mar 2026 03:45:58 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2e2c71sm808294f8f.22.2026.03.13.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:45:58 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:45:56 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
Message-ID: <abPq5E33cehxfOjq@mail.gmail.com>
References: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
 <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
 <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>
 <abMHY2sCSe6xEKR3@mail.gmail.com>
 <wficveatl5cscfiaasqanow72ejlzifrcatj7z3r4dtu6nul77@bpfukkbrhml6>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wficveatl5cscfiaasqanow72ejlzifrcatj7z3r4dtu6nul77@bpfukkbrhml6>

On Fri, Mar 13, 2026 at 10:17:52AM +0800, Shung-Hsi Yu wrote:
> On Thu, Mar 12, 2026 at 07:35:15PM +0100, Paul Chaignon wrote:
> > On Tue, Mar 10, 2026 at 12:45:39PM -0700, Eduard Zingerman wrote:
> > > On Tue, 2026-03-10 at 15:56 +0800, Shung-Hsi Yu wrote:

[...]

> > Thanks Eduard and Shung-Hsi for the amazing reviews and contributions!
> > I'll send a v3 with:
> > 1. The renaming commit from Eduard.
> > 2. The initial reshuffle + additional reshuffle from [1].
> > 3. The removal of one __reg_deduce_bounds.
> > 4. The selftest and I'll see if I can craft a second selftest from the
> >    new inputs you shared Shung-Hsi.
> 
> Perhaps I can try to see if I can come up with a better example, from
> the difference between initial reshuffle vs additional reshuffle.

If you have another example, that'd be great. I tried to convert the
inputs you gave into a selftest, but I'm starting to suspect it's not
possible to reach those inputs.

I initially tried manually. For the first example, the trick was to
write all (or most) jumps needed for the different bounds and then find
the ordering that puts us in the exact case generated with CBMC. After
failing to find that manually, I tried the brute force approach:
generating all ordering of those jumps with a selftest that fails if we
reach the state we're looking for. That also failed.

> 
> The problem is that I'm operating on a simplified assumption of "not
> being able to converage to a fix-point is bad because it could lead to
> bound invariant violation". So taking this chance to ask, does that all
> ties back to is_scalar_branch_taken and reg_set_min_max (or was it
> regs_refine_cond_op) difference?

As Eduard answered, not reaching a fixed point in the refinement doesn't
lead to invariant violations. It's just a missed opportunity to get more
precise bounds. In general, Agni tells us the refinement functions are
sound so if they output ill-formed bounds it's because they were given
ill-formed bounds as input.

> 
> Also, when we fail to reach a fix-point, it does not become a problem
> immediately, but only becomes a invariant violation some where down the
> line when we again do bound deduction?
> 
> I haven't actually look into an invariant violation myself, so details
> are rather hazy. 
> 
> > > [1] https://github.com/eddyz87/deduce-bounds-verif/blob/76755f763f9282b74ca4e2251f83767502a98e5e/deduce_bounds_new.c#L321
> > > [2] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
> > > 
> > > [...]
