Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D54364EB2
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226258; cv=pass; b=GnmejxiVqeVdbXo0u+8SR7stq+FKgSUPwkvusPV3rsxBD4uAsWgrk2jBDl36621muCHe+tZP/LGkB9xaiSGFVLofz2O3EMDovVwIAl+0j7nBsodj4rdqB9mqdzOKUHfH5gQpgf9eVfl+hW5AYX3z33/YkZTsXYviOAZCmZf7OKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226258; c=relaxed/simple;
	bh=sMkNhibmcIHRkremZT1q3Qua/h7GiOCly5spXEAKDT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V20ugqQ3t7P+k6POLTUulCvUFqnN4hbcx4N+PCjqD71KIL2D9zc8sugt8EWCTUT51dLg3Te22eVOWnq1JMVUHNNjjuP8hV/Q2fKMkOl7rTdvE5S1tN1cLU2gaApKWrcy8AsmMgMGeOQm2kji/TZ4RiVD7MlxiVQkoIKWweiPKCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIloGflp; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIloGflp"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-130c9dcbd25so2432603c88.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 00:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778226256; cv=none;
        d=google.com; s=arc-20240605;
        b=fzTEfE8He0z4g3NtVdHUt/DvW97jIj7Uy1OIxZCcTrAqz6Jbyas9x9LlYsVdyb9uZC
         E35LhvDt9Cw/rRlyqVCytODSCtBEt9fYUWiRsW7+lj81fjBEY8Glb2i1/Z3LrVhZrJ1M
         W6e/SERN3ag8RxR4vkgwsCC1kTdbDOb1B0btGCTxtr2/2t3rNHw4/C0dKwYCMKM3zErl
         e9Ubm9pjwQwztWE6Pte/wRJ6DvkQluBPgYzCH5AccAdd+atk7JI7T0o4xMt5IWtHegCm
         ilcIwbVDUfV0Q6wOKdag2aAREcK4xtRs87ZLQIb/UoZdBSDz/kaeOxSybvX4QQLYySyM
         3Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pi0joMkG2M93+42Ksix4AKGdNipw+mH9xoz9YwVjrAc=;
        fh=XtoOfSoVn8e4HrMsXJFLL5qU6kvQQfoXvl8cVh5/6to=;
        b=EG3eEzxVIKF/b4JJ9yOsz7H6Xzjj7MP+d7cfAEvn2A3U9BwRCBg7Z+2d4UB6MFke2Q
         pSP+YoZin1nbso3CrZlZlj2yIB3GaVnAxbH0/5NUqik+9hGk/I5/i7l2xGJl2guxJRjg
         wZFbz85L/twogrxoj3/jvMwden9Tn/CLJErR2tZtq1V6u5NRCJ5XUROfcYuqrAFrfvlw
         KFm9Mi4r06nIdnCvr+0kjCXwud0LTQ3A72cBcSAlBE2A/xFg6bgB80IfxxMkOxfyoCN8
         pWozx6m+nzv2rpNf6gzczCCR5h0R2G8suN9mMv9s9ITLZHNl73wEnSGIVLlnGN8pcMx4
         ongw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778226256; x=1778831056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi0joMkG2M93+42Ksix4AKGdNipw+mH9xoz9YwVjrAc=;
        b=QIloGflpnddVYrXyblUfpne1rXkvZJ7Ub+41ex0XRE0rqj5I8sK0afmQLL0oqYC26K
         cl7zcNOQ/V2nIv5DOu/dDhWMTciBHtKV14kTK97CAjlMPwkqIhJvApWaPA+TFi33Dpmm
         xHwG11uO4vxpHNYV9xrtPnCE1ZvQTIjV5cuzazwdC4SHi3IijI5cAj7JpdttePrTWKlI
         Q6flMBcxDQxl12xYp4LKPS/+MRLAQkWopYhia53an2SWc818DWGYCHWwkTcW2JFO2Jji
         FDjGmHU9KEub4+BoxQ5318tkaJeMbGrCRD5qnNlTtoeuFUOXhRVLHTR/NoZRfujsiRCH
         Eblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778226256; x=1778831056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pi0joMkG2M93+42Ksix4AKGdNipw+mH9xoz9YwVjrAc=;
        b=s3ztnnjSUmf7wxPskwbKfuaRU9gK7Mra+BrVW52/XTxk3f9GdTYjF6LLIV6GFkBQsa
         ynYcynsy0KVQy2AMf275390YTXvMIc68jS1o93OCFAhsYAyRZTd7CkqRBD6f2f1Do7rn
         52LY9ApwrjRjwNnV7Be/MpnEi3QKqiiorbOii1htQn+qFxshUN4KzxBD7t6Zgo6XgQJe
         3D4SoAqZt4w74nmzboaJB9q/Jlzq+/tWRyuMnxxIhCSQD6ds+hpG2Zn0vrIts0tQiGMD
         amMq3cWpV19fvhYV0+lO3tqx5BmFtCdlriaFIIDUaX7zZywoKaw0Ypl+UKP5W0qL1YqY
         ySQw==
