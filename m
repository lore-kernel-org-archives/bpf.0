Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A14749F5
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933172; cv=none; b=TUXKjfS8Q5GraL4kK2CPbm1eSEVVRJxRe4eg685VOszGasx37Huqw+UnBuL/PQt9HK2oztltRejIDz6QwZVVS3bdcUe4+piuOHa9TCiVcZ6IhYxBYJWyORzVUvzR472h5Viy83zbmMYT+w9N+jYyfzh12JxBrwSkaK+AKMJM7EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933172; c=relaxed/simple;
	bh=bXGiriF0ZpR12CZdKrsdUosiRKo/uGaGWUfUovbd5gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVhGAykbTfToNRLn0YYVHoeOKDOP3l7xCM4CjJ6Gww/gpE0oKq0jkHkN4OOMmC6hgixzIWDTCdjX06naqURYWnayahTQmYyUb2d4+p62fHueb+Dka82uwvDxoTZ8NrA7XHDwYhzVo7IeZMXErJj8P4P31fzzjHG5naQcdSjo6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shagZRSj; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shagZRSj"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca7d1dc4554so468694a12.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784933162; x=1785537962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUp0spRqE3+iwDhjOYRCe4RoHoRmEIKutFUO3Q5qoDQ=;
        b=shagZRSj0URzxg12cqpVhAY7LpmeB9d9gsgXBjVaJHHoe0Md/5TZyo5+9hPJSq6Op0
         HCZUcYMdtrUPpnQ2al3fcFFeU1za+Ay9sQfNXJbHGarNsVA37zKXWTjO1IU6rNdzXwz+
         ncIMJ4pbuHBVpjbgbW4FFaviafI5Xd/zQIB3nu9qFlLf3NiiTa67mgzGGv1hd7zxzoj8
         X7B059y+fzTDIBhBk0GClFCIEYZ+es/ATS0DXYHP4lksggfHrx1ZI1JyEghJ7aHOAicF
         u5mg+bcLkz/EW+QYz9vfSBBZz71al8jOuLBCPfVM4S2EF3QaSwkTku26fT5TF2Sm5c45
         bsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784933162; x=1785537962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUp0spRqE3+iwDhjOYRCe4RoHoRmEIKutFUO3Q5qoDQ=;
        b=UYsRA+Q9McdSAWVn9AHmNwcVV19c32gAqmgfGxmQkRHJpOTkj+XpilQYV9qKHkT30o
         DsF5+Nn9+G1hSSPwtC2dG7c2cXYPVb7DPGqcKUm0OXuN4NPnnuNa+z5GTs7+3bOuf98i
         rZtPwjRhHqtJ42JGif535v+x5yQH67C/0zcopiB+AM1QpiUnKwzQglIpt9uGvJ2xvpWR
         NT2u/PCPRVeoZlbGeaXVyAmRwlziuuNuWO20jH6wMHgN3f+L8DbZxkJyN+u7xJkjToe1
         gStE/D86WE5MajQALKcijs2HWFyry/QmIsfhVyIeNvJOytpGgL8mZ45NOrYZvDzJq93y
         UTyA==
X-Forwarded-Encrypted: i=1; AHgh+RqRgReJjpVGKwQp70M8T6zAPOKITWgYsp4W9ISVg8tahd8jNsJO2nzo//KWtIXTEgUOdoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiGaVO844DojTh9h+N+P/qYYA1CMwPws2lVIAFnfbAj1XWwra
	TWx9Q8SQtbOB0wwSaWvGMg7ZpaLIRQaPrkW+1GoLGIlkyJir7JqYnN85
X-Gm-Gg: AR+sD13jKl6XppIT/Ll1UXXakMFnOkaR5Wmu8SOBY4GXHvZx9zEMGKkY8LK3zp/iQp8
	7sXBMc9Nq/MtvWrJCPFkF3xkm35GTZhzbDAq2pDowvR8ppiU5fRcVn6oeckFfl2PSwevOB9d4ze
	0Vod6KZDHSDSKVgGHNTtlTjZuzajR/f9u8NnXYl9NMvYyPtXZZWRGSTXsIURUCQ18204d705VjZ
	8/NNAOH02amFCuT0T2CRw9YPAmQ4Zp/mJWBp32ThVx3FdGhrpwqFmTUyAgZNQMU2XLDkxomPOLG
	Js1R34p4rXC0+mUqTJdfx6LHsvVvuD5nBiFLRbqo1YmiHRcoOHcfJVsUtB15ahudGqcLrNS+NYF
	VxRI31KMYBAX4iBH5lSVv/kQIX4waDxxqKdz2/F9rYOWPiHwMgm2eUPi6XH06oaht8oK9kQU=
X-Received: by 2002:a05:6a00:23c3:b0:848:7475:29bd with SMTP id d2e1a72fcca58-84e5942f306mr124439b3a.7.1784933161733;
        Fri, 24 Jul 2026 15:46:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533ce1f7sm474895b3a.34.2026.07.24.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:46:01 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:45:43 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] xsk: fix NULL pointer dereference in __xsk_rcv()
Message-ID: <amPqFHJBnDEQGmOK@devvm7509.cco0.facebook.com>
References: <20260724164719.99563-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724164719.99563-1-blbllhy@gmail.com>

On 07/24, Cen Zhang (Microsoft) wrote:
> In __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> do-while loop without checking its return value for NULL. The pre-check
> xsk_buff_can_alloc() only counts fill queue entries without validating
> descriptor addresses, so it can pass while xsk_buff_alloc() rejects
> all entries as invalid and returns NULL.

Agreed, looks like a valid issue :-( (!ok branch in _xp_alloc) ..
 
>   Oops: general protection fault, probably for non-canonical address
>    0xdffffc0000000000
>   KASAN: null-ptr-deref in range
>    [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
>   Call Trace:
>    xsk_generic_rcv+0x26d/0x5f0
>    xdp_do_generic_redirect+0x3c5/0xcf0
>    do_xdp_generic+0x92f/0xe70
>    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> 
> Fixed by adding a NULL check after xsk_buff_alloc() and use
> xskq_prod_cancel_n() to roll back any partially submitted RX ring
> descriptors, ensuring no incomplete multi-buffer packet is delivered
> to userspace.
> 
> Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  net/xdp/xsk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b970f30ea9b9..76e0cdd43722 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -301,6 +301,7 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	struct xdp_buff_xsk *xskb;
>  	struct xdp_buff *xsk_xdp;
> +	u32 nb_submitted = 0;
>  	skb_frag_t *frag;
>  
>  	from_len = xdp->data_end - copy_from;
>  	meta_len = xdp->data - copy_from;
> @@ -348,6 +349,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		u32 copied;
>  
>  		xsk_xdp = xsk_buff_alloc(xs->pool);
> +		if (!xsk_xdp) {

[..]

> +			xskq_prod_cancel_n(xs->rx, nb_submitted);

.. but I don't think doing xskq_prod_cancel_n is enough? The descriptors
from the fill ring have been consumed, and the prog ring stuff is
cancelled, which means they are "lost"?
