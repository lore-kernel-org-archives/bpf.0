Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FF26ED3C
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593836; cv=pass; b=RHXKmZm7GN+4pmOS3Srj1m2rl8UF5Y5Ich8WdQUzYJzVd++kr3Nm81JYpa8S5OH0GeCrRTK2d0eJqgX7Nd7iYi3vJgrQTHBqYndaeOdQvNxlW8O4Ls+SnVDbZv+js2Z5JuCjfuRcwF5bgA6xhqCEGyMvlN+Fg453rxvKu2r3jU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593836; c=relaxed/simple;
	bh=Mff4l/ItXu9ZqNqYUtUuiPAKYv3iw1pM9tr4xWQgEVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8jQ1DY9Nn4Uf4qN/EB8guwQ46PGMipAStBr5lzUZvmH0zTW8ZTtS9izK53Y6Xi/4dYcfC7Rcud+hjc+0iWUY5SX3TYqHjwREMf2Vrs3IyE2DOL4ba0HXrF/CZGea/IHsxaGhQdW0p6h9p60XOpfWJs2Vm0gJ4CKbw8DWbU9AHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7YkrgAf; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7YkrgAf"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13663f68983so2416700c88.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 20:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779593834; cv=none;
        d=google.com; s=arc-20240605;
        b=kPyn1PPcyENbc7fLKMyojPmkGEqeAapDe4Vrl/0gK2h3XiKU0ui5QNK2PDDhG8fEsf
         dHNwDs+e/ZkcNV25uq+zfSxsuK3yv3BggQp8GgGBJtAEoFXgc1fIUSGF56Js+d781JFU
         R+XRs+xD9aaK8y+n8gcZfkGy/pKRVPekFZnoskfWWmY5i4L929nFIytS52EEpkXtMqCl
         wpj1tuxSCGWA7YEWt7ndVpbabDCfz5jV160sImCVxLcqiLj1emloDMxXk9bBzEbE2B6l
         +Jyi/3n2VG+CL5T8+FQnZZDmcVQ2qjXnNwbTj43svzKjdonc2VHOtekmXv36YUZDRRdj
         OFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xu+3Mbkt9D4gGjs6xNbDhlWV9Mr0QNOutO1d5HR5CM4=;
        fh=D23vILBglrzplMTd9IBX6lXVNoPfOEFQe9X+q2mDFok=;
        b=lqVLMcnT++SYrtvMQ6k991mq+kBRfbSXDxUOgMtzLM/POT1KVuoKiHJd/rJH+7W84z
         whB8/015rsde4nTXwRYLfKaOrBi/iK+vjpG++mtnVUlM8V0ENs360HcqusifIyZMUwXg
         v6dMK7MniXacXvPg9ChdNdCsuBQH4HVV2dMgAUQT+m8zkq4w3arfbLtckKk95dVp1T5Q
         oM1reMPEKSb0f6RrM8VOQn4uwIyWg2Uvc6EsxAcvob4+MGEj7TJqgvchpqoeZgYxsvAI
         VKj4rn97CDeySIBwZtPCxiQxKUWIBirowrcVV2vXDkMi+O0VME83JK3y/qzCzMOxHdEI
         bVkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779593834; x=1780198634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu+3Mbkt9D4gGjs6xNbDhlWV9Mr0QNOutO1d5HR5CM4=;
        b=V7YkrgAfuUKjud69rP53WFp+/WN8XKChKRFb+RWCPY625tHwQa77BewPHwsE3a10Eu
         4XFleIzq7Av1UwTxxGEz4zHPEKbR72Tf44MBJC6vlK96DuCG2uXckdpTsIhUh80NDu0m
         hd1xa1s2QrITJkeg3oazUvZWD734csdHU2Aw2kvQ9uTE5ZVtOt1XZFVAI8eyjK2zao0z
         u51Q2aqXpfy7gSPh2YztWCgS1nceFEpgMC8eP5OyWwTxsl3Ymrimc+BYY6FmWxIsVDh8
         JnzvJrMbNpWZdH20z4rU8HBsiGPaYriTvQVU2bUKoVJMj23eJ+px3Tt3AobERityynMH
         CkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779593834; x=1780198634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xu+3Mbkt9D4gGjs6xNbDhlWV9Mr0QNOutO1d5HR5CM4=;
        b=GV0xXIc9d2tqBJUPquWNpc/vOwh65JXpcteqfsbf/SfrWg1ZSr+fvrTKT5ZAkzc29K
         gGI5XjiVl9i/gpAyIEvu8mzgISKtXwfXuSvt20xE8U2eOV9bru+Oam8yce3/EwrGimKr
         1om5ypI5NZ1gv/5g7Musk0cNSOwfTsR7AJbvLDq8B1ilM58cpAv4Pmv2Jin/W/PQH6A1
         ZqFKgdAhsTarEIhayGyrMIIhcbuC8B0x3hLcb9qMyBY3SfpEcs5WP+lOqposPFdi2Ttf
         AEUJENFl2trUhOugDt17o8eULYFldgdAKAYW/TPRC5tybzwzb961jiqlFof/2mrq6Swn
         slpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wF+IMIZe9mTdt3S2VwNKA4cCdyY3B5fvm1pmmOdJ+d+lYoeAZRSNDNayzMocpTjwfLWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBLpmLc4SpY/7QaDa7zAHkaDHlp5nZqya28Rjz/4yJtp7Q0zM
	F6X7lOE+paqNLiIuE2Pv0efedFPjSKWKIxts+v/rHsn3E4tno4+DkTmmZhFBbkz2RbjperDSoUa
	dwmKe0HrOJuLXBYFPXlBf0MrSK5u7P9wcuDtoQ0PB
