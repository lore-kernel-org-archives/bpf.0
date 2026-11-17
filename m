Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794913736;
	b=OAz+fG5mYfSLIEsH9E4h3Jq4aGhVGJwT0NSkeSzX8U8cVw6ph2lTOYy7JWPcoPKLshYq
	 fxWOotM8GAC0fzapTZrMBo9o9CGnEyNrABq9LpCfWcpJCb4b2iROfwct50kky0HmTm9V1
	 jKr/edRKrr9FLTZq4T72S2bXhWxS04HQOVSHtV/G/l+jviep6FA+TRkgtlQKYqpCJ+wFt
	 asbo4X7TCoaOrehWWQRgFbwaDQc/HJxUo8GRHYON3OVElvGMF8D3VEizzem5IParXwJt8
	 4GHKu/q19tU6/r8kIMpyTV5uhMPC4Ze59WO39qaN2+gheSrWBvMtJSOfNHCm6ARSrRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ya3rh+b4RSSKfCrvN68HAjlZ1+sxuSEJGaff5SDgpnY=;
	b=en40zGrK2dK/RSX+fE4VOqivZHJuJAbD6skPObu8FCMnhR5v1WVfMvjfDwgXbo/XNJtT
	 iqgwlzgYruUkMB1k1j3NMLia8P4RrwMbkVLljaiBEgR19DJnSNWzjC7kyJK3K/gAybYPs
	 7NzPYq7TJNZYmPhULuXcgO7BDviYZOY0zhAoMGfabMEbGObemPte4V5fEvoOxEfqSd1Al
	 WSNCnRZHWnk3aZuFb6IRUJ5ixCDcGJfxG7UrBzknFi9ewBCOXI2p7Ep7S3fqmWAUnGz41
	 HMpl7t1GVYWttK+9iWFJj5LZ5gSDHDANcfm9ad71t7M+gyPmu4NHoF/EQ3dX0L0w5Zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JCzwZlRX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6B606A323
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A6B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JCzwZlRX
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so3938115b3a.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 03:08:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794913735; cv=none;
        d=google.com; s=arc-20260327;
        b=epbU+o0AbbtVvYlKy+lDSCYtxyajbwfeQS116ur7PHDcij4V521B24AAoXU7wGAgSr
         xu3hmoDA9R1T9S0JxkQa596P0oVyhJoUc/0YOtxHbFw/u10jAXmDuLKlDbIDoQumv8eC
         FQeu1Fkjg6LoGuDo1hxpRpleemFQ4HYy5GtYmacEuUWdVZUgEEhXYPqPbQWgZkjqkm3y
         0ZYJAg7UuTN8hgcLjMOh+BmhfqHQU6LvUBABI0AXSlkN58vY84mcn8Pc57SH5BK8/bmZ
         4Ok83iMAOp6W+SkuFPqBwS2NMC+Jb+sYNwCc/4ZXEzB25qqF8JS8k1TWCHUdhIp98S/U
         iD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ya3rh+b4RSSKfCrvN68HAjlZ1+sxuSEJGaff5SDgpnY=;
        fh=6Jxyp7+lTbAqInapxRkpkvoua6N5RIcbADA99xwJNsY=;
        b=DVF4sLK2lMBvzyd0l/OWLGs6r0F68gNjmg5Dn2qIM2C1xq+U3/Ro5HsUs+M2pRXHhm
         1KP828p0wOnr3PVuPpU4O3flanC4i8terSPYfiMBhslDd10fTEniPln9rtPIut/NHtpE
         jGkDHYfNqxvFfa8SYABjs0GUCq5xd+uXhHJK1/okB40+iROUVpDOGogqejOvAdbvKR9i
         +N9k9XXZ02uhWFzInvU0vt5TqPDK3ghnzNAau5siKqEG/61nQl2I36lhD2kaC3REpd7b
         MDNb8RMmq7h5qFHFH8kOAWRIlA0q8PZHcebibOb6/ylgk2a/GSX+AOo7wE8BmBxu/ftq
         N42w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794913735; x=1795518535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ya3rh+b4RSSKfCrvN68HAjlZ1+sxuSEJGaff5SDgpnY=;
        b=JCzwZlRXovzNOQ79rRxvNbDaH/O1odsoaA0pVWlgcLBlX3LY1ZNuPm/TOJfhs4cqVT
         2H3jES4kEfbHr5JZrebBnnf9KpG2QLYN/uEXXXPtHq+WvPtkmlcGw71JWhZrOynK1icS
         6oEpbE9SMiVtWLNJKhjzDayi8XWZ9a5ATJEP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913735; x=1795518535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ya3rh+b4RSSKfCrvN68HAjlZ1+sxuSEJGaff5SDgpnY=;
        b=NSKX7DZgTDpwTB/JeYjO8jGjMpNVFey1KIy+mooL3yV9DNHIQXu2qj7zEeQOKq6dmp
         ng4j7vP+HP8EhLcjY/wu2ewdmnKxvgoeQOwFjnyPo1hZC0AFI5ovasIBZg1wETVeVhst
         AfKYdIkfadoRpEecCJBLRQi2/gaxq/swy+1iX5dlhfPYY0qQcl8NFOXW4I4Sxr62+Mar
         AT+hoMWjCsZdhFWuxiReZCpWDySONibci0uvrqoRQYfjQ5Qdz+Xtj6Fr105H0yVKY876
         mNiOB6Omb8GQD86Gv3htiz14Pmx7L15tyqZ9PwkBTHlk5o7Ew7yqgr45drss9v7ieLXC
         T/PQ==
