Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8631E84A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319700; cv=pass; b=rrIL9brVpPYkYtGMz5kMkM7vjfnsFzRIeh9uOPREQYb3689x29KhI1/0Qhgto/2gMeQIL237w2PqViikK4ZhGCsDBK45MHloYp4m0ouiH7f44dI53KkOZezhGgrFFgeMReqgmwEq81swSKM37ezd10JYL0j25tejGa4Q5B7mOkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319700; c=relaxed/simple;
	bh=D1dDY+PxqiBKFbSG6nmxEVOa3WMHNTh5EZ8F9r4yzQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzsvNImPdGDhKOZgaOAYB0uSrfx3X0sl07O63R+2GPUvSCdfxcJj/ZwhrkLofU7x8bqwwyqA4WSGHDYzqJ3OfV04gSeX4V8+3GZuMZz4sz+G7CX0b8BbBX6rwxE01GuMzkteBz7lD6BwfIiWk1ewo/P3IlrnZ9vuXVVrtAJ3V1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tB0nNIO8; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB0nNIO8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so854154a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782319697; cv=none;
        d=google.com; s=arc-20240605;
        b=DxZbTjm9zWvAeWDETlCRpYblo7sv0G/jNBxtqWGSfYP40JlOJSnhCF/70SI4vc4gaE
         r/uGvD1SOfDTh2cZWWFroWScLuKf99M2qwlUaaSMcZUXUVTtV9l5FWTw3j0yt12UrWxu
         sF5AwELDosAIOAb/3KU0G0Ohj9wm/O7R2lWbjSkZ9kQ8aI5zEo75Tcpv5Yunpc/rWEiI
         AJJ5xuXgAmfNQABud0k4L+YpZoZCVPUZ3325iIrxc8BxWmyQyxuMHtuwBgDTctmNxHDV
         L4WHJAYwNpGgQqGaZQ1awfYwKqeMISrDTTy5GRxD5xI/xXcNbNDcovoj5CrxWJjuMO+w
         A87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W03tYUTCql9OC1n8+t5466/i+LRzkumE2EIqxm2Qnew=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=N4nR7pMryalqHufNcYEuvH0xvYSxmWuzzE7HHmPltqOYDCV1DaoN8oh45K42fUswWi
         MvPtlb6InuG+Z2P/wOHTp61K89rgY7rOyi2iCZf6O2gmEc2s5U2Zu5scFmwi8dZucHrv
         d4P6mcwJYzR1FgP9U5QLu6T/2P1Jg9ga5MNnQ3ENZlX195S9dZ9NiAzXFLZc6oD8pddQ
         JHMTvkeu9Up78sZugHZuheTTMMqWUADW74ius5HR8Ix7kIb2KMc4M5qAN6Deh3o55Obm
         9paBrCtw2Lci92a8RkDqJLL1kBgrTRNxHMjAk4UbplFNwlIybWrPc0LhvXtV1rcjuFLY
         ZgMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782319697; x=1782924497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W03tYUTCql9OC1n8+t5466/i+LRzkumE2EIqxm2Qnew=;
        b=tB0nNIO82BBgMwDiW5BsSYPK9GDMKyS18wf18771qxeileK/HxqJhdgyx+ZxmUIAzu
         7+rZFKGQCpLXTV47PBlAgMbyBQok16jhU6OKsCCMe6t/q7St0a1QRFaskhjMIUzTALca
         oh7InXVVoX2QsH0pp6FCgvjq2QHPmLkcBAXWlIvgDrKpgjsa5UiBMUyBy6As3rGcxgX+
         WFac+rBLjQAMvZiwltklmouQa8tNleuNPHDno5LP1h0S9ZgTmrG1zgA+96N3XQHvAZpn
         S8Ev7EnIlbpjfjkrO6K0AdW5wUez6yCWACzAzlnX/78UQnPtQQIAt5eOo/CaL/ESKT/M
         IcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319697; x=1782924497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W03tYUTCql9OC1n8+t5466/i+LRzkumE2EIqxm2Qnew=;
        b=FbGDPl0LvLkaH5RUzZqKzJVczN6hitEN4Dm1+GvpuyHZDeYXrN8hjh/pynCfapZ/rA
         QkkEIGNiEd5E0wA2Bcak9nlG/9V4G6DUnxp3nPKB+bBUZ38nBa/OWW4WRZkPgUtDq9dL
         9eeoGIT/kI1H87ZMvr2H+6rofNvLm/njIMR7zRbGzlQX4zYBCh+rvodY2C4QHt93TCKP
         YyiVJrr/ZVieVixYJCcpp9FxDsaPj6pyr0U1mFOrN8CI/8O/0Jrx09kDd8YUwRPdKF4t
         B76uqbmKXfS0JHqMfmG91YoTOt4h38M9vW0ZE19gKXF6PSAYf5S0lXN02VGkLCJIs8YQ
         YWJw==
