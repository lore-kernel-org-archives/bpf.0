Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5848CD50
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341327; cv=none; b=iN+uqWD214zms6AGtgdcEMa9+3PJaVbO7TATauWNgoMHacaEjmyUnaK5T+zzsc01Y3gw2DZLxq9wY6tbBg0O1s2g6uUjnCT6OtZyKii70/Wf/NcDk0Szkc/pZhLz+PK/SHyvC7EHPfApaBeIuMEcngRgo0P5VZJCCeGyetsQeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341327; c=relaxed/simple;
	bh=hkbCUFGpd78t80fmDHxeHaGDNL1O544ta/CmN8MXza8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUjrogZIHN2C8agCt0HKr3vl4aevpvWktihtDzkrZBca/OEH69JdgbCX2kuydr4PTbh/LwqdvlIzatDXtgRp7l/+tOe2SJdKKxni/BCXWKmz8zgJPifxIS+3D9GB6Ow5oJcgdHRm2dOG+X1onvGbGAABwLVPyQYe3AzOhZlIia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUPuHJcu; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUPuHJcu"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cac634f921so4507375ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341321; x=1785946121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I1J2W2Ej9t2c8E57diK+j6vjVNEsyRnKT5FgUYUw3BY=;
        b=BUPuHJcu+kzRv0iFO2k7dnmqJsGP9lgXRnLLusDhuk5jfCABfcjb1uJusGCqF6BmV8
         8ZGYHqPGjTxgoxAj/xst/id4NuKhl15gEWklD+Ky7DU/+N+S9GXP5VMaEYOq/TwleY4A
         e0RxREUkfdTG6nczIqP3YtBROXuj45MmIOSEmMqKJLeXx8tgGFx7U25Gr7Lt5ZSwmslz
         Z5otgfKPE99uIvMnDsgR3Iy6RhiB8TziMGwQtaM0doWUm/PPWAEUuzSVq33SMLN015Fg
         +6ToD05eVRvU0JZ5xMjHG0FFFEsQGCZrHsJ0MWyIuID5waSet71iHqMq+rnCm82dffUG
         /Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341321; x=1785946121;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1J2W2Ej9t2c8E57diK+j6vjVNEsyRnKT5FgUYUw3BY=;
        b=hjbRS+psomRs+xMAuAgXC+nkjqvbHmVfQ6FWnk5x/ICTaSBkB/nFIXlQgsf2rKGV+W
         PoG1SIgd7i9WucAONTPfTRtAB8PK21yNZqmmBU5z1wVNLbGMXZPoGx2rMtu2kM+SUSiM
         oxdiJvhbqxHu0IFNGiE6pf3GODYvoiD0hH/mg1y81uhyHl9sM+8Q0S+0qp4tbmemOVtL
         V1PcJ1KoYtTNXUT62kQilg9Lue9gkJB3lmxg1LUNICDyAc38y0gxocRO3UYtnk3MwVxK
         ONJGrknJZqNySvdMO1KxB9lP4MsJBB6hYpPPHKv/rjrDAKSet4PE6/thJZup2cyidFAC
         iVCQ==
X-Gm-Message-State: AOJu0YxBumSf6pUx3NGK2aXdOasWgBgj8iHjGg/TNfYoiFgc+q5qQLIY
	ofQaFOBuAzjYMAf1ML5oOOlDCWOI9R/GI1drQB5WpBFxFz0vFolKzJf6NCJiKCJE0WU=
X-Gm-Gg: AR+sD10AHcsnyvockwYlAwCNF6a/JBW16wIAhowd09dzWd4GijlRuWDiN/RThOb4Ydc
	UOK+uetcxLvbMhPJeS+snJve1x4N57gzDF/12F46TnM2XUbvOglVm16lIKpWYXdNLsZzlLpCyg5
	I24bub9tgmt8eLnl8YLVzKNJzJzAQj/n5pTBRJvPEkz+zwJVdTDwB3WvtiUwHtBtFylWZ0/Nv/M
	OAG0XNTh39U2Zsc97qLt4QL0ceiPjOQD1/2oyY/drSjVl58L1EnP3m7RZRl6KMyA/Uk5QaB34Qs
	Et+1mWZUhdI/F8pjt3wKA/EMEZewKSAVdZPOdqP0p0ZRgmyN/FprVxGUZXz70S3lW0G0uGgQ7CK
	v2Aua8PmImS6h/mb014ZPE9AaALDARcqnNNQvlPd2voi41x+qRyZe3yeRF9QOZMEKTNDcK/TZgq
	d9q+pA0yWeh2Mf6wlfPyc5pvyAZENIpuFWymXHtsSxOfABNGDMurlN
X-Received: by 2002:a17:902:d4cf:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2d015db933amr79219805ad.42.1785341320867;
        Wed, 29 Jul 2026 09:08:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc9bd4sm13696275ad.48.2026.07.29.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:08:40 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:03:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net 3/6] xsk: clear metadata pointer when no timestamp is
 requested
Message-ID: <amojqDqhN1v3p2ky@devvm7509.cco0.facebook.com>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-4-sdf@fomichev.me>
 <20260728162040.7805A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728162040.7805A1F00A3A@smtp.kernel.org>

On 07/28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer overflow in `xsk_skb_metadata` when calculating `skb->csum_start`, leading to a potential kernel warning and panic (DoS).
> --
> 
> --- Patch [3]: [PATCH net 3/6] xsk: clear metadata pointer when no timestamp is requested ---
> commit 814027e56069dbb5716ac5b9f7f38aebab332dd6
> Author: Stanislav Fomichev <sdf.kernel@gmail.com>
> 
> xsk: clear metadata pointer when no timestamp is requested
> 
> User space can change metadata flags after request processing. Rereading
> them during completion can therefore make the kernel write a timestamp
> that was not requested when the packet was submitted. Clear the metadata
> pointer during request processing unless timestamp completion is requested.
> 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> 
> [ ... ]
> 
> > @@ -998,6 +998,8 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >  
> >  	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> >  		skb->skb_mstamp_ns = meta->request.launch_time;
> 
> [Severity: High]
> This is a pre-existing issue, but can the checksum offset calculation
> earlier in this function cause an integer overflow?
> 
> When handling XDP_TXMD_FLAGS_CHECKSUM, the code does:
> 
>     skb->csum_start = hr + csum_start;
> 
> On architectures with 64KB pages, csum_start can be large enough that
> adding hr wraps the u16 skb->csum_start. This would result in
> skb->csum_start being smaller than the headroom.
> 
> If pool->tx_sw_csum is true, this then calls skb_checksum_help(). Inside
> skb_checksum_help(), the offset is calculated by subtracting headroom from
> skb->csum_start, which yields a negative integer due to the wrap-around.
> 
> When this negative offset is compared against skb_headlen() (which is
> unsigned), it is implicitly cast to a huge unsigned value:
> 
> net/core/dev.c:skb_checksum_help() {
>     ...
>     offset = skb_checksum_start_offset(skb);
>     ...
>     if (unlikely(offset >= skb_headlen(skb))) {
>         DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
>         WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n", ...);
>     ...
> }
> 
> Could this allow an unprivileged user to trigger a kernel warning and
> potentially panic the system if panic_on_warn is set?

I guess.. We can do a similar size check before calling skb_checksum_help
to avoid WARN_ONCE.