X-Forwarded-Encrypted: i=1; AL+hErFIGUmexA1Lxmpc3HkSiRySCLewd5K+qnpU4PAM8+9zeJUJAwFw3BkPhTy+PbUVSo/YWZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y68gzklzhHsOVpoKh7MDTQNDKsagZ8zUZn8/3pwt75CBNcKt+
	e8ZEFheSO9bpSb5e5OQ4XtziQq+xSpXt37SmECGnszGD20i9xiEubqpyX9UULtge5KaJeijzkTO
	FG07OwE0osyE4fDr+ujdr2Dke0rlzyHc30Or+5LBG7zq2qtqFoYA=
X-Gm-Gg: AYBFou3JhDOcSOJJKe2c2I4V+SWoDuTKxplt+VdRCbKeMQ8oANFvI430z2CvnsCEqUQ
	tJFZfUaSWmupvFLJeZ96XYMotFEK25QJ4iytdcuMttAzuKe5pi9v5OU8PWluu2s8Li+b3jctcBm
	le7uMI/j//qAcj9uNUia+kWFDjf+KSOfyJ3IxmFJpvcMrla+NRDXU616EpDX7HT0xGjML7IAh9a
	pJS3E+N3I5tTBvvkS6Wosy4iSK/1LJWP/d8gddy5j1cnAOeaV4UGWBcKLUfsxV5AatlnKgag3Ak
	CmI83rBsIVKrjE57RaMEim3plUaPbwv2OgzrAfojhIKbFy0reioPJCHF7671FymZgUdfmP4HDm+
	XWwO3NfIqJZNtI9OkwfrF1qenhvIcTorFCdS2eJ/3erWFex9IZzMqERLXSuowFXhg5ATWSUZy1b
	8UgdwmS6Ep8UvOWlOsOqSQuXvm6jR2Qii9753Y
X-Received: by 2002:a05:6a21:3d86:b0:3e1:180b:402b with SMTP id
 adf61e73a8af0-3f7a74bcd46mr10374727637.39.1794913734738; Tue, 17 Nov 2026
 03:08:54 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115201824.3680803-1-acassen@corp.free.fr>
