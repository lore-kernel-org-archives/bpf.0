Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2E30C366
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329864; cv=none; b=DBP78705MvJIRrxnF5BTp6KCtwemT2vPIqbS9a57f1m9dP7LRuOLUAXlgGk2fwwPsV6OWSEHQDOq2MI7gugEEBFtQujnhWEIcC/07RaH752+m1n8QoTbr1nItFOPCD0bmWPDr0v3R05xpb20CJ6az/Ga6azHaCwh2c+1QjyPpc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329864; c=relaxed/simple;
	bh=NsE6nXxHo97VM1sXx6yZreG1nqdIdV6j50wdxtLFBOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfL11PlPZFr17ihJgM8yBQUxZ4djzFNTutjeTBGdc60+0y/LmcmTO7dIR9MPunHOh1T6lXi5lpLc+q+alMpgz8yq1aZNXnjLPVKZSEinbuFxnGAj/1FQOQ46yLpYiuAQk7ROkJ3W9MuwEK60UgDtL1aN0uNEF7ME4Cx32mkIWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=fl45xRp8; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="fl45xRp8"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de7dc85b74so5485719a34.2
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1779329859; x=1779934659; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cB1qNOTZCCYHy9Z+hs2y+VPCP5OkdeilQfyLp43YV0=;
        b=fl45xRp8pEjZJ3xf1McdiX7eAq8DWaVG/XBYfG6JDpKLXDbdTw0ucz7ITBRgjHN3gS
         cJKQZvSoj6sGbTBhJrgUj10YZv99vVKowrxgYv44h121XoG/sQXz4HCMAKxrU0bh8LVY
         8Aicdt52Nxl3Til6D2Nz0UdKwqPqxPFvpVyZ4O8cJJu8GOtwdAukB+vfPGVEnYRpwo9S
         a6dFP+iam3tc/SJgmPQ3C4h4aDVPot+BlnJj62QIvoynZd5LTWQCoCCMFD0WlTMCnKED
         8EDWG7eL/EkoZ68bwLa+fbCEzpJniSspr7EfMNR/z27vSxwJ6MESNEBx7xtk8LfKfBEs
         AsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779329859; x=1779934659;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cB1qNOTZCCYHy9Z+hs2y+VPCP5OkdeilQfyLp43YV0=;
        b=Skt3ooBxRaFWohZhOx1hmglMbL/RnWppZ177/dupuF9bGoxOfOaiw3RH7RwZt9FxPs
         hDGVQFoL36GpiWB1rC3PLqmq4fZTf8HZ21vXJHBz9FUqvkdQMXsvjRjJ7unrcmfdMnwL
         BKhIcZXYKD0K832x5+skE1M+QS+G6lc5uEChUpEA6KF1v8ELj/mq54lvSMevsup59UBB
         oRCHfnBnnYUh+FW040KU3H3gYXxQv1k8LquhPHJtmokfogY+5MJH7VttFwULs9h/yOUQ
         t5m5SMVl4bXYMoYu/vhsiRpD7pesixIAexIjiIiGifpHc9fi/c3eProYdzU5tVGr0KO4
         Vu7A==
X-Forwarded-Encrypted: i=1; AFNElJ//JhMbcsc4qYDGMQfANNjIOhnQQ8mmgv9LpQ6iJ6cLgSW/EfB12F1Tgtg9oG+WEDt4Fw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvH0XcmlGbRo6wj/DdriSie6jLs18s9OSVAOJTZE+ym5V1yqcH
	HYnVPPafToJ7fiwlHEqwpcaIhpbRd7tBqUx5VWSGhloeEVseHKdSnNtNiggjz7BD1O3q
X-Gm-Gg: Acq92OG5qE4gSwlQPJpKilK+6HLf401OEipdu0HonRUZLOhgJImustErMxKc6XUeYoA
	CNtTdL5XzJYdIp+lAfX3rkeRrmMPmwT9+OTJM2WbSISMECxZiVmX+oQn8XG8mR3VqveV6g7L4WN
	2cNEFN+gHMBH5aK0e2mk3S6w8EXLWUG3cYgiR8XxmLWkpYdDotwLPSyfm78tP+WW2IkEY727xaa
	4LyB2GiO4FKpO65OKqgdZQgbL8Ss2alx1oEU7Uxj3VpV6wfHRFSPRc5KL3OpEa72mnht42N+TnG
	tqNkXduhTFc1jWrgim6nui3kbwhVb/g/s39Pf2/OpgtI0v28LGHt5p2xvGiKRc1tanoU0q6MYgp
	DF7DlM9AdBZB92ZfCPLTC3SB2YAFCCfDZvv7krz2n3Ouf6X6C8R+rbg7bkFOeLHbxXRcIY0ncFL
	KZrDE8PUSBaBcTnovC23JlvZyxwWfPjjzvpMLtBiWZKsNOF6loRsAYL68jE5s=
