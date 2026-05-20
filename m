Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002A36EA9E
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261946; cv=pass; b=iHmEntXvRMqV6huEfIL3/lY7TLjOeBtk6sRbv432OgKWr/M5GDJxwIEcG9/Vd6uWreA2mMwDnYtLH4axJoKWcIHRoy/YnhS4lEzZj+yy+hrP+g2l14UFS8pWKjZBv+rxZCbBe7NuPpvTxPXRD3MIERrzrHkWIB5wfWZZV61qBH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261946; c=relaxed/simple;
	bh=DpuQ8Poe19voowdeiVQ8ziD67bSszQ9be7fcUPBKxIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idc1/3hkCj8dCGpHuEzW4o84YgVhMjgfXk5XHBUmrYIBoPNzTaFoTgqxvaWoqHxm0wgcWAYazASJCHDNs760pRa9GocrdanXifFRQSFgERLOAkH5eOEpKpmHugcSQKnexZ9pz8Hc5Yk3EZNWua5oCq2f4jBpt14W4LmgSJTvurE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ec6ICsQq; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ec6ICsQq"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90f850473f9so475415485a.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 00:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779261943; cv=none;
        d=google.com; s=arc-20240605;
        b=PVnL6R2PbkE/wpE9uJ4+G0PFQO1Ay4gUnpo5hGpAsyVu9N+ESzW4u2fDZTLMFN/UZm
         yAZTH6VAKkMqTqbwUAiTyRc3DuRCJwesxCZSk36qTm2pf6MmvfJUxujDHV6xPw0NWLte
         xw7wRyz7fHdmH4gbMsyqTXiXAEWJ+xM/ovwJWhByXmpa+wAWGg92BhstVJXaQ/JIyav5
         nqiQ8rV1jrx2LzWc3QrwcbKmJUlJQ2SjH2vWh2rkeMw4YZBFe+n92kHw0Kr+fK05lyNg
         IA+/5UO+wVm3n8OL6K7yNzyIF6y6LOq47MNay0sdHsvh6AAA6XydBd3TPZOoULISmtm6
         xsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=576nO/YV1iMXtGVxB8ckBZBIVkpdxC8JVKo+7JWN4sU=;
        fh=gqWd5v6Wk/pyooYphNop3W60x6z42xHpI0foeY5OTiw=;
        b=TG21Hl7yZfSq92Dc1NhVWqbL/7ibb6NJZ1E7gbD1/crDbySqGyNAW7mngSBVE8ZrIy
         /LZDln0RARh4h96vH2yNbdc1oHDH/R9gHM2Ai6s/B2foB3NviNSgq8dBbA/F+S9m0eN0
         rqzKKGWv8f7V5LIEpHYfaN8CyqcUa62Tes7JtWr0WJ3ev40v14NKiafRBrSPn8p7Qv52
         lBnk6RGt7Agg272O0SdxtCygfaYsgqXCUcuvayGoS5rqmk/sfTNQ30+iZesKj+G9Kp5k
         mi8bRQblD9lcnxtoE0/BsIC2vamaKjIGwGj3YcuSVdDBjiV+/bWbzZF0aEEr/jqXHi1B
         y+JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779261943; x=1779866743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=576nO/YV1iMXtGVxB8ckBZBIVkpdxC8JVKo+7JWN4sU=;
        b=ec6ICsQq17b1Z2ur4gUWguyrKA2jIb+YY0KqT92ygBb23smiEkttFk3CrPqmDBAGJe
         IbOXS9AAw7G0k6RaypdkErNhbmuepNvTL6ZKCAWTlzhhrMmcG9mgT87r9VOVDO4VpgQi
         qgoyhOPHH/sG4PRUXvhTNWUMqzrpIV4pHnATKIUN9Gn2SgsHoQarOAL11uerHGgcpRWG
         WP+Jk3ZT8Dqgev3uFAIxiiAAM+VDKggb7SLDuireNm+AlPZzBVve7h5Muhhkujto4JaM
         c4mMmLdq6tqmMMU35m2DSrnhfsHN8ZHl9zrgfxjDYz2TgibV/Pptu2NMi7A2J32T894E
         PiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261943; x=1779866743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=576nO/YV1iMXtGVxB8ckBZBIVkpdxC8JVKo+7JWN4sU=;
        b=j+uto7Z7ZdZPIlDCi76IsrZL65Cr9PPaeyNbWLTOTsMBX2Q3VO9EDmw212c2+/zLb9
         EQKTnov4XNd3dO8AvlABJgqUryBr7fGQPpGGwad+P6bdFCPEutgwYGkdRLl4rs6Whi05
         0sYzZQ0//20XEk0kRVWlQQxjgdE5e0E54ZqclxTBYKHQFvnQ9keLhZLwEL8Xm4IEXPk9
         eDNa9+eSjfgovDC0NQZRALQFpSb4Egj+xZkInQK+v/GaxG7iq2LSmuu99Yxe0RHffrD6
         m7N4NX0T5A0I4QZaCVZxtCraxxExnhzFuP4Vw6xq59ud7h3QGq64v3M6U2wJUnNUt9jZ
         T5bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xB1cbtXpPgN8VvoDw2Po1roLIfTBnAjeMdhTzYt2gMVrqhuLLDPKxTtNpIWJoKdIfe0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSrMDQHha2MRx9f9JCE9sw3RB8zz4LVOvS/SrPVOdFt2Km8QU
	kBd7XfchXxEb5Xg3y+qeugFjz+iGZX2ZCELBNGcm9ids8rW4l2L0MNJYXGWMGes1tQEXPoE9gpC
	2OPITY4MEHJpQPO0W5JDPNaudSuTghtVekBl3Y8AK
