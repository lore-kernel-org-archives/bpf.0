Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B853361
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143689; cv=none; b=f6jGyBcse1SRMgbxgWmX7GDhU/Z/uaIaFfqyVhhljWPPWB1rqMrLMvFzqrgW1dEMcVf/py/2iqviEpSSHtV7reED4ofNYx9BSU5NiEqGGz99mgIfRmii0j5Wcjfgz0CXRuDDTOYa9HL9QQ1xvbn+f93hjFmwFlpIz8JRB717d4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143689; c=relaxed/simple;
	bh=jjxOpw77jOFQLlLJGEscWSQfvLuh+CGe5B6vm0oScHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvn7lv0e4sP4uC2MwTq/XtuYyg3khLs75RDJWagaPAP1hy1f/89m10190XaGViCS5atoJh+Vv8g58CXXB0OHbw/leiwiD0PqAoUbl9ZR2a0K1TWEpqHOlU6y7l3zhTla89EgqAFsSCsMN3RBzJ16APz4h4L0IFhk0HkH7QbrDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcmYwxFM; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcmYwxFM"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3775ce48fso1596245b6e.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711143687; x=1711748487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOb40ZQ6mC1RutdXpnSz9Glks2VSWbd/5nQLRnHz25c=;
        b=gcmYwxFMdf6DylsiAZxYZL8T8YW3mqCp5gLooKlri8PMF0YNAk+S5pPkwfowwBOpB+
         uSXFhzZgJZHozp1BkxpDdwMsuaiLlHzXI+R7a3eVAG9P8JMrL7nPMc38T49mypqCBWIx
         1l/4p/kuwAlIWhCgUplYTrkyYc0KkG9wojVk1Gwb5qrCKEBCHetKpGQ2mP0mPHPPL6U6
         rOHNrxkEkVUbYqZOzVv+9X/uvwaYSVUmWpAYDyjRdxk1Hl3ks1ufx8lLBU6JkVFKPUdU
         /qOnOWY/yS/Fyd94BI+UYNWZtqA//yUDHJ5Hw5T15Ia/vwTIMbiN8JNLqInZqzxba9vp
         omGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711143687; x=1711748487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOb40ZQ6mC1RutdXpnSz9Glks2VSWbd/5nQLRnHz25c=;
        b=A/dYGCkwUu9xEnCzosW8FI+f4V/mRWlb2q3qbaL4Q/iUDZig/HUkzMsmNIJgl8pNfu
         Wt5km3hOLFSsdDu8tiQrrh6uBgoIYD+NPu1ncPoWCzXXKSGn4+YsjcKyxfz0OJ2uYjJV
         TLar//GiZiLo53Qd6xiXcZfRI21iHjx1Zw5HZdyh5F7LOowrdPZZlUzwFzQVi4ktovmh
         C9N1q+R+aDKhDSyLYA4fsVzCdC+5z92975To67PSDwU3FwCBgZ4HjyS9y75yu1TpK0oc
         BZInhT2sp+gRCSSPu+IyVjtYintp1nZPnC4FngaxZ8hOgJc9NKR7rSQc1xgloEVeDIcY
         b4Ug==
X-Gm-Message-State: AOJu0Yx/ysK2aBHXwiet3kVOIVuA2PnZYmek0xKo9dmgwHaOUuVSKmRT
	uZjyFB6uZw89tyE1U0ntyQAG+qII8bMwChyS2b3WiG7Ww8t+qcVS4Dt9jU0zcoPTnXJ1V08TY4o
	br38/DI6lugH30KwxmMnuy3izSR458aEV
X-Google-Smtp-Source: AGHT+IGJGzJf/xpvcDxChNc50DJuneBKZuWFSm9nBdqzGglVmEDEa/MyVuB5xjmHp5dlZ3M9NTy8ANnpKvzDESPgTXs=
X-Received: by 2002:a05:6a21:99a2:b0:1a3:69d6:d0f8 with SMTP id
 ve34-20020a056a2199a200b001a369d6d0f8mr1139064pzb.12.1711143326559; Fri, 22
 Mar 2024 14:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
 <20240319175406.2940628-1-yonghong.song@linux.dev> <CAEf4BzZxD3xQ_3x_576OuvM2pueki=h19b1eyX5i1cqZtWNA4g@mail.gmail.com>
 <7d6eba04-d70d-4467-9c65-065774b29012@linux.dev> <CAEf4BzbEAKFiuxrMj2qRgQvyUQBeOWLMOqgibO7s9s9Bc3FVqw@mail.gmail.com>
 <b89a5d59-b4bb-4ffa-b366-3b8a9fadf10c@linux.dev>
