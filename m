Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6A3CE098;
	Thu, 14 May 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770361; cv=none; b=nrCmMknKRloFkrX14CsAtHkwHoYXPBzG/YX4QXb/u3JY0U7+KU9RP6n1jypIWCuvbTVy9LUF+v/PGmlRaBHiiG3MdP49JzCcEEYf3obTKxhBC6EPCrfrusK72fRWAYT3hnL4tKTzKbjyd5upFSz4uoRztd5/ZkoqMLtjOD01N/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770361; c=relaxed/simple;
	bh=JJJOVJikQnlVfnlPKoBMfb9G3U4vH6Xwl3VpWCTgAsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COEM1kX8zB6YShoWT0/uIA5Ze0rD5ntX96S4sdhhhFzEaS0po2X8L1dPllkdpr6EmbsDqWlApD8nut5/QMGRdDSQbRpIsMSW1+f+YEgVOC+Ei9obO/AinmTRJRj2mD26svQADXD/grqliMqIXcXGjfuQ2gJM3VoZvtv1vuD7SRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pIUoeYUb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pIUoeYUb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HApBGbUIopWE1eKRprPbgwODOdGqjWiFYdpjK0iQJgw=; b=pIUoeYUbHBZQ3fl16jbbkB7Vti
	+gJ49RyJnSxsRufj0QoSyUy5UY7Fhs/oBXOaTFsa0Y25zYj4VjY6QUbsbykrNpTBhZz0qjMUSuOYv
	1TJuM8bbEuW9tInprDCfBRvkU6gf/vQpSBJc6fPkz2pWWqt+zsyHIgtrqc3hb1/3WoOkLS1J4ZHPK
	m4n3uR9QBDoQqWHLdmTWlExrw3nQn6y1jj1YySa8TNS2taAZddWBzQCKtQkzysi4yTXtenqIzyOQg
	5OqlYwfV0AbbnJOE25dFVLsDJPnmw/b84g+KviVXIoyiHUCgN0OUCLGO60gthrOys8Bm2BHt2GRTL
	VXXE8/LQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNXQS-0041Fs-31;
	Thu, 14 May 2026 14:52:37 +0000
Date: Thu, 14 May 2026 07:52:32 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] atm: convert to getsockopt_iter
Message-ID: <agXhTGVurhrJmBNu@gmail.com>
References: <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
 <20260514124501.43BC2C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514124501.43BC2C2BCB3@smtp.kernel.org>
X-Debian-User: leitao

On Thu, May 14, 2026 at 12:45:00PM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/net/atm/common.c b/net/atm/common.c
> > --- a/net/atm/common.c
> > +++ b/net/atm/common.c
> [ ... ]
> > @@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
> >  }
> >  
> >  int vcc_getsockopt(struct socket *sock, int level, int optname,
> > -		   char __user *optval, int __user *optlen)
> > +		   sockopt_t *opt)
> >  {
> >  	struct atm_vcc *vcc;
> > +	unsigned long val;
> >  	int len;
> >  
> > -	if (get_user(len, optlen))
> > -		return -EFAULT;
> > +	len = opt->optlen;
> >  	if (__SO_LEVEL_MATCH(optname, level) && len != __SO_SIZE(optname))
> >  		return -EINVAL;
> [ ... ]
> >  	case SO_SETCLP:
> > -		return put_user(vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0,
> > -				(unsigned long __user *)optval) ? -EFAULT : 0;
> > +		val = vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0;
> > +		return copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
> > +		       sizeof(val) ? -EFAULT : 0;
> 
> On 64-bit systems, val is an unsigned long (8 bytes). However, __SO_SIZE
> for SO_SETCLP is 4 bytes, which is enforced by the length check above.
> 
> Since the opt->iter_out iterator is restricted to 4 bytes, copy_to_iter()
> will truncate the copy to 4 bytes and return 4. Does this mean the
> subsequent check against sizeof(val) (8 bytes) will always fail and return
> -EFAULT unconditionally?
> 
> Additionally, on 64-bit big-endian systems, does copying the first 4 bytes
> of an 8-byte unsigned long always copy zeroes, ignoring the actual flag
> value?
> 
> Would declaring val as an int instead of an unsigned long resolve both the
> copy size mismatch and the potential endianness issue here?

Good catch, dear LLM. This seems a real regression!

val should be "int" or u32 instead of "long int" in this case. I will
update.

--
pw-bot: cr
