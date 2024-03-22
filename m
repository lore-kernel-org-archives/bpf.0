Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE086E5EA
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133166; cv=none; b=Hwdjkjb1gAL99xl4hbBn8/FIz7rAnUE7X7HOStozurB1H+CO6rrWlN0cZL+Z7fEIBP2E85e4eUjldEiLGTC6WhuRwWWQGTpoSiiqidvXFLgudDeObIWTA65i4S3092Dse/ezzSyIfeTkECLCSWxXJSvt8T4UQhWq+Kr+JYYX6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133166; c=relaxed/simple;
	bh=/exSn3RmNiATv3lWquAMM3fsJs7ZbpcPfqWBIpHN3Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcAHFVtIm0PbYqcWWrKd1Bz6ey64hqjc3sGV7rCY7ScJqZwaaIe93PqljAYqxSvPA4HQgQXj35k0SWYVZgEYxuCbNnJnSie/ewffr38mbMZ4iip25PlVrI1yKbOJBuI/9k2wN3eqGkVM6TG03Co9+8tHwVD7A6SOe/Nybs/UQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQFvebZA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQFvebZA"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso1738483b3a.3
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711133164; x=1711737964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8WVsTYSme/27zDfzG+gIH200rCx1cHuJJATWUVIbes=;
        b=VQFvebZAPFDKCPTDxzxVbizu6EP6HIy5j9oAhP0CKZo/0orAyijDiieCg4cBHyyz84
         P6/JPWJpclU1EKbunYNZPSJcBvTOOhhbTJL347tjzp4/EX/VVULEF0M4n1IfZKENg0u3
         peGsgR4DQbxUu0hHSEtl7COKsnoG7v/yyqxd6FtqT88pNflxnHEg8Ii8wQENSA0RRhR9
         rQ0ro5RmxZosCpWW3hie4kRMTkWpAooZeqfaHaQNqOuOYKSPkX/YR2dp8DgQ0jVzDGdv
         zQitdeG8ZtOrsAYtxMhRmJ6BH5zc+fONCnWFU2RdXpPJN/hDdZjykNuTrr8W1ZwMLDct
         bzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133164; x=1711737964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8WVsTYSme/27zDfzG+gIH200rCx1cHuJJATWUVIbes=;
        b=kLR/EzX1TtzpHfHZ3Ng71HIDKu4rq7kCIak1qiA9XPPA34nTTtlEk8+AcoRZAsmF5l
         hXuv7JeNK1BWAMPXuiO4Z7trLjRuJxux/f5IQGwEod5CNvsS59habRd750M7SuzRNsU2
         RdNv1G16/VB+uZasFsWS+hHcWvTwVrFIOhm1EZ80XMsU5iXxzVqNajtx55k9cvkr6VMm
         JMXJfUuw6lvqk/cLN8oUidmwSLniyDHqTFvjP4qn/L1Sw2kdC4z/Dt6HxOV45SkiKaS0
         h1iecBaR9QGk4u4psRBfsHdFlKQoC1W1G2JSzysnAozTjHv4gnqT2b9n6fd/4vWAt1cl
         u8iQ==
X-Gm-Message-State: AOJu0YzYoYCcsnpoGYfJDDfDKc+2+MA+HZ8+ylSGB1b46Ak5qBxr/1Yl
	A4JqnUjtuQQEmg78Kq88PPcrUhR8jm4DO8jSISIVxp5NOV5ylzM6gaPK+VKhUGyfqfWgYfauTDD
	UVXIVjhBaQjC18BQgKxRQEffWatJgtPhM
X-Google-Smtp-Source: AGHT+IELtgpHypoiKIW9DZj+e/cbu3A7ZyYYUkZctAsyivKsaJit5LtQKAv0uICf+QdxqnPU3nWwgT3/8OYY+mI7uYY=
X-Received: by 2002:a05:6a00:2349:b0:6ea:9223:54e7 with SMTP id
 j9-20020a056a00234900b006ea922354e7mr590749pfj.32.1711133164309; Fri, 22 Mar
 2024 11:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319175401.2940148-1-yonghong.song@linux.dev> <20240319175406.2940628-1-yonghong.song@linux.dev>
