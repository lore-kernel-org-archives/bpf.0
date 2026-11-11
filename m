Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794359279;
	b=E/93kFxbMkp/jyPIAWV61GDlD43Q6Fp2OypVe0i6VbSJHiElj8MwPMzyuJCMS5nRBij5
	 YgNYUjdNYj+0SmGYtSFkIOh9kad6hiiY/OhWRGFm489+oJi6AxoRKOBMungQdBJ5G7Gra
	 amPwGtEyXMFKmyNP9xywx2hOvPfPiHWoJdV8rz9hzgpSlJmMYjZ9vQSFGBvJa4aqYzNpn
	 8YZOUyjUR3T1M0241ldaRLc3X50Cbc9+vooz5jtUnUKYBi3be5oatLtNkdJp73E3D4gFw
	 25SftNWI28KCQvsta17++w5TPXwQtswc7xYx0DVNsRu0dT/yrHHwOUvUeJHFEHDXjDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
	b=awCIUbyiRTmOWoJ2TWO3lTjNm3JtILGAn9PpVaWYkLtXEliJoZUQXrW4wQZ5fPs1NqaY
	 qOM7wb1uf4XgAbycdrFUx+plTFFGji8/RKIhoBHYMudFL8v/78ELI7/4Jt6Ny7jJLabdo
	 Ftx50Q0zcY7ENv8uq0FClqidek+idu2XZsLu1SK0nKMnxObg1GXO9vJZxb1z41E94WPvz
	 i0NNxH78lWGf5HWbCnoPFGqW68a/lgY2Dz4rU71A+9oKZEwwaKMRH8BpuuF3PD5AAA8qQ
	 3GqLoC02n+XS6fE11sMY868mS6y3+MzsEMI2XfUh/1djAdfe4D+ChPTrHZrFSfsg7jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EjLXsw8R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCC606A325
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 01:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32BCC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EjLXsw8R
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6df5e315bd1so2070703eaf.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 17:07:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794359278; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDb7MTNJFW79GH/IzALqWpzbeBJatJiBCVEWeq4d4MvX18mes2S/JeJnsVQ8O5J1B4
         lofwLEHGPr8HMn+HtqU5hir3AgyYMttR3jYrgzYcd0P69RM0iz/1ICUp5HMxNDDnwhUf
         hWZ0HAwBvjhYatWbKXe+00xRM2ZxQdROxpZUBT+VQE5M3jqf23x+9g5IqV9fZmdA8fLZ
         zFCUhv3GwTlYAb5B0Ah4g/r31MetkIHvVTHeSZcA02htb05RaBEl5i/FWiA7ZQ5WKDEn
         7d6KKSCSnhNyLccfzMKqd0hFNn1C9+K9/5L1ugROidBdyV1W56qJGjYD7RinZHoNYte7
         XFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
        fh=LY7GBeBGxIWmuRDzXUpu6m08nqV43vwf6GSDhXCMvaA=;
        b=g4dGJbFAKbSxG8bQ2IewHYpZoJlKIr5sgn32VYNLE0MKyuDkVwvDBc2ullIWUYif/A
         0NFwqbV1qU5pRyRokrFWqjBT+54aFeOu9nAD4IAzDeQDCKZNbOkAhS5ORpK0VqGeobF9
         pStuaN4CxFt+jCE/TQp4e7snBjvbs/eexnwlH1XWgWxh3HjOIGOfYoik5iVtU7g20GL1
         sAwsnyFLHEuV9A8WhPZdBXLcUNw6obeAWMSqOASkcY0iOpFwBmzRjlxovkU/NbtgWTJt
         jgeAssuC1EDCZnjO10X4rG0vpsqQKzd+92XZk9QNEhHxGD3BbGqWZGid62p09VZ/EtxK
         JZNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794359278; x=1794964078; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
        b=EjLXsw8RYK9LddS4DSnzgL5BG+S85ls0lQHexUCxrrgOE8c+nbSlDaIhvMJmh3Eer5
         vXDdlz1/G98drqKh2hlkTWXUSxGkTgmok0qV2/fAFr71FqSgI1rOfEqm9I91pXhGhN+a
         fGhndmMZH5sQtIcdP2A7UiHMpAinpCQNyPuX/7J16MOG6BqZ0YCXUzkwK1YtUfg0GrQp
         Di4IW2RD0lI82lG0B9Mjfd+WCIP8XIOqnfufvF5iAwcdpNhJDSJ67VHK1ubTbL/9PMK+
         e61eCud7B1dK+MmTSNY22IE2hj2vuMWWhpkIMajTHeoeI5K75VM17Y4BrNZH7Z8DDmLy
         3Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359278; x=1794964078;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
        b=Mf6W+Pwj5MD2Aa+7uzvKjatNYXq3EWPTHi7n6K/r/PgfshwSXxlQbRvuW4gbDwmcGd
         EAKjl/u2jV3GbseVf86LXdslYGPz8eb92JAEs+GCg0/ghNLaFxHrnE+q+X7rH+7tFDKR
         uYXsdH1euHp/jz/Qoh0t4YNpNcCKKjrGUc6TOHkwlpOEs4vTSMpuMbeDYsPh9ZP8UZ7W
         hFSiCCdbXjU9J8J5Ob4PztvIRpGEXLafhiCjCyfpV4ZEzkkBPWjuWvVT7uzarW3yH1nB
         6sU7tikidbhup5NZj6By7aTiJPWD+7HW7b1NNRGe0hl6yuaHz1znlRjSI3VRG65H5192
         tGmQ==
