Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4523A6B85
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246967; cv=none; b=hc6/SvIyP/IqP7gvEh8L8EK3pJAqDG5JO4gvOXphPiRzlJxS3EEmz8rtH3+VxhDOlcHKOmX15hPJwUyMscHh8Atbzv3nIYqBybfk6aVsypLKcKpkQWl6xWibdsVhAksONJdeRLb+xDt4dKbh7L6t81Rfos9Gm6V+jKR2VOOL57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246967; c=relaxed/simple;
	bh=/GRGD1MLD4X5/6xzuqcyhlzMs7a2/Xib0LBHx4kotfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S2jswhI9JlbvTaYNFUjlo5qVm61ttrLh9ZYBi/e+9V7nACecmN80JZCQXNjveMuYl3xMDYo1s85qby078VHVS+XEnbDev9wolv/+yttWPZmne8zYWFqmTnuyo0726+XgHvLTSuvw8SbckKkawQSgclyPKZTGztV5iPcJNwpPovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UBpCpzx8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UBpCpzx8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso427791a12.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782246964; x=1782851764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpP2TgAWS6LY05FhT2gkiNjZjpsX/XmOaS8W6L/6Guw=;
        b=UBpCpzx82ReHPrbiYxd+lsYYyboAMrBhFygsPg3LAmBQRpmS6OO4CWf5qIrzHyxaBo
         2c8Z1MviLoEkDxi5t/hyuz1ZgFozfMO4gFLSqngf6Kykg6AGHAzr4EV3IXVnLoAJyYM+
         zFEv0nCnHFvsR9MMdLtZUdEDxaX0yOsQeNA3PodV7qx46PnC47HicKsLgaKsQ1moN1bJ
         mqoxjrPDPQ3g0nZVGYIav5WWjThsFMQWFthEfJCa4B5virf5i7NMA+Q9l5qkmtjp6H77
         vilRyiCpFwp/4JDYmfI0UZpj5bnNQ2rSzZJAu2K4oaaGRAbmDOcAxgqWRtt3XwliYI5S
         mu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246964; x=1782851764;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpP2TgAWS6LY05FhT2gkiNjZjpsX/XmOaS8W6L/6Guw=;
        b=b4vxWj+lzK7MSU0C/4mozUwnLXVZJ5sq7McNxr5Dv/wpNJvYfBDhsth/sQy6O3bMt9
         jG7qIakonsPYtvDz+Ye6IlqU5uoMaHc4sAWdDma8dEb51GuWvrICPc81QIzAOdtB4CrR
         hpdBtJbhRXyNRZoqaWlFdz+J4M8gHoiqkSV+462dmEFfY5GOTQof+lweY/QTHT6UTD3H
         I/8mG8HuJKTLaRI7P/8H+z+tj4Tql2pJFH8AMg1A7Igr/wj7j/89h/MjGqPsyvB6uuRK
         hFa8ogL0SOkCW5nDPJTtNXL0LxAlyBU8ZVMQ6AinBrR554vyfJbPmRamXrQmhCo6Sm8D
         bKbw==
X-Forwarded-Encrypted: i=1; AFNElJ+hpqxF5J+hEFM/7Jh88BYht+v8AG88ARqmm3v5WQk9yIA5jF1WdPrBQjj71Ut2OcG8dS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLq/S660+HW40vAtapWsU29agDSbBKRRdXRoZjjRp8vE0NZEk
	3M5saf5M78blRir84wiOVUA7UNtdgOgOlf5E8Xn9eGaryjg2/Xi8vLoHEbWCWwtqq7Q=
X-Gm-Gg: AfdE7cniM4YIVZErvQGsmKxjeLsPoCG/WsgcJLHs5seU/EMWcsZzB2M2bV4VokQfhn/
	swEoYfa/J2klt+fir9rxHCVSpVofe2ESpQKxveUxk+wIoBTCZzi83H0cktm77yjSR9/XnxZY6Fg
	ENScbEC9KRrU3IxYZAnQOmljVP1sS7EQP9pVkpg4jmXHzbEQHqxRocDxS/llub4UjGtE8jaJbYP
	64eva5Ddv2V/Q6IIc4FVvQHhhgCHd5FvpJzgj/817avozA7GYknOu78OouC2FzuxYHl/qXv9U3/
	fpALkUpCINBoBLcCB3VxU6qkdJOD4J4dzViD7qAyrOm4ZRiUlPA1zp+2qGvwCjEJXU3fV9EpUPj
	8Nk7LI2RYWQovsSv8hlPEO0T20ggrPYLjPcXMd1FPVRuUfQo6N5AcjBqk6IpUPXJEmxX+mnou6C
	OQfM0i0smTZlNSFW7l+4ZjRBbwYg==
