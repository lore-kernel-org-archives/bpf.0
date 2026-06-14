Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA61B4257
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781427288; cv=none; b=DLiIbm4w/Rafps7hPzAANEFp3opp+YyECou8axt5fnmxb1JEN672tFwJXX4AJuua0cmyMg0hVRqIHtw01O80tcHmWb+s/jyXQdqhJwWN6w5wHnKAGVHiAiCmCTpmZH0z5vtItaSvUGQMBK0hNejgf4JXxqx5oiAwZKnDM/8Sru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781427288; c=relaxed/simple;
	bh=oUeBDppd5KKTWCuDXqTzB0gVgPprODkKC1DKhm5FaUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhbu/QHFWnW0++95kYNiajgILh7ZjMUuRvKWZJ/1Vr6ZJqN9zQ67aAgHoHjVDyHYZZVPA47sTY7tmMX80QK/epZvhK25tW2j5jyC9no+H7IbKZgvqROcS3t+JWutwmIZsPTl01pKpTaE1QWRWJTOz9sU9roipaqoxLxpZh+n/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewv+U0JD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewv+U0JD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso1412944a91.0
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781427287; x=1782032087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q/uewEH1cW868+5OD8sXa+r6MPnZtf7AGJ1D3ihIG0E=;
        b=ewv+U0JDkahfMKly8oRBWMtGXCOtoQotme76XGvLumFmOe+arLTm6J0e6R4PN16AnS
         JXz+VQV/K/ptF1d3tPtvGkmyh087YURwZ2PfAOaSxoGKSZbxRHb0buvyPd1jhaKuHgBc
         DZaqQxnK4wzXS2kQMjhPGjTLRnPqRnDrEn6CgQqYjLSMhY8bhGztNZnT5bNUuNgKNUfj
         x5b4kpIarlcVZvwGBWRZu3jH0cDN2+rCzG6ZouePZZ2wVcAdpyxbdLU9zLOSWJ1ffLGy
         KQ7g4DV0aG7zMrcDPVZbur6hhoQCe6bjLeL8LMX3/UiwIEtHabXIsgmoknLITpO1lUmn
         CNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781427287; x=1782032087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/uewEH1cW868+5OD8sXa+r6MPnZtf7AGJ1D3ihIG0E=;
        b=Pdt9gCYdcvE/G56YpxfyXXECMe/1A41VHVQWX5lfHHLLhXChOuvduFbjYrvwj54IcT
         LmUjt7XGusjxpiXDB+gqiCkMT/haHbEHeonCRnzWS+QCQvFC+2aLXw4ex4ktIwWkRyW4
         0QAXGh3MW/QYJEp7NRFaPSZ/BgG9DLXBesBGfcH3xlyYcGJ/qfwQkswds224Qv6TCkXz
         BLvojEOa4/k8rkfwy+mjpegbD2o6CuLGORLRSv1yovDzg2X+5IaG+q4keqIc9Ekiwm+n
         hpkUt8PVNGoM0urN1ZYlqvUbEjgIJjizqNxuTR3Yay7uXqupx2HTqd/7+53OWbVOCCSD
         g3zw==
X-Forwarded-Encrypted: i=1; AFNElJ+jKO7BoYBB4n2QWhzhCiokHfUvm8gK1X6zB7eJawCeGYYyO4CuG2uNYPWf5+okkMu+5Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47DW4fZUVLaEApGoAoWW9lsFUun1wwdvBViioG1jsXY6rz0hg
	29bIeTS3+9FjHoic6uXhuA/trD73DRlAjul8FpL66UUxBI4hg4cDBf+u