In-Reply-To: <b89a5d59-b4bb-4ffa-b366-3b8a9fadf10c@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 14:35:13 -0700
Message-ID: <CAEf4BzYKOcutb11RWtzOMTjsWrjhgXdSsEsXoLTrHSeWVs1QEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 2:34=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 3/22/24 1:16 PM, Andrii Nakryiko wrote:
> > On Fri, Mar 22, 2024 at 12:18=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>
> >> On 3/22/24 11:45 AM, Andrii Nakryiko wrote:
> >>> On Tue, Mar 19, 2024 at 10:54=E2=80=AFAM Yonghong Song <yonghong.song=
@linux.dev> wrote:
> >>>> Add bpf_link support for sk_msg and sk_skb programs. We have an
> >>>> internal request to support bpf_link for sk_msg programs so user
> >>>> space can have a uniform handling with bpf_link based libbpf
> >>>> APIs. Using bpf_link based libbpf API also has a benefit which
> >>>> makes system robust by decoupling prog life cycle and
> >>>> attachment life cycle.
> >>>>
> >>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >>>> ---
> >>>>    include/linux/bpf.h            |  13 +++
> >>>>    include/uapi/linux/bpf.h       |  10 ++
> >>>>    kernel/bpf/syscall.c           |   4 +
> >>>>    net/core/skmsg.c               | 164 ++++++++++++++++++++++++++++=
+++++
> >>>>    net/core/sock_map.c            |   6 +-
> >>>>    tools/include/uapi/linux/bpf.h |  10 ++
> >>>>    6 files changed, 203 insertions(+), 4 deletions(-)
> >>>>
> >>> [...]
> >>>
> >>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>>> index 3c42b9f1bada..c5506cfca4f8 100644
> >>>> --- a/include/uapi/linux/bpf.h
> >>>> +++ b/include/uapi/linux/bpf.h
> >>>> @@ -1135,6 +1135,8 @@ enum bpf_link_type {
> >>>>           BPF_LINK_TYPE_TCX =3D 11,
> >>>>           BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
> >>>>           BPF_LINK_TYPE_NETKIT =3D 13,
> >>>> +       BPF_LINK_TYPE_SK_MSG =3D 14,
> >>>> +       BPF_LINK_TYPE_SK_SKB =3D 15,
> >>> they are both "sockmap attachments", so maybe we should just have
> >>> something like BPF_LINK_TYPE_SOCKMAP ?
> >> Yes, we could do this. Basically it represents all programs
> >> which can be attached to sockmap.
> >>
> >>>>           __MAX_BPF_LINK_TYPE,
> >>>>    };
> >>>>
> >>>> @@ -6718,6 +6720,14 @@ struct bpf_link_info {
> >>>>                           __u32 ifindex;
> >>>>                           __u32 attach_type;
> >>>>                   } netkit;
> >>>> +               struct {
> >>>> +                       __u32 map_id;
> >>>> +                       __u32 attach_type;
> >>>> +               } skmsg;
> >>>> +               struct {
> >>>> +                       __u32 map_id;
> >>>> +                       __u32 attach_type;
> >>>> +               } skskb;
> >>> and then this would be also just one struct, instead of two identical
> >>> ones duplicated
> >> Right, we could do one with name 'sockmap'.
> >>
> >>>>           };
> >>>>    } __attribute__((aligned(8)));
> >>>>
> >>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>>> index ae2ff73bde7e..3d13eec5a30d 100644
> >>>> --- a/kernel/bpf/syscall.c
> >>>> +++ b/kernel/bpf/syscall.c
> >>>> @@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, =
bpfptr_t uattr)
> >>>>           case BPF_PROG_TYPE_SK_LOOKUP:
> >>>>                   ret =3D netns_bpf_link_create(attr, prog);
> >>>>                   break;
> >>>> +       case BPF_PROG_TYPE_SK_MSG:
> >>>> +       case BPF_PROG_TYPE_SK_SKB:
> >>>> +               ret =3D bpf_sk_msg_skb_link_create(attr, prog);
> >>>> +               break;
> >>>>    #ifdef CONFIG_NET
> >>>>           case BPF_PROG_TYPE_XDP:
> >>>>                   ret =3D bpf_xdp_link_attach(attr, prog);
> >>>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >>>> index 4d75ef9d24bf..1aa900ad54d7 100644
> >>>> --- a/net/core/skmsg.c
> >>>> +++ b/net/core/skmsg.c
> >>>> @@ -1256,3 +1256,167 @@ void sk_psock_stop_verdict(struct sock *sk, =
struct sk_psock *psock)
> >>>>           sk->sk_data_ready =3D psock->saved_data_ready;
> >>>>           psock->saved_data_ready =3D NULL;
> >>>>    }
> >>>> +
> >>>> +struct bpf_sk_msg_skb_link {
> >>>> +       struct bpf_link link;
> >>>> +       struct bpf_map *map;
> >>>> +       enum bpf_attach_type attach_type;
> >>>> +};
> >>>> +
> >>>> +static DEFINE_MUTEX(link_mutex);
> >>> maybe more specific name, sockmap_link_mutex? link_mutex sounds very =
generic
> >> Good idea.
> >>
> >>>> +
> >>>> +static struct bpf_sk_msg_skb_link *bpf_sk_msg_skb_link(const struct=
 bpf_link *link)
