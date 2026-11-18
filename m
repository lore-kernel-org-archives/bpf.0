Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795027156;
	b=tNUQMx6pRwOxOgrVobc7MOaE0rqROmPb2tbZ3Q1Nlpn3hsAMkrLHuY3nFBtyje4TvBiU
	 i4+A/vUnsrHqNSqJCdcVKpGdu9RwJLVNVkGHnl6Ee+dJDwz2SuMJXn9Qjddhj/PjOKLqo
	 LC5LlQeA9bhB0oylOmc3isA0KrbFcAn59grpn9ix+HzCsjVRf9U/qGGFqqXZrX23oT+P0
	 6FaZHr/DyCk80spg41spkig+uCLhUmm7gYLdFU+QcIP6Hzd4QxlgbER2LzYYMfN9f3gJD
	 fxE8w3BHUR4sKRiZPV1joYip9oMz2VE9oKDiUT+76TiV4XsH83GD6gCyKZxm9Rfc6vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rOk5XMLKV41q7GLzoLXIV7TkndqjJrVZPK5114ekmS8=;
	b=A+bws+aatPJX6LWmP1NrE1VEv+a9v260RVjOISJ87rx8H/S1RHtAo9SQlDMJP21GXPY1
	 4nxD61wykRXx8KXxy9uKCrfGKvE+WF5AOBlPF+2rFf+qr0YXXWlOch4JBurYAjF9Cnhsf
	 6dqpl2feUQbK04JuxAKfwnbG983D4EvDPE/nZeWQzx0nJss4RVGhruh0K5JfDLuwHOwOY
	 +otDhG2PVhJgl4fkVCidchjY/OzyvbuRfZfOBiSu7+yWCYYa90pEDu2BLxbPXic39rpGl
	 RYnfmtGTexzuex55/tmsctAoRnshfsc9n+d48qHe8GqJqCLadOcyA4HPDci+vEhJw5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EqwkyyHO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86073606A32F
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 18:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86073606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EqwkyyHO
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae7fc5681dso538c88.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:39:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795027156; cv=none;
        d=google.com; s=arc-20260327;
        b=cPytywfjteQFSx3EJ0a1K0r/gbOGMfwljS7SNmGNiNGs7rKJW+Puv/KRuhKBX4p9Rw
         ngS3NOXsNgJIf+bUiovWuaqoOp1/hy3kkJhy74opySZsyqh9+qh9W216RNw3fMRzjvC0
         l2ReK57Hwml1f18668OkSmeEE3fNtWrcZEIP4WPANSBmCDmmjCaeaKxyP3cGWDpMoeVZ
         lL3ZD1dlqHKJieCZWTOxuwVVpdzeEP7nSkUFqPS+1cyXiVzA++hL1JxUv2vdqK9zSE4G
         ds5koIrsvqe6E1asGTfbYTiY8dOjiUMl+YrTlCl8/nA5s36Cup97h635U7JhHSj7a6lr
         uYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOk5XMLKV41q7GLzoLXIV7TkndqjJrVZPK5114ekmS8=;
        fh=lrvQwb4Izu9wl/Av0LyFoFWgMh2sRhPnimOURA/6XOY=;
        b=oWgMMhEYke28+REGcfaB+49bY6/3LWZqRO0gTtxdYkAD/T9zaV0TP0rUYcRCUaXheA
         J1xYNjMPXBhl3MkPMRN1oZ1Ur3xY9l0cTSKI3ojunErHSmQiArRuNrcms4HgFu36Zqfr
         tgk2IJNcc88B79S6+tZSo5X1Vw4C/gzHc0/t2gOMNftMSvPjhrJtKOGqfHFL7cwhiaDo
         iI34fdV34UA/PZ7xt/dApSTGByhpY5/BeJPsxSNLrDbKFNf86QUXGQ9UqiuJe0TmFEh2
         Q4IWp7tb20Ksw72i9ku28ToiMEWPEnpLXiXYHbL1yw3Ef8t3d+O8WCApLQQstl+VGbUR
         etdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795027156; x=1795631956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOk5XMLKV41q7GLzoLXIV7TkndqjJrVZPK5114ekmS8=;
        b=EqwkyyHO2oamLt3xfQMMarnkalFxCWVyLxv1Q4l0mYEbu9Pg/k9kCU7oyH1Siyig1F
         cWt3mC/3wl9qAqqs+Ug+L8GR/Rc8K62YHEnANmEQfoPZdf0TSaE/zAuGPSM+Er9dC0jQ
         yqu7KNRA7nBoQKwxMmvfsfOHSUatzhHxTXZ+ZbJwfT6hBEqT6RizFlKpPa4RJ8Abvhlw
         NGJS7hGUVZltdfx5P/uORo2ng5iK9e+F4bfrzFFzXZaVJFMHaIRC5uSyjEEA/bTK6+Qs
         uEkmLDXbWNpnNqszyXLwrsevSO0YAeVQVNWfon6zhYI4FTi7q064UqQX/jxAA7eFhH+2
         yZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795027156; x=1795631956;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOk5XMLKV41q7GLzoLXIV7TkndqjJrVZPK5114ekmS8=;
        b=j1M44ix8vTbzH3wiinLQijJu+hr+KsLl40o583aA9b6np6VKONa73+c7CspoquSqE3
         NyIfYPvz/ZluJPnJX7+/CJtc0YmI2XtTaGBqb2fij/8XoC5YNFOa0xg/64Ktv55B1jvh
         j+YEEbvFZW2Wol4BiNQ9NSlMjdvIPvq+U8NMiYiDcZCsPSzO3wsNTWSWj6crL77XLhyF
         6zxIe2U22GhwI6DG7855CLMtS4MHkE7L0JY0s4MWnSFsSEoUHBePIlHEZJTQSBmsyUCv
         e+065xRVHjdYXBmYcDoSfyVVzHfuroyRp0rHyf5B6MF/2cAQ1KS3SlpofZn+IlL7/SBE
         pehw==
