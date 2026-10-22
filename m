Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792660141;
	b=ohNcncbSli1EIpuk9I04ts96wXTSLlncnjTqcB7JTMKJvJsKHwkl7QQj+kqof+sWO4Qs
	 IAV/kL8A4tBf8bpX7wcJUB3Ayij75d8Zus9x1Vg0R2gfcgGt8LJOV0nhyD00wkOI4Q0TC
	 3JBfXfMcPiTfNZ9jZ+dtqQ8DtRTzr45lgJ9jNwtd+iZfxHl6fNlkQdkNrF07DJWKU/Okn
	 GHlHQYIFsmBWvDzspagDtO9THpGpWPTA6Fj5BM9llVcYSyjjkbGJJZcJR/aLLkGF04Ovm
	 qXZ28m3iAImQPaGuOYNvgRJW+TOXnwekHgImRLZrhxc/dV/dhGIeC8rwn4kswEQhxdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
	b=zO2TX3yyZcHTsQDqUDxwVnhLOw/q1BikxBsMwjBkokwHbvNBiC9fi5GvLideBa/aGNWv
	 geuugdagGaCQqjp44bDXDwdvBBS1FDQcxNVr+1f/LRn20O29EEukdplRqH5ME+UxNqt78
	 F72vOyVZh14dU678/UeRTwfzNkEQ/XCfpKXpyJbjg0QhBvBfRYBVlEhhqsbqalft1yHH/
	 /L29wzzNXcDirmayPOYLqoHYN3wRXHCNvzPNkqFxEbstRIJ7Z0LkSFvg16vsg8PZskIEw
	 Jo3R30xMCxZLSdUX8XnxdV06U1lwAxtmqb/J7b/Yz0s5pvf9juA72HSTahsAXQ+XOqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmGQigzz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8760A2611
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 09:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BB8760A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmGQigzz
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e5d0ee1951so10931875ad.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 02:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792660140; cv=none;
        d=google.com; s=arc-20260327;
        b=qbTIKXHY7JJJ1Fa6DICVJc/eHEX1mN2sKJCOLGyuKOR1ZSmPv2xsxHEt5gUBCgRoAY
         7fXJ1LUZ+yOlcO4NT3lJxR1jeBjg2z/qQSry/zlmnHmPPmVQO6zmPoBGZiF3roBYFbOA
         +VN6Hbb3rngREtdsD5pHryynHOhki/Mn6NNIZdDe2cWPDwZDFt7oRLscySzDDlPvwBIP
         9nyT8fZdRUJGPRRmGZDI+X08y4NK1okbB4Edm7+BVTnU5F6+m/Bfm0Ah+8k2IlSd5dXn
         xYz2RBAtQ78HNbcD5WeCxcoyZFtGPoL++YqL30NvTlbt9/icgUA0n2V9flD4M6qg8em5
         I/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
        fh=WuXD7rmzRXiS8e3vPxWHheN8gzyWbH84Uq/rCklA6qU=;
        b=hYItZj9fmLmhsgzSc76QaXl2TL7LMJz5dhK8bEehe6Herxl5GPmEOjPVjmn1867OUa
         fAgPg/9BlIZeijtJ6HgCK/bHHuHuyeIpqLVFEWBECoMax9yQcG72SvZ9opMIOF/pUDMf
         mk8WcM0SDyxQCgH+bVH8WagQUMeJNOx1vYcsz1fdzKDa71KaZZB5FHrmDEldQvJw7JQN
         lzJLhFtf4ftgia+LqkR0iZkMtliGQYIViCnbWaR28aFxQLuhnqNPBl+YNpBDhA7vTAih
         2B+Qk1xNfpB4ZKxDAz3XNn2hI5B+lpQALQl7gfo1sdnRvWWzXx+NObBTtB0fvct6JSz5
         l4ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660140; x=1793264940; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
        b=YmGQigzzpNxmz09qXtRdiVAK3ae/6WkZsxqw93zZJtYIX++tGjQia/CgPAiM4TBa+r
         ptWQx78OluWSJywzHD7RbDxl5Pzxv6pMtJWxp1qYj+33zQyeQKIT6dvH31zerqn+chQl
         Zv7Ccf1j8QvsEl44BzYNZGlQ7UXEa7qkl/AfERI46VlWCKNo+jMqDm1vkaRKv8OD8Fmb
         nm76IU69MfG9g5BT9EfFjkOa5N5DKX3PJLzP0A4Jjh0X2pvMnyznwwy5kZAMks4loUUg
         pNWCi8zUVH2BZiAnbbx4cePPbTezwl1AYgHm6ak3DK7Tb9/5BE4Jttw8gxlYiMsNYCoI
         yo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660140; x=1793264940;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x1gSHT1c/ki0I3qgcb+mFwc26qJiBmIOj6KoD3ALLCc=;
        b=N3rbihT/hDOB172XppmcXTW6fSdYLIe4S/yPr+zEjIx1H/QksdvBCIg7imXiZWnfvQ
         +jQWMIER0nAUeivYr+ZbmPRCdHd9yscbNfK3MwfC2NC22bMEORAqjM4CJ0ed4J2x+Fz/
         Qc+JTJr2ewNE3qtyXel7EOyjnlIx3sjQCLescUwivK4y14HDVvkrV0RIlevBlqplnDoD
         zZeVGPyEefIt0J79lkR6cx6uU1WeJRWHSWt15XpcZme7WOYaddtGRoGtjOof4mOVU5bY
         UwAd+qqUaJVf/xkXlCMVt55FGr+/QtjaVJufc+anoMGNqA+O2WB9BSKXecCF2wNIuZ82
         6j1A==
