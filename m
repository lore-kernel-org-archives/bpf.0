Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036C182DB
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422922; cv=none; b=kNeQFMp6M9s1kKaB0ndzsRVVPLYLdvffyE7oL+Ay2sWObEMQ/5uhWCFmGNgLTPuodp9li/zhU2i9hgajw6qr8Gk7XVSr/mXd1ew+spKex+fPgl75SJEdLTZ3fGUfnRY+PEb4R0CZogVrmpbmsDq3FeuOasdhRSmX/tQAT+g5Y9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422922; c=relaxed/simple;
	bh=YRfTVK98IojhAvG5IoCnnk8eTk+u0RpE1SePBFzCcBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAtQqM1+x80L9mH+hdzWjmE3OB3GBQT2x/ER5AepRZJRM0HtiRQyGM+x9PUZEUEkDQuVsPqLwdi2EMFcga29AqRFxevesX2jhdReoGSNcnpaXMNtf6Am7l2PUwAFcZaSEanQd84gyytjyzG83jscRLyJmhBqZe4qLZie7jmJ+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTPfxvCW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTPfxvCW"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ececeb19eso3295292f8f.3
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 20:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711422919; x=1712027719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIUWNOQNXDdQHQ7wfd+HZ4iV5Kim08zXI4nYnGfswiA=;
        b=JTPfxvCWMUuhIbhxx4y29/3loj3UFucnNS6GBuGoyVwjTmt4uu8Erc9kKcNMGAaZBJ
         GRXvQL9fE4XaOmU8y9rlpucFi1v8BJocuHvEqWD8CZjJxU3moAkxdJCcBxlVGjjmeTJB
         4Ah1dVkaylJ1bkqDW6vWd1W+OhG7DRsaeF1v4uIOMXYaBdxSUBdYohFtBKvoq3344y0E
         rkRFsTBwd2KzAVwryeXjMsurUHMs/0Uyed6iuuXjm+GV+dXrYP9oPjxL5WWOkLQu4E8p
         Dto7kgF+XNUhQF90evMEvywaspFSzdgnomsBsz0sGnS7UYtX5Py3KQ60AgwBJI0xrivV
         LNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711422919; x=1712027719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIUWNOQNXDdQHQ7wfd+HZ4iV5Kim08zXI4nYnGfswiA=;
        b=FKIRwOPeSnSQ28vJgkQc9kl/FVssIF4si8g/wnrmpSrzEu2MY2smjpcaQpPHOw9y/G
         IMo2vWS+M3jouft1JNxQOjzOP3YCnx+yP5615L4rjUiOwt0F5NliArFu4teKNALYdajQ
         aBaCfOeg99zxQjFZjWqlQ8Qo9xOsQnBlyrg9ZYxNhJuMC9PJXCsQtUOI700eO727qvhB
         FvIoM9OZD8GFQZ0uR/tDAcDWtx9FnukNfZykrlPDLQJCumSuGTs/ohjca+VryKi+BrWG
         W4K5/JZ4DqfUSpnOpo1qLQrCWFlsF60UG/I+iHxq//S1cg3ogg2kXDxD+LZi/L+DTWYo
         OhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA81zIKxq9U/H+VxNtwO9qj9/2wRFq0P+KVdTl6PsRzMZBpI3NKUW69dPsnsc/14Pso+h39Y8QjMg0//u7aICHSl47
X-Gm-Message-State: AOJu0Yzm1vFybNTlO+ojETkvRptLEMoey0TLCHuC2o/I+Bk6gWSfSRpu
	5FsDTqDX/WQBYegFwZLz3UoK8jEFsh6aX5snib1qrNoYd+AE5P/pL7kuGLRSd6zT5XMJPSAH4Wm
	3vIESMNWKQI9Aj+LgC+H70wmVgWo=
X-Google-Smtp-Source: AGHT+IH4ki6cWMIXAvoLq4rUaeOGSvwyq+m60iBFB4SQG+LkWMxYqjXbV9wI5QZiKXoFsIk3+dazx/h6/8DBtx8CKqk=
X-Received: by 2002:adf:e4cf:0:b0:341:b4c4:3b2 with SMTP id
 v15-20020adfe4cf000000b00341b4c403b2mr5721208wrm.50.1711422919055; Mon, 25
 Mar 2024 20:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215144.3786732-1-andrii@kernel.org> <CAADnVQJ6SDtLKTx_68iBuLXv+=tthNy81r_cFhrwTbED6N-10A@mail.gmail.com>
 <CAEf4BzYa0-6-awZght3qbhXMSkNFV6OVYBAk9DwW33SZe7xOAw@mail.gmail.com>
