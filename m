Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739226;
	b=etXEDDlyzw8NtGvgBZkrbe8cdHWvoT4h3LSn9PTreu8nnOMBIvFsR2YjhiTeJAKoy+4k
	 Z/CPhbBIaQ0vLmcMbAQkYxlwzUvHATc4NqdHWygQ7TPKne3eBt8T8Ob4LxEr/LNNBbJ/d
	 U4YUvUpmuR6b+rQq0BgpYdko2ZXRVRjMZEYM3rw5NaXOSz/NRXz71WWrcSmeKtjUpF/41
	 QId26MtQXoIk0S5untQ7b62aqE0k//5lI+ZtjNbkx7kxGg7a8HVm8tRzmOjPrqRwV5ktW
	 Mr6VGeoixWoOpv1qY48Cmaeld5OArL/vCXosgWuLjImrTuQzSoAk87O20c6FwjjAAWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
	b=F7fNaPhIhCsDoPw6sA/wUCxYpT/zfHfMO4pTkND5XG6qCu7aoreVA9bqBenAgUa7ejJe
	 exhrWV+QthPwozQodDDlxaiGWl70HHj8TPLfzA0XDTDLz7ay1zFcFdduKs7Xa/TyPG9tP
	 E9nNczDbDh7kczO7gB07VNE/LqI8iHvlqYO5u/C6fc0TrcuhGIrJl4pgoTZZOknZniTaW
	 ZdYb44xvi4NQcFzevtwjsr7OSAqbDCcYg449JFXnqUJQYPT4rTqiVfSZ1D3NeIgX84Gs8
	 IBwUE28AN1XlYvQyf0YM99Zef5xg+pIQqahG0fkaOP9HS87Ehni+tqCHf4xIialBg2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=auyMeNme;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292E606A32D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 20:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9292E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=auyMeNme
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a77761ff8aso53941fac.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 12:53:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739224; cv=none;
        d=google.com; s=arc-20260327;
        b=mCwrn66GCGmKiJj8oScJr0hviyr9+i/7y/yXO1btUYGpZjDHpe0OubOH4vvXKUwQVa
         vFbXZtzC9o3f1D6Ikpej3LLE8IlRs+mA7lxjxQ5Ftxe1864EYhchSenX3pgQjZluay41
         qBgfIx/s3MT0OIsVIDfhoZqLGuG6/21uvUE/2J+1M0C3nIBpOmcKfbbxgPYSkXIW+0GV
         nHZEpVA1D1LMbVYhbFtikLGD7v9fnxXkh9p4WjAJV4oplDzIjMvgSFRIfCZxI3tQrx/m
         s9vC4E46TllrXbf44GMfxNcrmyx2CkCFLjaLoPQC+oKwhywrrsDLf1JI78hjBsWPVQky
         g3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
        fh=7FLR4yRO5k2Mrl7YBLHJ0f7y10zdoSZNxBbremWxsGI=;
        b=f+yvF7H1G/yxk6nvRddMujxLe6C1PiVTglLi660mUobYKgajokFSNfPV0v5X7dEw/H
         eadJHVkyakkveqTlOmQMF+CryUkmHxvt9Rz5zt/Zz/HlUYmmdx7U3ZE/o/UjFwSt+OF0
         hwCh8DanJWwHNSyFSkNkwT0zjJIr8yOcmF/rEkYQ+rxaV1V0JUzezUK2jpfeVsbHuwGk
         XON2YlPVxCvGPBnQIKUh0Ly6P5RHyDdFAenF+75+andnDL3E09xlswZmq2DXN3lZ2+rm
         /aM48RMGLceBBKZtKeBxk68RRVKdmg5ywXmyPKKyPQ5wzKW4O6NwetpOr7UaRLsGeunc
         PUow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793739224; x=1794344024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
        b=auyMeNme4/2d01zzCWqyBDt/BzGNmz1TB0h3Ud+kIp+iV12/l8l+8oSCKuUj676PVq
         aBVugEhproylVMbxZ7jqq9EoEq0DaylN3bZe83HxC63yinS4CVEx+Fl497C9Hk9Feu5V
         X7YX0LQsolMtep+IVhOVyBefbxcZQDq3tAga2gRse5wioCQHAteEB2xjOC0Swqmbbq1u
         7vakZI0vFXnqKTQHHcfgr9Khsq03VzDmMwUASgXd2/k1nJSUEAGbYp4ac+KsSb6xsEvo
         GL46Z3ltFuZJbQj7hXahyilz5WzR2KwydmZJHQnpDiPtwSX1ANt31TnNEbJVh3nSc95B
         +ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739224; x=1794344024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HU0IDlTEWZ/Nq80LY/Y8bonUl8UVtmzIsUjZigKckck=;
        b=lpHSFz9rtquMavqkjwnaLvuE7Yge6rIXMjta2ZfXaek607rrgeC55M9Br81NVME31F
         FWJe4VXUFuK9ao9n78OTvoevjyWPRwuKGVoMleAQjeT336nWlx7M20DD66TnD/maflPe
         lrKeXfNhdPBOhwVmRQeZScEpzSaneKCVGUqPQ+MUSVGN+U2wcoroSozeV1wiR6LHlXF0
         Jmw2FqeiTmRidCIYYiTa8raKPI91tUcEDRXPa2dT582abym9N+QQY6BxKJtoJGZaix74
         ySeBtxrs8JqHiFt6TtDbY0Nfngg94rJU+mS3O1manIkbBYXEmBUrUvO50pqXcuJEOp7c
         kpOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQBflv6MmT6WrXVpApTDOwKar9yTZawR5r0b45Baa3ICVp8eaLXxDGH9Gy8szRzVop2Rw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oIaMcB5VutFQ4luePTem8z4uiDHNnBZribmYckYveqN+4qoBY
	XdVU0Y3L7kuD7/34SMfg6EtXsP0wk8nU0TaaLUFO2WdmZy34N2ucpwbyPSCKDC2QTkNVAM1X6v8
	l1hkG5IfWGz3EWW6yIQ6Xn/IzEf6gORRMo7FePbjJXw==
