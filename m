Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793837167;
	b=wwbto0VQ3QZ1CzD+VZ7UpLGMjsgb/On8n4L14Gw8OJ8QuftCY11QgGpfORodbkjy3gpo
	 pHtBDWbbgI6sujeZ02O4HLZuoglmL3jZpusN1DTHXJJbyzzWiT8gAaKPsur42aaZJLuF0
	 ulQksuwEWpM+kMJC/bv9jWF8OlVeUtjBS7LQYATW0KzGt4u91xiyqfkgYTbgr7J1OTXlw
	 kPbLQ8E+qWljgz+pMKo2nHfIyBzkkm/eJukIVfTNyO01DxlqrvV7GRbtJJUOBjrHyEOjj
	 ITdGsUB51MzGO1h1LPFVBMPx2O5PmM3/TOwMW0TAcMHiEE+jkYzfOhTMIsJIfOFgPNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
	b=gLbFVQXptvyCK/ZnzFHWHhiZ2b5SXI9GhYy8FfkW8Mf4oiXIb/GiU9+6z29/7ZyVQnMO
	 PEMTh6H5+8oZ72bTCyTvvgZfstrNgYqzzw/o23cpAWwVPFU+NnkLs9xy/gIXbCy1K6axh
	 dCZRHuRLXVKSdC5cj1GV0L8pyPoFrMBhSZy7yxvIWsaVpZYMiO9Kwx8/eAhAhSkCIkof4
	 pXSB9Ux9VTobiZTP14dFYSFTELMgsNSXO6xHSKwp8lTdnTlHU3JWzVgzTUNSkNkkJA9DS
	 258jxf4LX7Qyh9pltTXac93U/B1uNgZw+2DGjLP9Cv1E8qfWbL5IgDR8FtHUNvrOpWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UW7+Lg7r;
	arc=fail smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100B606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 00:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E100B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UW7+Lg7r
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4682977f9aso166302566b.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 16:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837165; cv=none;
        d=google.com; s=arc-20260327;
        b=kIV46w5tZ63ev8/rWFx4UR+hOO/MHl2L701gKybieWvKrnwqhEVE5Tv515VrBqgnn8
         e6c7AHZO356La2jZ3VuH4kvOp8R4AOiNcdG74PKReM0Bp6VSbloV4/jT5TYfUSuo8CEX
         dCikq4WMMMMuRvFjGKHk8dlMg7JefoRbfLxFU44iUWWwnnnceFPxLcnbHbca0tQe2wqY
         oSzY9vJRQief0MeZKbk7jVayORJacZt/o4gcnKhCoui8wBgHsMBWJAjQVGmA6a9e8Ofa
         EfC3iYKD1LPi46ci1MUDOuBIrhy1Tq8B7Yn0PzhZdvf+OfsFCVR29ao62vPg2oKIStsT
         4plw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
        fh=1C1wzk+LD30+/nOqfX3JiKQlEXqrNxKcipGrI2+k/jU=;
        b=ZF0i6U2a+KyMB1V+QTF+L6tUPKZHzGaU3b7j0CE7AA8wbpZGjivdPb2TUZY3bVfbXW
         gZip4rZRzoQXZtDxTZmsZbskX4nDTtmS732wqLmmFFc9/vZEVh4DQQTKHfIX1MZJYwJK
         necPAwD3yZts4Zr9XulXp7Zi0M8xNCFw+XOljH4dehCPiV/Z/ztu18Rl80ruiRy2ZcVU
         Fy3ywx3k5DW0NG526OgytoPgfYGEkxLZsnuBZdOe6MXDcbsD4thyB+h7d2LBfwPAX74C
         5CG+x2m6doRtoGYd0qXI7q0C/pKKZaDXn9YcHQvXnqmIHB14qVYZVwitXMFe+lkm2bFw
         2f7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793837165; x=1794441965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
        b=UW7+Lg7rFdK2cPOSHdibyhfqd0mNfE52oRphbaahRpCOHjIZJidko9tTbllyzCryjy
         siNubT2yNT8UsddMzx39cRlaaf4u9pnE+6dIm/dTOyiVwyDFMyx/T503O/SAkgV4IgXs
         efUG5InyQPdPjXkVj3FyrgQw8Tp3Uwud4aaLkD2TGlBzm2pE66Yo0XieOJu07M7lI+DV
         gUkNX9hygDXotIY7g19Ob5YY4jcsnCTMlsFTY/Azp5LW+ukD9CKA5AAnTO8zpTJXxWqx
         5Vgp8TB7FfNb2pRMsONUAcd0wfnBxqAeiMrEDvVnn/35z4BZWsrn2RkRHETiQqHGP/C3
         KXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837165; x=1794441965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
        b=iVFwCPV97LYnRQwgxP8Cni28gtb0/uxxiOcj6oYN8atbv7fEpSssR8UNltFcKNMu4S
         ZBQyxptd9fQ7LiBGP8Rp7226XzbtfOHiNKouI16ZCFLIiGaD/hVpOOcX2L7eVQDfLC/8
         KtxiSUQ2XuOZakRklPG0KWfHhMgrju/xSzfJF6VPsuhvNVm7LLs+FR8HPiU1k6lI+UtQ
         1dtckODZ1ohNMeeK3brB8KmLdzXRFJTfj4zj9FeFYeSuwYy+ABD7Dj9YivxIsmhvQGL/
         ip1eyRnzYj5ZyZWxgnibzVRq9EeSnAsF1uHGk6rRUzA6p2W+SHQ0icIUQd2W6ZmXudMY
         oGtw==
