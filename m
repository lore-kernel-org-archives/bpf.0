Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC544210D
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908948; cv=none; b=j9oYXIMEgnZ/Fc8hC8I8nFvEJoOw02w7wr0OoXbmJZlCdsjpgRe7iBBbDGHYzfDe4GB1mUg1dtUkkTKy8fh/69Ikv4wquwfy98KHFm8s2bWisvsGlig1YLftNowsxxLm0kOpAdmvvAtKOoNaz7qRE5DpYyjA3YQF9v/tBQgwRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908948; c=relaxed/simple;
	bh=SiOlZD9NMIJEcVTScWhRNja0TOvwP7qLk8zDIbXcowE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM9tIx1/Rw58ncRbLAkKy7xgqcCcMxci84lu2rJalZ7yG2YiVSXfwYyQVf1IGzFEl7hBW5G/N/yiuo3Vcj4KakR6GM730Mw+9/AXlO0y0OEf//rDP3bv3weFRSZ7AQh/sbYV/qfvnFmqMsao0ONiMt6OYRvnwE/7bvRuVgohV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVCxwjo1; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVCxwjo1"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38dbe53179bso201256a91.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784908946; x=1785513746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CqElJuXGgCpnkfoHNKy8qMyBOhibQlCl5yeDj+8xAO0=;
        b=mVCxwjo1++wlgH8T8OWNnH4JqmNVJQQcRDUl2fWi1dCzgA531fuJsc+uv5z1wWWxTv
         JIKx8lrBBqn6FBYgVTe27A1vvQyDwGiIpLKIReWZssgwjB2JtMoF6gPMrk5m53YHsJuc
         X/0wx80ui4BtQ0/PMkvts6mLUc84EKk4ZCv7RCf3FMi2e6xWedW+R8llKPqAq2NBsayS
         DgKjbbtfCNgi3VcUkFCdROx17K0Q9QSXEutZGGOEhWAMXmTbV5fbeDuHnudL0uiQrja/
         1QV/XeM5BvP4gFeJAZHf/K58PvXgwiOS26UcvJF6h+i4xtKpWMAB/e7U2r/i3rFbGlCq
         KKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908946; x=1785513746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqElJuXGgCpnkfoHNKy8qMyBOhibQlCl5yeDj+8xAO0=;
        b=BXmD3ZYjnRaiJW6hMBm+214XBFj7j/0Itgri5lVZ0G7bdegGNF1RotpJ0koFtP0VKT
         /Gu46fUTThOq/vMs0suUWpvPoez/qjnF9EY4pWLoEK/Gb8MW5czaamLJL/wacxI6VE5A
         p133QhjKw+S3Z1E8blCPVBHT1Im1VqjN040Vk0B0ubVYDr+FbH38fkSAm8FALEHwjj0Y
         bg/96+iJt5jyxiAhLh2rhMgJqigD2/ng3qej3pH66kWWHgs0ZcaChj+14OzsFnStLKvA
         2zGdUkOrfNrJmW2/jfPF9PbCK5OH0z9CWiBFJbLjmFIMB9lXsj8IEA9m+T8ouxPAaA3a
         U3YA==
X-Forwarded-Encrypted: i=1; AHgh+RrNtD2F8ZOwogRAZt2xNyQI0DXWtwcMmBgqOulwwwU8HTpOwMaLSzI6WMnnRCSDB1T6wK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0uhLalqntiWSPCBr0dejoJc2ypmEcy1EFCiPkCYkXPUQJH/LE
	1uMv69p1lHFQ5fswNtELKXOmkDey5CiPzSeixaeUgCPq6YLtdfmUVu/R
X-Gm-Gg: AR+sD10AMn+EUed2GMx8KnFAHECzvoSGRF5/mPLMSfSt8LF+6CpnRaHNoIilPTm55Kl
	kebw/wbvu+3NaCjaMlWbjHFZwii1QoTsqTZ7lgQhBriGAkUDOlG/hVXSJiUUx751D68EhO6kmmG
	a0x4QKYqbSKFX+CH3//wM9LyyuzPI6w0yTTelk+7NGzX3a/j2nCqq0jpXRmse0iicBkOaf1n7E+
	FtojDHBiwleFyc3DMstPCRtvs7ZYya8BNHh/1p4vLkoKI3gJdh+kppWPDiNGmi2IK6vaC5nA4rq
	hZmOt6FLBIdNQeoVnkpx2Eh/Bhagdm5BMIHn/LN8SgaWtZy0QFgreYhDY3MDOiQqsXJU40l1+Ut
	HXwNOYCB7UgkrKBbuOl0jeM9+iydGXHdfFsO1RPUEDEG87wOkKGqs9GT3N31JRPLENI96489VBC
	ialmoz
X-Received: by 2002:a17:90b:2787:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-38ec651cb31mr7625553a91.16.1784908946308;
        Fri, 24 Jul 2026 09:02:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f04175831sm1712388a91.11.2026.07.24.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:02:25 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:02:21 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, horms@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
Message-ID: <amOMXI2j-3tLiej5@devvm7509.cco0.facebook.com>
References: <20260722041326.75199-1-blbllhy@gmail.com>
 <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <c3de7856-d9d1-4bb8-ba4a-a7f967c767ae@intel.com>
 <amJL48yvoEcOLcHw@devvm7509.cco0.facebook.com>
 <27dd39a0-71bd-4cff-8e72-6aa45df57dff@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27dd39a0-71bd-4cff-8e72-6aa45df57dff@intel.com>

On 07/24, Alexander Lobakin wrote:
> From: Stanislav Fomichev <sdf.kernel@gmail.com>
> Date: Thu, 23 Jul 2026 10:15:15 -0700
> 
> > On 07/23, Alexander Lobakin wrote:
> >> From: Stanislav Fomichev <sdf.kernel@gmail.com>
> >> Date: Wed, 22 Jul 2026 10:55:17 -0700
> >>
> >>> On 07/22, Cen Zhang (Microsoft) wrote:
> >>>> There is no metadata length check before accessing struct xsk_tx_metadata
> >>>> fields in both xdp_umem_reg() (registration) and
> >>>> xsk_buff_valid_tx_metadata() (runtime).  Thus, an invalid small
> >>>> tx_metadata_len (e.g. 8 bytes) passes registration and later causes an
> >>>> out-of-bounds read when xsk_skb_metadata() accesses fields beyond the
> >>>> declared metadata region.
> >>
> >> [...]
> >>
> >>> @@ -773,7 +773,7 @@ struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
> >>>  	addr = __xp_raw_get_addr(pool, addr);
> >>>  
> >>>  	ret.dma = __xp_raw_get_dma(pool, addr);
> >>> -	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
> >>> +	xsk_buff_read_metadata(pool, addr, &ret.meta);
> >>
> >> That effectively disables some micro-optimizations that were the reason
> >> I created this helper -- __xp_raw_get_data() is inline, while
> >> xsk_buff_read_metadata() uses the external version, probably some other
> >> stuff (note the underscored __xsk_buff_get_metadata()) =\ This function
> >> expanded to have no external calls on clang -O2, with this patch I'm not
> >> sure it would.
> > 
> > Any better ideas on how to solve it? I can convert all non libeth stuff
> > to these new xsk_buff_read_metadata helpers and keep xp_raw_get_ctx
> > to you? Will that work?
> 
> Sure, I can take a look.
> 
> Do you want me to pick this patch as a base or you'd like to send a new rev?

I have an idea on how to keep the existing pointer (instead of introducing a
copy). Let me play with it today, will send something hopefully Monday..
