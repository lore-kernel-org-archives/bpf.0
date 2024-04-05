Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C398171E42
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347990; cv=none; b=E73hQD0XKxsfvVAuXV/MymVuWlGblPjUzQMY6/rLBwXVlbyTYBT+XpA9XSf2zBBXiFTzRUxLLbZ74z2vdV6nCuD+VZ4w6iHaXCkaxnJoA60XF9rXQ4CzHxsCCXl0eVJHJl7xlPHf31/8tOoE2p/8p28FWZ2scF5RPpXYUFMnXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347990; c=relaxed/simple;
	bh=VI+14nnW8XBebyo2i7cd9d4ULwFKEuMkLIrDBmL/SNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng/ZFUfmTTUTMJ+9T8/TBC3meLLRTSb9BwPN21FlAYHKaId/HqHUu7Hpj9PP/L7Kah4R2mqBjNnz0NIc3QrAXhZRPf0BPGWNEdIlxStXv/IhAiPOofOydPNeXd+Bpnz08f0/CoTxBFqzsfvWy7qgn3y054OM+QZ+TTkS9o1JZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQtvhHrO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQtvhHrO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e034607879so23019155ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712347988; x=1712952788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DUkicJyjOXfGDld+e/v772Bmxt0P/7OxW+6jultECc=;
        b=nQtvhHrOF1ugiuqmUYnQBaSC2hRAMdybk+Er9l0+vzOEL7MpBwlf4HDttHWC3SkAy9
         8hq0wLE01Tk1jcy56Rl3C5y60guZP7129rt1yaGp3xdUg5IMsvwc6HhjDw23hZroaxDr
         ShM2alL0ZRuybMK2hPqLUzeRUxQVHHnLgDRjSOIN+GiLNjJVKbKxGA9xyGy3bp70x+oQ
         OX8jhO1OJg/CRLzuXORUKREmzgj1uOCP6GFMZ3YcmG/MopsglT7ZDXYvv/Ws0+MT5X6o
         1fEV0AadDZzsvcaHoCAvMA5g1FqeFdLFqZZyA/HlVlMn91+KMANtWzRoif+ol77Byyfd
         PYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347988; x=1712952788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DUkicJyjOXfGDld+e/v772Bmxt0P/7OxW+6jultECc=;
        b=wM+lR3WY4sHUhVk/VCNIQkwnc9fKy80NcE12dW3VMskZr+0s2d8ZTv/j+J/gk17oub
         Lw5yMg9vVz7xuLvUzRJ5BOrno2tVfQr8hUPNLjXSXX4nO/SwQq1026Ua3js/dmxJRzhr
         0NFN+FZ/GlFoIGHAF2m1Yq5JcU22wDKWv443ajK+3aGH4qcqOHki1JIqxTd/vV3wsvbX
         fSNEpaa32YMe1PxBaML9OgFMLmRQ40VcXjfgPXzwMbksPNU7C1ms3O2zBd87zNdZx3lS
         3y/SugdqMdfffAbXmwWpY0ppkIIMK965Y21862cHCCaoQNmGh3yEU6mLHsrWJ6qK3Eeb
         I36Q==
X-Gm-Message-State: AOJu0YwQW3xNiDWBfazKw1oZTAnjrvUR6tmgmvNpSBZNuLZhRkVICQmq
	u1h7JC2imn1qsKGdlG2bTueH+zY0IGZderwB2NIE/Jrt5N97946K2snSMMzQbASOdWOruK/0TfV
	mWbgx1QCUCZ0AZCUmk2HRZRIePogwTTjrONc=
X-Google-Smtp-Source: AGHT+IHVWf9c8POXNmVGwO5OlXx2FGCigGYooOVyXDjTsnG9H2kjChNKclXWbmnPK66alkEBwoLxpu9xXcA+I35nvLM=
X-Received: by 2002:a17:902:e84f:b0:1e0:a735:227a with SMTP id
 t15-20020a170902e84f00b001e0a735227amr3304667plg.1.1712347988399; Fri, 05 Apr
 2024 13:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404025305.2210999-1-yonghong.song@linux.dev> <20240404025310.2211688-1-yonghong.song@linux.dev>