X-Gm-Message-State: APuU4Z/9Z0rDq7HWOcg3H2s6Xhw5QgZpP//HpgfZmXC99gz6PXWmlDfE
	maOThtsL94xIkZaQ91qkD0v8i89XElVBO4RmD9giFdXyLGmYOqQr8MFmYOoCGIYgWCiAvKmbJ8b
	fggQzn9eoO5BRGudodQT5TR68J5N/xHd9Zi9ij/RqCA==
X-Gm-Gg: AYBFou1xrqrLPsGxTqw51k1eut65S+6EmB3tJjfv82jxXmJkpTHbEmg0fqQ6A03H9O0
	27nVM1LrbN+6RnTyiSM7e2pxRk6sEvXul+oNE/qF0zp1s1JvFX5isSF7MKSFrtJ3DrkCr6/AuL5
	ydWhKI8BpTZajbWGYOkE/dVf5xymtOpMUcEx8HgBwn7eGVeu15RE2hn0U4homY7B9Am45bcbl1d
	SS9gRXIkJjNwpXCYMJACk04VZYC3yMaFzXUDFyPT0UL2APXaOoBSBTx1rtbZ9ldcKeRccWmP5LP
	KzeUECWcZE8pV2HzarppnAeJ9PQ5MoXnwnumgDMBMCG/7kevyo/9XeaTRBntutEAUw7SYdad6b+
	RBNfMTeJwGTML+fHMWP+3OshO2YqFyyxBxQ1P/3lOkpdxoGG0dv/3WcyuoIX1RnDH4EVn4d7+Zs
	vzuCLbVIjUBA==
X-Received: by 2002:a05:6820:16a9:b0:716:c04a:4771 with SMTP id
 006d021491bc7-71917858218mr598043eaf.24.1794359278033; Tue, 10 Nov 2026
 17:07:58 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
In-Reply-To: <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 01:07:46 +0000
X-Gm-Features: AclHuK9OIHzq1A_ViLb9jLKzo-flUIoCHThbTHbypb5m7BOmw6IeVMdp_ZFoAAw
Message-ID: <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	llvm@lists.linux.dev, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

Hi Stanislav,

On 11/10, Stanislav Fomichev wrote:
> Awhile ago we discussed the alternative of adding setters for xdp
> metadata. Then the veth (or whoever turns xdp frame into an skb) can
> apply whatever metadata it needs (and there is some magic behind the
> scenes that takes it into account when creating an skb). That keeps
> the layout and most of the code outside of kernel. Have we considered
> that here?

Thanks for the reminder. Yes, we considered [1] and [2], and took
parts of them.

The alternative setter model in [1] requires a program on veth or
cpumap to call the setters for the RX metadata. We want to avoid that:

- On veth, an XDP program removes software GSO from the peer, limits
  its MTU, and can copy skbs from the peer.
- On cpumap, each entry would need a program only for this.

This series achieves the same with only the XDP program on the NIC,
which stores the values with kfuncs in the skb core extension area
after the xdp_frame. cpumap and veth take this area into account when
they create the skb, which is the "magic behind the scenes".

[1] https://lore.kernel.org/all/20250616145523.63bd2577@kernel.org/
[2] https://lore.kernel.org/all/aGvcb53APFXR8eJb@mini-arch/

Cheers,
Tianyi
