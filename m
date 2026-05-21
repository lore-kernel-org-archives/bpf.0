Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8103314D0
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329874; cv=none; b=i5F/jK3C/F8Q+3TzcoeE4kU80BFhfekqMVY6zTMQDYxkXaeSsw6dYoXoVzrqQVmIaocj9EjopkvCGDZkVvuLlN6mPZqPQsKU6AOWJjGLhurVO7TuDyTQZpnpYI9RAL4xwuyoWpFHS8Gn1WWh1PwVzT0zdHOZVFLE3iUO4IzwGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329874; c=relaxed/simple;
	bh=taI5VCFh5Le09HdoEn82d6H1BQkuwnXM12kDTiHef7w=;
	h=Date:To:Message-ID:References:MIME-Version:In-Reply-To:CC:Subject:
	 Content-Type:From; b=XBrmg9LIOrehUNEchn8wedfZEY6Z0THizfMZIU6xSxFMAUk8qFUFduqiu6CbOpc+iMOhO9SIAirXpjNbV/rI5UJpxA5lIIlQ3ax7HPltDSh8uHluRxqGsibHEIU5ERx4K40j2wbaXuxs+hbTH+jpMQP0PO7eOiD+xSmDC5RNfow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=FqhIonwB; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=fQ25jx/i reason="signature verification failed"; dkim=fail (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=e5QV7Z6Q reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FqhIonwB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="fQ25jx/i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="e5QV7Z6Q"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 2FA99F219613
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 19:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1779329866; bh=taI5VCFh5Le09HdoEn82d6H1BQkuwnXM12kDTiHef7w=;
	h=Date:To:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FqhIonwBkMhxU9LDx8vboNj13gJBVWhy9d0MkG3gSxs97fG3Su3SRKT4G9aEUy1Ik
	 4jz1nPvoUNJr2nzNKMYI2zjCT06r1DZhSVoyT/pSVCXyBETuDT6HstHVuJcln93s7F
	 rlaBdagi6Vr7jZ5R6r58V/2bGVuvvUjxlRW6jfi4=
Received: from mail2.ietf.org (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 28F93F219612
 for <bpf@vger.kernel.org>; Wed, 20 May 2026 19:17:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 5D11AF21951C
 for <bpf@mail2.ietf.org>; Wed, 20 May 2026 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1779329860; bh=NsE6nXxHo97VM1sXx6yZreG1nqdIdV6j50wdxtLFBOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fQ25jx/ixXjBmP8I47Ju25s8pErqcokJ+fCa8rR0tNc3mG2jKlGFuwO89i6JMP88f
 UJ17lFSS+16UyOTKtIEj96qjz7WztcXHnn1jU7Y1nxDSAxtrICsmCZMKzRot+W72Vd
 ZryOQbdeE3re6X+URkWs2QM7pT2W4+xS4dYfwypc=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=manifault-com.20251104.gappssmtp.com
Received: from mail2.ietf.org ([166.84.6.31])
 by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v_Hie5ciC6p8 for <bpf@mail2.ietf.org>;
 Wed, 20 May 2026 19:17:39 -0700 (PDT)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail2.ietf.org (Postfix) with ESMTPS id B140FF219514
 for <bpf@ietf.org>; Wed, 20 May 2026 19:17:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso4682472a34.3
 for <bpf@ietf.org>; Wed, 20 May 2026 19:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1779329859;
 x=1779934659; darn=ietf.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cB1qNOTZCCYHy9Z+hs2y+VPCP5OkdeilQfyLp43YV0=;
 b=e5QV7Z6Q8yfVLJv2l8mW8+/CacPT0ARUa6zpTPdXvH79ePaS3gRkUPj1/tEUZC/P8k
 czfkFEM2Ezn8mBrFc1AWfydkfdMHTQQ5KQ0PVGZTTn7Bg8yQ9tTV+BPp1+XIRtVxvGpr
 hR3dY1N6Q4weO1L/0/17+eg/3ANgrc3KmzgO4Yt/N/rIYR85KNB9GPEm3HD/n23kDYMf
 b4Um4WN4q5EwOsFXRoIHA7GJQHiJbu3L3GXQ0q6MVN+ZQ313oCYEjFFgu/H1htd3Nqmi
 MNCTbMxA7wpS+pJSFI40mCG5RomE1NdcYYr5o6FTzT8Zit9eUa5VVNoSLVjmJwzhBcTK
 r/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779329859; x=1779934659;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3cB1qNOTZCCYHy9Z+hs2y+VPCP5OkdeilQfyLp43YV0=;
 b=ZEw7ASrTf8HajOTEhdWpQqi1yQylQ4JvaTgOYD1E34AMH+VJfwQFAoCGVAPUJopoYJ
 Jls3j/efWPKhQGC1q81QZ/BOHM7VQ+BDBe1NPDDZCDL8OGJpouTV9GDiAr0PpVj2ZTgf
 kNh2r0KNgpECR34RCk11XjKEN75aZt71brd09URCuytnVm8ABFpsT3YcJ3lzbZNR7MTx
 hqVv0AJ2c1mkPY709dDt9IETitoqwW0nSmEbx3OW1dJdnLSPrIDbYySPMNgO2+PkVHHU
 fd5D+rOBy43NK5nzvbnpaI96Qz/CPz1IozM4yyebJyJbxLc+CX+W86pROufMoKlQ+ddx
 721Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9c6aC5cOOwFkN79tKuxiL4QFFDukbfQgOO7Ll3pCctkWdRVbBOgDKO/8Wg+PA2OIG8JY0=@ietf.org
X-Gm-Message-State: AOJu0YxEq2Eci/Lkx8Ww4TTjwSx9LqBUhLeFgNTHFA+d/A8dmDa2vF51
 3siQwvor99o+xGVcz6NmRw/GMDqi+7rG+SoxoDEbZ/4YlZb6eGE3H2FKy3DWhEkCMCi/
X-Gm-Gg: Acq92OGd3bvhAbmKtD5RCQySICdLvjPHSdE8SncfioLVetw2zc3oUGMXzQshUAKWqSb
 LOZiyfh0tVQXpCT54/p9LS/wbCFjzcBRwaqufa2qf4Gpa8YeO5LsVbBymOQRyL7jWpLBxUnwUIW
 efFiSQLBPvJeSPK3rkwkPE7N0oANiMHjXjzox0onTIGrNx4H/BbfbZqjr0/wWe9wX5lKgLoeI3j
 vedtoD1mR3v5eUaGu15S/gc5yTqWX5PSBUnsYFk0D8DBF1GYhQZ6YmfQiMOs1n+YUE9ik1HiJXi
 vULLcesO136wy35R5JFl3AFNeEhwot8Q5K7o0n+paPKnLsRZSac2Ch2R/NmW+0FmMSfsIypc6yH
 sZ8vhWvtRwV8YZSQE1+Jucs4Cc6y9eoH8wXEmG6NruAesYfBLqUx/E51LAM8Yd/SMCTm5gtyzd8
 Ix7vlhp0Hj5RDhx699Tei1cadlhOYGdsySbUJToEfdC96YXYWWyvu8aPiXFeE=
X-Received: by 2002:a05:6830:25d0:b0:7dc:d0cc:91b with SMTP id
 46e09a7af769-7e5ec60237amr399495a34.26.1779329859054;
 Wed, 20 May 2026 19:17:39 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net.
 [76.141.129.107]) by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-7e55b81c8a0sm13273517a34.10.2026.05.20.19.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 19:17:38 -0700 (PDT)
Date: Wed, 20 May 2026 21:17:37 -0500
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Message-ID: <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
References: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
User-Agent: NeoMutt/20250510
Message-ID-Hash: UDM3TG6AC6FGRIPPVY43SW2VN3AFTSCR
X-Message-ID-Hash: UDM3TG6AC6FGRIPPVY43SW2VN3AFTSCR
X-MailFrom: void@manifault.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 bpf@ietf.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next_v2=5D_bpf=2C_docs=3A_add_LOAD=5F?=
 =?utf-8?q?ACQUIRE_and_STORE=5FRELEASE_instructions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/d1GUUmfXTM8SN8X2wlO1nTbYtaE>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: multipart/mixed; boundary="===============8706965226719245447=="
X-Original-From: David Vernet <void@manifault.com>
From: David Vernet <void=40manifault.com@dmarc.ietf.org>
Message-ID: <20260521021737.it57fU_OkZ_FTzPXsFRVEZNRusyKJ1XWGECAzIDIUtM@z>


--===============8706965226719245447==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xm7tw5c2mh4x3j5d"
Content-Disposition: inline


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


--===============8706965226719245447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

--===============8706965226719245447==--

