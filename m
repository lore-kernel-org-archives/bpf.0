Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E433DC4DF
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891239; cv=none; b=ZzQuxLIYF4uf7ws48OYX+uPvLFr40w54QFKEe7ENCX55NxXgjvVm1bKl7JBIHK5gONGFmjAlYO2VMCV57KZhZmwc7yQ7a+JPt5ICS5BGnIkF0eJBuimJtGxGggHk5fX65BluolLiQE+7p4KYay3EUVpVmxOrNH6LS95NSKE1/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891239; c=relaxed/simple;
	bh=QbvnqIYMjAqN0+w6Iq2D7nQDlavnRq3MlFyBS5NkTRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKgCYHQe+TdI7B+4akcDN0k3CkyBPa1dNc/fVTQB8NhSHVb2lozUg/74IQxYOKT+zdfKXu0XEapbsO+GFCiF+CW6sWQm1Y4eWyFHJBqxHj8DKNjFJnJGQ2hsx6BShkACEDiCZ8QgEPNTHr1inoRcf7RBH5Pk4gwCxvyjHT8yjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+5yoLY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+5yoLY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2939BC4CEF7
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774891239;
	bh=QbvnqIYMjAqN0+w6Iq2D7nQDlavnRq3MlFyBS5NkTRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N+5yoLY+7yYYsGkoypxiOtBhreTX/dZnoenLCQ/RMXMU+h1QGJ8SNKoM8XDItJ/iZ
	 PRv8W5tsxfvkbYEbazDIcW+HtWIMN2klL6K8N58B4iNvU0/TW+TlJBnjQgCTmHRiDc
	 iH/2lwn8ycZgwZ0NdHfAXt7ajAfpo6XLFBLPfuC4tOygSUZhZRirIvdvSx2fC0kJRx
	 nSsJfabiPc6FXlzKTr91Bq57zlnnnt8bTlnn7rkbQwJm+ncLXSCmcM9DJf2q5/qLIH
	 lZwaDF0xwQVcs916x/auxpCGPalMz1WMyShfMKnumjL/mANxmM7B72Q28npeDHa38w
	 i5XsvjJkWsUwg==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89cc71f4311so56850086d6.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 10:20:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3lCw8mmmviEfdoETXwTPycI0cQBZirPxFaWM7fnn1nDFiZo6f4qEoAEGdv2bMaPPzYfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKnmoDIi1Ufgj462PaukRX8BogN4w3VuKY8O1/sbniNFNKruJ
	DWrEaGWZ8ak6HW9uEIV74W2vKwjOGwoiJWfACqby9ANmqGV2wgazDUfEaJxZNW8BrzZ5JIwnHdM
	HfYhlaWTX5osuZ/c1iX4XWTG7uPvvL/Y=
X-Received: by 2002:a05:6214:8111:b0:89c:8769:1d09 with SMTP id
 6a1803df08f44-89ce8d57c70mr173878406d6.5.1774891237343; Mon, 30 Mar 2026
 10:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326141718.17731-1-leon.hwang@linux.dev> <20260326141718.17731-2-leon.hwang@linux.dev>
 <CAPhsuW7vwp6pW5RntKC+Gbn5gTcVg3vsm6LVc-y2ssTeauZayA@mail.gmail.com>
 <d19336f5-5373-483e-81e4-326aa9c7801a@linux.dev> <CAPhsuW5LKnuZ=wReS+_VtGOs2sefd73a=WUCdaZPho99JBaqJw@mail.gmail.com>
 <CAADnVQLVEoytOJT4kVAcnzKqEJk0AhGxPCK+tMTKwpK_DJ32sQ@mail.gmail.com>
In-Reply-To: <CAADnVQLVEoytOJT4kVAcnzKqEJk0AhGxPCK+tMTKwpK_DJ32sQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 30 Mar 2026 10:20:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4H6VJOAQZuHzoXpi0yL-6CTVdv5AYzzQmu9Vf2PCHZvQ@mail.gmail.com>
X-Gm-Features: AQROBzCAGDlh6cYheeiUIpta1eguOtJHM9Ii3I3erWVZ02Ro8V_LrhJXCckWLjc
Message-ID: <CAPhsuW4H6VJOAQZuHzoXpi0yL-6CTVdv5AYzzQmu9Vf2PCHZvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix abuse of kprobe_write_ctx via freplace
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Toke Hoiland-Jorgensen <toke@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 10:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 9:44=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > On Sun, Mar 29, 2026 at 10:38=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> > >
> > > On 28/3/26 05:39, Song Liu wrote:
> > > > On Thu, Mar 26, 2026 at 7:17=E2=80=AFAM Leon Hwang <leon.hwang@linu=
x.dev> wrote:
> > > [...]
> > > >> @@ -3733,6 +3733,11 @@ static int bpf_tracing_prog_attach(struct b=
pf_prog *prog,
> > > >>                 tr =3D prog->aux->dst_trampoline;
> > > >>                 tgt_prog =3D prog->aux->dst_prog;
> > > >>         }
> > > >> +       if (prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> > > >> +           prog->aux->kprobe_write_ctx !=3D tgt_prog->aux->kprobe=
_write_ctx) {
> > > >> +               err =3D -EINVAL;
> > > >> +               goto out_unlock;
> > > >> +       }
> > > >
> > > > This also blocks uprobe+freplace when prog and tgt_prog have differ=
ent
> > > > kprobe_write_ctx, right? Is this the expected behavior?
> > > >
> > >
> > > Intuitively, yes, this also blocks uprobe+freplace.
> > >
> > > However, how can we distinguish uprobe/kprobe here?
> > >
> > > At attach time, uprobe/kprobe is recognized by the target perf event
> > > flags instead of BPF prog's expected_attach_type. Thus, we cannot inf=
er
> > > the use of prog by prog itself.
> >
> > Maybe we should introduce an attach type BPF_TRACE_UPROBE in a
> > backward compatible way:
> > - expected_attach_type =3D 0, it could be either kprobe or uprobe.
> > - expected_attach_type =3D BPF_TRACE_UPROBE, it must be an uprobe.
> >
> > With this flag, we can allow uprobe+freplace when the user space sets
> > BPF_TRACE_UPROBE properly. WDYT?
>
> New uapi just to fix a narrow bug? Not a good tradeoff.

Agreed.

Maybe we should just land this set as-is and accept uprobe+freplace won't
work in certain cases. In this case:

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song
