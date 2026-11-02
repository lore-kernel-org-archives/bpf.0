Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641902;
	b=auADcKLZxFazCvp4VALKjvNXR8etIP+eCKlWjjSNL2H+G30yrQnTdHS7earUAqNqx7Iy
	 cGEY2AHFfE726B+c1QEL09Rf4/pUv+LizxrMyHAjXBnJg9XTmew8np7Yhl09fB4BHDpQG
	 sD4y44SGzK6PJGK/Cb0LknHCK9sjW7pjlFCQMiGnjFVP91VYhrR6qfcfg4eTOw5+TaxmG
	 fyjfHOWs7rdSKpZEAZzFl4RHED0hDokobKTQ6jKat05QjkvBe9V5fSuNPbPjWuTwUBHfX
	 fcQJCopuFli4tOb+Y2sIhrJcAvI1ulcIweljuL7vnkBNBAvnA24l3kwQlC85ZHwxi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1UTj7D8U8+hxOmWus5onNXedkTK0UKM+sEpe8PoDcXs=;
	b=PpLwFBDlvk7R9Ds4aVmtd9BEkRd2XGrEtF6N5tUsi9tF0FF/wyd+sac2XiF1I9sTpswP
	 6fiVH7C6MocCdlxhPwHFpDDogeBVEXbQU8RTpD9la6v9nfx6W3MGAlwDm6kmYDBh+gUD8
	 HpmX+y8+zuVolCSMwzjBIO3FOJ+zF5/es57Lzbk8muiwBeGXnTA6NxQyl7th1krWRUNl1
	 PRSPDTzDL9Gh8NQUFIdwC/gCP7g3EBIDcAUGRWLbqJHF1GmDfwfbUWBDWLW4u6L0TGt35
	 RAd2sQacq8DEm+G8hMCKVYDNCdXznPV9HG/BVvc9/NXG9SUZiWuBFYUF2OS5jkpxsXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hqPVBVye;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AA606AEB3
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F1AA606AEB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hqPVBVye
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so20381715e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793641899; x=1794246699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1UTj7D8U8+hxOmWus5onNXedkTK0UKM+sEpe8PoDcXs=;
        b=hqPVBVyeqcglbHKcEb1sJBqvh+MKf32nBKhsUOi9Ua7qjPAX3tJ+tqADzcPut8FFh8
         X1bRUoD+eEFrQKl/X43FairBw7U5XO20F0BsPJrkaYsSxVeJfnj51Ow6UukY45G/eFCf
         Zt1uFXpkhil08pRRWUYwEwxGwG7amPjPiCER02O7aQl+MYZwdAgkGtzt96CFrcJXvBpk
         uuAiPjyszHDhp61/j6LeQcEAW/EQpqQamJdq/whie/RoAkbodBT83fBAqDPg6S5+Vnih
         VWdF0b2uukGg3hH2GspRDeXPSgdJvVnQVyBvykfGj05b3OjgutR2M1wvBYnoaWm6E2D4
         Aliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641899; x=1794246699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UTj7D8U8+hxOmWus5onNXedkTK0UKM+sEpe8PoDcXs=;
        b=VfAcfXMzuomIiM+nOdaJPnqJdboxqltOIpHpQYgYt755OKYu/DeEqWbABrRV0r3Bjo
         wJEAIEGZEVeLPzYlUvFTwnIu2MRndTBg8kAi8LyDgQEm7/m+lcneMRIvR4FvS0abypW7
         dMsiUc4Yp+6d9i/7FFiDhpn958KedKr6JK0aBa/VYT4nXXliLhgfrllU6B9rLAewaYuq
         Nc7YXTcGYqe9/eZZCX6GdhkhSW6b68Ds/boVG8TtzRYqf9hVG1LUQ/cjZ3HH+NAi6hXU
         u0P8b4/ZQdh4IFnj6tBQulDMAuMRqTxF5GgW821MEWqYFvk0f5HsPKlqifjP7L8cQ+if
         Mz4g==
X-Forwarded-Encrypted: i=1; AKwUvBzx0Yupv353nhqJG41BLSvfxAsVmnyQ8WgzBTEHOk5tttoV34l1ZEj5HHJxgUASwxuFdDM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVeg3WYGk6NOqp2otXsRKNmpITVRktDY4Cmu4dmAI0PWr0+giq
	CVJiPWvoUaUe+y0vA9ck+JkGDMSgrMdtcZQykFSQLdXolgv1DdmyQIhDUgkX3I6ZYB4=
