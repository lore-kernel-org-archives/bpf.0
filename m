Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF879955
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711138609; cv=none; b=ZChR1ZWvJ0KB6yYsDDhyKCRkZjb/rugIdoCa95mos7Rp1mZYl63WE9gmGT2F8yzMaQtyl/qQkDVpGlR+ZSsrl40073o8eD/B1yhHIHl5S4gDltMRU7tv0cKBM5coqn6lPtuwv73fCN8blRuVczxUVWF8pYwj8stNJr5sq7JSjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711138609; c=relaxed/simple;
	bh=CMPUEA4o6RoOnE2yg21NCU3z0mW7qtxuMWN+bAdIGlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Urqsy0e8bLwCU0M3Yat9t/Sm2cQHW+nOv/rXvz4UNAK3DwyVf8FKA6aCRsoe5+Coff2SIUgMG+Gr3O+Z3slMBXpvCFc6t3kiGyFDVM6vzR8JDT0dgR19QriZchf1SCvpG7AUMaV/hK3XV7vJKs8uSE8ra2Ly0qusFHcEHH3tWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLSmvNdy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLSmvNdy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1deffa23bb9so17908535ad.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711138605; x=1711743405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp3VFuxo06XCMSN86iezvg//jT11Fn6HNuvruq/5p6w=;
        b=PLSmvNdyCYRkVnMpoZN4CSb5HqhETGa1G7THbTwj15UFRbPILfRd4fQZXpaAJJltfe
         XTLaRhJOo0CHsOPVbTJX2NN9jauj361F2Yyrg6oyj11mNTFvGpGAXxMjBZ5QB+9oHYX2
         f4uc8n0SZ1VCB9an6LwODuUxOHF6J5wrcxPqQBbBMQg+Cad3n5ClunT/eKA7KhtvULRp
         QcA+rjIQyy8PPrqUaJ1FZq15mIt/nkZXEBThAV0QQOHfu2b9p/ZwLhmR/aEJ46jPFG5c
         uK8NLDzn/fEfEqJFQEoPz8pZ1Vmne0m/sNBUj3A6x0YaUEHEj6cjfDH5njV/FaQ/fFPZ
         T9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711138605; x=1711743405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gp3VFuxo06XCMSN86iezvg//jT11Fn6HNuvruq/5p6w=;
        b=Pp5ndi1K0SysLirS/IggrTsgjaFMwW/V/pqb1Cxvu+/8gIsNruL5xHbedPSxK1asGN
         9zaJfpYl5x/Ly0xyapBZxaW2bipt0gPwJFMWduwqLfoWymwiJy5zt2zdIV6o5j97Pw+s
         1ionAHWeanNLTnfgmnfDBeSo4fkSNOcqOVrxY/fJCMltCkbcuxkgvsrhal/rXigJtNEW
         UuPaZZjKzBtvZ3senjxfGwstle2j5ORvobvx2RX/qeeSD9qpqcrFaiYCHWPZ0L6pq7nJ
         LQYS52yf9EhFbgHDaOMD4LmFTbQGImB6QDMgTCZGJ7MeP8Q/5AM2bBJVCe6wCqHamD5U
         6gsw==
X-Gm-Message-State: AOJu0YyMPgtKp8uTdxxDP2xPlPsnxAZnX9tRQ1d66BT0SWYJa9U1okxK
	VzeqMHWjNePQOLcbCBMUZu8WmPqYnIrUsFBveDagHslwSSnIwCe97eV7n9j9+f/+jxN2EeFjl+g
	O9qjrExphwwd/cD8NT3UVVMgRnyqefK4i
X-Google-Smtp-Source: AGHT+IGRHq19fHGp51+5MVrKl9ABUoxjgl3d203tWf8Oya1ycRSS7AUTqgYIvwJr/mM8MvUKOm0VuPiGmjYSibuqT8A=
X-Received: by 2002:a17:902:848e:b0:1dd:2b9a:a1b6 with SMTP id
 c14-20020a170902848e00b001dd2b9aa1b6mr645244plo.25.1711138605089; Fri, 22 Mar
 2024 13:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
 <20240319175406.2940628-1-yonghong.song@linux.dev> <CAEf4BzZxD3xQ_3x_576OuvM2pueki=h19b1eyX5i1cqZtWNA4g@mail.gmail.com>
 <7d6eba04-d70d-4467-9c65-065774b29012@linux.dev>
