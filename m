Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45520430BBF
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772313684; cv=none; b=dnJwl3Q1rvE8E7mdOucqDNatOKjY13OqxSFD5RATgN077JMtSXfQKYO1Nn2qRmx7Ss6xIik9BdcwkmmDg47acN+tP3NBANqEeyL5nAYx/CfuUIhNHdqVuKZk/UxfPw+dNjeC+4cOtFDSNKKIaqJi58s72Azf9hG8lYtJAGbP9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772313684; c=relaxed/simple;
	bh=vFrp7si+kuivemFTLYpzw3yOvNT20HQGOg7GymLJlok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1CnIBcdkZO17Q7uuJgp+GNnbmNhlQgTP6/RCWhdfp/EoAnX4tBtIjLNW/Dlq2gpmi0jVwPy5PHzUIoKqU8BtFwHe6/GCr1CnjHv4OYKrYsirGKxLpMQghUofSyjggQ60yLpU9YKFIWErss1KsTc2ZYfJ0Se2c6C8ZsdjBK9IFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuMZcZpF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuMZcZpF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a871daa98fso25634165ad.1
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772313683; x=1772918483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbXbQx7M9jVWpclASY470wNvm6J3WkCyiEQBb8Mk9XQ=;
        b=OuMZcZpFGfU7k3YPlCdnNZdUOlraN2Ev6cLrvdsmj2YP7VWnj7F/7jXpuZxm+ykZ6V
         QH4y/VY1T5mGkp667k7gvkMdGgd6EpNxPWsUXza2XCfpsensKgscwHZUS16L0adSJ//M
         eoJPbuIXvgT5EbJsBK6ynWureq477vB4nwfvmQ7lyCNIEWvka+SrT7YtzW7BQgVZxIiv
         MOaiWvelfsaMaUXjxMiJ4cNUtryqE3CZPre6jHTbQ/ed3fOoJd+BzZS9wRI8dlfpVrMH
         SOskc7YnXdpIQpoeLRNBbtU630Row95CvT6XeWqhE8BPCnQavYlO6zCHnWXUzDPmirAp
         5a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772313683; x=1772918483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbXbQx7M9jVWpclASY470wNvm6J3WkCyiEQBb8Mk9XQ=;
        b=Y/u0Wm95H+MeKFgWVJICNg1b/TRSyeDZhV3GkuOccmcvQW4LEl1+fWfNWonRaqQo2s
         jKizF4ek8zHKWETk3OEA5Bu/Qcgo1n2IfhAd+z+2yhc1sx81Cj/ZPOYdNoj5OMe0f9+p
         foeAJ2NEGqOx9pI7OuSjKlwWp82ngFh+yjx4t7VtXvdGBHrNAi/bpALtoIFH/moW9S00
         LEc3Eg0kW3DbvBiRG/E6oPQK7cmKQopGVuWtbLxdmWQFGa6YEhF0Iw3XPJ+18ANp5CHv
         dpze0SjIpjx0h/5H6fgTWg9XusJYFV03KM/UJDmqyXEc02rs+bpnkteXboGbM4ltljsA
         B+zg==
X-Forwarded-Encrypted: i=1; AJvYcCV9385xfDKeFuMcodbtGsFCqbb2yzyODicjLKBC/X4iRzI+iz2BNd8fxgNr7v2lhwjFF1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBupQObryPEQQqRp5/9RSKnYeaVzHD46PyoyF79HzX8Dk6kwz
	xQPB93vBz3BVvMbj8wkMiIJXFB7wkFZC6HrQAHudDFNMNbxk7y3m9umZ
X-Gm-Gg: ATEYQzwjWBDIlVBbtdpT+cnrU92zLyAMnCPSvPBb1mKxSx/81aSNFgRTstPNf5nTeLZ
	7IsJszjw8p2LMngfcAGEjOEkcVCVmhYXcrzg/j/4rBVJ62jvTL3BWpMU3PzVX3xv9C2al+xzVBE
	EgVGA87Wq4omIhF/LEs+zCtcqZlzxRXcZAe2AtrnND4mw6xx+0wkXN3NOWn4EFoNT3NioLFrYmV
	zYJE/1sjwOlVIYb3S21pC4MC6rTfT6dcn4yke4BiZDdfeCbEudYJrYOFL6y7fFT5dX6k+NUuTRJ
	um7i6vPSd+E0DizFCvOADaiWxvX98MOO1UkQOyrHPD9XGIFsBuzUr2540h8BZV7mtjZODc2ySWt
	bVU3laMlRX6/i9qhcYPDyKQFlNyei6K0PDuOBxY2Tn88zmXgr5ivv7Hs/7EJQcNuE/Ngc9pwHlH
	zgCf1YkyBx+5sqbX1Bpp+voyQhof0qrTZFsxSo4UXLmaz6uiGamFo=
