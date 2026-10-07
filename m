Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD650547078
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416548; cv=pass; b=MdU/66Ccp/L8OkDMvvWSopDSHdTpL6GL7f2zgczIj0UovGfW/ojIUpywZd5fxddwvm4WFMEAhOvBIUYoErWSyXBe4DyYdoR/uGyMjdPV/LVo/mkqnKj0IAuUgC5OsYe2MJu6wDPJwfauOkKDhZ1s8pC1tKdL9JEBisv8WK/FRhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416548; c=relaxed/simple;
	bh=ro4+/i2TM4zywI6a2AaHcGTylLGRLEcMZCi8IHwFh6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUmtTS+10hJ2Acstplgy9nRnBvtRbefSiYjk1lCD46ArhVzJ4HcDndpw7/05qScpHfzzddJrxv4CGpF+fpJ0tlFhiA/sNJhh9dwOjYKhsaPo9FczXhgWlY4xqPX0VVTQQoGBEMrfLbqaLrMsN1AlCxBobcto4FD0HkWyBLPGzlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYMB2EIw; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYMB2EIw"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4f9b643b13aso3063400b6e.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 16:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791416545; cv=none;
        d=google.com; s=arc-20260327;
        b=XWaSPp/u/8mJ9lg02cvPhvBPdYctAMicRu6L5vZ+cQitbzbbeataRMS/jhQvsMsNDo
         RNcZ1K142CGOytBP/OoayUA77vMQ4eFCLl9MbdzVpWYULLFl2UWvZl0UoifFllO2H7xT
         jR8T1AZVTwqV+mcG8PH0A/YtZ4995dv41tx6OxZLWeW1sQmUXz1NWyTsFJK0EvaHeAkm
         0eUFqtVYWzwf6LcbjZ0yqdrhGlzVgfbMQY+7mkXiX6fchQaN8jr4j5FEMGYtpBEbzju9
         R2hcDCmmLItISjmxuRSw57aBJYdeg6ubhDMJbvW+okOGbk816SzW1CLiLdhmBqcYl6fS
         EOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yGYj5b6U1++JQdGjDtNa0FrBS6zy0pR6vz75C3C1YPI=;
        fh=Syl+WP7+jDkr4WF8Wj0Pf1uuJiNdYnQk9mF0pZuKV6g=;
        b=ri7aV1AHNE1FwQKJH/LXZY+4OKRJuyOlwteH3/9vswV4Ah1RqYho/Xyby2gKf2B85A
         WsOxKrjDq064j+zXSVBR9XmT1qNvQHvN+nvGQ7s28BvpqXFCAZiuEzAce1naFQoq/Mog
         7G6PgNoEy9Gw38EEmmTpC9us0W3sw7u62kJuAikS0mV9RkBWoiLDGxj10vnRWpypqFht
         CCAFjT3NEfzBlTO+dHn4CgLzaULJ9lhyhVOcIljd1k2AUzjgTpTPAG/qOnOpxwevV9kO
         f+AtWJhN+mZvr4Ev1nwkPzFCqQ6KsUwoG8PmgU04B4JOVWOkDIaSgkBDD/vrC8PpVTn7
         4PxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791416545; x=1792021345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yGYj5b6U1++JQdGjDtNa0FrBS6zy0pR6vz75C3C1YPI=;
        b=UYMB2EIw5Dj4ij9cLgi6uuIFR79RPMatOGiYjb35a5BXqRilX0QTUL5LEvd3Tdyv3g
         WYk9mOO+uB4dDZoW1FjJpq8DW4sNg3xv048OzE7M8pBj3obopps3dOYG+gBOhQQSUqqt
         zh3Rjhl0+jXgYQwCurqlBfn2Z5z+Q402Y60PaFElDs+Hb4tJGorFJydbYaOFqptNEpeq
         cI3CM2hWV8UUafLPiTEL6XN8vd4Us04pVvsSvlDfuCMqCj2xEfzU/fgEK+fqSCa1evX+
         1vB0EMI2vMP50kQITwhi+UFSsO2cF3a0D7S5GbePLpwa1VZ7ouNLjH6WS8fsaKqW+veO
         JAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791416545; x=1792021345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yGYj5b6U1++JQdGjDtNa0FrBS6zy0pR6vz75C3C1YPI=;
        b=nq7y4Qvwio965KKoUGLHFIAGaMYBieMbAgi/+EOQqICHhddTIvhQ5vaDVFIf+nhtM7
         FIBBHC2sVvwfd2vzY2SyiLRWqAFHkIp1J5cVAia6zpWwWKo598/3+VxnSC7l7i0FqJvW
         qJjo8SoxBLB3fI4Up0mD2kV4b9LouosfxYgg3IXZ1s7WjyATm1OXAqwYa52r6/kCYjpp
         TsVLwOvh3rUU3DOEGi3LgPk5PDn2Orm/k+1CU7H/u0qesArJlrFKeBX15RN4tH9piQQn
         rQYxCg8eYzEzQBBB5PSuyWItqLn5NCQS9p8qMbfzyybgQI+n6nHtefe3A0RH15o8zA+O
         gidA==
