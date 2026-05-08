Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A71270575
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269547; cv=pass; b=lxEn77S+vy44x5G4lHIhu+wMBXbsRMA2oFM4OYiV907PxjFz4ALyoXYkmcjRYFjP7ncjNg2vUdB6gUBzchp9D/7h8PEU3fGKxhRQv17+IjYQYNywPOazIr1IAp4xU1lVZDxugsMqTMu9zWJlWO0Y/V/e10m5ffTuI3qKC6W8z7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269547; c=relaxed/simple;
	bh=Ro5DruJiif08OCzynnb3PXbgNRdrYftLXsTIr8OpWUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBezzl7ZkApsgsidPDQAGoztbaLzjFrsz3U85TyIISilCMCgKHn2AexADTM1BzDzEsXoHyTEsXXO+HEsvGge3bI5gqOqGqvbPOa/Cn74tXg4iWxTPpflrJWwdtslH5TAr4SshMtK2X8VIcNLhRT9HXW7GylbVEJTXgWenaOah0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6/7/QTl; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6/7/QTl"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12dfee30612so2170672c88.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 12:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778269545; cv=none;
        d=google.com; s=arc-20240605;
        b=hBpgwyysblU/OErTCO8gvhyTqOeWm1oRJovOWE22+Z22JUcTlabM4mN4Z9TxnUVexw
         vXtj12FT+xPD2rU5+AZ52QQr7QLx5NPm/vV3BqlbOsAlZcbu2p5ldh/2QfYUzT5bqZe/
         0c74k9CZK68s0e+mTmsqlEOzN4XGahLqr8XJibr99IHpQFqsP4jgNQX5xmRzuzrMoSbG
         BDUjdi9QshGQUwFbbNQfHv9uDLiCzzdwJlH81twkHO6vZ9gmAxsN2G9SUmImbDqOxS0O
         eXaslou3A9tottVUFsqqsZRu5NRTIeBuQn5EfJ1Q3GMOrZ4+EYXq8O7ktcoiMlSahscV
         nUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQ8nNqRjbElmBBLWfEelIrZJk1v9aJBHHekjgICQwws=;
        fh=VuUfv1+34E6SYOHukj/KleSD0tnYW4AdkIrm23C6M5w=;
        b=VKo2mZNhDWEJhl8Wvvnx+2kwOYL9CUQ7YbS8oMa9E1dWzeg9UmQSZVqznPBv/Q/6Ex
         aWNzB1dPpCfqwj6w09cp6FPWYD9hbx5lPb/03Gy4tBzRIPv8O8SxSqm0pq/WnAtxiEpI
         DgOwY5uN+g2TuCGW7IU2f0tFcEeIGbiX8RzwGXnWcCDhud5lVQlOH/4HzcRl6FXqNeiO
         4oWbUHuDxMEXaNXhRG8FiyQfvegrMe7NlKmPIoRdXdoCaWyWs5pygBkIv798ATK3qJDq
         Fbkf++YU+9dpeOOlxJQC4tVk0KA3Ykm7tuwxhZrwrQD+amoHiAaIVT609sGUzDVckSKV
         jUlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778269545; x=1778874345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ8nNqRjbElmBBLWfEelIrZJk1v9aJBHHekjgICQwws=;
        b=W6/7/QTl20eTqpUxzVMCELqTBcfgT7HQ0ZjxmhselMX5dpcrNAdfLQfRRF75ow2vP4
         XopwpN5p3VfzsjZGgvHVo/wMPCVc5+s2gP1B7YAPjRHsZ2L9DIOp0i406rHfoEVP8X7g
         JbsN3skvhqti3oEqIZP8N4ME9UdgqL5y9CRvV9zlv2qg82FqJOMAVLMoNA5wVvCMxGej
         zgNDCqH4CHG4pSOstdw08cHzFB0Sp06sPYv+THt9VuGr3PAX2naOIulRm9O/+C2ga1Ds
         Sz7OcHKOzlydqglyEdCnhqTP5rb2bV0NAkAck0QXCc2B0OrphESmxpKsrk9cmmVMhlsK
         8yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778269545; x=1778874345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ8nNqRjbElmBBLWfEelIrZJk1v9aJBHHekjgICQwws=;
        b=Tvvj0xQ07wPMkANiwLr47t5e3hm5oPg81bh/249yTRkNqrn0gHRH8Oi9CRan75VoWN
         3+AXrhGnhHnnJfbX1EDjdUFbVMgS7LmrrODGWUI8aY0vFHzy6+geZmmaxuqZlI/Unbpd
         00QTQcm77npYwTjUCfYQ66dEAbF3EsNSz8GM9o34sr73fOkXVSATtCqBb4EOHcJrn5vL
         0Q/ZFKKJcTIkB0ZpoIp1bpsQu9mMLVJ/VyLXG43mgi/HXkMyLIdAdwi2ElcfxT3FX+Pi
         qJSR6xpFegK8IenDuz+5f/tEhqvHIFIygy9Yz3gPeM9akMyA0btIdmPwMNp2350S2fAI
         LBXw==
