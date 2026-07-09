Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4D3B8412
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626709; cv=none; b=fAsrqYtcpzT7AZ2lyydjbc42YeUUH7pyiayLxzhxhtAZzwajZ3ae0PQu5x3Qks4wewtNPLOHsjWEqynHuouHM22GFwy42M/lr9E5zr9Z7N4xytQ40DOlLp+DTqOKa0S+UUh/yLo5bw9HoZRpE2lj8TfS2gq3lZzRluhsFkdpj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626709; c=relaxed/simple;
	bh=kBZwb2cRE68I1czVBQGrvfPjZQW9fylv6EksNu1C5sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv+1Hm9lhRuL+7ic6jH903RehlulmlTyULxPxcJ8qat5KQg+OzPWU2vdFss62lfsamB0pOIjYxTcYUShYzogS8iTuyysFBZSQWkRzdRJQ6lgr4COuVULFDcwu7FN48cXXYefYctEvg+vEPcgs28GvFG84nKGFMlXnXgM7tW0s4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCt0doGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCt0doGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F9F1F00ACF
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 19:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626708;
	bh=kBZwb2cRE68I1czVBQGrvfPjZQW9fylv6EksNu1C5sY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OCt0doGXrYzRVeJfu/G9t3TVkpeL0XPF2B6u5RcuM3cR3odlHTd8QdDJdaCJv/gSp
	 5jERAHatgrl7aSgS6t2v6spBqvCio4NEXvSkT1vtEyX3txUM/vbbbb/6wSUqICd0OP
	 XYOPc0a3eBqY0n5BM4v6YFlBX9RMVB4vxxMfd3A8Zw3s43OIenlgUeI20orjLVec5c
	 tyh9MMYZJhToVS65UkcC6h1cIFWs16aYt9TpUDdoZCjDHmIejRwMTRdg4+aDUmJNGr
	 X1R97gzkMMN+yDOLpUFxplAti7qjfSYyG5IXhrAEh6FIISoqxK0d4BnJonirH6U5g8
	 rU+9RsLEgQpOA==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80cebd41372so2525607b3.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 12:51:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpysBmjSOJuWBsYZbgJK6yTrMXCHOQpYzOcAuO/wSoHKdTwQxLoqx5kwY7P9k6zu6AFlDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FVdLgmftcJSEeGHx6gHEETU4fy+F15zy9geS4tXLAp7wzRkn
	v/QXzPkw76ZnflIYy+VRqDEW14W9IVd/8p0yO9MJ4K67kxGI3owo2xLIgpL1xoGaZYKvIEtK7AI
	7XefL9DgNUqAiHXopDOdL4qZnVIEr+9U=
X-Received: by 2002:a05:690c:6982:b0:81d:3b37:30c1 with SMTP id
 00721157ae682-81dbeb62c28mr66172477b3.58.1783626707206; Thu, 09 Jul 2026
 12:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
 <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com> <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
 <fc972c33-1b66-4979-97e9-71627fb6179f@huaweicloud.com>
In-Reply-To: <fc972c33-1b66-4979-97e9-71627fb6179f@huaweicloud.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Thu, 9 Jul 2026 21:51:36 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNgPWwX3dfu=62TSMKeLD8m9S0rc2k9G8rVN7r2SuzQ6MQ@mail.gmail.com>
X-Gm-Features: AUfX_mzRdJWsTfK-NsIC-FwuP0A4MWVi9F1vZPgfsDKDjIV5ebRacxEBUg4UWps
Message-ID: <CAJ+HfNgPWwX3dfu=62TSMKeLD8m9S0rc2k9G8rVN7r2SuzQ6MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jul 2026 at 17:09, Pu Lehui <pulehui@huaweicloud.com> wrote:
>
>
> On 2026/7/9 19:37, Bj=C3=B6rn T=C3=B6pel wrote:
> > Sorry for the delay here -- the bot had me thinking a bit.
> >
> > On Wed, 8 Jul 2026 at 10:54, Pu Lehui <pulehui@huaweicloud.com> wrote:
> >
> > ...
> >
> >>> This assumes a fixed number of instructions before the tailcall entry
> >>> point. When is_subprog is true, the rv_addi() instruction is not emit=
ted,
> >>> which means the tailcall entry point moves forward by 4 bytes relativ=
e to
> >>> where RV_TAILCALL_OFFSET expects it to be.
> >>>
> >>> The tailcall entry is used in emit_bpf_tail_call() when calculating t=
he
> >>> jump target for the tail call. If RV_TAILCALL_OFFSET doesn't account =
for
> >>> the conditional emission, could this cause the wrong entry point to b=
e
> >>> used when tail calling into subprograms?
> >>
> >> This is not an issue, subprog can not be the tailcall callee.
> >
> > Say, that we have an entry function that does bpf_for_each_map_array()
> > into a callback cb(). cb() is a subprogram, so no init of TCC. Now,
> > cb() calls another subprogram that does a tailcall.
> >
> > The callback to cb() is coming from the kernel, so a6 could have been
> > clobbered, no? We're entering a subprogram coming from the C ABI. Now,
> > if the callback calls a subprog that's tail-call reachable, the TCC
> > can be garbage?
>
> Sashiko reported the same issue yesterday. I verified that the verifier
> rejects cases where a tail call is invoked within a callback;
> specifically, while the callback's return value range is [0, 1], the
> simulation of the exit path in `check_helper_call` (handling the tail
> call helper) marks R0 as UNKNOWN, causing the verifier to reject it=E2=80=
=94so I
> didn't investigate further. However, I just verified that the verifier
> *does* accept the scenario where a callback calls a subprogram, and that
> subprogram subsequently calls a tail call. I believe this scenario ought
> to be rejected; perhaps some changes are needed in the verifier,
> otherwise tail calls on other architectures (like x86) would also be
> susceptible to infinite loop issues.

Thanks for trying it out!

Ok, so seems like we need a verifier fix pre-landing?
