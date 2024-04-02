Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFD159910
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079946; cv=none; b=lr5imo0f4yNfUGssYWjl09beP26DR8GSqez3bepoPC/t0MciMm3KExb8F11m1aKcxGN2BYQzjmGUwnVoftHc7blVsj/G3mesh1N0FPnbaa/X9ISe9cHJ45afmeUDlS3yxr2aNoN+9HecXO4E3ncApDiiWcHUqb/a+xwMP8oQCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079946; c=relaxed/simple;
	bh=O6/61aQKl1rmedzcc0OqAU3V8B9r49Ka+NnITg0xa/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfajXtN9oSMvPIcKnzNqD7mpEbbwZjaVZKMX/lsSk2SN44I2SdKxy+RoovWSqmqs9Z8qptBM/a5/uhpZfOE0L3XtpYOZxYB/HAg4b7VFe5ou12rwPymhVw+wrUGdmHdtOTCxBMm895e9jCQwxGAob/OQ2YvEBDWvSQshRd8Hd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM83R4OI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM83R4OI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e27c303573so6704585ad.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079944; x=1712684744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kkz1OomnSohSEEy6YkvH5uH5llIPSoJHMAPU3XcOtg4=;
        b=IM83R4OI/CFwb/e357XXt7XcaEtSVbcJ26Rw96UnVUmN8BQ5kmj0ONeEZVDURTMaGw
         20vpKRh7XN+nqfOZS72lD4d9oKWcvju6pbgdMN5i5qdXNpKCU3WinQ3Bx2tTNcREg2hp
         G44htO2mcQXnQnTDAzrgeOKYTJigpD78OI/s//vMIY5B4bWL5JrAO5TYYXEgq/5LV8fs
         T7PLF2IKulGYTt+11ejVdzdElKky/73HIfzdqPVdOGGJpsDMAgWQDrHp0Gj9vDbf01mD
         mJJH2GVt75UTMx61vQw0hSUCcsA8f2cVjMl3BUqVjh78JJrGfTGefZDwaaO/OBAZ6Ofo
         nsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079944; x=1712684744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kkz1OomnSohSEEy6YkvH5uH5llIPSoJHMAPU3XcOtg4=;
        b=CDskxtsZ2hTLFQNdSW+zhyobMtZaOXwId9zu2bBCATljDf4/cgniw4DZMNTikBVfd2
         KAkqz208S0VtkariZbvNNUwdp7zfD1nzaZsjKEyvTd9R84+VOECziKNblV+mPdhbeGry
         G4gDHzVvnMvdkWl0GHY8BE/8tZiflvTnZtu7o9dtTbhHHwpLCRQg+3MA3jXwA13IeB8s
         NePsLUVQnzO1gbg+9lyLRMCIuQowhz7M2ncwszPSikanHB89QJ5rpuOM/Q6jiGC6tGK7
         D01tydiST1OOuWCrqIXo2ofZjL+q2LXGET8jR1+IZRg5DsLbfVwpsP6iyUJypyhPBuhG
         y89Q==
X-Gm-Message-State: AOJu0Yw+fSYPHW8wOOZK/XQwtCw/1ac1hyY/g5fR3a6O9H8epuyI70Zf
	9zcdaDGKImxyayMy7t1FQHfApMBxGsz6gdy7pNCeOCT9zD7TtXitGsnQcdDhBflFd6XyDTxZmES
	48dBaHnBydXkyedpQKd0xWcsWzmU=
X-Google-Smtp-Source: AGHT+IGvYJJeeMXRtQepY9gKfIMRNMLQQexK8B/UzR8QQjvuxwfXAw9YGAlDoCoSr0z9J3hp/Lj4TJxprm+7vB3X0fc=
X-Received: by 2002:a17:902:d50f:b0:1e1:6850:f823 with SMTP id
 b15-20020a170902d50f00b001e16850f823mr15748115plg.13.1712079943986; Tue, 02
 Apr 2024 10:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326022153.656006-1-yonghong.song@linux.dev> <20240326022158.656285-1-yonghong.song@linux.dev>
