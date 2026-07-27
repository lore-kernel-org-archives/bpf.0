Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE93B14D9
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191347; cv=none; b=ei42UMCtbtSu/JYXWB35gb9fC1Xt6ZE2/D19Te/1GM1pHUmK6jTbUCkGOMZvokW5rg/bHAI8UQJb11u6KKA0dY/wGNQhIJQTzize+n/fdoX3SqXJ4uJTwu8/O1VHvU9mRtvQvgJubec/5K+LIYqk9gs75sQIMoB5lEjd0Sh80xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191347; c=relaxed/simple;
	bh=c4wSGmQbf5tcw9iM1+QHT3BomJNfyCMt4gl9c5xQm0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwJVwSfvedBxUsGLyDFECPCposxpRX0vfycuTGv3nWDegA1M03KyIK5k5zTQRw26Cc49wG7dTwxnIXS6TOzjOTXQtakq07iuCJGrHbfI1xiO8TMV1OkH2CsWStdeExIvgVDLxD7bXFjzcnDnGd59/yTTibi7UUX8nEbqoiQeNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1hrpQ7r; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1hrpQ7r"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceab75934dso40742655ad.2
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785191345; x=1785796145; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hejzklh+Iaa81aHWLa0mm+DQVlzcyJbzBFSLKDcyWRo=;
        b=s1hrpQ7rokyZJGMLthMMOh6t6l0nm6QLDQO/tSSTj43MLU/xZezRGjgMeg9TrWvgkD
         XmoLVG66MabRA2CDHAjTmmjRO1AImyCigvtstEzZ5Fdw5UIplJrhiTjUkhLtGH7PVXpB
         kMNbtu+T30dXXkrflVMlOpBD3SPUhD2StpxN89tnXqrhdAk214thBLyubOBHeGhEawOw
         iVnqghDW0Z0eOY/qb+IRO5pfL5PieUwleN6tUpFOq9OeruCAFsT3X5pwBm+kJxiO1Acm
         Ez/oxfj3ZM3O5kXmU1tou9jT6/xxLwbNpxLUqDQIDWajbw+0jy0Rb5aDvv1UQy7Q/tUS
         A4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785191345; x=1785796145;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hejzklh+Iaa81aHWLa0mm+DQVlzcyJbzBFSLKDcyWRo=;
        b=YdjUW0MfWnQXYVT5DaBS+Ye8ldQXcgQu8gaT2fTnAn/toWjsEkhzf2Weu10XpyFz/X
         Wu9iWkLASt5sitxIBGiWD1lxMVItvQBCKfDA9Z5lbIKjOBA5yHzcM34vYmQ/ze1CPK3U
         SPqdW0/YgPWWjBnbxHVJBhFmRXhtbVi/9jH/yUPrKsMcOrAFRUGOsH3yt9o/o5ayzcUf
         duwejRkiurgWnaCv/VHfX3mjbFHisvEQ86s+LSQS7fw3Y3tpkBjuvVTHGX6MfMtUNYhD
         pqEY8W4An4D7vCSP/MvJJUKxKdYl7VBjFqC02ztqkDsfzH7ZT89kQSTpUy4CFhJEdOJo
         91gw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5cJHj41rbGFzf2vkFYa451HecIAChhHNMEg05MxGhW4Mt4QkJMibhKVO5vIRLgwCTIVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZ3nbI2iR/0lJNhvVgC+Plg3stzWK/1ISafglhhraXEXXQOx8
	F/jUSoxnTbHMLcb4akSGqXs4s4/bJzOlkhU5wEZlffLuoSBQNc2xZ2LV
X-Gm-Gg: AR+sD139+u1W1KYxpxSUXJT2w/5i8qeeFJC+w2k9M3RGo2DoYYwBUuM5uSYE7VGr6F6
	dWQlMgnb9S4R8bWaQ4XDQHuRgEkiUjRPS8DwfRrTinAkVMFh+zetD8cDk8Jv7ftgyQhC3kEV3jL
	NEtPvI1MSndrZdRQBi2zakoiLooO8fBQ/bKTmvqX8SA8ujLLzMSn/MvsqdZMs9hYFBoVPTOOfaH
	1XYN/57WXBuU/i1YjysLSd/gnEWmrHq/ZnESFlPLIagklXrRoED4tR0k8gudgczR4NqFSyUoQ/f
	6Rrb0nv51Br23V8NW3JGvlkyon7zEgpLku3xZBa+quAMKD6NiRO/VcUmoOOU5ERDSHtsJ1ThGEp
	Xv3+zivaEv2aXugim/T2joJY6oc4uAHFAO3R4eV/rxSLY0a9c/8fzeWGjLYajiF9XdPBbbYjkl/
	ajCR90uhcuvezYGTPRcA3lTV95u9yAwMpVWwL1FsfO
X-Received: by 2002:a17:902:ebca:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2cfde88a001mr100003495ad.38.1785191345365;
        Mon, 27 Jul 2026 15:29:05 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc57asm41466485ad.45.2026.07.27.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:29:04 -0700 (PDT)
Message-ID: <e792057b4f2f8a64aab844ff391c381924933546.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 08/18] bpf: Express ARG_CONST_SIZE_OR_ZERO
 as ARG_CONST_SIZE | SCALAR_MAYBE_ZERO
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 15:29:01 -0700
In-Reply-To: <20260724190813.1458271-9-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-9-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> Add SCALAR_MAYBE_ZERO as an alias of PTR_MAYBE_NULL for scalar size
> arguments, and define ARG_CONST_SIZE_OR_ZERO as ARG_CONST_SIZE |
> SCALAR_MAYBE_ZERO instead of a distinct base type. This lets
> check_func_arg() handle both with a single ARG_CONST_SIZE case, and the
> redundant compatible_reg_types[] entry is dropped.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
> =C2=A0include/linux/bpf.h=C2=A0=C2=A0 |=C2=A0 4 +++-
> =C2=A0kernel/bpf/verifier.c | 12 ++----------
> =C2=A02 files changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e066f44a9c05..1d537ec557ec 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -748,6 +748,7 @@ extern const struct bpf_map_ops bpf_map_offload_ops;
> =C2=A0enum bpf_type_flag {
> =C2=A0	/* PTR may be NULL. */
> =C2=A0	PTR_MAYBE_NULL		=3D BIT(0 + BPF_BASE_TYPE_BITS),
> +	SCALAR_MAYBE_ZERO	=3D PTR_MAYBE_NULL,

I'd suggest to avoid adding aliases, this might be error-prone moving
forward. Is this change crucial for the entire kfunc/helper merge?
Does not seem to win much on it's own.

...
