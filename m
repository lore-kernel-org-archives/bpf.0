Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE626056C
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243228; cv=pass; b=U6NqvID/5eZUfhqTcFPDXGs8NeuytFH+i7Wy+GpdjwpZ9jPJ/PvwdYUG3osOF8YVygFVZfBsYK1e/QHcxsI6G1WBxfCjprIA23wB8jaeVzNK1Cv0fcRqCSxgcAmvAbewRDfqJtmWCj6IN90kDw+1Z4NUCCzs07jg/jAxHBH93eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243228; c=relaxed/simple;
	bh=Tn+iQA6ZhTH4MNOl1+92jKkFzlrelBdGGhR4vcgh4T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMyBE8B8Rm/2XOwetALtISKD5pUG9au92M58sDfR5UoJcky0OSFPHrLeFyIw5+HisVG8Awv3J1mv20Z2TpYjzulkwYawA4AI/WMqXtQK7Ex068HC2Yaw8oUVdZzlOWcoPSH+wAorpl7FjHSv7t9EXTgfM2D9FZM08Asxv/3BeWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAraGG4J; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAraGG4J"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842307472d4so167525b3a.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782243225; cv=none;
        d=google.com; s=arc-20240605;
        b=PYSJnp1T3UEUnQNtmCo8ejSf5hTWcx5y2A8K+9YFjaY7XYptcfBsS5qAYAH1cnBaeY
         s+XeQYbPldhTOg6yFSHrDT1iGYOhOhi7rLEaou3FZ9kFBQIfslzq8eIeZWEzUkb3epLc
         O0jedoBgL0l5K9+f4ZAjyNWEpJQpGacnn5LgGD1kPBatkWpD4P3kVMIW8WpZtMJwjfGc
         AGWTMHVJgSb7B11exPsVI2eRbf0LmcP5BaAfriOoXtstyuseGycExMNU2ZD/syxdPDfU
         zZ/3VGCX5to1BMFG+6zSUih7Qz9imobuamLyFKtSeRu43dlV1k7VM+lwWx0L/ArOopQd
         46uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=52svT3NV286lk2lB6I0q4CEqZCQeZ41pvbWignzJQwU=;
        fh=vrQKFddz50bhKpZBU5rHun31U8tEPcvlrVi5WY7hdDA=;
        b=VIrkxrzbjzicKHn+C8qM9L1sohYEmpRUU48xNR73TGgmlyXfzfkMIlvsg21HF2cnJ1
         P8PczSvnkmhapfyACq/L9yPil5FzKSkOtxL/OvFvVxWQzg0qDZbG4FblX8mI2DG/5oMV
         nd1b6+MJv6jN3d19oAsPKOUrtoQQ0WlTOcCvEJ2nq1Uuc3HPX7dptZYhmsB3b9bGzIeY
         57AyRiP9aCWJ+RrBt+hKWXEvh0JFRsPiOfjgrTzUuX7dQKrbEz0WRtCvaGLUCtTlULwD
         ke8uTx5zZ6OG+C3+inhc+0N1i4NzjHWql9txa4VG59DtqcB2MOKQRE/CqUMPMYdUyM5E
         R87Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782243225; x=1782848025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52svT3NV286lk2lB6I0q4CEqZCQeZ41pvbWignzJQwU=;
        b=HAraGG4JX9KJXKFwVpZ3bTuIa+KHmJOiKN72+iZQtzClQmBsi4JOZGK1Xtw28I0QzI
         URGibNxFvTokmYYr16iw6MBez8GUhyl24vN3lKpm4vBh/V2men2A0c5QE3+kwUBRpFYr
         JSmCsylFadAFyh+kn7CFXAgGpLPqF61KX0axyUBhUFiwIASz1gSWy9kTfpba3AxiNG5g
         OgtDyhgrIiRu8QKw8W+blq7D+qZ6aEzZQVZ7FsSxIi8N5g+KVLL6NdqEZ6DLKMytCnsX
         rGrYnwNpO6icOylEAysHM3cPS8nNFmr7DOMm/7p4/xG3oZxzY67fqNo111+jRQB5nKxW
         nkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782243225; x=1782848025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=52svT3NV286lk2lB6I0q4CEqZCQeZ41pvbWignzJQwU=;
        b=BOHI8WQXt48xTdHC07S6OCWe0EskR04H+1VR+sVO7c8FEvcqdW0PDJwm/LvVk7tOUc
         nqbE6mZMJnQ4JtyhEL46WtvY28gom4coSdTj5S3XbERpAUBnzh4wOtd5E2s4C1F0Qjv4
         vDkQ2TNEj3+cY95puova4Ox1ZZUPiJhT6WqZYqUhLKuN+8BIS+WlIfJY5qemVTq4UXX8
         JOzIvV9V5bL41k1Jlvrj5CcZWsXZIw/esDFRPLCQdoN9RGPPsnq546fh5YamNcIeJU85
         F2lnEs5QDI26iVj1m7igO21bzK1KWptJhjriEc4n63+VQh5htQPULq+2tF+HwhOjtgkG
         a0Tg==
