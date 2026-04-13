Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C5395D9D
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116611; cv=none; b=izbrWx0NB8XrhtyxEQG0lOWrtq0QmzYRtELPKR+cGKS/5oFC011c+9UkOUln3aHLWdfXse3UAJHgpXt7VahsUaV8piP/UJvzGcto7d2IB3LOFdVCUQKZmxP4ZyKfT1ChdupBAnUuo2gx2nswehtH/I4o2F4K5AsPp/PWOKvPbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116611; c=relaxed/simple;
	bh=PPuI7UMHBNPYvWyE1slim5/MwsnFqz3RSJoYkg3rq3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cutXQu9URBi1hfti5UC/V+8im219ylkpZpzTdV+XNeFXz+ciMvFTgHPMtlAsVI3N2JIL9LfG62NN6xp32xxF7vQg1Y1p2oxmC06UZjNsy+xZHH2flY5nBBmd43/xIWKTWreghycXZJrVQZvUb8KdyAfOYTgprtg7oRoKYGZq+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnhu6jX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnhu6jX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267A8C4AF0C
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776116611;
	bh=PPuI7UMHBNPYvWyE1slim5/MwsnFqz3RSJoYkg3rq3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bnhu6jX5NNRVIJi4Y1gSDiT9iyWrTVuKkEPGP0GF3qISUWEFInWr8xAbniAD+QZMz
	 3Wk9HJXNLiDf1Rb6dU0nLW5HbxiRidcc3EqYqMe+XGqS9FzsH3xVUT3VPF1wyqF/vi
	 BmXUHDwx8jJSbxPzuyocmr+zWG4aCoKdXMRpPkYOwaiIR4EsFXZXst7oMA4qhzx9pW
	 g22MNGe0W2Pk0DQa8+yq8e/P45kT4Out+UxGm71fJtcxsPHCKShXLK8ZcImOc7BMzS
	 WpX23EbIHflxxsNcx/f2HjWr3MMdqPj9q5rsD5Q54d3ARGzPNjwvv9Cr8jTgzT67o0
	 u1ai2ExxgrB7w==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a3342d301aso50232296d6.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:43:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyDaLtmOKW8KjNDIPaFNKnnVboFOTbG2mIIaCJNYfP2kZ+9QDLr
	038acUDy1+wv2+VmA+teg20g5smF8k7qwvi2Ej3Qzh/jTIQd6usawmA9A1vmfVg0aj9NoGhersS
	FIJF1yLE/AYEFa+TxjiwufYepLyfBsyo=
X-Received: by 2002:ad4:5bc1:0:b0:89a:98:ff1d with SMTP id 6a1803df08f44-8ac861b63cemr244813136d6.20.1776116610349;
 Mon, 13 Apr 2026 14:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org> <CAADnVQKMyGyw6vYVPVgT_G-CfbabARTiisd0dKV4U+8SY3qcEQ@mail.gmail.com>
In-Reply-To: <CAADnVQKMyGyw6vYVPVgT_G-CfbabARTiisd0dKV4U+8SY3qcEQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 13 Apr 2026 14:43:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4uCU0SitRErVGr9B3RA9_MCxtGopHcpyZzw-Nm46fGEA@mail.gmail.com>
X-Gm-Features: AQROBzA4yZkuwuYblYp-J9lcbpfBtxVAnlVox6W9wBBXHBCVKAPugLoLUb5sBsk
Message-ID: <CAPhsuW4uCU0SitRErVGr9B3RA9_MCxtGopHcpyZzw-Nm46fGEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 2:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> >
> > This shows an alternative solution to the idea proposed in [1]. This
> > approach doesn't need any kernel change.
> >
> > [1] https://lore.kernel.org/bpf/20260402092607.96430-1-laoar.shao@gmail=
.com/
> > ---
> >  tools/testing/selftests/bpf/Makefile          |   2 +-
> >  .../selftests/bpf/prog_tests/test_klp_bpf.c   | 109 ++++++++++++
> >  .../selftests/bpf/progs/test_klp_bpf.c        |  26 +++
> >  .../testing/selftests/bpf/test_kmods/Makefile |   3 +-
> >  .../selftests/bpf/test_kmods/test_klp_bpf.c   | 166 ++++++++++++++++++
> >  .../selftests/bpf/test_kmods/test_klp_bpf.h   |  12 ++
> >  6 files changed, 316 insertions(+), 2 deletions(-)
>
> It looks good, but takes 1.6 seconds on a non-debug kernel.
> This example can stay out of the tree.

Sure. This is not a typical self test to begin with.

Thanks,
Song
