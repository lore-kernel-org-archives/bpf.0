Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB723D1A82
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939315; cv=pass; b=UQL+Xu+Vl+fA+EE5M5u5umwY5vAjdbXYfUDQ1mjAJufPNlYw1OqYX0ilC7m1LHomOAXnzUjB7cmz1z/ePg3X+GXfy4bqtXxrF57mEp/UJxCcRr+tu2DCjnQaTgHYgedzVaYhapY1aDfbGNAf/HDsWLGoLka09KdTGNLh8j26TqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939315; c=relaxed/simple;
	bh=QhL6+Og5Q/2hRDexNOZHX54YQpZaWEITisbjv1OZ03M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxaQlXROHHANV16b077xeH7O+JWfdmRD9q1pA4ieqwQoeGkVRbWevKGXwJVKQUKkrLZWh3yE89FNzzvJ7DoN7jCl0zMymOR10MOU5sjh7LsDAdaBqDq5JJIRMSFAGgJ2wHozlBbzCOwq4CeP7g9glw3LxOXqlSaCap1+r22U3qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr+zHCYK; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pr+zHCYK"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1382c509485so1057912c88.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 10:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939312; cv=none;
        d=google.com; s=arc-20240605;
        b=gfjTKfbeqVB/vvidXyiH8ZJQ4bSl71iUCOsG+CgwTMmbojH1+Joi/4U4xAr8shzJHL
         PAS8Je+5QqZlqKONoRRWTLi7v3ekiQtlPVwu46MX1QI6HfMc6u66EMCWT91RtEuC9chB
         taVEAODdo8f5uUTO6qs6HcupNdABMtIWDmdwz8OzlMmHHsbrBsNJiCejC1jbsrNzRS2e
         stZUOrsxVvVxNfEzw+YVtdDeSIr48dCTXqoHHu+wkjkDARBSljWTMiAT+O0sq/2RoFQL
         rcFVmnbCdbuliXB8AIqKZoJwK62zRByrYHRmqknBSfLRkNTkspzXLun54Qbcd+x095c5
         7RnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wd8GNmsbbskCMjCK+uQDvW4BClWHx0VSsIW/uXHLcIQ=;
        fh=gXSLTX2NyvxNpa8+DudFVfhh0W7aVtgAF6OXwC16O1U=;
        b=WbdxsL9jTkdyXOH5IUmWmZSPbOKo2EEazM/BK3+PzzJTbn3LwYpko//2F7WfV/w9D6
         SvEDz8IWSWU17vkBkUQPaIncva2nOt5bayIdhnqUkoS2dJDk2Awly7BWMDbMOt6tbiRi
         3soxa/65tfcaPy/MUK8N8ZPHg+SRErVupUwhHVyvv3gISMYQMPDw4mKVQEvplSR6D0G1
         kQdLBujC0Th6xyXZrZij8f/V1MrUEuc2Vww1IYfS+/BEoY0SAFS3HbSwteOl3VTDL007
         qCGdNmtH3pXmmHb8vBlhQLtUXLSrllaVeXtC4BgPR3Di07J9LY8u6qJquw93eeRCcz1Q
         VWaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780939312; x=1781544112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd8GNmsbbskCMjCK+uQDvW4BClWHx0VSsIW/uXHLcIQ=;
        b=Pr+zHCYKZ61QQRxYPxO77pfbp9wONivQ5ufwLdbowWyUhXqeKmoOKiblLJW4SlzJQj
         2TQFJmAlM8oeZke4LLhcdLhFA2yoeJvWwN4sVlOlSZGmqOB0iLaKSYJ9XByVPLy+ISEH
         lMtKmDmiNwriLYzuDoeLMSqa8ccw85OEo/36sbw7LaxEOSTXmJCNUnyCgEXg9lzN9n3V
         gmR9yOsJeYaCBnsS+1lIAB6PAVUxSg5P82CguyVXA6HSsEc8TLRBf3gqCZFbfeHpVmcS
         8g8zZBf+XDKVqlQ967m9QL8r4SYrYHAnxHCg8LpFo+1o+tGfWiVsfwi0sBDG2G3WAGvt
         0wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939312; x=1781544112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wd8GNmsbbskCMjCK+uQDvW4BClWHx0VSsIW/uXHLcIQ=;
        b=K6Vrb/a8q2+v7p8qgb2Qh5MA20HFsvlURK7nAX73/Jx8O+akfvxId3G/TWjEM4MxBZ
         8xY2EvNCIvXNZc+JWvIPyC2lE3mRkMorZ7qQw7tbBxZWYmu0Liy+Hlj5nKVv1RymX2pE
         cHVpJA7wGDgVltjctX70eVdGWskTNEtEGgy1biO87kQHSNU0L53Oltqs+lpyLoKHuID2
         kORJNyVV10yQu1o9Dbk4cy9/faRaR1gVG3Z8cDtleDZll/hHy8PbQwcdZn0XTVct6EC+
         FujWOs8d8uFDd5sTODtaIFLKtrTDElOOWtEEyGZUwLKhYjwePjWFfY3EbZLZReWFb89B
         1Hyg==
