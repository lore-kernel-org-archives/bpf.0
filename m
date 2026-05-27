Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22693E834C
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875869; cv=none; b=U1BJXH/z9cbg62wY2nlSNRo97a60GWPCE8UPeqTfJnSiPHHKx7PhKUz34Y6Ap68mnimcYajwh70DehRDjDU81L1H+lI2HAUDNjh4O4dLDiQT6f5DmXp0KnIIjrcNV8ySphGZ/SVAAC2b9sMeMcjgzD593QM36LTOvTP84jj1RbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875869; c=relaxed/simple;
	bh=rhr6p3Lg7XJ0vMqzbFcdeO2CJajTB0zXczci4HQ/HsE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g856Fnt5pJ2tyABppjaGI3Y7nntLRjlnfhxDAPcnl70qLdw6i9ltd3DyARwqCf2r8PQ7bZ6E9x0yQ/+e2zNzOsJwEWlowGlqXvl7ST1rm7MUsDVpEwXa2kVhv3ykfvfhz1+1cnMjYEaArSvPv9mmsZyGoDWdODcuVADkeYtUdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/L/Lf3u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/L/Lf3u"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so121196395e9.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875865; x=1780480665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HK5/dim6I8THjlnPnIlV2fUiqEghMFcOuVhn1AO2dDg=;
        b=k/L/Lf3u4zd84kdccNmUARhogwRWSOf+kCuW1jYcojLrYxH87hUxCm7ksOLJvxpZP9
         YMumFySwGUCIBEZbFwlfw6ZNZ1KDv8Stpo1f0DwfunoKKWO44EBKB8Qb6m9/yGxyPLl9
         bkkV1BW0pqyvc0fURAzDRkc+RKgN0sct/d4DqlQpsRruz2MRyMr/hA2ff4fMCG7ZvIYY
         N7CAlsvMHoES6kMpmf4uYfrpxLiqBgH6zqS4SjqN6l4mY4R3hgyLjC1Jra10HBf0MS1m
         dHdrnv/Z4Jew7wg1jUFWdF8FS047Y5DMWZ1AHIQsraBOqKjHsoNPPdLYW3jnGlRC8Rif
         oDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875865; x=1780480665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK5/dim6I8THjlnPnIlV2fUiqEghMFcOuVhn1AO2dDg=;
        b=RW2YiPwfSblHKz1nNijNCdgGUi4h1Zhw54h0S4D7d3X7EWJ3BgTyvlIcXCZsY3G5+S
         gfJW+aBxRpROlmm/5ROVWQupRyzsiDSlDWsuPX0tR4rWKqPd6pZb6vUFTXzqH35N8ef6
         9q5rwatcX5QKRjoN4X9paNklhVpJtxuFWvEhTimV5HAHOFN3m5JAraZlNE50r7V+/A7C
         yUC6Jtwx0aqQKfmGjs1tTjoxm/maGYi1mvxJTCTwe/h/qGWkK//FXEdqINcwQ4CaPfOW
         sJ+RZTzYd9lloTe99k4b4TWlvUFHzlsNjI+RPAFSnkRxc+wpuMT8TLsP+cy/0uDa7YxQ
         mxlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8K9DJ+z77TO1PNj6Ir9j2bLuTXfeKof5HZ41KL4Co+GS0mbZsL2rhK2r4laCFsnHKd9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Gs5Vi1F6gDquF3F9g8P27dFlRgqRF0CCuF6dzNKjSw+fu86t
	NdVeAhxZXJ0qSh1XTr9ZRv+97aZ7jCwfWFs2ANnxMaAGbdgbiIE0mnjO
