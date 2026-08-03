Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9130371D1D
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727605; cv=pass; b=M1Tc5TOHuoECurTcdQQOaoHPR5QcmaENzicQAy9Y9IX77tBGsCjvub5iOli6RSGjfhycqQxthS+1Fzq79QpBLtLMep9MVkoBo2BFpwL42THV9SdlrwlgBGWghaTIcA+Nc4M4KzM5CAx01Xtg+siaEEzSIwzuEEAJryuL/M8vYOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727605; c=relaxed/simple;
	bh=vhyfBHbdbWHsR1dv1Jhn70X4KNYWrkVF9lbJkI6ieFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfXTQuD/HdDSWN+7bq1JIQxJSYe/eds7fNeIxbG6uzmeHPAaydxAjohwDnB8M2k1vp2j8o4ErMXChcDMdb6eDKz6cR+hEaGWieYBRosgFpHVpysPvM79l0SaeLbnzKPzDakle1OY4NnDXwff1+vaZn/b4Y7mTwHC/AtGGeiBKM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB1dYsi3; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB1dYsi3"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8edda5d56a5so30556346d6.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785727603; cv=none;
        d=google.com; s=arc-20260327;
        b=WM5bBArXXuSJFzn31bVNBVdY2sie6diH/S9n2mYiiRPs3nEwJp6L6oOS1Q+uVm7Ub7
         YH2+CQ4x0hItReYsvq9trUMbSuOSYKYXE/Fx+rMQbwBBO0DfPxtwMHjiyyoOfM6TqGWv
         xKRJSEno9kKzLVQVQe1kgqJpMoAbuqm5g2FNd/l2hbsnWi8ETkL9SdIlqT5c/pdeG5+W
         0NRVpIuys8qGAoXtfcWCmpw/DCd0FnFWZUbPGVN8SvLUHdRjpENyzzu8Nl01za88MHqR
         dL+6oWu4CSq/Tm7Qa+rE4AH6QjLwsK4ZFAhIhkviXAdEtN7bCCcpZ1I9dmHf+NqdZt3R
         E9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vhyfBHbdbWHsR1dv1Jhn70X4KNYWrkVF9lbJkI6ieFg=;
        fh=OJhM//sz1dak2s3kpgBY71DELFw51RM/7XWwl3kuhGQ=;
        b=okmGe57XhXv7+NQr+g6lt9ji2vwynCL1kKO7fzf+JCG60zlf04MomSRSLaQ3atT+Hv
         5I4xVvqTCkOk8TQYCzAPPS+Mw3KNFwxFva4wmh862NJIUQie6TKPkzT++by3LxDJ2YzC
         MoTERuLhuCr4SwITJbZPiYYUAxBYRCyumx029EFUTW+SbrmdGse4HkXY2dKKVdzL2znC
         VH7UJb3G/769RrusjFk1aB+Qr9VLDMX1BY42ldrAQ02p/WABCTL+ugM1Z4bjWhYSipHY
         ZsHFvOUY8RhNuZrHBgFAwdPIVSexvK6OzeArFWRXd97bHhTRQmE+QxLftG1T4hUqbzfM
         tdYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727603; x=1786332403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vhyfBHbdbWHsR1dv1Jhn70X4KNYWrkVF9lbJkI6ieFg=;
        b=iB1dYsi3CldFQWXYxBhbl1pbe+FcaSehXoabKr+OQNpz02WPUKbqv+XHO7/MuHk9nG
         k+ZapGNCiYGrrR30fRkzzN6GMPfxnHN/XZYPvsRoWyeaOWBODehjgxpOB5TVJEpWMSg2
         sRKB14rw7CDZtON6xrto7QSkurgeQ3QPUpDDNJOUhOWfoSIrV/4kxoAKypgY2UV5FYWI
         SqsQ7LtavYBiQ0J1ZaQwM3Gwu8+c1dBC/uFS4HyPM0WutdGN9bRplvb4p8ZhiDbXR/6s
         HnRWH8Vqb8PU+tvq2m0o6aIoTnJI8TBeul5GovxVm9kVFMKOePb6p1Da10XNHMK6ir2P
         1BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727603; x=1786332403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhyfBHbdbWHsR1dv1Jhn70X4KNYWrkVF9lbJkI6ieFg=;
        b=M3RhTQlxQeTth6qqQy08XbSwrnXmpfs1uQhs8hnUMl+6F/TljPBk9FptL53n+73w7K
         jMIo7LmLXCpvXLSmEYXFvJMXFXpGK2cRChvg133ZY/C4rGlbFsv/0/YDKOO+54fr0BfI
         ShVsN4VHLe3/Q7DxvSEsmo/9/+eLXm2k/ef+iW09HwrNAxUBv7DbRv8belpNbQuKlAXe
         t5HZPXyCe3e+b3OpY9qPHPyqw2t4qLU31ZoZEEh9EIPAL7YTGm1Iqks5fSbA6RVdoYVX
         tbsT+krtcySGHyzSbhUOh5MQDJuMdEP9cVUAVNRV9s9+3IlR1q//FxctUGrGHFmgV/oy
         0bMw==
