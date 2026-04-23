Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977634402B
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980444; cv=pass; b=c2H8AzsZ1ahYi4nqM4ORuGlszD5HDE/PBaH2qjXqbSm25Tqa+K4shljHxCGrYOUr/1642X8phQMBLsp1+K+qxl9VC1Leg0Gi3unhcugJSk1Bt/FD/nKPtjudqMAJEF+ODeOoxHNBYe+IVoCKaSeqb598WIsCNAzuFdBYFTuugS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980444; c=relaxed/simple;
	bh=LBaojAYoQTEOG485YZ+/4Sb1CgR+bBaYEXRwbg8I+Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QevDZXBng/K0EPda3NXJaNGSIV+aKz9Rah/2sBVvQUpg0D+RhXbKTOeqZNSPJX+8erOMRraqalTqQJDQPF2SaA1zmZwVlrCC6BZGaZG8DXSQizZnE579K5vmTG5TTMe4UamkNlvb0GxXe7C37pPSdz+GibB5+dXNZSnrrgyzZoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT9kswB5; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT9kswB5"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-799001d73bdso52513387b3.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 14:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776980442; cv=none;
        d=google.com; s=arc-20240605;
        b=WYNJokbuVDMFN8b3UaksfQR5KDwWJm+AlYgz5tJlRpKipXsQDijP9SuqNCYjic2PRc
         zXguqqVuobDVw+Qo2Dvjh+TVGpYpezJjAwSSfPJISCRg809dWSZS8RRTB8KSl6zxruK1
         hrE6N58Fm3lXZsKYnRxWf9KvIixoBnXyeUPSj7/6Svu+FbZaVg8ESceGmnlydc2rvv3W
         0leHhHZdR8R8NzchoaeGrSmlsMC7pp0fLWyi5IMRb10X+oYwTEGVpSJuBdfnIFTLcBqs
         QwOum5pyVr0PnrD7fjRLaFELoLd61kyPDX6DNUlwuFuHeQ+feUxqY3Z+n62Zi4dxI/Y8
         JT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZkKWSdXKAjKaTvWAA3BKuowSpND4UX4TINDWGeSiV2c=;
        fh=P9gA31UYDLft4sfTtK+xDh/HHblLAajZoI12JUQmOow=;
        b=WIUGLhWuHOgw+HBSICw0NGq4klfbK9kywAXLXwXmDK3edzmDfqAQZqH15IMKl9jKLF
         keHIIKyT3/8ZujTM+G5mtIJkGp490lEJb5lxV74EQD74Q/bcm4Q3QyYjTX0MGlz3iw9G
         +dlmIvKv7M5dyN3A6itRWAY3bADNqH3RNV4P2JZmYGYS1NNyoqjAxWm5Nf2uRTbJp8K8
         S57cRClFKsLznLjkFiG+NY9SNMHwL8BpV4BnR2bl02iEfuIREp/TiN2K80DcmMS/t+8E
         6U52e8lBuyiIkpPB1/K37iLFAhdGnk6am1ZJhO7oCQ6rSlZ6kV3V/LkpB25Z0JgOLtQP
         XGng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776980442; x=1777585242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkKWSdXKAjKaTvWAA3BKuowSpND4UX4TINDWGeSiV2c=;
        b=jT9kswB5AbFqnbYQcNFbLRH3XsR6TChPt0dYn4uPvdgBQW/Qt8FuGNJEGzqvHL0qGJ
         1YpSp1usCZ1Q77V0+ESt20E1UZ6uQ4iQiEFUPMQQDDAJBv8svpgzgrDv01HYvJbf//k8
         7pZ3yK3tKaJcU3H/2cYRztdnA40hoFXgVTSkk7N2YS3RHWkrD8b1VmnHq8OG4p7h5hw3
         sSDE1VWNfhB63R0z1FNTiUdycOPem5vDHSrdqDpKrcvr3aNWLd4pmU/p6ZiAJFd998/i
         AdponXqt/Wq3vTi1dRuRm2FAd7X3C5T5PYOUQS93O8mZtcfVzLRBK0jFPP7ktVxnYm4P
         K8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980442; x=1777585242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZkKWSdXKAjKaTvWAA3BKuowSpND4UX4TINDWGeSiV2c=;
        b=NA90qEkvt6PzPL/jToOXVvCHwCVLv6iJ26h+ZsqUdqtn8sWEfxCyQXrdTR0hkfOEwM
         NtnFeceGaLBobKXcAcQnfQ9nFyoL+YDxwjyjBccj7r8r88crHocedZFlbAgVLXc8/wNk
         xKaOLqu+JUUjCdW7oLE54jCg8I7UrHX6IlJdIsL04DCy+06B8Yy3CfUzlGAa+iIKiZHG
         rQ27JAV2W3KPCiOc4WFyyxxOGnVOsLLO8wpwIu1b6vAe2nuKHo4i8ToEo6Et+NquC4Q8
         Z8W2heAazg1LFAh/E73x+wcPbKS1RAiGcWC3DLSqhGmc0aCVTw67m29hxAsp6ECCxQ0F
         jPgg==
