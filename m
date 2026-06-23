Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFC31A570
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245024; cv=none; b=hap1zWlSY4w//A0y9cmxmnUpFQcOiVqkOYBjNUvrX+vLPQ6F2fMg4E9GPXCzpxpzpLmPqKzVurfX3xcAyvRJYxI721ZL8H63DjjbjIpfJKF1XXIqepvd7GlfUdSgqIPTEqPWV1lL3bgX1L+xnSgsHpIjpJIFk5ry1ACnN0KAXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245024; c=relaxed/simple;
	bh=pSaanlwtBbeInvRpU6KeexNfjPmfeqm+bZK18BkZANc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ke6oSftzBRmNHNTXVe2cJV860ry6S959t+c9SaY+wpLNjBWfgy8iS7M2H/AuQlOlt7qUdTTF5vS4FErBVxwDrYeMlgQAGjNtaLTUgL5czcGaIf0ofsjA/gNayfgqD6w5yenpFnO5T72TsjUObPYaRMw9HxYt9IXc+9AfuHkfnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c5ypY7F4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c5ypY7F4"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso424488a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782245021; x=1782849821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6SzrCo7H7iOgBc7gPmXFJSVTMaa0i98zxr3jzUeDCQ=;
        b=c5ypY7F4bTWGvo/DFcIWK5U6o0PJCS52+zpyrgV+rX78rAHrKkRguMf+dLNpSA+9Ej
         RhthrpBU8u9jeZ/wzrx56pdKRiW7nIwnEPlDQ839bwxwA6U0GzzwTlfx77280llyVKw0
         OINGdHcYZMZ3Zqc/0ts/5gMhqkLh7CcrS/m52FKAz9tl9TueRHvFMXfm23V+xDX+1bB+
         AdZIFSqicYz2YfOoScEawaT5FpzyVfSBdu6a4r46+G5rHB6fxewdPBcz6yEJyZFEZzvq
         kVNnyXMrZ2TtTzmtZApe0kXx0zLsaG8NkNYIBKlQYyFljQDoezVvMntQ1AhVUfv0/zdQ
         JNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245021; x=1782849821;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6SzrCo7H7iOgBc7gPmXFJSVTMaa0i98zxr3jzUeDCQ=;
        b=lOpr2ZK+JVZhrQFRkX9Elji4QAFug6QegyGU8fYb3lWLaii0f7dOZylP9ABKToexqf
         6CV+JAyWGFr7CDl+sp85UG9iEK9Os4KITwjg3mIoGcVgzqi88Ok858ufP1BXr6KwHOws
         r/kS48pbuLV4k72xrRfFSu91ADGaQjrDayl2Gd26gqB9dETgsVXT3youqqsG74JrhOQz
         Ydf7UgjJmDhzxATU6Vmz39LBqND9thJl90qj+DXxE3BiuEZv+vAfyEOwx/e5Ga1BMy5N
         bGct56/I+PazjWyzvXUNQk7vh2QYGONIJfinRzds4m6RV7d4E8ONWAj8z5mokW/WqNn6
         Lhaw==
X-Forwarded-Encrypted: i=1; AFNElJ8FbCXbO7xa8x5nkFqE7PW/EFLrBj052vQU1E2wlul7vfeAU/eY5awH5hjPz0S63f9/ihA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFXCRJI+rs76l6H2FGZB1zWHEEN8LpLZGdPuXlmInfYGQUj3G
	3NqbyMWTpSne1EULFKaZTpzmHGOlaLSs/2AqXsBam8LDvGjvDeCeHsDOBT0cQMx4mpg=