X-Received: by 2002:a05:6830:25d0:b0:7dc:d0cc:91b with SMTP id 46e09a7af769-7e5ec60237amr399495a34.26.1779329859054;
        Wed, 20 May 2026 19:17:39 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e55b81c8a0sm13273517a34.10.2026.05.20.19.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:17:38 -0700 (PDT)
Date: Wed, 20 May 2026 21:17:37 -0500
From: David Vernet <void@manifault.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf@vger.kernel.org, bpf@ietf.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
Message-ID: <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
References: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xm7tw5c2mh4x3j5d"
Content-Disposition: inline
In-Reply-To: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
User-Agent: NeoMutt/20250510


--xm7tw5c2mh4x3j5d
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
MIME-Version: 1.0

On Thu, May 21, 2026 at 12:09:11AM +0200, Alexis Lothor=E9 (eBPF Foundation=
) wrote:

Hi Alexis,

Thanks for working on this.

> Commit 880442305a39 ("bpf: Introduce load-acquire and store-release
> instructions") instroduced the LOAD_ACQUIRE and STORE_RELEASE atomic

introduced

> instructions modifiers. Those are currently not described in the
> documentation, despite being used in the verifier and the various JIT
> compilers supporting them.
>=20
> Add the missing entries in the instruction set documentation.
>=20
> Signed-off-by: Alexis Lothor=E9 (eBPF Foundation) <alexis.lothore@bootlin=
=2Ecom>

Alexei et al -- if you plan to do a subsequent RFC, it will influence
how this document needs to be structured. [0] explains the process for
adding new instructions. To quote:

> Once a conformance group is registered with a set of instructions, no
> further instructions can be added to that conformance group. A
> specification should instead create a new conformance group that
> includes the original conformance group, plus any newly added
> instructions. Inclusion of the original conformance group is done via
> the "includes" column of the BPF Instruction Conformance Groups
> registry, and inclusion of newly added instructions is done via the
> "groups" column of the BPF Instruction Set registry.

So you would have to create a new conformance group for these new
atomics -- you can't just add them to the existing one. In general it
might be easier / advised to snapshot this file to RFC 9669 and create a
new one for the new instructions to make it easier to tease this stuff
apart later. If that's something you want, I'm happy to get us started
with a skeleton file. Again, though, that's only necessary if you plan
to submit a new document to the IETF WG.

[0]: https://www.rfc-editor.org/rfc/rfc9669.html#name-adding-instructions

[...]

> +The ``LOAD_ACQ`` and ``STORE_REL`` operations allow using lighter load a=
nd
> +store memory barriers rather than full barriers. The corresponding acces=
ses
> +must be aligned, but are allowed for any access size (8-bit up to 64-bit
> +operations), with 8-bit and 16-bit ``LOAD_ACQ`` loaded values being
> +zero-extended. As atomics are encoded as stores, the meaning of dst and =
src

Nit:

``dst`` and ``src``

``src`` below as well.

Note though that as mentioned above, these instructions should probably
go into a new conformance group that includes the existing atomics.

> +are different for ``LOAD_ACQ``, effectively using src as memory based
> +pointer and dst as destination register for the fetched value.
> +
>  64-bit immediate instructions
>  -----------------------------
> =20
>=20
> ---
> base-commit: ceeb3aa37bff895116944acf4347fcded0b7692d
> change-id: 20260520-bpf-insn-doc-756b369ca328
>=20
> Best regards,
> -- =20
> Alexis Lothor=E9 (eBPF Foundation) <alexis.lothore@bootlin.com>
>=20

--xm7tw5c2mh4x3j5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCag5rQQAKCRBZ5LhpZcTz
ZHoCAQDFWUGw9Hr99Buhk40sk2JijGKk35iz1XODpAk+Wn/yRAD/W9A37/iQvWyx
wtmRJGU7PSSg6gN/rmsCFovizz7KMwI=
=m4px
-----END PGP SIGNATURE-----

--xm7tw5c2mh4x3j5d--
