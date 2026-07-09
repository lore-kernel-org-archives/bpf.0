Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7093B893B
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597068; cv=none; b=EOG04Ksw5/YTCpxgB9EXWXjJbvrZZh7HaKUvZ0M2vRHBAIw+sxE58JmP2kR8ARXsQDFGpz5cBhAHtVCthtHcEGpoxhYzDnsC/M/CVaILi9oVDtZpdu5tkDbr2lMFXVtFySQEA7VXgUxtHyOTuOtRwJ1ilWwBTCNlxaE8870lp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597068; c=relaxed/simple;
	bh=Yz412YS1mm3028gqttBvo2HQF+dXMccepgPqvi+nG/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5DvEvPHVMqzG1m59GCc+IyYLPTvXPuqIDNnhCc63vjUTatqPDC0I5rBkMyvmoCy9dzRudC9G3oYnWElJpz6foyVYlhT+Ri+Fa/PdvMe4qt4922XJbP5iMgoJG7WANd6KUaoHGCHa91RMGXuQfOqwZcxlyhab26HLdkMsMFy1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwh3Wc60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwh3Wc60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAB71F00A3A
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783597058;
	bh=Yz412YS1mm3028gqttBvo2HQF+dXMccepgPqvi+nG/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mwh3Wc60ZclGeeZRtmxqpXnlEfYOISWMc+WEL7+2ZGunYhK0WHmoqJMrMMetVJ9n7
	 fxqtQGmKG0y837s3iKhHu+lfgYEIZ2myMdkm5nu2vm+6GwQ7C9FTmGkP790SJn2DOp
	 JPD27DnMYrLYxqt44QACkjFc4/OgZb51Mv4hjH+YWYEAGiu89MyaYXSSxrOqAO7al0
	 SKZJDxncm44wcZYnT6+m5gtbq7O6ynotr8Q523I3s+zH2VLAxvJt9uEpjl42YyiC/C
	 0IuqLAFpPaRadzNcxAa6Kxle4VpWTGBDfO50ITsfbLN4NyVYRkWvOg93Zhe5bR5qaI
	 DattWSKOud6Rg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e771226b0so774627b3.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 04:37:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq86TseasHAcI55HBrzDXqXlLEUcv+g42RgyNqWUYBvgy9R8Ts+uDdjzuucGbRR5Me/BBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXDJ/Pc9WRc2v+yQ2CcsUoeUMMpyH9laxCFMvZQG6jWjIufwK
	VxrFXG8KD1csQXpLJTtNW2pvfyvLc/EX9n4NrCleCYoQXI6QodbuQElO0MwBWnOTcvA0xStdLHv
	NxsHlmv7/fIEjxzAzP2EQu2nCLr2la0M=
X-Received: by 2002:a05:690c:7288:b0:81c:7f96:591d with SMTP id
 00721157ae682-81dbe553a1bmr51674577b3.36.1783597058167; Thu, 09 Jul 2026
 04:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
 <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com>
In-Reply-To: <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Thu, 9 Jul 2026 13:37:27 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
X-Gm-Features: AVVi8Ce8nk2IlpXpBJGjqQ3IJKRb90NHUVNDXbkho0Wnz5Bid6O-iKdNzIa3RjM
Message-ID: <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
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

Sorry for the delay here -- the bot had me thinking a bit.

On Wed, 8 Jul 2026 at 10:54, Pu Lehui <pulehui@huaweicloud.com> wrote:

...

> > This assumes a fixed number of instructions before the tailcall entry
> > point. When is_subprog is true, the rv_addi() instruction is not emitte=
d,
> > which means the tailcall entry point moves forward by 4 bytes relative =
to
> > where RV_TAILCALL_OFFSET expects it to be.
> >
> > The tailcall entry is used in emit_bpf_tail_call() when calculating the
> > jump target for the tail call. If RV_TAILCALL_OFFSET doesn't account fo=
r
> > the conditional emission, could this cause the wrong entry point to be
> > used when tail calling into subprograms?
>
> This is not an issue, subprog can not be the tailcall callee.

Say, that we have an entry function that does bpf_for_each_map_array()
into a callback cb(). cb() is a subprogram, so no init of TCC. Now,
cb() calls another subprogram that does a tailcall.

The callback to cb() is coming from the kernel, so a6 could have been
clobbered, no? We're entering a subprogram coming from the C ABI. Now,
if the callback calls a subprog that's tail-call reachable, the TCC
can be garbage?


Bj=C3=B6rn
