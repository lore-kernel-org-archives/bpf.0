Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706077;
	b=D4UNxNuLIPNpcuulJLHqdYS3qgkQUkNilL2CEMnRG3eqygnfC8dAybRet8zCSqNb9j1/
	 tNMntyxpOwGInC65OMaPWBboe4YwauzgGyyacH0HNrd8dFh8NOsTniC2ZSw4sgFymxKTs
	 RwwyZ5hlPR/kkQ+dWPrbNBHfwKsrk0Jgf3hcmf0bHRMsnNK+vAWbwsUE5kljVFmonNJBt
	 YlQc5N9dTkGe4NCiY/eqvirmPSpLnqaZ2IgHGO25YVYkai4AKRMx8dr8DpoIp2v5DZHPM
	 T3AApzu60QhN9DXkbhQh2dTu8aZeQrtMTQqnrWaiiuANlMuLVAdXfG5kqcRm0Qk1u2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BWpuhH7HKuyTH5YydyoQM9mt4Q3kHiFQksBEODQpXNM=;
	b=Np6SJwMgSJEgiwBMwtVvy1s08jehU/PtNlQkLgQdpoW3b4/DXHaETDKGM5GwDs7rKQPK
	 Xe/x4Lsxnat/7oYTvbBWf5N3sToGi16EqkCjpMPtCWdLoIlZWMJYsPScFJui0OqG6qGkI
	 GD7rxNMxWsoWVtikhqfmqfQmqoO8Brk+G9+Uk6wu5t7AE8PnIbQ6zFmYVs5pkaVd2E09k
	 jb77qisp//+5shGHr+Z1pTwZMqYaoawOAdk2VF3wGCbMfSs9KlOemSNjU906DzNCDB0oa
	 tScfEA5ddAmvZt/wvPAb/r1FXVV10wNwow20Am+vCiYeBfYrMxWYC0BqznwUS9wqQ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RlFWDBFe;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3588606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3588606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RlFWDBFe
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491971ac844so6348903f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 07:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795706075; x=1796310875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BWpuhH7HKuyTH5YydyoQM9mt4Q3kHiFQksBEODQpXNM=;
        b=RlFWDBFeu5WTPqW64Ptc2JJXrjxfzc1CQ04Q8KxzoRcDAJ8EJNZDyd+EoAU5245bF7
         ei0O1zdj3xsl4myuPcZ2aDc38i0zap/DXxFGuSDpsL+Oqp1ANfClcKWgtJxgrfBN+OQL
         86+Ndwsk9LGlplxo34QgkZIsu7bp+UI820HzM+ryYhXgmLTlGkrBJHgTrOGmX/0lXZmJ
         3Kd2XK7H8VN/rvflOn/bUEo58Akud6E/ClWEdBbHJN4LB6wKF7zXAOjr0vdS82Y64NT/
         oA4c9ZpXuAyIIyK/It8UwD8pkNxlRxOq8jyrTEgNyQcrtwDOCsY+YErW7GvOCtHLclsW
         G8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706075; x=1796310875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWpuhH7HKuyTH5YydyoQM9mt4Q3kHiFQksBEODQpXNM=;
        b=K4hABfO0NNns9BWtH2xkl4oxMyJR1fLzDrAC5Fx0Ox/8GS48KmzLS5Y7FqgtClRn0w
         MF1YhST6et21vv0SUvz6urxo+7nq8vgEoDSy3x2MlmDDTDOIiSUmH+QhvfM3UbsHYpCI
         ZrQgZbYpT30PsplmSmjE/akLM5pZ0VpDUfAjBz6P/oTeI/lbdF0HeibOkm/B78KL0uM/
         NAYcHzPIt+YtJP3YpIUjrUfTUUGW5q2yntu/xb3TSIUb1iWBjNHkhIQT0B8Z8kHxmi9o
         inLgls60esJqtK+4Rheh3vqq2dfoMSBsynqlO5+4Zu2w7A5AIPWwd9WFTiHJFSEZMFOy
         WGqA==
X-Forwarded-Encrypted: i=1; AL+hErFlwWXY5ihghQbW2S5utKHSsAq9Sm7j+duL9dTLVpDK9HsYIUxUQw+iS6f7nAgpyic/ewI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LdG2gp54K4JltaA8lkfvsLrbfjOYD/eVjMei26AitLU+Rp8Lh
	7yOfuzQrRbXKOveP2tCX1m8c/SzhhLt25I+fwepjsAnINAuz8NMmcR11
