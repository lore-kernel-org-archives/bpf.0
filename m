Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B939BFF5
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625288; cv=none; b=ndDYrttVW0rJcUNwFV4zFLy4QacMOzqND/NMY6Tpu9ZpN9/qaGkRel/ayquM3GonZHscwg+k4daxnGmhqUVipNf8XkvW2yL/Z86y5CkbasousqMvxS6hkwjzKmo8lVy8fjjaCBAhaOa+vdBGDJQ5B7ACu8jfgCcF6kfcsYtrzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625288; c=relaxed/simple;
	bh=WyGA54gcSfEwPmBZ1yT22s2i71gVY9h4KQNOJn9VllM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOtR3QH7m0TyYfZRoY1HxvOhbdtmBl6yt1XJbCdJgmAGN5aTXBtiKBqtV3fyKCp1PyfQQ4rkJer0vmblH6OYaHUPiV/0BTE9M9XXr/yAmRZitXq9lkr81IfPDMzM6YmqQZg5rOxMn/fhGy4AP+uBmNtiMF8Fwbt3nftW/Qc7p4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dstRc5MI; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dstRc5MI"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82f8893bff3so2819994b3a.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625286; x=1779230086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BO3odHd40A1icJZvGy9LfmlOcg6Cjiu8d7ytO7Oe88c=;
        b=dstRc5MIHPeqEOxtmlAy5cv8RGA6tElsCDjM7mo+o9GHtBgHbGlFwWzu24V52HwjEC
         SQnuqnptEG8XGLwEp40vE4N4L2n7zza2xRNBAPXv48LlwfSLUuQ4f6dkbDs2BJIspfCp
         Xc5OfUI7RxQlzCvcDGsglvQX3nfYtI3d1tKe+Um8S+o0Nrjlkijwn4qh8vJAyWa83SuE
         UtSsTFAeE5F9vjkD2SdAxLT5CdraU0LWzifTXQc+2t+G+kZrd2tYL7v3h9/JFLDHZX0l
         mbfVAq6JSrjw2NSuW1kBelbCGf0NxeAlisIy2fHOIardpVLxi9GKAo4mXzQvyS99Iog8
         1AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625286; x=1779230086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO3odHd40A1icJZvGy9LfmlOcg6Cjiu8d7ytO7Oe88c=;
        b=WTAg5JOsOR4oH9G+eGy7HkLbN5twORx6fWeSXT/0whxwoOyT12sWj/sKJL+X8Xa7Ep
         GJ+tpZVBYysPrxfkpj8Wcj//BrnowTtgh9wcwrkAxrqfHBXLALw8VhI/Mzg6peYqCHQJ
         n2ZrkQ6s4176+b9PXvNwqhZGTeN9iX1cQC3o88VQB8NRzQTDHmQEN+pQHO7f2NVuNGHQ
         6mFsd5jfxm6gT3PEaQzsptonMhDRtA1Tl9LweEkr1HUsEN2upTRwmXYvhJUets5np70N
         p+DhwXWmloAIZysLdMpRAY9+YztCHz/PbCuFKiC0gDPOeni1oMyClTW5C1zs65zTV/j5
         ilYA==
X-Forwarded-Encrypted: i=1; AFNElJ83LsdYFTTePaFBcCSRePsBGL5c2wFi/60NiAs9NxqHE9L6okDbxtS4yZ2a+3niaViCgdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6W1oNnTo7VcC6HtfJi6xkP9ChuE+uBIZg0OFAiIO9MOPCHhet
	QCsx8+nDajx9s9kuXHrEidQWcfrQE9tH03W7Exj4omdDa91DH5MajOTV
X-Gm-Gg: Acq92OF1mL9TrwW88QOKlkzXAh4RXfT/b6SHpgI8DQ6eu5zsX46xVBxHE4Vz2wIKVgl
	EkjwHiBFfsxQCovYR4LPSSrfCwkhFXOfTC/+r9hhMN5eklwxfA5fc9EU3n2VDz8bdFhEcKc3Miz
	4uEeLWc9ndo5oPrUsGFQJhwsUf7E9Qxgkf18NsmBQHufZzzDMf3O7mU7he62k4xVDq+cqmtpe+K
	TVjdgp1BTyHhWIsC5t7M/DYCYgkmRZzErM4HhmVqW5hjIIRL4ZqZwSN1HH2/yGQzG4fOcbI2BfV
	qfrS6rLylzQ/rWdZE5Y7D+Mxu0yPV7ZlH42w0WyW/YYnWvB175XeQslhPYWSAQHDoGuXAETQLpD
	3Y7DHTN9+a/A9gQYHQjEHQKPGACrZCO2IpPtfAm8PlDFsbdfzkiEL6NmJaEGyidlEk2F7mnpWCj
	JF+TSFw5WWSgR4aqc3
X-Received: by 2002:a05:6a20:9184:b0:398:aea8:a9c0 with SMTP id adf61e73a8af0-3af7f875fa2mr578019637.19.1778625285821;
        Tue, 12 May 2026 15:34:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f049sm28583190b3a.7.2026.05.12.15.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:34:45 -0700 (PDT)
Date: Tue, 12 May 2026 15:34:44 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com>
 <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>

On 05/12, Jason Xing wrote:
> On Mon, May 11, 2026 at 11:03 PM Stanislav Fomichev
> <sdf.kernel@gmail.com> wrote:
> >
> > On 05/10, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The TX metadata area resides in the UMEM buffer which is memory-mapped
> > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > csum_start and csum_offset are read from shared memory for bounds
> > > validation, then read again for skb assignment. A malicious userspace
> > > application can race to overwrite these values between the two reads,
> > > bypassing the bounds check and causing out-of-bounds memory access
> > > during checksum computation in the transmit path.
> > >
> > > Fix this by reading csum_start and csum_offset into local variables
> > > once, then using the local copies for both validation and assignment.
> > >
> > > Note that other metadata fields (flags, launch_time) and the cached
> > > csum fields may be mutually inconsistent due to concurrent userspace
> > > writes, but this is benign: the only security-critical invariant is
> > > that each field's validated value is the same one used, which local
> > > caching guarantees.
> > >
> > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 6bcd77068e52..cd039e397018 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > >                           u32 hr)
> > >  {
> > >       struct xsk_tx_metadata *meta = NULL;
> > > +     u16 csum_start, csum_offset;
> > >
> > >       if (unlikely(pool->tx_metadata_len == 0))
> > >               return -EINVAL;
> > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > >               return -EINVAL;
> > >
> > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > -             if (unlikely(meta->request.csum_start +
> > > -                          meta->request.csum_offset +
> > > +             csum_start = meta->request.csum_start;
> > > +             csum_offset = meta->request.csum_offset;
> >
> > Wondering if it's better to READ_ONCE(x) these?
> 
> I still chose not to use it after reading the suggestion from local
> AI. The reason is there is no WRITE_ONCE pair to make sure everything
> is no data-race. I also checked some existing implementations around
> the shared buffer (between userspace and kernel) and didn't manage to
> see the usage of XXXX_ONCE(). Does it make any sense to you :) ?

Without READ_ONCE your patch relies on the compiler honoring exactly the
loads and stores as written. Which I don't think it does (hence that
whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
the same code (and read csum_start twice) even with your patch applied. Happy
to argue with your local AI if you give me the output :-D

I grepped io_uring/ and I see similar pattern for reading user supplied
entries (via READ_ONCE).