X-Gm-Message-State: AOJu0YxXRM/98sXYUYIZkgX8LYnxQ2kvSoS8HCooQZsDh7WvgOHG/Pgu
	nlpWUc61KpsnwQ3JPuqgXRbGM2akHOS7BHGfPUDVHDVMXpGKNUbNCO76GG+ODjYUfRZI5akB3B+
	JRXR+yBAwh4FNthpmP6Vj/07LiRld1x/FJsoOXury
X-Gm-Gg: Acq92OEs9pIKU0hl3iIH3kpmcSEbuveU5CZbyWJb1wWnl8OK0f8ftNHypZb7jEY1n4E
	B41cihQ3TV7QorsBDwNCDFCsN/dsHcZwIWbYFb8lW2SiNxT+TMnIyXbSqexCRr/GTHWOBvHWvv8
	lIBEwBase3ds92ank7fLHAf1V1+kv/Xfq0+itSwaAhQtgUgH7aEo1i2bZiKU1IN11r0YJgTcEvO
	o3h/rr4704Vc7TiZgrqXxs5OtlPrV/WNFBS9UJP4KgnS9N/zcJLbCBuPA6RxMIsEIAcFAt8Wj6x
	bdohy5pSKghL7w1NVF74ECq6olsV53p7ha3fv9E0QL/s0tJsLmAbcAFk64CCV9IUKllIgcmnLsB
	g+nb/N5rX7ypSxzwx1Xboh2xI0B2Vn7MSYVDSk7BgRUxhASv9WVpLfqZgSwB383XW82hvHxM=
X-Received: by 2002:a05:7022:439a:b0:137:ef27:e2b1 with SMTP id
 a92af1059eb24-13806731a20mr8368591c88.29.1780939311188; Mon, 08 Jun 2026
 10:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev> <20260608125846.157004-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260608125846.157004-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 10:21:40 -0700
X-Gm-Features: AVVi8CdEYEu_V10M8S7Ftf79tPIdsLj4WF1IsqTeM2icUsCKu5PzvQ1A8P3-Rcc
Message-ID: <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> causing a panic when the skb enters the wrong L4 receive path [1].
> An initial attempt tried to fix this in the BPF helper by checking
> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
> this check via a TOCTOU attack by modifying iph->protocol around the
> call:
>
>     iph->protocol =3D IPPROTO_TCP;
>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
>     iph->protocol =3D IPPROTO_UDP;
>
> Furthermore, bpf_sk_assign() has had the same class of vulnerability
> since its introduction =E2=80=94 it can assign any socket type to any skb
> without protocol validation.  Since the BPF helper check alone cannot
> prevent a malicious BPF program from crashing the kernel, add protocol

I'm curious about the BPF maintainers' stance on this kind of "bug"
where admin tries to shoot oneself in the foot.

I saw Alexei said this recently, and I guess it applies here as well ?
https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWHDQu2OW=
Qx27_w@mail.gmail.com/

---8<---
Not every "bug" needs a fix.
If a malicious bpf user wants to crash the kernel they will
find a way to do so. Especially with agents.
We cannot realistically close all of the holes.
Right now the priority is to fix the issues that normal
users can hit and not bots.
---8<---


