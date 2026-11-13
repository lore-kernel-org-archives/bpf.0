Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794547076;
	b=2sHL6LVMay94UZtScgoCBonHMb37TGtvqb9+DczWTN/UVwHLpE0q/DE6stnYd8fnH7ta
	 qqGc531YYOEPKB4Rjnly/4yN1qfx1WuqT7UbWWkGRrWDCpL9ASENptYkjByKJxn/3ucbA
	 /ZVzdOqV3UY03hnShLekYkAT4rKuz8W11QHRQd370pUiy6HxfkRkEWuHZG83q4FpETpIL
	 posBA6LjjoLCL90OATs92BbaPC6K1HLYKsYgSYYf/0ujgS8ctmwkqkAbJJ4NA63LWJRpW
	 ZsqFa38uczQpaERuATQ0qSdglRLGRQAFd/puOijqUXOUUuzV5FpxUHBBLfMrdBo5BVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
	b=bHgdCPcnrE70+3goK0t22nXyf+kqjc9Ba//IcQOZgKLooTQSE/R1zDKPBSuA0avuUDto
	 H8JVpGAkYSNaomu+bosf8YKi6j3NFXLfE7m7fSLVzKGS3azc7nxd+BpEZG5V8YFJ+EmTZ
	 KUhhzLjLF4/TADatDjTST+uP2eLh6MPII97UtlxiuL7wjtctMeyXs/odCIlYGcEvNYlbm
	 Sa0V7JQeDuqFkhJ9IfPXyp9V1GIyJE2T0FLysZmcO+DemBYbCWVDXMImnxUaWiW9RwXoi
	 sTbmkOxO72lyoysv1elCuMAGMqwxjgLPSeOaNyBJfdcoWGKpSEb5cQbviciCBRWP5Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XkcAxtUC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7468606A330
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7468606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XkcAxtUC
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso4468a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:17:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794547074; cv=none;
        d=google.com; s=arc-20260327;
        b=so22vSSXHOD2LIHyfXLLmtXoDiuBp+l428Luo3EXOC5RgFyzLz52Mb4u1J6L4ubr6c
         xjmE913BcKHwO+3E3ffG1E6/zdy/yQPQSt1HxPsAqIIxtb9btXe7UCo7Ltg3Tcmjt+Re
         DPz3GYtpAHcrg1X/Z34ptQfuw5rWeauu4nWi6zt4C0PG1SIrNB4CjKucdWY1fFUWK9pz
         n5Ng7Nxh/FTwlbQ45oPXD/AcVnuf7aQLZ+MUh6LCR4PaywIaTdXT1Y23wbeZ/u9kXRgj
         fppLqrQtUuWofkEuhXmN356J7YPCBnoCjiIQAQsr82+1E2hKbmV/QjCtF9W6Xama+727
         dcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
        fh=UbeXgJX4Xyd8Jfnoz6iWvjSU5v73CFgoSIcDInSuGIY=;
        b=inMu/6Em4rktarXpRRKHuB4DeVD065Af8gUiZoSxPQ/50X63aFy7mvP1OHrYH/1fVk
         x4KXe9QwD1UIQDchCqCnHkKxWPh6VN2WFsI7I39V5KpvxUAL46fzoqBRxwYwYOXO7Yal
         dbVwLhMEimQwbkPVM2XGFchG6pWdwV6++/1A74FJTd9HCWORaAiDiqyGfChAAb2LE522
         /PCKe6pbx/ZHAHy3DZPeY0FJ15efmZ+2X94zjEyHtsuXyxGOw2THSKBmvEmyaWDqVbba
         UEG0IdMVhR3j6J3Pq+eC/0pI+RPHbzfXSEsLkOdxuIIWRsiQp1GMqfeuTpxcCoyJgLU4
         y9lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794547074; x=1795151874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
        b=XkcAxtUCanemul+RicaP/aozebWZdnRnipw0ipFQorOt0CF/BrSpgOa8erBdCdQ4N4
         VLN7NIrJsbUZs5/qRbv6PVx8HdejsexGCcXBvZF9JMwInu54ZTGyLTXV4CP5Khnt6ZmY
         KtwFVLwvIbCaIc+i4hJo68hl9fk2E5AG+n1NWywpxM5HEwL/Sh5PnG2wSuHDKvMPj93c
         eS9Wdn4dxDybUNs84KncdG8MxZzbqIualdyZuYd1d9+Jv3B6t3kVQ5SHpDpkkDeOs8Hr
         TJbLqq+E4fLdgNwbW0RukXF0HL4RUXNqvH0YKSicntzdAKQfXtwzBHxp8r6Xg1qJ7l/Y
         8paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547074; x=1795151874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+W0yRPPh5LN5Rei1H2okk7m72K0RoxQKNaAvZ54EI4=;
        b=yyQEEv0t+LEmiSLOFO6V6wC0+BYO0ob7NOejjWllP5Q4w+LQFLRGwQBq8Fezl13ExK
         H5alnbASSrOOEJcSBsI3W6+IzUNOYw9fZPNDOS35jWncb/u24V/U6Jf3ThoeM+y6HP1w
         h2gXk1QnHhX3yZbEnAxLIcuyJRqiIYItSM1vZcUmjhir+7vPoZ9WEtMeOm+wT5TkN1OU
         jzFxvz6tAsJ/0EBSZ+GSO7cjemYCv5j6SnPCtSqAkg3GM6I0A8NDZhFJr6drnZ59UHIB
         GCsPcSkZ/vDNquMH8Z+QNZgaMKi5hh0onlp5elTmMMhlT/cP8tf2gCzpLdEmYaiWh/O8
         HEqg==
