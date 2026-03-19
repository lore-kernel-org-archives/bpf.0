Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356D37419F
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912912; cv=none; b=l8TTCoKi2SxRYG1OAlObGmbns/bZhaaVndLfDNgIxlGoZTBXYk3WnVlec2bym1qSQ4+JPDLDxrLyCrZipKBR06Vz4jx+rLYC+0joVy3p6BP6GXPi9cInD34dDNaVEfSrPXOV4YDcjqDNlxtY6piJJitV7NZC5ROFjpBdxg5eL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912912; c=relaxed/simple;
	bh=hwNOGXQH89R2fhkpymstdIQmva8Np7BQfA1d47tkCtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuLKtDGtT7hsEJn+dG0t9Yu1soTVjCqgTbTQX5J1H7hqV4pcO9ZzOIImlF3nafiK/HNsHPK26jZy/qP1yOlqpx+b3lXxzdfHLtYfRieu7xlHdBvOvr6r2yteszPtVfwoUknb+m8SlUYL606nXEg5VdzEvbWUt4KnTzGUQm/QYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKQa8S+Q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKQa8S+Q"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b9b1900bso432381f8f.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773912909; x=1774517709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsi6Snfpldbdx/qVF6kvcZDyl3BM2Mth+ewOT8FmjRc=;
        b=RKQa8S+QA6StoDWl3nxQ3GDmufmRq3T8GLtQMkCqH92aH91z6Ksnuc8/igDHy0bkk0
         SrFsxL7k87ESro+1FdvnGdA55NaSyAtq3c+slCmNrYyjcS95Q/6ED5r/deSwInwPaMQ5
         yeM5j2q0lqjO4YILnKZp6J4svc1lBT3ZFJbdT0HqCZ2Mntcd/XIc4T1S+l8JCy752/Dv
         OjO1n37ueuHZ/En9uRmuMTnri2dRTl2j9UhckGi+Cc7iDGCaHUY8jN+g6xjY1O19O1Ic
         oLiek510v/uM5VuYDgfE64sDZX45/B7zqo+vh5XTBrgxjbBNyA25AhQp5gmTjZbqnmCV
         9s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773912909; x=1774517709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zsi6Snfpldbdx/qVF6kvcZDyl3BM2Mth+ewOT8FmjRc=;
        b=aaVOcceP0K9hqF43y16cm8+cL3TWrL2abKqHgDk+Xv6hyzzO8pLwd3+VlR1ZqV3T4O
         oKZT5BxkiRKpNNY0xqHmmEdoOBWroPsDFq+7AayeleIVfktCpezsgmGUx+ean8mxw3gk
         HeAk5TAjd9qe89fXg5H+l4CMRyw0VCqZX02mzFj3HslB5ZclmDpqQwd5HPtdFei5u+vF
         uwmz9DZTGwwXnOsAAsCO34H+/TK3WQeEmT4lCLd2ksIh3Cp9GF68lOSVV2TAKXc4uFG5
         kYcFUv7o/g7pAQ6lzmBbeCY4ALtrhG2519ytBZKFBIxm7CzAPTIu4IcYi6LuhKHSg+1n
         4dug==
X-Forwarded-Encrypted: i=1; AJvYcCURqOo6QCzJmH5HzkobIpcWrroCq4aGJq44zP2kuKd0aPSJkY/ku47UDkr38mhImpJ7r2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2lYhRf9UFgruDzHFcP0rjOL4y5L5pyQ425bq7+K1IzDeWw0r
	/lnS5M2aqd/zXLVyxiVCq+X6BYBItlRIYC6fLXPKlFLWV99HHwrDjcHx
