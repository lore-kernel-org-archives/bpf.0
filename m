Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06BC3932FF
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246174; cv=pass; b=qbqFZNouYj9h/X+GJ8x2ooNgySqetoVy/0NEpChGI0N/eSLbWrfX36sZJo8vvF+PcT5dHpi7rEWmTKAi7sac+zYHUYtTDfl8+zEE+RcvRBU6rcOcLOzKPmap1k341kd1efSYJ2uM/2HvsSDKCfiucauOJcq1ZIqtLygvfjRIJEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246174; c=relaxed/simple;
	bh=0MzRaeA3gAz8QYO7u/KFgEphT3lY2mqcohRfwTGlkDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trOBYr1DcmNVGn8BWEOb+BpGkHZlNFcAXFtu4j38sEY+8zVwQCqeEoSkaNc7KumUwRRuZhYVQHtrpX6dnhVtdYHkiJ2KTjYz4kThsCEs3FvIIrvPBaATB8PseNj2eoqVQP3ec+UGU/f70lB4bSoDRRUiGmDD5K73jRcUI90P9IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQcXQ22h; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQcXQ22h"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-662b95934dcso246818d50.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782246172; cv=none;
        d=google.com; s=arc-20240605;
        b=H0h6bGpDBiinkUhLLuyA5u4AldYLLkRl+jozO7fsV/52NBjy04gV4h3+dDrhbngO08
         yPDnkOsyF4NGbfpCUq5OWyWn7Iak65SseelW+TQrLoObhe6K7fTE9MuAccE1/z0DLeA2
         WiRsnqNp3gg7JzOzQQrD6Znae8MzRTAILbn/HoRiLVEziR0UWi2dBdpL9Vf7mkx/VmUO
         0wYlxNer8oNCpxgfpQLH030d9XZRM33h4E5bybGFuXbWo9nC1ZHiKWGteUtFkv+ps9Kx
         OYlZlOz7ZPXbvGOmvOSwt/t+RnRexkXk/93BQ4neoo6tIkHKKmbjFr9FOETem6ssT9xL
         LR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+qPE3ZLfrrjwShyrsUwND+Pow1Vtpy5cQfWnnfwlCg=;
        fh=YdOyphViGm7HZt5XcIzmxb1QtRqOujuIXjIql2ApGI4=;
        b=KLDRhKE2or4s4OnMGBi8uYxcpzCkEKkPNg7wCUGbqZ5CnweiFwRJhrSMm5U08NjYfw
         UdZ0hb91nU263VaI84/S+BU82Bm/v0tlbqYwyCNy+5TDoMlyNZ+3AZgrq3ode2uLuLI9
         JHNP8TysqWKDtjQZi1IGv+7tSC3Zwa9HqGYyhc5DfMyUz+IEo0osM3qYSlO9rIZiJtaZ
         Vfz0f6vLif8jqI6DjTvCMUXVAxa2NErdFF4v+/jRCvp9dNIGM6fxs4e4MeV2Rt1Dc6+c
         EzRb1tcgjz0HIpgrL2otDlTWGEl+NfeCS7PHBinpIArCMGdqv/2pQVT7rUNS258aQ6WW
         DMLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246172; x=1782850972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+qPE3ZLfrrjwShyrsUwND+Pow1Vtpy5cQfWnnfwlCg=;
        b=qQcXQ22hWZJ7F1UQ0BH1Y4R3nZB9kSEsDq1gYLUJY3CnNPM6fh8iBqcE6Fe+ML9rmu
         4XalIbl6IOtY+dcwIwRAHAlNr4sB2I05SAelm8LDqhUwNIbiGkIOaEHcujNV4wdwZhxt
         WW48KOrE/BygQcLIF0MpXlDA63r0AR8Vi1RN8KGUS+9R67kF8JazwpVBzK/mMzXstFLG
         hxHjYEem1d8H/Ur0glQuTo/NO+s4VP1hHq3pSgBWeL8Tj656SfXobPgjICd4ScBYCUr3
         NBRrdRGAI/azHHTpmaQ02Ikprqg6Vc985/XzGvXuEDRX+9IpAqwSu6XVd9IhXDVL8xdq
         g3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246172; x=1782850972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+qPE3ZLfrrjwShyrsUwND+Pow1Vtpy5cQfWnnfwlCg=;
        b=YJ1o8NS+VqA/kBGphOYa8aQMhvLrkekvxMGYOMyf/PuixfOza1CC3cOfWavpUEAeUf
         hwxsCRIZRkHn6m49h4OZMAQLIJluO3OE97cGTQAivV2d0dt/o4F1w9DNmBoVxUKDrd5p
         YMaDzLikut7sVWHl6+p/Ro5ohD68KjT+/bMrZm4isFxVvktdyTN6MsvU7GTEAzY7mF+e
         FHo/jAS6HrC/VJer3jLNIlcPmPfjzQBrgIcw1QkZ/4Aw0kFLWfPm5ghLjk0C1F0Az9ha
         1Y9y0UY5paDp2DTPE59PaixqiUxUshu4WOGh16TG/1anCD2AYAWicfn2LrnMF3RyTTH9
         Kzow==
