Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C67080D
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826928; cv=none; b=VAHyDI84zCYBA5IXHZwnqYJvNpyGQBVdI+5qsUU/KoKRn0d2qmmpVFjKL4a7nJ+Owg7CYAOjY9hj0xbpV5asU6hfAKlE9Ny/Fck8TnsL6hPJbT2dq+7q+olVzLoPlornN4aUiSLZO/zn6BqbDjLWHoKTt8oXkqNaFXhwOXxcAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826928; c=relaxed/simple;
	bh=gRvEv99Tveaj910OP+Pr72Hlm+AWoGqPbF8kIi4uYIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUlpNvMpVHSIeBVdRcgwVyonp+NAO3q5B/BON1sOelUnivPEHpzEQD8251F2pWlOgyKZ5cUq0DOI1Zi3kbyHLC794OP5u16Vwc2M/ycImOO8OMy8NlfG82bwifVJyjQW1wu7zOTlv51CsXj7DipO+xhOqbPfYvRrbeLgGQ+QQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXDM0YeA; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXDM0YeA"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-cbb92a1213fso282298a12.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826926; x=1785431726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qDOoFldaLflTi52Y4t0/f1yKLzKujtAjPwxewIEUekM=;
        b=kXDM0YeArlpWee1rz8t6MpObK07WYzNkhiMiwv9uvs0ZApUJG4xmdwpi4gYWouMJ8h
         OVlZE4DrrxOBuCx31rpfBoJXuB/mvE8Ksxlk9isQXetCwid2iqnuFPz3NO0M3e7LBNqp
         +jGs2ZstTOUAFyQUhvoxrL/k8qPxe/cJaw/9fV1gdA5wMieMAOoMFHWzqiX66I9Pcaod
         BsF/CZ8OhzZdy1kwvxDHRdxkqIXEzr94Ki8Q1SOzxcuQYhQS1hxFCwc9E5fghbjAzABY
         Hj5B67FHGi722J8r5Ci3CphbfLf8Zq3PQimtzKwQ4Vxt35tNjGrm/26LGKF57gt4DmWJ
         4rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826926; x=1785431726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDOoFldaLflTi52Y4t0/f1yKLzKujtAjPwxewIEUekM=;
        b=S5v11FpMCyWkfWfDTKmOtedsBEyGuijD/2LlEFWRLTh59ezvu7KrYCMoYcY7nMHh+Z
         Mh6TxEuPpmQQw4GPdA/pN2srBOkDO8+WAvkUcZA8Lem6tQLJ9BV5FGQG/G9mU+MtIJMP
         r8FLJaOZxaR9Alp9qvAA0FVnoeRKTuplp36VRe2IXskkkgUEQd1ej1REz5WVsgJzWQoX
         AvATESCtflPUaYqc2BkmFn/6DEVABPTaBkjvyXDakBnnlUUhB0UrmY1jixFqTKROb6yx
         o1r+OJoZ9x3/GLY+vTHpGBRX6nbH7OjsnJdZ1Vffe3fvyxFdNr4YDpOXYY86Yqd+N/au
         UVZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKQJ1X+BednTuHaJIM3J0WHkbwKZ/aN766kdNQN9wQV8gSNN7LtBjDIq6f6t5NXUsAteU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyq2G2Wx2+L/GyM5aSCFxHLIb+/fly4s5sAd27bh+k0IMzacQj
	NU8s00styeJb9qJs5SAK4D09i8ImAkF7BQhik/5qo0O3Ohzqz8/Rit/W
X-Gm-Gg: AR+sD11fXchkIVIOZ9rmNjwbQLxKZ3WiyGHFSxrXxTW41sm0JiT1bK31C51TZ4c/PyN
	5qvXcL2uYNW1VU12bkNUNos2d7xm5vcHVn1V3OtctEJuZMm6R5A8SOTqvc+LGalD5c176mCbBGZ
	a+fuzVJYJJrEcQycqZS32wkPO1VkTdc1wLxiilbBPvM19LGR9VwwHYA1WkkGHfbwbX4h5SRD6U8
	cVuoSoRHQF/3J1HGSn78oW3OQ4CUS7KuwKP45c2F6BzMBL0CSYtCAW/ly+e2L3hzKsJuRLDUUIC
	LQxBGQHdMzxRt1eA5ZjtWm8gTuMB86g2wpTVJ9FF8xbRAq6i+NLfNR8z/uNKPlOY1cLelqvi8mU
	Zn6P9Ne4TV6bH7A4IOTNYmfdLab3ur/MKoV4ZveVCzhRLSyoKayZkcn5nABpZ7HuDY7mb9d0=
X-Received: by 2002:a05:6a00:1f0b:b0:84e:23a:14ba with SMTP id d2e1a72fcca58-84e2bba3b90mr4535479b3a.55.1784826926412;
        Thu, 23 Jul 2026 10:15:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1757833asm3453039b3a.29.2026.07.23.10.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:15:25 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:15:15 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, horms@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
Message-ID: <amJL48yvoEcOLcHw@devvm7509.cco0.facebook.com>
References: <20260722041326.75199-1-blbllhy@gmail.com>
 <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <c3de7856-d9d1-4bb8-ba4a-a7f967c767ae@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3de7856-d9d1-4bb8-ba4a-a7f967c767ae@intel.com>

On 07/23, Alexander Lobakin wrote:
> From: Stanislav Fomichev <sdf.kernel@gmail.com>
> Date: Wed, 22 Jul 2026 10:55:17 -0700
> 
> > On 07/22, Cen Zhang (Microsoft) wrote:
> >> There is no metadata length check before accessing struct xsk_tx_metadata
> >> fields in both xdp_umem_reg() (registration) and
> >> xsk_buff_valid_tx_metadata() (runtime).  Thus, an invalid small
> >> tx_metadata_len (e.g. 8 bytes) passes registration and later causes an
> >> out-of-bounds read when xsk_skb_metadata() accesses fields beyond the
> >> declared metadata region.
> 
> [...]
> 
> > @@ -773,7 +773,7 @@ struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
> >  	addr = __xp_raw_get_addr(pool, addr);
> >  
> >  	ret.dma = __xp_raw_get_dma(pool, addr);
> > -	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
> > +	xsk_buff_read_metadata(pool, addr, &ret.meta);
> 
> That effectively disables some micro-optimizations that were the reason
> I created this helper -- __xp_raw_get_data() is inline, while
> xsk_buff_read_metadata() uses the external version, probably some other
> stuff (note the underscored __xsk_buff_get_metadata()) =\ This function
> expanded to have no external calls on clang -O2, with this patch I'm not
> sure it would.

Any better ideas on how to solve it? I can convert all non libeth stuff
to these new xsk_buff_read_metadata helpers and keep xp_raw_get_ctx
to you? Will that work?
