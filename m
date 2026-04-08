Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EB3019BA
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622321; cv=pass; b=PBrs10fq0d5D/cHTY0I8ER/9HSOF8AiE60E9wnFbUiQRcbZQn/CaKVE0iOQHgdkuXDtoXWLVsTpdkn50cdsGt0SLxxGANCdM0MVpHWFnrB2u/yMLslS+FxeIRXpNtMWT4NQ4JXvzWVD8M4eYMALVpx+HPX/KRnQoSMLX4t0mAE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622321; c=relaxed/simple;
	bh=EpzLy0TrP73NoJ2rHgGQizmFz11MeqhAFBwsmv///Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfOpdXgHF4xpsFbu81ftp+KI262p1Odl3K4vNNVjHSMD9rXH136MvPYflCemCDS5ICUbnBXMT1ZWpDHaxnjr93gs04YRvyKFq75ghvNzIdvbeOKeplc+fphhlQkKm5lIHcCy45Lgv2IiaXZMfMINsqJkDZ8Q8Hxf75JmMv1adeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/4+g38k; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/4+g38k"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1279eced0b9so7060036c88.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 21:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775622318; cv=none;
        d=google.com; s=arc-20240605;
        b=QxHSKVQpSfAD+/jFnZqPKi88WQ7bhIy1xncU91hhpoiMsbQaohhQRnSoTAvRu1yAY2
         iVB7wFLXjksty6Xlo/Xj6RYkrdBUjdM6e6x+EiYOrmGMl64gsMN3WQC21Pj37Poy/EPq
         fZBlkUcfrvSdWprqz6Bq5AP3GYf13ZBYclhOZ3REl/w6tXgs8GeGKJRsXwUAjBlVrWL2
         g/qzqCmAFNqUjPDAzxRBSIkNze7buYBJSNeBHkgBWukPTA6jRNzzbwQ4RAt5b7NJ+omw
         YcPJG5G0040NmxDcATQNVcSHFwi/u+YMC5rw34fVH7Hnmi044es69TzdYJk+qxDpBAE5
         0tSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OEhPm0Fn+mROzIJC17MAEFSqj+mwf3c5yOCZe00lfA8=;
        fh=T7geaMljwSzRFnX8AhKRoRzQ6sIJjbHF5LT1Y7EOpKU=;
        b=k3T6YDsMrj8HafPK8mOQ5okFQkEpORu6QRHOs15tN7K+x3RDO1ircUDNLuX8U1Ixa6
         G2UKnwohUK1+3l+7prhWJfe5aQTap1JvzgFo5tiaN/hpPn+IU9qGtTocIcAAFcxMZd71
         TkHTS45lVE6ZKbqwgd8UtFeh6mwMLi2rfDYCATdKmOfS+BVEu00EFJA1pn+zWgooeZus
         kxZXu7HHqxKooWcC0+WzsieTVpR9zL+uLmdH7pv3rhFN1j0hcKdRQ2p76xFK3r9e8sEm
         6/xPqIvwf+7Kp5heFlvOB6wlCjdx2Iy5aLLa+TxdXhbyCSV5KP9oX8XdKKApNgnMGMY+
         c93Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775622318; x=1776227118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEhPm0Fn+mROzIJC17MAEFSqj+mwf3c5yOCZe00lfA8=;
        b=a/4+g38kzLxOH0uGnwPsrX6knjIH4N7J9cCFXx00KNM9SzfnwZCDgrT65xHWsnrOKT
         CxAsNU9OPZCIzeR/48RYz6qlkpLkA70dONiM9l00mXG7tmlYtbp2av8dEAHkPDq5qqKN
         KFNWSFiXLfzpXwC8SIrcLJs3qdds4JhqB8BJdQqYnz64ATLGBinVAu+gVJgt8dJ1J7ty
         EFXPWO2bOZtNsch4Ff2D97aBe3JuMgsBpm9PC4RmdDkCMX8atXU1N14vOp9tAk30N8LP
         +C6TK7vZERsY1XhD6K4XmNh1JA/hjkgvE+h21mondwuL4VS3W5aQk42x0L2tN9IagIAM
         QhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775622318; x=1776227118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEhPm0Fn+mROzIJC17MAEFSqj+mwf3c5yOCZe00lfA8=;
        b=YnhJbNr/Q+UHSr77HAYM0uS2vBpJxWhig3iQ39O/hzM1i79UsVYyHYm9GXrhMVpSR2
         yLCinCflXuNHrbif+Ni6HzMjjrPYoC1QU40Rf1dt4/7puWxw85R/TNHQa0GqiP5ui9T0
         SnX3xPIdkCvHefySlsrkaywz/NeE4SKiouHkdRGozvbsVZUYCI326pVSv4coH0B4YXAz
         Y1q9/AaCuMy/9J64XkxN6mLhz3QlWqK3/FCDo9dqxngnB92lfLvO5LMgOTrbMk35NEEy
         EqjTAv2Jcgqi1N3GQlnTZ+m0PDR2v3Hu3Vdn90u1vMgaEQi3UuQ/kQlkIq7mZUihyNIj
         ZgRA==