X-Gm-Gg: Acq92OHNYf61NN1dugLt1lBDUd2HHto5X4CHIS/hfZxjcefYnziuv3J9IJtXhbZK+HW
	8phK4PsZVqZRytPJHQTY7QEgpeO/NZckmGRnEW7pZyNIyWeOiG7XRn3V5wt1CJ7qGP/XXDc7R7Q
	m+mqLpYcvWzdK9ojsLxPQvTUE1Xhm+UzHkg+W5vxYn+5tq2MMH4y5tnqUSaQI1kOXtUX9Hbe8lL
	VlaSQop6YYTMludXz25zpSXxizJsPJ6L47RnDgdbIoeVaDNW83tKNbpRyz9KHVZb9FviVncI99g
	CubNmQ1o524mHlr+eji9q9h27o/2IXW9CRFc352JtDTNPTxKgN5AP4r2HEIJeMxYFR/UoYs0hy8
	rdq3bAMEj6HyQx0erjJ5v0nMDuKTAvdUa/jF8B+MPnfhNydllfw1c9qUs3KiYpXHe
X-Received: by 2002:a05:620a:2685:b0:90d:b6b7:ca93 with SMTP id
 af79cd13be357-911cef0364fmr3314735185a.47.1779261943125; Wed, 20 May 2026
 00:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520064310.4154268-1-ntspring@meta.com> <20260520064310.4154268-2-ntspring@meta.com>
In-Reply-To: <20260520064310.4154268-2-ntspring@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 May 2026 00:25:32 -0700
X-Gm-Features: AVHnY4JA5ULcAD8FHiBt5X7hD0S7aFEuUITtlQpIRKTp5El2DBtrGA8XL-7n_ec
Message-ID: <CANn89iLoHtMa+94G5NHC5L9Cp4dbkQPKnZneNo08ak4Z6ZzAtg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:43=E2=80=AFPM Neil Spring <ntspring@meta.com> wr=
ote:
>
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
> and spurious-retransmission events, but the cached route is reused and
> the new hash is not propagated into the ECMP path selection logic.  Two
> changes are needed to make rehash select a different local ECMP path:
>
...
>
> Signed-off-by: Neil Spring <ntspring@meta.com>
> ---
>  net/core/filter.c                |  1 +
>  net/ipv4/tcp_input.c             |  6 ++++--
>  net/ipv4/tcp_plb.c               |  7 ++++++-
>  net/ipv4/tcp_timer.c             |  4 ++++
>  net/ipv6/af_inet6.c              |  3 +++
>  net/ipv6/inet6_connection_sock.c |  7 +++++++
>  net/ipv6/syncookies.c            |  4 ++++
>  net/ipv6/tcp_ipv6.c              | 13 +++++++++++--
>  8 files changed, 40 insertions(+), 5 deletions(-)
>
>

...

> diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
> index c11a0cd3f8fe..accdd83dfc3d 100644
> --- a/net/ipv4/tcp_plb.c
> +++ b/net/ipv4/tcp_plb.c
> @@ -78,7 +78,12 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_=
plb_state *plb)
>         if (plb->pause_until)
>                 return;
>
> -       sk_rethink_txhash(sk);
> +       if (sk_rethink_txhash(sk)) {
> +#if IS_ENABLED(CONFIG_IPV6)

Please remove the #if IS_ENABLED(CONFIG_IPV6).
Code will compile just fine if IPV6 is not enabled, and is not
ultra-fast-path anyway.

if (sk_rethink_txhash(sk) && sk->sk_family =3D=3D AF_INET6)
         __sk_dst_reset(sk);


> +               if (sk->sk_family =3D=3D AF_INET6)
> +                       __sk_dst_reset(sk);
> +#endif
> +       }
>         plb->consec_cong_rounds =3D 0;
>         WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
>         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 322db13333c7..24c1c19eda6e 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -300,6 +300,10 @@ static int tcp_write_timeout(struct sock *sk)
>         if (sk_rethink_txhash(sk)) {
>                 WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
>                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH)=
;
> +#if IS_ENABLED(CONFIG_IPV6)

Same remark here.

> +               if (sk->sk_family =3D=3D AF_INET6)
> +                       __sk_dst_reset(sk);
> +#endif
>         }
>
>         return 0;
>