X-Forwarded-Encrypted: i=1; AFNElJ8pWIlOWlNMD0rh98siliw/gMGHHHBo1GITKwBlEbZdYVS7EHodZNAUWjBH275eyS5kuvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMfB4pi2BMRoy9DR6X2xTARfJx2tn5yj4HihQZMDveN3GIk/J
	8UroULB6fTVD5DVkqRt9P5my32ncBaQsta4QTiAwTuDB+rL7YrLFoKIrxm8IEcqiTKyKxr5XJ+S
	jIRArzvJrJfkRTB/tf8z+swjgqi/miA1f6UVJqnbt
X-Gm-Gg: AeBDievxj8oHMZb2/KSQIXLlFpLb+02GBy4ky4lWPPB89u+bQzaKqpvDs1MzZIzdlwm
	olwGA6CBRDLVK1/4AJkFfUb6uoGEpJ+F7Ium89+EkYFWd7FeZPnIt32eH1/QzBTxNX92rb0nsl6
	ZimicLWKzV/y5IaTEDN5gStZFm9tOrch/z5MfTfH94w7i0RUB5tziSXcUjyA50tSgfaOuN4PQRw
	7imH4n+/ECI2d/GSlllGJDwj8K04slaThfz2YQdXQoJQSk58VmvvBh8ULN2k5T6aODZVUxmi1F4
	ZQLb5jPPfZKW8ey+Ziv4I4gWZkHUQgvhdjAyPH2r+ecivA+ZRGbC/HR/EyK9tWxNB/QsVIAuuZo
	zirXL/Obbamf+BAEF2UtO/a9bmrC4L9k=
X-Received: by 2002:a05:7022:b90:b0:12c:6ebe:b458 with SMTP id
 a92af1059eb24-1323b0abc56mr2860980c88.17.1778226255338; Fri, 08 May 2026
 00:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507104612.236253-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260507104612.236253-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 00:44:04 -0700
X-Gm-Features: AVHnY4Kf-tKGIUBHz4lbVIHn4sjHfFnnyWpgpskKoutXwyLUklAhJoc7UZz6kIA
Message-ID: <CAAVpQUA6z4bZVReNDMToRVL1V7xmYg4Tq2YMnWyU8AYXWoeB5A@mail.gmail.com>
Subject: Re: [PATCH net v7] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Joe Stringer <joe@wand.net.nz>, Martin KaFai Lau <kafai@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 3:46=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
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

Why did you drop selftest ?
Also this patch should go to bpf.git instead of net.git.


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
> index 2cc5d416bbb5..218498373a9c 100644
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
> index 6e2fe186d0dc..a2a044f93cc4 100644
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
> index 5a9c826a7092..3469e4903aed 100644
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
> +               if ((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) !=
=3D protocol) {

Please add unlikely() here.


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
> index 0ac2bf4f8759..ceb4d29a64ac 100644
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
> index 15e032194ecc..d9c12cce5ace 100644
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