X-Forwarded-Encrypted: i=1; AKwUvByd2rhsJ+koshtCyM1iezPoiVM9B1xXAzsMpWayrCku7xrJOVxIPsymy2+bCrt8lngxIMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JY4DrtgS99vQy6r822Ptjw1LRRIF4P1dJVQq9brKfy42Ag4QT
	w9aW9Ofvtl56HU/ewEPfivYS3lwXuxDJI98tabBMnS2iV1AKUDRT+RSTMrUybhHR1aEtuMhhQ7j
	nkluAnMU4BdObOGfCfs/Ga1bSHNZEUaJUdzGGV7mq
X-Gm-Gg: AYBFou2msyTRikaLbwAzsOr4Bu0ZNn3hO1qXiQfJi846h7vYTVml/X0BrzUr3ErVsPZ
	RrCi0X5JctQSezs3CkHP4kph3Abm+Nb2dDQAbPxRsiePjx1ZmDHMxoGMgsBMGDlCnY+oWol18f1
	TYayDBasIg2J58IytS6nUc8GmrMw0UJbO6L6Xm6T80x5eEyMFn4Fopli1GM/zESJzD43ncTrRH6
	bT5tRG+9sIIBrxNZDKX8oR985FX5ohxcT0UXH8wKfg5NvnDrtM5ZhX795QBopbdV6ePz9kcRLAK
	op1vUMMhI2oLxt8/3ifv/8k78ZG4q34xNwkfbpSkeljce/q0Wx3bircz2Ja/VrMRGDaegySw2Ph
	KkVkEFSHl3pD4DH3LCnnmV7s7yjZFat0/v2eOTVKqaPtkdnkdjGRPW0CqWLvUyiYZq+SiT64=
X-Received: by 2002:a17:907:3351:b0:c4c:b560:2a71 with SMTP id
 a640c23a62f3a-c4cb5603d9emr979541566b.36.1793837164883; Wed, 04 Nov 2026
 16:06:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <20261030100215.6f8e0d4f@pumpkin> <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
 <20261104142307.431fc12f@pumpkin>
In-Reply-To: <20261104142307.431fc12f@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 4 Nov 2026 16:05:52 -0800
X-Gm-Features: AclHuK8Z7yNuvzdyvQXTyXXmXbvszi-XVmOSWc_IPj379xX-z3zgWWYR8Kt4UgU
Message-ID: <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:23=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 3 Nov 2026 17:14:26 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> > On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Thu, 29 Oct 2026 15:05:45 -0700
> > > Samuel Wu <wusamuel@google.com> wrote:
> > [...]
> > > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > > > would be different symbols at different addresses. Please correct m=
e
> > > > if I'm missing something here!
> > >
> > > Only that the user might really want one of the copies.
> > > Sometimes there is only the copy.
> >
> > Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
> > pagination to cover these. A prefix query for "foo." also finds the
> > copies when plain foo does not exist (expanded on this in my reply to
> > Andrii's Oct 30 mail in this thread).
>
> I'm busy rebasing my patches - they got stamped all over :-(
> I should get a v3 that applies by the end of the week.
>
> I will add a 'prefix' variant for you.
> The 'next symbol matches' flag is exactly that (actually it is a
> this symbol is a duplicate to avoid issues at the start of the array).
> So in this case that application would always need to read
> the next symbol (by name).

Thanks, that would be helpful. For my v3, I'll keep the lower_bound()
approach so the two series stay independent, but I can switch over
once your series lands, so there is only one search over the name
table.

> I think it might be more sensible (less pitfalls later on) to return
> the symbol number - not that of the next one.

What pitfalls were you anticipating? If the current symbol's position
is returned, userspace needs another ioctl() call and an -ENOENT
check, to learn that there are no more matches. Alternatively,
returning the next position means every call pays for a look-ahead,
which for an unfiltered query walks the module symbols even when
userspace only wants the first match.

Andrii, do you have a preference between the two?
