Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5D2FE566
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920113; cv=pass; b=hRLR0/Kk+7QimHy6O9GIZW9geKP0hr4HLA9V0Y2sdWREBSShZMLZ8rbfkBxbmkNXxniaglJWMXJjTX2zXhoL3RbXyTbvkyhlrqC+2rdA007CpKo145cFfo3+JNu8cwMRaXPltq4oHPTNa0CUQQJ7zF9T+U5jiyzJhHkimQ2fXE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920113; c=relaxed/simple;
	bh=fvTz1IRpJxhKnPo++V+kL9b5IKkpiz5dUGWbBQKfCKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7i07W1YT3R1hLEUlS5tw35jW5xhTHT7x7YUI2NCCb8qQOC1oVSaG3q3tN63+sU3AndptXssBOZInftaJM0tBcPvgHgoj2cAmqUWca3VmElGK2fZYJWwbNVk+QmNatcMAV71u5eUoXTA5KdurVfMNZNaODt/8WfhYFs2SRcGoog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYX41Z4M; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYX41Z4M"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12732165d1eso7082907c88.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774920111; cv=none;
        d=google.com; s=arc-20240605;
        b=N8Qv+RjqoYYlTfsqkLIQe7Ja8HKkeQfRHZnlVhIJEBXNOXsZEazYsEd86qlS12jgJT
         wswDZq1MlTwUipY+B8STa5gwz4pfoN/9/FRH72/ZyPlnp5l7aO4DavrzqlyuE7m/p9XA
         JOzTN9EQOhkeJXBpx0G31EooWtAdMXrjRKccN9iRguSnYHEsy1ZVsbPEAmkqqj2FhU7C
         NP3bHajYnGLGfVf8N8Q5VoybYN6YZtqwcVdX7e+LdqNQzwXd0E2+vOtwZ7W1RSh9JOpx
         Z0lutvsijU4SyFPyPXk6KVSQ/mgWryomD9idsuw7KDDbWtS3+EhyvbADAfty/x59cdR4
         KJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=asBUfDtRMKucrOKQSzjBlvbQiLLd54e8FYUI/VhTDuw=;
        fh=WN6UgUcY94ROilPZ6A3nXIlh/fdTiz+2icgdzOqr4oQ=;
        b=kmloGG19WptqluudGDi9NlbgaJOrHbeT2LbxJzNYMUKkB6VtDDZQ8WozxJIlLnAcrC
         0kgXPtm8ro9yPzZU+rkECmU1ijVNANh9OwjMJFNLHIrr9M9K9PkjEidTYwplYYAsfurM
         p9p6bOHxiaYWdDkSBudcMlnKxmV5jMw69R+0c0x6ml29zHhYUzSp4bOI6ONGd0TRhIeQ
         usjQqychiYvMoWA36dB/xkYIYGOanPLm5bArgIj7YDkLa2KSWEgNMREra08w8tlLTS+L
         8A96SI2g5XBj7EgOa1/noS8bQQbfF8JiIlxNLicl6A8MrGtZz8tu7WeYLXNFXeSfnnoE
         VJKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774920111; x=1775524911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asBUfDtRMKucrOKQSzjBlvbQiLLd54e8FYUI/VhTDuw=;
        b=qYX41Z4Mo42xNMxlacd/QMopWmBw2APmtSbMo86UKr+17KCS50DAH57KCPkzRj/hu6
         vjltyH/8A6Mx9etEFr/jS4C53PjM4gu8op3BYB8fMv5b86Npzg629XRdXEvcaBm4E/vH
         PqlndsB8FgDaLZCssx3g3WVSkbDscAxDX85hzK2qPJ1KckNx532zDhryjKEJ97D39U+u
         3WSyYh/pEgv3sPpc+HcsnOspEFJilUePV4LqgnAImvQvJfFXR9ucs92mGk/INa0WIV8x
         OnN3pe1F2aknW2Ey4LN92RMY81u5l6Y8PS5Xdht1Tz62EsXfYZhIi33qKhe5ZGmW4dSN
         DcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774920111; x=1775524911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asBUfDtRMKucrOKQSzjBlvbQiLLd54e8FYUI/VhTDuw=;
        b=hHMIbde7cezDJNMvfmt8V9ccFiQAnNOUhvGwVdTR5P1E+WWL3jhjqv4ukK+8V8i3BJ
         z4I7lb3leJdWhHHGVqGpV+mZZHn1/UDmK2Y7RuwgYR0siESOHQvsthZ3YjhqwFeMbC/t
         2hZxh46pmWN6tb/WtX8jS0M7v4qjB/zNHNXUzJJtLp2cScnnvaZ5W7oUgoMEEWu1fTjz
         JeW97UdtVGwdvnCLRzGu1HiuzbuMojsWNzgOAk6f0ywzb4DURBg6Zp4ur7npSZqXuY5h
         8fVaGJZMganaYlbMAd/1UhOLepy48/vFkWjlTqkIq27BI9BsYrxAEbT/iPqI8r0yzsZN
         0CmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pntBta7qCQRUTrF25LZgi9OFI5R9p5Utot+CrsBIOlS0oWLcEW+UGYyiG7ea0kIZghY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywszum7M9ryHEK6aX9YPFME3ycAeOO5HAhUjVkDT/OjAnoOCtet
	4HzelCjGVPX+SOBNJ+sxD2T/TFBPwqHt/z6eeH4vscB05W7BkHAN15fn3c5XK0wlmOX/0vnnpZy
	t/hm9R8o55WJZRL7D2WC/ipwMNz5ShT18eoWRVt5t