X-Forwarded-Encrypted: i=1; AHgh+Rq501C72WQmjUb3ctccuY9NrcxNH3Gqqf/HBw0vSRbL6M6svW3ihTZ7sQdJWKoX8o4z0Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGGoefbPjIBuLWpUhMmQaPop8GPsI8OjPbRBK5Rusvg190LKw
	Lti/8Thlm3k9fjMQ0Jpk/N7qTBxI5a7NvCJTlRKi0x3huUB8Sz3zccFT0hTr63QfCdJ+b9u5YJB
	cOgZlAuXqNDMsgfS9Jz+Cx/SYaMHF6Ne3KB2Z
X-Gm-Gg: AfdE7ck6WecGUN4edCeZ9UpARWw0s5W73IzJ3rBCXzPCehqINB4vW36RM8B16LWeECN
	SZ1VNLMrZ9O9UwbAfgLENgwZCJXE+wyVWV+q+SDGNSjyo/r+KvZW2nqIaoTVErrfovPniXuaIGt
	aQP5t7h/8ehrKhuE4OLZY7zjhTHbMwr1w+SjKhuCGu7Hxd3PBFy8kBaJz3ycWk0w/uVpvfHoqVc
	DiG7N1usPOntulW2gxh/hpLEYSiWfb8+deGDRwN8VLkfUOGg/UR5h6p5rwLDpAsuqs8ft/wjoxS
	+OZYyWPZ2AwQ
X-Received: by 2002:a05:690e:1685:b0:661:1669:b784 with SMTP id
 956f58d0204a3-66359e1b367mr4192169d50.10.1782246171839; Tue, 23 Jun 2026
 13:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com> <87mrwlyqg4.fsf@cloudflare.com>
In-Reply-To: <87mrwlyqg4.fsf@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jun 2026 13:22:38 -0700
X-Gm-Features: AVVi8Cc_kvY2-hiFq-rqmW8Jf1KhrQ23ATZsBbzS0ewBwc43J2MEhRPb9SEpfFU
Message-ID: <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 1:04=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> >>
> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudfl=
are.com> wrote:
> >> >
> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@clou=
dflare.com> wrote:
> >> > >>
> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. =
When
> >> > >> completed all code paths related to sockmap-based redirects shoul=
d be
> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out =
by
> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a contai=
ner for
> >> > >> socket references would remain under BPF_SYSCALL.
> >> > >>
> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> > >> ---
> >> > >> Changes in v2:
> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
> >> > >> - Elaborate on the end goal in description
> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-=
unix-v1-1-d7e0cb7bb03b@cloudflare.com
> >> > >> ---
> >> > >>  net/unix/af_unix.c  | 4 ++--
> >> > >>  net/unix/unix_bpf.c | 6 ++++++
> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >> > >>
> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
> >> > >> --- a/net/unix/af_unix.c
> >> > >> +++ b/net/unix/af_unix.c
> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket=
 *sock, struct msghdr *msg, size_t si
> >> > >>  #ifdef CONFIG_BPF_SYSCALL
> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >> > >>
> >> > >> -       if (prot !=3D &unix_dgram_proto)
> >> > >> +       if (prot->recvmsg)
> >> > >
> >> > > There is no reason to have this dead branch when
> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >> > >
> >> > > Let's compile out all sockmap code when both configs
> >> > > are not enabled.
> >> > >
> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
> >> > > simpler approach.
> >> >
> >> > Okay, will put the whole file behind hidden config option like so:
> >> >
> >> > --- a/net/unix/Kconfig
> >> > +++ b/net/unix/Kconfig
> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >> >         help
> >> >           Support for UNIX socket monitoring interface used by the s=
s tool.
> >> >           If unsure, say Y.
> >> > +
> >> > +config UNIX_BPF
> >>
> >> Maybe UNIX_BPF_SOCKMAP or something.
> >> bpf_iter is supported without this config.
> >
> > I don't like where it's going.
> > I strongly dislike new config knobs.
> > I'd rather remove existing knobs.
> > What is the motivation?
>
> The goal is to compile out sockmap bits that use sk_msg.
> NET_SOCK_MSG is natural, exisiting candidate.
> New knob wasn't my idea.

I'm also missing the big picture here.

sockmap already holds socket references today. You can store and look
up sockets without attaching any verdict/parser program, and no
redirect happens. So if the goal is to use sockmap purely as a socket
container without the sk_msg fast-path overhead, what does a
compile-time NET_SOCK_MSG knob add over the runtime checks?

I am also not sure if NET_SOCK_MSG is right. It is broader than
"sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
Because those select it, it can't be toggled independently.

Could you share the concrete use case you have in mind, and whether
this came out of an earlier discussion or thread upstream?

>
> Alternatively, we can do this to avoid the extra knob:
>
> ifdef CONFIG_BPF_SYSCALL
> unix-$(CONFIG_NET_SOCK_MSG) +=3D unix_bpf.o
> endif
>
