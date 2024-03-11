Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD0D516
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139373; cv=none; b=uSX2XwIE+9EtRbbW9WFtmRZO8tu61cxwLhK6SyPcXz/ZdjCIG3Nnf7pTGZyvUzSx66gbf+wvziLGsMKXrMuSoERoLFG/mzkVshCxsMdng2hbK98axX+sIKkFHbnFscmy5aOCIfBQxHs8V6qtKbJheMTOiisF+KYnfI8ZX2vXurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139373; c=relaxed/simple;
	bh=X5qz9Wi4uBq7D4n7eDIWIgGHVZWH2iYo30BLX+iEMuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MORGhZgVGeaZm4Jkpao5CUTF2yg0F4jUEsmgjpCrZZVg1Z8WxkJ7rHl8yM9NnA4nFgfgK+NgnH8qwqvZ3M1iL/W3/+Lz1T0qLXTxPjs3LJ9FDObtgMvWAbsiRhjJAcpPfumC4+yhaSAdQafS9ElLmeuiUqc5nOZuYE+yClamFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeTDraVT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeTDraVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B00C43399
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 06:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710139373;
	bh=X5qz9Wi4uBq7D4n7eDIWIgGHVZWH2iYo30BLX+iEMuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qeTDraVTTf+ACqxXrDDimzU8Nh4CnUfoK1WZtlJ18mfUvkUo+uqgqSNOssx4EzQM7
	 aJ4BAYMvZCZwVs5xe4bozsdcmZpU9wl+C0Uc8JDHaZpT4Nju8nprGzuz7amcOOfNBc
	 /1Nf5vgxgBx8J90D494O08kzbcx/AfrukIxD6e9lah7bBY4n83RjgQsK1g5/N5mX4i
	 iuQbGBbWpS02De89jKpMR+nWrql9OCpYlVno9PEaljteUeWyEPMXwkitLVdH4U/Wja
	 jieVZofB2Kfo8kvWxwh2b5AjxqqS0J9jhd/QRRrybwVDgShnx0/w2qAWzBi1hDG/4c
	 I7L09zckSfldA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101cd91017so6581945e87.2
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 23:42:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVDoRSOsOEGAPtVnYk5eyywqiqVUexAdrzmyH7JctU7A6GGK9zyEGqOeloWx6qGNpXd1fAs1juLTWorye7s4n/Y40H
X-Gm-Message-State: AOJu0YwnDO+VZdFm1/Q8CX+16r373+MHezN765UBBnL7pvRQlutI37DQ
	9pROchoD12mrrJpgEzCyTWi7+0MRRW6Gnsth2SqBt9H0iCEXlP8z70qzYC1uUCSF2UT3s9PO2FA
	45AByG6GRkOqAUxbv9EZaELk2ZRs=
X-Google-Smtp-Source: AGHT+IFRvN4GnmkKCHuiRRRDivtgUw11BSzhv9eBjtFFiLCjPwtxoIH9/kVamdN69E8+WDuN3wpWoUEIthHheticPz8=
X-Received: by 2002:a05:6512:1091:b0:513:aef9:a7d8 with SMTP id
 j17-20020a056512109100b00513aef9a7d8mr546945lfg.47.1710139371237; Sun, 10 Mar
 2024 23:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403092219.dhgcuz2G-lkp@intel.com> <CAADnVQJ+6mFs56fu+KEvumQ5uqM-oLpYx0hGxLJfE9XUCtEWEA@mail.gmail.com>
 <CANk7y0gT8bvKuhJvxG1yLTxdRycMKNEBtgEv_PsCA56Nv74cDg@mail.gmail.com> <CAADnVQLXFWDDV8xGLVRNd9JXaqOMfCO3ZGtuQUg8CZjrwLjxrA@mail.gmail.com>
In-Reply-To: <CAADnVQLXFWDDV8xGLVRNd9JXaqOMfCO3ZGtuQUg8CZjrwLjxrA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Sun, 10 Mar 2024 23:42:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4=OPS+MgbsnsJM=pJCj64vg2xEG4MUq3hufWBkNDr-1w@mail.gmail.com>
Message-ID: <CAPhsuW4=OPS+MgbsnsJM=pJCj64vg2xEG4MUq3hufWBkNDr-1w@mail.gmail.com>
Subject: Re: [bpf-next:master 5/7] kernel/bpf/core.c:900:5: warning:
 '__pte_index_size' is not defined, evaluates to 0
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, oe-kbuild-all@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 7:43=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Mar 10, 2024 at 3:05=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > Hi Alexei,
> >
> > On Sat, Mar 9, 2024 at 5:38=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Puranjay,
> > >
> > > Looks like I have to drop this patch for now,
> > > since PMD_SIZE is not a constant on all archs
> > > that can be evaluated by a preprocessor.
> > >
> > > We need to find a different way.
> > >
> >
> > How about we define it like:
> > -#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
> > +/*
> > + * PMD_SIZE is really big for some archs. It doesn't make sense to
> > + * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE t=
o
> > + * 2MiB * num_possible_nodes().
> > + */
> > +#define BPF_PROG_PACK_SIZE ((PMD_SIZE <=3D (1 << 21)) ? (PMD_SIZE *
> > num_possible_nodes())  \
> > +
> >                              : ((1 << 21) * num_possible_nodes()))
> >
> > So, it will be computed at runtime. This adds more performance
> > overhead but this is called very infrequently
> > so shouldn't matter.
> >
> > Or we can hardcode it as `2MB * num_possible_nodes()` because
> > PMD size in most architectures will be 2MB or larger but never smaller.
>
> I think hard coding is cleaner and less surprising.
> I'd like to hear what Song thinks about it.

Agreed. Let's just hard code it to 2MiB * num_possible_nodes().

Thanks,
Song
