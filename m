Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91635A93B
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806437; cv=none; b=gWijEFdu0Xl+BWp0OuCs05gmiKVIvftiwBjXqh5v8vOFAQkEv+tD5nb8CAT8l4cHSPx9BqEbe96BNO9wBuQa2APS8U7g6NrVUYa+HRgdfuBzpxEJT/fEwWU96qicE9BjGToI9dPTIBUYoHRIOJ2O3oWQWPrxvMF1hnIcxB0k8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806437; c=relaxed/simple;
	bh=28Vg1GMV4r+i+vIBKXJxixIg3Vo2QeNnzHXDUGj0Jxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWJAtkhiLQgLg9ylvZR+jrjer08ZRRKG3vQ6FnsxKU6p0FesK9fFQiLZYGCyqLo+6G3IZqSKRiaFw7J3H3LenUpZYnmkE4k9l5i7QCrxADm9w2mD2K2NYKQKn0aYoZewiAjsTKJxoMwbkwYRc67dEpp1kYVUeG55P4kjbqvbQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2hJoxTm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2hJoxTm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82418b0178cso912020b3a.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775806436; x=1776411236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRS9Nnu+V9tZL7QDrIq6tWswijIHQUZ2fyNkuG3AePY=;
        b=g2hJoxTm7d5pBhbOXQS7vatn0f0ODokjIMvFDcP8jW2+zBI3hJfFgMW2Dz+es76FPT
         fraXJH7hXZaaV8ikQrw3q0PSyOPHNL/+9lGSf67o/zkDY4Pg/ijupxwqi20UQ6bSSI1J
         LT5FUfkIh2KqXeY05xslSQWmzPpzImp09FJZ2TSNwScIs7v2Vm96J9lme+Qw3IGJ4J9b
         P0Suzi9XiND8bmXCdvlp5Hh9Tw2jOLTqK5EvoYo39fPxr93eytWCFydXpu73OIBu2OHx
         Z1L8VSvgE0t9YcUZ571x7pk+CdksaN89X5wdjS4iJ6IplCbLH6nP4xn/jSBMVNgmxzu7
         pzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806436; x=1776411236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRS9Nnu+V9tZL7QDrIq6tWswijIHQUZ2fyNkuG3AePY=;
        b=lc0mX6HqZqId9mFHWNEfuQHg42L5s8jlkjV5O9aLf3DEGfAJ/pImbO3JARnA5oZ/8x
         tiL3BYIhsuGjLOIjxD1ciDpHMQayx0AxShLLl7W7nH0NJNabPtALge31SH+9LaeYhp59
         4mdhZAb/ynZScp24qWYRNHOvjm9kYulGpet31+VnD6qi7r4nweAG1d/bay4zoy81b0VT
         7MXVnswa6VXA4Zn+4yOVXHxocw6X2OBps6Rphjz5V1kQ7CY/LZNxNR/ngK5OCgBj32qw
         e7PrPsFbNp18uuxtK6UU241+Jwl20VziWY1bZskeVCPi9m3hAgeSNfss3lhb9lxjnOWf
         u3nw==
X-Gm-Message-State: AOJu0Yw8w1tpGMRPHlXs893cFJHtqTvfmIao+zXnjNw5i3vG4acJc5MR
	SOMVYOK2JEEPu0cWAd7f+gs1UWgY92LtKBVqubhgSr5md1Ieax/vJSTw
