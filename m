Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9E3C343C
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513613; cv=none; b=JdgLXscxnxXWp12AG2gICTZUO0+GWvJHqCsZ6mIfGjAJvvL1jKt3fFo0ROUy5/CYEDwwhUN2Dq5R23AshnK+2SKiEUEj0/vJbFKU5wnMyXKHtOZfB3wroU/BYLas7LzbbJrvi2JoFrIsGeFrJUQbvBzdRuYXQHoO8fgCtxJJT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513613; c=relaxed/simple;
	bh=TMSj3OPDL/CzaPE9syUv/EMnnI3dbe+S2Sn07fiNIQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1c0ipRTLPRchXvUZ0WLmb8c8G8mrc3qmwUJEhZrdW84Lym8nG4GdNLrPfpT5DqwXYlVElLFHKBOtMXolaKqnB+i3ocA5okzbGNWQy1H38OcnOfOPyxGt0BEOV8k+XejEioXtLp5TyFrk/8IoDUWqDg8AvKPbNA9Z0nSHkdgqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp+7YlDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp+7YlDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FBA1F00ADE
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781513610;
	bh=TMSj3OPDL/CzaPE9syUv/EMnnI3dbe+S2Sn07fiNIQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mp+7YlDaNzHYjhxIn1ES/JhGgzK0evQNRWGeP/23sce13PQER8HFAa8m3MvAhCBWo
	 hQY9kk9AgyaXBCSXXb5249p7kHfdySZQjT03OSmqx0CgRpeaOfqqpu860evHkevFzR
	 NTawt8/Oj9lclgqB225ZJi2+ux7684ZMQxKrOUaWw2+H9NANGfudw8M8Ey7jgnDJhC
	 m69K3eskgvhWUYs8pOQvnyAdW+Yk5qzcAZrDI6pKmgoQ+ZWXh24px5ahfha+iGqF9Y
	 p/gt1eJrzO1obnpXWX2C8QCmdfbYchS2VPE2qt3tNsX41+BHtfduykIeyqI1rhJpGR
	 hBVDlhtKvJ+8g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so4632774a12.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 01:53:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/iINh7XCAWwcNYI8diApCjJmILZ9Lbfyh9u5mpY4psWHZIBoPqQL7LT+HsX9vEgQroM9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUk2Sg7GxtoQpNsiJMgRi8xkVU0rstQrLqYsDqlr34V4I1Yrh
	A9xVswcJ8d1IejWd1sMuxqubTqvhXAA+QDtcEHC5YPv1qy5z5iyPK18u8n9R+BcQBF6VAUhzs89
	mb/X/6dZE9pDVKn7Io+PMNBS4EY2ib/Q=
X-Received: by 2002:a05:6402:40ce:b0:676:988e:8eb6 with SMTP id
 4fb4d7f45d1cf-69378a510femr5017682a12.26.1781513609340; Mon, 15 Jun 2026
 01:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011616.27771-1-yangtiezhu@loongson.cn>
 <CAAhV-H4daHGFoAiXrwcNXj=T1kZm5jRRwd_sCiv7ksjR2ynHgw@mail.gmail.com>
 <e23e6781-d39d-d7fa-10ec-8d09349103ed@loongson.cn> <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
 <833e2fca-6a41-786c-356d-6480ca168e44@loongson.cn> <CAAhV-H5LORpNeTycjmHFobOZEA5w=spSkxJuOajuizz-941zQg@mail.gmail.com>
 <CAADnVQLAgYFQ=BRi+hKwt5pp7fffqsvD0rXzn6Nk9jJQ=6uUZA@mail.gmail.com>
