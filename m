Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B548CD4D
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341323; cv=none; b=e0TXhsOawEnkHJEQxyboeFfaL1wWGNgWwj6JOvYE8CNc3uOhdtAOBC36IcXGajik7U7gTB1aQ7JDIcM2A7qEXwUt/TyHFB5U88fjFKibDfrWGm0AT8nkDY0OvxhOBCtilT81cm9/2m7+gWsusGCbCkqlmbJaL8fAs9ZLzyLYrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341323; c=relaxed/simple;
	bh=RuGK7GoIYQg1A1vvn5oTwJjNqdkv+nRmqviNxsgVaX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7orymuaMA5QHbl3GaY5Gft2Oi9Ucp4/ue2yB5y/LRBjebK51hbyWxbK0od0Dkej8Fa9sJvDf+2ftw9J5wXVv6LoXfWXdSsDUQ2Yr1oohkuPbXXe/fTGQS0gvb4Sg30By82OEb0twr36sfxwZOvRv5rCdWnAVXDH+YBqUI3YUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnTi919e; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnTi919e"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc6bb7476dso2653745ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785341317; x=1785946117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tx1LHO52ziNj3TMGJJTE8eQcLC2MzAr77iy3lm/1Tq4=;
        b=NnTi919eqlChvPDwgSQZq9SGI5W1gUK3144VvnwlwOpaZSVIkgaJ9it/FIS85Xe2EI
         yN2bCmuUQv/QgmQbudKGUBwyK9PXJXoCbTGE4l54FLGHY0o74UV0iRPzt8G7nF/UR6Te
         tgEPLVJuhOiAVeiEOoAQvCqi63/9RQss0YuIy4Hjri5SbGXCTxC0bnzrbAQZAyROjvgX
         uJ736VdB06A/cYXHdrGGCnenTn/TMAeJY2Udxy8eoOGm0tk9Wm9XWguBJP3CB8amIKW/
         7Tr8rPo6/nEz+cUP+67Ws9fFySuxhcXZIUkX/q0qI3QvhMIi4eC5KmX9WgifexPTZkgX
         41sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341317; x=1785946117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tx1LHO52ziNj3TMGJJTE8eQcLC2MzAr77iy3lm/1Tq4=;
        b=qzIEQP087POEaPCutN6dQHSi+8TPw9lSS1claejXQ8OyNghJ3AepYYjC1U/xac1IqN
         MjU60ZFjkAJhQvS1ibe/+qr4ynrW8KqR7kod4/11NKvuLdPU8tbLzfdwNU995XTbzIxm
         EEc/trzsuSQCB+DUW1cLy+TQqwcMa2eZl2mmJYLrGtGnsa0zMYIw9g6ypy+LB5d6BftA
         ACOPVJjhPg5NnidF0uSHb4Re9lRZak73PRDi5+sDGBf2LN6SWoYayqGzhNr8VNSP02Md
         elZFmnVwQucV8z2fryf1Zg3d0kbUbmlwkJfnILJrRfB7WcFitBU+XzVKBi/tRrYuWFhn
         ZfHw==
X-Gm-Message-State: AOJu0YxHASjbMrpqFth3a84+EjRmtG994mTdR9ANaaaGnI8nroxsFrMg
	i9dOOgMu7Et4rCg0e6r/0t1xiVimp/kuDARmvXdNVxT/9GUGMKy9DoYIz0K7zeiBVoY=
X-Gm-Gg: AR+sD10JatPn5x/6AqLpybFku60VSJXEHhoWYC//4QwndDkhQBw8bQlvZOsyCm5Qzr5
	l4I7LLRmPwdFd+gnvKRBl5JOrPbi2DvvtEUNUB9nggE6Gi39SyFmRuh+LiC1spOY0Bd+fsRvPcg
	BxEVgAVHV+27R8Mbws72YYecN+5s3fOcWutg7VD/mHsbrtHZjjggz+S3w5FrsTJwHw8owpiTg/e
	Fl1bSbxK4uf12o/VFuJa9hRVwp2JG+pnG+50yqdYHbOhrvol7/9Qt0o9D3GtTphUV7uz4enG5VB
	oK1TrniuDLIx7lwRWzbFDajn0ky8CLj32RNJfonXabzNZGG/u0DfGkgVhzIFFWK8XqrCYu7W1Qu
	OHOYFGBfDDIFOLp121n8z0tpJw+n2kA1EEjTEI9HrTxQvWzp3RzmqZDDUG18FPGlW953EVlxTK7
	vkH/FUIE1dU0txjRIWUUOqinbvP9BMEcfuyNAq9D20g3OcjEmFdei0ZCMvct7MBMVy