X-Forwarded-Encrypted: i=1; AFNElJ9RBWOkBneFC3h3F24gi1ozOrPnQJ7QUW6psZydSgEagxcTUjfxInb3d682W8IHiSMxKnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9pf1oobha+VDq7bxSfrNwn0tkxTET9L6TM/tQgjwS5uArjJ4
	3wOUTkX5vDKLUQcfG1FHKz9Kz7UN3TM0veOTqLH30iSeeuokhtKtknsyyKMyQZp5QhpwVUwv/Ow
	gV4+84sM4Jn/ooQruAtp33aKG7oCHpO0=
X-Gm-Gg: AeBDiet8CLJ8muC2D5jkGRv3Ch0Iz3BFHx0ldBMgh1WXZaAM6v2uDLh3YYchkT15lSH
	Dv/bTtWw7B+tpTo4h3KSsI4RcZnkxy1rrxoSYwJ8WqeyPEeXrRUmK7I6ZTKRjE/oYEVhizWean5
	OnuvkhjZpDU0kwUhxz9UG2eAbKpxDF0CjNpaJ5P/iOal+gldadfIA1wRLzrqn1aS/0v6R5cTv7R
	MooOvxjoRtlCK68rzbpGBaQZafkytDImNQqU2YMlm0075zub3lhqhq1kOHaUiCLAtkivCKi5MLr
	BxZD2Cnhr6BKsjirmI5OuBLb8uiZSSk=
X-Received: by 2002:a05:690c:9201:b0:79c:ff02:a048 with SMTP id
 00721157ae682-7b9ece6ad3fmr279055557b3.4.1776980441695; Thu, 23 Apr 2026
 14:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422065411.1007737-2-bestswngs@gmail.com>
In-Reply-To: <20260422065411.1007737-2-bestswngs@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 14:40:27 -0700
X-Gm-Features: AQROBzC34lSJnNThVZ-OV1TLMJPbKer-jB6dylzgNn1S8zHtGmTLEWl0Ij91Jec
Message-ID: <CAMB2axOjSHOBq2_3-N8eZ0twdth2MxtLs8sO9tYDcdE64vkekA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>, Kees Cook <kees@kernel.org>, 
	Fushuai Wang <wangfushuai@baidu.com>, Menglong Dong <menglong8.dong@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:37=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> =