In-Reply-To: <CAEf4BzYa0-6-awZght3qbhXMSkNFV6OVYBAk9DwW33SZe7xOAw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 20:15:08 -0700
Message-ID: <CAADnVQJxougTiJBj7iGP4aT927PDXCc9iTNdUE_6FR-KhF9TCw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next] bpf: defer bpf_link dealloc to after RCU
 grace period
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	syzbot <syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com>, 
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com, 
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 25, 2024 at 7:16=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Mar 25, 2024 at 2:51=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > BPF link for some program types is passed as a "context" which can be
> > > used by those BPF programs to look up additional information. E.g., f=
or
> > > BPF raw tracepoints, link is used to fetch BPF cookie value, similarl=
y
> > > for BPF multi-kprobes and multi-uprobes.
> > >
> > > Because of this runtime dependency, when bpf_link refcnt drops to zer=
o
> > > that could be still active BPF programs running accessing link data
> > > (cookie, program pointer, etc).
> > >
> > > This patch accommodates this by delaying freeing memory to after RCU =
GP,
> > > which will fix BPF raw tp, multi-kprobe, and non-sleepable multi-upro=
be.
> > >
> > > Perhaps a better approach would be to have a per-link flag specifying
> > > desired behavior: no delay, RCU delay, or task_trace RCU delay? So
> > > sending this as an RFC fix to discuss desired final solution.
> > >
> > > Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when trigg=
ering raw tracepoint")
> > > Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> > > Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
> > > Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h  |  8 +++++++-
> > >  kernel/bpf/syscall.c | 12 ++++++++++--
> > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 62762390c93d..d73a8978c800 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1573,7 +1573,13 @@ struct bpf_link {
> > >         enum bpf_link_type type;
> > >         const struct bpf_link_ops *ops;
> > >         struct bpf_prog *prog;
> > > -       struct work_struct work;
> > > +       /* rcu is used before freeing, work can be used to schedule t=
hat
> > > +        * RCU-based freeing before that, so they never overlap
> > > +        */
> > > +       union {
> > > +               struct rcu_head rcu;
> > > +               struct work_struct work;
> > > +       };
> > >  };
> > >
> > >  struct bpf_link_ops {
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index e44c276e8617..af1591af10bb 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3024,6 +3024,14 @@ void bpf_link_inc(struct bpf_link *link)
> > >         atomic64_inc(&link->refcnt);
> > >  }
> > >
> > > +static void bpf_link_dealloc_deferred(struct rcu_head *rcu)
> > > +{
> > > +       struct bpf_link *link =3D container_of(rcu, struct bpf_link, =
rcu);
> > > +
> > > +       /* free bpf_link and its containing memory */
> > > +       link->ops->dealloc(link);
> > > +}
> > > +
> > >  /* bpf_link_free is guaranteed to be called from process context */
> > >  static void bpf_link_free(struct bpf_link *link)
> > >  {
> > > @@ -3033,8 +3041,8 @@ static void bpf_link_free(struct bpf_link *link=
)
> > >                 link->ops->release(link);
> > >                 bpf_prog_put(link->prog);
> > >         }
> > > -       /* free bpf_link and its containing memory */
> > > -       link->ops->dealloc(link);
> > > +       /* schedule BPF link deallocation after RCU grace period */
> > > +       call_rcu(&link->rcu, bpf_link_dealloc_deferred);
> >
> > Do we have any sleepable progs that access link as well?
> > If so then call_rcu_tasks_trace ?
>
> yep, multi-uprobe, can be sleepable
>
> > and check rcu_trace_implies_rcu_gp to avoid extra call_rcu.
>
> yep, saw that for maps
>
> >
> > Doing that for all link types like networking that don't look
> > into link is not great. Probably needs to look into link type?
> > Or look into prog->type and do the extra work only for raw_tp,
> > multi-[ku]probe ?
>
> so I was thinking that bpf_link_init() can accept an enum or flags to
> specify what needs to be done, instead of trying to guess/derive that.
> That seems less error-prone, more explicit, easier to audit. WDYT?

yeah. makes sense.

> This should work ok given this is normally dependent on program type,
> the only exception (that we currently don't have) would be if
> LINK_UPDATE command replaces non-sleepable BPF program (say uprobe)
> with sleepable one. But we don't support that for kprobe/uprobe and
> other tracing programs, so it's a future problem (but we'll be able to
> support it, when we get to this).

that would be weird. future problem indeed.