X-Forwarded-Encrypted: i=1; AKwUvBy15hLOPhZnM3xTN0/b/L2RlR/GJMISN2Ou4PWBUArpU2l39tI84iwCCj0R3ieKF8X0kwM=@vger.kernel.org
X-Gm-Message-State: AFuF++k3XwH+j90NwYqAuIx+ohbuxbWyOpKI67bH5QlsajnLNzKyZ1aR
	DpTykMggxJLti52oNnbutMSG+HUVdgCViekkcSSjya+RjaeO+jcohSGd3WKlVFovYucm6zM6SXu
	8euQdxcqSPHBklK//h4DLvBTS8pA4YIU=
X-Gm-Gg: AYBFou2LGR5jU8hS07SM0Ah1aaB1oyS6H/GkW7Z6eIjZ13/OsjUwrDwlFUv47E0fO3Z
	NM/ubxhQMDzj1sJvl0k6VXvTdmmsOPvdaqA5oim8NKvtVLIRWDxsGAUriB6PlMvhsfA1e5QDFSI
	0h8aiz7n3p9z5nIu8IpVu4vSXeWef4IsIFrwA5ZAx+kBl+qGKaCD+vuo8XoWk1+sPh8ZIQyj9Rf
	ImL2IhEArYo3kpRb4M4toBVgdxcOloXXC1stwNw4atrASqA5BCWn25SATPyvmhgChvSn+Ca3b3x
	pSihEaaTR0K9cvVjtWXTjERUm2RfaVEEXmZ3caO10rWi79AADZRrorc=
X-Received: by 2002:a05:6808:3091:b0:4d5:27da:a496 with SMTP id
 5614622812f47-4fc46578fc2mr4036254b6e.48.1791416545324; Wed, 07 Oct 2026
 16:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-10-kuniyu@google.com>
 <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com> <CAAVpQUApCBTdHQDjf0NRXhE55fcg0wtmjGz9yEuQhsbQ8xm3rw@mail.gmail.com>
In-Reply-To: <CAAVpQUApCBTdHQDjf0NRXhE55fcg0wtmjGz9yEuQhsbQ8xm3rw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 16:42:14 -0700
X-Gm-Features: AclHuK-Nt_1xRb-O29Tb35isp6a4Vi2zZyko6wRWS0DCOsb6YDS_tJOHheNbCYM
Message-ID: <CAMB2axMECgYbMO172_3enQh+Sg75yRZSBE3ihvOKDqw6qkSxjw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Oct 7, 2026 at 4:06=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> > > adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
> > >
> > > Let's add a new kfunc to set sk->sk_rcvlowat.
> > >
> > > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> > >
> > > For enqueue_rcvq(), wakeup is set to false because:
> > >
> > >   * tcp_data_ready() is always called after the hooks in
> > >     tcp_queue_rcv() and tcp_ofo_queue().
> > >
> > >   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
> > >     not yet accept()ed, and when called for TFO SYN+ACK, the socket
> > >     is woken up by sk->sk_state_change() anyway.
> > >
> > > For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> > > is not called in that path.
> > >
> > > An alternative would be to support bpf_setsockopt() for these
> > > hooks.
> > >
> > > However, that approach involves excessive conditionals and an
> > > unnecessary memcpy(), costs we do not want to pay for every skb
> > > in the TCP fast path.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > > Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>
> > > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > ---
> > >  net/ipv4/bpf_tcp_ops.c | 46 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > > index 8182037c4269..2ba73dd6c52c 100644
> > > --- a/net/ipv4/bpf_tcp_ops.c
> > > +++ b/net/ipv4/bpf_tcp_ops.c
> > > @@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tc=
p_sock *tp, u32 enable, u32 disab
> > >         return 0;
> > >  }
> > >
> > > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlow=
at,
> > > +                                        const struct bpf_prog_aux *a=
ux)
> > > +{
> >
> > Is there a reason this takes struct sock * instead of struct tcp_sock
> > *, like bpf_tcp_ops_set_flags() in patch 2?
>
> It also works, but bpf prog needs to cast sk to tcp_sock.
>
> This patch is straightforward and rather patch 2 has a
> reason to enforce bpf tcp_sk helper use in cgroup hooks.

Make sense. Thanks.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