> validation in skb_steal_sock() to reject mismatched sockets regardless
> of how they were assigned.
>
> The check is applied to all prefetched sockets.  Early demux paths
> already only assign matching protocols (e.g., UDP early demux only
> assigns UDP sockets to UDP skbs), so they pass the check naturally and
> the extra branch is negligible.
>
> Pass the expected protocol from callers rather than extracting it from
> the IP header.  For IPv6, walking extension headers to find the L4
> protocol is complex and unnecessary since each caller already knows
> the protocol it handles.
>
> [1] https://lore.kernel.org/bpf/20260403015851.148209-1-jiayuan.chen@linu=
x.dev/
> [2] https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%4=
0linux.dev
>
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/net/inet6_hashtables.h |  7 ++++---
>  include/net/inet_hashtables.h  |  7 ++++---
>  include/net/request_sock.h     | 16 +++++++++++++++-
>  net/ipv4/udp.c                 |  2 +-
>  net/ipv6/udp.c                 |  2 +-
>  5 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtable=
s.h
> index 2cc5d416bbb5a..218498373a9c1 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -106,12 +106,13 @@ static inline
>  struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int =
doff,
>                               const struct in6_addr *saddr, const __be16 =
sport,
>                               const struct in6_addr *daddr, const __be16 =
dport,
> -                             bool *refcounted, inet6_ehashfn_t *ehashfn)
> +                             bool *refcounted, inet6_ehashfn_t *ehashfn,
> +                             int protocol)
>  {
>         struct sock *sk, *reuse_sk;
>         bool prefetched;
>
> -       sk =3D skb_steal_sock(skb, refcounted, &prefetched);
> +       sk =3D skb_steal_sock(skb, refcounted, &prefetched, protocol);
>         if (!sk)
>                 return NULL;
>
> @@ -153,7 +154,7 @@ static inline struct sock *__inet6_lookup_skb(struct =
sk_buff *skb, int doff,
>         struct sock *sk;
>
>         sk =3D inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6=
h->daddr, dport,
> -                             refcounted, inet6_ehashfn);
> +                             refcounted, inet6_ehashfn, IPPROTO_TCP);
>         if (IS_ERR(sk))
>                 return NULL;
>         if (sk)
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 6e2fe186d0dcb..a2a044f93cc4b 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -446,12 +446,13 @@ static inline
>  struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int d=
off,
>                              const __be32 saddr, const __be16 sport,
>                              const __be32 daddr, const __be16 dport,
> -                            bool *refcounted, inet_ehashfn_t *ehashfn)
> +                            bool *refcounted, inet_ehashfn_t *ehashfn,
> +                            int protocol)
>  {
>         struct sock *sk, *reuse_sk;
>         bool prefetched;
>
> -       sk =3D skb_steal_sock(skb, refcounted, &prefetched);
> +       sk =3D skb_steal_sock(skb, refcounted, &prefetched, protocol);
>         if (!sk)
>                 return NULL;
>
> @@ -494,7 +495,7 @@ static inline struct sock *__inet_lookup_skb(struct s=
k_buff *skb,
>         struct sock *sk;
>
>         sk =3D inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->da=
ddr, dport,
> -                            refcounted, inet_ehashfn);
> +                            refcounted, inet_ehashfn, IPPROTO_TCP);
>         if (IS_ERR(sk))
>                 return NULL;
>         if (sk)
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 5a9c826a7092d..c2b8c6350b624 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -89,9 +89,11 @@ static inline struct sock *req_to_sk(struct request_so=
ck *req)
>   * @skb: sk_buff to steal the socket from
>   * @refcounted: is set to true if the socket is reference-counted
>   * @prefetched: is set to true if the socket was assigned from bpf
> + * @protocol: expected L4 protocol
>   */
>  static inline struct sock *skb_steal_sock(struct sk_buff *skb,
> -                                         bool *refcounted, bool *prefetc=
hed)
> +                                         bool *refcounted, bool *prefetc=
hed,
> +                                         int protocol)
>  {
>         struct sock *sk =3D skb->sk;
>
> @@ -103,6 +105,18 @@ static inline struct sock *skb_steal_sock(struct sk_=
buff *skb,
>
>         *prefetched =3D skb_sk_is_prefetched(skb);
>         if (*prefetched) {
> +               /* A non-full socket here is either a reqsk or a
> +                * timewait sock, both only contain sock_common and
> +                * lack sk_protocol. Since both can only be TCP,
> +                * use IPPROTO_TCP as the protocol.
> +                */
> +               if (unlikely(((sk_fullsock(sk) ? sk->sk_protocol : IPPROT=
O_TCP) !=3D protocol))) {
> +                       skb_orphan(skb);
> +                       *prefetched =3D false;
> +                       *refcounted =3D false;
> +                       return NULL;
> +               }
> +
>  #if IS_ENABLED(CONFIG_SYN_COOKIES)
>                 if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV && inet_reqsk(sk=
)->syncookie) {
>                         struct request_sock *req =3D inet_reqsk(sk);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 0ac2bf4f8759b..ceb4d29a64aca 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2618,7 +2618,7 @@ int udp_rcv(struct sk_buff *skb)
>                 goto csum_error;
>
>         sk =3D inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh=
->source, daddr, uh->dest,
> -                            &refcounted, udp_ehashfn);
> +                            &refcounted, udp_ehashfn, IPPROTO_UDP);
>         if (IS_ERR(sk))
>                 goto no_sk;
>
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 15e032194eccc..d9c12cce5acef 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1106,7 +1106,7 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buf=
f *skb)
>
>         /* Check if the socket is already available, e.g. due to early de=
mux */
>         sk =3D inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, u=
h->source, daddr, uh->dest,
> -                             &refcounted, udp6_ehashfn);
> +                             &refcounted, udp6_ehashfn, IPPROTO_UDP);
>         if (IS_ERR(sk))
>                 goto no_sk;
>
> --
> 2.43.0
>
