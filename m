Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D23A6F0B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953969; cv=pass; b=XvUocn5JVqFKqjS2ehOj5hk/IVn1g0y1YAlwuMJOa2si2k1BBXh9vMsSE0M0mM9I55TvR01gd/FLTfQzMGh/20zfzKTQ28Q8lvGebHrJGVHipevuuY2Q7TmAZxukpEFTlqoVBH//EYwRJxfRG+RKCXZ+cEKLSX2B+3x0f/YJ/qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953969; c=relaxed/simple;
	bh=uf5HZTHJoAXInjP6F/jPwTZEqhmJlXS7G2mQJDPJKIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmfNQVxW0iUzvFG5Srjd9F0miIcYuElYMBxaYhbvEDa+0vkHCNaxPFp9uxQEdG0hMH/dtZYrjnI/152zH8k2XSUrAxkcahMCXSpAYxPIXL3/QGBP8XW1NFoqrpKVX64vr4WKPl29/qciX8VLtHtG24gN+cBMU8gdXBdtNiBGk0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs1lWboY; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs1lWboY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45efb698ef2so2230125f8f.3
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 14:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780953966; cv=none;
        d=google.com; s=arc-20240605;
        b=YDpfYu8Je+SuJgO76AUn1kI8tHHM20S2xJnQNl75ZrkCpCYy/vYEc6VUuOtzg0ked1
         SNFpFhncynEdo8DnvumfW90QeRemBSSoYnuucK6ecVnUtlE2ihoFA7Zfac15qPC2W4WS
         V2+ImOpDUG5jBnOO7UZTjP386PHsESroFEvD+xjOfCLZ5uXh9CrDbaCtDkQ0grQv6wBT
         1Uwp4MPhZH6pw4Yo07tidX4tkpjnusm0/teJpLh4gzvT9lJlqzcanNWsbKcLLk2yPu2g
         Ih23cO4L7qzy4uxEXhkTtzdXnZKUUGGSgTt0r/pcM7rtCxBVI8eQLF2uv0ltgVPN6Vbu
         Dppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbOXCSw4UW03CiAnUGJEGMnbivoK/CLI2jGJHgllnPI=;
        fh=zsH1PGX7gj9E0AJ8Crn4PD8SulSIP5phm8yoP8c4YVk=;
        b=LBsig/1+xpaaiel3joya59FrcEgrKFyzLwLwihWQdEVk5BKivm+iV76RoVBZBivsCO
         AxVu8j7RSqA9BRj42PqjBleCCD3eFXuAh9qr3FevDF1DL497exK/87x9B9h6+3z1GXH/
         Z6f5ctaVe+rZ/3C6+M7watYHgjha6shKTOsdxk0OI6U7FmIHuhB+LhDZnaqleVsnZyh5
         ldfEBRTLjBLzAhzTND7K4UKzEncVftseQxz3z0BYfd0gjH25php00Q18u/5ovohexlQk
         Z0J9FXFwlR4Xo5L8Cms+nh71WW/zQfYOVHbaj/d58Ru73kaJKEYU4TdE/gz0jKRCVZp3
         tn5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780953966; x=1781558766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbOXCSw4UW03CiAnUGJEGMnbivoK/CLI2jGJHgllnPI=;
        b=Fs1lWboYpHyPc0zTxwQpATFDS1TinajwLgIiUffWox8eqbd2QrjpOMnpADipxnDdUE
         adeXpbwH6QBzGeN7YrZefeJW1rFRdHbXh9efhtlQZvn+kNi7vLe35plR0BsxeXDk/R3i
         bf5PMgGrZMmkt8h6wOTcgdYR+4D875AswUHBqia5yNFTuvgMQ+pP9Jsr61IuOufJLV2I
         dXm6VetciYYiByJodoMDm2QHuviWQyOSyHOrXCppQfLaZ+3r1A7L9FAvhiikNDfTW+SD
         fSRN64uq4f72FYkijaLhnhnuZeAARE+w3K3n4VDFVv2SUrBng844Gye1g4tKESHmEIJa
         BGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780953966; x=1781558766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bbOXCSw4UW03CiAnUGJEGMnbivoK/CLI2jGJHgllnPI=;
        b=bFW1ETZVdexQCKz6hLSfW52UVdkPVDqyea/EFzyoYuSJo7YW6id1+Sg3yj3CbhjdWT
         USLwjjoOPbbUtS6m7IRbp+NpA9jUsj7gCN3PlS1qSJjkupRZET9q8L80Lc+UaIOIPIn7
         NQMrKN2YFLw2VvqNIBrW7mZ52T1UuYjeMyy5eA1gOb0DtuYb6zh+/yYYbxitVO2+oZnX
         PtKHxUK7VV4CjD7ZZM6dsfRW/5UZsb0w0ZNfRz7zmB5NFdB3ZCpWIvqEqzUh13audg0D
         gpwLU0N4kbrgvBlP5GVRxtEP2WA7pdi0ZC8GQ6iotgleHqJwotd7moj1NjPog8P4Y784
         /vOw==
