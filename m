Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0673AEB38
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321020; cv=none; b=kVAdp+rmsh+f7BhY0dz0AcJngWD7GpS2HiipcwjUg3VRxx6dnqTzVtKREdC+5JSSqsbw3ug/bVg0Q4pU3MD4xNLxvzQ8noJuUF0rrksn3VQdmaa24lqV+7cJ3C/Gqkmfg9OpZ5M4Lt832RQKMawYsgqRx5ifueLwmrQ0EhaviCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321020; c=relaxed/simple;
	bh=tcgv9JV8PxiC88LlXyjeE64UkSVapeFi3tKfKiKyi8k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSNn3Q48bhmc6PfRAWwJmzJOa1RGmDHRS+Y/82MbRI7/cYohMRejoZRNFyr2ZWjMfT+dxtGNyulMeSEZZtZsAOV1zTr7azEVyyzrT/I8aFjnTa7MAUvnaQVaj6pMyG5B0b3LOZzj7HqsuJZy9GnIhp1oFN7pHyYwLG/cCodE6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3qM+BRj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3qM+BRj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so8063885e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321017; x=1785925817; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gve361V0fFkgkDMAjMe5VScFpJ9Gjzihx/60pySBpkg=;
        b=L3qM+BRjEg+NNhMSVT9/E+Daw/+rqN0qMrGFIO4yWi2I9JqUelaeQU5SZCllV2M23/
         kSnzuVVYORi43gO5uWD9wQamObn3eomVZ1l+d7tU8odapoyyps67TTjUDtX7uXU2GAel
         LUkvnVZYM4faVa93KOtyWZx+LgKYf56rFNH7V5e5isawPkxxmh8M68oQhdphLiPfe953
         oFdEFqXBAIcY2Ipyt4KGvf2MHL7xbCvtfV08nNFK0kRtY6cVt/U3ktNlcTHF839FtkR1
         uhdcrJd8megD4UfrLw2qQEpXsnZyKZZ8yoRX8l9coQ8yM7/v2WPK+Y+Kpf6+iiaqRA97
         pfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321017; x=1785925817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gve361V0fFkgkDMAjMe5VScFpJ9Gjzihx/60pySBpkg=;
        b=M4Nwh15BNbhOgEOXo0IBNCnYaFANeobiTWWW211lkOMkvaVoZWvIE+XhZJIGcOjLpj
         b+kCiY4OQB2SmV/uC9xs4xTAX9ABCs9NgxqNkvF2lJJW8fGXcWiA2dAxfABSNkE1EWbH
         qtcKb/HFFtknJKrZ74nTNGFbyZeg2hoilB6nZvW1t5fsvHiVwrjO+Jnb/3+8H/4SKmlE
         iLdHajN9YZ+y2v1zgWOH4k9lY6qeWOaZYqZHT6ab7lrdl/HTAE7Svbn9KKyEo2aMXXIx
         gAPV/j3GYwE3ySX5hWpN2vZo+mAbHzLW+vsy3wmqrOqUihlMu1SHQyivzIVNvgWaO92f
         iosw==
X-Forwarded-Encrypted: i=1; AHgh+RqhvPq4zDTE+nWAhqTrrXfeK1bSnfcCjveP5z/+xsZRJq0S/cNtMFt02YLEev9Pb4fcmlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/kuwnCaDJgp50PnL2ejQFU6Ksog2+Am1+ct2+amoGFvtBGv7
	8+qNhV5n4cDxHs+r8WoH3vaJEPbHMZE6AoQ2fTnkoiS1CPgbv7I2tUCz
X-Gm-Gg: AR+sD10BejfYySkQNhNOHN1sR9LwMDg56vio2yafgE85M9DHQjCCsi45LM1XU9+h360
	BQqohCJOiCtHEoEYXlVsttmNLJE6zpiouezf9r+dPC2Dtb33QsbVSCWB4iU6ZtoKXBED4i1VKIv
	LDq/0KMagJzCpAv4h/dxZXpKCVwvM/SttIunNvGGOeVrVbbrf9fcTh2H6eHKV+4ePuIYYRnscqR
	gNBS+1xmIxYitc1QEiQnhFO5wZYCKpb7S0r0ZwKrzpT+hQm0y6g+99MIS70GImekfff3MZ+zQpG
	h4JrkbbmxX9VjqVt7IbVZVnigiVrIn5H3RcWqkCYroNAOFC6dj7UW4zKmuX3BFf72cQ7McVVd9U
	qcW9JPYniny36zYBYFwGKWNlbc8J5aKQNkHEHJB2PFcMoQKvCHiQmZR3A0gN9WFfxWUqemODeR8
	Se+9CbAS2KTfmd/gh7Xfnq5jUhG3sIvOdvhEQ74i9zcaIYeg==
