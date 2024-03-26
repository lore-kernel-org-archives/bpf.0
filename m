Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCC128387
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421996; cv=none; b=PlXi7PXM3PLOuSdF0Gum6kbCoFuxcJTvZjXCamL9HvjI8umuvBQERCOwZbmQrq5WBodWUnjqUwQpr/A1gmTGq1DLieTrNMKN5nUNSH0H9L4s8pkKPR2A1tcRSADWX0QHuw3An2/F4Yzn3efTSYvSEH9IumxmPGUGJlkGfke/RCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421996; c=relaxed/simple;
	bh=S8EPrNniTUlz2FUecWcn119SIsyN6FllZzdMpgS8PzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaHDl8kZfWspWEGZ52L6/qSXSk0TOWHClNcn6JXAEOBjeBCtSkQGPHmETEyhcDNvxES2Pg2/KheJrl5J+ng+JtnqHLGEYXMAy/wmxuTw1bUlM9itJRf/JUgFzzMa9OxvKebj3siBFXor4SitOy49Exynp0QMgJHyV490nbiYpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJgzI8kh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJgzI8kh"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a0292c4df5so3376856a91.0
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711421994; x=1712026794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/XsqWyaAQBYL+hky5CWJazSyuCvErnjTf/q1Dmg1Hg=;
        b=FJgzI8khsqz/Y3oQf7rw4aNW93+4bPYwTQOCtCrqKZHubL18QcaSsdZZFOVHaBYbol
         ztb3pSqSBGvPOdkHfL9MZ1PR3NJhktLu7dwzX2Rb1/byumBcRI2qu18ts0RpyWt9tVcy
         BfdVoDeLNTJx/DaP9VG9mdgoJBldYLPH7xrlWpvhCIxKvnIhiSPv6kgOuoRHX47eFHpy
         2Y0jqOHigibzOTt1mbNGZ/2EC1bCpEHDDmn2xe9laPSLZmKMABRZwRjJMh+A1leUWdMJ
         KK2bBhqAwR9CNhJBsqR7zQ1SIAEqPZ1nzWK4/aqkrmKKf8Mmi+fNAKOJIifPECnIWblV
         ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421994; x=1712026794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/XsqWyaAQBYL+hky5CWJazSyuCvErnjTf/q1Dmg1Hg=;
        b=dQWPID1PyQ1enHAZqNdLtjzDlnoXRnshtXZMjxYJc46/YTB9OIv8WqQTzbBwCXwScV
         01CC6COa4iTguBZjGR8Xk5ZE/9xT6OLv+L8YDslrZyUKPBCO1bjyDBoW9o61+4YVcj+E
         dbgLhLLGqaNzXRj+K2qvaylhKxu7tU36yQJcwLyF+Lrv9leL9Kllid38lgy79Jtvbeyf
         EeY3mKEKbxI6Fm/kkZcNWEGgpy8sl8zPNasYDvj23YXvRXbqov0T5XUmvChaRqxIQcrz
         oA7MaCo3esVHaUaNMdfapC3GP1VlyjCjg7m+iYmC41d3r5I6fUr7fqL+7GWYX7Xc80pc
         KvUw==
X-Forwarded-Encrypted: i=1; AJvYcCW6FKI4A8UJ2k18JlmBpJgv3IL7lKf/iS7HT8lTQL0L0Ili2YQCIZ6YsveFRophNSq3vYLUOoxCqE2PL+rNZOQ8lW/S
X-Gm-Message-State: AOJu0YxlxcsjrmHPp/SAfmKKn3Z2SYosnzQ8wcWawIB3247ngsWJDMlQ
	j7vhiN//ggwCk7wzjqUlHTxZUimyvnyjbHu2Vn/eTAh9oRew+WjR844kCGXoN5X4qZGtXwkQ2X2
	4hdQ6CWJQzLg0KLp8Yr/jqarlRV4=
X-Google-Smtp-Source: AGHT+IGnSMfGwnatOSrhk5B6qe08d+xz+l11Ra8acYL+S2aYlYH7J8mU5DxP3z/DRgziWBrWvg4GWY9cHQJ2xIacAzo=
X-Received: by 2002:a17:90b:310d:b0:29c:7028:62bc with SMTP id
 gc13-20020a17090b310d00b0029c702862bcmr13564pjb.17.1711421993877; Mon, 25 Mar
 2024 19:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215144.3786732-1-andrii@kernel.org> <CAADnVQJ6SDtLKTx_68iBuLXv+=tthNy81r_cFhrwTbED6N-10A@mail.gmail.com>