X-Gm-Message-State: AOJu0Yx4C0rzNrS2kc55wi0r/AsvAK8/3tLlRIL0M/TGK3xzM4O+KORY
	446Nk+DtSGwiKRf3M+kBwxUiw8RHOIky8NGKYwzwPbjxTrZZ4+6qIfl8JIJnhAlGp6z4n5YzsKb
	HekYxAsVyyxAoIEgvABB0P+SBzjJJtHc=
X-Gm-Gg: AR+sD11bRwX844nC1A7IPcTZl/SWdssyi9IYS9jvH8yH/Jhp39iM8uRp18vfinH8u4h
	HXgXOm9FFC1HLmCxDLWiL9iETibksgmbafpbDLYVEfok+bComEqefLfC2bfp/AUifMBqnN9fZ8A
	VAapLQqVEUun+erAI0xJ45h5//Q96Na6DfGCUqZUDgKQkoDNNtBbCcdTJZvUfloypGPN5cfVXoL
	5eDImnJmceTqqzma8aEoR9WQAGqFzrnfA2E+nAAHBo8+zvGaSPgk14guzB1PfJYRiMTQJtrqFAA
	CsN1xTRfy5DDmPBW/pcJYhW/Coz9u6trOUPh8Cpn7ew2OrjUIRSXh6nufybALPjppBArWY6dfBR
	asqOGVe04uA==
X-Received: by 2002:a05:6214:450d:b0:8f2:940e:2423 with SMTP id
 6a1803df08f44-9084957555fmr158359926d6.11.1785727602613; Sun, 02 Aug 2026
 20:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803021643.2189641-1-dwindsor@gmail.com> <a68933c3-39d6-414e-b869-bb3fd1a6b4ba@linux.dev>
In-Reply-To: <a68933c3-39d6-414e-b869-bb3fd1a6b4ba@linux.dev>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 2 Aug 2026 23:26:30 -0400
X-Gm-Features: AUfX_mw-DL5DvPHWYbydNlCd4ul-kWTX8BLon5qHHGULm9oSnEPggN8CxWBbQEg
Message-ID: <CAEXv5_iKZnDvitaURzcAJDdHHB6H-YwP5MApMeCR64KqXQVRSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links at creation
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 10:44=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 3/8/26 10:16, David Windsor wrote:
> > Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates the
> > link permanently sealed. A sealed link can never have its program
> > replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETACH=
,
> > and holds an extra self-reference that is never released, so the link a=
nd
> > its program attachment persist until the machine reboots, even after us=
er
> > space closes every fd referring to it. There is no way to unseal a link=
.
> >
> > The sealed state is tracked by a new bool field on struct bpf_link.
>
>
> Why do you want BPF_F_SEALED? What's your case for it?
>

For the BPF LSM use case, mainly. There is some language in the
commitmsg about programs not being able to be unloaded until reboot,
but I will be more explicit in v2.

There was a presentation ("Securing BPF LSMs against tampering") [1]
at LSFMM+BPF about it.

[1]: https://lwn.net/Articles/1082111/

> I think 'sealed' should be set before allocating the FD to avoid the
> race issues reported by Sashiko.
>

Will do this in v2.

> Thanks,
> Leon
>
> > [...]
