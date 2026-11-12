Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472366;
	b=A6N+31SbRl/mZ57oz7Oj2na1OvOChJeCrLTPfhwIc28y2xcQA+OEsc53hoJxBgJpD6D9
	 o1xZhnQNXw71OnZcFRNZpCK8BY0A11iZtWYj3OX2H4Dlw1q2/1z3agwQJ6sdf8rwDtXLc
	 Q1l3LsaU+ZZpxc6T82FnZlqv9O8UR15fIKkwKfS14+yNC1FnlQAIkbDBv80zQMIRErjYG
	 GRNT2AJJCBsEvfjtA8t3qSwCrrTeRn8vfCW5XiL4BqCfbL0AQ7T+4QDrDFfsQUUJK1et4
	 lqHs7vucGVSts2sHRe5cYpG1D74VRijQkmSuLjFGce6fPOKHr35AbiQzIfPaJ6BbLDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
	b=oV4LY0ZaF+aqyqrgzYQuqcF1ZBynqfuI5AV2+WSkzbS3E5i+ZulBTTYNTWEuli9iwk4J
	 npO7Jy2Cxyxw4HVRhEcLT0UWyx4oeVulHS953R/gKd0w8tab3rdJh3xpJqsJ8v6incfCK
	 hyQdZDIVxAMdDzkzQMFk1U4eWm5+AkQVAPNhnbYf+BtTvI9+wHd0yUroPPkMln+fbAsib
	 HQwgs/fyjRccXD5jF0Lk3FGlbrFAl5GU4VUv2zlGcCacMPeoXJFFlGGlsDAI54I8kVn9X
	 oDgMD0gAWYGzdvTUm2IkyUAfPoO2Kp6ESO2MApzFWsWEszlpSbr9g0bXTVWdtPnW6Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjZZzhPX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314560A5BD1
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0314560A5BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjZZzhPX
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso4336073a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:32:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794472364; cv=none;
        d=google.com; s=arc-20260327;
        b=p4Ds+v/X3E1uzaSWDkeL82Yp5U/7NcqptsqSYKzmXg/KmVlNjXtRqPbt0y+QzW4B8d
         orwsa6MX6xYvYDZgpOn6epWL+MLEt1UXT60XPWr6QxXIZUt4JlZxubiPTdkRhorXt2H6
         W0BEIgqFjrX2du0oSZTeR7dBcPkzX6xgTqUT0I6mavu+1jeaG4Bq9uBhYwhyNTF3BayV
         d3biquqlGr0e3WgPdEX89zg6eTQd3FxDU8+PMN0OqZvlsrra7rJlsGuarOVseEq9XNvW
         AWD/ndRoZV+VQEraTU8Rk4chVg00mOOlAf8eT7LdIfwqHp4lhFoP59MOlxQB8uwCnoyE
         guCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
        fh=rZ2JvGvysgYWJoIMfIgP5gOIqg9i938DMdytKRap6Jg=;
        b=o7dU3akIGoJCA+XEWDasfwi9VYaxnpeKPc913s2VRgZWAUAfvJqPU+cw7FH9zMNF3R
         hzFxZqLg+d+gZZNEZEhwdsO8P2h0tkKrdfIVd/ykqPAvIhrIqa5EkDYn2vHyu3wxtpBj
         RmEUfd74lROSYGUUYhKHNnT3QGKYsmUsMIQUZCg4UFyIjvfVdKYd30ttIH7r4U9CAfya
         MCD3x3fmC7vb6RsriNlJURH1U9OG8A//WN8cxzU61kkBqG8RiYGzbQqya3XPNJKDJZ4s
         i8RI3cXTg9kb7pSbBrw7BWe5vXucu9086tmHREN9ZBQCuohMYCajMbqL/cfbpqfN39Po
         iDig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472364; x=1795077164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
        b=IjZZzhPXrQb+C82MzXH+yaFZMdw3I1fS6f+ZKPUlu4rKAv7YGY/A4npfbHZ01BDx4/
         vehtR2RomeLqZqfjL08oP+6ImriXxgfvzxYVKbLJ5TeraSk7AGdN2BqZCr8Wfl8Y6rKb
         hLv1UqaQKCKAPrnqdk/3nPwU63dOGY6TlaP1LNzhv3oNk0/OxVEzF2RdbLEzQ5w9cEX4
         CDX3IJKXBPew0T49m9+pPKYVvmv1QcvsMgpSfZrVqfxCa7YIZusZzdVD8FqruquU+RON
         bGCSzVs/dSbZYdxZLgr3yfjig8gMvd2nyMgu+eUgDB2zpv7w8KhcsyyzDz+XmXgXnOt1
         V+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472364; x=1795077164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
        b=nmUFkC4urTNZgBqSr/MDcW3T8hUc6MX204c3tD4ROZAM2XmONLSYqEqpo7AkPEYgvz
         55wf4lFsDS+arFKHgpLXCCAC1hzirY6ek9UnyUwJjyxzm2rZCg7UqrDKUxpizJOMt4R5
         1IzsNzoRF1vn9gAsoneTgcy5jVCr8JIJSQwMNrkNQbcJJLh9jZ0vQzMK5v+hO6/O0gze
         W0Ky/zM+pNXaciJ1D5xk7+qDrqfxwe1ZxWnZPvxuPUZ9DcVdM3/VRmdz3ZvXvoKIZUWU
         BAhTepBf/mFX/DPxmhfFHfCjrfqLUps8f4RQKhswo8Mpo9Hv5OMs6a2eNwlEGguTuw5X
         Y5Ug==
