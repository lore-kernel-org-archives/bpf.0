Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7531DF74F
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206050; cv=none; b=AkbrGtnVtIgsduqqCnv5nLJlwufk9m7ZPLcImf6PLpaJYGl43x+yqRqtMHj0NkrBEwwUAkPOEcN29SJBpqcSR2Zr8rquo6RiaPplq2L2DDMqiL3oLhg4wO1GzCgMe+gOYiuwzYmGMSz0yke592a/9h3hNsO7w1MUoMKmxJJQfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206050; c=relaxed/simple;
	bh=XubzWqdHpQ/bhOAx5TOL4pzvmktIfaL3BTFx+vctpsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4ft1+UKYtApyoEIJNiW9SFH3USVJZjUVAEON11xltzFBHkWW+2lr+JC9KN94lcy9IyxWOfyts/A/0AOsHzatA7a0JvGzlgIXJCL5ukdl0CJghT+suMNi9KjuRK0MJBP2Xr2bzoBDwsZln7XJwLC8E4Jxm05gY/qp8H10kjON+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omWoC9D/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omWoC9D/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E80C2BCB5
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776206049;
	bh=XubzWqdHpQ/bhOAx5TOL4pzvmktIfaL3BTFx+vctpsY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=omWoC9D/jZPk0MYLKctBuH3Jg61IgyWzpYSXZP5sH9NDtVR/TSdpf1OpkLlzqNY34
	 Ah/ctPMsboLFYYX0fuSbc24HJgdW9Zci+fbBUug8wmSDJxCcg+jmwJlqRKy+zuL5cq
	 N8B4AwbZoGhU6zfXWSlvjpXuWdhUUEuqsrTRYcXeKSW6L0HNSOM7hD1i1d/oXxF8Hc
	 reyPBZX+J7I1beEQ0O5p2KLNTu8Um1mx8FIR1LvGb72YmIvksZqZSofB/zRD7mnTIw
	 0J9Dsz7r7q9EiK1qZH0TITVnRqqFtZh/MfQZqMzvkwCUWva9tfNh/GIEBQAGl5h58K
	 PbIxpbXjXCxkg==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a15ebb3abbso87074636d6.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 15:34:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8vllEJri4SzqtCi55Q28hrkr/9DVL3XPf5S9DbgOexGnc4hey1JmnUtfXlxtspT6hb98U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNP12r7T18x99DGDEraZccml7a7IjmhlnjGcbr8iupT3P9eVY8
	2Ut9Q95RFPpm3bNdWeZxvKlgFFCWTB1Hs764OTCk9KnJ91uKmh0JfGrp5USLBGPFdHobovQtUY4
	lvTWeZiXkvNlsgd7m/BtARz0B+aWpkmU=
X-Received: by 2002:ad4:576d:0:b0:8ac:a6f7:8a68 with SMTP id
 6a1803df08f44-8aca6f79762mr187533976d6.21.1776206048611; Tue, 14 Apr 2026
 15:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org> <CAADnVQKMyGyw6vYVPVgT_G-CfbabARTiisd0dKV4U+8SY3qcEQ@mail.gmail.com>
 <CAPhsuW4uCU0SitRErVGr9B3RA9_MCxtGopHcpyZzw-Nm46fGEA@mail.gmail.com> <CALOAHbBRVbGEm9ueoxTR4ToxPEvW9U2=8PRxfSWpotf_AkRfmA@mail.gmail.com>
In-Reply-To: <CALOAHbBRVbGEm9ueoxTR4ToxPEvW9U2=8PRxfSWpotf_AkRfmA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 14 Apr 2026 15:33:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Z2OoOQyFZYdViwzZ65sVxWtT7YMVr0pCX1VDUhJhnAQ@mail.gmail.com>
X-Gm-Features: AQROBzARmRXYKj8_mO2dGelBMH4mq1pmm7cmvAWS9ABLdg_4Ro3Aa_IuouFUA8s
Message-ID: <CAPhsuW6Z2OoOQyFZYdViwzZ65sVxWtT7YMVr0pCX1VDUhJhnAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Tue, Apr 14, 2026 at 5:43=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > On Sun, Apr 12, 2026 at 2:02=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > [...]
> > > >
> > > > This shows an alternative solution to the idea proposed in [1]. Thi=
s
> > > > approach doesn't need any kernel change.
> > > >
> > > > [1] https://lore.kernel.org/bpf/20260402092607.96430-1-laoar.shao@g=
mail.com/
> > > > ---
> > > >  tools/testing/selftests/bpf/Makefile          |   2 +-
> > > >  .../selftests/bpf/prog_tests/test_klp_bpf.c   | 109 ++++++++++++
> > > >  .../selftests/bpf/progs/test_klp_bpf.c        |  26 +++
> > > >  .../testing/selftests/bpf/test_kmods/Makefile |   3 +-
> > > >  .../selftests/bpf/test_kmods/test_klp_bpf.c   | 166 ++++++++++++++=
++++
> > > >  .../selftests/bpf/test_kmods/test_klp_bpf.h   |  12 ++
> > > >  6 files changed, 316 insertions(+), 2 deletions(-)
> > >
> > > It looks good, but takes 1.6 seconds on a non-debug kernel.
> > > This example can stay out of the tree.
> >
> > Sure. This is not a typical self test to begin with.
>
> How about adding this test case to
> tools/testing/selftests/livepatch/test_modules/? It would serve as an
> excellent demonstration of how livepatching can be leveraged for more
> creative kernel extensions.

I don't know whether we want BPF heavy code in selftests/livepatch/.
Maybe we can just add the livepatch module to samples/livepatch/.

Thanks,
Song
