Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43823F5BF3
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855894; cv=pass; b=ZqeSjF6KQB2omK8yyZZo/v/N+hZzY+FLZlg/4NpR2PUGv2l1wPFyrgMClIX1t4+mN3snM0YzW2OznZu+7DbM4l4jBAxncmDKY5S0FGmxDZtla8bCUP2fvv4meBNm3V2b8VU+POt0/EQq9noYN4XIusYJwGHOLkJ+wanZnSG7RMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855894; c=relaxed/simple;
	bh=DIK9byJoKUSn8x1QzNuAeFJl0xfITa1H/6MjxmO4zl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnukq0KkXjlGFq2TV8ff45NQhb9J6+fwZMynIIqQgrXraZjB2CCeV/Sd99dZwtnyGSaXJm8ue8NXXksxG/1X3Kb1tDaFeHYLnkwveUfbaIA9i1upm4bZJCsCyu7n464IBFWBDRrZaxOFLFw6vSDw+dIXH5FlllWPE688au07ekg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tnc1tEKY; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tnc1tEKY"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1712a04ddaso757146066b.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 08:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855889; cv=none;
        d=google.com; s=arc-20260327;
        b=g3TbbcbdhAQthUKYFqdd098hZfogT+7vbuE7tthPLMZMM8GCOfB4RAbPFbL8cH0J5t
         U8bEl3KQblTrVbjromZ1TqNw8HhKEnnDN2VyswxDijf3dw345uqYtLV3BD+CyvzReODI
         6xRyA1Cu4qbPwJAsIJesHfxAePeSDG/vqCUxmMPwcOmOuZsbrBbdoifw4AGfccHle6U6
         4kLVFD/9dm+HWFP8SfOuS2Wh1a+L89JzYCW4QgAbbeZKscztLlrZ4K/fD1iN/AVLTnyx
         qkMeqCgo9WLu/G3gBhCL2xCnIbxan5b3K7WPc0Mx3e4QdOlIUJtnhxGcAC1uXvBiuykZ
         oWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UMfYGwm+h7erjn/kf3mtUFJd+xnuOStNHUghIRTCk1g=;
        fh=t0zB/eO4npZSEulEd9pyiEHEEYvMuEqkZALaJN07k3M=;
        b=gTwPPMVweWsDwCbcjnjai5xJ2Ryi7r4oSFCtO90/1o/5Qtmee5NMek4VNZNrMIBJf/
         V6qp1xgNttPAjn4EXZJisbJbQTEIjg6PKxqYsk4HoOxkzZdcqMyBGs7A0q/tXdqbtE56
         xIBTA9O1lEF1f1Et3gcHQJD8Ty3LnPjsocHQYRIaHtSvyVAIEA1PTWsNt0iCBDTjc6UG
         VL3eQiwK3JRcgN8rbMuf0c0w1xfioLotzzE0qvPAaHV7+HruT4PcSqIeic1yOyObpX65
         Im85EBNX9v9q4ILnWVYY1MjsBaFw1dwDaRIN1KW9v19DhbSrTC8cnWq8B4yBQsK7+vve
         FKUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785855889; x=1786460689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UMfYGwm+h7erjn/kf3mtUFJd+xnuOStNHUghIRTCk1g=;
        b=Tnc1tEKYbSxys6WFbO1mgxH+NOYoWQZXcEKWQtkeMSkNLYuhdqzts7tj1EIRv4qgTa
         zU3L/k4lnW7nbUevUQrX0+dnRnQ0v1mqzozLSZm4YdBT3lQD39MaGSCTZCio+VKRZe5V
         gHJH9J14aU1wRX8L/uGhPEJXYB3Pmc+GAtyLhSRsKXyrAEYl+sgx6uFsH6/w5EB7tHA1
         DGRdRZqMb+hUi9UdiXMVjb7zzDhVr8g7HXmAVd96Pga1enDc+mr2M6UeyK/+p9QnSQmd
         qCeBu9J3MoSAuYiKkxGsNLGc4glAXG7tsIt/JZ85N+i4xE70tnwGZ+PmPBldhwEB71ov
         8vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855889; x=1786460689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UMfYGwm+h7erjn/kf3mtUFJd+xnuOStNHUghIRTCk1g=;
        b=GS7QyUOzSCGxyF4muROoAVn6volKW+HDyjfI2k7cjmLL/eoZHll+2XRczJ9ErWUdUi
         Qc+ksPSVgumdrcJXCJ92+0GTH2zWyyOj73bjbTEDnLEcyEihJTSmIxZJyNNLNs+7tVLQ
         rtO3866lOideq+Fubb+eJJ1CKYRG72wUg7W6plmcFpTP+Y+M5t1Zbbd468NWYG2c6oUp
         Ft5BbQbONala5wl7/xxnk4vPybBfEZNYmqomTh8DNBvnMWiD84LCSToCyD6nZUGQpyDp
         FBu4ifWOoKbv4TSC6402Ud4V+yqcmKVgpNYCvitsp79ujxh/2r5qC6aOWmK/rtQJp2F4
         UUmw==
