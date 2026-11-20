Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134721;
	b=2zcWtx8V+eIYWd8XKjj51oSRH1BS3h3HQ2rQ2VUWB5syFrv+2bAjUqclGicmunIHexz+
	 MfXsVlxi+XUOxHIYJY9Eua0NPVl/c8msJ3TcPXVyKi1nGqUXgZKiv+UTaRTipC/h4N793
	 ruvj6osH25do+1SSPr9wwVvoH2ofYMbQGXza7xSn3ybRySP6OLgQL0WyzSypqj0qgNkAL
	 4BBCXMYiLWnw5J4Wxgh6KU5aKESz3mL2DORwcfw0AcQYpA0j9ZuSke1TJncfh+ezZt+XR
	 hCFI0IDKvnOk2DfrV//YbohoeI0n71H+ojKcGD5OhkmF1At1EAx6sz/OzmXmYR3pquQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6I0dox9mdYstBqG9ky0WjIUXtlB7TLrMdzBHbsE5LOA=;
	b=bi0g7USuryQdtWqvTzRWTKukcPtKbO40aDjUDjcBbqcXnKjh8A5DeO3de9F6dB9JZXTK
	 GgM2hUMHunXxAYbpKNfQWRxEm/jvxxtmWTrDZj70u5k+BsuvnSo4GGq8HSseccqmdYY5L
	 lbafFIFZKbklgFhLtsVis56BYYh5Z1qQDhcT5hZBNafOSDoGpJXKsjQVbRg8bHM/1JfYB
	 fC78VmA4xIzc7LvkAmyCmt0cQFkjH2s1vKVHCq26KMkh9/3484PV/yQlnFUg2VfceWozp
	 tNqIdPjVrQdU9dXTaeHreiJTivLKdT36DQk2fx9ein19Xi4aJaFYBF3m5PogyX/A8Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=glVrkyNI;
	arc=none smtp.remote-ip=74.125.82.66
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B2606A32A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 00:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 049B2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=glVrkyNI
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1aefd1bf74aso213741c88.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134720; x=1795739520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6I0dox9mdYstBqG9ky0WjIUXtlB7TLrMdzBHbsE5LOA=;
        b=glVrkyNIyYlm8wVTiuLIn+1R/pE2V9VJN825nkjbnVE7DzI/tklr0XR6PDNFu1OUjc
         A6P3ZfTwHJQxiHAjmoK4SpQIdS8Ir/katd03VOBvE+4swUu2oA+8IkTyyok1Pjj9/pPY
         jRHRWeNYDZ3yM5EUWHx+RVw95l+YNdToEWVWMBlDmJCQ5nDUi+lZAkU6M+KCBd+2W1HW
         fToXfkJkp8+luUW1MITx+x0oH3VnjO0S4X/xzsL89lshkI/VzuYPu9YudzfVuvXLiO7a
         PI2e6DkQIuvL5sJxpbyOQ9dBGmqKQnp3LSWMA4iJOQsw2EYyE1DA6dSJBL+RP9i6HuS0
         6Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134720; x=1795739520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6I0dox9mdYstBqG9ky0WjIUXtlB7TLrMdzBHbsE5LOA=;
        b=2Kw1acmCXlaQo8pEuSdk0EK3KaV4yWoxtfrfE3CKIZnAF7XmstXPxlWQobVUdTImCb
         OOc7FbSBTq0R2I96MpDsQkg6mx2RQHc50WuluDqr9WkupLsFYzbXMMJO8KIaiH6aYJK7
         D1Wr6AlC1ABSnLx04LVKQtzl/1XxXPcA4ado/ZFSlvaICYZ7Vdiww+SvExvwM+DE78zH
         MJAnLvLF6+gCYQonbRvzrOt+sjg4l79SyH5u/3BnEPIgtCddjsJPsdI/OJFOH7z4nqiB
         qX2Qj6b970Rtcg21y1Lv5xWGBpM5b7A0Zv3N9aEZ2drK6Nxmb7/uIG9NaBR2ffTaJ7ir
         4ERg==
X-Forwarded-Encrypted: i=1; AL+hErH1Q3Dmo/l0G/NOVCFOxGsqlMUdjiLNVpvcvVCJguArtznzVfBsSwZZiH2StLoyKTtiM0E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DGgjgYVMja4XYOAEX+gi+TAHuTDJ8yhtGqdHzidjP+qojFI8x
	Dqo/GpNAbMfsF0kHVKB9PPBZZ+jl/+CthpOY1Szg7fxNIBrzJRqTdno+
X-Gm-Gg: AYBFou0mbxG54zMCkITUARL3O2u944UX8d2GJ4UqmRKtU0yDIH0VnxplkUAp5x8nHgW
	o7V/LGD/j8RAiR848uCQn3vd+4L89sgNcvZPhDfXdBz+a5QUSSMeaW6P4VN8s5sO9cNhhPNyB5m
	O9vp7TP0MzXzHXVHX1TmFySfp99YxchBm7T4cOgE8HhjlQ61AxwMcbQtrIaVJ8zFaBM/e0WNrij
	+nXSds/6oJr/X7dLvO3miz7UslVnLvOXS9QkIfPF97JFNEg8+HhWiP+DA9Q62NcaMd6bCsf3UIb
	t1wnTZUkdQT+U5MhpBW71mr++sBMBhjl5R6yEDFlRCVKfI/BJEqtKzrnaQn4gOZOFwpnSPNzuOG
	ns9JokMEzodx4mSx3FkXO2Y5Iit1IQC2WJ4k+cD3iuEHZi9e8/8sZcANwh3b6DdAeRxipGgf1wx
	Brk70bzuLM6d7lxN/nzWk9mCwq0IUzSGORO1Q3Pfscj+saLLLH2JMtRiMxx+t/fV6qgRaR7MIwW
	NKJ12Cdf1+S8TlAbok+wGOxIA8YS/IYu3DVCh8uLCx6M5CpA5fFnft4vlEOA7WHiYXjHrxFwOJE
	dTKXWxA+lrDsT5lVT0B0vF8=
X-Received: by 2002:a05:7022:7f19:b0:19f:cc98:f603 with SMTP id a92af1059eb24-1b5520d7d86mr2448430c88.1.1795134719982;
        Thu, 19 Nov 2026 16:31:59 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm2242124c88.8.2026.11.19.16.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:31:59 -0800 (PST)
Date: Thu, 19 Nov 2026 16:22:53 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Duyck <alexanderduyck@fb.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, kernel-team@meta.com, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next 1/7] bpf: Keep XDP helpers within readable data
Message-ID: <av-SmgwQhAKI5u5P@devvm16445.scu0.facebook.com>
References: <20261117164700.2157816-1-bjorn@kernel.org>
 <20261117164700.2157816-2-bjorn@kernel.org>
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
In-Reply-To: <20261117164700.2157816-2-bjorn@kernel.org>

On 11/17, Björn Töpel wrote:
> Devmem and io_uring zero-copy RX put payload in fragments that the
> kernel cannot read. XDP helpers must not treat these fragments as
> normal pages.
> 
> Reject operations that read or write these fragments. Access to the

[..]

> linear part still works. Tail trimming does not read the payload;
> clear the unreadable flag after it removes every fragment.

I guess this is technically true, but why allow it at all? Easier/safer
to reject tail trimming as well?