X-Forwarded-Encrypted: i=1; AFNElJ+MYeNaFS+OQZnVs4AmZsUjVpeIogPt/eZU3KC4T7EslU2lk668TfkEcZuFBw8bDil80KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJx8Okp2Njn6xAzlQVG0bwYY3+e65+O8UafgJHoIv6piM3v3f
	kUZyEml3BmbAnvWbKMMBlqXdWtVcTmtKgXb83aVHScQTnA0ljWCXXln0WhW1YLAeqwLGYWAw+R+
	RJHfp9pFzpwQYLceUjasZaXWsrmHjwLPXglyVrz6t
X-Gm-Gg: AeBDiesjTrVflFaSwYiqJsCtH4n89AsgVQR+uq+lftLuoSd+LEcIUngbFpFNQq2WoIY
	xS1kbdXf6xpaT3uIAZpZlfbeyEP8PSpTa2oqSNH66mEFfwn2WbeN3BTlEuLcOqrbbXV6GuHXG0g
	14PwF19rzlBL+N/WRKzWZM/67ecRE35ESaMunjzLojt0t7W7jInZ6KyDSlUxD3OvDfo1ingJvGg
	Sd1+1eIsNQPGec/n5r9nitlPwaiwmOD6Vt8bUbV/uxINbj5nXQCjQdnLsGVavb/WG4n99jSC/Zp
	pJsrJhrgMtJA6tADcVC+ItUdge9zIxmhEM08IPzzXETAebS26Dri02EZkbqY3rYeQ2r0C2T2P+Q
	tH84WtGq+UmRbjTrfmDMh89odv1bH4EE=
X-Received: by 2002:a05:7022:524:b0:128:dedf:f56d with SMTP id
 a92af1059eb24-13271b86623mr1983124c88.24.1778269544864; Fri, 08 May 2026
 12:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-4-kuniyu@google.com>
 <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
In-Reply-To: <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 12:45:33 -0700
X-Gm-Features: AVHnY4Kh7jOPMKRUwiQs_V5O1uSsyK3oD8rM5kNPt3C0ykL7Es4h05MSqDt9pN8
Message-ID: <CAAVpQUA_HHEbcRxEVbuxtnyz_5ibvOSxO2wVx16ZQ0kKHQM7NQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/8] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVLOWAT_CB.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:15=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > prog can be called with BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > In this hook, we want to parse the RPC descriptor in the skb
> > and adjust sk->sk_rcvlowat based on the RPC frame size.
> >
> > However, we cannot access payload via bpf_sock_ops.data on
> > modern NICs with TCP header/data split on as the payload is
> > not placed in the linear area.
> >
> > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > Two notes:
> >
> >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> >       invoked from recvmsg().
> >
> >   2) Access to bpf_sock_ops.data will be disabled by passing
> >       0 end_offset to bpf_skops_init_skb().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5fa9189eb772..94d07a15b2ab 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7718,6 +7718,38 @@ static const struct bpf_func_proto bpf_sk_assign=
_proto =3D {
> >       .arg3_type      =3D ARG_ANYTHING,
> >  };
> >
> > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bp=
f_sock,
> > +        u32, offset, void *, to, u32, len)
> > +{
> > +     int err;
> > +
> > +     if (bpf_sock->op !=3D BPF_SOCK_OPS_RCVLOWAT_CB) {
> > +             err =3D -EOPNOTSUPP;
> > +             goto err_clear;
> > +     }
> > +
> > +     if (!bpf_sock->skb) {
> > +             err =3D -EPERM;
> > +             goto err_clear;
> > +     }
> > +
> > +     return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);
>
> nit: wondering whether it's better to use __bpf_skb_load_bytes (which
> wraps BPF_CALL_4's ____bpf_skb_load_bytes) here? Seems a bit less
> magic and used already by dynptr?

I guess dynptr used it because dynptr is in a different file under kernel/.

Users in the same file (sk_reuseport_load_bytes() and
sk_reuseport_load_bytes_relative()) call ____bpf_skb_load_bytes()
directly and clang inlined it there (including __bpf_skb_load_bytes())
while dynptr tail-called __bpf_skb_load_bytes().

I see the point (I had to read BPF_CALL_4() macro for ____), but
____bpf_skb_load_bytes() looks better.