In-Reply-To: <CAADnVQJ6SDtLKTx_68iBuLXv+=tthNy81r_cFhrwTbED6N-10A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 19:59:41 -0700
Message-ID: <CAEf4BzYa0-6-awZght3qbhXMSkNFV6OVYBAk9DwW33SZe7xOAw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next] bpf: defer bpf_link dealloc to after RCU
 grace period
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	syzbot <syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com>, 
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com, 
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 25, 2024 at 2:51=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > BPF link for some program types is passed as a "context" which can be
> > used by those BPF programs to look up additional information. E.g., for
> > BPF raw tracepoints, link is used to fetch BPF cookie value, similarly
> > for BPF multi-kprobes and multi-uprobes.
> >
> > Because of this runtime dependency, when bpf_link refcnt drops to zero
> > that could be still active BPF programs running accessing link data
> > (cookie, program pointer, etc).
> >
> > This patch accommodates this by delaying freeing memory to after RCU GP=
,
> > which will fix BPF raw tp, multi-kprobe, and non-sleepable multi-uprobe=
.
> >
> > Perhaps a better approach would be to have a per-link flag specifying
> > desired behavior: no delay, RCU delay, or task_trace RCU delay? So
> > sending this as an RFC fix to discuss desired final solution.
> >
> > Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when trigger=
ing raw tracepoint")
> > Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> > Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
> > Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h  |  8 +++++++-
> >  kernel/bpf/syscall.c | 12 ++++++++++--
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 62762390c93d..d73a8978c800 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1573,7 +1573,13 @@ struct bpf_link {
> >         enum bpf_link_type type;
> >         const struct bpf_link_ops *ops;
> >         struct bpf_prog *prog;
> > -       struct work_struct work;
> > +       /* rcu is used before freeing, work can be used to schedule tha=
t
> > +        * RCU-based freeing before that, so they never overlap
> > +        */
> > +       union {
> > +               struct rcu_head rcu;
> > +               struct work_struct work;
> > +       };
> >  };
> >
> >  struct bpf_link_ops {
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index e44c276e8617..af1591af10bb 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3024,6 +3024,14 @@ void bpf_link_inc(struct bpf_link *link)
> >         atomic64_inc(&link->refcnt);
> >  }
> >
> > +static void bpf_link_dealloc_deferred(struct rcu_head *rcu)
> > +{
> > +       struct bpf_link *link =3D container_of(rcu, struct bpf_link, rc=
u);
> > +
> > +       /* free bpf_link and its containing memory */
> > +       link->ops->dealloc(link);
> > +}
> > +
> >  /* bpf_link_free is guaranteed to be called from process context */
> >  static void bpf_link_free(struct bpf_link *link)
> >  {
> > @@ -3033,8 +3041,8 @@ static void bpf_link_free(struct bpf_link *link)
> >                 link->ops->release(link);
> >                 bpf_prog_put(link->prog);
> >         }
> > -       /* free bpf_link and its containing memory */
> > -       link->ops->dealloc(link);
> > +       /* schedule BPF link deallocation after RCU grace period */
> > +       call_rcu(&link->rcu, bpf_link_dealloc_deferred);
>
> Do we have any sleepable progs that access link as well?
> If so then call_rcu_tasks_trace ?

yep, multi-uprobe, can be sleepable

> and check rcu_trace_implies_rcu_gp to avoid extra call_rcu.

yep, saw that for maps

>
> Doing that for all link types like networking that don't look
> into link is not great. Probably needs to look into link type?
> Or look into prog->type and do the extra work only for raw_tp,
> multi-[ku]probe ?

so I was thinking that bpf_link_init() can accept an enum or flags to
specify what needs to be done, instead of trying to guess/derive that.
That seems less error-prone, more explicit, easier to audit. WDYT?

This should work ok given this is normally dependent on program type,
the only exception (that we currently don't have) would be if
LINK_UPDATE command replaces non-sleepable BPF program (say uprobe)
with sleepable one. But we don't support that for kprobe/uprobe and
other tracing programs, so it's a future problem (but we'll be able to
support it, when we get to this).
