Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C65372ED0
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954541; cv=pass; b=cml6CfoI+tEJ6Z7HGhsmJKraFwVFsawDTF6DPb2jQwQbdlddePTKGMeAhKFEE47tXaB0uDSy9Aj23xyHcfinxVsVIznV9eX6CM51enshvp2fbdl9gs4UV5uMiGjyP8mWSNAOMuPyX792gWIE35O4l809BH3buaAH4NNXTjrF8uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954541; c=relaxed/simple;
	bh=1A5zKEqAscmhGqROJUPu7ZRqKa1REMrRG6hrstD7bCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKIveQXpenZ4oLlQ3th/yAYYteJI0xSD43xX7HldrPHkqfvn06IMGyh02zd4DAPLOXAgnRSqWlG8EGM/BDzqx7wVF55H1oOBR/vcQeU9nYNI1zhAfPZ7Gha8SMe0EbVxdGycmsEKPqCSATS5moG48DnrhyLe+uBfyIN2JBHARt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uo2OUVbR; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uo2OUVbR"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1382c509485so1581953c88.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 14:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780954539; cv=none;
        d=google.com; s=arc-20240605;
        b=Xh0A5XSvXq9meM9NKvNuLyNJM7BIkBKcaHniu2+1J9fYtT52XpsK/FcQOTAuCkkYmw
         munfMtPdQsFfP7B/rddJucnH8CHBZUTbemVeAZH6tVFhb19jjmveLMGU2eHcQRZWjuq6
         oMtwlpOD+A204mFqs9/pz2Jx0m77+no3yrJbAkfOvckT7XGCR+vFqPeMFp7lAEl0Lp+Y
         yKBKpoEd4+0c/db/c2xh84K1fzmXQLh7H9Ewyask8ijOCI97MdNpf5pzOup2GG6pVXbr
         YnE1R82n/RdhSzoJ6yy6pJsc9f71lu5F+fzxw/j4Lx1+MB4XrwWWCENGyxdD5WfXuLzR
         /XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfEI3p6vfYRJLFYBKXtD1V6ydUrj2yea5C4lNu0JJ2A=;
        fh=dQRS2qRdnBlMcYxbB731hshriX+7PMxZWP4qyDaQJgA=;
        b=OLzbth6iGocqcq/vd8DtL9EZottvXHD+dUnMHBIS1t7rTv3djOf/+GqdsSW4N7ljr5
         MPdbX20YgbDL4HA3Pw2M2kYsn2A7pLddgFSTm8K7eUsfAfkEPdgY4255H3FJItLSe9Ml
         cnhNzxCcksViNjbIAGGrjGEuw5zBjwsn0S6L1KDX9PFSeIDjHL+GnaKdqDyEuxNNsd6p
         PPcxa14yRxJkana9/uwTHg4wjs+emVWwI8o50W+59IwNLa9wh2HVzuVp4S4doOUomk0D
         wX1qFuSBSm+tt/ypZZWJx+sW5zWhQMCjatE+mnJHC17WsDvqnlraIKoqXNvz8CdZhVYa
         j7Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780954539; x=1781559339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfEI3p6vfYRJLFYBKXtD1V6ydUrj2yea5C4lNu0JJ2A=;
        b=uo2OUVbRa39U0wC/EJUyZ70AuVfZ4D5qWOO2Jx0vUNXm1mfnhx1yYx3KDRhv/2aYI6
         F+0vATXhlu+ZEenNggghGhACfDSEh4azmVb3o4lWBECZhaDDjqrusmk1ToCFJo1VqK0s
         wnaGRd9/XnEE789JK6TTDah6qKHGr5ApOV1DWp6AJX+cFzmmkN6jLaZ2dFXQXREL8Xmt
         iovp1VAtUmVrZXe69ZZbsSj0jSDFfS9xXcsilB2TlHTQGcOxJIvraR+A3CzU2jxYAEch
         w0rayS+pgRH0M+35kI4+lSsMFlAk7BXYhTqt2Q9drGcOLLjkkzhvIjEQc/ZxXWDl8aMf
         zceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954539; x=1781559339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kfEI3p6vfYRJLFYBKXtD1V6ydUrj2yea5C4lNu0JJ2A=;
        b=SQleJ7eZXY68hzrFRvRcbqGdzhR6mhXb4wcMorC5VbrrNZ4Ju1wu1NmqjRMMZzWoQN
         4CFYh1UcXWp5W/YXCR2+d55CrpDvOLnocbPTnKzhV1rZjoeeLEMNZRjiwNUnUTfspBOt
         uIy8YwcyuDe/hWy9xvq4Snajv3jDBqECr4yD/xYG7tLOYQw9huhBBkRy4xS4CktZuZUP
         hRM6hh6p5bF4hx6UmM+nSOsopm4QCoKr0BtoZpDb67+D8qaFlAmdsxe+nEDLIvhAvxt8
         qy0qAv1yT4kv86Iny7k8/ylibEYezT5q6n9qjMoIpqgHohy63wW8wntwoeLXh+y1z9UQ
         Y7Ww==
