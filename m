Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5603C1408
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018898; cv=none; b=Fdd7BiLsy5S3petnTGS52RdvJ+onO286rMsUAL6+Z1igOSKTHmE5/ewPdA8GN0HViKEvnKLwPUeydjEBw5Dym1PeZ0SQN4H7573VsKPgF4lEvIWXaUu3krSd7qFe3kr2qZfhtu2gXFfKzsDdAK96oz46/fNC2jsh2l7o2hrE1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018898; c=relaxed/simple;
	bh=dKsUpyn2NKtJ5jpa/F4mcLLgTHirnEROKNm+qzVDoXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5CEfZDScpCVxUP78YYEEhomsUbTefMCoQJqwSd3Q123ITNZkRhrClOUDu1nrBrd9zG680LIokEzJRkG/aNggNt1eEn7uFYrhWku8u+Db6IhfXj86wGrMFbuqqZtHoOhjuyB693gg3GzIY+uMPR35oUYV/ReYpndGfjq8a+AdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA1PoHio; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA1PoHio"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c0c955a481so617673eec.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018896; x=1774623696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1+t74PZ37mjpgg0u6P8TqTzSJ8uiHRKeT0bk1Kj7kQ=;
        b=MA1PoHiovgoiWvr3jzVDwkQKKbfMTUlu41m9od8hIOYXclPkKR1JrT1crWlJpeOBg3
         ju7sYxDgGFmlVOzWRoCpw9XigjLy8po4V3vuFO8NAVOc0ReghHNNT8Mpk000Xt2LRXID
         VmCuzd2xd5R4yKhgMf7Azl2nZELbfziPcAJbZF5E3gakiEW1TKSKfti8W8BbnNJIQhOP
         EC8udA1UTTr3cdVerSUf0CT5N1ITk0NB4GXAtbPBVmrEnPErumg2IjmD/LTAgijuBIBu
         U7iwu9QbD4NYoB+7Q4NsJhuGwqG9/NIGOGKzcuysANky1wQDjwVGMVSnsA9OygHbzogr
         AiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018896; x=1774623696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1+t74PZ37mjpgg0u6P8TqTzSJ8uiHRKeT0bk1Kj7kQ=;
        b=Q8wzSSKTAnLWOcUP4+92h7JV55LXkaz3q3E3jhFYa6GNTsQUUiLIXX6bIrh3Do0VOA
         8n8/KxFZ/pWUksTNW0ASMnPj9EZqZECUFMXnSNxI7kYr5OHzZZLIFg6x1fcNL35H79BF
         62+fVJ0p1JMhP4AgJWvk+o88hg+60z94jEANPr7Yruaau0n+RfCSEU5z5Sa0MdnyeeFq
         XD0a/viamHbetVbSHoPSB7sYb2dhj7f3Ghh2gTILgXMp318k5yJMNzKGyaCVgW5RZ9Rx
         XhA8VG0AwKLZzMX0E44fGNTgazfbiM7KHe38AL540a9U7KIZjpPnsYHWOu6ZVLVekS8/
         0u0g==
X-Forwarded-Encrypted: i=1; AJvYcCVmyBFzpf76qXy+ev50WFEX4/KGQVW7SsKCoCMhP4aSYSiOUGo4dyY78e6q0KLNUtv/bd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kO0FJqFitCiduQVePmQScxlt8xLTkAoGYFm3gP2mWKvw8Avx
	a9fK73aEDWyNw/yuewKYbc8I21foLQjKIwttVHi2gCAxQIwPccTaTxGLxSG4
X-Gm-Gg: ATEYQzzzvojnddw1pn4vmS9X2ryAojgsN4c2FIAyHZ6ZrdHYyW7fJ5RNtijScEj0WOE
	nW+GE7r6+Zf4y3UakgK5yfMPbBDIxw6t6mAeHNOD8c1E9LpGRk4eHFKvv5dmCISLAeHoeOFliOG
	7Uf5Na0INV+7T7tt0enuDWl0a8NpnUvTfNQdWO881YATQosaXm0nxgz5ACiodaXJH/KciTzi3aX
	g36O+7uAqidCWWXWFshiWnO2G86F44kstyoqiu4zNYidh52Fz6vBUn1Nm1jkoIlMvujRQswjy4s
	MR4Cu4EmmrDuhp+i7U4/EL8z5/uOWNIEB+VCX7k8krjeCzlU3MehkqIheTkqm0EteLQx1m95gjq
	fLTeQUB0QcB3jbfMatmeU4AtDkH8RStqYZ5RyNubKrJpt8841MsHf3o8Jj9WmD5S8f/h2+DjtzL
	LiGaJEH9lUlqVmie2rzjEHI+bovxAKG9rapx0eh0XLK8p5Xloz6ET9Es2KVQz2g4N0w7RbNx/Y4
	4BQfhz1kwCjkMqwzg==
X-Received: by 2002:a05:7301:3886:b0:2ba:a1f1:2879 with SMTP id 5a478bee46e88-2c1095fec8fmr1786912eec.13.1774018895508;
        Fri, 20 Mar 2026 08:01:35 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2e6c30sm3345405eec.25.2026.03.20.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:01:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:01:33 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
	bjorn@kernel.org
Subject: Re: [PATCH v2 net 2/8] xsk: respect tailroom for ZC setups
Message-ID: <ab1hTRsbqS5dQ07P@mini-arch>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319175538.479139-3-maciej.fijalkowski@intel.com>

On 03/19, Maciej Fijalkowski wrote:
> Multi-buffer XDP stores information about frags in skb_shared_info that
> sits at the tailroom of a packet. The storage space is reserved via
> xdp_data_hard_end():
> 
> 	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> 
> and then we refer to it via macro below:
> 
> static inline struct skb_shared_info *
> xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
> {
>         return (struct skb_shared_info *)xdp_data_hard_end(xdp);
> }
> 
> Currently we do not respect this tailroom space in multi-buffer AF_XDP
> ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
> it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
> configure length of HW Rx buffer.
> 
> xsk_pool_get_tailroom() is only reserving necessary space when pool is
> zc and underlying netdev supports zc multi-buffer. Rely on pool->dev
> state when configuring tailroom. xsk_pool_get_rx_frame_size() inside
> ndo_bpf is usually called when bringing up queues and before xsk's dma
> mappings have been configured, which makes it valid to rely on
> pool->dev.
> 
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