X-Forwarded-Encrypted: i=1; AFNElJ/d93m9/vNHI3ocUHFvZyIx2iag6e+kWLUVm4cGiArx0alh/1g+VFccFkwKOECN1A99yr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OZaXIfjtLyPPuk9oqTXRZeH/MmUYgUu8kAk+d5B49wikMHHf
	7+UVYWP0cOOUxQKyCGWQu4L1llX+0nsISc6B7WEMA4nWbnreSFjvHG0ih7pmTG2kHlCUpWSwndv
	wBWMOyxjbUU35hEJut9z3/hGGCEGXPSA=
X-Gm-Gg: Acq92OGwz11Ke2xOUWz3e/gKiGEzshaDRzqSQQRNv3U6KVbegVheP2EGAzIouyO8/TP
	CirV92CYkxzTDP7y992a2yLU4oYMw/Wv2WDseY/cJH95Gd9bcG6yVd1a4aOQizr4r4iKHzZQaQp
	AbfgS8RSV3ziIxlB/OCEbscehjqu/eQVdWSoF8Cvv/JNn/WUzg53XsmSVj45F7twObwW5XGqlsH
	yTsY33YfmvjFIYDJbnHtIn3tTj+HibtWbeGpBLFiJUPYi/sFhnCTwDMq7SZdd71UtGzVE9Kasmt
	WPaas0Gm6vgDvf1LkSJZ269QpbaebxOZ8oBGNoXaQ21tJZf4H8pNOzUhmFxbujlvGsHFceAm6+a
	T1ofDsehupMNmkrmNZ4D1jzR9Ged09IunV/w=
X-Received: by 2002:a5d:5747:0:b0:45e:f266:f4c4 with SMTP id
 ffacd0b85a97d-4603061efd1mr20310565f8f.29.1780953966314; Mon, 08 Jun 2026
 14:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com> <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
In-Reply-To: <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jun 2026 14:25:53 -0700
X-Gm-Features: AVVi8CcgT8ycMVDBgmvoAGA-VFeJoLSpPQAJdB-dJg65JsknvnohoOnZrD5JvOE
Message-ID: <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Kuniyuki Iwashima <kuniyu@google.com>
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

On Mon, Jun 8, 2026 at 1:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Mon, Jun 8, 2026 at 1:02=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> > > On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@lin=
ux.dev> wrote:
> > >>
> > >> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> > >> causing a panic when the skb enters the wrong L4 receive path [1].
> > >> An initial attempt tried to fix this in the BPF helper by checking
> > >> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
> > >> this check via a TOCTOU attack by modifying iph->protocol around the
> > >> call:
> > >>
> > >>     iph->protocol =3D IPPROTO_TCP;
> > >>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> > >>     iph->protocol =3D IPPROTO_UDP;
> > >>
> > >> Furthermore, bpf_sk_assign() has had the same class of vulnerability
> > >> since its introduction =E2=80=94 it can assign any socket type to an=
y skb
> > >> without protocol validation.  Since the BPF helper check alone canno=
t
> > >> prevent a malicious BPF program from crashing the kernel, add protoc=
ol
> > >
> > > I'm curious about the BPF maintainers' stance on this kind of "bug"
> > > where admin tries to shoot oneself in the foot.
> > >
> > > I saw Alexei said this recently, and I guess it applies here as well =
?
> > > https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWH=
DQu2OWQx27_w@mail.gmail.com/
> > >
> > > ---8<---
> > > Not every "bug" needs a fix.
> > > If a malicious bpf user wants to crash the kernel they will
> > > find a way to do so. Especially with agents.
> > > We cannot realistically close all of the holes.
> > > Right now the priority is to fix the issues that normal
> > > users can hit and not bots.
> > > ---8<---
> >
> > In addition to that I have to add that skb_steal_sock() is performance
> > critical path of networking stack. Adding runtime overheard there
> > because bots can find a way to abuse the interfaces is not a good trade=
 off.
> > If there is no simple way to fix it completely on the bpf side
> > then we have to flag this issue as "won't fix" and move on.
>
> I asked if we could fix this in the verifier but it seems difficult. [0]
> Since this is triggered only by BPF misuse, treating it as "won't fix"
> makes more sense to me.
>
> [0]: https://lore.kernel.org/all/202648182730.i4ki.martin.lau@linux.dev/

btw is earlier sashiko TOCTOU concern real?
iph->protocol =3D IPPROTO_TCP;
bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
iph->protocol =3D IPPROTO_UDP;

as far as I can tell past bpf_sk_assign_tcp_reqsk()
the networking stack only looks at skb->protocol,
so modifying iph->protocol will only mess up
things on the wire (if this packet goes out).