X-Forwarded-Encrypted: i=1; AFNElJ94zWjN4eXCxytDste0eay1TSZrSOQFJrPLbOIftyoQ3W+ajw82iZeQR7wnajer1JjsHeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyYUd7tkNGZNhoTL6/0VTEYowJxuILVLbW52+3FY2DExnTqP5
	pulOvpVAwyPSQh2hovC4Q/R6qNxUx3CzD0pJzaTZhI/0cpIhADXLLYuHIsLt8Em3m4D2xkxM01g
	DB2kpLjqYj2a6Jds+fXifbaED1MCJG8shMRs6vi2n
X-Gm-Gg: Acq92OFCkd9ifL0XDjUU8N8FhHYAj5kKAtOjENuJrAQe/arlQqMIJWgeA/dTWZkbZyv
	yGdUrGr17QQFMswf5gY2Qf+8SyWf4Dvo98TKG2udzAPSqsl0sv0xrNAt1SJCs5+VnKMnAegFwXI
	8F5kgnyvcujs11uD/xc6sGn1hOHay15WrGugKXz2yKvSpLZOTyma2RrMWKqc86MEq/7NFmrv1yq
	ZXTaoz+VsozVm9PzPTczhcNHaKr+uA1fdnVGqF+96LR5LFiNhZEQfdbpgEqrVHJ9SEdgrKxqRUE
	+0rSb6Rxq/UzHMrhJtbZcIhJKdWq3yCdQZ7kpB2E+Y6aK5IbRtRv2695d36ElByUMnOD2LhCnOV
	4H01cd11Rp0uNoGmaR4EgaAJGeiHH27FuvKBF6/5MYLcz+vs+9k5mSVKPn8mL
X-Received: by 2002:a05:7022:503:b0:137:f0d8:4ffe with SMTP id
 a92af1059eb24-13806764206mr8627440c88.36.1780954538395; Mon, 08 Jun 2026
 14:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com> <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
In-Reply-To: <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 14:35:26 -0700
X-Gm-Features: AVVi8CfNPnu_11Y9w6rUPwUMj9tXfuWG5h97XU5lB3N-O0DJfMa4Mh5VgPAmWag
Message-ID: <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 2:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 1:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Mon, Jun 8, 2026 at 1:02=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> > > > On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@l=
inux.dev> wrote:
> > > >>
> > > >> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> > > >> causing a panic when the skb enters the wrong L4 receive path [1].
> > > >> An initial attempt tried to fix this in the BPF helper by checking
> > > >> iph->protocol, but Sashiko [2] revealed that BPF programs can bypa=
ss
> > > >> this check via a TOCTOU attack by modifying iph->protocol around t=
he
> > > >> call:
> > > >>
> > > >>     iph->protocol =3D IPPROTO_TCP;
> > > >>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> > > >>     iph->protocol =3D IPPROTO_UDP;
> > > >>
> > > >> Furthermore, bpf_sk_assign() has had the same class of vulnerabili=
ty
> > > >> since its introduction =E2=80=94 it can assign any socket type to =
any skb
> > > >> without protocol validation.  Since the BPF helper check alone can=
not
> > > >> prevent a malicious BPF program from crashing the kernel, add prot=
ocol
> > > >
> > > > I'm curious about the BPF maintainers' stance on this kind of "bug"
> > > > where admin tries to shoot oneself in the foot.
> > > >
> > > > I saw Alexei said this recently, and I guess it applies here as wel=
l ?
> > > > https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPC=
WHDQu2OWQx27_w@mail.gmail.com/
> > > >
> > > > ---8<---
> > > > Not every "bug" needs a fix.
> > > > If a malicious bpf user wants to crash the kernel they will
> > > > find a way to do so. Especially with agents.
> > > > We cannot realistically close all of the holes.
> > > > Right now the priority is to fix the issues that normal
> > > > users can hit and not bots.
> > > > ---8<---
> > >
> > > In addition to that I have to add that skb_steal_sock() is performanc=
e
> > > critical path of networking stack. Adding runtime overheard there
> > > because bots can find a way to abuse the interfaces is not a good tra=
de off.
> > > If there is no simple way to fix it completely on the bpf side
> > > then we have to flag this issue as "won't fix" and move on.
> >
> > I asked if we could fix this in the verifier but it seems difficult. [0=
]
> > Since this is triggered only by BPF misuse, treating it as "won't fix"
> > makes more sense to me.
> >
> > [0]: https://lore.kernel.org/all/202648182730.i4ki.martin.lau@linux.dev=
/
>
> btw is earlier sashiko TOCTOU concern real?

Yes, the selftest in patch 2 should reproduce null-ptr-deref.
(I tested one in a prior version)


> iph->protocol =3D IPPROTO_TCP;
> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> iph->protocol =3D IPPROTO_UDP;
>
> as far as I can tell past bpf_sk_assign_tcp_reqsk()
> the networking stack only looks at skb->protocol,
> so modifying iph->protocol will only mess up
> things on the wire (if this packet goes out).

ip_rcv_finish_core() uses iph->protocol for early demux
and ip_local_deliver_finish() also uses it for demux.
