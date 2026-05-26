Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998D3B6374
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827714; cv=none; b=qnSQRAQmE+SukAoun/eCvri7iTxpsuyQnlOmub4bfqiUULlYvnpyXbi8KpFrVlNzKSsqAbDRbMPmu8RbS0o+m6/0+BjOvfz6RloftPWH9QyNbA7qdMijirKRAU5vqaGE6CSsW6xZRIT578EfDnJKRsivQWDIvq73C+lP/OqwAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827714; c=relaxed/simple;
	bh=6kYZgsyU+MdFgWQWs6RsWRTaES8w0MvIrm74tGaOQ94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/SRlMnZNLt9D+eaS6x4Rf9+hZnB1BO1dowfMm6Ajlyz+FzSnHo3Qosl3umMCPWyM6GHAV/lvnLH5ZgogPzpH5S3YbYpGtZXNXyzuqmeDKScflHp4w3kLAPvRvity9MyyvHwaAZGf3M4e6KtUG9sj/MWbBHK/A5RN0YfkBufLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJMZ5m8S; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJMZ5m8S"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36aa4ae1f11so1915645a91.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827713; x=1780432513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ayKa+wXv9mBm8YmojF2TWUJ13IEkeuAAhZGYZ06n1w=;
        b=GJMZ5m8SiMtGbFF8V1LuE1AeX//+Yp57iXNlLl3hdxQK2PHIbc+/TTtw3m7L4NWFLA
         8RqOz2RH4K6PlkfLKZt1X+4JRR5vdc2GLU3PYONFqCagVekia8HkwFVN4yQlccS/wu6l
         hkZLRZ23DfglVPDE2uuoy/cin1N2MbNAEHhWEXUtiX7yTpC4AeD0e5r9VIw2Do+Rg6az
         XBHHGCYoXn7fzr2MeB60ox8sKkJdxcSj8p7IzSGjPoB9Jp7xte58dkKpIDK5OHOLl9cQ
         zlXbq1OLPN/6NXddmmnEshA20hQwPI0QSFnDMrkwbHJIrCW4aIjskab1DqA9LjGG430Y
         EmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827713; x=1780432513;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ayKa+wXv9mBm8YmojF2TWUJ13IEkeuAAhZGYZ06n1w=;
        b=gXn4h5TuwrZOK+fR7xeOfIFJxeNuw3b3Ode/OJSGYg6t612WcI+CuyOO8PWy43kHVl
         xVPkTNrrC7BmTwQQEvTuDmpJ7f5ev985CdZ6zFT2jSlOOT2utBahtsYE+fRWaBqYYjVj
         2nUuP2L5SD8NibWkXTziJP+1gpXkFzGglK36/NcZQcC7/I9btSuItwZAnEkpSwukGHUd
         1LyQNoYsOdyZMkutl1wunHdPau04AQ63C9JvmIGMAWTIHv7MZPdpqg0d/9JC8+4xOtz/
         6SITG6k62QIFFrtJ0F6XniYF+ehLkacNSbbK6aawgrHhrt1bsRoKR3XE2qUxht+uTlkO
         vdRw==
X-Forwarded-Encrypted: i=1; AFNElJ/joNh/SqzmWUjN4yNa1ZZ+kF8QlQMQDrWfd3lzbkPAWcf9d62/JPRY2fsnfap4VAwnVC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBBlXcXtIUT9fvLCcpCTilKZBvpj53pvrLJsG5O0rLNDiZxSw
	0wwc7H8unIgK0AYhMouAyYchJk+E4b+uiGBYblOfw3OdN0W42fRdiE7S
X-Gm-Gg: Acq92OFAs4DDdGRVbGPcKvJlvBrbBHt5tfo2DsEAb7xApBKi213lTqfD61BO5Eh+lm3
	adOmUrxiXiivnqHRA9E0PFoDKJUxJvjOGhqCRYNBMOiW+7fjVpNUMbADwMLRMeSpo90Tei3ofV3
	WCzOSTozH/W2wnUfM06QFQlmjLJRRC+OzK8KWQxAoBS1IKohh8Nf3anBZIUo8LbpFBjn0haBRJ9
	+HnlmKBgJzNOYwTC0LzPpn9Z0DTNIUZH/kEErbOh0FSlV8+7LEq3avhxb28A+S70Yxl0sC9fXCI
	O0boy0chYkuSPU/lzG5genBEL6QliQHUK7dQLMhHaTHjFFzWTbsvTnxIEXRy8U1Edc5vUYm7lw6
	G+8qiPuyzgTJjEx4akB5JuQpuxmshnFeiipq4ka3ssQcDQK5bSZxGvyADLNoZ1NYG99mzzk9duf
	NKy5sTUh1NfEe2niuMFOW9QwufikT69t6uFSSJHdv/5zvgzbnTcnpaaAVINv2bhod3zuE4Bi6zB
	A==
X-Received: by 2002:a17:90b:4c50:b0:369:bddb:79bd with SMTP id 98e67ed59e1d1-36a676c6a95mr19311575a91.25.1779827712708;
        Tue, 26 May 2026 13:35:12 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36adc0a6e94sm7985475a91.4.2026.05.26.13.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:35:12 -0700 (PDT)
Message-ID: <fbc242b2830a0190348e8fdc3f98c08f455995ec.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 5/6] bpf: report register diff summary
 for hot callchains
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 13:35:09 -0700
In-Reply-To: <61ddcbe99f39faa28a822a24e5e400f9e5825fb37305a5832d58bd48e1faea9f@mail.kernel.org>
References: <20260526-better-1m-reporting-v2-5-e7ec61c45d41@gmail.com>
	 <61ddcbe99f39faa28a822a24e5e400f9e5825fb37305a5832d58bd48e1faea9f@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 20:17 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 54b7ad65b7fc..d09c014462f1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -17527,7 +17564,9 @@ static int do_check(struct bpf_verifier_env *en=
v)
> > =C2=A0		insn_aux =3D &env->insn_aux_data[env->insn_idx];
> >=20
> > =C2=A0		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> > -			print_hotspots(env);
> > +			err =3D print_hotspots(env);
> > +			if (err)
> > +				return err;
> > =C2=A0			verbose(env,
> > =C2=A0				"BPF program is too large. Processed %d insn\n",
> > =C2=A0				env->insn_processed);
>=20
> Should diagnostic allocation failures mask the complexity limit verdict?
>=20
> When the verifier hits BPF_COMPLEXITY_LIMIT_INSNS, do_check() now calls
> print_hotspots() and returns its error before emitting the standard "BPF
> program is too large" message.
>=20
> If bpf_sample_state_diffs() returns -ENOMEM from kvrealloc() during
> diagnostic printing, do_check() propagates that error to userspace instea=
d
> of the expected -E2BIG. The program is correctly rejected, but the
> user-visible error shifts from "program too large" to "out of memory"
> purely because diagnostic output failed to allocate.
>=20
> Would it be better to ignore or log-and-discard errors from print_hotspot=
s()
> so that -E2BIG and the "too large" message are always produced when the
> complexity limit is reached?

I don't think this is a real life concern. If system can't allocate
10-20Kb of memory, there are bigger problems on the host.

> This concern was raised in v1 by bot+bpf-ci@kernel.org:
> https://lore.kernel.org/bpf/e98190c9cf56e356e517d69e5409b8fa34ee99342287c=
612418fbfe57319e1c4@mail.kernel.org/
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/264713=
89564