X-Forwarded-Encrypted: i=1; AL+hErEP7JvonvlJyq0bYw78wnyr36Jl4odfACRcH39Pl9FkCsEWgHoLce5aUZDlGbfWoSN7iyg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EW8tXmvfnAsq4KAHGRw3Aw++BYzmm4Oz1W2/u+h6XoDlFz1sp
	gOKZnAl8z7xVCDaEnyzqEtSurVMKSFBu1HX5sL1IL4y4Q7ivmIRvGkFMkz7sIAGkVmzSDPguTMs
	4Pfz5O49P+dxLBNVafKqfIzyFpcsUKK91lrlIQY6s
X-Gm-Gg: AYBFou1LOzxw++EylYsF1MVhBlADFBc61dhuuPCKziqFX5uoEtLSs7UzMSxUDBr2rwh
	VDGN/4P5Gfw5VdXj8rC51J/ulmkqcsa9l64E+z5fCkMb5fuV1VNQA9KWpW27oYU/M3OU1HJxJ50
	Aw1x0ljmj7I/0B/nydayxCpke1kEMnTTyaCrQe0wenLDucMFbTvRUbBgJ0JXmXXWn8a2mHcLZNh
	Hx5Z3riOTy4R+3JMm+y3zvqINAkOyY1NBRjihL3V7enBBaWXF0wAaR4g0UBzyPc9wk04KzCoozI
	lq80JHwDBaI7bn4uzPb+QEQaIB5cFv6RfVhEwRBwq84HimWB7voSCR4tGGNC4tb66SKwXttT2oQ
	npEkKjAUOVlGs+Pcm9ACCzUrgUE2HjUMtq+E=
X-Received: by 2002:a05:6402:160d:b0:6b5:70c1:650c with SMTP id
 4fb4d7f45d1cf-6b7c34c6eb8mr48079a12.4.1794547073617; Thu, 12 Nov 2026
 21:17:53 -0800 (PST)
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
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Nov 2026 21:17:41 -0800
X-Gm-Features: AclHuK-EmG-vcwSjI4xi1-iRc2SNUCp5kahvZ3vW1cJ6PmqMOttCBZ_NEdrFdlY
Message-ID: <CAHS8izPnmy4W6f3dWp2NCkmNYxtP8jKm5rxjvPbQc8VdFm0Wng@mail.gmail.com>
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
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> skb_frag_address() goes through struct page, so a net_iov never has an
> address. Only unreadable memory should lack one: XDP and BPF read
> fragments through this helper, and AF_XDP UMEM will back readable
> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
> an unmapped highmem page.
>
> Generic code needs the size of a net_iov to find its address, so keep
> it in struct net_iov_area instead of the devmem binding.
>
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Are the changes for niov_shift some kind of rebase error? I don't see
how they're related. Otherwise changes LGTM.

--=20
Thanks,
Mina
