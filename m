Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B74D0A10
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219133; cv=none; b=uyCZwW6sFoP4dcMcqLLW8Qy0QBZzZh+pt+oQOLpTw7WAo6La48Za84u/sqaL49gBBk68icvBCvz0NMNDojKVWEZeHTOY+t6EatKOc/6R+toUD2Nruh54g7Wy/Gz1U0XwXLQ5HiN2JflBmKtaB/HoSusQvhHmir+itwESlwGWG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219133; c=relaxed/simple;
	bh=/tRm15v2eDHO+loamV84hQyUIYclpqiL/2I9jixRE6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc9k0ruzyH2C5/CHG1SZGEZ1qCCNDc3xAcm+A/6Z5V1TzO2/XJHVKROT7As/Dul3cbT5aIOhQAaSnoUN+iXtCPEvDyrfVbJJLPvxo+phfcBqnGdcTva7kUfbsVi+7ueKxCWh7TLfTOfrRJBhEPRoveUEVhCdrch9dYK6VYN5EkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbbmpGgO; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbbmpGgO"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e2f352108bso10209035ad.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791219131; x=1791823931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Ml/WHArCmzzGX3zR0T2czoQ4pKZKMdyG5OJbl9EXA8=;
        b=pbbmpGgO5iRj7JGDznK88nBraAxrqQ5X6sHI5PiSenjpQy8uK4emegnE+ROD1z7APm
         zJZ/406PYtFGWr6L3fMWI2/v8ZKrZcHjL3vpO0IyQmXZWy6oHlWXolXs+Zq4kvUrBAys
         TBNV1oGAi4HRVWNJbLARt+d9Eu/Ft/ETjIeGee2HK4F7hmlOARFh5g+P1FtZ3gDyz6Lv
         Coi3Kqgp2vt10/QzhSN4jMbCqEgr0dyNwW3xOsirh0STCyMtNkPo4qXJlmm5s7lpmAZ2
         gsj7DlO/2GibNPe7Rdrbjd8VX/feM6mGIT2oPR6cB4swQ2egQkcNMWZa+aSoKvAUx/5s
         2MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791219131; x=1791823931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Ml/WHArCmzzGX3zR0T2czoQ4pKZKMdyG5OJbl9EXA8=;
        b=RgIiwOZDR80h1TCedVAXM5n0hQRjN7KiH5x14fL1UxEnkybrzP3MyyjorbX1tIwVZL
         jXCNuk+lb+OGuEwRwcK/Td+0+qEV2KGzpRVWhCXW9R7vMRe79ayi2cNb/5Dq/AVFmE+9
         ZD5tUwJuB7sVaVOn5HFMLVlU94nc9eBM3VRxWVcgaZ9X3Y5e1+M4zTbhTxBPEYvAtfCE
         RPAGt6vjN+2iSTqoj/W/XEyY0xRS2I81xnJJaVqQlCvN/z/mXEofcH6i3HIwvKpeWnTg
         ht2Lohw7Eja8x4EdnK0KHl/USVRXRvizitYd+koPFVDEZ4+vJp1a7If+1EQasUv1keHT
         P3Lg==
X-Forwarded-Encrypted: i=1; AKwUvBy25WprpT6brlv5793qwyLmo2gxF9kj9O5/Y76A0hUpoxAXTP2vEXSThZPFd0Yi5pVyIhk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyXtQg8MQTqEBl6hjydFmDl/ay0u+5qu82IdHsaRCL+PCFH8u6
	yqI2QVdcDETa8UIzJ04/0t3UuzAw/1Eav0Lh+n2EtuvNhEJR2EJQXWa0
X-Gm-Gg: AYBFou1hTF5eduB9geSJGA53+dW6GFYjZWHsC0uUjO37UP/LqNef3gjDsibxQ+gvBWU
	wIxHx1/vdrdqWT3Q/Te8UX3POF7Ii+JOtlgBZScvTU9zHHRTUEnW2dqQa+H3p4KT6hBI3Yp4oz3
	PnnmBK5OtXXsKaHS1P126ac1ch1pa4ZO0nMb2M7j6y+glzmpc3rWMwXk9RuF/gPf46/gDThuRfY
	SMF9KIGTNynmOZ3qerHB6/lFkd6m4ayM+k11vA10I57MsT+1ptqycIlOMhVHU5eGtYGhVj3yVZW
	9m7xL4kLAB4nagd5SHosOk4YbjdOBvYloXyDLgPoYisckCwdsPqkDZL+gnPm6IzRoPXzUF7Ls1E
	9KE1tn4Hd6YYSM8wRf4vY2YeB9KLsS3f28pUPthF82CPkU5cSd1S6xc6UhUdu7JA7Dl5D00PR8j
	XzcHpT/TFBggPkQj/6ql0tyzwqS9eAZ6Gpf6ZUXlC5iiTx0HsFKz27eWwAaU+PWTHU
X-Received: by 2002:a17:902:d2c4:b0:2df:a4d8:57ad with SMTP id d9443c01a7336-2e49b699f84mr98443455ad.72.1791219131179;
        Mon, 05 Oct 2026 09:52:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5f001d9sm10692365ad.79.2026.10.05.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:52:10 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:52:05 -0700
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
	io-uring@vger.kernel.org, "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
	Weiming Shi <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Subject: Re: [RFC net-next 04/15] net: Let memory providers set RX buffer
 headroom
Message-ID: <asPVkD_QwZtqVLs4@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-5-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002190018.696925-5-bjorn@kernel.org>

On 10/02, Björn Töpel wrote:
> AF_XDP lets userspace choose a headroom in front of the packet data
> in each UMEM chunk, and the kernel adds XDP_PACKET_HEADROOM to it. A
> driver whose buffers come from an AF_XDP memory provider must put
> packets after this headroom. The driver sees only the page pool, so
> it has no generic way to learn the value, and nothing checks that
> the driver supports it.
> 
> Add rx_headroom to the provider parameters and to the queue
> configuration. It is the full headroom, including
> XDP_PACKET_HEADROOM; zero means the driver default. Add
> QCFG_RX_HEADROOM. A provider that sets a headroom can only be
> installed on a queue that supports it; otherwise the install fails
> with -EOPNOTSUPP. The driver checks the value with the rest of the
> queue configuration.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

This is also a bit confusing to read on its own. Do we not need to
convert existing users? The next patch does not seem to use this new rx_headroom?
