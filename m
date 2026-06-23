Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811953AD530
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249980; cv=pass; b=QUAGJYGcIrgnYcRXXUTRPjNjRrOAEz0g4x5nXBbCRMrQFzu1X4+3JLFWJdCWHqPlkozbG/HVKJcvq0Fj8646WYrDIMr3uqgFhCuUpuKciHVhr6I8jV40CRmIQIGshWhhyeq0tBY1SBQTED0V0OpXteLcoRLzC31MQMOPwvlzeSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249980; c=relaxed/simple;
	bh=kmbhr2XiGYBwOOko7mqYKlF/rFd5r96q8J/WiCcO8aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvC+qu0L46H1uRgA+rEavsRgEYzaFqfG9yiCe6L+RWl7SgRXjRJWNRXJ90VOtV1yh+jPJluCEtlwQzp1gU6RReQNwnCXgW7FuHTVbfY9RyEVrJWb8D/7zEEj9vbUwpRFa6o+ZAg222BTOlfdgLJJE259aYS0ZUMcs9Q8XUuQ110=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDpawnYy; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDpawnYy"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37c64d34032so765190a91.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782249978; cv=none;
        d=google.com; s=arc-20260327;
        b=Lc8qEiLDIPEnFODgRavoPr/5pbi1rjdRIR8qqXOvu8q0YyCyOAuj1Owst1CionFAFb
         m63PUnDi7XkENjoADvnA1JkqxXN85RM3c48gRgSOQE4FqrqBhl2IZ9YLjKmyQDZQ/wIP
         xIOg2uvyupgZ/2At921tp/BnwjQe2huldsia5Iu33wvYADG0sJzkV22IjUGdim37lrD8
         eklZp/vzg0txT8zEdGSiloLYaJGgtp6ZwJVwhUy4ZdEV/x1Smqo5Ci7+q/l7cDi8QENh
         LiHka1Z5cCNpQg9CGwiG03Wkk11DooZrXdtb496spIJ/2gUmqm9MHCarzk2mINDiQqEl
         21kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USp7TphAsEpxVcFBP5z7GL6uCnYY56XN4R2T/hQLw10=;
        fh=ryI4X5W60VdA5eqVqHSJUMx3x3JDjcPZJ67QrR6w5aQ=;
        b=S5RV/ziUbb+3S4ILyyxuf36lKz1zm8c6c/BtO5YfPKcSGiWCWcR9PLdmqDMamCueyl
         d3Qitu/fnWx/cQAMUgTRPOjU71aADwXdpDQyiZfK9E2sMiH8IaoDM4buvjTDNHSPJAMs
         ILmfZOVwrVDido6qai8zVle5o9UEjdUxnkFkr/KIu5OJNZFCRwFe9hnhgg3y21QXQ+uU
         v+sjbciYftmgUkpS8f+idRmaiPBqUF3AAtNRpeC6pRUn4zl+sDKzVuT/18VxoDX/C8ns
         vKV5yr6i9t9ofEEL4w10l+1LWdYlXVTuETCbnvDdiIHOafHYrQMm5+tcp/yxJlwAWqw0
         xRKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782249978; x=1782854778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USp7TphAsEpxVcFBP5z7GL6uCnYY56XN4R2T/hQLw10=;
        b=LDpawnYyvALN7qgjd3o4/rpDjz25DIhZwCS6M8RjOO4tryuhSPM6CNoMBbpTbKm7v5
         bwwMa7k+LdSBZcqZ9pUOUFdkyvmgbfRzLhcK+ko7NjIDNCHpGaGEcXy0TOF5+X2Kw/dK
         CW3Cxm3egBXCgMrHn4dhv6rcjdKTdOP8JIVTvvFvN/hQsaWR4SYQ4BA7+vnmfCSesbVv
         UNexP89a4xEWR81PgWXpuRvXiPwEfzxeot2VOlTaPrd7v3hkXauFXPp+1a7ECiwokcqA
         szvLevkL2FSt83IiHyw3bXvOQOnSeGks/UxZho9GFtFXeNGXgNBbmd/zr21XUxA034Ae
         uASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249978; x=1782854778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USp7TphAsEpxVcFBP5z7GL6uCnYY56XN4R2T/hQLw10=;
        b=EoA+S7NwFLKg3YP8q4M+OLIlkEds/wAfVg3zJzRE/W8baR2UHwpwWmjTWV57ZHg83A
         8nztOksFJ53/PP0VOH/cB+aoBt4eILjQHIkoH/DV0+ypLIyJrpCRBxXI/zS731rYIaCI
         HFOcaaKPW498dwQXKb8BAUOv1lD0bUo6KrT6DOnohHR51aLysfDuE+Q1IT6Mk4DKRWyo
         lrLIv4wG2YT2IqNZmfvMw87UcxJ25Ez2e6pzojjjVZGayDSyfq1O509sjJo96j20BVSl
         L2q1UsuwL24QonyLAXc38+z8zZj8m36g2Bbn2luDyABQT5RQJlRfeit7HTDArYft5KG2
         strQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCcG4COlw6bRzQWjMlTscXW0jfMbYSIkjN//2UmY284WGD+iCz2ZCee/dlBmW3Lb8j61s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq47hpvAZ+xmNX2unVgFoaoRpiHdOPba/rSkNNqg5smoS81tVi
	pCvj+xui/Y42C1sDqbwld6yYVPLOBWuvm1heB7/r04pCpEva+RYQcB8AWIrM/nhbSZC7OyT/XCq
	/F0WL1Qo//P/GAh8A2zHleY4aPF+ctFk=