In-Reply-To: <20240326022158.656285-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 10:45:31 -0700
Message-ID: <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:22=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
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
>  include/linux/bpf.h            |   6 +
>  include/linux/skmsg.h          |   4 +
>  include/uapi/linux/bpf.h       |   5 +
>  kernel/bpf/syscall.c           |   4 +
>  net/core/sock_map.c            | 263 ++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |   5 +
>  6 files changed, 279 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 62762390c93d..5034c1b4ded7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2996,6 +2996,7 @@ int sock_map_prog_detach(const union bpf_attr *attr=
, enum bpf_prog_type ptype);
>  int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value=
, u64 flags);
>  int sock_map_bpf_prog_query(const union bpf_attr *attr,
>                             union bpf_attr __user *uattr);
> +int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *pr=
og);
>
>  void sock_map_unhash(struct sock *sk);
>  void sock_map_destroy(struct sock *sk);
> @@ -3094,6 +3095,11 @@ static inline int sock_map_bpf_prog_query(const un=
ion bpf_attr *attr,
>  {
>         return -EINVAL;
>  }
> +
> +static inline int sock_map_link_create(const union bpf_attr *attr, struc=
t bpf_prog *prog)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_BPF_SYSCALL */
>  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index e65ec3fd2799..9c8dd4c01412 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -58,6 +58,10 @@ struct sk_psock_progs {
>         struct bpf_prog                 *stream_parser;
>         struct bpf_prog                 *stream_verdict;
>         struct bpf_prog                 *skb_verdict;
> +       struct bpf_link                 *msg_parser_link;
> +       struct bpf_link                 *stream_parser_link;
> +       struct bpf_link                 *stream_verdict_link;
> +       struct bpf_link                 *skb_verdict_link;
>  };
>
>  enum sk_psock_state_bits {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 9585f5345353..31660c3ffc01 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1135,6 +1135,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_TCX =3D 11,
>         BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
>         BPF_LINK_TYPE_NETKIT =3D 13,
> +       BPF_LINK_TYPE_SOCKMAP =3D 14,
>         __MAX_BPF_LINK_TYPE,
>  };
>
> @@ -6720,6 +6721,10 @@ struct bpf_link_info {
>                         __u32 ifindex;
>                         __u32 attach_type;
>                 } netkit;
> +               struct {
> +                       __u32 map_id;
> +                       __u32 attach_type;
> +               } sockmap;
>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e44c276e8617..7d392ec83655 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>         case BPF_PROG_TYPE_SK_LOOKUP:
>                 ret =3D netns_bpf_link_create(attr, prog);
>                 break;
> +       case BPF_PROG_TYPE_SK_MSG:
> +       case BPF_PROG_TYPE_SK_SKB:
> +               ret =3D sock_map_link_create(attr, prog);
> +               break;
>  #ifdef CONFIG_NET
>         case BPF_PROG_TYPE_XDP:
>                 ret =3D bpf_xdp_link_attach(attr, prog);
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 27d733c0f65e..dafc9aa6e192 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -24,8 +24,12 @@ struct bpf_stab {
>  #define SOCK_CREATE_FLAG_MASK                          \
>         (BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
>
> +static DEFINE_MUTEX(sockmap_prog_update_mutex);
> +static DEFINE_MUTEX(sockmap_link_mutex);
> +
>  static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *pr=
og,
> -                               struct bpf_prog *old, u32 which);
> +                               struct bpf_prog *old, struct bpf_link *li=
nk,
> +                               u32 which);
>  static struct sk_psock_progs *sock_map_progs(struct bpf_map *map);
>
>  static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
> @@ -71,7 +75,7 @@ int sock_map_get_from_fd(const union bpf_attr *attr, st=
ruct bpf_prog *prog)
>         map =3D __bpf_map_get(f);
>         if (IS_ERR(map))
>                 return PTR_ERR(map);
> -       ret =3D sock_map_prog_update(map, prog, NULL, attr->attach_type);
> +       ret =3D sock_map_prog_update(map, prog, NULL, NULL, attr->attach_=
type);
>         fdput(f);
>         return ret;
>  }
> @@ -103,7 +107,7 @@ int sock_map_prog_detach(const union bpf_attr *attr, =
enum bpf_prog_type ptype)
>                 goto put_prog;
>         }
>
> -       ret =3D sock_map_prog_update(map, NULL, prog, attr->attach_type);
> +       ret =3D sock_map_prog_update(map, NULL, prog, NULL, attr->attach_=
type);
>  put_prog:
>         bpf_prog_put(prog);
>  put_map:
> @@ -1488,21 +1492,90 @@ static int sock_map_prog_lookup(struct bpf_map *m=
ap, struct bpf_prog ***pprog,
>         return 0;
>  }
>
> +static int sock_map_link_lookup(struct bpf_map *map, struct bpf_link ***=
plink,
> +                               struct bpf_link *link, bool skip_check, u=
32 which)
> +{
> +       struct sk_psock_progs *progs =3D sock_map_progs(map);
> +
> +       switch (which) {
> +       case BPF_SK_MSG_VERDICT:
> +               if (!skip_check &&
> +                   ((!link && progs->msg_parser_link) ||
> +                    (link && link !=3D progs->msg_parser_link)))
> +                       return -EBUSY;
> +               *plink =3D &progs->msg_parser_link;
> +               break;
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +       case BPF_SK_SKB_STREAM_PARSER:
> +               if (!skip_check &&
> +                   ((!link && progs->stream_parser_link) ||
> +                    (link && link !=3D progs->stream_parser_link)))
> +                       return -EBUSY;
> +               *plink =3D &progs->stream_parser_link;
> +               break;
> +#endif
> +       case BPF_SK_SKB_STREAM_VERDICT:
> +               if (!skip_check &&
> +                   ((!link && progs->stream_verdict_link) ||
> +                    (link && link !=3D progs->stream_verdict_link)))
> +                       return -EBUSY;
> +               *plink =3D &progs->stream_verdict_link;
> +               break;
> +       case BPF_SK_SKB_VERDICT:
> +               if (!skip_check &&
> +                   ((!link && progs->skb_verdict_link) ||
> +                    (link && link !=3D progs->skb_verdict_link)))
> +                       return -EBUSY;
> +               *plink =3D &progs->skb_verdict_link;
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +

you can simplify this by

struct bpf_link *cur_link;

switch (which) {
case BPF_SK_MSG_VERDICT:
    cur_link =3D progs->msg_parser_link;
    break;
case ...

}

and then perform that condition validating link and cur_link just once.


> +       return 0;
> +}
> +
> +/* Handle the following four cases:
> + * prog_attach: prog !=3D NULL, old =3D=3D NULL, link =3D=3D NULL
> + * prog_detach: prog =3D=3D NULL, old !=3D NULL, link =3D=3D NULL
> + * link_attach: prog !=3D NULL, old =3D=3D NULL, link !=3D NULL
> + * link_detach: prog =3D=3D NULL, old !=3D NULL, link !=3D NULL
> + */
>  static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *pr=
og,
> -                               struct bpf_prog *old, u32 which)
> +                               struct bpf_prog *old, struct bpf_link *li=
nk,
> +                               u32 which)
>  {
>         struct bpf_prog **pprog;
> +       struct bpf_link **plink;
>         int ret;
>
> +       mutex_lock(&sockmap_prog_update_mutex);
> +
>         ret =3D sock_map_prog_lookup(map, &pprog, which);
>         if (ret)
> -               return ret;
> +               goto out;
>
> -       if (old)
> -               return psock_replace_prog(pprog, prog, old);
> +       if (!link || prog)
> +               ret =3D sock_map_link_lookup(map, &plink, NULL, false, wh=
ich);
> +       else
> +               ret =3D sock_map_link_lookup(map, &plink, NULL, true, whi=
ch);

it feels like it would be cleaner if sock_map_link_lookup() would just
return already set link (based on which), and then you'd check update
logic with prog vs link right here

e.g., it's quite obfuscated that we validate that there is no link set
currently (this code doesn't do anything with plink).

anyways, I find it a bit hard to follow as it's written, but I'll
defer to John to make a final call on logic

> +       if (ret)
> +               goto out;
> +
> +       if (old) {
> +               ret =3D psock_replace_prog(pprog, prog, old);
> +               if (!ret)
> +                       *plink =3D NULL;
> +               goto out;
> +       }
>
>         psock_set_prog(pprog, prog);
> -       return 0;
> +       if (link)
> +               *plink =3D link;
> +
> +out:
> +       mutex_unlock(&sockmap_prog_update_mutex);

why this mutex is not per-sockmap?

> +       return ret;
>  }
>
>  int sock_map_bpf_prog_query(const union bpf_attr *attr,
> @@ -1657,6 +1730,180 @@ void sock_map_close(struct sock *sk, long timeout=
)
>  }
>  EXPORT_SYMBOL_GPL(sock_map_close);
>
> +struct sockmap_link {
> +       struct bpf_link link;
> +       struct bpf_map *map;
> +       enum bpf_attach_type attach_type;
> +};
> +
> +static struct sockmap_link *get_sockmap_link(const struct bpf_link *link=
)
> +{
> +       return container_of(link, struct sockmap_link, link);
> +}

nit: do you really need this helper? container_of() is a pretty
straightforward by itself, imo

> +
> +static void sock_map_link_release(struct bpf_link *link)
> +{
> +       struct sockmap_link *sockmap_link =3D get_sockmap_link(link);
> +
> +       mutex_lock(&sockmap_link_mutex);

similar to the above, why is this mutex not sockmap-specific? And I'd
just combine sockmap_link_mutex and sockmap_prog_update_mutex in this
case to keep it simple.

> +       if (sockmap_link->map) {
> +               (void)sock_map_prog_update(sockmap_link->map, NULL, link-=
>prog, link,
> +                                          sockmap_link->attach_type);

WARN() if it's not meant to ever fail?

> +               bpf_map_put_with_uref(sockmap_link->map);
> +               sockmap_link->map =3D NULL;
> +       }
> +       mutex_unlock(&sockmap_link_mutex);
> +}
> +
> +static int sock_map_link_detach(struct bpf_link *link)
> +{
> +       sock_map_link_release(link);
> +       return 0;
> +}
> +
> +static void sock_map_link_dealloc(struct bpf_link *link)
> +{
> +       kfree(get_sockmap_link(link));
> +}
> +
> +/* Handle the following two cases:
> + * case 1: link !=3D NULL, prog !=3D NULL, old !=3D NULL
> + * case 2: link !=3D NULL, prog !=3D NULL, old =3D=3D NULL
> + */
> +static int sock_map_link_update_prog(struct bpf_link *link,
> +                                    struct bpf_prog *prog,
> +                                    struct bpf_prog *old)
> +{
> +       const struct sockmap_link *sockmap_link =3D get_sockmap_link(link=
);
> +       struct bpf_prog **pprog;
> +       struct bpf_link **plink;
> +       int ret =3D 0;
> +
> +       mutex_lock(&sockmap_prog_update_mutex);
> +
> +       /* If old prog not NULL, ensure old prog the same as link->prog. =
*/

typo: "is not NULL", "is the same"

> +       if (old && link->prog !=3D old) {

hm.. even if old matches link->prog, we should unset old and set new
link (link overrides prog attachment, basically), it shouldn't matter
if old =3D=3D link->prog, unless I'm missing something?

> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       /* Ensure link->prog has the same type/attach_type as the new pro=
g. */
> +       if (link->prog->type !=3D prog->type ||
> +           link->prog->expected_attach_type !=3D prog->expected_attach_t=
ype) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D sock_map_prog_lookup(sockmap_link->map, &pprog,
> +                                  sockmap_link->attach_type);
> +       if (ret)
> +               goto out;
> +
> +       /* Ensure the same link between the one in map and the passed-in.=
 */
> +       ret =3D sock_map_link_lookup(sockmap_link->map, &plink, link, fal=
se,
> +                                  sockmap_link->attach_type);
> +       if (ret)
> +               goto out;
> +
> +       if (old)
> +               return psock_replace_prog(pprog, prog, old);
> +
> +       psock_set_prog(pprog, prog);
> +
> +out:
> +       if (!ret)
> +               bpf_prog_inc(prog);
> +       mutex_unlock(&sockmap_prog_update_mutex);
> +       return ret;
> +}
> +
> +static u32 sock_map_link_get_map_id(const struct sockmap_link *sockmap_l=
ink)
> +{
> +       u32 map_id =3D 0;
> +
> +       mutex_lock(&sockmap_link_mutex);
> +       if (sockmap_link->map)
> +               map_id =3D sockmap_link->map->id;
> +       mutex_unlock(&sockmap_link_mutex);
> +       return map_id;
> +}
> +
> +static int sock_map_link_fill_info(const struct bpf_link *link,
> +                                  struct bpf_link_info *info)
> +{
> +       const struct sockmap_link *sockmap_link =3D get_sockmap_link(link=
);
> +       u32 map_id =3D sock_map_link_get_map_id(sockmap_link);
> +
> +       info->sockmap.map_id =3D map_id;
> +       info->sockmap.attach_type =3D sockmap_link->attach_type;
> +       return 0;
> +}
> +
> +static void sock_map_link_show_fdinfo(const struct bpf_link *link,
> +                                     struct seq_file *seq)
> +{
> +       const struct sockmap_link *sockmap_link =3D get_sockmap_link(link=
);
> +       u32 map_id =3D sock_map_link_get_map_id(sockmap_link);
> +
> +       seq_printf(seq, "map_id:\t%u\n", map_id);
> +       seq_printf(seq, "attach_type:\t%u\n", sockmap_link->attach_type);
> +}
> +
> +static const struct bpf_link_ops sock_map_link_ops =3D {
> +       .release =3D sock_map_link_release,
> +       .dealloc =3D sock_map_link_dealloc,
> +       .detach =3D sock_map_link_detach,
> +       .update_prog =3D sock_map_link_update_prog,
> +       .fill_link_info =3D sock_map_link_fill_info,
> +       .show_fdinfo =3D sock_map_link_show_fdinfo,
> +};
> +
> +int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *pr=
og)
> +{
> +       struct bpf_link_primer link_primer;
> +       struct sockmap_link *sockmap_link;
> +       enum bpf_attach_type attach_type;
> +       struct bpf_map *map;
> +       int ret;
> +
> +       if (attr->link_create.flags)
> +               return -EINVAL;
> +
> +       map =3D bpf_map_get_with_uref(attr->link_create.target_fd);
> +       if (IS_ERR(map))
> +               return PTR_ERR(map);

check that map is SOCKMAP?

> +
> +       sockmap_link =3D kzalloc(sizeof(*sockmap_link), GFP_USER);
> +       if (!sockmap_link) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       attach_type =3D attr->link_create.attach_type;
> +       bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_m=
ap_link_ops, prog);
> +       sockmap_link->map =3D map;
> +       sockmap_link->attach_type =3D attach_type;
> +
> +       ret =3D bpf_link_prime(&sockmap_link->link, &link_primer);
> +       if (ret) {
> +               kfree(sockmap_link);
> +               goto out;
> +       }
> +
> +       ret =3D sock_map_prog_update(map, prog, NULL, &sockmap_link->link=
, attach_type);
> +       if (ret) {
> +               bpf_link_cleanup(&link_primer);
> +               goto out;
> +       }
> +
> +       bpf_prog_inc(prog);

if link was created successfully, it "inherits" prog's refcnt, so you
shouldn't do another bpf_prog_inc()? generic link_create() logic puts
prog only if this function returns error

> +
> +       return bpf_link_settle(&link_primer);
> +
> +out:
> +       bpf_map_put_with_uref(map);
> +       return ret;
> +}
> +
>  static int sock_map_iter_attach_target(struct bpf_prog *prog,
>                                        union bpf_iter_link_info *linfo,
>                                        struct bpf_iter_aux_info *aux)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 9585f5345353..31660c3ffc01 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1135,6 +1135,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_TCX =3D 11,
>         BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
>         BPF_LINK_TYPE_NETKIT =3D 13,
> +       BPF_LINK_TYPE_SOCKMAP =3D 14,
>         __MAX_BPF_LINK_TYPE,
>  };
>
> @@ -6720,6 +6721,10 @@ struct bpf_link_info {
>                         __u32 ifindex;
>                         __u32 attach_type;
>                 } netkit;
> +               struct {
> +                       __u32 map_id;
> +                       __u32 attach_type;
> +               } sockmap;
>         };
>  } __attribute__((aligned(8)));
>
> --
> 2.43.0
>
