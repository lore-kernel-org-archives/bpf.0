Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530523;
	b=tZbLvxr6AqDdeUKME1D36+ZxdyA1XAXTFLk1mtYnZB8d/x/vaqJbrDYU5yKDZNsvhIRV
	 jfEH0L4zCbTSETmwrrE0HIq4qfYRsoT7LM2RWEZItExuAdqcX8V/J8g2lWgPadq4U4mrr
	 LO7MEgcaUh+jonr0+gNysQfyHiRP2o0C4JSbcLF1/t3vOpWzG6FSsfaaOsHkm+TWQIM5v
	 l1dTyV3HeP3hE31s5K064fp4ndi4s6B3mLI9g7LAcbkWoXU6aARVdo0MZNvtR74GxF5KA
	 Nmuh/K+JMTCGgdNTtEVCtdaRCmbfKeSTOoN+z88rrX3b1lp2Q9qqv0beiBn9OzRiFkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=rN0Ie5yME6hsx7pm+x3UNEKpXeb1k8nlYJCB408a9fM=;
	b=3wjQDKWpLrAyqcwDITDhfkpoUkGqLTVz9ae1VLmif1gCaMhki13GXuMRr0ZyvYs44m0X
	 sa1wUUe3e2NyXOC0AZbxA/EtUTrJKqVrXpHsfSI8gpaRsSJmJsfOmBJNIVoo2nqeIFSn1
	 pL23fZL3wQvszmw5Md5YzCdkOmy553pkhNeD2ymG0LScW9/pgiCpRu/rd2GDvOF/SUv2q
	 pmt3l63tO586QRWBNmXoyJHMb9w4313dpK0WvMFHv66wlDW+kpeqRnE4xXIAlpTtqtduv
	 RW2SSLLejTBdcOY4fd8ibGAByTDmnPCIYH1H12wddp6ySRjKD4Fkj+L/CfaaSLDJg3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wS4wsUX6;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1BA606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 00:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1BA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wS4wsUX6
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f758312e0so137187eec.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530522; x=1795135322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN0Ie5yME6hsx7pm+x3UNEKpXeb1k8nlYJCB408a9fM=;
        b=wS4wsUX6ixKaKqiYjQsFCJYaIJKn2BaV3f3zkmlFUG5frnXleY4I+yDFt5BO59cWXS
         E5JETtLS9PRnKnT4J1LIE09WxVAAseI/wWSe9ZZeOV6x8kziPaEXsCY6VA4BF3ndFAYK
         RWSIBklti8rhZx7Uw73mxUbumVjoZyDIRHpcBnNQhm2oyRlOtVBUnzHH7YKMa/VKxtK6
         XRHkKorE0Qv/+WieykgVMwoTnmMHuUtoJt685pJPRiQLmu8VwLBvHw1reor7fxpobajo
         9lGqkOBDxWRjtpOvgGDO8xvWJO5ml5wtEjHhs/tWxIBi40DGSxddqrSQp+uaaq/lq/0t
         sryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530522; x=1795135322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rN0Ie5yME6hsx7pm+x3UNEKpXeb1k8nlYJCB408a9fM=;
        b=2svDaIGzQ9valtxN5gWNzxJEAkjFkG+8gJrr6JgHW/ziJjCwljOHdrtJS+sNCv+9i6
         F8TJJmnVSBYqo1FmklQU7W26qHDBRb/E+3MVdMDGBw7gm1day9LVFkGIzBFPCDA2gNfi
         5f1iN5vVx9Zo3xiC80gFNlJZCrVeiYpqST+zUrzljPxY4jM/iJkAbdMUZrYitiZ2qDMD
         qhGx1uCdgl0o2IiKFo7hb1SoUwwvxeSUhS0ABobCiEMLFSF7OQ85ng18GIOFN3fjyoq5
         wSCeTX6xzIdYCnPfb4S3r4SIwDsNmfE3aJ409eRQgKjwzQJY2lRYpSZtzzfR1FYSN647
         0WaA==
X-Forwarded-Encrypted: i=1; AL+hErFXqYNgExZqbkFyInNqjsAmZ2lIf2+XJKbaG+T/p51BrX0VwHRBZyy42LQhVkr0RWVA398=@vger.kernel.org
X-Gm-Message-State: APuU4Z86LzgrDPlFxvIjyA48urrcDrdZi9g0mC9kQybff3V56TgPXWlb
	7HJABgGKTONm5nwTa4jJWVt7xCao3au9TRfOqmqff4Xa3avbIi89qCQV