X-Gm-Gg: AZFdTZc5oEN1hgOffrqcmy1YUZooqcyyZr/FFZnm1kv6QAnTTJPTnYpCN/NinxGO4E9
	6TOMr5y78LliecVM6jfcJ3ffAJfLV4ToHzI6O2YN1Q4hFvVI4hsoj7N8PMvpNQ7RaIVopKWeX3M
	HGmRH2govNMmKxpQ2/raLyO74/n6QvrW3fxI27rO2pf1AaOY+3k6xq0a22Yf+onG2RpcemWR9UL
	ETghtXuh5E3qN4OtAonJejXkFwj9FCWKOCURl9jT8Ovpb1+9c4HGq7frXKcMz4KM0OCNr/txsaf
	I8YT8hOqbgPyFLtLGVmQa/uFwKekU5UGN7AJjrZceO7LK6caEiijV0/5Vy2U4h817AqD8fhymcG
	YSvm92iT+b1CB1W2RhXt1YrxM4PiU+xvGsQZZ36Zz9OtdtfDFCUhrC9LxPnnyx7qqHkd9DLwBb2
	fniT9jx3vjFOPFP2VNZ74e84NVyNwB98IvG0ryPLBMpAfjHeAnRC04BKdeo9kKbBuhyGMunnaja
	/QGarDX2yQdxODVT5GchNwHAlbN3YOPUFGFtBO+0RDiaI45p1rlG1Dv/ysK4kogyRQpVzIkZsP4
	vlhMZ3jp1asCxHPlr6DR1/hwzk1XGz5AvQQSqQ==
X-Received: by 2002:a5d:5d10:0:b0:4a7:f82a:7f6d with SMTP id ffacd0b85a97d-4abaa9769demr45441761f8f.6.1795706074952;
        Thu, 26 Nov 2026 07:14:34 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm39669758f8f.36.2026.11.26.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:14:34 -0800 (PST)
Date: Thu, 26 Nov 2026 15:26:11 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org,
	almagui@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 bpf-next 5/7] resolve_btfids: Exclude bpf_*() and
 __bpf_*() of vmlinux
Message-ID: <awhPk5btWvLDaDxT@mail.gmail.com>
References: <20261126142915.1106330-6-a.s.protopopov@gmail.com>
 <94179833c6a4aab3dd44ee9d28f3f25f9e912c027ab41e82c254322c8dea91da@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94179833c6a4aab3dd44ee9d28f3f25f9e912c027ab41e82c254322c8dea91da@mail.kernel.org>

On 26/11/26 03:01PM, bot+bpf-ci@kernel.org wrote:
> > resolve_btfids: Exclude bpf_*() and __bpf_*() of vmlinux
> 
> TL;DR: Comment and commit message only: the code also excludes _bpf_*() and
> ___bpf_*() names, broader than documented; the review asks to document this,
> citing _bpf_getsockopt().
> 
> > diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> > --- a/tools/bpf/resolve_btfids/fmodret.c
> > +++ b/tools/bpf/resolve_btfids/fmodret.c
> 
> [ ... ]
> 
> > @@ -105,6 +105,12 @@ static bool excluded_by_name(const char *name)
> >  	return false;
> >  }
> >  
> > +/* bpf_*() and __bpf_*() */
> > +static bool excluded_by_prefix(const char *name, bool vmlinux)
> > +{
> > +	return vmlinux && !strncmp(name + strspn(name, "_"), "bpf_", 4);
> > +}
> 
> This isn't a bug, but the comment and the commit message ("Do not tag
> bpf_*() and __bpf_*() of vmlinux") describe a narrower rule than the code.
> 
> strspn(name, "_") skips any number of leading underscores, so _bpf_*() and
> ___bpf_*() names are excluded as well.  In vmlinux these include
> _bpf_getsockopt(), _bpf_setsockopt(), ___bpf_prog_run() and
> ___bpf_copy_key().
> 
> The broader behaviour looks right, since _bpf_getsockopt() sits on the
> chain the commit is concerned with:
> 
>     BPF_CALL_5(bpf_sk_getsockopt, ...)
>     {
>         return _bpf_getsockopt(sk, level, optname, optval, optlen);
>     }
> 
> If the compiler keeps _bpf_getsockopt() out of line, an fmod_ret skip of it
> would bypass the memset() in __bpf_getsockopt() in the same way.  A later
> change that makes the code match the comment (for example, two strncmp()
> calls for "bpf_" and "__bpf_") would reopen that hole.
> 
> Could the comment and changelog say "bpf_*() after any leading
> underscores", and name _bpf_getsockopt() as a reason?

Yes, it could. Will update it if v3 is needed, otherwise this doesn't look important.

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45839706175

