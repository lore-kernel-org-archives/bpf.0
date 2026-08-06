Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8DA41837D
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046670; cv=none; b=V8+uiOcCvIjPM9I3n4CRZBPp1tt86OmsyOBYS1E8P1c/AqbJavmAmNyj8j+uG1DAHInGf9olMwXOasWLiU2VwF3fM2LvLxzgeGZ/OdMjfV9Vhvf+3V/0x2FJ4dPBuAmgwgixrJMF7w5Gyl7+HAo0a0AO7UhkPuCYOL4JdMUdpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046670; c=relaxed/simple;
	bh=vgNZfjOyt5LhGJHgSSZNxJ4rnZpOUM3mLpsAKxDpIvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4h0hsYqEpfiQ5VnAbc293lmcOxv+GX5Bnjnnzgzv9p11/BvijVbBqmhKW7sKnP/31EmnEDc90GsWBfVDGBn31xCo18tO5PF6UKdWkhXdzNsWL0c/qMd8L5EJnq5qxobzp+z3C1pNBgR2d8+G2N9S8XY/q0btssp0Z1+QVdP104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH9Hj2TG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH9Hj2TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3B41F00ADB
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046657;
	bh=S+ivQOtAjzR+9YUNezgrawqw4+W1vmKjk85MTyzBXtY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UH9Hj2TGitUSHikCK6jXbcLfxQ1u1h74Sk3gLGQIFH8jxhd/KqgKepHMKony5Tlb7
	 1i7uRMo5gRqnPvgEEiT7KddxBtNsYm22tTwnDcT5BR46hoUsuzF9PwAe3JnbGVr86n
	 65aM4XCSKgmmISw/E/SULRjJ0/3y7FhZ0WZn/TKxucA4PpNeottkj4ONPQ7QOAm4JW
	 3uYr2bvMiXYV7wtvQVvV7BRrNe5OKNIu7KpIPZ/5wb7z1u14AVyTDABUQGs64QaQYO
	 CRoK+wRG0rVhNuIe4ERGxLMhnJ6712dT8VVhNeiu8nT+ubvEjx3XxXI+sm/Z7HuZNW
	 hRfJbWRBgDWgg==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92f03daaa97so158356085a.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 13:04:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqCc9oE/eb1d1mWKJHd2fHP0LcjuxKHWhwp9PzrK7Y8CF2P/bRHWgDb6I7WiTcpHQNnY+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjA1fjgJGqkBgaJChNL7Yrf5ZBrDslC11fd3iN9b5E4kyXJYnF
	664i3KoXeeiED3V+XnWQzS/cnPqgHtZ0xuzr5Qva9YHOEEBJ2nj6POnEpIuqJmCFwTbosjZ3W6U
	lHHMqAc+ODwSm+YLEmU+QzqWD/RkMlVY=
X-Received: by 2002:a05:620a:a1c7:b0:92e:fc42:2c1d with SMTP id
 af79cd13be357-936490336e2mr1654159585a.20.1786046656402; Thu, 06 Aug 2026
 13:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804164652.296919-1-mahe.tardy@gmail.com> <20260804164652.296919-3-mahe.tardy@gmail.com>
 <CAPhsuW7=6Wy31ZKqUiwOOPJA7-39y_DtJXBO8BFj+OUfgnzRWg@mail.gmail.com> <anTCmv1esr3CWfSf@gmail.com>
In-Reply-To: <anTCmv1esr3CWfSf@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 6 Aug 2026 13:04:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5iobzRZPukVSRH8XNGwKHjvzog4mZyGvv+ddr0-8_4vA@mail.gmail.com>
X-Gm-Features: AUfX_mxU8Y3D8oTLXxheJVC383QcQaQRagZNf03urIPY9sqCvDJE691vlDTOGY4
Message-ID: <CAPhsuW5iobzRZPukVSRH8XNGwKHjvzog4mZyGvv+ddr0-8_4vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev, 
	pabeni@redhat.com, netdev@vger.kernel.org, sdf.kernel@gmail.com, 
	ameryhung@gmail.com, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:21=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> On Tue, Aug 04, 2026 at 09:55:44PM -0700, Song Liu wrote:
> > On Tue, Aug 4, 2026 at 9:47=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com=
> wrote:
> > [...]
> > > +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *dat=
a,
> > > +                              u32 data__sz)
> > > +{
> > > +       struct msghdr msg =3D {
> > > +               .msg_flags =3D MSG_DONTWAIT,
> > > +       };
> > > +       struct kvec iov =3D {
> > > +               .iov_base =3D (void *)data,
> > > +               .iov_len =3D data__sz,
> > > +       };
> > > +       int ret;
> > > +
> > > +       if (!bpf_ksock_has_user_task_context())
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       /* Early check for UDP. Exact limits enforced by kernel_sendm=
sg(). */
> > > +       if (data__sz > IP_MAX_MTU)
> > > +               return -EMSGSIZE;
> > > +
> > > +       if (current->in_bpf_ksock_send)
> > > +               return -EBUSY;
> >
> > Returning EBUSY is not ideal. Can we avoid recursion by disallowing
> > calling bpf_ksock_send from certain hooks? You can find examples
> > check_kfunc_call() or check_special_kfunc(). This probably means
> > we need to grow special_kfunc_list, which is not ideal.
>
> This is actually a really nice feedback. I didn't know we could add a
> filter per attach BTF ID. This resolves the issue that the send kfunc
> calls security_socket_sendmsg so we can remove all the recursion
> protection and struggles, it's rejected at verifier time.
>
> The filter now looks like this, I'd send this in the next version:
>
> BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendms=
g)
>
> static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_=
id)
> {
>         if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id))
>                 return 0;
>
>         if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL)
>                 return 0;
>
>         if (prog->type =3D=3D BPF_PROG_TYPE_LSM &&
>             prog->aux->attach_btf_id !=3D bpf_lsm_socket_sendmsg_id[0])
>                 return 0;
>
>         return -EACCES;
> }
>
> I don't think I need to touch anything else. I'll adjust the tests
> according to this. Thanks Song.

Ah, right, filter is enough for this case.

Thanks for digging deep into this.
Song