X-Gm-Message-State: AOJu0YxeHnamCtByXMRaxz+FFk3hT7/htyreZtKmUfDdbXeHOmyKlkob
	zAMNzQoUXh+/2t73HoQSnyTGHOf+JLI5ZDFfKManZgUyUjRai3ifIaksm6hA1ZiSfR79FUfiFrY
	Beb67fLA7L+23vfoPiavNtqXsz632yYE=
X-Gm-Gg: AfdE7clNl6RE8Qh6BiXcG1O/feJw+TkKFCmKc9I42I2iP5TM4jcSYhJgDOwKKsukwLb
	XwGRx7D+hMVmutwj4FzkwbQq1HHDkbBIFizZX+kOxl5O2VBtMrd+9QIRrQCtl3gnnzeuH37X9gx
	PPsrodeu051VwypYh+2YAkFqL+uiOk91R4zcQNytO9IAi41tC0sKJZLenYtdvmkCrSQ6n67Lotg
	NDwCQMMDD3Th7OeCP9VtiyNNzfxA66Ihss5SJ1+MM2eOOwCFply154P3HbLV5IGN+9BGl5+IdpX
	J2Z1ipm+awGwUGhQOKOjkHgkBq6kRK4J4CER4CAFjgu7T6yLqaM6Aez3kqSqTk/hfzM=
X-Received: by 2002:a17:903:1d0:b0:2bf:3309:ecce with SMTP id
 d9443c01a7336-2c7e15804acmr44655155ad.28.1782319696656; Wed, 24 Jun 2026
 09:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143557.22955-1-leon.hwang@linux.dev> <20260622143557.22955-10-leon.hwang@linux.dev>
 <CAEf4Bzbmj-ekwYQ6oGW-BRnzLBDvWgLyn_QsU5g1yNt_8A0H3g@mail.gmail.com> <d6bd1b3c-17eb-40bd-af02-e7135db07fd5@linux.dev>
In-Reply-To: <d6bd1b3c-17eb-40bd-af02-e7135db07fd5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jun 2026 09:48:02 -0700
X-Gm-Features: AVVi8CdKhrk157vucbetxQ_xx2ozhEEUK-qKqre-NlZyb581Wr69_5EUbHkA4Ls
Message-ID: <CAEf4BzZHC3_oyWyA8zC-ogNFktsGFd35Stst5bswO05O=dL+Sg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 09/11] selftests/bpf: Add test to verify
 accessing rdonly percpu_array
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:16=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 24/6/26 06:46, Andrii Nakryiko wrote:
> > On Mon, Jun 22, 2026 at 7:38=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Since percpu_array supports direct-read, it should not break accessing
> >
> > what does "it" refer to here?
> >
> >> rdonly percpu_array.
> >>
> >> Add a test to verify that adding '.map_direct_value_addr' to percpu_ar=
ray
> >> won't break the case.
> >
> > what case?
> >
> > I think you are testing (read-only) direct access to read-only per-CPU
> > array, is that right? Just write that out? Though, really, negative
>
> Right, will update the commit msg.
>
> It was to test the change of patch #4:
>
> @@ -6113,6 +6115,7 @@ static int check_mem_access(struct
> bpf_verifier_env *env, int insn_idx, struct b
>                         if (tnum_is_const(reg->var_off) &&
>                             bpf_map_is_rdonly(map) &&
>                             map->ops->map_direct_value_addr &&
> +                           map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY =
&&
>                             map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {
>                                 int map_off =3D off + reg->var_off.value;
>                                 u64 val =3D 0;
>
> > test (we *cannot* access read-only per-cpu map for write operation)
> > would be more trustworthy for this...
> >
>
> Makes sense.
>
> I think it is worth testing both positive and negative cases:
>
> 1. (read-only) direct access the data of read-only percpu data's
>    percpu_array map to test the above change.
> 2. direct writing the data of read-only percpu data's percpu_array map
>    is disallowed.
>

both is even better, but negative test is testing a condition that is
hard to miss because you won't try to do that in practice )

> Thanks,
> Leon
>
> >
> >> [...]