X-Gm-Gg: AYBFou2A6zISJYEnXDG8JeO14HU9CDsYCxG2U9WrJaLtwkcHO4A5ODAxctKz/KBg+PK
	/LQNHbPlnyCg44+OzRA+LUGPCA2Ttgu5PC+mz5X1WHIvjJq3wMbzhJ72MqX1ldjFOYV4OrMlBcd
	Gih/Z1u3DIl/GPny6sGhFapvs0Ix+9LDoThBfW8T+WXwUw0GSdIIbK4K/zuOsqaVu7gx2UGDZhJ
	wLZa/7PCV9jaKwp+xEjlQuHc9DqOFe2Kzl03F93ugTCh6J7i9si6lzTqENObeHiietaF7y6BdFc
	vzSabhL4+vwhOWIQaAqrGCXOkNkqq47LKMD2cXQWLUrJ3/KC+ClylKCn155P9fqsYswGV8TmNn6
	A3WynN6zISNZAHUe4k3rc5w1t/NYa4BQyZEqpBSixyv1sKG+TqBVUVbp4StIeJZwG05YZLW+SK6
	HrN3MOWRNvB8odzVNm+k5iVLR12K8UaYLjA7CFT57hGCjPzNadtg3GwPrzBNgyy/IkyIaol9j0D
	oT4kfBTXtKtB5bbbU4RS/IZ+RZbqms8Dw6DuSwjcj+rKbuEOqQyGMCBPf0ki8JN1nzz+Hid9L+U
	gylRUNgKn5BVvmAHeMFiUZ/P
X-Received: by 2002:a05:693c:8852:b0:36a:1452:8dad with SMTP id 5a478bee46e88-37966f32039mr734196eec.20.1794530522135;
        Thu, 12 Nov 2026 16:42:02 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:71::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm1934134eec.9.2026.11.12.16.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:42:01 -0800 (PST)
Date: Thu, 12 Nov 2026 16:21:27 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
Message-ID: <avZXuHWBUTJvJnEu@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <avOYe27x-AlxmyK9@devvm16445.scu0.facebook.com>
 <87mrrfa6c4.fsf@all.your.base.are.belong.to.us>
 <avTy21_cSnyMdbb5@devvm16445.scu0.facebook.com>
 <87cxsarvwd.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxsarvwd.fsf@all.your.base.are.belong.to.us>

On 11/12, Björn Töpel wrote:
> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> 
> > On 11/11, Björn Töpel wrote:
> >> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> >> > On 11/10, Björn Töpel wrote:
> 
> >> >> +	if (static_branch_unlikely(&page_pool_mem_providers) &&
> >> >> +	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
> >> >> +		return 0;
> >> >>  	if (WARN_ON(size > max_size))
> >> >>  		return 0;
> >> >>  
> >> >
> >> > What's the deal with that? How do we get here?
> >> 
> >> Hey! Thanks for taking a look at the series!
> >> 
> >> An explicit frag call on a whole-buffer provider is a driver bug: UMEM
> >> chunks can be smaller than a page, and RX gives the whole chunk to
> >> userspace.
> >> 
> >> But page_pool_alloc_netmem() also picks frags for small requests, so a
> >> valid call can warn.
> >> 
> >> I think it would be better to make it return a whole buffer and its
> >> actual size. The WARN stays in the frag API, before taking a new buffer?
> >> Wdyt?
> >
> > I see.. Idk, I'd still return 0 here, but without a warn. Not sure
> > we want a warn for any api misuse? Returning no netmem is gonna be enough
> > to debug things? As for the calls from page_pool_alloc_netmem, I'd also
> > handle it explicitly? if (size > max_size || !page_pool_supports_frag) ?
> > But no strong preference, up to you, was mostly trying to understand
> > what we are warning against here :-)
> 
> Yes, page_pool_alloc_netmem() gets the explicit check. Thanks!
> 
> For the frag API I'd keep a WARN_ON_ONCE, like the size check right
> below it. A silent 0 looks like an empty provider: the queue just
> stalls, and nothing points at the driver. With the helper fixed, only an
> explicit frag call on such a pool gets there... Wdyt? I'll probably take
> that route for v2.

I guess, yeah, makes sense, let's return full size and warn. Maybe also
a short comment will help to explain why?
