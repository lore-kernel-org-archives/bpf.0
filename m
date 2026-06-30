Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D010270EC1
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854308; cv=none; b=iQznDtvgpHOc5lKek9yTnq7ReKMah8idZf7xYuOQOlhY1z1LbMNvrVpVEAlWdEwck5xzbp1m1dhie2Z5YOdI+GSfEWdM3pB4XOP7j13dkjoIt3Lbgb/xMsrDOAHGYmnHZMMO3UaKYm5Nr9qAP9GrJgceYcUuR+Ov10P6W7WHLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854308; c=relaxed/simple;
	bh=fcmANZ004Q0lNW7yrfpsdAerR3yiHCf/824ByPXnnIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXe0dgLDzWI4cHwP2vh5T1c8I+dDEMG2FFqvEkzsutEK/qG5ZEt14Dh95zAu3aI4+O0pWkV21D19nLMOKnk7r88qTjNkkhlFQgodSWxM2Qo8EQqUltZpTQ/+vjD+OX4vBYITahy6bhtJh5OZ6UNGHbJB/kbEGcwhPnuaBEXZOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya0nPVOj; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya0nPVOj"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37ffca5d434so486a91.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854307; x=1783459107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2r2hvWyxJvr9jrBQHVSlf0QNgNk9jJsPhFYeRiWKWmI=;
        b=Ya0nPVOj4inlsFXwboOIrQiikl9v1N1LdUlTYyNIbi74K/8ni4kyw5WxoRtIJHsV+Z
         E2wiDRaxD2VcV2QCIreliQyALK3zxQ3IsY9hkoQrwiKJ5XLjYyu8wG7zoNBVK3WpO/Oh
         cruVXTy2zjrdzMgP6HfdmAtER4350QMEquX19d9wU5Eu9SWe1igsuFCIxpsWUY6s021a
         KO9pVRrO3yIkmjHSUNLUcBCjDjGVa3/n8P4djmHK+eBNyfif6WSyqhZU4sg5o/V2stHR
         fSM1kTkilcYCkHByAFM5ENxyGHC7o8QrfjoJy9h5iYzjaEHtbGaLNlMfWFq0YnS7LsQO
         MjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854307; x=1783459107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r2hvWyxJvr9jrBQHVSlf0QNgNk9jJsPhFYeRiWKWmI=;
        b=ffA/jIZVcgVzoe0DtBEwJgnINN1+jF2SCv4iZKJIO2kK2TbB/AanOrvnXrJgs9BeNa
         1EFPRCQlnt4GhIOvld47HnAxyQySxmdDwOHNdxBTtNkmSYKhB7bWk0/E77pTut3mrSIW
         CzWKKWaO+TCwK5g89JZJi0VUJJsQ87JYNPFerpN0nrEUi248Xf4J+u1gNr5GBjh4g1Ui
         6gqEiFXnoJgzeFHsu4EyQ9h8Lsd4i1mLwq/pTrE1pm4uj7iXDIQSPi15ZAdilcInPOZw
         fMYGRfRuo7RSURiZUgQUhWegT71Hrk0cI/yaP2ScSZnQ8YXPPihQd9fCFylqIg1iObuU
         AJ+A==
X-Gm-Message-State: AOJu0Yy8v6N/yGotWZZ0nAuyXfqe1TE/rssQl/rGvmQcdDKCKr5lJOEM
	2zyq+6+O5ygfYYb/wkLZxq8z5t+9ETjvzta422N7b+OQrOpInf+0PCrS
