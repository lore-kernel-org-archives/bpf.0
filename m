Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8577A14C
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579643; cv=none; b=hrWshKHLXAu7CWTo8zUaPi0i3eTkkTI9Dxe96uMYXdCDxmjn3V76TFA789v7J3jdG4K5ocyZi84Pg46JsIMa9VSIbHwR0RP89HSTQLEMatF+gyLc9KCrkA8Nlr/l6nB9L0Zbi8FypiFq4xbhM7wIfmqEJfk5Y0//DJeCQFg/GC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579643; c=relaxed/simple;
	bh=MvWYbn1hxYDu/ArBrtX1Wbf3f6CKbYVg32cZa3KxdXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVj2r1y3nX9SCPr+nnkq9WZWwC7/bgTSn1n6ggiUMTN5TtNiLrpE40aQDd+HKAniwzRUBY84Phxd/qRYjK+uLZ5J2UEoTZzicHyLbzXm6X3tpulJTVeTk9O4DJ9XQTJTDc69XllewysfG27iyNUUJE5OFA0LmTTiuXOSzQ2mI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WflxBonu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WflxBonu"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so56634131fa.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 11:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579639; x=1710184439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3q8D5NngQb8FDqtVLu5QI4PwEqHWjTdxbRxQOUurpdk=;
        b=WflxBonuTv2cjK0dCgZJrMXI99tLLW5y4datVwSgLijbpJQMdmKfgimWCE1fxxoYxt
         Ty/EEPshXVjvyGoZyfHxcXWtaqcqtCUScCQn2y4hT3086L6vm2Z8/mjWojZwgPAK75PE
         prYuGywcDFyNkaMTlxTTpZnkrCjvOSZWR2Sek8U8uTja3XISCAWW6RgVn7Zfk+iIEQGv
         BQoN4IT9IBkFYjsonH4Vd3XCoMt3I8ISm5Eb5HW+o91fTCT71/byIEO8CH3DVjI7FAXx
         A0Mxd7M+VMSdTlaMnm6aQxzfjfdZOZ+kEe7v78k18CbXtRSqKaxoH4WNVqXIujw5IoRl
         F6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579639; x=1710184439;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q8D5NngQb8FDqtVLu5QI4PwEqHWjTdxbRxQOUurpdk=;
        b=oUlvBL/sZNNFOpADrXh2Wi6+CKh883d9M8Qkn1NlphZ5uOdIOUYCVb/3PrkpjXvmtX
         S6qFmU0nbbMlEsLwFNObPMkRBghF6upVH6IXTKuJ+97gYKhKQSH1ZtJ8wQHnunho8PaZ
         91cgiwW8I54Rc/wAwpf1mmCIyZptZtIZPLrs55tsDSQzFyEE8KZb4utQfy41t76KdMBi
         2cIGY48f2mkc0RT8glkX2Fw5x9DJhFvAbIk+QeWMSZDC34Y9GPzkvne4B8hauhj/BWZ0
         Nsa5+QLJDeybprP/bspENvsP2H7xv+WnYUdNsCDeSHRoR1MX2DmpnYLkUDojKNrrlm7w
         2GtQ==
X-Gm-Message-State: AOJu0YzgKaPMkNjRhtM4MyL4BCT3L9ki98ERvPAPcuaL3G4BU7DovQSH
	KYIctrI8lSLU2YMJoCV6KSezy0quSxg5qwJznwGX3rejkkPlfVL/4PKEefJj
X-Google-Smtp-Source: AGHT+IG4s/iXOvayYymI2EjvfDDoQ0ISA7FUMRT03pU72TueDO4JBmWuFE9khGbdrKA6UUhX4clEwQ==
X-Received: by 2002:a05:6512:251:b0:512:d877:df6f with SMTP id b17-20020a056512025100b00512d877df6fmr6240175lfo.2.1709579638902;
        Mon, 04 Mar 2024 11:13:58 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170906e94b00b00a455d78be5bsm1208189ejb.9.2024.03.04.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:13:58 -0800 (PST)
Message-ID: <f94bcbe0578569cd645cb018e210cfa8299d2e1e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 08/15] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com, 
	sinquersw@gmail.com
Date: Mon, 04 Mar 2024 21:13:56 +0200
In-Reply-To: <20240302011920.15302-9-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
	 <20240302011920.15302-9-eddyz87@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-02 at 03:19 +0200, Eduard Zingerman wrote:
> Automatically select which struct_ops programs to load depending on
> which struct_ops maps are selected for automatic creation.
> E.g. for the BPF code below:
>=20
>     SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
>     SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }
>=20
>     SEC(".struct_ops.link")
>     struct test_ops___v1 A =3D {
>         .foo =3D (void *)foo
>     };
>=20
>     SEC(".struct_ops.link")
>     struct test_ops___v2 B =3D {
>         .foo =3D (void *)foo,
>         .bar =3D (void *)bar,
>     };
>=20
> And the following libbpf API calls:
>=20
>     bpf_map__set_autocreate(skel->maps.A, true);
>     bpf_map__set_autocreate(skel->maps.B, false);
>=20
> The autoload would be enabled for program 'foo' and disabled for
> program 'bar'.
>=20
> To achieve this:
> - for struct_ops programs referenced from struct_ops maps set autoload
>   property at open() to false;
> - when creating struct_ops maps set autoload property of referenced
>   programs to true.
>=20
> (Note: struct_ops programs not referenced from any map would have
>  their autoload property set to true by default.
>  If attach_btf_id and expected_attach_type properties would not be
>  specified for such programs manually, the load phase would fail).
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

I talked to Andrii today and he asked to move all logic related to
these things to "load" phase. Will post v3 shortly.

[...]
