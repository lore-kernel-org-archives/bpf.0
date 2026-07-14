Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECB3905E6
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011114; cv=pass; b=HbaE1oyntdmZ/qNbgfMoY7v1Xc8pg88xxuJ+DCfzJ4sIT8aATtWxp16l4nn+ZhhnWpDOXEotf/CFTRA4wNl/Rm24iLOWo9QKe5+IFr8THRj2X0IOrP7STwdusasXKhya6SgLHQOhKpjubxoig3W9mQIsXr9BxNNHQrT8axuPw3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011114; c=relaxed/simple;
	bh=y8xHWmkJkqubTyz+Whxf6Mqk6P6YdMklCfjtCXAS0DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zv19HgBZcTOtnI2y0yX6zoHfs5ZSBU+29CLixzyHpVPT3zc3vh+XwnC91tkYEv4cC1GgUUeMhklT4J3IhitY9h1HTwOFfGbU+xom+h4rirZ3raoabry4uT3uM9sWAZ+IasT2I0DCDygBK2Xz76zTe9YSJy1VHM5yV5AGygWx8EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCtyWsHf; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCtyWsHf"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-667bae10ba3so668800d50.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784011112; cv=none;
        d=google.com; s=arc-20260327;
        b=reb/y27d5puYeGvYkLhktHh+Ye7ce7RQNDX8tkh3dpEbgGoWrcIhs3eCJeHmVjYxh1
         XQKdvvYoUA5mLjPbhAVlifA3xwIwUVhNSCH/7Dl8DICR6dBIDWVt7me/1mzTh6tCWYv9
         dFb0Nc0hO4KGSA+zOpzA7KI47Ig4ZCCAsyzewEeex14W0+QRrsg31bbgQgqZ/sliAAhu
         bTyubmFZnhXR90xmXWz0esbf4HmvL/bT6WTWY/p0O9Wa278MtKFWsL0u2AOkOTcXsAZS
         GclX1XYUyK6n8aim/PLnALJxW1GBiyEQN8s+a+dbFh/wD3OjVWCnvsY7y/BI2hrSLx/k
         rvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfYwLW4pS/TGI+RDVYXaWxQ3zgK1Q7Yru9JeS97oBl0=;
        fh=LLcMbnA019Fy2M2Z6mkz+S+SyDzsbokwMTt67sbt1pg=;
        b=VmpiCU5ijkNtzU437QnkdjwrxXFKKHv5BNGP65ZKCZit5+PtJe+77kg95utsG+JTvl
         GWQhAWOCTSbh2wt3CYSKEY9amsGqFO1VCiiOGJNbxOZ8CK6UGaQ/+TyI/8/ydBqVC13Q
         NRWayg9yUjdCmknkkehQGfRLfQGEyb9bZrrdU24o4xYFyZBH+bsVOBJCBDdwcYgTmxcO
         MlYHE209c5d+JdCoBnhVJ+nm3w+GlSEIugPMrik90WlZAMROiJ+R8Prg0u5ccF9VZBf3
         vvSnSmM2KDCDMMnrjfa1DTBynRehm3ntMhZ6b7djJLeJbhMEX0bIvuDQzrZ4GR/9c/QE
         gd5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784011112; x=1784615912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfYwLW4pS/TGI+RDVYXaWxQ3zgK1Q7Yru9JeS97oBl0=;
        b=DCtyWsHfFa34WGsH/FU/ot7DL5lVk21Ch+IuYgixgMS4QZv9kbkkyRzqYaBoFEvX4C
         bFcorL8VOrUHln/Gvpjdv+/KUfjoFj/Lojy5roxQZ+cQn2yWNIpEgWdssicH9SQ8lykD
         haxzX2zUNadlg4BEJ+bzMTTAAzPINuCa8Ls51MmfrXccgxxhKZCiI2NTgR6X8MA1U9Ty
         rGAh8DbmKdOdzA8Ru30bTsolChfKwIC/Z27EezlEX1WIcmd8ZEDwGiMb1t7NosDGZnAz
         WwWp+32sQXQoc8UutywqsInzhfmWo1DQ2V4A4gsA3n6NOr6abhr0L73gw3YHC6maGr1C
         z9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011112; x=1784615912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfYwLW4pS/TGI+RDVYXaWxQ3zgK1Q7Yru9JeS97oBl0=;
        b=g+GEf9X3rjoRbDNx/QPrQ4q7ZLU67jvZtqk7FMDUBIrJhlXdeeGYXJcIqWmu/XyO9A
         aplgrQzs5yynRaBWbNCY5QguSR3YUs6t/pFPq1oWcze9Ik2ASKldB1zVQwKRm10BrqXf
         U5jRR/0A3TP4LIHN1gom1608fCHl7UwMscNwv3u4dlyfoGBWC5cM2w0Qi1nSkgqo8VwD
         lngpO0xX3RArPmw5ZkmM9DcRw/470Gsm78J0iw5nTU2nAYRVcpkRJwafcWg1Xk17dXYY
         9pvuEg+1R503sCyFNy28QQaK0BVHa/52WmaCuLZTNuzBOLIN5Sicp+TeObLcsKTJRnZp
         NUiw==
