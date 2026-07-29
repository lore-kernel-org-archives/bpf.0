Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0448D885
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341327; cv=none; b=Firdqd/1kv+ssAO1ZIN+0TGdxXZp8Nmp9eyFaqA/pncsScTcw9m11Vf+0Vtm5jyTD39Tix8h62+QCFaqIbcCdR1JbXP8WlcnR3qdKTuVERJg6M5cyzJwzz7U/mvtjsdZblZVsdICk5WDjcEHOiX7Tz+cKtE5Iu3l6hZTnlxODQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341327; c=relaxed/simple;
	bh=PgwRTINTEM4y8lTmvy/2+CXrZqtSovCear9tpRZu2z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWAGTUHiT1WvaT8baNTd0loWr7sElbLG9HZsmIPK97xWaenkLhWaUHPsB2l+NEboy7ZBLA/XjqWyIMPkuGW7g0ad0j8d2P0Mg0lDZQY8fVTGafXnFDgAhS0PWw3fBlvT+rE9E+Ys5KLF+KE2fXdcOLZ9QLDNhs5Qvb1jciGGs9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otB1p9GU; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otB1p9GU"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca00ea47337so397854a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341320; x=1785946120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vhbd/IauEGsMdaRvYQ8W1qczAGgnfc3VqSLPKIuT8vg=;
        b=otB1p9GUP5HV2aRof3TLZ0UBxdb9KAQ8J3LI184GMnNdPLz520TlQYyATjqBhTevHf
         pQ8d+JJksCTvnc9yRqCEsqTJFdEEUFUF3uT1rkK8VVSd9IqLefFYidqjRDj7pSiDlXpv
         ueiAylkNZlb2RPO6tT0FWtJ1BtvLgVoB49LghtsGh6r6nlllDhA12YxCoHg9kNmBNwTL
         l5w0YKdiHWvb1ioAlJFLh17Bg5XJbr2dW5SQcf8/KtKYJe3eDSh9poY0fNwAb+i9MOvQ
         bBa6ODPuRws5Z/s1dtVnQXRqdJOeGhqNT5AWC24NkWfdnnXDDGyNxCDeT5w8smj4I1Je
         nfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341320; x=1785946120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vhbd/IauEGsMdaRvYQ8W1qczAGgnfc3VqSLPKIuT8vg=;
        b=cj9Ik13/3UCQYcRLs52n3OfG/MhiqJn2jy8MibsEkTNiyIvNZtx2RBk/pRSGHUjH5G
         shPNW+ouZtBZmJdMpnVa3efwIWHNkr6+8uMt3JuL/aZ/ThfcVnvlACSa+8TmKU22z/a5
         ZSN6kBYPBOQtJpMEltguuJ2+gVfsLj2y01cWF3LPSjXR6rO/EXtpU5bMakXOV6/kOfAu
         vMhlw8vuoXvSWh75iSyGGQpIKb8pCGakWHa8OSBvDhlU/F1RwiBJEtw6swCtkf8dEGHs
         ptO9bM8/WiU5WxCiX4zaLF0HX1p89QGelEkR2f0HyUNOaL86ZENdamte4c/WGGX7skbd
         /lDQ==
X-Gm-Message-State: AOJu0YyeOWRHmxJgt705ZptB/YRZSneVJJzOI5cYAedVf6urJbOixkUv
	grgHbdg4E3d63E+V+e7z4JY3WttQlnm8ZLR2JVcY1IwUsiJfoLC2EkumJLWgCoOks+M=