In-Reply-To: <20240404025310.2211688-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 13:12:56 -0700
Message-ID: <CAEf4Bza+V-DerE=Y2cuNNYgyv0jv0b4RH2r3gXt9=uzZzA2JTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
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
>  net/core/sock_map.c            | 268 ++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |   5 +
>  6 files changed, 284 insertions(+), 8 deletions(-)
>

[...]

> @@ -103,7 +111,7 @@ int sock_map_prog_detach(const union bpf_attr *attr, =
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
> @@ -1488,21 +1496,79 @@ static int sock_map_prog_lookup(struct bpf_map *m=
ap, struct bpf_prog ***pprog,
>         return 0;
>  }
>
> +static int sock_map_link_lookup(struct bpf_map *map, struct bpf_link ***=
plink,
> +                               struct bpf_link *link, bool skip_check, u=
32 which)

why not combine prog + link into a single lookup? also it seems like
sock_map_prog_lookup has some additional EBUSY conditions, do we need
to replicate them here?

> +{
> +       struct sk_psock_progs *progs =3D sock_map_progs(map);
> +       struct bpf_link **cur_plink;
> +
> +       switch (which) {
> +       case BPF_SK_MSG_VERDICT:
> +               cur_plink =3D &progs->msg_parser_link;
> +               break;
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +       case BPF_SK_SKB_STREAM_PARSER:
> +               cur_plink =3D &progs->stream_parser_link;
> +               break;
> +#endif
> +       case BPF_SK_SKB_STREAM_VERDICT:
> +               cur_plink =3D &progs->stream_verdict_link;
> +               break;
> +       case BPF_SK_SKB_VERDICT:
> +               cur_plink =3D &progs->skb_verdict_link;
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (!skip_check && ((!link && *cur_plink) || (link && link !=3D *=
cur_plink)))
> +               return -EBUSY;
> +
> +       *plink =3D cur_plink;
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
> +       mutex_lock(&sockmap_mutex);
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

nit: feels more natural to do

if (old) {
    psock_replace_prog(...)
} else {
    psock_set_prog(...)
}

it's two alternatives, not one unlikely vs one main use case (but it's mino=
r)

> +
> +out:
> +       mutex_unlock(&sockmap_mutex);
> +       return ret;
>  }
>
>  int sock_map_bpf_prog_query(const union bpf_attr *attr,
> @@ -1657,6 +1723,192 @@ void sock_map_close(struct sock *sk, long timeout=
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
> +static void sock_map_link_release(struct bpf_link *link)
> +{
> +       struct sockmap_link *sockmap_link =3D container_of(link, struct s=
ockmap_link, link);
> +
> +       if (sockmap_link->map) {

nit: if (!sockmap_link->map) return;

and reduce nesting of everything else

> +               WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL=
, link->prog, link,
> +                                                 sockmap_link->attach_ty=
pe));

I think sockmap_link->map access in general has to be always protected
my sockmap_mutex (I'd do that even for the if above), because it can
race with force-detach logic at least

> +
> +               mutex_lock(&sockmap_mutex);
> +               bpf_map_put_with_uref(sockmap_link->map);
> +               sockmap_link->map =3D NULL;
> +               mutex_unlock(&sockmap_mutex);
> +       }
> +}
> +

[...]

> +       if (old) {
> +               ret =3D psock_replace_prog(pprog, prog, old);
> +               goto out;
> +       }
> +
> +       psock_set_prog(pprog, prog);
> +
> +out:

same nit, feels like

if (old) /* replace */ else /* set */ is more natural, and then you
can move xchg logic before out: knowing that it's the only success
case

> +       if (!ret) {
> +               bpf_prog_inc(prog);
> +               old =3D xchg(&link->prog, prog);
> +               bpf_prog_put(old);
> +       }
> +       mutex_unlock(&sockmap_mutex);
> +       return ret;
> +}
> +

[...]