X-Received: by 2002:a17:902:c94f:b0:2a9:484c:ff19 with SMTP id d9443c01a7336-2ae2e4b9847mr85015505ad.42.1772313682443;
        Sat, 28 Feb 2026 13:21:22 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa5asm95515235ad.60.2026.02.28.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 13:21:22 -0800 (PST)
Message-ID: <85a9bd51990b0e2d0c586405ba9f940fa5cca8b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: extract
 check_global_subprog_return_code() for clarity
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bot+bpf-ci@kernel.org, 
	bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, 	clm@meta.com, ihor.solodrai@linux.dev
Date: Sat, 28 Feb 2026 13:21:19 -0800
In-Reply-To: <DGQWGJOKPUN9.2N53YPANBDJ8Q@etsalapatis.com>
References: <20260228184759.108145-4-emil@etsalapatis.com>
	 <9014655d9498ca02086847eec5b1f50737bc3de06999b3fecd9aa67345b98cae@mail.kernel.org>
	 <DGQWGJOKPUN9.2N53YPANBDJ8Q@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-02-28 at 16:06 -0500, Emil Tsalapatis wrote:
> On Sat Feb 28, 2026 at 2:45 PM EST, bot+bpf-ci wrote:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 80b6fb821456..ebcca81ccdaf 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> >=20
> > [ ... ]
> >=20
> > > @@ -17987,15 +17984,6 @@ static int check_return_code(...)
> > > =C2=A0		goto enforce_retval;
> > > =C2=A0	}
> > >=20
> > > -	if (is_subprog && !frame->in_exception_callback_fn) {
> > > -		if (reg->type !=3D SCALAR_VALUE) {
> > > -			verbose(env, "At subprogram exit the register R%d is not a scalar=
 value
> > > (%s)\n",
> > > -				regno, reg_type_str(env, reg->type));
> > > -			return -EINVAL;
> > > -		}
> > > -		return 0;
> > > -	}
> >=20
> > check_return_code() has two callers: process_bpf_exit_full() and
> > check_kfunc_call(). The new dispatch in process_bpf_exit_full()
> > correctly routes global subprogs to the new function, but
> > check_kfunc_call() still calls check_return_code() directly
> > when validating bpf_throw() arguments:
> >=20
> > =C2=A0=C2=A0=C2=A0 check_kfunc_call() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (meta.func_id =3D=3D spec=
ial_kfunc_list[KF_bpf_throw]) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!env->exception_callback_subprog) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err =3D check_return_code(env, BPF_REG_1, "R1");
> >=20
> > When verifying a global subprog (frame[0]->subprogno !=3D 0), the
> > removed block would have accepted any scalar R1 and returned
> > early. With it gone, R1 now falls through to full return value
> > range validation.
> >=20
> > Could this reject previously accepted programs? For instance, in
> > a struct_ops program where return_retval_range() returns (0, 0),
> > calling bpf_throw(1) from a global subprog would now fail
> > verification where it previously succeeded.
> >=20
>=20
> This is accurate, but this change of behavior is actually a bugfix,
> not a regression. Eduard, can you confirm?

Yes, given the documented bpf_throw() behaviour the returned value
should go through the same checks as main program exit.
I should have noted this change in the commit log, but I think I did
not realize there is a behaviour change.
=20
> > The cover letter for this series indicates patches 4-5 may
> > complete the bpf_throw refactoring, but they are outside the
> > provided range.
> >=20
> > [ ... ]
> >=20
> > > Both main progs and subprogs use the same function in the verifier,
> > > check_return_code, to verify the type and value range of the register
> > > being returned. However, subprogs only need a subset of the logic in
> > > check_return_code. this also goes the way - check_return_code explici=
tly
> >=20
> > "this also goes the way" -- should this read "this also goes the
> > other way"?
> >=20
>=20
> Ack, this is a typo (my typo, to be exact). I can fix it in a next versio=
n=20
> if necessary.=20
>=20
> > > checks whether it is handling a subprogram in multiple places, compli=
cating
> > > the logic. Separate the handling of the two into separate functions.
> >=20
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >=20
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2252=
7094257
> >=20
> > AI-authorship-score: low
> > AI-authorship-explanation: Grammar error in commit message and iterativ=
e human review process
> > across v1-v6 suggest human authorship, though the cover letter notes AI=
 assistance on a different
> > patch in the series.
> > issues-found: 2
> > issue-severity-score: low
> > issue-severity-explanation: Behavioral change in check_kfunc_call bpf_t=
hrow path could reject
> > previously accepted programs, but the impact is limited to an unusual c=
ode pattern (global subprogs
> > calling bpf_throw without exception callback) and is likely addressed i=
n subsequent patches outside
> > the provided range.