X-Forwarded-Encrypted: i=1; AHgh+Rpgen7huaASzQU+GCJOTpkfV4BFgfnckWAhDKqASBj1TEpsDzs0p6YuKtuAHcMEaPcL/ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQQIYM1TKuIPnCDhdZervNuovreJzY/dHDYgYNqtxsnIJxb7M
	/N7fR4aGEMOoUgQkr2tAbvJAz2J+aVjUyFFe1hFCs75WqcjY02XtgcOdjcjccDp2mUHfRYQORaS
	4/L/+9WpCasB9hjJQsOTdSPETxIpi62Y=
X-Gm-Gg: AfdE7cmkSfxOPfIHt6lAXT1/8G2l4BwXFcnzE/PaPGjAOEkuMUTkPlNcthyocOUYds/
	mH5TDOJZQopJh9KNr0vNaQvLj1e03rkAeEMPqAO1gCISxBAusXZ41g5ML6HfkckUp2m5hNRzRQ0
	egzlGcUSI4qBe/L/y1Uz4pUzohoPqnUVvrtrqV9OwycxGvcJWokOC4TjTkxqXM8WWQCaJa4dBnF
	mSGDm2B5aSBfGSwWX7eJgEPg+9aQZlv3IUGOJjlyXKVjnqZzD86fgAnlShgKTTE3+DmbEgq8Mcb
	aXNhosWCWxPQhZXgW91pt1IjagNeIuL9gF+qGSuZFpK8gQF7y+Q=
X-Received: by 2002:a05:690e:1447:b0:664:ae6a:ee9 with SMTP id
 956f58d0204a3-667d7be0259mr7772187d50.71.1784011112312; Mon, 13 Jul 2026
 23:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
 <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com> <alWsBzShn4sgDRl-@u94a>
In-Reply-To: <alWsBzShn4sgDRl-@u94a>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 14 Jul 2026 14:38:22 +0800
X-Gm-Features: AUfX_myWt_NEQQv-BJRVLkgSebpkvKsdZl_YXe7JCUgTiKFP3vZHGE0QBxAv-Pg
Message-ID: <CABFUUZFJ6N6uC3kJM+qRcMFk75S2+6mTK_+052u3zdscz=DErA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for raw_tp_writable_reject_nbd_invalid
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Mullins <mmullins@mmlx.us>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:32=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Mon, Jul 13, 2026 at 01:47:18PM -0700, Eduard Zingerman wrote:
> > On Mon, 2026-07-13 at 14:35 +0800, Shung-Hsi Yu wrote:
> > > The raw_tp_writable_reject_nbd_invalid test relies on availability of=
 the
> > > nbd_send_request tracepoint, which is only present if the selftest ke=
rnel is
> > > built with CONFIG_BLK_DEV_NBD=3Dy and the kernel built from current B=
PF selftests
> > > config lacks.
> > >
> > > Without it, the bpf_raw_tracepoint_open() call always returns with -2=
, leaving
> > > raw_tp_writable_reject_nbd_invalid test always passing without exerci=
sing the
> > > checks bpf_probe_register().
> > >
> > > Cc: <stable@vger.kernel.org> # 5.2.0
> > > Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > ---
> > > Not sure if fixes tag is the right thing to use here, so use the cc
> > > stable tag instead to get this config change propogated to other stab=
le
> > > branches to make stable BPF CI's job easier.
> >
> > Shung-Hsi,
> >
> > Thank you for figuring this out.
> > I'd suggest we switch to bpf_testmod_test_writable_bare_tp() [1]
> > from the test module to avoid the config dependency and let
> > Sun pack all of this as a single patch-set to simplify backports
> > (if such are necessary). Wdyt?
>
> Make sense, that's probably for the better.
>

Hi Shung-Hsi and Eduard,

Thanks for tracking down the CONFIG_BLK_DEV_NBD false
pass and for the test-module suggestion.

I'll fold everything into the v5 series:

1. Keep only the necessary effective-start check in the verifier fix,
dropping the BPF_MAX_VAR_OFF and size < 0 checks as Eduard suggested.
2. Move the attach tests to bpf_testmod_test_writable_bare_tp(), use
subtests, and remove the NBD configuration dependency.
3. Add the PTR_TO_BUF negative-offset verifier case requested by Eduard.

> pw-bot: changes-requested
>
> @Sun can you make sure to include the follow tag for [1] when you send
> it? Should give a better guarantee that is will be picked up by AUTOSEL.
> Thanks!
>
>   Cc: <stable@vger.kernel.org> # 5.2.0

Will do.

Best Regards,
Sun Jian