X-Gm-Message-State: AOJu0Yy0vD4B6jr3v7/v+bduTMhW+kz/UVDywtjOTw5C+Aebc6xA7veg
	z4gcDCKlInYVtouufAvnzEtBbqMM/aR2Of4XD8B0FGgkjm8xsXI1l8sp31knrSGZIyERednpbRZ
	yyFoDXD8Pc0GcNnDrte3gNzt/J8+RRIA=
X-Gm-Gg: AR+sD10eDnx3b4FrGbGhN9mV81a1rS67GmmY6vTaVncNVqpXhOhq2xm3goIP66CrXEY
	SwGTOMZQczTuyXVOAJjt9d7wxiUpZTLA8Kjd5TH8lNxhHtcUk3BF0Pg1YZC83tk5SRe6f0p13mv
	9DQb+oPWvxt6ZMOO/hdT8EutGqRsIGOzvy933AUmhirYgleTRMTPquj1PnP5uQjJVytfqmlL2X4
	N0ZjRJ4Xy2zx+ySYc8nrIm3azbny5yutPDFf0OZCIgPCN7JQ7cPHEw6BeHstKYm4BxE/gCcsiF4
	9vKS7anFUZr2g+mu/cL13MyUsqtx1NjqbYAMpZQtIC94hFhShH2jlX5DJLTW
X-Received: by 2002:a17:907:7b9e:b0:c20:768:af62 with SMTP id
 a640c23a62f3a-c200768b973mr964186866b.22.1785855888297; Tue, 04 Aug 2026
 08:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804134601.2305303-2-puranjay@kernel.org> <8203f8266fa504ec5dc4719a590280be46d11dea934146476db1307829dc71fb@mail.kernel.org>
In-Reply-To: <8203f8266fa504ec5dc4719a590280be46d11dea934146476db1307829dc71fb@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 4 Aug 2026 16:04:33 +0100
X-Gm-Features: AUfX_mzjyuw23fm5YAX6-cr26FtMJBKHl3esFCF-uOhkFuVSeglK68ssOYLz3Rg
Message-ID: <CANk7y0gS9fFe5-SYmnjtdTCZYaG=CXqpq4WOrxrn29BUeWkFAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Correct the overflow check comment
 in bpf_iter_num_next()
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> > index f5eaeb2493d4a..b235e117e206a 100644
> > --- a/kernel/bpf/bpf_iter.c
> > +++ b/kernel/bpf/bpf_iter.c
> > @@ -802,12 +802,11 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_ite=
r_num* it)
> >  {
> >       struct bpf_iter_num_kern *s =3D (void *)it;
> >
> > -     /* check failed initialization or if we are done (same behavior);
> > -      * need to be careful about overflow, so convert to s64 for check=
s,
> > -      * e.g., if s->cur =3D=3D s->end =3D=3D INT_MAX, we can't just do
> > -      * s->cur + 1 >=3D s->end
> > +     /*
> > +      * s->cur < s->end while iterating, else s->cur =3D=3D s->end =3D=
=3D 0; the signed
> > +      * s->cur + 1 >=3D s->end holds even when s->cur + 1 wraps (start=
 =3D=3D INT_MIN).
>                                   ^^^^^
> >        */
> > -     if ((s64)(s->cur + 1) >=3D s->end) {
> > +     if (s->cur + 1 >=3D s->end) {
> >               s->cur =3D s->end =3D 0;
> >               return NULL;
> >       }
>
> The replacement comment says "s->cur + 1 >=3D s->end holds even when
> s->cur + 1 wraps (start =3D=3D INT_MIN)". Doesn't the inequality evaluate=
 to
> false in the wrap case, not true?
>
> Looking at the code: bpf_iter_num_new() sets s->cur =3D start - 1, so whe=
n
> start =3D=3D INT_MIN, s->cur wraps to INT_MAX. On the first call to
> bpf_iter_num_next(), s->cur + 1 wraps back to INT_MIN. For a non-empty
> range like the selftest bpf_for(i, INT_MIN, INT_MIN + 2) at
> tools/testing/selftests/bpf/progs/iters_num.c:101, the test becomes
> INT_MIN >=3D INT_MIN + 2, which is false, so the function returns the fir=
st
> element.
>
> The commit message describes this correctly ("the wrapping s->cur + 1
> brings it back to start"), but "X >=3D Y holds" reads as "the inequality =
is
> true," when what seems to be meant is that the comparison mechanism remai=
ns
> correct under wraparound.
>
> Also, the first clause says "s->cur < s->end while iterating, else
> s->cur =3D=3D s->end =3D=3D 0". This doesn't cover the post-bpf_iter_num_=
new(),
> pre-first-next() state for start =3D=3D INT_MIN, where s->cur =3D=3D INT_=
MAX and
> s->end =3D=3D INT_MIN + 2 (neither s->cur < s->end nor s->cur =3D=3D s->e=
nd =3D=3D 0).
>
> Since the sole purpose of this patch is to make the comment accurate, cou=
ld
> the wording be adjusted to avoid asserting a condition that is false in t=
he
> cited case?

Andrii do you have a preference for the comment here? I will copy
whatever you say verbatim to the next version.

Thanks,
Puranjay