X-Gm-Gg: ATEYQzzmUPp2lH1OqjVyzr7KociXMB5RCdkt1SoniuQAcrAY84xilwU/TqAFcIn4a8t
	UwahLf67rpFCi2nLntRf0U0x/ZUupkszZLP9hqiU+vAhgRvtvh/H5TyytReggWtCGXzhGgrR+hd
	yRGrEiErRosoCdbjAsBEhAbFTDxQpjLn/z+71anCkMEU5FaNCB1ULjLaNZXn9zVYJYlYHR+Bxk+
	izGvPWUJQlFML4sdTWPz7DAHqmdxxgFKTeqPad4f3P5IIWmCUOMEowkmWAWJ/AleGVzGNS0wgYz
	YUejD4eTiT7kF3i2MjYifItNXCCmM5t5r3J6h7DlV03O2Z3gOjSzcg+7NZlGpZaqOqD9pIQy
X-Received: by 2002:a05:7022:2209:b0:128:ea68:27f6 with SMTP id
 a92af1059eb24-12ab28fda86mr8134739c88.36.1774920110404; Mon, 30 Mar 2026
 18:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com> <20260330215707.2374657-2-jrife@google.com>
In-Reply-To: <20260330215707.2374657-2-jrife@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Mar 2026 18:21:39 -0700
X-Gm-Features: AQROBzCDjrWJyJmfSCXtFAx4PFUj1XlE0JIrlHyoRlyN8IxuQEL9bzRmPAc5E0k
Message-ID: <CAAVpQUDk1ywgsuCtreVCV4yVJRm_mcjsnC-+LuUwLRLHWavtZA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/4] udp: Only compare daddr/dport when
 sk_state == TCP_ESTABLISHED
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 2:57=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> Adjust lookups and scoring to keep their results equivalent to before
> even if inet_daddr+inet_dport are left intact after disconnecting a
> socket (sk_state =3D=3D TCP_CLOSE). sk_state =3D=3D TCP_ESTABLISHED impli=
es that
> *daddr is non-zero, so remove redundant checks for that at the same
> time. Note that __udp6_lib_demux_lookup already checks if sk_state =3D=3D
> TCP_ESTABLISHED, so no change was needed there [1].
>
> I could find no discernible difference in performance in
> udp4_lib_lookup2 before and after the change in compute_score.

What workload did you test the series with ?

I think we want to see results under DDoS.


>
> (AMD Ryzen 9 9900X)
>
> kprobe:udp4_lib_lookup2 {
>         @start[cpu] =3D nsecs;
> }
> kretprobe:udp4_lib_lookup2 {
>         @lookup[cpu] =3D hist(nsecs - @start[cpu], 2);
> }
>
> BEFORE
> =3D=3D=3D=3D=3D=3D
> @lookup[11]:
> [80, 96)         1387077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [96, 112)         364973 |@@@@@@@@@@@@@                                  =
     |
> [112, 128)         34261 |@                                              =
     |
> [128, 160)          7246 |                                               =
     |
> [160, 192)           215 |                                               =
     |