X-Gm-Gg: AYBFou2lMtY8O9SYsBL5Tc148641k6vJgAPY0byMUDxcUyDSHR1k06KUbQ4qXL3Ljy1
	8ctHxmblnI2eNY1I7Msofrdj6WmNuRuGONQMkVaYWnHTpSDtfNVuedDZ8qRqQi1+1Repyu117NY
	DxItEvsqT2aLdiO8C8rK7NcVLsYG4oynaqNPFjLxySsnevLpEJ79USowU3i32KHYDGeG2jzjrMY
	Kg6Boi3jRjLhhV1760N+mGUsYn2xr/j/h3ywcLdFiYY+N9oLz1sGTwK4779K5VTltLd1XSAzdyn
	Ol7cG7bgZUVJSIbf2kFOqx7W2VN3ZJLDu1svvXI/D0BuWNpH64/I0tY9tD+Hfa+NPherrcWqtHH
	gUO9fcPtazxB6IQjqLXgOcvLiLCKpxsyqMkVfTHTpScFQ00LBpZ9u5x5JfRPlh1D7r0YXssrh/W
	sf/kndO8O2JZPL3fKgPFUS2R0tfW80kwc=
X-Received: by 2002:a05:6870:208:b0:497:4b0a:61f5 with SMTP id
 586e51a60fabf-4a90777511dmr8964664fac.43.1793739224442; Tue, 03 Nov 2026
 12:53:44 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103200036.65764-2-tianyi@cloudflare.com> <179373626776.488859.10701424242617832815@kernel.org>
In-Reply-To: <179373626776.488859.10701424242617832815@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 3 Nov 2026 20:53:33 +0000
X-Gm-Features: AclHuK_asYprUqDKWj4NTjMpDW40oUsEV9HAiqmCbg-4s8sP4_dIHmt3NG3pWyI
Message-ID: <CAG4wq-c32sQ2NiFj=9XVXuc5Eqa+5zHvTKcGRQ3ugAdXWnE9sQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net: fix mac_len of skbs copied by generic XDP
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I hit this while benchmarking generic XDP with an xdp.frags program
that redirects to a cpumap. TCP throughput dropped to almost zero.

Cheers,
Tianyi

On Tue, Nov 3, 2026 at 8:04=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.



--=20
Cheers,
Tianyi