X-Forwarded-Encrypted: i=1; AJvYcCWCvGvMNxPERtLi+tvEaEv5zc4wpihvqrqg6d9TtcHHzUxsM/smz13T796Ii/kk1Cmv4rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztqp+QPTzAlPGWgbd5sp7Kvfzt/ae5wotx7PrLbLy59KHWOtwS
	0WRvjnFQ7v/QhU72TzL4e6EiBMIareDrszS8FQfDfmH8SPIM1HOVR1RhqvF2n1mAglcAcXfXPWU
	y0Uus8494dYHqj9OI+m410EghfD5b3JK6jmtY3B5l
X-Gm-Gg: AeBDievsiKw5aGGRPoyjAvs/It2E3EbzmMeoZVlxMSZHb3M+a/DgO3JY2EwuscuCMl1
	MGrrYL/X68DlzfCSfqH9FxmdKnTiT3yz0n9HXBnQBdxCWCFVCHKmH+lCSmolSt6nXxtWneKbHP2
	kkXsCNxSJ/JMFYfcgT2ZCjvglVl1B9um7TgOydKsyn22FHi/OOJqRUxzTi3R4ktLNyfVqBk7vjL
	2p7piqiaHIH5SVDIW6+eVupmFR3S/ZVTniyQ7nvJfXXcEFpVNl99fDdRk9/4J4nQCi1+VjySupv
	werg8KVKQXjOyUDE+0kwpxUyBd7mMNVh4IuzwPdOEWawrEKNkZRIhOKsKIYnYL2mesnnxCci
X-Received: by 2002:a05:7022:221c:b0:12b:ebc9:2464 with SMTP id
 a92af1059eb24-12bfb7458e5mr9636002c88.22.1775622317682; Tue, 07 Apr 2026
 21:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403015851.148209-1-jiayuan.chen@linux.dev>
 <20260403015851.148209-2-jiayuan.chen@linux.dev> <20264619471.he8Q.martin.lau@linux.dev>
 <4820d99b-f2c4-4b24-b90f-87e6444284c4@linux.dev>
