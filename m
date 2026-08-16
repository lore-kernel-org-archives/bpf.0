Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF151448E0
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863012; cv=none; b=W6PPC9GbvoXJXo4tlbbsVvJFwQrSP3ueujdQvTZtiv7NO+EYsRV7pDA7BadpbjTsnLB9yH0/ffIEGAEyI/ZwyTrn2e1azs8MM3iF3/foUZGw/stjT2AnlNqccz9G0nbKFi5YVf1/42M7otnhlZveNb4Kij7qViyKWboBtX5chL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863012; c=relaxed/simple;
	bh=23ZHHJ1P5y/dfFOb+fh08RGyfiDdumS+meZlEd1t6W0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIAfOLSqGF6wvZYbL8ryPJZvsIuBAnhCS6usT4MvDOufSvb4k8+/NLqXP7XFKQZZtSzFN7SYU98mz2xCPSCNTArBNEZ9MMis2Gr+QzhxkLE2BgFtbfRRj+lP1kGM5fvboDkSMqQJ9QCbNC9o8gmkqaz/JsWNjSDJWLdt4cd+3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jprhFvRe; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jprhFvRe"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2002222a91.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786863010; x=1787467810; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YLUfSq13I6MlNrcEtMJpTNGPseC56I/RNGB5tXTImts=;
        b=jprhFvReeNBHEIpC74s6LmfP9S1GXYP2GNWEk5f0bH7m/C/lz2Fn5xPchl1sATchLt
         YwQKf3Cu9VhNdSYhHG7bzo9taOeh0Gy3Kn4n1MOmmaroVqqcshOcVeft+ICsywRQQfme
         g1wQrTAiq2VciUpzI+anG8qcZr1JLInuOjKaBAZb6iVjKuCj0AhW22R+v1I9QU3u325i
         7FUZ4D2CcpxxCQMaFUz7KY5n+4eXDO+FPZhwNRzHpYZQK5YDKtGQvLQ7EFnlsRi8R0vx
         kcEQrrvxtqH8D3cinrX1EZm0h4a4Fis6PkjXVfufKf/Tx37bgnwy9HVvkJL92S+wAGZ+
         aNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786863010; x=1787467810;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLUfSq13I6MlNrcEtMJpTNGPseC56I/RNGB5tXTImts=;
        b=SUGs5UwpKfvAMBw2ONTNvP62I5+0y5HMMU9aI4GRrHiOL0R9vuURiSGMKFOVuSZmri
         XPoGMie7n86kLSqXLBVLnEzdd6MsSaqRZsDCSYrbHE21ty4hYGmDCV7OHO/sv/k5uDf1
         dmxopqEKHqNs1HEIkOEOMxnpT4adaHYH/rWM51B7TboFVnrpmn8kyblBm9mOV7J92wIn
         SweMgjwaEmRzSM3Rh4iWL0TYXKA3HDhxINnYpoxiOjJCFLkhfbLHXgRPPEdQxM55uspO
         VNp4tM+s9C8Au1QZXQDYdw6ozkMROzmbw/gU9jeOT0BeVl/4IrnoW0o53gEFEDSgu5u1
         +3Dg==
X-Forwarded-Encrypted: i=1; AHgh+RoxY3gvra3k4E5Mze8m6br3L1DuPFny9tu5FIowhec+N2XlGdMxTTs27TiRWVcQH1G/r0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfH6lX2Bjis0RS6N+bBbzEmUTMPVqCMMjntW92ePxz+LNBD+i
	ZW8zxBZ1HRh8fJ8zY41Hu57OUQlvFboY7Vye10foYQwgSaiD0sU5v+qA
X-Gm-Gg: AR+sD13pRR8ljwRdN2RHO0h7pnc9nWShob5xv/qUHIqJ5ZRSMuQYmN9hrbVSX389qLF
	YmmVhZGsavi4eVsVk2+kn2F/UvVvXPVYoG/7kK65B1KU+V67pTrtWHNS3U4/I7/2x9UknvQr1do
	G14bya4s1lL/Zyt4oGIRirqCJzQFDWcz3iUCGc7JR5ht1jkfRprtV7L+dnaY4FI0VosdXvc1g6+
	zYBeewCcseA4OV7Jy8jHanSvvkhAXg1fDx6yKDaea4UOlZg1NrWDOWMGTHaQ5gq7bkqVCQTaVhf
	Pi3JOjlvW0Xef1F2FlQccnoKwb3dghf/f6ZGoa3UNZTZ/ZSzfZxybBeqz+i/WXY8D+oxpbWbiIv
	4qO6y74oCASYRwZaLdsYRTSusONF5uCMUHx6y4jgiwBrTYQnDKF/YPoaXCh/3aK+/ccZqlQUy1F
	3QiNWvnz/CIe99l1+IlTTvq8lPyPAs7UWbgyfWKpbQz2P2qHtZbCMhylKxI1DJWdlVHQ+ZQymdL
	ohUSv/lcy4HSZwS25qwrkJKbW0=
X-Received: by 2002:a17:90b:5450:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-3933b8470a1mr18115416a91.7.1786863010515;
        Sat, 15 Aug 2026 23:50:10 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e9a689sm732819a91.11.2026.08.15.23.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:50:10 -0700 (PDT)
Message-ID: <41af6583fa0b058ec97158a17d24648a746e2994.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/14] bpf: Correct kfunc argument
 diagnostics
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	kkd@meta.com, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, 	clm@meta.com,
 ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 23:50:06 -0700
In-Reply-To: <bc71b9e364a0d43c49d26f9547a1e757e8a6a38e1c378a6fbea21aa8835dc31d@mail.kernel.org>
References: <20260816015746.2632990-7-memxor@gmail.com>
	 <bc71b9e364a0d43c49d26f9547a1e757e8a6a38e1c378a6fbea21aa8835dc31d@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 02:45 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git kernel/bpf/verifier.c kernel/bpf/verifier.c
> > index 7ef324e384f4..da2ec0655b17 100644
> > --- kernel/bpf/verifier.c
> > +++ kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -12653,12 +12653,12 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> > =C2=A0		=C2=A0=C2=A0=C2=A0 !type_may_be_null(kf_arg_type)) {
> > =C2=A0			const char *expected_type;
> >=20
> > -			expected_type =3D bpf_diag_fmt_btf_type(env, btf, ref_id);
> > +			expected_type =3D bpf_diag_fmt_btf_type(env, btf, args[i].type);
> > =C2=A0			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
> > =C2=A0				reg_arg_name(env, argno));
> > =C2=A0			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Add a NULL check and call th=
e kfunc only on the non-NULL path.",
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "the pointer may be NULL, but this=
 kfunc requires a non-NULL pointer to %s",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "the pointer may be NULL, but this=
 kfunc requires a non-NULL value of type %s",
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected_type);
> > =C2=A0			return -EACCES;
> > =C2=A0		}
>=20
> Switching from ref_id to args[i].type renders function pointer
> parameters incorrectly. For kfuncs like bpf_task_work_schedule_signal()
> that take a bpf_task_work_callback_t (which is itself a typedef to a
> function pointer), btf_show_name() walks TYPEDEF -> PTR -> FUNC_PROTO,
> collects the typedef name and adds one level of pointer indirection,
> producing "bpf_task_work_callback_t *" instead of the correct parameter
> type "bpf_task_work_callback_t".
>=20
> For kfuncs like bpf_wq_set_callback() that take an unnamed function
> pointer directly (PTR -> FUNC_PROTO), the FUNC_PROTO has no name, so
> btf_show_name() produces the malformed "( *)".

Let's keep this as a follow-up; current patch is fine.