In-Reply-To: <20261115201824.3680803-1-acassen@corp.free.fr>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Nov 2026 06:08:43 -0500
X-Gm-Features: AclHuK-Ub9_Qne2dBnz2BsGwkjaD6Vrv1a4Pw878kTzLzPVW9NqPVGbYgz20G1w
Message-ID: <CAM0EoMmzUXV0_Dera1hALH=acm-uc8t8d8x3QJ3PvSmCW=fJvw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: act_api: fold tcf_idr_create_from_flags()
 into tcf_idr_create()
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Ido Schimmel <idosch@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:18=E2=80=AFPM Alexandre Cassen <acassen@corp.free=
.fr> wrote:
>
> All actions but act_simple pick their per CPU stats from the action
> flags through tcf_idr_create_from_flags(). Merge it into
> tcf_idr_create(), which now allocates per CPU stats unless
> TCA_ACT_FLAGS_NO_PERCPU_STATS is set.
>
> act_simple prints the packet count of its plain stats. It now passes
> TCA_ACT_FLAGS_NO_PERCPU_STATS. Its only visible change is the no_percpu
> flag that tc actions ls now shows:
>
>   $ tc actions add action simple sdata incongru
>   $ tc actions ls action simple
>   total acts 1
>
>           action order 0: Simple <incongru>
>            index 1 ref 1 bind 0
>           no_percpu       not_in_hw
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  include/net/act_api.h      |  6 +-----
>  net/sched/act_api.c        | 15 ++-------------
>  net/sched/act_bpf.c        |  4 ++--
>  net/sched/act_connmark.c   |  4 ++--
>  net/sched/act_csum.c       |  4 ++--
>  net/sched/act_ct.c         |  4 ++--
>  net/sched/act_ctinfo.c     |  4 ++--
>  net/sched/act_gact.c       |  4 ++--
>  net/sched/act_gate.c       |  4 ++--
>  net/sched/act_ife.c        |  4 ++--
>  net/sched/act_mirred.c     |  4 ++--
>  net/sched/act_mpls.c       |  4 ++--
>  net/sched/act_nat.c        |  4 ++--
>  net/sched/act_pedit.c      |  4 ++--
>  net/sched/act_police.c     |  4 ++--
>  net/sched/act_sample.c     |  4 ++--
>  net/sched/act_simple.c     |  5 +++--
>  net/sched/act_skbedit.c    |  5 ++---
>  net/sched/act_skbmod.c     |  4 ++--
>  net/sched/act_tunnel_key.c |  5 ++---
>  net/sched/act_vlan.c       |  4 ++--
>  21 files changed, 42 insertions(+), 58 deletions(-)
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index fd03f6319e88..8591486cb877 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -194,11 +194,7 @@ int tcf_generic_walker(struct tc_action_net *tn, str=
uct sk_buff *skb,
>  int tcf_idr_search(struct tc_action_net *tn, struct tc_action **a, u32 i=
ndex);
>  int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *e=
st,
>                    struct tc_action **a, const struct tc_action_ops *ops,
> -                  int bind, bool cpustats, u32 flags);
> -int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
> -                             struct nlattr *est, struct tc_action **a,
> -                             const struct tc_action_ops *ops, int bind,
> -                             u32 flags);
> +                  int bind, u32 flags);
>  void tcf_idr_insert_many(struct tc_action *actions[], int init_res[]);
>  void tcf_idr_cleanup(struct tc_action_net *tn, u32 index);
>  int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 13317d1abde1..7628f64faba4 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -799,7 +799,7 @@ static int tcf_idr_delete_index(struct tcf_idrinfo *i=
drinfo, u32 index)
>
>  int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *e=
st,
>                    struct tc_action **a, const struct tc_action_ops *ops,
> -                  int bind, bool cpustats, u32 flags)
> +                  int bind, u32 flags)
>  {
>         struct tc_action *p =3D kzalloc(ops->size, GFP_KERNEL);
>         struct tcf_idrinfo *idrinfo =3D tn->idrinfo;
> @@ -811,7 +811,7 @@ int tcf_idr_create(struct tc_action_net *tn, u32 inde=
x, struct nlattr *est,
>         if (bind)
>                 atomic_set(&p->tcfa_bindcnt, 1);
>
> -       if (cpustats) {
> +       if (!(flags & TCA_ACT_FLAGS_NO_PERCPU_STATS)) {
>                 p->cpu_bstats =3D netdev_alloc_pcpu_stats(struct gnet_sta=
ts_basic_sync);
>                 if (!p->cpu_bstats)
>                         goto err1;
> @@ -855,17 +855,6 @@ int tcf_idr_create(struct tc_action_net *tn, u32 ind=
ex, struct nlattr *est,
>  }
>  EXPORT_SYMBOL(tcf_idr_create);
>
> -int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
> -                             struct nlattr *est, struct tc_action **a,
> -                             const struct tc_action_ops *ops, int bind,
> -                             u32 flags)
> -{
> -       /* Set cpustats according to actions flags. */
> -       return tcf_idr_create(tn, index, est, a, ops, bind,
> -                             !(flags & TCA_ACT_FLAGS_NO_PERCPU_STATS), f=
lags);
> -}
> -EXPORT_SYMBOL(tcf_idr_create_from_flags);
> -
>  /* Cleanup idr index that was allocated but not initialized. */
>
>  void tcf_idr_cleanup(struct tc_action_net *tn, u32 index)
> diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
> index 3aea3ff5785f..f651098deabf 100644
> --- a/net/sched/act_bpf.c
> +++ b/net/sched/act_bpf.c
> @@ -305,8 +305,8 @@ static int tcf_bpf_init(struct net *net, struct nlatt=
r *nla,
>         index =3D parm->index;
>         ret =3D tcf_idr_check_alloc(tn, &index, act, bind);
>         if (!ret) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, act,
> -                                               &act_bpf_ops, bind, flags=
);
> +               ret =3D tcf_idr_create(tn, index, est, act,
> +                                    &act_bpf_ops, bind, flags);
>                 if (ret < 0) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
> index 0b6ac6be60d2..2844eca7cd26 100644
> --- a/net/sched/act_connmark.c
> +++ b/net/sched/act_connmark.c
> @@ -129,8 +129,8 @@ static int tcf_connmark_init(struct net *net, struct =
nlattr *nla,
>         index =3D parm->index;
>         ret =3D tcf_idr_check_alloc(tn, &index, a, bind);
>         if (!ret) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_connmark_ops, bind, =
flags);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_connmark_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         err =3D ret;
> diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
> index 5fff52a8ca90..72f5e4f3d82c 100644
> --- a/net/sched/act_csum.c
> +++ b/net/sched/act_csum.c
> @@ -69,8 +69,8 @@ static int tcf_csum_init(struct net *net, struct nlattr=
 *nla,
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
>         if (!err) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_csum_ops, bind, flag=
s);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_csum_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 7602733d7f6b..342c6a8d4964 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1427,8 +1427,8 @@ static int tcf_ct_init(struct net *net, struct nlat=
tr *nla,
>                 return err;
>
>         if (!err) {
> -               err =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_ct_ops, bind, flags)=
;
> +               err =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_ct_ops, bind, flags);
>                 if (err) {
>                         tcf_idr_cleanup(tn, index);
>                         return err;
> diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
> index fced4b1094af..876cf8f7e3c3 100644
> --- a/net/sched/act_ctinfo.c
> +++ b/net/sched/act_ctinfo.c
> @@ -212,8 +212,8 @@ static int tcf_ctinfo_init(struct net *net, struct nl=
attr *nla,
>         index =3D actparm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
>         if (!err) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_ctinfo_ops, bind, fl=
ags);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_ctinfo_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
> index ec9a65dfc442..bcd9b87ac347 100644
> --- a/net/sched/act_gact.c
> +++ b/net/sched/act_gact.c
> @@ -104,8 +104,8 @@ static int tcf_gact_init(struct net *net, struct nlat=
tr *nla,
>
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
>         if (!err) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_gact_ops, bind, flag=
s);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_gact_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 711cf2443540..6d64c1d43a23 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -411,8 +411,8 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
>                 return ACT_P_BOUND;
>
>         if (!err) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_gate_ops, bind, flag=
s);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_gate_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index ad77eb303ae7..01f7eef261e1 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -549,8 +549,8 @@ static int tcf_ife_init(struct net *net, struct nlatt=
r *nla,
>         }
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_ife_ops, bind, flags=
);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_ife_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         kfree(p);
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 1c98e4d81ebe..657dbc86c31e 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -171,8 +171,8 @@ static int tcf_mirred_init(struct net *net, struct nl=
attr *nla,
>                                            "Must specify device or block"=
);
>                         return -EINVAL;
>                 }
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_mirred_ops, bind, fl=
ags);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_mirred_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index a870386386d9..58957f6fd3d8 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -196,8 +196,8 @@ static int tcf_mpls_init(struct net *net, struct nlat=
tr *nla,
>                 return ACT_P_BOUND;
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_mpls_ops, bind, flag=
s);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_mpls_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index a201979ac7cf..f9e8e9e26cd1 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -60,8 +60,8 @@ static int tcf_nat_init(struct net *net, struct nlattr =
*nla, struct nlattr *est,
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
>         if (!err) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a, &act=
_nat_ops,
> -                                               bind, flags);
> +               ret =3D tcf_idr_create(tn, index, est, a, &act_nat_ops,
> +                                    bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index 99d7e36510bd..a4eef302cc00 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -196,8 +196,8 @@ static int tcf_pedit_init(struct net *net, struct nla=
ttr *nla,
>         index =3D parm->index;
>         err =3D tcf_idr_check_alloc(tn, &index, a, bind);
>         if (!err) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_pedit_ops, bind, fla=
gs);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_pedit_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_police.c b/net/sched/act_police.c
> index 0b0c09e3dfd9..e36cd8e0c08a 100644
> --- a/net/sched/act_police.c
> +++ b/net/sched/act_police.c
> @@ -80,8 +80,8 @@ static int tcf_police_init(struct net *net, struct nlat=
tr *nla,
>                 return ACT_P_BOUND;
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, NULL, a,
> -                                               &act_police_ops, bind, fl=
ags);
> +               ret =3D tcf_idr_create(tn, index, NULL, a,
> +                                    &act_police_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> index 3029e93c4dea..2acdfa939a81 100644
> --- a/net/sched/act_sample.c
> +++ b/net/sched/act_sample.c
> @@ -69,8 +69,8 @@ static int tcf_sample_init(struct net *net, struct nlat=
tr *nla,
>                 return ACT_P_BOUND;
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_sample_ops, bind, fl=
ags);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_sample_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
> index 80e5084b4dbd..5bded0695482 100644
> --- a/net/sched/act_simple.c
> +++ b/net/sched/act_simple.c
> @@ -134,8 +134,9 @@ static int tcf_simp_init(struct net *net, struct nlat=
tr *nla,
>         }
>
>         if (!exists) {
> -               ret =3D tcf_idr_create(tn, index, est, a,
> -                                    &act_simp_ops, bind, false, flags);
> +               /* tcf_simp_act() prints the packet count of tcf_bstats *=
/
> +               ret =3D tcf_idr_create(tn, index, est, a, &act_simp_ops, =
bind,
> +                                    flags | TCA_ACT_FLAGS_NO_PERCPU_STAT=
S);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> index 1f958b7d2a60..52e999b14284 100644
> --- a/net/sched/act_skbedit.c
> +++ b/net/sched/act_skbedit.c
> @@ -221,9 +221,8 @@ static int tcf_skbedit_init(struct net *net, struct n=
lattr *nla,
>         }
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_skbedit_ops, bind,
> -                                               act_flags);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_skbedit_ops, bind, act_flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
> index 72dedb9b19a6..bde17f9626a1 100644
> --- a/net/sched/act_skbmod.c
> +++ b/net/sched/act_skbmod.c
> @@ -171,8 +171,8 @@ static int tcf_skbmod_init(struct net *net, struct nl=
attr *nla,
>         }
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_skbmod_ops, bind, fl=
ags);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_skbmod_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
> index 28d9cc080101..357be7b3f9e2 100644
> --- a/net/sched/act_tunnel_key.c
> +++ b/net/sched/act_tunnel_key.c
> @@ -507,9 +507,8 @@ static int tunnel_key_init(struct net *net, struct nl=
attr *nla,
>         }
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_tunnel_key_ops, bind=
,
> -                                               act_flags);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_tunnel_key_ops, bind, act_flags=
);
>                 if (ret) {
>                         NL_SET_ERR_MSG(extack, "Cannot create TC IDR");
>                         goto release_tun_meta;
> diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> index e666004bb919..4f784626802f 100644
> --- a/net/sched/act_vlan.c
> +++ b/net/sched/act_vlan.c
> @@ -214,8 +214,8 @@ static int tcf_vlan_init(struct net *net, struct nlat=
tr *nla,
>         action =3D parm->v_action;
>
>         if (!exists) {
> -               ret =3D tcf_idr_create_from_flags(tn, index, est, a,
> -                                               &act_vlan_ops, bind, flag=
s);
> +               ret =3D tcf_idr_create(tn, index, est, a,
> +                                    &act_vlan_ops, bind, flags);
>                 if (ret) {
>                         tcf_idr_cleanup(tn, index);
>                         return ret;
> --
> 2.43.0
>