X-Gm-Gg: Acq92OHGlkhb2SGPe33A2t0fx5aXag+R7PF2P3ENLE6sNUKOCZ09qwVedhUSvBUyC8d
	6PKv1l2o8XM6L74UNlCl3UVMtw2CT2GpqtSa55Q6SXQErZbCGT7HOry4j35KN3HpN+OaMsMhlfL
	zcwxCatW5iUNo2tfvsN3AMR/jks4Hu26eqqZqAk+sJJaZsBNhk9ujBuKR7UFHL+JS0Xb/zSxCoY
	oZ79UuQFim0YlhoPJ45hSP3DBgoapFh494mOVH4kOyhCSqucOoQhXPzvSH8Q7MfqYZc+p6slznn
	NiTvDlvBtPWJBaprrUmQws7kwguujOCAVncr1MzF7tVKeyF9myM/2gcGanFJjpE8LScyRwvGMMW
	lHeOjsSCLYyhOIGLR07iyGuI6EPQB/mVliGwXELMTqckspEtD45p+VDhnyEjGOXIsVKjxZmx0Cz
	tUAHrEwdqdrzvQqrcc4vzz5RqeGg==
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-49050580a91mr306966745e9.11.1779875864661;
        Wed, 27 May 2026 02:57:44 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045284855sm390114725e9.0.2026.05.27.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:57:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:57:42 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, jakub@cloudflare.com,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 06/13] libbpf: Change has_nop_combo to work on top of
 nop10
Message-ID: <ahbAFrjEvM5m_3l1@krava>
References: <20260526205840.173790-7-jolsa@kernel.org>
 <4ea9f26531f9e53da6c8e5c8a638ef7aeaffd6b3fb6ed20e742069783e660e05@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea9f26531f9e53da6c8e5c8a638ef7aeaffd6b3fb6ed20e742069783e660e05@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > commit 5ad96df841a0877eeca7d2cbe4b3f726b7fd0b72
> > Author: Jiri Olsa <jolsa@kernel.org>
> > Date:   Tue May 26 22:58:33 2026 +0200
> >
> >     libbpf: Change has_nop_combo to work on top of nop10
> >
> >     We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> >     fixing has_nop_combo to reflect that.
> >
> >     Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
> >     Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> >     Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> The Fixes: tag references commit 41a5c7df4466 which originally added
> has_nop_combo() with correct nop5 support. However, the actual bug was
> introduced by commit af734a7ddb4e which changed the kernel's uprobe
> implementation from nop5 to nop10. Should the tag be:
> 
>   Fixes: af734a7ddb4e ("uprobes/x86: Move optimized uprobe from nop5 to nop10")

af734a7ddb4e hash is not available, the patch:
  uprobes/x86: Move optimized uprobe from nop5 to nop10

is part of this patchset

> 
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index e3710933fd52..484a4354e82b 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> >
> >  	/*
> >  	 * Detect kernel support for uprobe() syscall, it's presence means we can
> > -	 * take advantage of faster nop5 uprobe handling.
> > +	 * take advantage of faster nop10 uprobe handling.
> >  	 * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
> >  	 */
> 
> The comment at the end of this block references commit 56101b69c919 which
> added the uprobe syscall. Andrii Nakryiko noted in v3 review that it would
> be good to also reference the commit that switches nop5 to nop10, though he
> acknowledged the hash isn't stable until it lands. Now that af734a7ddb4e is
> available, could this be updated to reference both commits?

I proposed to change the comment after this gets merged

> 
> > @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
> >  #if defined(__x86_64__)
> >  static bool has_nop_combo(int fd, long off)
> >  {
> > -	unsigned char nop_combo[6] = {
> > -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > +	unsigned char nop_combo[11] = {
> > +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
> >  	};
> > -	unsigned char buf[6];
> > +	unsigned char buf[11];
> >
> > -	if (pread(fd, buf, 6, off) != 6)
> > +	if (pread(fd, buf, 11, off) != 11)
> >  		return false;
> > -	return memcmp(buf, nop_combo, 6) == 0;
> > +	return memcmp(buf, nop_combo, 11) == 0;
> >  }
> 
> This isn't a bug, but Jakub Sitnicki suggested in v1 review using
> ARRAY_SIZE(buf) instead of repeating the scalar value 11. The author
> preferred keeping the literal number for simplicity, though the value
> now appears in 5 locations (array declarations, pread size, pread check,
> memcmp size).

and I replied to that then

jirka
