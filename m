Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098265;
	b=n1gVP43Vzu3jtPRr4Zx7lkUpeT+fbLNngpygDTyDZ/1+w9fx88LNAEc8qINS3OgIdITQ
	 vXoURUA6fzb5qGL8ary0WeBS/b2FAoCKiiXFR+HzEYLoX9jM8qagFjdEvWh+EckTRC53A
	 xyLKdCUN9f6atrEyB6DszrOc9/CkLHL6ULufFrfL1YEam0zm1AEghP183zYxzCSydNyxN
	 3h9OoSpsOYtYEoPuXAaphdPbVELd7MktO4c7Q/jiNB2W17ZZRTM9Q3nMhzTq/AsCdOLFT
	 VkOO/aW9VVS9dhNOMQj57UketMgbpVaUfNsYwq/YAcevAGVaTzJ5rD7LLwT8oVLBWxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
	b=ugdrTUbLTtwo2m3sC96EWQdqgZVWnegaDA6P//nBv/3Ta+RB7YtXuwabFDj3FBWAnQLB
	 PiMVZD9oVPKlzYw3P2dXd5yScemd2skLJxlz9Fpkna/RD2KtkBxBoCKq6tZe5rItlhacT
	 3ODjdxXXGD2D9Y/53yns4kUIW5o3z0LEG8bQi/BGmNA+hkde3+Z5Nwn+wdU4mYyl9As2e
	 Y8rEAJqvJ9/Uu3rcP/oqLNez7yPKmQQxAlYXgaAoBET3O1GvNEWTnr0egmksIozDDMSMu
	 c/FnTOB7T1wpZ2Fp+w9WDQ/bLc3Pg/zEmM9pjBHgS9zozHke/9xw7tILR6ZRFUeYFQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Jky2d6gY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44E606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A44E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Jky2d6gY
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-71ae5389c00so1579564eaf.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:24:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795098264; cv=none;
        d=google.com; s=arc-20260327;
        b=FIzj41worJTLlK13tzmHurMt71Xg/OiEMGNuMnCPp96xr0avSK64B683/i6WPXigr6
         FHwDKEg8vnoDJRl2blxdDDRwj1ZtrOdDlKpE68LhvV8ci7qZnyvwsk5f6dlVh6jvGHXV
         acQmOdsQn2NrD6ZMRcQtxGq3S66tUuBclF+kxZBHaEhryesxYa7voJafur3pO8JEmu0h
         mKFQ5BL/Zya9UqLuXcK1mg5/aE0fACHhx6RUpNB2d/kmZan2tozKkAP0/8vbkeJ9YwZ3
         JFZEtkinQ+isCnesoAZPcd8iDrPCli+f9L5PtKN4pk0LWJ1iQH1oMxY/qO9qOQjuVRzF
         F5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
        fh=y3WvZY3A6UnqJImtMFDQs+01thADJIywsoJDGxIXAtA=;
        b=fu2aCOxCIUa1+MkntM/Q0pw7ykADukYmjfgdCvo02Mim2L9OVOGNZD03A3KwloTeEn
         kQP1Q4wbdzTQLzZKesLHny4B/6bBOl6c5W/4qWLu7Mbd50e9Z9ypMjrfIw21y7nJ4wi4
         FjvB7vjg1YgB4AFGm4nHACd0jyp1NiVLLWNAUUUmVUo6mTMA+muwoIrYiX0bzoPZEEHl
         mqFHaAVpxtsQpo08dzJfQ+2MXlRpp/ERSQTYwQnn1k4ICHyvpQ6gKxrdEwA8IGVF+MBS
         rGLdenj81X1pgw5TTDbuvoE6GnSiRLOimzD/KaZRLNtx+EgTfT8Ti4eOJXRutZaNjd0D
         01Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795098264; x=1795703064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
        b=Jky2d6gYO2im7zgXjsRHuw8jDBLvJEUKKauPO49apSmZAHtopHWUGW9waTKeDU6oKi
         OG4FE0LJagiop3Ipbm8Y/2r8NDw0FCzRIeDflqWcnhIfSDPNNGxg8CNqtWMA5cpHFUjm
         wh1tshorNt5nlQE1S5K/GOFnCXDu4SvTkIVT8x0YWtEpMzdrJy517oWZCwAVxfd37wXb
         HLe9cPgjg5pLGDXWbiFckzf4pRFHqsBmzAhvZLitWyefhCShnu7ojrM9P8qaZG89nV/1
         4HEEKYxlco/Ghvuv3qIXR4sM8vTlwA1gzjO8a+MX5Miw2zqc0x66C7gYW8AX5CSU1QpW
         E7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098264; x=1795703064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
        b=Dg2Bmlzt2CZoizUNrsyaeXUISwCRG+UV5iWgxCIjyeOSXkpxF2RQsGFlL8xuSGPwt+
         CJt2p0FpRuAseOddV4nu9u83+NowhTTjXCN2SQDWYXp8UbIVqFFuPdO37bBULj9RLy/6
         gATmKD9AfHMmV18zDPT/W72Hqy++Do8QMNa2ZFjg602X7t0NrsRqhcB15QSlvgKYILBn
         rrvMAJCpQJLpxiPtk0yBgxYj6kIjhCoZ6ChPtVTDIJtB5GwirsBGJGGXfutI6kIHd7u0
         OqBn6YAkm1gp5WNgOeRaCvRt3gD+ELKRvNwQlRLZMdmiPZt0ynQb2xQra5DjPepchODa
         nFlQ==
