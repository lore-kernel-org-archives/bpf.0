Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC5368951
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905097; cv=none; b=jtSR1BAsGVYuNgo+g6EVLlres9hmqOZeHcWaMj8kEta14UVQdMk1zUC6TWra9Qft1CZRS+Hq0sr/828yZq0xTpVswcBhUK2jEuBV8qeBaUqPiASrSWJQfcyr9RG9Rq8X44pTuFpXen+7RGv0n29UsUaaJLGGckKjSvgeqoutdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905097; c=relaxed/simple;
	bh=PDKYlk7HuKHwiEwYgFUVdtDrZ6lneCyWxO0pHbY/gZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvc9dPDWyA8Mal3Jhuu6iGZoTEbK1pYJFWDfZWpZzSFEsQF6RaBnNx8QJ0sdT4T9CMv3C/ClWoeStC1jryTGONvJ4suix9lMTCNtqWVIKRbBRWI6feejrTH7ygfsxvbm5YXAqXHsZ5w+8bkBZ8PUdQJE1eymNvfEUIrH9sIdJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo+Zqvfe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo+Zqvfe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b04e6a989eso4446785ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773905095; x=1774509895; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PDKYlk7HuKHwiEwYgFUVdtDrZ6lneCyWxO0pHbY/gZg=;
        b=Xo+ZqvfeKS0FMMJCQ17NcbO411uBfzwZkOXQ9URh65emazpCbqZi7QAv5NIEMPhWTE
         KOdBZvNQhIAHNUTEeTrewhRoisSRC2NfNpdDjBPrFaqWnb5mcqWR23rJ+h57BlQjPKOc
         TzhXQrrlvYwA23WkT+DHDcEr/HzYOxRnyTQnTJDQ4mkeZ0hv4z2PSYKkaady0QzmdsOK
         Yhpnfmo5STsrU5G//uAr5B/MntvlL3sIFfTKEPlPhKynQ9dY5oVbk9+xNKUPKDfRa5JI
         Ni727de1Boa81YC2xxaUea08+Jr0uZSijNCpJeLTI6PW6Q6gu1R+e4A41GL7ebXuLDxc
         p8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773905095; x=1774509895;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDKYlk7HuKHwiEwYgFUVdtDrZ6lneCyWxO0pHbY/gZg=;
        b=DdYzR78I7chv3x69b03UoG41cbx2UE2lonEO1EDDKLzMuReTWRNaqK3PqstBpo81LH
         KzdDeNa/5PSR8cRwxW8d3U6isAa6PzC9K9NrRoqVYCXzdvE3Vhh8OzQ0HAzY3TcFU3/Q
         kJVQAm3IfjHlEkUkO2s7CjXX957JKELeywV2k5K2bVWsN1kzDbdpnJPAp39wU8PwdbF2
         6bw8Ny9vohcHR6taPbu65/oh016PBVAT/eUvVfAO0T46XIm/mq50tDoLyaE+10bhU+WW
         NYqm4jFumNAdS4GJmwYmi4wGkjWcZzYddiQKf5JtHjcYm/pa5M3jGIV4x/KbL3TJD8uq
         vP8g==
X-Forwarded-Encrypted: i=1; AJvYcCVyEX8hYASzXn8+UlmB9FNAAPWyLxXgFNxZEPOEORaEAFwKHkRI6XYiMQ8tfusBCg/9+Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8xQsQjbWVQBo/bIkc/uW+8C/D+6sfz1TCazUQGrU9NLvsYEF
	xR/ueK6IQcjoECXU6wXOub+AsShqfNZPMA8DVxsi+j5aqLSjkuGjYeff
X-Gm-Gg: ATEYQzwS/IEXr5OtSvLoAs1Xooqlm2lHxJEHCrmqE/aHU7GZLcnXZjjeyyo+TiCTOCm
	MnBRRrniZTrlD5gquGKbnat9Y0eKqBTEQMKEQwrz1L0roQI35+GvslFYe2zGeHna4vJyZbncih5
	UPw1vclvatmlGMgsyIbiufwggd/0zIa6n28UgAbquvzxkIxaStyCs01uJ3wCx1kLMcBl6ibNEvc
	X2ePHScDATGFU2/XsAoSCJ/FCzfuMhnuj1/95wB32tHrD2/2yLkXeTiaV63oDeINN5/KVb7qwN1
	FA8+Hyyh2x73kQlAY2ppORf95nnWFoBjQ15lCVLYkfGs4/xQcYvLAf2ODOTtGAViQhcOVgjrfJV
	qjioffvkpVRbtVuNI1XtaWezZbCmoFBlnfyohEi2Kl+R3Sr+VMyYQvICdza27yPQvx0Qi/VYm1+
	EwStKh05Eip2cen/i8BToAEDhRTXIxB0C8djykunBoXpMhw43O8a4=