X-Gm-Gg: AR+sD10/gSq6KWINnL3prvej5kVdo7Mo3QqwwdfkB+wXNWMTN2WpBJgVyAyIEr61Mbb
	PvAB5aWzJG3eQ40Gpo+CJA5ZfVrxU0oS81o4BucMbYGERkeitdxSarNiuSOYBA+DzUzzKHY51Mg
	+cs1s3fVYkaPFhsvivHsfcN9ovz1H4wxR0zQHrLfyEE2XJ0TCjRjEdEgoKulsji0NjSUczn581U
	DZXcfjq11cp89Wi3pCgbNoFNFxDqXHuWDPG33rJ5aK3aDUVDeZoRPrsWCBr6lVPH0ykWde+2HrN
	ekdRGXFfuXITEQMeIV8G+brtGsz0w122j0H2WLusbOyF9n2gPdyrqfq7tKSAeqoBaQ4BXSN5kHS
	L1XAdVHIqcrGSKq1VrmjAkcOYOaXNH3pKF5VUVX0TYu93PkP5l+9ulMD4Av766GptKuCyeOsmLQ
	Duqv2Hy1AWA53BG1CKiaVzuzCC+nS/8DTtQNUXURQPojEmqwH5OHr5UA==
X-Received: by 2002:a05:6a20:d4c:b0:3c0:b55a:80ff with SMTP id adf61e73a8af0-3c8ac23c2a5mr9069215637.24.1785341319505;
        Wed, 29 Jul 2026 09:08:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba929728sm1064755a12.29.2026.07.29.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:08:38 -0700 (PDT)
Date: Wed, 29 Jul 2026 08:59:48 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net 2/6] xsk: pass TX metadata pointer by reference
Message-ID: <amojZw5ZTajq6Kqb@devvm7509.cco0.facebook.com>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-3-sdf@fomichev.me>
 <20260728162042.27EE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728162042.27EE01F000E9@smtp.kernel.org>

On 07/28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] `xsk_tx_metadata_to_compl()` returns early when `meta == NULL` without clearing the `compl` output structure, leading to arbitrary kernel memory writes during TX completion.
> --
> 
> --- Patch [2]: [PATCH net 2/6] xsk: pass TX metadata pointer by reference ---
> commit 83fcec7a0c0075ec991849b8d99f6d6cd083c335
> Author: Stanislav Fomichev <sdf.kernel@gmail.com>
> 
> xsk: pass TX metadata pointer by reference
> 
> Completion handling needs to know whether a timestamp was requested when
> the metadata was processed. Let xsk_tx_metadata_request() update the
> caller's metadata pointer so that decision can be carried forward without
> rereading user-controlled flags.
> 
> [ ... ]
> 
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 8b51876efbed1..06c081feff42d 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -153,17 +153,19 @@ static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but I noticed that 
> xsk_tx_metadata_to_compl() returns early without explicitly clearing the 
> compl structure when meta is NULL:
> 
> static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
>                                             struct xsk_tx_metadata_compl *compl)
> {
>         if (!meta)
>                 return;
> 
> In drivers like mlx5e_xsk_tx(), compl is declared on the stack and passed in 
> uninitialized:
> 
> mlx5e_xsk_tx() {
>         if (xp_tx_metadata_enabled(sq->xsk_pool)) {
>                 struct xsk_tx_metadata_compl compl;
> 
>                 xsk_tx_metadata_to_compl(meta, &compl);
>                 ...
>                 mlx5e_xdpi_fifo_push(..., { .xsk_meta = compl });
>         }
> }
> 
> If an untrusted user sends a packet with invalid flags, causing meta to be 
> NULL, could the uninitialized stack garbage in compl be pushed to the NAPI TX 
> completion FIFO? Would this cause the completion path to dereference a garbage 
> pointer and write a hardware timestamp to arbitrary kernel memory?
> 
> Similarly, in stmmac_xdp_xmit_zc():
> 
> stmmac_xdp_xmit_zc() {
>         ...
>         xsk_tx_metadata_to_compl(meta,
>                                  &tx_q->tx_skbuff_dma[entry].xsk_meta);
> }
> 
> Could this early return leave a stale pointer from a previous packet in the 
> descriptor ring, leading to an accidental overwrite of userspace UMEM?

I think this is now addressed by:
- [PATCH net 3/6] xsk: clear metadata pointer when no timestamp is requested