X-Forwarded-Encrypted: i=1; AL+hErF5cEYZmR4GTfMwJ61BtGcHCgo/Q6QcirI8UROxkqw4zM3KNke/kJHsVoCZ9pgrUGKEHps=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vcarn7PblDfzkF7/LBVE7RyFuAV3ympminLT2U5yNse0SR5NP
	qDLB05c6bZYNeDRFv4svg92nbjoW5o2Cc4wpxTn3riQRB3aEe0/dTD7ziNi6Wf3gaUhC2WwUwet
	0aeCY/s1Tv1V2Vgqw+E0g4P/Fc7doTsw=
X-Gm-Gg: AYBFou1fFrsllkyEF/oSRmtUjBApuUB2yytckSNY2ETmxGZsjxdCG93Bhxij+8oeXLo
	WR5jUtWnQW8C76diNW/EBi/tMikf+5uVmTu9RgxmsA3CMuAD0/vUclqy+ntZlN0+wykRPysVuNz
	a/yz9+5gaTJ2JYnHo6NyJD6G2/PNMoYA5NKtRJtge2lLlBwfmeGKP+FW5fiWmSHjVRtAiyX/ROi
	KNaYQsK+dULDg8boiEkW1OWynFaW+gqfIj9FPVZss78UgJlafT+tx0sigVMcT01Zfi+SjtIlTZt
	7Z4eF8ulUq/KHGDN1w3yqxOeqDy5pKXzzKQbZt3R87cscQIx+Iquamwg3KaOZrSCxZ1ylv/qY8u
	G8weMF99fbucMAltle7pzRAp+ncvRY8FMIOju7HimlfqfigCVBo//GiGPkqBS5BiZx+3PGyA=
X-Received: by 2002:a05:6402:2711:b0:6b7:a357:375b with SMTP id
 4fb4d7f45d1cf-6b7a3573c70mr809364a12.40.1794472364208; Thu, 12 Nov 2026
 00:32:44 -0800 (PST)
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
In-Reply-To: <20261110102039.1002605-2-bjorn@kernel.org>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Thu, 12 Nov 2026 10:32:32 +0200
X-Gm-Features: AclHuK_JmHtMGasdG1MlcgZSR9JInf5KlnPcivwlvNEZTX0IPHWZAk1Q01MwQ2M
Message-ID: <CAHfVqdVYBbs8zu40nEaCDvGVNeXHe2DXh0dGxEcgL3kP8S8_HQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses through netmem
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 12:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> skb_frag_address() goes through struct page, so a net_iov never has an
> address. Only unreadable memory should lack one: XDP and BPF read
> fragments through this helper, and AF_XDP UMEM will back readable
> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
> an unmapped highmem page.
Does this mean that skb_frag_address_safe() is practically identical
to skb_frag_address()? I assume highmem page is the only case where
non niov page isn't mapped.
>

>   *
> - * Returns: the address of the data within @frag. The page must already
> - * be mapped.
> + * Returns: the address of the data within @frag, or %NULL if the CPU ca=
nnot
> + * read it.
"CPU cannot read" isn't accurate, I assume that in iouring case the
buffer is mapped to userspace.
>   */