> [192, 224)           126 |                                               =
     |
>
> AFTER
> =3D=3D=3D=3D=3D
> @lookup[11]:
> [80, 96)         1408594 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [96, 112)         340568 |@@@@@@@@@@@@                                   =
     |
> [112, 128)         30753 |@                                              =
     |
> [128, 160)          8019 |                                               =
     |
> [160, 192)           231 |                                               =
     |
> [192, 224)           157 |                                               =
     |
>
> [1]: https://lore.kernel.org/netdev/20170623222537.130493-1-tracywwnj@gma=
il.com/
>
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  net/ipv4/udp.c | 20 +++++++++++---------
>  net/ipv6/udp.c | 18 +++++++++---------
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b60fad393e18..d91c587c3657 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -385,16 +385,16 @@ static int compute_score(struct sock *sk, const str=
uct net *net,
>         score =3D (sk->sk_family =3D=3D PF_INET) ? 2 : 1;
>
>         inet =3D inet_sk(sk);
> -       if (inet->inet_daddr) {
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
>                 if (inet->inet_daddr !=3D saddr)
>                         return -1;
>                 score +=3D 4;
> -       }
>
> -       if (inet->inet_dport) {
> -               if (inet->inet_dport !=3D sport)
> -                       return -1;
> -               score +=3D 4;
> +               if (inet->inet_dport) {
> +                       if (inet->inet_dport !=3D sport)
> +                               return -1;
> +                       score +=3D 4;
> +               }
>         }
>
>         dev_match =3D udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
> @@ -796,8 +796,9 @@ static inline bool __udp_is_mcast_sock(struct net *ne=
t, const struct sock *sk,
>
>         if (!net_eq(sock_net(sk), net) ||
>             udp_sk(sk)->udp_port_hash !=3D hnum ||
> -           (inet->inet_daddr && inet->inet_daddr !=3D rmt_addr) ||
> -           (inet->inet_dport !=3D rmt_port && inet->inet_dport) ||
> +           (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +            (inet->inet_daddr !=3D rmt_addr ||
> +            (inet->inet_dport !=3D rmt_port && inet->inet_dport))) ||
>             (inet->inet_rcv_saddr && inet->inet_rcv_saddr !=3D loc_addr) =
||
>             ipv6_only_sock(sk) ||
>             !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
> @@ -2854,7 +2855,8 @@ static struct sock *__udp4_lib_demux_lookup(struct =
net *net,
>         ports =3D INET_COMBINED_PORTS(rmt_port, hnum);
>
>         udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> -               if (inet_match(net, sk, acookie, ports, dif, sdif))
> +               if (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +                   inet_match(net, sk, acookie, ports, dif, sdif))
>                         return sk;
>                 /* Only check first socket in chain */
>                 break;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 010b909275dd..b93a9a3e7678 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -147,16 +147,16 @@ static int compute_score(struct sock *sk, const str=
uct net *net,
>         score =3D 0;
>         inet =3D inet_sk(sk);
>
> -       if (inet->inet_dport) {
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
>                 if (inet->inet_dport !=3D sport)
>                         return -1;
>                 score++;
> -       }
>
> -       if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
> -               if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> -                       return -1;
> -               score++;
> +               if (!ipv6_addr_any(&sk->sk_v6_daddr)) {

This looks unnecessary.


> +                       if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> +                               return -1;
> +                       score++;
> +               }
>         }
>
>         bound_dev_if =3D READ_ONCE(sk->sk_bound_dev_if);
> @@ -949,9 +949,9 @@ static bool __udp_v6_is_mcast_sock(struct net *net, c=
onst struct sock *sk,
>
>         if (udp_sk(sk)->udp_port_hash !=3D hnum ||
>             sk->sk_family !=3D PF_INET6 ||
> -           (inet->inet_dport && inet->inet_dport !=3D rmt_port) ||
> -           (!ipv6_addr_any(&sk->sk_v6_daddr) &&
> -                   !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
> +           (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +            ((inet->inet_dport && inet->inet_dport !=3D rmt_port) ||
> +            !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr))) ||
>             !udp_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if), dif=
, sdif) ||
>             (!ipv6_addr_any(&sk->sk_v6_rcv_saddr) &&
>                     !ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr)))
> --
> 2.53.0.1118.gaef5881109-goog
>