X-Received: by 2002:a05:6402:538c:b0:697:8341:9e40 with SMTP id 4fb4d7f45d1cf-697f376fe8cmr98020a12.5.1782246964455;
        Tue, 23 Jun 2026 13:36:04 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm16312a12.25.2026.06.23.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:36:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  bpf <bpf@vger.kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Network Development <netdev@vger.kernel.org>,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
	(Amery Hung's message of "Tue, 23 Jun 2026 13:22:38 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	<87mrwlyqg4.fsf@cloudflare.com>
	<CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 22:36:02 +0200
Message-ID: <878q85yoy5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 01:22 PM -07, Amery Hung wrote:
> On Tue, Jun 23, 2026 at 1:04=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
>> > On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
>> >>
>> >> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudf=
lare.com> wrote:
>> >> >
>> >> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
>> >> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@clo=
udflare.com> wrote:
>> >> > >>
>> >> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.=
 When
>> >> > >> completed all code paths related to sockmap-based redirects shou=
ld be
>> >> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out=
 by
>> >> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a conta=
iner for
>> >> > >> socket references would remain under BPF_SYSCALL.
>> >> > >>
>> >> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> >> > >> ---
>> >> > >> Changes in v2:
>> >> > >> - Handle prot->recvmsg being NULL (Sashiko)
>> >> > >> - Elaborate on the end goal in description
>> >> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split=
-unix-v1-1-d7e0cb7bb03b@cloudflare.com
>> >> > >> ---
>> >> > >>  net/unix/af_unix.c  | 4 ++--
>> >> > >>  net/unix/unix_bpf.c | 6 ++++++
>> >> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
>> >> > >>
>> >> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> >> > >> index f7a9d55eee8a..84c11c60c75f 100644
>> >> > >> --- a/net/unix/af_unix.c
>> >> > >> +++ b/net/unix/af_unix.c
>> >> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socke=
t *sock, struct msghdr *msg, size_t si
>> >> > >>  #ifdef CONFIG_BPF_SYSCALL
>> >> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>> >> > >>
>> >> > >> -       if (prot !=3D &unix_dgram_proto)
>> >> > >> +       if (prot->recvmsg)
>> >> > >
>> >> > > There is no reason to have this dead branch when
>> >> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>> >> > >
>> >> > > Let's compile out all sockmap code when both configs
>> >> > > are not enabled.
>> >> > >
>> >> > > Since AF_UNIX differs from TCP/UDP, it can take the
>> >> > > simpler approach.
>> >> >
>> >> > Okay, will put the whole file behind hidden config option like so:
>> >> >
>> >> > --- a/net/unix/Kconfig
>> >> > +++ b/net/unix/Kconfig
>> >> > @@ -30,3 +30,8 @@ config UNIX_DIAG
>> >> >         help
>> >> >           Support for UNIX socket monitoring interface used by the =
ss tool.
>> >> >           If unsure, say Y.
>> >> > +
>> >> > +config UNIX_BPF
>> >>
>> >> Maybe UNIX_BPF_SOCKMAP or something.
>> >> bpf_iter is supported without this config.
>> >
>> > I don't like where it's going.
>> > I strongly dislike new config knobs.
>> > I'd rather remove existing knobs.
>> > What is the motivation?
>>
>> The goal is to compile out sockmap bits that use sk_msg.
>> NET_SOCK_MSG is natural, exisiting candidate.
>> New knob wasn't my idea.
>
> I'm also missing the big picture here.
>
> sockmap already holds socket references today. You can store and look
> up sockets without attaching any verdict/parser program, and no
> redirect happens. So if the goal is to use sockmap purely as a socket
> container without the sk_msg fast-path overhead, what does a
> compile-time NET_SOCK_MSG knob add over the runtime checks?

Sure, let me clarify. It's about the maintenance overhead.

sockmap-based redirects are a rather niche feature with few users, for
which we've been getting quite a few bug reports since AI came along.

We're not using it internally at Cloudflare, so I don't really have a
good reason to justify time spent on these bug reports.

Hence the move to put sockmap-based redirect behind a config option,
which you can enable at your own risk. Or which we can deprecate, but
that's not really my call.

> I am also not sure if NET_SOCK_MSG is right. It is broader than
> "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
> Because those select it, it can't be toggled independently.

Once the sockmap redirect bits are behind _some_ config option, it will
be easy to replace it with a more granular one that depends on
NET_SOCK_MSG. But we're not there yet. One step at a time.

> Could you share the concrete use case you have in mind, and whether
> this came out of an earlier discussion or thread upstream?

This is a follow up from discussions at BPF summit with Alexei & John.
