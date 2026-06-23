Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA163A6412
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247477; cv=pass; b=lAuevBCAob0zv3+t2Tf9fd8jMT/vi9Z8Y0wrCjjRwq7/7VRBBg/PYqPeTr2Q8Pck1VvpFVgJzJzIJPTUDbvnewGLrtoK0yK2/L1kIOqs+B8ffRNlXr4obL770i6GFOV5xeu8hof4L2l673YrwBOC1hN6v3Skrjwd5g/BcWXc0Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247477; c=relaxed/simple;
	bh=peQMGgivtWX/4yVotHO3GauRipRZ55KBtEzx7s7Df+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlsK8M5YJlZNT7vQFpveaWPUiqTTd4O+bXAgTKM/HZC5CTMJj50MPE6VBQ7sEr3lCAruEPic17gLfQ0Y8WG3L//qXLQjyG4gF3VYRklcgWMv+ZvPUPPX40kRVOBvBTV4A1Cl60QFr69VA5N910F61qtjTzqldnsCFMTK/nEJN4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu8OA32U; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu8OA32U"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66077e90382so332394d50.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782247474; cv=none;
        d=google.com; s=arc-20240605;
        b=NZd7/vqXggCj8C6x4oxXwtYK7+t+KZcvAeWTG6+LUUxg5cMNsDexqC6WcGyFHdpoG7
         6lVBTRA0ObauvCA3Nrm6ptRjWf3ch+bNdHNI3c0cionuDjSeL3Elarmj+BrIo8u2MjcW
         ylI8T5jx9dHf3LC2SMgZdJxj6a4LthGscbLVU3OGlQ+Ak4lVrNJUlQyn4EajufQgoKe0
         AW25KGiu2BUz4dJNgCM1MD0abSgCW3OHuXy4sscI1PZjAuWe23tnafc2FrjN5uQ7DcZO
         KooZNHSAljkrruB1GeQMQ2Mc9YkVEiAHi8UjDKP3KSG0ZoOVarp3Df47Z+j7h/mVK3Me
         NaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j3bx0vWlQbek/bc5PVktDuuMBd9L/up5ejzVscDCOsg=;
        fh=yu6WWHqiG6DydqWSEz/dDDQFpK48LqgOb+K69xjeUBQ=;
        b=Y4OyfCWfdtqrVlKzCRo7srMk5pWeweWCzihaSHVd2IrGPP91xl5JBMQjUaHCEGKc+u
         jlLQ2bQCLSE++J1DsB1GTSpTAg/J0Bzr0w8fTzu5QHtopmzeC/NEMeXQNkA7jzAdJVxq
         1cVOBfUA+N4P4dNFSI43r9Fdqw1tQnSirzzfSUnNeODvckQ3RDCpAaB0pmZQ2XmZ3NXY
         jWTDBrV70qLrOi1el4ZerxoxqQ5U1/ssnESRhOdHQlgRohr+1Nmx/ctmAAOVumgwMOOV
         BpiN48R+v39c+WAEzOaYgcrmdzKyRGUf1qpvxMzLdxNCeyEE4P/0Gg3KVRoU8ho/Kqgf
         9g2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247474; x=1782852274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3bx0vWlQbek/bc5PVktDuuMBd9L/up5ejzVscDCOsg=;
        b=iu8OA32Ulo03e8JuuU/JQQM5HF+BSQ41TkCC5YqfU9w72BHGRUsW6EEdUzrCw9l+na
         FC2lITv2vmbwrdt8gPrZ4sZwkdmlRzAftvJ+Oe2JslKeUVDw5L4QNjUs/FuhaMje49GC
         HzjbfjLIbeIHNVfuVEPHaePAcz3KWIJ9FqKxl9jcwEvXSvWGruH8JsdzJziDwUGm804H
         /YJzd7nG0d/m9wnIfOhk9yO52jBo4m22Ke/DAqYo4XxgDC1vv5ZEtzFVJMhZPNt3gyLf
         xJYkVvQY5fMUL9g4YQ107Q6f0dZvqh4q6zmSsTO+q5Tx4Ka+2KjU0+1c2V50RpVLaXOY
         32EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247474; x=1782852274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j3bx0vWlQbek/bc5PVktDuuMBd9L/up5ejzVscDCOsg=;
        b=kz/f/qQm4iS6xXcAYuKeL1ZJ5uUov4Laox0rflTogTuCfSYctfiN70yVhzBqK02msl
         jfIzWQWq2bQoB0uR0RChD46Wn/+IaUOfAc7O5n00AsM6pUM1I0TxTngbIdAtHJz5LWID
         m5Qq4uA4s5USDNLB5AlBP3VRdlSGT7AwInNYb1R+2LUa+DgpAUdUWPZMaiy66Hitv/l6
         MSr4IXeqFElHv8vrYKYzD0Wje646xHYuCXyDkuEiqW4GO8izXnTn35DXdFirafbtvXO4
         tdrC961gUfzbW77lTVnZBSREyKvhfbC4Oebe8NlfF6u/MxVgZq/uNGYeAuAKrpcWP3gL
         mvJA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+giaEM44NCPphZvoVb/xudegE3HAhpo02QbshNtTcWb8m7WKL0rWB0M6hND1cdyrxkCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TCerxt4eT+WVDitRjSI1BUA2uNqlru3km/81o5HM6whRRT+x
	QXi5BDZ9BmSLCRQL1cGXtQ6lUfr+1yhd85hDMCitrRNY1L0DkqEYRjLHCajofHYlhFaZdlFFyt6
	+sdYRnRzj8d3uZWgpwlaG2Rjcahe60J0=
X-Gm-Gg: AfdE7cmVO/GJ+af4sxpE44w+6jfp16HXUjiNyN+8g8ohgnmtVCrmjjVCAkLqIRex4qz
	mTWrJjD1DxCkyFMXe9/hjNzIUmB/NtCC2lokPxlUKw15FdzexioRYSlotp9jlpG/tEu3aOd7Ziq
	0ZSSYgoe3+sBhDA8iSlGQ2W3ZaaFECGEDb1TTFKpVIExKg1smGJgq2lUoIYcKw/4stw+GuuSkXC
	j0Bjob+mBcg7kye+PmZhg6kBYm+qkS/aWPHWCEjDG2SDo+pMVYbbuTv4rwA2FPg9pKvphC+BLKf
	sox8qKUhBqym
X-Received: by 2002:a05:690e:c48:b0:656:7cd:98e4 with SMTP id
 956f58d0204a3-66312db7cdcmr17211421d50.16.1782247473557; Tue, 23 Jun 2026
 13:44:33 -0700 (PDT)
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
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jun 2026 13:44:19 -0700
X-Gm-Features: AVVi8CdfYEJbDpqhuNcrMZV5JVqWgKLR48l5Cm88ZUU8sCsFzlJtBSm5UT1qE5Q
Message-ID: <CAMB2axOGX+t=pTVf4X+QmeHMfgV7CJ5FG6gUca=XMdfrnhe6aA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
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
>
> > I am also not sure if NET_SOCK_MSG is right. It is broader than
> > "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
> > Because those select it, it can't be toggled independently.
>
> Once the sockmap redirect bits are behind _some_ config option, it will
> be easy to replace it with a more granular one that depends on
> NET_SOCK_MSG. But we're not there yet. One step at a time.
>
> > Could you share the concrete use case you have in mind, and whether
> > this came out of an earlier discussion or thread upstream?
>
> This is a follow up from discussions at BPF summit with Alexei & John.

I see. Thanks for explaining the motivation.