X-Gm-Gg: Acq92OGEhu0RjRmAv1MGzskXKeFUUtBqTNwBbs4oQkP5oYpojnR97q777z5Uy3OfJAl
	rHBvpPciQ7VRzD6NlLwV247B3RhTDHGjWnN0OKsyWXlpkm3l8FKuVhEArszMX8YhGwlru+/4kBp
	wNBpuZ9boLJYTZ2AIFe2ViGouIjER8nzklUFBE9JPV1MaEdnB6D8+frRpRjtQHBjXwVtOsmwUdy
	uXWUsT+rTsEVvBekgdZQsoQ+JWKtolEkqvhLSia7VJtPKW43ji59VJt9Ed5hl9GKi7YtfNaIzz8
	VeGrHTk0vY2Zh30J3/gb3hYM69de9ySYDt/HzLXWsshEp1d110Ckoc+8moeNOWkZJDadUKj+1su
	3r8TtLq9vzUeq4O2prBGBUnPknrLGY5wqlJMq8tT4CfOrfVoNt0KSM9QbjRxqqbaITRMoyzPAmA
	==
X-Received: by 2002:a05:7022:126:b0:136:3520:7234 with SMTP id
 a92af1059eb24-1365f70aad4mr3408534c88.12.1779593832929; Sat, 23 May 2026
 20:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-7-kuniyu@google.com> <0c3701f35cdef6411722a91c596d736cc9e88e3d7a14564caf5354302eb92d98@mail.kernel.org>
In-Reply-To: <0c3701f35cdef6411722a91c596d736cc9e88e3d7a14564caf5354302eb92d98@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 23 May 2026 20:37:01 -0700
X-Gm-Features: AVHnY4KgiB0CX2qyM7pkseVw3XHqXKIJ_6Yv9JljSTiebp-5w9SA3Cknk1SaxvE
Message-ID: <CAAVpQUCzzCwCK9+_GRJt53emU_9YQg3zL5Sg=vpPHue1KYr4bA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and
 SOCKMAP mutually exclusive.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:20=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c6a6853909c4..bc95d8e7b62e 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2853,6 +2853,7 @@ struct sk_msg;
> >  struct sk_psock;
> >
> >  #ifdef CONFIG_BPF_SYSCALL
> > +bool tcp_in_sockmap(const struct sock *sk);
> >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool=
 restore);
> >  void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
> >  #ifdef CONFIG_BPF_STREAM_PARSER
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 3608036632a8..1fb63b264b18 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
>
> [ ... ]
>
> > @@ -5382,12 +5382,34 @@ static int bpf_sol_tcp_getsockopt(struct sock *=
sk, int optname,
> >       return 0;
> >  }
> >
> > +static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
> > +{
> > +     if (!(val & BPF_SOCK_OPS_RCVQ_CB_FLAG) ||
> > +         tcp_sk(sk)->bpf_sock_ops_cb_flags & BPF_SOCK_OPS_RCVQ_CB_FLAG=
) {
> > +             tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +             return 0;
> > +     }
> > +
> > +     write_lock_bh(&sk->sk_callback_lock);
> > +
> > +     if (unlikely(tcp_in_sockmap(sk))) {
> > +             write_unlock_bh(&sk->sk_callback_lock);
> > +             return -EBUSY;
> > +     }
> > +
> > +     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +
> > +     write_unlock_bh(&sk->sk_callback_lock);
> > +
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index cc0bd73f36b6..7e7966b095f9 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -705,6 +705,16 @@ int tcp_bpf_strp_read_sock(struct strparser *strp,=
 read_descriptor_t *desc,
> >  }
> >  #endif /* CONFIG_BPF_STREAM_PARSER */
> >
> > +bool tcp_in_sockmap(const struct sock *sk)
> > +{
> > +     const struct proto *prot =3D sk->sk_prot;
> > +
> > +     lockdep_assert_held(&sk->sk_callback_lock);
> > +
> > +     return &tcp_bpf_prots[0][0] <=3D prot &&
> > +             prot <=3D &tcp_bpf_prots[TCP_BPF_NUM_PROTS - 1][TCP_BPF_N=
UM_CFGS - 1];
> > +}
> > +
> >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool=
 restore)