X-Gm-Gg: ATEYQzzTszncTFltv0KEoTiAx6Xgh+zkSty4+fWbnL2IWBdAO5w6D2dg8kWzuesf7VD
	brUJk91uUbFfLf7LRN6aNUqWxm7xL0NydCl1LeZv/h3afKlSPHNcGoqT5bNwKlm2yHzJUrDGjMS
	Bi0yRQiQIQl2RD8bKQNoz2Ap5T5kT9NfJSpSqGlw5gf2AAqaULSQD/kuW75e1bIVugD0cb+F9Jk
	SD/EBJ0rtF/Sfvowpq+2rkNSnCbirzLakahO8qtQKrGzXiF9nQk8TaCbIX6BCA4QodbhgXpfeIE
	q6wakwJbp7Gyhc2VcBOA6W67Ja0m3+h+YbFdCDvWgaQLD8aFb2TW/NeWVnOSSqoOhq9oVQvDr8g
	lP+zRt+OANsKkMtxCmUSzqhEFAKkELzlgNYaEiFjGer+LmgNZVtzNjiCuUz9lSMT+OqUtc1tfbP
	+1busdhvrYSy24TDWdJXfo/dcLlFr3PPNb+RNxEIVZDtHXFd2ey9Fq1jmjvY2Cd286TOQZjUSVN
	WJ13EjCkDcivjLJThwp7WyP4b8DZsZZDvJZhdAq5DJj9Ng+ZKfMWnF3DiqD+Ww=
X-Received: by 2002:a5d:5848:0:b0:435:9cd5:bb2a with SMTP id ffacd0b85a97d-43b527af569mr11562648f8f.24.1773912908977;
        Thu, 19 Mar 2026 02:35:08 -0700 (PDT)
Received: from mail.gmail.com (lfbn-ren-1-685-61.w81-53.abo.wanadoo.fr. [81.53.253.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184957bsm16111061f8f.5.2026.03.19.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:35:08 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:35:06 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Simplify tnum_step()
Message-ID: <abvDSjl633b_Hb1O@mail.gmail.com>
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
 <atwy3evusj7cjafp3fnrzgimj3dimcyuxasohegjc2enplb3cb@4l7i5hoe2ify>
 <CACkBjsbcv4woDZZ0_BA4idBwfLPXNTX7BzJMXTH54zq_8F0BuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsbcv4woDZZ0_BA4idBwfLPXNTX7BzJMXTH54zq_8F0BuA@mail.gmail.com>

On Thu, Mar 19, 2026 at 10:01:31AM +0100, Hao Sun wrote:

Thanks for the cc Shung-Hsi. We were discussing it with Hari who's
planning to double check soundness.

> [...]
> > > -             res = w;
> > > -     }
> > > -     return res;
> > > +     d = z - t.value;
> >
> > A bit of comment explaining would be nice.
> >
> 
> The commit message is self-contained; anyone interested can git blame.
> But I am unsure. If a detailed description is preferred, I can add a
> comment to v2.

Not disagreeing about the role of git blame, but it's not a replacement
for code comments either. Having just the intuition in comments can help
a lot; as you mention below, it's one less indirection ;)

In its current form, I find the proof harder to follow than the
previous, very verbose version. Maybe there's a good middle ground?

> 
> > > +     carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
> > > +     inc = ((d | carry_mask | ~t.mask) + 1) & t.mask;
> >
> > Maybe break out the calculation of inc, give it a name (next_submask?),
> 
> Maybe we can break this down as:
> 
> d = z - t.value;
> carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
> filled = d | carry_mask | ~t.mask;
> inc = (filled + 1) & t.mask;
> 
> `next_submask` is not precise, as we ored `~t.mask` into it.
> It's always hard to name the intermediate result :)
> 
> > and have it as preceding patch? It seems generic enough that I thought
> > would have been implemented already, but bitmap_scatter() was the
> > closest I could find.
> >
> > Perhaps could be submitted to include/linux/bitops.h in the future.
> >
> 
> The calculation above is direct, adding a bitmap helper intros an indirection.
> For me, it means I would have to check out the meaning of the helper
> and then get back to understanding the algorithm.

I think I agree with Hao in this case. If we can reuse existing helpers,
great, but otherwise it's short enough that it's probably easier to keep
inlined here.