In-Reply-To: <4820d99b-f2c4-4b24-b90f-87e6444284c4@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 7 Apr 2026 21:25:06 -0700
X-Gm-Features: AQROBzCCNHbhTkKCzfbjbGVVTwKTenDD2XAihH9uMRGOtry1NzFDOyXjYVzYVx4
Message-ID: <CAAVpQUDz_rUFF1A8XDyE13fLTsgdP5k0XWGtdB1V3r=Z_mJW+g@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 10:22=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 4/7/26 3:53 AM, Martin KaFai Lau wrote:
> > On Fri, Apr 03, 2026 at 09:58:27AM +0800, Jiayuan Chen wrote:
> >> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does n=
ot
> >> check the L4 protocol in the IP header. A BPF program can call this kf=
unc
> >> on a UDP skb with a valid TCP listener socket, which will succeed and
> >> attach a TCP reqsk to the UDP skb.
> >>
> >> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
> >> the TCP listener from the reqsk. The UDP code then passes this TCP soc=
ket
> >> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
> >> it to udp_sock and accesses UDP-specific fields at invalid offsets,
> >> causing a null pointer dereference and kernel panic:
> >>
> >>    BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1d=
f0
> >>    Read of size 4 at addr 0000000000000008 by task test_progs/537
> >>
> >>    CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 =
PREEMPT
> >>    Call Trace:
> >>     <IRQ>
> >>     dump_stack_lvl (lib/dump_stack.c:123)
> >>     print_report (mm/kasan/report.c:487)
> >>     kasan_report (mm/kasan/report.c:597)
> >>     __kasan_check_read (mm/kasan/shadow.c:32)
> >>     __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
> >>     udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
> >>     udp_queue_rcv_skb (net/ipv4/udp.c:2532)
> >>     udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
> >>     __udp4_lib_rcv (net/ipv4/udp.c:2742)
> >>     udp_rcv (net/ipv4/udp.c:2937)
> >>     ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
> >>     ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/i=
p_input.c:242)
> >>     ip_local_deliver (net/ipv4/ip_input.c:265)
> >>     __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4=
))
> >>     __netif_receive_skb (net/core/dev.c:6280)
> >>
> >> Fix this by checking the IP header's protocol field in
> >> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
> >>
> >> Note that for IPv6, the nexthdr check does not walk extension headers.
> >> This is uncommon for TCP SYN packets in practice, and keeping it simpl=
e
> >> was agreed upon by Kuniyuki Iwashima.
> > sashiko has flagged a similar issue with larger scope.
> > Please take a look. Thanks.
> >
> > https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%40l=
inux.dev
>
>
> Thanks a lot Martin, sashiko actually dug into a deeper issue here.
>
> Eric and Kuniyuki,
>
> I think the AI review has a point. Since BPF can modify skb fields, the
> following sequence still bypasses the protocol check in
> bpf_sk_assign_tcp_reqsk():
>
>     // for a UDP skb
>     iph->protocol =3D TCP
>     bpf_sk_assign_tcp_reqsk()
>     iph->protocol =3D UDP
>
> On top of that, bpf_sk_assign() already has the same problem =E2=80=94 it=
 doesn't
> validate L4 protocol at all.

Sigh... honestly it does not make sense to me to add changes
in the common fast path to protect someone with bpf capability
shooting oneself in the foot.

On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(),
can't we mark such an skb immutable after the helpers and catch
subsequent writes to skb->data on the verifier ?


>
> So I think we should add a check matching skb against sk in
> skb_steal_sock() instead of adding check in bpf helper.
> (Also, we probably need some MIB counters for this.)

No one increments the counter in the real life.