X-Gm-Gg: AeBDievqAA7AR6dhpqPfZ5NZczY9FXO5QrQrns322kuYr3OsLYjhRYVYRl+ceDM9dkX
	9f6pR4RLMIaDC2Z/hpMk+HKEZgD7xLsifcFuS18DYTARhWAaRP1ZT4BGpLpV2tm+WHauTWFQzGN
	FFI0liPGBt/zc6sdpcl983UjszVqvPgHfif3zzZYcbDC0icEhOJfSXPAZpc2KfU+1K81vaZ5+tX
	bkxR7Z0o1OO0BzFmM8DUnlG4WzMLeajvpj31sDGpYqgqMnuL7cE9NLh4qAU87PzHOl1KFAUVe9R
	I33zKLW+d0swX0CcNqW/Y1OmlKH0zR/tzbXu0baXLyt1GmSiyywZe6T3gfxBZQNjNhtvJ2x4srS
	XhQ3aMiYZhlwjm3xA0hZzaDuXZ86WuEQ7rimQAOdS1xeN7Jo1Wa1AL61jWJD9m7oJJKHM9LQWDn
	z6eVnadCqNXWlJr/AfAtpMnQcae7SsjskbFbyjG9xh7A==
X-Received: by 2002:a05:6a00:429b:b0:829:7553:afc5 with SMTP id d2e1a72fcca58-82f0c13210cmr2263369b3a.4.1775806435999;
        Fri, 10 Apr 2026 00:33:55 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:277d::3ef:37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee32sm1908846b3a.7.2026.04.10.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:33:55 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:03:43 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, jolsa@kernel.org, leon.hwang@linux.dev,
	andrii@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
	eddyz87@gmail.com, martin.lau@linux.dev, daniel@iogearbox.net,
	linux-kernel@vger.kernel.org, memxor@gmail.com, song@kernel.org,
	menglong8.dong@gmail.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH bpf-next v3 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK
 feature probe.
Message-ID: <adin1waaRhIJZWbi@computer>
References: <20260403124412.37449-3-varunrmallya@gmail.com>
 <3b7a777be44a7aaea75f1dc3084b3adfb32357c4bedde08d0666f6f9f3d65ba4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7a777be44a7aaea75f1dc3084b3adfb32357c4bedde08d0666f6f9f3d65ba4@mail.kernel.org>

On Fri, Apr 03, 2026 at 01:22:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index 4f19a0d79b0c..01ded8a1e3c4 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -424,6 +424,41 @@ static int probe_uprobe_multi_link(int token_fd)
> >  	return link_fd < 0 && err == -EINVAL;
> >  }
> >
> > +static int probe_kprobe_multi_link(int token_fd)
> > +{
> 
> [ ... ]
> 
> > +	/* attaching to a valid symbol should succeed */
> 
> The operation is designed to fail with E2BIG (the count is intentionally
> set above MAX_KPROBE_MULTI_CNT). Should this comment say something like
> "use a stable, always-present symbol" instead? As written, it reads like
> the attach is expected to succeed, which contradicts the comment two
> lines below about making it fail.

Yeah, I should be clarifying that. This is a nit though.

> > +	link_opts.kprobe_multi.syms = &sym;
> > +	/* MAX_KPROBE_MULTI_CNT is defined as (1U << 20) in kernel/trace/bpf_trace.c,
> > +	 * so we create one more than the allowed limit to make it fail with E2BIG.
> > +	 */
> > +	link_opts.kprobe_multi.cnt = (1U << 20) + 1;
> > +	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_KPROBE_MULTI, &link_opts);
> > +	err = -errno;
> > +	if (link_fd >= 0)
> > +		close(link_fd);
> > +	close(prog_fd);
> > +	/* Fails with E2BIG on kernels where kprobe_multi is supported */
> > +	return link_fd <= 0 && err == -E2BIG;
>                     ^^^^
> 
> Should this be "link_fd < 0" rather than "link_fd <= 0"?  The
> reference function probe_uprobe_multi_link() just above uses
> "link_fd < 0 && err == -EINVAL" for the same pattern.  fd 0 is
> a valid file descriptor, so "<= 0" treats a successful fd 0 as
> a failure.  In practice bpf_link_create() goes through
> ensure_good_fd() which dup's fds below 3, so fd 0 cannot be
> returned, but the check is still inconsistent with the
> existing code pattern.

Good catch. I'll fix this in the next version after I get more reviews on this.

> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23947048141