X-Gm-Gg: Acq92OEWFPU0DtLILc51nWYLjQdF6CAoX5V6RLt/zwSdOJPfsPmGKm9YY2vkvevT6hB
	dzjSqFe6vlnyJ18mZeMtbSP7IrsFmLDJ4S3XNiZ9vwLY0gqE4v9hVzFT9OaRU7AGmE7jdfMZW6F
	TW180+zqHi5vOlHe+e8oJcQmeauYfzFRzpzqVSOlx3X7uBweOhV/suwi9Y+BYetsEWDIiNEuSBt
	GOWZ7IkyxXNXtewAHv8vsb9/L02Yd660CsVa25xquI3GL9TmrmSbFRZiVhlGGL6zfScGWrOqnCR
	JRWumsDYrlflEYkEVRI3l0olvf76YtfGXs/dlWZ0WCZTrSjQhOjsbbaQ1dM9cMaWv1He7aPtRS+
	rQAM+nuIZwp1vaI8m+pyEO7Vkfcs+YLChlTsgNpmmEjWdJdtzaMshbDFEr1STDRdbUPAAtNX8u4
	bhifUatNuYCJVfdybvxaLLL47r41CEzz3yaE0psz6L8otsP7WZLEdpyD46SU+Z8g==
X-Received: by 2002:a17:90b:1cc5:b0:36b:8baa:a683 with SMTP id 98e67ed59e1d1-37c2bd08184mr6481790a91.19.1781427286899;
        Sun, 14 Jun 2026 01:54:46 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm4317500a91.2.2026.06.14.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:54:46 -0700 (PDT)
Message-ID: <20cb2aa47183659080443fb9a875c4b6da6b3968.camel@gmail.com>
Subject: Re: Proposing a change to cnumXX_normalize
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hugh Coleman <htcolema@uwaterloo.ca>
Cc: yanze.li@ubc.ca, bpf@vger.kernel.org
Date: Sun, 14 Jun 2026 01:54:43 -0700
In-Reply-To: <f99c47a0-6c99-4538-a80d-d992273416d8@uwaterloo.ca>
References: <8c297913-c48b-4d50-a253-039037c21e53@uwaterloo.ca>
	 <7a5c9c3e8ef2cb86b7ae38fb4593e7337e9962c0.camel@gmail.com>
	 <f99c47a0-6c99-4538-a80d-d992273416d8@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-13 at 20:11 -0700, Hugh Coleman wrote:

Hi Hugh,

> Hello Eduard,
>=20
> Thank you for the response.
>=20
> > In theory, the normalization function is unnecessary, if something
> > hits a full circle, then the primitive functions shouldn't be
> > sensitive to exact starting position.
> > However, I wanted a representation for an for empty cnum w/o adding
> > more fields to the cnum structure, and I picked the { UT_MAX, UT_MAX }
> > pair for this purpose. Which added a requirement for normalization.
> > The idea is to guard for is_empty() at relevant operations and to
> > apply normalize() to the results of the operations that can produce a
> > { UT_MAX, UT_MAX } as a legit full-circle value.
>=20
> Yes, we see the benefit of having a representation for an empty cnum=20
> (for example, to return from intersection operations) that does not=20
> increase the size of the cnum struct. So the idea is that if size =3D=20
> UT_MAX, the base is irrelevant, so we can introduce a normalization=20
> function which "resets" base =3D 0, and "free up" { .base =3D x, .size =
=3D=20
> UT_MAX } for all x !=3D 0 to have other interpretations.
>=20
> > Hence, normalize(EMPTY) is not supposed to be called ever.
>=20
> As implemented, `add` and `negate` can and do call normalize(EMPTY). For=
=20
> example, suppose:
>=20
> 	struct cnum a =3D { .base =3D 1, .size =3D UT_MAX - 1 };
> 	struct cnum b =3D { .base =3D UT_MAX - 1, .size =3D 1 };
>=20
> Then, consider what happens if we call add(a, b). Neither is empty, and=
=20
> thus this condition does not hold:
>=20
> 	if (FN(is_empty)(a) || FN(is_empty)(b))
> 		return EMPTY;
>=20
> Then, since `a.size =3D UT_MAX - 1` and `b.size =3D 1`, this condition al=
so=20
> does not hold:
>=20
> 	if (a.size > UT_MAX - b.size)
> 		return (struct cnum_t){ 0, (ut)UT_MAX };
>=20
> As such, we go to:
>=20
> 	else
> 		return FN(normalize)((struct cnum_t){ a.base + b.base, a.size + b.size =
});
>=20
> Here, a.base + b.base =3D 1 + UT_MAX - 1 =3D UT_MAX and a.size + b.size =
=3D=20
> UT_MAX - 1 + 1 =3D UT_MAX,