> >  {
> >       int family =3D sk->sk_family =3D=3D AF_INET6 ? TCP_BPF_IPV6 : TCP=
_BPF_IPV4;
> > @@ -729,6 +739,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk=
_psock *psock, bool restore)
> >                       sock_replace_proto(sk, psock->sk_proto);
> >               }
> >               return 0;
> > +     } else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_C=
B_FLAG)) {
> > +             return -EBUSY;
>                    ^^^^
>
> A subsystem pattern flags this as potentially concerning: the commit
> message explains that write_lock_bh(&sk->sk_callback_lock) is taken to
> synchronise with tcp_bpf_update_proto(), but does tcp_bpf_update_proto()
> actually take sk->sk_callback_lock?
>
> Looking at the call chain, tcp_bpf_update_proto() is invoked from the
> SOCKMAP path through:
>
> sock_map_link() in net/core/sock_map.c
>   -> sock_map_init_proto()
>      -> tcp_bpf_update_proto()
>
> In sock_map_link(), sk_callback_lock is acquired after sock_map_init_prot=
o()
> completes, not before.

Oh I assumed it's under lock since sock_map_del_link() and
sk_psock_drop() call it under the lock.

I'll move sock_map_init_proto() under the lock as well.


> The lock is taken when setting sk_user_data to the
> psock, but sock_map_init_proto() runs outside the lock and calls
> sock_replace_proto() to write sk->sk_prot without holding sk_callback_loc=
k.
>
> Is there a race here? Consider this interleaving (the commit message
> acknowledges sock_map_update_elem only holds bh_lock_sock(), so it can ru=
n
> concurrently with setsockopt that holds the socket lock):
>
>   CPU 0 (sockmap path)                   CPU 1 (BPF setsockopt RCVQ_CB)
>   sock_map_link():                       __bpf_sock_ops_cb_flags_set():
>     sk_psock_init():                       (val has RCVQ_CB, current=3D0)
>       lock sk_callback_lock
>       set sk_user_data =3D psock
>       unlock sk_callback_lock
>     sock_map_init_proto():
>       tcp_bpf_update_proto():
>         BPF_SOCK_OPS_TEST_FLAG: 0
>         (no flag yet, check passes)
>                                            write_lock_bh(sk_callback_lock=
)
>                                            tcp_in_sockmap(sk): sk_prot
>                                            still old, returns false
>                                            tp->bpf_sock_ops_cb_flags =3D =
val
>                                            (RCVQ_CB set)
>                                            write_unlock_bh
>         sock_replace_proto(sk,
>           &tcp_bpf_prots[][])
>         (sk_prot now in tcp_bpf_prots)
>
> Final state: sk_prot is in tcp_bpf_prots[][] AND bpf_sock_ops_cb_flags ha=
s
> BPF_SOCK_OPS_RCVQ_CB_FLAG. Both features are now enabled, which violates =
the
> mutual exclusion goal.
>
> The validation checks in tcp_bpf_update_proto() and __bpf_sock_ops_cb_fla=
gs_set()
> each check shared state before the exclusion point, not under common excl=
usion.
> Running a lockset analysis on the two shared variables:
>
>   bpf_sock_ops_cb_flags: written by __bpf_sock_ops_cb_flags_set under
>   sk_callback_lock; read by tcp_bpf_update_proto with no lock.
>   Lockset intersection =3D {sk_callback_lock} intersect {} =3D {}.
>
>   sk->sk_prot: read by tcp_in_sockmap under sk_callback_lock; written by
>   sock_replace_proto (called from tcp_bpf_update_proto) with no lock.
>   Lockset intersection =3D {} intersect {sk_callback_lock} =3D {}.
>
> Could the synchronization be strengthened so both paths access both varia=
bles
> under the same lock?
>
> >       }
> >
> >       if (sk->sk_family =3D=3D AF_INET6) {
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/263285=
41814
