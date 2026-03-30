Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB837BE64
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889042; cv=none; b=EnARnYcZ7uSrFl8rhsvu/MOLMBWXme2kbnbAXUYRL76K+F94pXhqrwfPyy0rsAREFoCZaTpDAMGZ5QEKcuOJYSx7x0t5dDJF7fm/1t2NfjRlNpin5zmwDVUjazKPvj8MkQgR2Y8Mf9cAFfH2fYCzW6N5kmDCgvR97r8BpGRJD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889042; c=relaxed/simple;
	bh=ZrhF6h3mPSNJGy8KQqQkHtzKHIN+kooyg1QRQ9QjYrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfWB/QYCbcKhLx0zjxZLDmtFsPQuQovCG5bl5Yll1Ss3qehnl6TF/s0QY+5OrDoMfqj2oh4r7OWnURzc4lCXjHU0GsKy1OlXvCKWv4/onKGs4vtHjKdJTKNTsxKVKfHaURqr0jmI/Raex/N6xtCRTpBaAozDX2aHyzAZyksPVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6x1fQqn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6x1fQqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C8BC4CEF7
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774889042;
	bh=ZrhF6h3mPSNJGy8KQqQkHtzKHIN+kooyg1QRQ9QjYrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M6x1fQqnJGP9DGKBP/C/biqzcbZsd5KGHCIkXPbG+WwQaydHlQoAhWWLLpiN6Bo3M
	 gYc32Vw5pjvYQcgfobGgwzT+U7lhjUiZl17NyrwfhLAkjPjeSM5tthRE+Js+X7lSLM
	 kZ0OOvDjOLRmV6IUVYjEciqVw8iuXceTuo6/PAu5UbUhVmYvJlKjbB0pRPBbGUIdyC
	 g+pap6eElQa4nstoz33aSyVUgfiWOu1j/cvrgBZ+LbzEjarUeO4cm8P7iD+UZQYblR
	 wN72DFluAIcOcffMljdFlec/DoVvW3CsAEUwN1yLkM1bAmhSN17hHufCCqFkstG/UG
	 /EuQEghxKgXvQ==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b268fba9aso40960341cf.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 09:44:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzqqmk+MnK3Ib6OA7LBcO7vjakztqpQGWU1cWqa2VqQnGXzHJ2E
	KEzvgaNsjtQlwOs1+dZHu3UWo7e+thyvsoUHI/fOT2+fMFUqielP+hK4bLRYCPe6NcDpUDV86lE
	kyOFnctQz62WihAbJjdB5in8mwTGa94E=
X-Received: by 2002:a05:622a:10b:b0:50b:4778:ac60 with SMTP id
 d75a77b69052e-50ba383f3efmr181618101cf.10.1774889041357; Mon, 30 Mar 2026
 09:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326141718.17731-1-leon.hwang@linux.dev> <20260326141718.17731-2-leon.hwang@linux.dev>
 <CAPhsuW7vwp6pW5RntKC+Gbn5gTcVg3vsm6LVc-y2ssTeauZayA@mail.gmail.com> <d19336f5-5373-483e-81e4-326aa9c7801a@linux.dev>
In-Reply-To: <d19336f5-5373-483e-81e4-326aa9c7801a@linux.dev>
From: Song Liu <song@kernel.org>
Date: Mon, 30 Mar 2026 09:43:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5LKnuZ=wReS+_VtGOs2sefd73a=WUCdaZPho99JBaqJw@mail.gmail.com>
X-Gm-Features: AQROBzBKTLf4GmV83Z4vXPVmGocd0yrwcBrGb6XUFTSmyFGzvFRJfGlzmKPOtTA
Message-ID: <CAPhsuW5LKnuZ=wReS+_VtGOs2sefd73a=WUCdaZPho99JBaqJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix abuse of kprobe_write_ctx via freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 10:38=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 28/3/26 05:39, Song Liu wrote:
> > On Thu, Mar 26, 2026 at 7:17=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> [...]
> >> @@ -3733,6 +3733,11 @@ static int bpf_tracing_prog_attach(struct bpf_p=
rog *prog,
> >>                 tr =3D prog->aux->dst_trampoline;
> >>                 tgt_prog =3D prog->aux->dst_prog;
> >>         }
> >> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> >> +           prog->aux->kprobe_write_ctx !=3D tgt_prog->aux->kprobe_wri=
te_ctx) {
> >> +               err =3D -EINVAL;
> >> +               goto out_unlock;
> >> +       }
> >
> > This also blocks uprobe+freplace when prog and tgt_prog have different
> > kprobe_write_ctx, right? Is this the expected behavior?
> >
>
> Intuitively, yes, this also blocks uprobe+freplace.
>
> However, how can we distinguish uprobe/kprobe here?
>
> At attach time, uprobe/kprobe is recognized by the target perf event
> flags instead of BPF prog's expected_attach_type. Thus, we cannot infer
> the use of prog by prog itself.

Maybe we should introduce an attach type BPF_TRACE_UPROBE in a
backward compatible way:
- expected_attach_type =3D 0, it could be either kprobe or uprobe.
- expected_attach_type =3D BPF_TRACE_UPROBE, it must be an uprobe.

With this flag, we can allow uprobe+freplace when the user space sets
BPF_TRACE_UPROBE properly. WDYT?

Thanks,
Song
