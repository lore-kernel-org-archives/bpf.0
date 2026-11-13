Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794547871;
	b=BbPlYBxeiU9pvmoGkoECfd5w3hlYnd2aYFQqwUExIO2ZHUffNF03J9RMEVLzg47rxnZR
	 54QDeEBebvFDnjZs+MOslvTQpskHBMdHf3PJTbPbuxbk9PoMOPG0HkPUycgyAil2i0fOt
	 dniVosyefKLsbbWMCLC9rzeTXkeIHi4QbndIsmVk4h6lT3GNIYHYtcyNFKWlUPK7tpYAY
	 LR5Ecy45lRAdlD62X1kbns7FEb93/swjdbya+VHHDLw/6QbTfs4ccf3aXvQ6yhRYfmqDI
	 cpaKJOTwrOjMzjMLrP75l+GezPZxS/YmXaGP1hNvb9QFtJGnHZqM5abdfvp1ESDe2Rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
	b=COQBfDdxWXHAVri3MMOx9xmvsqmdf+HxIfkSgohy6QR92vufu9l3snp/MQUPZrxQTGTQ
	 Xy5wjpAxlI+/Dx3XjJ+8zOxNMBnLGpJN5b+W9nS+VDCAxDHVO+Y4mtyi2tzvvIQhGqmF5
	 pS+SWPuLprE/u7s3SjtLiQ6knt4rXTXHwS6JKSZW6xHOp7gmfh07ezSF934m5LkaK2hxv
	 w/aSQ81Lzd6cv9+7/SsaVHs+NKSEJJ2nbsgPdoB9roaeE1Fp3KzSXytaRdLd0BeWVb4R0
	 4lGle8avbYjSwUcZFFAfXOYzDIjTCqDHrBPx2L4a0fPEnfcMhx7TgNa+ZtGvdrqmjlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="VTU/Umv/";
	arc=fail smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0164606A32E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0164606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VTU/Umv/
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso4650a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794547869; cv=none;
        d=google.com; s=arc-20260327;
        b=ar734nysBQbUL2FR2lWCX3besFc8bExqFjY0aseaS1SqGaxgT+37odVYN+CS5ZT9x5
         BCflsW4DvdDLKwMHIt2YsyREjS63f+WwNfd0IcQuhB3huLS566g1C5cTHUxg7W/iZ5cM
         epgvpUsxvKw7Z2lghSyHwyAGM8k6mP8BXf/FgbzlW9ffuNSu83k2rj9K0uCCUUVeJ7F8
         164THU91ezDG9w65uXr+POU2fBuihCyE4Uz2cEHtaDemryfj7HLTQuj/jMLcCHmlsY2d
         EAFY33+jSH3NSLs4q234DVexWJ0wajZVFLf1aeYDOpcHppIZWN4Vxn4dDVrS5Xf/aPPL
         cHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
        fh=T9ZvtydcC6nfJ+yd2MOJLIodJGr7CBQZy/xhWbxdWco=;
        b=FYSHujgwk4X3eljcA9YhRmUlcXCP11PFf35ON5Av/W/rAwGkS3cFh99SUssrGc+i14
         WBqwhspNccsAAwFW9LvRGXtKof98wnepyBFKgeBbyoLn8xC5vJkxrpcJHiZhAgt6Ry2+
         RtmF9Oy49d+igSjYbVcyEvRYD64APPYORLpPNN20S8xxYQMn3EeoDmbKcbveZk4uJjJT
         V3a4XMjBzQPhFchbUSwZ38lqQanjmhIe98qwdE5Jaaw2VLtykjLwkzu91yXBjj0pnmOc
         /54s34O3PWa2phi6o7GVc1T6Oogoj2aHCgYSNZkzHVvURO0IDopLVFY6OLwpF/YyNDu9
         6ffQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794547869; x=1795152669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
        b=VTU/Umv/XxRmtX3d/XSHHHzSkVNlCjGAiWWmvRpYtATJbDMspOvWRWvSyyqUeqeGeO
         Q8uCINspbjVgU1zSuH+9UnHcqxv8cjRjT4BNbJxmhaQFB8TeexUJIOYqLp4e6zCgNF7n
         GqWGMPJWmhxv2jXRWVtVDAZqa1EhqIWzuIWQ7K3QsEysQ+usM5G4CvZUur47OQUqnPpY
         PP7Up96FsigDTcgDAk4n7JTplwxHbQe689kspsrS0geT7o0ItGIgt0vez+TupVh2sN/m
         e+JFPSRT2SGGBWIOmeouwuXUS1RYlIiX34y+UZSFFdexoH4xWaCTbeVKnfpyGGT5KVCu
         Qs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547869; x=1795152669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w43UbU37I+5iOET4dygwr5SwGRkUmEoClUGG8OTjGgI=;
        b=BAOaRpjhvTlPthDWodF/cUts4kkIpOE9yr8mtGpdcGbV1WLIdfecVODtMCVx0VYQdD
         Ke2hzSjHpbo9TI7Nb68gWHIZ/QQvcyZRj4KauFJ/1CNIkwgPRpA4UYXs3/lR6jgYvEWz
         KITSuN+ULxvnRetSCkqbCOUrmrM5L8pmoZRafFmgH6OJL4EahNcJ3BKPL986AvwdFkTb
         8Kc+4BGIc6GcA8ntJ24SHKcuVpIBfKV7RIEF8wYbTQ/OHhobm5Gbl62Xh55v1eB+OuQn
         bKQgNp41p0vZtisGsw304BhywjXrGRE1/cZayPt6ViKlK7zC/VAgmMhRZEXiDuM+C1fN
         RFhg==