X-Gm-Gg: AfdE7cmKCIxZdqsm9waOO7cwo6FnNGdCvoaOfpkD53yM1nI26sJZhiUan8tTNX7SaQP
	q3Fy1g4FW3WgT1YoQ2nYA5RZ0R1T6vSPUKTxXfKbCO9KX7Ci0FEyOG9Wyx1NHrpFvN0rhQAE+QQ
	PNSMnQzg966GfGnHslelHY1BTzVx0R666B1iwhtmeOqDAmyGRSznL9DrFov1hoUHjrUorfhxU4Q
	bcDP9I5VrRAI9r6ffJn1pscDZUHH5J5G7+CLOUtv2VVlBktrS4CkuVgfLBgy5GTqZqdZ2cji8Pc
	LBoak8Ec3DhiwubyLclT31DPHEiFdohnnt7ETBT3935GTiMDzTxeU69gfTK1dnUld6YSB7NGLhL
	4e6T79UBJ9WJiEpvGE5+ublXlT3Xqvji5jmaGbETjHh9Z8Q8toegwKM1Uz5Oxrei/vaLXH6Is8G
	zpGdugLm7WgNVruTs=
X-Received: by 2002:a05:6402:5190:b0:671:a18b:32b8 with SMTP id 4fb4d7f45d1cf-697f305a514mr61658a12.0.1782245021176;
        Tue, 23 Jun 2026 13:03:41 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be32083sm5237099a12.14.2026.06.23.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:03:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,  bpf <bpf@vger.kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Jakub Kicinski <kuba@kernel.org>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,
  Network Development <netdev@vger.kernel.org>,  kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 23 Jun 2026 12:33:33 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 22:03:39 +0200
Message-ID: <87mrwlyqg4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
> On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
>>
>> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
>> >
>> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
>> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudf=
lare.com> wrote:
>> > >>
>> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. Wh=
en
>> > >> completed all code paths related to sockmap-based redirects should =
be
>> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
>> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a containe=
r for
>> > >> socket references would remain under BPF_SYSCALL.
>> > >>
>> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > >> ---
>> > >> Changes in v2:
>> > >> - Handle prot->recvmsg being NULL (Sashiko)
>> > >> - Elaborate on the end goal in description
>> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-un=
ix-v1-1-d7e0cb7bb03b@cloudflare.com
>> > >> ---
>> > >>  net/unix/af_unix.c  | 4 ++--
>> > >>  net/unix/unix_bpf.c | 6 ++++++
>> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
>> > >>
>> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> > >> index f7a9d55eee8a..84c11c60c75f 100644
>> > >> --- a/net/unix/af_unix.c
>> > >> +++ b/net/unix/af_unix.c
>> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *=
sock, struct msghdr *msg, size_t si
>> > >>  #ifdef CONFIG_BPF_SYSCALL
>> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>> > >>
>> > >> -       if (prot !=3D &unix_dgram_proto)
>> > >> +       if (prot->recvmsg)
>> > >
>> > > There is no reason to have this dead branch when
>> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>> > >
>> > > Let's compile out all sockmap code when both configs
>> > > are not enabled.
>> > >
>> > > Since AF_UNIX differs from TCP/UDP, it can take the
>> > > simpler approach.
>> >
>> > Okay, will put the whole file behind hidden config option like so:
>> >
>> > --- a/net/unix/Kconfig
>> > +++ b/net/unix/Kconfig
>> > @@ -30,3 +30,8 @@ config UNIX_DIAG
>> >         help
>> >           Support for UNIX socket monitoring interface used by the ss =
tool.
>> >           If unsure, say Y.
>> > +
>> > +config UNIX_BPF
>>
>> Maybe UNIX_BPF_SOCKMAP or something.
>> bpf_iter is supported without this config.
>
> I don't like where it's going.
> I strongly dislike new config knobs.
> I'd rather remove existing knobs.
> What is the motivation?

The goal is to compile out sockmap bits that use sk_msg.
NET_SOCK_MSG is natural, exisiting candidate.
New knob wasn't my idea.

Alternatively, we can do this to avoid the extra knob:

ifdef CONFIG_BPF_SYSCALL
unix-$(CONFIG_NET_SOCK_MSG) +=3D unix_bpf.o
endif