X-Gm-Gg: AfdE7ck8+ny7DPWrsTQxbKVkVU5q/ZEwlNvjCKl7qzsRqziVeV99oNknLASqyuI6Wyg
	uy9a9mK3mrSH6uuPgPozoi+IT1DBhqnCG1TOtKsAWbffPGQFBKZE5+ZLU9aTXkUG/sqnPrPWAw/
	pB3cqpXsmNlbOA/K0e/89x9+FR5ZrTfV3yp5Z4gFio+9sFz2ABVfG/104QZ4g5B9iMRiiOC7FM1
	LyC59S/HL8mN4ILDLkRtNnXXds2MNsoRBTd4JrsQXxbQB0IJMrXqqrQ8zilCGxAGMFt9WfEdf5L
	Qy/1ZxW3F/V6lLuDAGNWH/Q+p4QJU02pzc4Wpapeu5hitZXoSg/a84Ve043bYeevq/fvDOf9Iw/
	GlgUMnWyEUZvhvsTmXY87q/lA
X-Received: by 2002:a17:903:1a0f:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2c7c3ff8e25mr45033955ad.20.1782249977555; Tue, 23 Jun 2026
 14:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com> <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
In-Reply-To: <878q85yoy5.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jun 2026 14:26:06 -0700
X-Gm-Features: AVVi8CeY7z9Rj08nBW_kFc0hpBI6wW6ndWShy7Xbr0q7dvXzSQPEb0mb2mBVoEs
Message-ID: <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Amery Hung <ameryhung@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 1:36=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 01:22 PM -07, Amery Hung wrote:
> > On Tue, Jun 23, 2026 at 1:04=E2=80=AFPM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>
> >> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> >> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> >> >>
> >> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@clou=
dflare.com> wrote:
> >> >> >
> >> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> >> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@c=
loudflare.com> wrote:
> >> >> > >>
> >> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MS=
G. When
> >> >> > >> completed all code paths related to sockmap-based redirects sh=
ould be
> >> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt o=
ut by
> >> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a con=
tainer for
> >> >> > >> socket references would remain under BPF_SYSCALL.
> >> >> > >>
> >> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> >> > >> ---
> >> >> > >> Changes in v2:
> >> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
> >> >> > >> - Elaborate on the end goal in description
> >> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-spl=
it-unix-v1-1-d7e0cb7bb03b@cloudflare.com
> >> >> > >> ---
> >> >> > >>  net/unix/af_unix.c  | 4 ++--
> >> >> > >>  net/unix/unix_bpf.c | 6 ++++++
> >> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >> >> > >>
> >> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
> >> >> > >> --- a/net/unix/af_unix.c
> >> >> > >> +++ b/net/unix/af_unix.c
> >> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct soc=
ket *sock, struct msghdr *msg, size_t si
> >> >> > >>  #ifdef CONFIG_BPF_SYSCALL
> >> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >> >> > >>
> >> >> > >> -       if (prot !=3D &unix_dgram_proto)
> >> >> > >> +       if (prot->recvmsg)
> >> >> > >
> >> >> > > There is no reason to have this dead branch when
> >> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >> >> > >
> >> >> > > Let's compile out all sockmap code when both configs
> >> >> > > are not enabled.
> >> >> > >
> >> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
> >> >> > > simpler approach.
> >> >> >
> >> >> > Okay, will put the whole file behind hidden config option like so=
:
> >> >> >
> >> >> > --- a/net/unix/Kconfig
> >> >> > +++ b/net/unix/Kconfig
> >> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >> >> >         help
> >> >> >           Support for UNIX socket monitoring interface used by th=
e ss tool.
> >> >> >           If unsure, say Y.
> >> >> > +
> >> >> > +config UNIX_BPF
> >> >>
> >> >> Maybe UNIX_BPF_SOCKMAP or something.
> >> >> bpf_iter is supported without this config.
> >> >
> >> > I don't like where it's going.
> >> > I strongly dislike new config knobs.
> >> > I'd rather remove existing knobs.
> >> > What is the motivation?
> >>
> >> The goal is to compile out sockmap bits that use sk_msg.
> >> NET_SOCK_MSG is natural, exisiting candidate.
> >> New knob wasn't my idea.
> >
> > I'm also missing the big picture here.
> >
> > sockmap already holds socket references today. You can store and look
> > up sockets without attaching any verdict/parser program, and no
> > redirect happens. So if the goal is to use sockmap purely as a socket
> > container without the sk_msg fast-path overhead, what does a
> > compile-time NET_SOCK_MSG knob add over the runtime checks?
>
> Sure, let me clarify. It's about the maintenance overhead.
>
> sockmap-based redirects are a rather niche feature with few users, for
> which we've been getting quite a few bug reports since AI came along.
>
> We're not using it internally at Cloudflare, so I don't really have a
> good reason to justify time spent on these bug reports.
>
> Hence the move to put sockmap-based redirect behind a config option,
> which you can enable at your own risk. Or which we can deprecate, but
> that's not really my call.

This is wishful thinking that a config knob will stop
the bug reports.
Just disable it for real instead.

> > I am also not sure if NET_SOCK_MSG is right. It is broader than
> > "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
> > Because those select it, it can't be toggled independently.
>
> Once the sockmap redirect bits are behind _some_ config option, it will
> be easy to replace it with a more granular one that depends on
> NET_SOCK_MSG. But we're not there yet. One step at a time.

No. That's not workable.

> > Could you share the concrete use case you have in mind, and whether
> > this came out of an earlier discussion or thread upstream?
>
> This is a follow up from discussions at BPF summit with Alexei & John.

Not quite. The discussion was to disable pieces of sockmap
that are causing trouble.
Not to move them under config knobs, but disable them.