In-Reply-To: <20240319175406.2940628-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 11:45:52 -0700
Message-ID: <CAEf4BzZxD3xQ_3x_576OuvM2pueki=h19b1eyX5i1cqZtWNA4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:54=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Add bpf_link support for sk_msg and sk_skb programs. We have an
> internal request to support bpf_link for sk_msg programs so user
> space can have a uniform handling with bpf_link based libbpf
> APIs. Using bpf_link based libbpf API also has a benefit which
> makes system robust by decoupling prog life cycle and
> attachment life cycle.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h            |  13 +++
>  include/uapi/linux/bpf.h       |  10 ++
>  kernel/bpf/syscall.c           |   4 +
>  net/core/skmsg.c               | 164 +++++++++++++++++++++++++++++++++
>  net/core/sock_map.c            |   6 +-
>  tools/include/uapi/linux/bpf.h |  10 ++
>  6 files changed, 203 insertions(+), 4 deletions(-)
>

[...]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3c42b9f1bada..c5506cfca4f8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1135,6 +1135,8 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_TCX =3D 11,
>         BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
>         BPF_LINK_TYPE_NETKIT =3D 13,
> +       BPF_LINK_TYPE_SK_MSG =3D 14,
> +       BPF_LINK_TYPE_SK_SKB =3D 15,

they are both "sockmap attachments", so maybe we should just have
something like BPF_LINK_TYPE_SOCKMAP ?

>         __MAX_BPF_LINK_TYPE,
>  };
>
> @@ -6718,6 +6720,14 @@ struct bpf_link_info {
>                         __u32 ifindex;
>                         __u32 attach_type;
>                 } netkit;
> +               struct {
> +                       __u32 map_id;
> +                       __u32 attach_type;
> +               } skmsg;
> +               struct {
> +                       __u32 map_id;
> +                       __u32 attach_type;
> +               } skskb;

and then this would be also just one struct, instead of two identical
ones duplicated

>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ae2ff73bde7e..3d13eec5a30d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>         case BPF_PROG_TYPE_SK_LOOKUP:
>                 ret =3D netns_bpf_link_create(attr, prog);
>                 break;
> +       case BPF_PROG_TYPE_SK_MSG:
> +       case BPF_PROG_TYPE_SK_SKB:
> +               ret =3D bpf_sk_msg_skb_link_create(attr, prog);
> +               break;
>  #ifdef CONFIG_NET
>         case BPF_PROG_TYPE_XDP:
>                 ret =3D bpf_xdp_link_attach(attr, prog);
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 4d75ef9d24bf..1aa900ad54d7 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1256,3 +1256,167 @@ void sk_psock_stop_verdict(struct sock *sk, struc=
t sk_psock *psock)
>         sk->sk_data_ready =3D psock->saved_data_ready;
>         psock->saved_data_ready =3D NULL;
>  }
> +
> +struct bpf_sk_msg_skb_link {
> +       struct bpf_link link;
> +       struct bpf_map *map;
> +       enum bpf_attach_type attach_type;
> +};
> +
> +static DEFINE_MUTEX(link_mutex);

maybe more specific name, sockmap_link_mutex? link_mutex sounds very generi=
c

> +
> +static struct bpf_sk_msg_skb_link *bpf_sk_msg_skb_link(const struct bpf_=
link *link)
> +{
> +       return container_of(link, struct bpf_sk_msg_skb_link, link);
> +}
> +

[...]

> +       attach_type =3D attr->link_create.attach_type;
> +       bpf_link_init(&sk_link->link, link_type, &bpf_sk_msg_skb_link_ops=
, prog);
> +       sk_link->map =3D map;
> +       sk_link->attach_type =3D attach_type;
> +
> +       ret =3D bpf_link_prime(&sk_link->link, &link_primer);
> +       if (ret) {
> +               kfree(sk_link);
> +               goto out;
> +       }
> +
> +       ret =3D sock_map_prog_update(map, prog, NULL, attach_type);

Does anything prevent someone else do to remove this program from
user-space, bypassing the link? It's a guarantee of a link that
attachment won't be tampered with (except for SYS_ADMIN-only
force-detachment, which is a completely separate thing).

It feels like there should be some sort of protection for programs
attached through sockmap link here. Just like we have this for XDP,
for example, or any of cgroup BPF programs attached through BPF link.

> +       if (ret) {
> +               bpf_link_cleanup(&link_primer);
> +               goto out;
> +       }
> +
> +       bpf_prog_inc(prog);
> +
> +       return bpf_link_settle(&link_primer);
> +
> +out:
> +       bpf_map_put_with_uref(map);
> +       return ret;
> +}

[...]