X-Gm-Gg: AfdE7cm1wO7Mg0qUOIfKkVcVqiB6K7n/J2qgcdFRclKnYIJ6sEF6AgYZ7Z83tm7abLL
	xZlhWRUXrNBjJiiVnda4Pc6Er4GMCFomIri/P9We67hEwkjZCZvcxE61PQa5wfboRSRFt43rrOz
	3ckgBhVvEgZihbbwIwI1y9ElM0SXZiZC6n5Uuq3EjPd3cz3I4fqGE/cAzIkjiXfTy9qu//juC9s
	tdRviyLt9rDqJn2DxPh3Tfn4n9vP4We1oL+toizyYcbVuH47nzhg5f5uelacYWeKKQRCm4v4wm6
	EXtz00DmbEu+F9yOsl09mfrwA/cxZXikNY7TSUODRRq5tga1VhkMcK1qmDKGuhk3FEP4H5xQ/kc
	rW7Ci7JkbkxPrvgA4y791B71xvqnO6we864fmj+APxTlmFBKR/luPpNl8oKO6yKggshhd16h0V6
	mImVjsXw==
X-Received: by 2002:a17:90b:55cc:b0:37d:a52a:ff12 with SMTP id 98e67ed59e1d1-38068b9afabmr2435095a91.10.1782854306807;
        Tue, 30 Jun 2026 14:18:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d8c8cdsm597450a91.7.2026.06.30.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:26 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:18:22 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, lorenzo@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 0/7] xdp: RX checksum metadata hint and
 checksum assertion over redirect
Message-ID: <akQyT2d0wNF5F5LG@devvm7509.cco0.facebook.com>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>

On 06/30, Vladimir Vdovin wrote:
> This series lets XDP programs work with the hardware RX checksum verdict:
> read what the NIC concluded about a packet, and carry a "the L4 checksum
> is correct" assertion across a redirect so the stack does not revalidate
> it in software.
> 
> When an XDP program redirects a frame to a cpumap (or any other path that
> rebuilds an skb from an xdp_frame via __xdp_build_skb_from_frame()), the
> HW RX checksum status is lost and the stack revalidates the L4 checksum in
> software.
> 
> Two kfuncs are added:
> 
>  - bpf_xdp_metadata_rx_csum(): a device-bound RX-metadata hint, like the
>    existing rx_hash / rx_vlan_tag ones.  It reports enum xdp_csum_status
>    (XDP_CSUM_NONE / XDP_CSUM_VERIFIED) and is implemented for mlx5e, ice
>    and veth.
> 
>  - bpf_xdp_assert_rx_csum(): a generic, non-device-bound kfunc that lets
>    the program assert the L4 checksum is correct.  It sets a buff flag
>    that rides into the xdp_frame, and __xdp_build_skb_from_frame() turns
>    it into skb->ip_summed = CHECKSUM_UNNECESSARY.  The kernel cannot
>    verify the assertion; the program takes responsibility, as it already
>    does when rewriting packet contents.
> 
> Posted as RFC to get feedback on:
> 
>  - whether the read hint (bpf_xdp_metadata_rx_csum() and its driver
>    support) belongs in this series at all.  bpf_xdp_assert_rx_csum() is
>    self-contained and already covers the main use case: a program that
>    computes or fixes the L4 checksum itself, or trusts the source, and
>    wants the rebuilt skb to skip software revalidation.  The read hint is
>    an optimization for programs that did not touch the payload and only
>    want to relay the hardware verdict.  These could just as well be two
>    independent series (assert-only first);
>  - the kfunc naming, bpf_xdp_assert_rx_csum() in particular.
> 
> Testing:
> 
>  - new selftest xdp_cpumap_rx_csum drives a frame through a native-XDP
>    veth into a cpumap redirect and checks, via fexit on
>    __xdp_build_skb_from_frame(), that the rebuilt skb is
>    CHECKSUM_UNNECESSARY iff the program called bpf_xdp_assert_rx_csum();
>  - xdp_metadata calls bpf_xdp_metadata_rx_csum() over veth and checks both
>    verdicts: XDP_CSUM_NONE for an AF_XDP-injected frame and
>    XDP_CSUM_VERIFIED for one sent through the stack.

This was posted somewhat recently from Lorenzo (and had a fair bit of
discussion), but there haven't been a follow up:
https://lore.kernel.org/bpf/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org/