>
>
>
> Below is my diff:
>
> //The core reason for passing protocol as a parameter rather than
> reading it from
> //the skb is that IPv6 extension headers make it non-trivial to get the
> actual nexthdr.
> //It's much simpler to just let the caller tell us what protocol it expec=
ts.
>
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtable=
s.h
> index c16de5b7963fd..c1032bb9ea864 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -104,12 +104,13 @@ static inline
>   struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb,
> int doff,
>                                const struct in6_addr *saddr, const
> __be16 sport,
>                                const struct in6_addr *daddr, const
> __be16 dport,
> -                             bool *refcounted, inet6_ehashfn_t *ehashfn)
> +                             bool *refcounted, inet6_ehashfn_t *ehashfn,
> +                             int protocol)
>   {
>          struct sock *sk, *reuse_sk;
>          bool prefetched;
>
> -       sk =3D skb_steal_sock(skb, refcounted, &prefetched);
> +       sk =3D skb_steal_sock(skb, refcounted, &prefetched, protocol);
>          if (!sk)
>                  return NULL;
>
> @@ -151,7 +152,7 @@ static inline struct sock *__inet6_lookup_skb(struct
> sk_buff *skb, int doff,
>          struct sock *sk;
>
>          sk =3D inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport,
> &ip6h->daddr, dport,
> -                             refcounted, inet6_ehashfn);
> +                             refcounted, inet6_ehashfn, IPPROTO_TCP);
>          if (IS_ERR(sk))
>                  return NULL;
>          if (sk)
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 5a979dcab5383..0ad73135ece7d 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -433,12 +433,13 @@ static inline
>   struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int
> doff,
>                               const __be32 saddr, const __be16 sport,
>                               const __be32 daddr, const __be16 dport,
> -                            bool *refcounted, inet_ehashfn_t *ehashfn)
> +                            bool *refcounted, inet_ehashfn_t *ehashfn,
> +                            int protocol)
>   {
>          struct sock *sk, *reuse_sk;
>          bool prefetched;
>
> -       sk =3D skb_steal_sock(skb, refcounted, &prefetched);
> +       sk =3D skb_steal_sock(skb, refcounted, &prefetched, protocol);
>          if (!sk)
>                  return NULL;
>
> @@ -469,7 +470,7 @@ struct sock *inet_steal_sock(struct net *net, struct
> sk_buff *skb, int doff,
>          return reuse_sk;
>   }
>
> -static inline struct sock *__inet_lookup_skb(struct sk_buff *skb,
> +static inline struct sock *__tcp_lookup_skb(struct sk_buff *skb,
>                                               int doff,
>                                               const __be16 sport,
>                                               const __be16 dport,
> @@ -481,7 +482,7 @@ static inline struct sock *__inet_lookup_skb(struct
> sk_buff *skb,
>          struct sock *sk;
>
>          sk =3D inet_steal_sock(net, skb, doff, iph->saddr, sport,
> iph->daddr, dport,
> -                            refcounted, inet_ehashfn);
> +                            refcounted, inet_ehashfn, IPPROTO_TCP);
>          if (IS_ERR(sk))
>                  return NULL;
>          if (sk)
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 5a9c826a7092d..80bd209b2323b 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -91,7 +91,8 @@ static inline struct sock *req_to_sk(struct
> request_sock *req)
>    * @prefetched: is set to true if the socket was assigned from bpf
>    */
>   static inline struct sock *skb_steal_sock(struct sk_buff *skb,
> -                                         bool *refcounted, bool
> *prefetched)
> +                                         bool *refcounted, bool
> *prefetched,
> +                                         int protocol)
>   {
>          struct sock *sk =3D skb->sk;
>
> @@ -103,6 +104,24 @@ static inline struct sock *skb_steal_sock(struct
> sk_buff *skb,
>
>          *prefetched =3D skb_sk_is_prefetched(skb);
>          if (*prefetched) {
> +               /* Validate that the stolen socket matches the expected L=
4
> +                * protocol.  BPF (bpf_sk_assign) can mistakenly or
> maliciously
> +                * assign a socket of the wrong type.  If the protocols
> don't
> +                * match, clean up the assignment and return NULL so the
> caller
> +                * falls through to the normal hash table lookup.
> +                *
> +                * For full sockets, check sk_protocol directly.
> +                * For request sockets (only created by
> bpf_sk_assign_tcp_reqsk),
> +                * sk_protocol is not in sock_common and cannot be access=
ed.
> +                * Request sockets are always TCP, so assume IPPROTO_TCP.
> +                */
> +               if ((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) !=
=3D
> protocol) {
> +                       skb_orphan(skb);
> +                       *prefetched =3D false;
> +                       *refcounted =3D false;
> +                       return NULL;
> +               }
> +
>   #if IS_ENABLED(CONFIG_SYN_COOKIES)
>                  if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV &&
> inet_reqsk(sk)->syncookie) {
>                          struct request_sock *req =3D inet_reqsk(sk);
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index c7b2463c2e254..442a9379aefe6 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2188,7 +2188,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>          th =3D (const struct tcphdr *)skb->data;
>          iph =3D ip_hdr(skb);
>   lookup:
> -       sk =3D __inet_lookup_skb(skb, __tcp_hdrlen(th), th->source,
> +       sk =3D __tcp_lookup_skb(skb, __tcp_hdrlen(th), th->source,
>                                 th->dest, sdif, &refcounted);
>          if (!sk)
>                  goto no_tcp_socket;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b60fad393e182..61f7fbf5ffd9c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2728,7 +2728,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct
> udp_table *udptable,
>                  goto csum_error;
>
>          sk =3D inet_steal_sock(net, skb, sizeof(struct udphdr), saddr,
> uh->source, daddr, uh->dest,
> -                            &refcounted, udp_ehashfn);
> +                            &refcounted, udp_ehashfn, IPPROTO_UDP);
>          if (IS_ERR(sk))
>                  goto no_sk;
>
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 010b909275dd0..9c3c25c938ec8 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1115,7 +1115,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct
> udp_table *udptable,
>
>          /* Check if the socket is already available, e.g. due to early
> demux */
>          sk =3D inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr,
> uh->source, daddr, uh->dest,
> -                             &refcounted, udp6_ehashfn);
> +                             &refcounted, udp6_ehashfn, IPPROTO_UDP);
>          if (IS_ERR(sk))
>                  goto no_sk;
>
>
>
>
> ---
> This fix touches the net core path (skb_steal_sock / inet_steal_sock),
> so it probably makes more sense to review it on the net side rather than
> the bpf side.
>
