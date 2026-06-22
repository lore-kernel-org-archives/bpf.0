Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C9371877
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124564; cv=none; b=Uf6PkianiVCnGiY0Lgm99fOpnzh2B0HqiCkw4v2/8hVRuGwg4x6+MscSGGtWvtsGPqOpAVksgAk6x1VlsJpVLznHjRr2tjZsOPUI3X/9C0imx4LGY6/GarTFFuKxYGkgfAlz1omzV6etds0MxhtX+komLh1Kv8XQEmM0/Evkhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124564; c=relaxed/simple;
	bh=CdhzNEvEzeM4Cb2Q3ggY+4SMLj+7QqizoqUamE9SWhQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQqMZQsCJeHc86rb6zSPq/K+oT70I5hBnMzzjeTJjL2u3r8xnp3ukLOPz0IqzwTTeCeaMsJaCpo36X/LPhqcrcqWF3nFkzIBAwhH2nPyYSKXFJnE9zvdlGbQpPDoFvHtgGpn1oTRYkvu43Wi2YqLwEW8KZaA+9vkb+Z/FNzLUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZyhun8D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZyhun8D"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b3637b90so32352135e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782124561; x=1782729361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3r1/tqF5BE50TrdY3pFWW8BNC9rn1rlUywnd4aQCIHY=;
        b=qZyhun8DCeuZzqZs/lw6On90VI371A97ScfvVbN8iDFB2m1w1ddxiqNhPisByPYTjI
         m381MoQedlAIPNCEfJQ1Ig9LMgSTJFv5uOg44q/CSiD2Rr9NbJBe5v47j7BdBUasyRMA
         3CbicYGh3O4Ql2zK8BeD0GICbBhfs1E9wFr20hjYKTcrpuNmfNHdw8h7aqYvy6g4r4ru
         MNEPt9Y1I2PsIJYu9EsN33SVqTSCCrvms75Q+eIon51Xl5r2OMpmqNggWOXcmrUarAZJ
         lX7tX0yzVELJyEnl7OrkhyPW0BJvJ9YjL/JoVgOTf1pgLr3QeM834x32zU7OnsmznBNf
         K+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124561; x=1782729361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r1/tqF5BE50TrdY3pFWW8BNC9rn1rlUywnd4aQCIHY=;
        b=gxYTDO4jFJqFDTquQQ/23KbK68U07HB9ecgiluzusyhy3APLZZim1n0h8ZEV+5ay/L
         4AcXPbHmvs6Vz3V7/KS6PRb62L92KL2uJULGQEx0xhoucIGLtETk331yGUjdbxiDqqnx
         BXqngx3RRvqWA/jhKp+Lwr6s+XRoZUfqVAe7x7QKwMHEBtyUWqftjJW1nXHKR7ILyahE
         xx96YtogbFBL5SJ5DstgKdKepjc65an7o4f2mK1R0v63zXSLS6GclXtv4o01BtHfxSM+
         lWEs+TR1Hv0RQUI3QFA3+QVOx/s/c0j7Etx5+75PCicH/jUkOq3RVPhzCyOdMp0lduvm
         LAaQ==
X-Gm-Message-State: AOJu0YxaVblQoN+k4UMLIP5P7xfA6FPqOcnXWtAAloUrsrqPuleBFZ2q
	XVnN6mKjxL6TL8i6bw+hBxaxqiB7G1KdpyUWlFZVCbG2j7C6toz9Rn8K
X-Gm-Gg: AfdE7ckXyg9V4bcyi/rvc66GYDKzzd22RhD91gPmsmNJvz9g5FBjYXIvQ6ZNRpTYcrZ
	PgKCWVr98zXX2P/obPxhxbVi0mSE/8+0GMxG96WC2fyVuu92HejS+RD80G78Q3x3N225NtExc17
	NQT5MHi6UiZ4VWwZBQoQh012uAkQEhejN8jruBIJt1m4gupu1I8ttJq9hmc6dcTi9do9jBZ2CUL
	wlEKzVvaDAvHu2FWNsDlw4i/oSJxbt/3bT8wI/AfqWznZWISsETQGnUfMI6+4+gnY5zhIJ9CnfB
	sf5pOtScvzZUA8TpTt5Xg569JHDFhyJrqjHzpV0znqenFyRWB3hlSl0gXknZf1AmmY3Sle4FRRg
	zIvxPbccozrJIWWqFjMGjlRScNvqZn2eSx75hBkUotCcZzbWn5MQdCLmiGo9Km1jNfKfTzU2Wsz
	bVB2TtYpQ98KH1eCE=
X-Received: by 2002:a05:600c:828a:b0:492:5297:e8a3 with SMTP id 5b1f17b1804b1-4925297f415mr85451635e9.20.1782124560915;
        Mon, 22 Jun 2026 03:36:00 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924594f8fasm184523775e9.0.2026.06.22.03.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:36:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Jun 2026 12:35:58 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tracing_multi link info
 tests
Message-ID: <ajkQDtC2PGX-gqLN@krava>
References: <20260621204524.61067-1-jolsa@kernel.org>
 <20260621204524.61067-3-jolsa@kernel.org>
 <20260621205350.ED2741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621205350.ED2741F000E9@smtp.kernel.org>

On Sun, Jun 21, 2026 at 08:53:50PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incorrect assertion failure message tag for invalid `addrs` pointer test.
> --
> 
> commit edec3b6e703fee4df106f0b3f019e87b22c606fc
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Add tracing_multi link info tests
> 
> This commit adds new tests for tracing_multi link info. The tests follow the
> existing logic used for kprobe_multi and uprobe_multi tests.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > index f589eefbf9fbd..969f04ee9ac6a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> 
> [ ... ]
> 
> > +static void verify_tracing_multi_invalid_user_buffer(int fd, const struct tmulti_target *targets)
> > +{
> > +	__u32 ids[TRACING_MULTI_CNT] = {};
> > +	struct bpf_link_info info;
> > +	__u32 len = sizeof(info);
> > +	int err, i;
> 
> [ ... ]
> 
> > +	/* Invalid cookies pointer -> EFAULT */
> > +	memset(&info, 0, sizeof(info));
> > +	info.tracing_multi.cookies = 0x1;
> > +	info.tracing_multi.count = TRACING_MULTI_CNT;
> > +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> > +	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_cookies");
> > +
> > +	/* Invalid addrs pointer -> EFAULT */
> > +	memset(&info, 0, sizeof(info));
> > +	info.tracing_multi.addrs = 0x1;
> > +	info.tracing_multi.count = TRACING_MULTI_CNT;
> > +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> > +	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_cookies");
> 
> [Severity: Low]
> This isn't a bug, but is this tag a copy-paste error? The comment mentions
> testing an invalid addrs pointer, but the assertion in
> verify_tracing_multi_invalid_user_buffer() uses the
> "tracing_multi.bad_cookies" tag rather than something like
> "tracing_multi.bad_addrs".

yep, will fix

jirka
