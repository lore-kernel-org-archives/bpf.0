Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582263BB48;
	Fri,  7 Aug 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129278; cv=none; b=j9BYodFvIyntPqmZ1Mqw3koabbBD05Gc0ShZpvgo8ZmUOxspI2gxo6qo2H286hH9N1NEG9c9GzsAtOagNWmnpgNwOqu7xQrAv5F1UzzLtRXrDxtm0C4CTktAYQPQZtrGcuSEcy9rxHO1Bf4Du3tzhnVNDaQ+vCYGHafNoHWhWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129278; c=relaxed/simple;
	bh=86ara+HfeW2Hk135Uxw6/SHJydnGqQXBKMgiurlWUhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BINXXWm1u2JPXPz7Ob1DOEudcwzxZyPM4iuoys/JJgLu+5StJ8GCvbur/EvUGq0iDTmJE6Lt3j3QkCYhWQsBj13XF+KNhT5VJ7SOm7tYcTWVvVf1iAgJmcon4/f76Lc+Wl6IsmfTbGZIvKndaH9KOQbYe4lRtsvU0fOExL9Zsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=yDYS3eLc; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="yDYS3eLc"
Received: from x1 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 677J0wBk030066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 8 Aug 2026 04:00:59 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=4bdG/JFg//U/ZzRpQpxd3QskSgee6tRLQPpNCqUBRFk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1786129260; v=1;
        b=yDYS3eLcLvdOUHO52G+87QTE9ovkKwL5ieG72mFCvXqpp+lD5uhXhchfHwdhqk9g
         v4l0pz2n7+XjTczsDTftPCchVznbdCG7V2bg3c8HLHfhSB11AW4tZyWEBgv4Ho10
         UCsJLgsUa1vZ6Ad7dyTzHvDG7cJCjWxPOCzZ4fYPOoxRZViOujqiLajB5LSqWEh+
         LpsTYQ9bKFimlIRBWkUZ6UZo4pX7vkBo1W3e59DVKNHh/ACa1TP8IGASnzPoR1Sp
         97yOrET/C91QH8PWFTmpNtcORY/1uWBrPlrzDh9VX5GHIjA9pPZQR2aM2FvjlKaY
         PKW3Tzr4Uzl7L8mOFfEsMQ==
Date: Sat, 8 Aug 2026 04:00:58 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: sashiko-reviews@lists.linux.dev
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 10/15] i40e: prepare for XDP metadata ops support
Message-ID: <anYnt4a74hohZ-M1@x1>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
 <20260805213541.2281287-11-anthony.l.nguyen@intel.com>
 <20260806213617.56A711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806213617.56A711F000E9@smtp.kernel.org>

On 08/06 21:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Use-After-Free in the AF_XDP Zero-Copy receive path due to stagnant index variable on error.
> --
> 
> --- Patch [10]: [PATCH net-next 10/15] i40e: prepare for XDP metadata ops support ---
> commit cf380b8d06da010c94723db1eb6af6df8fb0fdc8
> Author: Kohei Enju <kohei@enjuk.jp>
> 
> i40e: prepare for XDP metadata ops support
> 
> This commit introduces struct i40e_xdp_buff to wrap an xdp_buff alongside
> a pointer to an i40e_rx_desc. It passes the RX descriptor to XDP kfuncs
> and adds bounds checking in the AF_XDP Zero-Copy path using
> XSK_CHECK_PRIV_TYPE.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba53..51a05ce4c7ce8 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> 
> [ ... ]
> 
> > @@ -472,6 +482,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >  		if (i40e_is_non_eop(rx_ring, rx_desc))
> >  			continue;
> >  
> > +		xsk_buff_to_i40e_ctx(first)->desc = rx_desc;
> > +
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this function have a use-after-free
> in its error handling path?
> 
> If xsk_buff_add_frag() fails earlier in the loop, it calls

IIUC, I40E_MAX_CHAINED_RX_BUFFERS (5) limits a packet to one head and at
most four frags. Since xsk_buff_add_frag() fails only when nr_frags ==
MAX_SKB_FRAGS, which is at least 17, this path is unreachable for a
valid i40e RX chain.

However, the UAF scenario looks valid if it does fail, so the
pre-existing error may still be worth fixing.

> xsk_buff_free(first) and breaks out of the loop without advancing
> next_to_clean:
> 
>     if (!first)
>         first = bi;
>     else if (!xsk_buff_add_frag(first, bi)) {
>         xsk_buff_free(first);
>         break;
>     }
> 
> On the subsequent NAPI poll, because next_to_process != next_to_clean,
> the code loads the freed buffer pointer from the stale next_to_clean
> index:
> 
>     if (next_to_process != next_to_clean)
>         first = *i40e_rx_bi(rx_ring, next_to_clean);
> 
> Could this cause the next packet to be built using a freed buffer?
> 
> >  		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
> >  		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
> >  					  &rx_bytes, xdp_res, &failure);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260805213541.2281287-1-anthony.l.nguyen@intel.com?part=10