In-Reply-To: <CAADnVQLAgYFQ=BRi+hKwt5pp7fffqsvD0rXzn6Nk9jJQ=6uUZA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jun 2026 16:53:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4DTJqUCS30ntDkQBRtSJ=rbZ=usaghUgtdXR-DMt3=wA@mail.gmail.com>
X-Gm-Features: AVVi8Cfto3qdRJHqxKM8eDmbW8zBIlRNKmbb7RRc45xJV-iX6C-b-acCWoVe5aw
Message-ID: <CAAhV-H4DTJqUCS30ntDkQBRtSJ=rbZ=usaghUgtdXR-DMt3=wA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Move thread_info into task_struct for LoongArch
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alexei,

On Mon, Jun 15, 2026 at 11:45=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jun 14, 2026 at 8:31=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > On Mon, Jun 15, 2026 at 11:16=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongs=
on.cn> wrote:
> > >
> > > On 2026/6/15 =E4=B8=8A=E5=8D=8810:23, Huacai Chen wrote:
> > > > On Mon, Jun 15, 2026 at 9:41=E2=80=AFAM Tiezhu Yang <yangtiezhu@loo=
ngson.cn> wrote:
> > > >>
> > > >> On 2026/6/14 =E4=B8=8A=E5=8D=8810:51, Huacai Chen wrote:
> > > >>> Hi, Tiezhu,
> > > >>>
> > > >>> I have queued this series for 7.2, does the below series depend o=
n this one?
> > > >>>
> > > >>> https://lore.kernel.org/loongarch/20260521125636.26744-1-yangtiez=
hu@loongson.cn/T/#t
> > > >>
> > > >> This is independent on CONFIG_THREAD_INFO_IN_TASK.
> > > >>
> > > >>> https://lore.kernel.org/loongarch/20260428080051.20938-1-yangtiez=
hu@loongson.cn/T/#t
> > > >>
> > > >> This is dependent on CONFIG_THREAD_INFO_IN_TASK.
> > > >>
> > > >> But anyway, I plan to send new version for the above two series of
> > > >> selftests once this "Move thread_info into task_struct for LoongAr=
ch"
> > > >> series is merged into the mainline, maybe after 7.2-rc1.
> > > >>
> > > >> Because the code under selftests need to be updated, for example,
> > > >> it can use bpf_get_current_task_btf()->thread_info.preempt_count
> > > >> for get_preempt_count(), and it should use ld.wu rather than ld.w
> > > >> for bpf_get_smp_processor_id().
> > > > You can update new versions now, then they can be merged together.
> > >
> > > Thanks for your suggestion.
> > >
> > > However, considering that these selftest patches need to be
> > > routed through the BPF tree (rather than the LoongArch tree),
> > > updating them right now during the active merge window might
> > > be inappropriate and risky.
> > >
> > > Given that these selftests strictly depend on the "move
> > > thread_info into task_struct" core changes, sending them to
> > > the BPF list now could cause cross-tree dependency issues and
> > > potential build breakages if the core series undergoes any late
> > > adjustments before hitting mainline.
> > >
> > > Moreover, because these are selftest adaptations rather than
> > > urgent bug fixes, they aren't high-priority for this immediate
> > > window. I will rebase and submit the new version to the BPF tree
> > > right after 7.2-rc1, once the LoongArch base infrastructure is
> > > securely merged into the mainline.
> > In history most arch-specific selftests are merged via arch trees,
> > including perf, bpf, ftrace, kvm and so on.
>
> This is not true at all.
> All bpf selftests are going through bpf-next tree.
> For example, x86 and arm64 bpf JIT changes always go
> through bpf-next.
> loongarch is causing problems this way by taking bpf JIT changes
> into the loongarch tree.
I'm sorry for my mistake. Yes, you are right, most BPF changes go
through bpf-next, but LoongArch is not the first and not the only
exception. See commit 806381e1a24c6eec2b431cbba2ba1b81e518fea8 and
3203a08c1266689c204fb8f10d6bb5186921fce2.

Frankly, cross subsystem patches usually have some extra difficulty to
get merged because of dependencies & confliction, and my mentor gave
me a solution: Merge a single tag from another subsystem (e.g. from
the bpf tree) to create a clean base, and then apply arch patches on
top of that base.


Huacai