X-Received: by 2002:a17:903:1b07:b0:2ce:b43e:44da with SMTP id d9443c01a7336-2d02672bacbmr29921865ad.17.1785341317273;
        Wed, 29 Jul 2026 09:08:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a167b5sm13688205ad.7.2026.07.29.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:08:36 -0700 (PDT)
Date: Wed, 29 Jul 2026 08:54:58 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net 1/6] xsk: require at least 16 bytes of TX metadata
Message-ID: <amohnC9dwEkquF1z@devvm7509.cco0.facebook.com>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-2-sdf@fomichev.me>
 <20260728162044.1D70B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728162044.1D70B1F000E9@smtp.kernel.org>

On 07/28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Incomplete Fix / Out-of-Bounds Memory Read in TX Metadata
> - [High] UAPI ABI Incompatibility between 32-bit and 64-bit architectures
> --
> 
> --- Patch [1]: [PATCH net 1/6] xsk: require at least 16 bytes of TX metadata ---
> commit 8f587b21f2b30dd32c9e63e0817476297538dfb0
> Author: Stanislav Fomichev <sdf.kernel@gmail.com>
> xsk: require at least 16 bytes of TX metadata
> 
> AF_XDP accepts a TX metadata length as small as eight bytes. This commit
> requires a minimum of 16 bytes of TX metadata to preserve compatibility with
> applications that do not use launch-time metadata while addressing
> out-of-bounds reads.
> 
> Link: https://lore.kernel.org/netdev/20260720155210.34229-1-blbllhy@gmail.com/
> 
> > diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> > index 58da2f4f4397a..cd8643360eb3a 100644
> > --- a/net/xdp/xdp_umem.c
> > +++ b/net/xdp/xdp_umem.c
> > @@ -210,6 +210,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
> >  	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
> >  		if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
> >  			return -EINVAL;
> > +		if (mr->tx_metadata_len < 16)
> > +			return -EINVAL;
> 
> [Severity: Critical]
> This is a pre-existing issue, but is a 16-byte minimum sufficient when the
> launch_time flag is requested?
> 
> If a userspace application sets XDP_TXMD_FLAGS_LAUNCH_TIME in the metadata
> flags and provides a tx_metadata_len of 16, it appears we can still read out
> of bounds. In include/net/xdp_sock.h:xsk_tx_metadata_request(), the code
> reads the 8-byte launch_time field at offset 16 when the flag is set:
> 
> include/net/xdp_sock.h:xsk_tx_metadata_request() {
>     ...
>     ops->tmo_request_launch_time(meta->request.launch_time, priv);
>     ...
> }
> 
> If the descriptor addr is placed at the very end of the registered umem (for
> example, desc->addr = umem_size - 1 with len = 1), reading 8 bytes at offset
> 16 extends beyond the umem bounds. Since xp_aligned_validate_desc() validates
> based on the chunk, does this allow reading into potentially unmapped memory
> if the launch_time flag is set?

Lanuch time is handled separately later in the series:

- [PATCH net 4/6] xsk: validate launch-time metadata size

> [Severity: High]
> This isn't a bug introduced by this patch, but does this tx_metadata_len
> validation correctly handle 32-bit applications running on a 64-bit kernel?
> 
> Looking at struct xsk_tx_metadata in include/uapi/linux/if_xdp.h, there is no
> explicit padding between csum_offset and launch_time:
> 
> include/uapi/linux/if_xdp.h:struct xsk_tx_metadata {
>     __u64 flags;
>     union {
>         struct {
>             __u16 csum_start;
>             __u16 csum_offset;
>             __u64 launch_time;
>         } request;
>         ...
>     };
> };
> 
> On 32-bit x86, __u64 has a 4-byte alignment, which places launch_time at
> offset 12 and makes the total structure size 20 bytes. On a 64-bit kernel,
> __u64 is 8-byte aligned, placing launch_time at offset 16 with a 24-byte
> structure size.
> 
> If a 32-bit application registers a 20-byte length, it would be rejected by
> the tx_metadata_len % 8 check above. If it registers 24 bytes but populates
> launch_time at its native offset 12, would the 64-bit kernel read unexpected
> data from offset 16?

Noted, I don't think we test 32 bit arches, the sensible thing is to
probably add some padding (potentially breaking existing, if any, 32
bit apps). Will put it on the todo.