X-Forwarded-Encrypted: i=1; AL+hErF/3zAOZjT8OBb6xC+6Wvg1bq86nF8XD2uIlHTwqP+CrfCZjT99eOxVtbrYHIydbILpcrs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ofMOQ1Z3lIowqWye8F6CFUz6oZg6nXsr5l+IJh5TcmZ5+e4sC
	Eg2J8wXUJT4P/AHOioyH8SqQ6wv11BjhIi5a3+/Xn7j/d4bTXyGSDTnrdiUYWITO6cmMOjqcADg
	adg2sZ9N81Of9DHncJifvsmGgNSC17ho2CehWiBWH
X-Gm-Gg: AYBFou3ThU4nlz9NkPwaSKCnrVzOfwtTE/QqJQE6dj1Z7zsWxggJ7jnoPV/d9vsxJBP
	jY7bj0dMoK5WwMTJhWyWSuSHsZjOpzN12jQMqQ/Fkv7DvbvHWUyDQKMPMVTkcue9oglDFE+pPFs
	KQ7F0NcAzD/X7PCrCW0hmkxz/G2eN+VJM3AyuDDN77MkQic5h333i1hBswK8yoiRH0OlYxI5byn
	44Jlml6SzBpb99mLp40oT7Eaw9BoAsZ4pN72TM69lmtcp/HEqngf6Jd9kBjyGKjrr1LH23PZvVM
	jrrcXBD/zfce9/8EBkudD3G1Y+xHUBZOgoJeRypf/obLXEwO3ahPkJV3GSU9GqFOo9C1TeO0fsP
	Z2G9D0jS0CCorAtB2WWFwqMW4lHM7QF6dI1jX9g==
X-Received: by 2002:a05:701b:2903:b0:133:12e0:aab7 with SMTP id
 a92af1059eb24-1b54d350911mr22039c88.11.1795027154537; Wed, 18 Nov 2026
 10:39:14 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-2-bjorn@kernel.org>
 <20261115131314.2d3ab96f@kernel.org> <87wlqcg85c.fsf@all.your.base.are.belong.to.us>
 <20261117163258.446a0c45@kernel.org>
In-Reply-To: <20261117163258.446a0c45@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 18 Nov 2026 10:39:00 -0800
X-Gm-Features: AclHuK8UJH3E_Epp2jjC1wv6_uDQD4oZqE2pXj-5wMybSCyzlV0cK1dXGLNdYt8
Message-ID: <CAHS8izNe7w5gcTrVW_gMue0-2HBbRkTpiqtUUcRGHZnPwiLp4g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses through netmem
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 4:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Nov 2026 15:31:27 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> > > IIRC netmem is supposed to be used for frags and memory CPU never nee=
ds
> > > to access.
> >
> > netmem covers pages too, and netmem.rst already allows readable net_iov=
s
> > ("Decouple net_iov from unreadability"); the in-tree ones just happen t=
o
> > be unreadable.
>
> Ugh, slop got in :/ I really don't think "the in-tree ones just happen
> to be unreadable." I seem to recall being involved in that design.

Oh, that was an intentional, I didn't think there was any reason
readable net_iovs couldn't exist in the future. Actually even dmabuf
net_iovs can be made readable sometimes, as some dmabufs support
dma_buf_vmap, and in theory the net_iov could hold a virtual address
derived from the return value of dma_buf_vmap that the kernel can
access.

Do you think there is a reason net_iovs can never be extended to
readable memory?

Do you want that point from netmem.rst reverted?

--=20
Thanks,
Mina
