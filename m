Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EA393DC0
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245616; cv=pass; b=BAE28F0FtCxdDCvnPNsw5XBHokLS4BdFudPNl4iqn+VHshxR1GKnKAXcEaeD2oWaoZ6R8162NiNcpyp/xR40wr937ZpZ9CVf+JhaZ7+muIq0I8O5yYKIG3Ua8X4vfoTazGnoK8zpVYPO55rhHWveku/e0sssPfUwgxz4C65Zd8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245616; c=relaxed/simple;
	bh=5sGeOw7VmUWiUHMPfJXbWRnlpRJBVEoR+wD19dd5j0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCe3kPDIMnJdAqg8Xpcw40bBntXkdwz204ybIXyA2R6QdJOEFZjxIJ6G7jYgW8pGeDMchCwmuHAYy+rI99PiZ0luZHkDnDzAkFA3XPVXL9NPTo5Wz0Be8d+2q7gj/jJm213jysYSu/T2+Ndf7kxUUHJ3EfqUUEgHEbzwoRjzk+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kbt9Pbl5; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kbt9Pbl5"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-139b914bab6so316384c88.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245614; cv=none;
        d=google.com; s=arc-20240605;
        b=Ft5KL/T65Aa1fIvkRovoRu8AYTy4z4P4SinNbC/IWoQwL2fG5aeiVqjMi9yEKnMTz/
         e8uYPodxkHPPRjCJBvrGvqOQIxIWQHn8ZzKI2uWpJudy+SpuQms9KKBwNZhcgKLqoILd
         c0Mza7kPJLTAjCQRxUIC+YQP6x8ygUnPv2F1zh89TvrAm4J7wANc58t+AbNpxTs1GPYC
         ok/9tcDr42Ug8VXwGtGAcYT45/MyCAk8FT14bQIL5tws6yUWj4cg7SO6hnHYwTZNc7i5
         YBR6WnhAq9XcsaNtRBI1MfK+Ty0AJpy569lFDdkiZ5XdrvHU8paEpMYF8yErIM6ch/0E
         upDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8sJ27FCi9bASXHy7tLRtiOieURaTWAatjcg7IB20DSE=;
        fh=rNHWfm6f1QAgpglvZd77HAbNxRUr2bTGPAIIezGBFGY=;
        b=ddnGO6PZgf5V4o1mrIu7hE6J32Uy5MGZY2atCMi9BT1/usJF/9NBYz/kl8bC9w/gen
         tHaLYfP9Ql/5hoBFPwkdlf1GhE2roo+kPC70S/XGR/t08edjElmTiqN8XFq57OFbYavr
         HvK0BRYeeRlyfCnAE2367L5KYRaGHC7/V9AArlOwkkw2qRj+2cBYi1abYL4rkh4KVELN
         BIJ1N51EHk54Np/kMYUtSuM/B37GacxvgO5Cs2HFBa7+7YbySwPh2Re+GYnf/eKolcbn
         2orhGpy33NApa2Gx5LIRXnppfzZu7GncIfzFB3oRl+3QmON7hjzo9tybd/VZyHwR6ghE
         dSyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782245614; x=1782850414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sJ27FCi9bASXHy7tLRtiOieURaTWAatjcg7IB20DSE=;
        b=Kbt9Pbl5hNuql1DOAmfUQZtnx4xaUvWpCO5pofBgc+51+PKNDVRZeI9IJrEI56KqN4
         u0zF+BN8i1ieHptUyegRepMXPa8LxoEbuw1wCJnxMQZ40/3X340PefkWimMjIk3ly+rF
         Xo6VF/PyTTLXPGIpo8De0tcyqgNVLENUe/Pv1fPpqYVaQFBma7MSZEFgKxZ+prNmbUne
         N7pHqwlZVAEUdr0lLSQu5u7Cc3ZSEkYUajWdUO28pGWc+goyxLRO6pqZ9zPbOxTrYz0Y
         OixN8WR6YPaAQMxagcE6nTJLpmFppctGu4G6M3OKLb1rqQgtHOxoBcrzSdNIyyPG5Ps/
         669w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245614; x=1782850414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8sJ27FCi9bASXHy7tLRtiOieURaTWAatjcg7IB20DSE=;
        b=AEZ+ChXjELmYQeRdlveH4X0mTTIDijQxtjUPTjt12oPAmpDHwO7xEHlAEq3yxTx879
         /XG/4RVhYd7by8VZPGm9gQ2mZZ6jaOI9rW0CRH6ncVqzHInaO/6qFtXV64BlmbXPNs8g
         hKggklRO5F2zPPZLAB9r0LBIH/923JcO6y8d2mHlWklJbsKs4S5NirhGmXurFPyVAVos
         PvtUbWdNS/j2yvPK3cNYI0xKpiek//WVCUEPjoRAzUoD8G8Y3Fh4TZLFWYg9S3IkKqp2
         dc8xkPJ7f0b70O7SJJ0eTC5GguehmKL6gWPysH34uLUaLrgBt/sZXDIqenLaq8iXRIFi
         E6iw==
X-Forwarded-Encrypted: i=1; AFNElJ+pID3cPKLgbVJ8TARngk2XNan05hWaDeaF8aHY8hKzyE5SJ0hDqNSNJFcbiD6/0jrlBgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUYpp07/l9HLvTfhw1/mTjtuyUkvcY7816TxDxLO+N5qqj5FZ
	zNLwhmaqTEvA4MKda4AS+aDwid9kzSCLlzgoyIRttidSQKCxSEoxjE9gJJasgbMbXcjYGRPP/D0
	eOEPKnDd4jJl4U38NMC+ARmq0F2HiTVy753TgMVro
X-Gm-Gg: AfdE7cmVIiQZyYyYfxW/Gr2X8tNipAsvxqcJotivjKfT4bivklj/Zc2/vD2BivazVtf
	s9+c2T43yTFzw/en2pVOsS1oBlrYpvKrbH7lk1Wdt2t2Xpr+JSBdGln4obg4649p+IahjWsJ94Q
	SgVCaAf9xa9WBVjnPeupa4SrZwLC2GBt/UsiT8NuBjpoeVphMxS+TGWIJduD7GQMi0IdV/DiVP+
	7WERlhe27rAgDy0H5ubj+du12ddKvBf/lWDQ/kM1lsoxb09+Nco6bLHeDolCBxLI5aQQKsaAGha
	oXQhICP28iluD6u/12wVpRCCcWeSk8hz7HCzNC53G4c3wtfec6biBM6s+EiR8Zw+uruLK781QP3
	hwxEbslQ4M93y1gWYRVhUtX2Y343guW6rM1dCLD0=
X-Received: by 2002:a05:7022:f9e:b0:138:4067:e44b with SMTP id
 a92af1059eb24-139d0c04109mr231753c88.12.1782245613203; Tue, 23 Jun 2026
 13:13:33 -0700 (PDT)
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
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 13:13:21 -0700
X-Gm-Features: AVVi8Cc3QtnEs9i7nXHsQhg0n0KdPybOUid5f0s8rhtZFNMPV5ILyqflipEPJAE
Message-ID: <CAAVpQUDgTvwG=Vvzz6gVea004f3LLTvdWz3tz1iOL1x9UW0SBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 1:03=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
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

I think config w/o description is okay since it's not selectable.

>
> Alternatively, we can do this to avoid the extra knob:
>
> ifdef CONFIG_BPF_SYSCALL
> unix-$(CONFIG_NET_SOCK_MSG) +=3D unix_bpf.o
> endif

This is far better, I forgot ifdef is available.