Meaning that the result of the addition is an unbounded value, right?
In terms of intervals it is:

  [1, UT_MAX] + [UT_MAX-1, UT_MAX] =3D=3D [UT_MAX, 2*UT_MAX],

because of the overflow the result should be [0, UT_MAX] when
converted back to 32/64-bit integer field.

> and so this is calling normalize with argument EMPTY.
> Then `normalize` sends EMPTY to UNBOUNDED, and add(a, b) returns=20
> UNBOUNDED.

Yes, but the intermediate result

  (struct cnum_t){ a.base + b.base =3D=3D UT_MAX, a.size + b.size =3D=3D UT=
_MAX }

does not have the EMPTY semantics at this point, it represents an
unbounded value. The call to normalize() then converts this unbounded
value to another representation of unbounded value, such that the result
of the cnumXX_add() function follows the EMPTY / UNBOUNDED contract:
- unbounded values represented as { 0, UT_MAX }
- empty values represented as { UT_MAX, UT_MAX }

> To us, this is strange: `normalize` should not be changing the meaning=
=20
> of its argument like this. That is, if we let "gamma(c)" mean "the set=
=20
> of possible unsigned integers contained in the cnum c", we wish that:
>=20
> 	forall (c:cnum), gamma(c) =3D=3D gamma(normalize(c))
>=20
> and not that:
>=20
> 	forall (c:cnum),
> 		(c =3D=3D EMPTY=C2=A0=C2=A0=C2=A0 =3D=3D> normalize(c) =3D=3D UNBOUNDED=
)
> 		&& (c !=3D EMPTY =3D=3D> gamma(c) =3D=3D gamma(normalize(c)))
>=20
> which is what the current implementation does.

That's exactly my intention here. Take an intermediate step that
represents a truly unbound value and make sure that EMPTY/{UT_MAX,UT_MAX}
pair is not used to represent this value.

> > As for the patch itself, it seems it just inlines the normalize()
> > calls in-place, so I don't see why it's needed, tbh.
> > normalize() is not an externally visible function.
> > Shouldn't it be possible for the proof assistant to do such inlining
> > on it's own?
>=20
> In some sense, yes, that is what we have done -- and you are correct=20
> that the proof assistant does not need us to manually do the inlining=20
> for it. That said, and even though the function is not externally=20
> visible, we think that it could benefit from having more straightforward=
=20
> semantics.
>=20
> Ultimately, it's possible that our concern is just with how the function=
=20
> is named. To us, if `normalize(x) =3D y`, then x and y should be=20
> essentially interchangeable, ie. y is just a different way of=20
> representing the "meaning" of x. As such, normalize should not send=20
> EMPTY to UNBOUNDED, and `add` and `negate` certainly should not rely on=
=20
> this behaviour. `normalize` should only set .base =3D 0 whenever it is=
=20
> passed a "truly" unbounded cnum (ie. a cnum w/ .size =3D UT_MAX, .base !=
=3D=20
> 0, .base !=3D UT_MAX).

Think of it as named "normalize_unbound_representation".
And the logical rule being: if the result is a full circle make sure
that it is represented as {0, UT_MAX} (or {ST_MAX, UT_MAX}, but it
looks like that can be dropped).

[...]

Thanks,
Eduard