X-Received: by 2002:a05:600c:3b90:b0:495:6478:2dbc with SMTP id 5b1f17b1804b1-496c641067dmr72438535e9.6.1785321016650;
        Wed, 29 Jul 2026 03:30:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::86b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d752dbsm30066895e9.3.2026.07.29.03.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:30:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Jul 2026 12:30:13 +0200
To: Song Liu <song@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark
 for array maps
Message-ID: <amnWNTIQm4F_AzjS@krava>
References: <20260722065308.4116186-1-song@kernel.org>
 <20260722065308.4116186-3-song@kernel.org>
 <amJhnbom_expRgN2@krava>
 <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
 <amMoJnZUF5flJazb@krava>
 <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>
 <DK79S0WM9AYK.162USUO6EB2ZA@gmail.com>
 <CAPhsuW5Zf7ufT2iiyQWBdG_7JOuJMJqwf+jHbumMRVPqFGn7pQ@mail.gmail.com>
 <CAPhsuW5RC9JkLwfc2V-iO0pw5ggsrrwamJGRL_haN5fs8KRLkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5RC9JkLwfc2V-iO0pw5ggsrrwamJGRL_haN5fs8KRLkQ@mail.gmail.com>

On Tue, Jul 28, 2026 at 01:11:49PM -0700, Song Liu wrote:
> On Mon, Jul 27, 2026 at 5:19 PM Song Liu <song@kernel.org> wrote:
> [...]
> > > I think it would make sense to compare cumulative cost of mmap+read-every-page.
> > > I am sure it would also be lower before this change, due to the added context
> > > switches for fault on every page access that would be amortized before this, but
> > > may give a better picture about the difference.
> > >
> > > I do feel like it's a corner case realistically, and after the first fault the
> > > page remains mapped (and users who care about pages being present can go the
> > > route of passing MAP_POPULATE). I am assuming passing that before was a noop, so
> > > it can be added to code in a backwards compatible fashion if someone really
> > > depends on this?
> >
> > Given there is MAP_POPULATE flag, yes, the user can preserve the old
> > behavior with this flag. While this requires users to make changes for
> > this corner case, I think it is still cleaner than adding a BPF map flag
> > for this. If there are no strong objections, I will keep this behavior in v3.
> 
> This turns out to be a little more complicated:
> 
> 1. Bad news: MAP_POPULATE is not a noop for old kernels. The pre
>    fault mechanism still adds some overhead (for almost no gain). For
>    8MiB mmap, MAP_POPULATE addes about 80us (raw data below).
> 
> 2. Good news: We can further improve MAP_POPULATE with a batch
>    pre fault (vm_operations_struct->map_pages). With batch pre fault,
>    mmap then accessing 8MiB is about 34us slower than the best
>    option before the set:
>    (before: no MAP_POPULATE => access all pages: 252us;
>    after: MAP_POPULATE => access all pages: 286us).
> 
> Note that, all the above are worst cases: we need to access all pages
> and fill the page table one way or another. If we don't need to access
> all pages, the change saves a lot (220us => 1.2us) for the mmap.
> 
> Overall, I think this is a net win for most use cases.

sounds good, thanks for all the details

jirka

> 
> Thanks,
> Song
> 
> Raw data:
> 
> All of the following are for 8MiB, access times are in microseconds (us).
> 
> Before:
> no MAP_POPULATE (do not access pages) 220us
> no MAP_POPULATE => access all pages: 252us
> MAP_POPULATE (do not access pages) 304us
> MAP_POPULATE => access all pages: 334us
> 
> After:
> no MAP_POPULATE (do not access pages): 1.2us
> no MAP_POPULATE => access all pages: 543us
> MAP_POPULATE (do not access pages): 262us
> MAP_POPULATE => access all pages: 286us