X-Forwarded-Encrypted: i=1; AL+hErEXpxmXoVH98gDnJVobhKoWV0pyyftm0mnEeQqSmm3FTLzT0UFGLpLb3A3a0oSChgtQX2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/K1iGd8bQTp0zvFHFaD1YC7u9cPMEUZGkLwdZu3dxHqR3AAdO2
	0MrjwqJTHTtrmaLB1YjxGSclDSb3otpjYAeQ8zo8+tdgmO9e8QccfOaclYuBU/si0ZG8PeleqDT
	uxfQJfpy5eEINsSVORFhAZbPW7/l0UATIV0AA/wAOBg==
X-Gm-Gg: AYBFou2FyIz/dt0K7y3VKXl2y6HiHg3L8UEdyZIH8YYpWcIN0cLWTHB1jYxuaYSPDmk
	pHe6qO9sRghP6vfbTIgrta8aWMQ8MXHbFVGHzm5Jix4sfrXMpZDFaSdZlRdZqTvZN9diD3dOVhO
	XwaVOeDSXCOXUtikWTfWWhVL4+IwJ7MFbmGyRY6alik/k482A4aWGlwa8LgAikzgE6cJxulWWsR
	qIyQ6HUxNRaoTo72mfFNKbqfBgaytyR6tQdUXHIkQrKbR3N8xkI4I6DeJe43DStYsa3cUcqcwqI
	gZSOXNVNgIHza8vhQ5EAgPRW1rpUq5FIqtCvb24k5S7+2RDzZfPF+sflguUrNObE6qV2t2DgmEg
	I6g9W8B6E8KYNuRBsCqnxAV5tdvUaGv0mpcDJawRk3OJe3yQAhja/Oit37Nldz+guXrGGL8mB1m
	9QFNe1ZQv57Q==
X-Received: by 2002:a05:6820:1355:b0:71b:193f:2eb1 with SMTP id
 006d021491bc7-71b193f3492mr4490832eaf.1.1795098263194; Thu, 19 Nov 2026
 06:24:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119133032.2015656-4-sst@poczta.fm> <9a5a1487a4676381f4c3d98cb5a22f50e2f54d9d4ec7947891c889b64ac12693@mail.kernel.org>
In-Reply-To: <9a5a1487a4676381f4c3d98cb5a22f50e2f54d9d4ec7947891c889b64ac12693@mail.kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Thu, 19 Nov 2026 14:24:12 +0000
X-Gm-Features: Aa3M54pU7ZbLxGTK6OUaJJJ5wSY671yMAwh7XMSPppG-d1bHhduINP_cjWCI05s
Message-ID: <CAG4wq-favnH37jS2=a-aJwBgQOuW=KTsM-vJWp73PNDfFq4=ZA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf 3/5] veth: use the frame mem type when running XDP
 on an xdp_frame
To: bot+bpf-ci@kernel.org
Cc: sst@poczta.fm, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, maciej.fijalkowski@intel.com, 
	tavip@google.com, toke@redhat.com, aleksander.lobakin@intel.com, 
	ilias.apalodimas@linaro.org, lorenzo@kernel.org, magnus.karlsson@intel.com, 
	ihor.solodrai@linux.dev, edumazet@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
	martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 13:54:58 +0000, bot+bpf-ci@kernel.org wrote:
> Is this Fixes: tag pointing at the right commit?
>
> 718a18a0c8a6 only reworks the skb path (veth_xdp_rcv_skb() and
> veth_convert_skb_to_xdp_buff()), and does not touch veth_xdp_rcv_one(),
> which is the only function this patch changes.

I think the AI is wrong here. Before 718a18a0c8a6, veth copied a
non-linear skb into one linear page, so no frame with frags could reach
veth_xdp_rcv_one(). Either way, 718a18a0c8a6 and bf25146a5595 are both
in v5.18-rc1, so the choice makes no difference for stable.

Cheers,
Tianyi