X-Forwarded-Encrypted: i=1; AKwUvBz04nJ7QWCDUe7n2p1UARx6pb9nCJ4I9T9zex7eWLRkXRan6kZ6a4Vwznmx2dzclwezBrw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIg+dmhIxJfb908qLUSwiW7hzKd+nIMS/wfuFs23u1myXwDgiX
	2Nd9awkcxfXryXoBRjVYJqSPt/qS9LFRVkqU9DFwxph5FnH/uYQShnOWA7trOFsGdxVCGBo5XS8
	9upHOwb+0g4WDX7rLxHIDnbM326UEe/k=
X-Gm-Gg: AYBFou3GEBNWjq95CwgqBWGE5eV8/7kUp5PiQIAv1vwxiPXMuegknlCi5OWYK4yWLFj
	Vp4rHKE1VeZkyB1sAqUtNbQOlICtotIIEF5UFCs5Tv9yr8aHPmEvPd9gv3+xWhumbCnq3qtWNWw
	0uiUOBB3jq117TBlAjipq1lcN4+dPDqYDSUnWyUkv6PLVjkAG6uUHOFydTKI/IO0kwhNKOlWsCu
	FbhIdTrvJh+g9Lg9vNl3/SCf2pMwxZhupHDhoJPIcPqF9Q8DOIEaODQcz9kp6l/GdYd7HUp16Kl
	c5d53OngHF4IcI1rC2Bk+F/8Q5o2dPk5BgN1M1PAP4LkpkrOBHsh7YuhDIPzKMxKVu9prc1g7qT
	1t76Ur+XchJPCX7YvL0U3GKnl3er6bWnEaGW30Ro=
X-Received: by 2002:a17:903:324d:b0:2e8:8637:5e3 with SMTP id
 d9443c01a7336-2ea43ca9b18mr41320045ad.34.1792660139775; Thu, 22 Oct 2026
 02:08:59 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792654486.git.zhilinz@nebusec.ai> <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
In-Reply-To: <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 22 Oct 2026 12:08:47 +0300
X-Gm-Features: AclHuK8matChSdrnMT5vbHsjOJ36t5qQf1YuHOVEVae9bK9_y35Mye5KmB-ETCM
Message-ID: <CAJ8uoz0PTUVOTk5LV+LrP4tL-bEiVoKX4jL_V5nQcvSzk=Msew@mail.gmail.com>
Subject: Re: [PATCH net 1/1] xsk: validate consumer ring producer index
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 11:04, Zhiling Zou <zhilinz@nebusec.ai> wrote:
>
> __xskq_cons_peek() trusts the userspace-controlled producer index without
> checking that the producer-consumer distance fits in the ring. In
> __xp_alloc(), an invalid fill descriptor is consumed one at a time until
> the cached producer is reached. A one-entry ring with an invalid address
> and a forged producer index can therefore keep the kernel in this loop
> for billions of iterations in receive context.
>
> Treat producer values beyond the ring capacity as an empty queue.

Thanks for spotting this. If someone intentionally messes with the
ring state, it is ok if they get no traffic through. The important
thing is that the kernel does not get affected negatively.

 Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> This
> bounds the consumer to the userspace-provided ring size and prevents the
> long loop.
>
> Fixes: c5ed924b54c8 ("xsk: Simplify the consumer ring access functions")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/13760
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/xdp/xsk_queue.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1bc42c8902f4b..315b656534749 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue *q)
>  {
>         /* Refresh the local pointer */
>         q->cached_prod = smp_load_acquire(&q->ring->producer);  /* C, matches B */
> +       /* A malformed producer must not make us consume beyond the ring. */
> +       if (q->cached_prod - q->cached_cons > q->nentries)
> +               q->cached_prod = q->cached_cons;
>  }
>
>  static inline void xskq_cons_get_entries(struct xsk_queue *q)
>