X-Received: by 2002:a17:903:984:b0:2b0:55cf:5e9c with SMTP id d9443c01a7336-2b06e394ab3mr60315105ad.30.1773905094624;
        Thu, 19 Mar 2026 00:24:54 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e437ed8sm48478105ad.27.2026.03.19.00.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:24:53 -0700 (PDT)
Message-ID: <9a6dd99e31bae75da12eaa18ddc7424534d13621.camel@gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	john.fastabend@gmail.com, martin.lau@linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 19 Mar 2026 00:24:50 -0700
In-Reply-To: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 18:19 +0100, Hao Sun wrote:
> Simplify tnum_step() from a 10-variable algorithm into a straight
> line sequence of bitwise operations.
>=20
> tnum_step(): Given a tnum `(tval, tmask)` where `tval & tmask =3D=3D 0`,
> and a value `z` with `tval =E2=89=A4 z < (tval | tmask)`, find the smalle=
st
> `r > z`, a tnum-satisfying value, i.e., `r & ~tmask =3D=3D tval`.
>=20
> Every tnum-satisfying value has the form tval | s where s is a subset
> of tmask bits (s & ~tmask =3D=3D 0).=C2=A0 Since tval and tmask are disjo=
int:
>=20
> =C2=A0=C2=A0=C2=A0 tval | s=C2=A0 =3D=C2=A0 tval + s
>=20
> Similarly z =3D tval + d where d =3D z - tval, so r > z becomes:
>=20
> =C2=A0=C2=A0=C2=A0 tval + s=C2=A0 >=C2=A0 tval + d
> =C2=A0=C2=A0=C2=A0 s > d
>=20
> The problem reduces to: find the smallest s, a subset of tmask, such
> that s > d.
>=20
> Notice that `s` must be a subset of tmask, the problem now is simplified.
>=20
> The mask bits of `d` form a "counter" that we want to increment by one,
> but the counter has gaps at the fixed-bit positions.=C2=A0 A normal +1 wo=
uld
> stop at the first 0-bit it meets; we need it to skip over fixed-bit
> gaps and land on the next mask bit.
>=20
> Step 1 -- plug the gaps:
>=20
> =C2=A0=C2=A0=C2=A0 d | carry_mask | ~tmask
>=20
> =C2=A0 - ~tmask fills all fixed-bit positions with 1.
> =C2=A0 - carry_mask =3D (1 << fls64(d & ~tmask)) - 1 fills all positions
> =C2=A0=C2=A0=C2=A0 (including mask positions) below the highest non-mask =
bit of d.
>=20
> After this, the only remaining 0s are mask bits above the highest
> non-mask bit of d where d is also 0 -- exactly the positions where
> the carry can validly land.
>=20
> Step 2 -- increment:
>=20
> =C2=A0=C2=A0=C2=A0 (d | carry_mask | ~tmask) + 1
>=20
> Adding 1 flips all trailing 1s to 0 and sets the first 0 to 1.=C2=A0 Sinc=
e
> every gap has been plugged, that first 0 is guaranteed to be a mask bit
> above all non-mask bits of d.
>=20
> Step 3 -- mask:
>=20
> =C2=A0=C2=A0=C2=A0 ((d | carry_mask | ~tmask) + 1) & tmask
>=20
> Strip the scaffolding, keeping only mask bits.=C2=A0 Call the result inc.
>=20
> Step 4 -- result:
>=20
> =C2=A0=C2=A0=C2=A0 tval | inc
>=20
> Reattach the fixed bits.
>=20
> A simple 8-bit example:
> =C2=A0=C2=A0=C2=A0 tmask:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=
=A0 1=C2=A0 0=C2=A0 1=C2=A0 0=C2=A0 1=C2=A0 1=C2=A0 0
> =C2=A0=C2=A0=C2=A0 d:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1=C2=A0 0=C2=A0 1=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 1=C2=A0 0=
=C2=A0=C2=A0=C2=A0=C2=A0 (d =3D 162)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 non-mask=
 1 at bit 5
>=20
> With carry_mask =3D 0b00111111 (smeared from bit 5):
>=20
> =C2=A0=C2=A0=C2=A0 d|carry|~tm=C2=A0=C2=A0 1=C2=A0 0=C2=A0 1=C2=A0 1=C2=
=A0 1=C2=A0 1=C2=A0 1=C2=A0 1
> =C2=A0=C2=A0=C2=A0 + 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1=C2=A0 1=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 0
> =C2=A0=C2=A0=C2=A0 & tmask=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0 1=
=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 0=C2=A0 0
>=20
> The patch passes my local test: test_verifier, test_prog for
> `-t verifier` and `-t reg_bounds`.
>=20
> Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>

I hacked a cbmc test in [1] and the checker says that the new function
performs according to specification (and identically to old function).

[1] https://github.com/eddyz87/tnum-step-verif/blob/master/main.c

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
