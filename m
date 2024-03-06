Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB86E3E48E
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730451; cv=none; b=arq0Ri7gs1kEjwnzdK8iDVoy5Fbz6oQBsakURg88Bg3lxinPVx5u5AstO5DxvoQIA97AgqGX8VhFitUJW5TrujLYJYygGBgbT+n0UIQ3rlJlHJ0zNY00TE6TxNqpIUNiZiI/zN/peqW6ZjAgk+0mVl6UkNCnvhxTRH+jtw4Tq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730451; c=relaxed/simple;
	bh=3jug2md0K7m6mkUo0SQ+JduBXmxHYamY2ypjqkjgEbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ck1hAtXj1DBlyHlTTSeXCYWPl6yqAW94bg8gu4JETGVyX7800DfiYl6gkhQU8qCzRJaUyhuKBWNMok3xGFsyA1+nNuIdU9IUT/lPN37iftl7wJeWZikp74nD7YEbKii90LgQ/wy/Gsj0M8oyetvorpCEqohb53Eri01eGUV5mfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNd4nVZJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNd4nVZJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a293f2280c7so138327466b.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 05:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730448; x=1710335248; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3jug2md0K7m6mkUo0SQ+JduBXmxHYamY2ypjqkjgEbs=;
        b=UNd4nVZJSYGBfFRW0U0xxL9MNB6fy/tizcBp2l7YqiNDHnUcncwERL8qslV/S4wsEL
         z5rZMeUxLIcKfe/n0SWCSS7pQTbJJdkL4YguVN/4sEJ0ecekqb69gTMOLfa4j/AU+9Iq
         u52kBI1ku6HnuQth4uthtQGlzqPdYVs7b+qFmEOu2LH3oXolWfUsEvj9hrEymvOGCMU9
         1wn5z6xNb9pHEIgWCZL3FRkg8t9T+U3miDB3FMBuygyFXUi4y8IDK5A6qENjQr13akCI
         LGvoT9drGALLvETz5IeMcKeWERNyeUkflI/h5t4OHdM3A6OMtkvgfdmYWjHFxpz1oKbn
         A72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730448; x=1710335248;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jug2md0K7m6mkUo0SQ+JduBXmxHYamY2ypjqkjgEbs=;
        b=puN48OS3xRyzvi9+tw9E7xhbhAbjMITAvW94mCGPbGP+GjCfo/k1krEnyAcpcJZ6MS
         Gr79F8FbsAZ13X5uWG8ma477xyCWJ6lXIpbZICEl1/LABzldFIypyooRopy94lTC40Eo
         6VKs0n8XfItJabtOXzwzdp6q5DYZGQjzvrQkBE0UYTkG6svhNbOPdeZSgqltu6V7L7u0
         OgGEy4wTEXvplMnkEEtt+KbUCT9+/xuD691j+7keOQfjUVHXI/ltlVbYuNJ181BQesYO
         rTzCp7TvevLP++8BKoTQ6n4aPDvphEoH/+k9XOC0KvrLVqBVOMzUTYo79zn6mLwklDS1
         ze7g==
X-Forwarded-Encrypted: i=1; AJvYcCV8MqhqgBDPbvdnSiBpu4PtuXC+3HUui+RNqtnLy4eJhl/K8rpug64+hyiAcDlDPrbXHq4weQ/wDnSJ/KK/5Hy8mYb9
X-Gm-Message-State: AOJu0Yw3KDdZeMlhRnsDNh3UfdFwk1aLwiRNhuzlqw5U20c2Q5fd3ykX
	m2i7JIW7ZmYLJ4ZvkfnKKiBSF6PBhSu2jWZi0irF8rHwYPpN3EWPn/ClOg0e
X-Google-Smtp-Source: AGHT+IE5wElHEyLKsG/BaRPgVVOD5EPHshndgDXJKaf/QqQvOdfGLWzYV25jQoE6EVDn4DQ90c8Wrw==
X-Received: by 2002:a17:906:37d6:b0:a45:b1fc:52d with SMTP id o22-20020a17090637d600b00a45b1fc052dmr2109576ejc.76.1709730447797;
        Wed, 06 Mar 2024 05:07:27 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b00a44b91ae6d4sm5460896ejb.33.2024.03.06.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:07:27 -0800 (PST)
Message-ID: <ac4aa0863b5dc80d20ce91584bcd351b4d6b3bdc.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/4] bpf: Recognize that two registers are
 safe when their ranges match
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, john.fastabend@gmail.com, kernel-team@fb.com
Date: Wed, 06 Mar 2024 15:07:25 +0200
In-Reply-To: <20240306031929.42666-3-alexei.starovoitov@gmail.com>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
	 <20240306031929.42666-3-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 19:19 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> When open code iterators, bpf_loop or may_goto are used the following two
> states are equivalent and safe to prune the search:
>=20
> cur state: fp-8_w=3Dscalar(id=3D3,smin=3Dumin=3Dsmin32=3Dumin32=3D2,smax=
=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> old state: fp-8_rw=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=
=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
>=20
> In other words "exact" state match should ignore liveness and precision
> marks, since open coded iterator logic didn't complete their propagation,
> reg_old->type =3D=3D NOT_INIT && reg_cur->type !=3D NOT_INIT is also not =
safe to
> prune while looping, but range_within logic that applies to scalars,
> ptr_to_mem, map_value, pkt_ptr is safe to rely on.
>=20
> Avoid doing such comparison when regular infinite loop detection logic is
> used, otherwise bounded loop logic will declare such "infinite loop" as
> false positive. Such example is in progs/verifier_loops1.c
> not_an_inifinite_loop().
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