> >>>> +{
> >>>> +       return container_of(link, struct bpf_sk_msg_skb_link, link);
> >>>> +}
> >>>> +
> >>> [...]
> >>>
> >>>> +       attach_type =3D attr->link_create.attach_type;
> >>>> +       bpf_link_init(&sk_link->link, link_type, &bpf_sk_msg_skb_lin=
k_ops, prog);
> >>>> +       sk_link->map =3D map;
> >>>> +       sk_link->attach_type =3D attach_type;
> >>>> +
> >>>> +       ret =3D bpf_link_prime(&sk_link->link, &link_primer);
> >>>> +       if (ret) {
> >>>> +               kfree(sk_link);
> >>>> +               goto out;
> >>>> +       }
> >>>> +
> >>>> +       ret =3D sock_map_prog_update(map, prog, NULL, attach_type);
> >>> Does anything prevent someone else do to remove this program from
> >>> user-space, bypassing the link? It's a guarantee of a link that
> >>> attachment won't be tampered with (except for SYS_ADMIN-only
> >>> force-detachment, which is a completely separate thing).
> >>>
> >>> It feels like there should be some sort of protection for programs
> >>> attached through sockmap link here. Just like we have this for XDP,
> >>> for example, or any of cgroup BPF programs attached through BPF link.
> >> Good point. I have a 'bpf_prog_inc(prog)' below, I could do a refcount=
 increase
> >> before sock_map_prog_update(), we then should be okay.
> >>
> > My point was that once you attach a program to sockmap with
> > LINK_CREATE, someone else just doing bpf_prog_attac() shouldn't
> > replace this program anymore. BPF link preserves *attachment
> > lifetime*, not just the program lifetime.
>
> I see. I briefly looked at xdp and cgroup where both support
> link-based attachment and program base attachment.
> For xdp, indeed if link attachment is already done,
> prog attach is not allowed.
> cgroup seems more complicated and need further study to
> confirm whether BPF link preserves attachment in all
> cases or not.

it does, I implemented it, it was an explicit design decision


> But any way, since bpf_link is a new feature for
> sockmap. It makes sense to follow the xdp-link
> style to disallow bpf_prog_attach once link is
> created.
>
> >
> >>>> +       if (ret) {
> >>>> +               bpf_link_cleanup(&link_primer);
> >>>> +               goto out;
> >>>> +       }
> >>>> +
> >>>> +       bpf_prog_inc(prog);
> >>>> +
> >>>> +       return bpf_link_settle(&link_primer);
> >>>> +
> >>>> +out:
> >>>> +       bpf_map_put_with_uref(map);
> >>>> +       return ret;
> >>>> +}
> >>> [...]
