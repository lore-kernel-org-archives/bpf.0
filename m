Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F053988F1
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 05:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897791; cv=none; b=fyfxNtNGPVNULNb49flhEjMCvqki6/S0ZuhmfQIJMKZOgK7XPh8umpkJwHbjY9TD+oUk0gw7jfB+aGxbFQsv77v/hEkeyUz5akWd0RkyOo0UBB13a5AAb/tQMa8GH064d3Vlf7YjPchX+15WGPb/LdybFtsmdzjkGKBjUxQhWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897791; c=relaxed/simple;
	bh=ARXGpKGSv+wFbQn76JoTF1A0AifOAZHXD6ZAzHYT/hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm+xoX1gEVvj+jI4ygI005miEo4fnQ1il9cwRbCmZQjcv16FX2vDOvQ5z1VbzWU7Np7FXNO1n0BNDzW1YABhpb1ILrQ7RUXom6MCanoWgkkWn9Ckp/MaRRO5lFgmLz8XOQeGq+dFZW+Amkg6pjTjaeLYVdiXVITUkFz2F+4l5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gray3KNg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gray3KNg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48538c5956bso4311715e9.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773897788; x=1774502588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DzguALJgsbQWsGNyPBjmaMszA97C5Yts14fuFwzMglU=;
        b=gray3KNg3ft184kmjG1MTPTr2jtp7RS5McWiPpKypDCOgelPertU6jf6baN5Pvwy2M
         2FtNob1e0oIFLepIG77+2OtTHp0JLPAf7M4OxzRR5a8R5XiNpuVic4v8b35pv/m0i4JF
         jfkVGU8jwXh1bvWSNkYPvovZz7QCemiore9S0JioiJBuEieqRWJtkjpTjGU4KCPPIDe/
         RzshtXZJhE+w+tG9M9G+8Dy/lyKfIL5aJ3VHICPjnjCsxxCicEdXcEn906QHGd36nhsa
         F30/7iRBOAob/AkDLekx6x2ruFtO2PEVIN92Lc1rHylpo3RJeuoL5nV7r75YQCu7KVyc
         9Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773897788; x=1774502588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzguALJgsbQWsGNyPBjmaMszA97C5Yts14fuFwzMglU=;
        b=W4wCSxyC0qsFKfrOKO3YRgj0wte/3ilOjrXEr77wyvJw5Gz0GkNIl9dX14ZBL2TIjO
         gbRywrPuXKQ6wiTjfWSXA3PtJF+yEzL0XjbX/YLBjUO5kReJxM67lQhDde40N1qZkevs
         Y/tVINVKsZgOukEFjew5O4wpNd7Rs8MVZx+T3tKY2UYWutg70E+gY1uOzGgKXCPfuCRj
         T1OewPnRs2hoTsD/NhW9NdddLoDz5PrYIg8vAblE7tiL5+uhyvW8lpwHTaXhP3yd/f2R
         AFNT7HY9koZtis4ws2Z74L8poPHV9qaitwCEwzCWEqSbbsjWJOXEUe26HkOfyu6yTf94
         tFBw==
X-Forwarded-Encrypted: i=1; AJvYcCVmiPDkIk+cxZVA+eFRFVleK4WVdfMzJA4LnpGdp45WY2c6/iGOjHnYrKRMUz6qBcHQyuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyo9hin+ZH+mE+/4LPDRP8tGHU7TITMNsefydzEz2Y/Z4hRZjg
	W/RIsYmOS2pcgo6ip/2juR6KfvehfUhetAlDljB4oqc+KP36oOsZ4HfXMEVPleEfliOaIiWSkUn
	179W0Hhw=
X-Gm-Gg: ATEYQzzbruvotRF/Jn3h5BVBLxQ33aBucLci25Fu4ap1vXRiYdS4H8rg2yTHruVtQ19
	HsjjeU1vP6Xmmmsl2LKaeCSm3NcdX9P6PZef3c8FSpzB4KYYJcMeaWTe6C83IIcE0KWv6XTIMih
	rU0BCguyvEASQxjpmkwynqNlSBP+FeMao1pU9AbnZX7h8C/kghMd56uE6B1J40gB5vNC8wFxV98
	mTelfirReAm7D3QQkKk9g2nxDHM6Dn8my0HE0ljJVawL0OtZ+T3xEBPx2IAwSBH0Y4EvFEkHjUo
	FVBmA8i0GNpd3VBkdkV9lStJ1fIwS9h/iGSInQHFneaSMqTm+iw9lCE6KCLL87DijhfEgaLdPkw
	EWF36P6/TTyXqeoJ9HJu2k4+P7fGmGt8pl5qDr2T/xnCsOlEjbVZ3dNgHnse8UJGHWHy/dFzECq
	QwTy/3wO2q379ZH5qjIQ==
X-Received: by 2002:a05:600c:3556:b0:485:3038:72c2 with SMTP id 5b1f17b1804b1-486f8b91f3fmr36196465e9.17.1773897787782;
        Wed, 18 Mar 2026 22:23:07 -0700 (PDT)
Received: from u94a ([2401:e180:8dfc:66a:a219:10d5:f609:370a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb51d1sm5711659b3a.28.2026.03.18.22.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:23:06 -0700 (PDT)
Date: Thu, 19 Mar 2026 13:22:55 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Simplify tnum_step()
Message-ID: <atwy3evusj7cjafp3fnrzgimj3dimcyuxasohegjc2enplb3cb@4l7i5hoe2ify>
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318171906.53174-1-hao.sun@inf.ethz.ch>

Cc Harishankar and Paul since they've sent the original patchset that
added tnum_step().

On Wed, Mar 18, 2026 at 06:19:06PM +0100, Hao Sun wrote:
> Simplify tnum_step() from a 10-variable algorithm into a straight
> line sequence of bitwise operations.

Nit: my brain is a bit fried trying to go through current implementation
and this new one in parallel. Would be nice to get a short tldr;
something like

  The trick is realizing the problem can be simplified to finding a
  submask of t.mask that is greater than (z - t.value).

> tnum_step(): Given a tnum `(tval, tmask)` where `tval & tmask == 0`,
> and a value `z` with `tval ≤ z < (tval | tmask)`, find the smallest
> `r > z`, a tnum-satisfying value, i.e., `r & ~tmask == tval`.
> 
> Every tnum-satisfying value has the form tval | s where s is a subset
> of tmask bits (s & ~tmask == 0).  Since tval and tmask are disjoint:
> 
>     tval | s  =  tval + s

This seems the key to simplification, quite interested at how you came
across this.

> Similarly z = tval + d where d = z - tval, so r > z becomes:
> 
>     tval + s  >  tval + d
>     s > d
> 
> The problem reduces to: find the smallest s, a subset of tmask, such
> that s > d.
> 
> Notice that `s` must be a subset of tmask, the problem now is simplified.
...
> A Lean4 proof for the correctness of the algorithm is also available
> in case anyone is interested:
> 	[1] https://pastebin.com/raw/czHKiyY0

Cool! First time Lean4 proof showing up BPF mailing list.

...
> -		res = w;
> -	}
> -	return res;
> +	d = z - t.value;

A bit of comment explaining would be nice.

> +	carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
> +	inc = ((d | carry_mask | ~t.mask) + 1) & t.mask;

Maybe break out the calculation of inc, give it a name (next_submask?),
and have it as preceding patch? It seems generic enough that I thought
would have been implemented already, but bitmap_scatter() was the
closest I could find.

Perhaps could be submitted to include/linux/bitops.h in the future.

...