In-Reply-To: <7d6eba04-d70d-4467-9c65-065774b29012@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 13:16:33 -0700
Message-ID: <CAEf4BzbEAKFiuxrMj2qRgQvyUQBeOWLMOqgibO7s9s9Bc3FVqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:18=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 3/22/24 11:45 AM, Andrii Nakryiko wrote:
> > On Tue, Mar 19, 2024 at 10:54=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >> Add bpf_link support for sk_msg and sk_skb programs. We have an
> >> internal request to support bpf_link for sk_msg programs so user
> >> space can have a uniform handling with bpf_link based libbpf
> >> APIs. Using bpf_link based libbpf API also has a benefit which
> >> makes system robust by decoupling prog life cycle and
> >> attachment life cycle.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/linux/bpf.h            |  13 +++
> >>   include/uapi/linux/bpf.h       |  10 ++
> >>   kernel/bpf/syscall.c           |   4 +
> >>   net/core/skmsg.c               | 164 +++++++++++++++++++++++++++++++=
++
> >>   net/core/sock_map.c            |   6 +-
> >>   tools/include/uapi/linux/bpf.h |  10 ++
> >>   6 files changed, 203 insertions(+), 4 deletions(-)
> >>
> > [...]
> >
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 3c42b9f1bada..c5506cfca4f8 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -1135,6 +1135,8 @@ enum bpf_link_type {
> >>          BPF_LINK_TYPE_TCX =3D 11,
> >>          BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
> >>          BPF_LINK_TYPE_NETKIT =3D 13,
> >> +       BPF_LINK_TYPE_SK_MSG =3D 14,
> >> +       BPF_LINK_TYPE_SK_SKB =3D 15,
> > they are both "sockmap attachments", so maybe we should just have
> > something like BPF_LINK_TYPE_SOCKMAP ?
>
> Yes, we could do this. Basically it represents all programs
> which can be attached to sockmap.
>
> >
> >>          __MAX_BPF_LINK_TYPE,
> >>   };
> >>
> >> @@ -6718,6 +6720,14 @@ struct bpf_link_info {
> >>                          __u32 ifindex;
> >>                          __u32 attach_type;
> >>                  } netkit;
> >> +               struct {
> >> +                       __u32 map_id;
> >> +                       __u32 attach_type;
> >> +               } skmsg;
> >> +               struct {
> >> +                       __u32 map_id;
> >> +                       __u32 attach_type;
> >> +               } skskb;
> > and then this would be also just one struct, instead of two identical
> > ones duplicated
>
> Right, we could do one with name 'sockmap'.
>
> >
> >>          };
> >>   } __attribute__((aligned(8)));
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index ae2ff73bde7e..3d13eec5a30d 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bp=
fptr_t uattr)
> >>          case BPF_PROG_TYPE_SK_LOOKUP:
> >>                  ret =3D netns_bpf_link_create(attr, prog);
> >>                  break;
> >> +       case BPF_PROG_TYPE_SK_MSG:
> >> +       case BPF_PROG_TYPE_SK_SKB:
> >> +               ret =3D bpf_sk_msg_skb_link_create(attr, prog);
> >> +               break;
> >>   #ifdef CONFIG_NET
> >>          case BPF_PROG_TYPE_XDP:
> >>                  ret =3D bpf_xdp_link_attach(attr, prog);
> >> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >> index 4d75ef9d24bf..1aa900ad54d7 100644
> >> --- a/net/core/skmsg.c
> >> +++ b/net/core/skmsg.c
> >> @@ -1256,3 +1256,167 @@ void sk_psock_stop_verdict(struct sock *sk, st=
ruct sk_psock *psock)
> >>          sk->sk_data_ready =3D psock->saved_data_ready;
> >>          psock->saved_data_ready =3D NULL;
> >>   }
> >> +
> >> +struct bpf_sk_msg_skb_link {
> >> +       struct bpf_link link;
> >> +       struct bpf_map *map;
> >> +       enum bpf_attach_type attach_type;
> >> +};
> >> +
> >> +static DEFINE_MUTEX(link_mutex);
> > maybe more specific name, sockmap_link_mutex? link_mutex sounds very ge=
neric
>
> Good idea.
>
> >
> >> +
> >> +static struct bpf_sk_msg_skb_link *bpf_sk_msg_skb_link(const struct b=
pf_link *link)
> >> +{
> >> +       return container_of(link, struct bpf_sk_msg_skb_link, link);
> >> +}
> >> +
> > [...]
> >
> >> +       attach_type =3D attr->link_create.attach_type;
> >> +       bpf_link_init(&sk_link->link, link_type, &bpf_sk_msg_skb_link_=
ops, prog);
> >> +       sk_link->map =3D map;
> >> +       sk_link->attach_type =3D attach_type;
> >> +
> >> +       ret =3D bpf_link_prime(&sk_link->link, &link_primer);
> >> +       if (ret) {
> >> +               kfree(sk_link);
> >> +               goto out;
> >> +       }
> >> +
> >> +       ret =3D sock_map_prog_update(map, prog, NULL, attach_type);
> > Does anything prevent someone else do to remove this program from
> > user-space, bypassing the link? It's a guarantee of a link that
> > attachment won't be tampered with (except for SYS_ADMIN-only
> > force-detachment, which is a completely separate thing).
> >
> > It feels like there should be some sort of protection for programs
> > attached through sockmap link here. Just like we have this for XDP,
> > for example, or any of cgroup BPF programs attached through BPF link.
>
> Good point. I have a 'bpf_prog_inc(prog)' below, I could do a refcount in=
crease
> before sock_map_prog_update(), we then should be okay.
>

My point was that once you attach a program to sockmap with
LINK_CREATE, someone else just doing bpf_prog_attac() shouldn't
replace this program anymore. BPF link preserves *attachment
lifetime*, not just the program lifetime.

> >
> >> +       if (ret) {
> >> +               bpf_link_cleanup(&link_primer);
> >> +               goto out;
> >> +       }
> >> +
> >> +       bpf_prog_inc(prog);
> >> +
> >> +       return bpf_link_settle(&link_primer);
> >> +
> >> +out:
> >> +       bpf_map_put_with_uref(map);
> >> +       return ret;
> >> +}
> > [...]