X-Forwarded-Encrypted: i=1; AFNElJ9Rd7I0gO5kZXP+JZHed55iIADFcR2v4/pgxuaDks/q7kpZ1j2AVB16uLvPzE0s+r3DzlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglLc9DWoR3PU44hbOXlYVOAGLVRavTpa6Qwn6d9Cp+C0deFMm
	Y8hzN9Ip6ajYRdyhTl2HVkDLCpDW3wf/COg6wFW8+xOSvLnjAPzwwxU1ytKNdOpKT2QqnPH1FwG
	KIu75RvgdFFS9cR5q5L3F8CB3taviAUQ=
X-Gm-Gg: AfdE7clLCFiJrwoXR15qMG2FtOHRAaV+UQgwWmW2BLneFMqtSnT0pjWC5QWxFQ8/ScN
	X7pHOhqph0WQNbR2M1U1QMzpmaT1CyzrbxbkSt3TF2fQPRpsMNJYYYrS0YLRSq+laYb0KAKW5va
	5l0QVCttaFVSZK9rndyp45AC7DLprz6bYuk9o42lYn1tAa0M5FguLM4IfZPEsolQnu+KRb5k8cG
	gRkDZdT0oPoZjhqQjY5hp+iVvMEV1W2skWu3IWqYdrN/KBrdgWZstUg2QqDpdLtksEfTqWw8hmS
	ReQbbMqw0UK+65+t/qqR1EtKiUt/o4n6kWgfnic2YalPS/y6ZjsBraD6fBokNQBg7VK4XF3d85D
	C3rVpGLXr8JxgmA==
X-Received: by 2002:a05:6a00:1c8f:b0:842:650c:153e with SMTP id
 d2e1a72fcca58-84562496e68mr17420158b3a.20.1782243225164; Tue, 23 Jun 2026
 12:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com> <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
In-Reply-To: <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jun 2026 12:33:33 -0700
X-Gm-Features: AVVi8CfXsvt87dwIgEd9FrX9gy85kkM2pU8VaQLRIibBAfuVgoLBDMPyOjlQs2s
Message-ID: <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
> >
> > On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> > > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudfl=
are.com> wrote:
> > >>
> > >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. Whe=
n
> > >> completed all code paths related to sockmap-based redirects should b=
e
> > >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
> > >> disabling NET_SOCK_MSG. The implementation of sockmap as a container=
 for
> > >> socket references would remain under BPF_SYSCALL.
> > >>
> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > >> ---
> > >> Changes in v2:
> > >> - Handle prot->recvmsg being NULL (Sashiko)
> > >> - Elaborate on the end goal in description
> > >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-uni=
x-v1-1-d7e0cb7bb03b@cloudflare.com
> > >> ---
> > >>  net/unix/af_unix.c  | 4 ++--
> > >>  net/unix/unix_bpf.c | 6 ++++++
> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > >> index f7a9d55eee8a..84c11c60c75f 100644
> > >> --- a/net/unix/af_unix.c
> > >> +++ b/net/unix/af_unix.c
> > >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *s=
ock, struct msghdr *msg, size_t si
> > >>  #ifdef CONFIG_BPF_SYSCALL
> > >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > >>
> > >> -       if (prot !=3D &unix_dgram_proto)
> > >> +       if (prot->recvmsg)
> > >
> > > There is no reason to have this dead branch when
> > > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> > >
> > > Let's compile out all sockmap code when both configs
> > > are not enabled.
> > >
> > > Since AF_UNIX differs from TCP/UDP, it can take the
> > > simpler approach.
> >
> > Okay, will put the whole file behind hidden config option like so:
> >
> > --- a/net/unix/Kconfig
> > +++ b/net/unix/Kconfig
> > @@ -30,3 +30,8 @@ config UNIX_DIAG
> >         help
> >           Support for UNIX socket monitoring interface used by the ss t=
ool.
> >           If unsure, say Y.
> > +
> > +config UNIX_BPF
>
> Maybe UNIX_BPF_SOCKMAP or something.
> bpf_iter is supported without this config.

I don't like where it's going.
I strongly dislike new config knobs.
I'd rather remove existing knobs.
What is the motivation?