X-Gm-Gg: AYBFou2yBqfcoXgGcnamjUYG6b9WLBmFIHcGmtxPrrqZ0fze7wV3hJJmDJEHPpd3X/i
	WO3NQQbVpVm3yaGEHJdAdQCNWsFaSzlGQBt6WKXuAiTjoKGs/SoNpRP5T6gdF/9BBvfCybyawOE
	a+p1MxJwHYhVYZoJjrzcemn2KcbbSAbPirTQGDRGUMREcwXdP+ijMldhKYT6iCMxHAUVk1zETqq
	jAPbSyriYUDr1idmZzkgJUPYKm1JUtW6sn9OpPJ7YgZWlFWDxXCOlA8el+HG/JhELUTwqNMZ8BF
	lYA7ZgIro6iW/NWZqkvzvajP2N3EGpvcdVSeqQ60omYWhtPBJtLnAOjVOMyi6SsDQsByRnWcGJ5
	TlGZaTL3GoiWmzGBjUtWS8I+97D0BhaanKo/V9RQp0CSeN8veWe2Zzw0qIJjXbRIGfjteiw7vdp
	+4VyMiloQ6p0L/6JcJqjIvsw0q1q+iNtywRqdkYm9rZTZXHSTD6iB/kWXYVj/7cHLe0Lw4LTvXN
	EBRco5FscLEQLwlXjupo6eg0uGQCKjDLtpHx7IibM25MAUVQo7fXjl6gdw1I/ddKDwBWDXbf2vR
	E4b9V0UFzbjDMMNPuZH1+DfQFtEMoW+QdIlPSnOLX4Z0FioMUKo76mI9QGFwhYEtwc7Rr3jCdL5
	kBtDDscyANRgbIUQ=
X-Received: by 2002:a05:600c:1c0f:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4ac19233381mr245619445e9.26.1793641899045;
        Mon, 02 Nov 2026 09:51:39 -0800 (PST)
Received: from localhost (p200300f65f19a904293c83a06545501e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:293c:83a0:6545:501e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e71b9eaeesm21154811f8f.49.2026.11.02.09.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:51:38 -0800 (PST)
Date: Mon, 2 Nov 2026 18:51:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Use "new" URL to show if net-next is open
Message-ID: <aujNf7TVDcwMYeLC@monoceros>
References: <20261102111509.357269-2-u.kleine-koenig@baylibre.com>
 <DMKVOUX2GDZN.2Y8MKLR367NU8@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rzmmr7d67z34n3v7"
Content-Disposition: inline
In-Reply-To: <DMKVOUX2GDZN.2Y8MKLR367NU8@gmail.com>


--rzmmr7d67z34n3v7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH bpf-next] bpf: Use "new" URL to show if net-next is open
MIME-Version: 1.0

Hello,

On Mon, Nov 02, 2026 at 04:50:37PM +0000, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 03:15 AM Uwe Kleine-K=F6nig <u.kleine-koenig@bayl=
ibre.com> wrote:
> >  For non-subscribers to kernel mailing lists, there is also a status
> >  page run by David S. Miller on net-next that provides guidance:
> >
> > -  http://vger.kernel.org/~davem/net-next.html
> > +  https://netdev.bots.linux.dev/net-next.html
>=20
> The link is not the only stale part. The whole paragraph is wrong.
> We apply patches during the merge window too.
>=20
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_d=
evel_QA.rst
> index 4729efd..f6b9533 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -231,19 +231,9 @@ load or urgency.
>=20
>  Q: Are patches applied to bpf-next when the merge window is open?
>  -----------------------------------------------------------------
> -A: For the time when the merge window is open, bpf-next will not be
> -processed. This is roughly analogous to net-next patch processing,
> -so feel free to read up on the netdev docs at
> -Documentation/process/maintainer-netdev.rst about further details.
> -
> -During those two weeks of merge window, we might ask you to resend
> -your patch series once bpf-next is open again. Once Linus released
> -a ``v*-rc1`` after the merge window, we continue processing of bpf-next.
> -
> -For non-subscribers to kernel mailing lists, there is also a status
> -page run by David S. Miller on net-next that provides guidance:
> -
> -  http://vger.kernel.org/~davem/net-next.html
> +A: Yes.

Even better. Do you care to get this change in then?

Best regards
Uwe

--rzmmr7d67z34n3v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrozaYACgkQj4D7WH0S
/k7W1wf+JQLcRbGrPXFvyGP1EZsRgK9324kSWU2Dh/RKoKN9FOlcL96jqZziPjF5
syGXM8YlngzCcmImpq+2qARXjs7pO3Jrh7omKGHQEo2yjxC2XnMNpGK9fdz3i6zC
BfE8234a0mFNL3SUDwGeDxTCxmbJ1C8xiT78fbxe7fp0jwPjX2dFt0f/FRSOeeoR
uOQLavO+AKRpxiTiG2wuXjkDN/sx55ZKJTOncUWSgORfWcrFpim8R1EShjodADRN
R9vcG/RSZjmwHpFYgmtsqP9w2c+3yG/RiKfRpiX08sxOwpDxfl4NybXQE4dVg82F
B9VXlziJD8NyUXDQ5aM2FPOSQZY2bQ==
=EFpF
-----END PGP SIGNATURE-----

--rzmmr7d67z34n3v7--