wrote:
>
> bpf_selem_unlink_nofail() sets SDATA(selem)->smap to NULL before
> removing the selem from the storage hlist. A concurrent RCU reader in
> bpf_sk_storage_clone() can observe the selem still on the list with
> smap already NULL, causing a NULL pointer dereference.
>
>  general protection fault, probably for non-canonical address 0xdffffc000=
000000a:
>  KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
>  RIP: 0010:bpf_sk_storage_clone+0x1cd/0xaa0 net/core/bpf_sk_storage.c:174
>  Call Trace:
>   <IRQ>
>   sk_clone+0xfed/0x1980 net/core/sock.c:2591
>   inet_csk_clone_lock+0x30/0x760 net/ipv4/inet_connection_sock.c:1222
>   tcp_create_openreq_child+0x35/0x2680 net/ipv4/tcp_minisocks.c:571
>   tcp_v4_syn_recv_sock+0x123/0xf90 net/ipv4/tcp_ipv4.c:1729
>   tcp_check_req+0x8e1/0x2580 include/net/tcp.h:855
>   tcp_v4_rcv+0x1845/0x3b80 net/ipv4/tcp_ipv4.c:2347
>
> Add a NULL check for smap in bpf_sk_storage_clone().
> bpf_sk_storage_diag_put_all() and bpf_sk_storage_diag_put() have the
> same unprotected dereference pattern, add NULL checks there as well and
> pass the validated smap to diag_get() so it no longer performs its own
> rcu_dereference.
>
> Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or lo=
cal storage")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Amery Hung <ameryhung@gmail.com>

> ---
> v3:
>   pass smap to diag_get()
> v2:
>   drop the NULL check in diag_get(); The caller already checks smap for
> NULL.
>
>  net/core/bpf_sk_storage.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index f8338acebf077..1f9bd0005883b 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -172,7 +172,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struc=
t sock *newsk)
>                 struct bpf_map *map;
>
>                 smap =3D rcu_dereference(SDATA(selem)->smap);
> -               if (!(smap->map.map_flags & BPF_F_CLONE))
> +               if (!smap || !(smap->map.map_flags & BPF_F_CLONE))
>                         continue;
>
>                 /* Note that for lockless listeners adding new element
> @@ -534,10 +534,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_=
stgs)
>  }
>  EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
>
> -static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff=
 *skb)
> +static int diag_get(struct bpf_local_storage_map *smap,
> +                   struct bpf_local_storage_data *sdata, struct sk_buff =
*skb)
>  {
>         struct nlattr *nla_stg, *nla_value;
> -       struct bpf_local_storage_map *smap;
>
>         /* It cannot exceed max nlattr's payload */
>         BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < BPF_LOCAL_STORAGE_MAX_VALUE_S=
IZE);
> @@ -546,7 +546,6 @@ static int diag_get(struct bpf_local_storage_data *sd=
ata, struct sk_buff *skb)
>         if (!nla_stg)
>                 return -EMSGSIZE;
>
> -       smap =3D rcu_dereference(sdata->smap);
>         if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
>                 goto errout;
>
> @@ -599,9 +598,11 @@ static int bpf_sk_storage_diag_put_all(struct sock *=
sk, struct sk_buff *skb,
>         saved_len =3D skb->len;
>         hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
>                 smap =3D rcu_dereference(SDATA(selem)->smap);
> +               if (!smap)
> +                       continue;
>                 diag_size +=3D nla_value_size(smap->map.value_size);
>
> -               if (nla_stgs && diag_get(SDATA(selem), skb))
> +               if (nla_stgs && diag_get(smap, SDATA(selem), skb))
>                         /* Continue to learn diag_size */
>                         err =3D -EMSGSIZE;
>         }
> @@ -633,6 +634,7 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_dia=
g *diag,
>         unsigned int diag_size =3D nla_total_size(0);
>         struct bpf_local_storage *sk_storage;
>         struct bpf_local_storage_data *sdata;
> +       struct bpf_local_storage_map *smap;
>         struct nlattr *nla_stgs;
>         unsigned int saved_len;
>         int err =3D 0;
> @@ -668,7 +670,11 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_di=
ag *diag,
>
>                 diag_size +=3D nla_value_size(diag->maps[i]->value_size);
>
> -               if (nla_stgs && diag_get(sdata, skb))
> +               smap =3D rcu_dereference(sdata->smap);
> +               if (!smap)
> +                       continue;
> +
> +               if (nla_stgs && diag_get(smap, sdata, skb))
>                         /* Continue to learn diag_size */
>                         err =3D -EMSGSIZE;
>         }
> --
> 2.43.0
>