X-Forwarded-Encrypted: i=1; AL+hErEr/pfxVIKw8993EFECfybbkH3uBGS/UgHUcqMn4OaX9xGJbxSDG8bLjP7wgdlC38z6Ji8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BMyes2TruCWgwt8ZMhtDWLKYU2PvYVTmmwFDENdhfZ76gxksC
	lGxmLT9dAy/WO+DndgMS7NxyctcWA02jaB47lGyZ3HZCvVqNwK0vj7f73bvNzVzNxiBx9Pgsxt3
	MIrH2DvVqrhYxuAXXbUqqMIwIsoZt1WwllZhoUlzO
X-Gm-Gg: AYBFou2SmQB/i51tN9nNLfXZhD8d9kXMV2PBJ32+ff4QaCa1fKARcfK2UbDfalW+y4U
	GZrZ+z+bH0ZA2aJRGG7DDYZa4nSxu92HP2Rakiie/hTOyn7wc5ITbH5C7wqu/H7VJLXVREGkewd
	Pg9QpI9ixMjUwxAUQIdH9kUZ02m/siC+Go6YO8Qw62Us/Dk55hnZyhZBMDKMPlkhVaQzgWjr0ts
	QTVvLbndkc5uhS0pSG7pj33Spck6NwyBlZeGuW8hb7Dy/aXSIWgkjDVT/8SCL8MAjwRepgoCwWZ
	HqwRABB+luqKfE58FT+SEdCZXuE4gaiEeCSTRFUMwqhAUiiLbH7D7LBpH3FSeiMLB0GayjcMLQx
	lu0i2JyHaKF2+1NgoYkjZVQE8CkQ4Fd9c1Y8=
X-Received: by 2002:a05:6402:50c:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b7c82ccc67mr31403a12.12.1794547868632; Thu, 12 Nov 2026
 21:31:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-3-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-3-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Nov 2026 21:30:57 -0800
X-Gm-Features: AclHuK8G8jI-cBJtcQSxvGp_Bq701GaxLVhNUpqBJGdSCTN97QaxO6J0E1uIQ_U
Message-ID: <CAHS8izMaAv6gX1NeJR+QCf43CL+DC4DgePRNNxSLoE31jxHU0g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
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
> The core treats every memory provider as unreadable: installing one
> needs header split and no XDP program, and any page pool that allows
> unreadable netmem takes it. An AF_XDP UMEM provider is readable, needs
> XDP, and hands out whole buffers.
>
> Describe providers by MP_CAP_READABLE and MP_CAP_FRAG; devmem and
> io_uring keep their behavior with MP_CAP_FRAG. A page pool takes a
> readable provider only with the new PP_FLAG_MEM_PROVIDER:

Why do we need this? I thought whatever creates the pool actually
shouldn't get to pick whether the pool picks up the memory provider. I
thought if core has configured the rxq for a memory provider then the
pool is forced to take it.
