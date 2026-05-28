Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE13F0AA0
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973990; cv=none; b=koaPkFKxPWDlVJ+6uS8RSFTvsZqEuhtZaRVTMCo3SLv2OYDDlfASjNyIqdv2jWp7BJL5ClOQi+gKGWw0z9aBlyg2qERhoa4HV56+aXm9/5g+UZ27kg5H5dCjcXnd/P+3x8gnFNnqH0Q5dMZ/OPyEHje7pgGlqSSPzPJAARUyPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973990; c=relaxed/simple;
	bh=NTVHnbYBV4uXxWlloyC4TfvYryT/9v1X6TIIv7txj7I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFj0IPMEuPVjrtKhF0paaJ1WF8z4sWGjt7+2P+ie/tN2HMw7pKD9+rczlqhN6n+7gE4KZPOZKr1tSLKE+341qkbIPN8ZygKDgmaacPJ8Lg5hGzhFPXNKWThmJR/x4ITi32rUxE+q8vCN2bkUJE0PlLtLu57+lJh1k4vhWwZ7/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/TcOHWS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/TcOHWS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso82418285e9.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973987; x=1780578787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWleOhWDQKLYgEGGi+3bPvOgQbWXJGxbxjY3SEegUiY=;
        b=m/TcOHWSQbIyEjUXaeCEFKaomgm0ug4ijn0w006rGNTm+D+Z7hbaanW1N3XziJsnJz
         6d+X9XJtDQnnJUKwrKMUXb/uB2AaLdu/S0vMfniW5xuDDkWEofDGoEeW1V6Ty/iYgSwo
         cB1CaKj0ijV1t2Bo+iBOCUhu2QopXPHiAhqUVTCmuh07XETylgrxVp1/ZCGPT1X4WL31
         hhALqWACXX6p7hxrRiJPx7ItJu9fJbAn6LAZ08f082sfh4XBF90TY/gBPdMOkOuCx0Rh
         FgXRduUrZJcbPn2iT169S2g3Fb/Wr85svXO7F+bQYbNmbPeZQjVV/oZTTINGvpEPuGBf
         zS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973987; x=1780578787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWleOhWDQKLYgEGGi+3bPvOgQbWXJGxbxjY3SEegUiY=;
        b=C8Wsqaay3LVybj6F7zjl4PCmfdbd600y3JUTNGgsWQR3eWO/Uo+MbS824pVafKL8IU
         w7PVV7YyTj3rDu3NwlGPFOIW02hsAR0uLg78CF9J+aOBQJJZrnS7HE5C8duEHJq78jNB
         +xjSpXpkDAVaaP2vNjFQD4VjK1kVEkJUKcqBzzkLFpDfKN/tpZxFs4W0RFLZFGgCUqrP
         VccLUoIzwHOcayTUU1gmuCivSelenKizajE0b6gUddlj59BKldMG7r/AqBkYRt8uwTKH
         6wJi0un9jRu8+r1XNrKSkxVghABm4UU1CCK37JXiR2dNlTxnuCghFRWeXyQzND4dmVzO
         /IZw==
X-Gm-Message-State: AOJu0YyIM+pSxPQu+zQNt1UL+iiuxYUJCoqzXMRwCBBiSA1zX/PEaH23
	8TCJLfR3iQcCIVIjBeXorXTR7TaKx6gizWRKDfnMUg1DSeCIm2nxWJhuCFzWIA==
X-Gm-Gg: Acq92OFLtbjjPwfy2M1dMokl8ZY17aOduBrzzubYlOGzTb7kBSxIJj0U+sEcxERgJMN
	tX8Sld41TemsdcZYngvrj6JMDt89mQl3BDyPHa4lo7qgJ1WUR0g5f1O5cz/d3znw6KR1GU8SIXu
	X1amY91WOmhMsALr69slCvo2RgVIZOIVqUnv+ich7iLvWQkH9fKaPt6YgDRhthfPDcnp4Q1XonM
	1zp12dzRmt27C/1mGjMYHAVX6GoRrfsLWSL5GuU5WsfKau+COwy1ByxK3pNpJec685afAqq6OxZ
	FmxshC64gwZMtn/eamapY5iBn8bMqu5D6GoFchjBaABiUQSVHtx6aOG03KmEHJEEB9TjXhAtOrn
	0Xh1w7pBtGezYRwO0bQEHnv1jxINRhyauQpAEO5r/fzJPpmvtahYYt8OLkrYz3sHMIT05AsWwtL
	co3xvGhKedUBy//lpE7b5TfUheaQ==
X-Received: by 2002:a05:600c:6383:b0:490:4717:970f with SMTP id 5b1f17b1804b1-4904717984dmr451274615e9.14.1779973987004;
        Thu, 28 May 2026 06:13:07 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909264fbf2sm41240615e9.5.2026.05.28.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:13:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 15:13:04 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv6 bpf-next 04/29] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <ahg_YFpqlTGYQUay@krava>
References: <20260527113951.46265-5-jolsa@kernel.org>
 <20260527122143.CE5ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527122143.CE5ED1F000E9@smtp.kernel.org>

On Wed, May 27, 2026 at 12:21:43PM +0000, sashiko-bot@kernel.org wrote:

SNIP

> > +static struct mutex *select_trampoline_lock(struct bpf_trampoline *tr)
> > +{
> > +	return &trampoline_locks[hash_64((u64)(uintptr_t) tr, TRAMPOLINE_LOCKS_BITS)].mutex;
> > +}
> 
> [Severity: Low]
> This isn't a bug, but could we use the dedicated hash_ptr() macro from
> linux/hash.h here instead of casting the pointer to u64?

ok

> 
> [ ... ]
> 
> >  	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
> >  		/* This is called inside register_ftrace_direct_multi(), so
> > -		 * tr->mutex is already locked.
> > +		 * trampoline's mutex is already locked.
> >  		 */
> 
> [Severity: Low]
> This isn't a bug, but since this multi-line comment is being modified,
> should the opening /* be placed on its own line to match the modern
> BPF subsystem comment style?

we have comments like that in this function and plenty all over the
file, I'll keep it


> 
> [ ... ]
> 
> >  	 * In both cases, direct_mutex is already locked. Use
> > -	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
> > -	 * (something else is making changes to this same trampoline).
> > +	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race condition
> > +	 * (something else holds the same pool lock).
> >  	 */
> > -	if (!mutex_trylock(&tr->mutex)) {
> > -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> > -		 * some progress.
> > +	if (!mutex_trylock(select_trampoline_lock(tr))) {
> 
> [Severity: High]
> Could this shared lock pool cause unrelated probe registrations to spuriously
> fail with -EAGAIN?
> 
> If a tracing tool registers an ftrace function with FTRACE_OPS_FL_IPMODIFY,
> ftrace calls the trampoline's ops_func callback.
> 
> If another unrelated BPF trampoline is concurrently being modified and
> happens to hash to the same bucket in trampoline_locks, this mutex_trylock
> will fail.
> 
> Since upstream callers do not retry on -EAGAIN, will this false sharing
> lead to unpredictable probe attachment failures under load?

I addressed that in cover letter:

- after discussing with Song, it was determined that cleaning up FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER
  is not strictly necessary — keeping the trampoline in the ipmodify_enabled state is acceptable.
  The race condition this introduces remains unlikely, so the concern raised in [1] will not be
  addressed at this time.
  [1] https://lore.kernel.org/bpf/aec7bAbGlnEo3R1g@krava/


jirka
