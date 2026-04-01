Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037D35CBD7
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076648; cv=none; b=HulWmNZ23buSqMzyA+HRivtz48RCaB1BwkBLttGJu5M1YSngpNtySpAPS8PvyBia9DP1nz1I59HDo1s+4pEEWS1QWDoV1W8cyTNnPadZFZOxQV3i29o9uOrSjd/dgO2WnbtC0ZkdGXrgaFi0BB+ulyA9nsUgFtnz3aag6tSNtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076648; c=relaxed/simple;
	bh=ktMqHT24bw1r5kmyz2JATopbIzzfJb9qr1AXckVYhVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+3VwHFJrhCcNci8TNkRKcYPbxK//iI4UdYJ7yrjrdJ2EZNFja3QMGZIW86z8x8RobRnqAI7ScHT1W3RRQ/69D+yqMr+tGWnGkZRk3//E8sThRYZzfkiqAcA0raM3EIGJLu9xPUld54u6UN5OrqLD3rxxjoizJ37Z9fJKI1hSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+08gWj6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+08gWj6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0c12be0ecso11975ad.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775076647; x=1775681447; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LjEEKe36C/xvbCnEOY0kz8sYomKUfM5nFzyVZeOUVCo=;
        b=d+08gWj6n+QbnRIVgoQZ5iByhY4Kfj5C/oFvF2eKZighWMDVV4sLlyVpVfOSihBdnA
         rwLBGt7OpJASaXLIBI4dCq7RZBr3iuXIUrQ1awjr+aBYHzLA6TKD5A/ceDD5DjX92yq4
         aE34cqe81HE1e1ubyH73Qb+OJUr93FkUJOHfHfRTHp6DA9Q36vsz5ZyayKB7EazMCYju
         VPUqFCcPkgH2db3XjdJY94FIPeOl/S1zJuDb7xDn8YqkQpQK5J8xwWMVavCB09hBgs/z
         yDHmrCGD62wFW0cy3xu3cbBgd9pjQhTxgJT2qJsMMrieosFWi+XYtSWZjcV5wOi1rLdX
         ZNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076647; x=1775681447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjEEKe36C/xvbCnEOY0kz8sYomKUfM5nFzyVZeOUVCo=;
        b=YAqfZeSxGwO9BBQJImBiLoFYKR/VrOzou5Z1m+xGyrCI3c4EiwRbSxdFgNcxpZLYqs
         Cys4x5ZJZaRdJdShJEGWXGtt5xm3siY/CSgvcEvaWa+Fu1kJKHuyAkO7RCGUYOos/Abk
         WlTMYlMzZdIYvgexQwF+8ZDCaACB1x/bJiHcchfvPjMLOqbS+YxXO9FdaPivb2q/UANw
         f9467bmJH0NbQLGWIyg4ugHEVTTsH4cejVKJKxGkG5fzBUFBBJdSxMH1cwyIMdLD3iw/
         C0i2Z0gQV8xJsaKSUsJh7+NjTQr0I3rDnCO5Nryp3UsDq6QLbgwGKoVb/UeELbl42tr7
         3Sxw==
X-Forwarded-Encrypted: i=1; AJvYcCXTwtoANUikOyzBHOeMW+MROELnoCgMuHTsnSmrdcebZoJVD788kzPuLeTyzWQfbshQ9Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS91VzUANtrbh3dM791H/TVrf0vNxTl7EDZG0ln9F+P7u8YypS
	xpPqvq0Ign7EYS70ePbtO5dU+kE8+mcrTNhnExEZ9tlIgkb3o933pnhqjjM4dmWo3A==
X-Gm-Gg: ATEYQzxWGDlbihxlVOaXywq6jhqUdH9z4AP4LGULe+Voag8EsSUL7XEpESlF/7dGNE9
	grMFNaIdvLr+aftexy0eFeqKm+I6QyKuYm6PtrVrjR1vXunR1cnc098HBOx8wpV4OAaLCAEe1Va
	i+y0cIx+chU26X8aLaVelFVQBZuxdO2T7XhF8mqakCijfVtCbvfvvaBKSPFQgamMtl6fxYMxqY8
	1tyepxLLBLkPDvqgf9D67tf0soPMPZZD4c/ZDgt9/1/4Myfe7PvPo/rGJqLOudUvccvM+e4uRwO
	hwE7xD5GvgaO2noxy4ThTIpps3rcVVYCPSKKyLzF7kt+RI8f4WiyMxuzhek9NFmsIgx5RncFmFS
	mrWsudcJKnXmk5QdWPmthrfA2LdD5SUnrIWbGMSzTgJXK7pJI7ifj6RI6tX6gdv7Z1/AWuwSsQV
	k514+z1TvL2oVYamq6iknPUksgGtqMuZDi1t95cKTmca7PFx6ZjcnjfX0zbPrTON4nwn7Z
X-Received: by 2002:a17:903:1ac3:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2b276aa3b35mr504265ad.1.1775076645947;
        Wed, 01 Apr 2026 13:50:45 -0700 (PDT)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a1d04sm831961a91.17.2026.04.01.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:50:45 -0700 (PDT)
Date: Wed, 1 Apr 2026 20:50:41 +0000
From: Jordan Rife <jrife@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v3 1/4] udp: Only compare daddr/dport when
 sk_state == TCP_ESTABLISHED
Message-ID: <ac1qqMc8M96aDORI@google.com>
References: <20260330215707.2374657-1-jrife@google.com>
 <20260330215707.2374657-2-jrife@google.com>
 <CAAVpQUDk1ywgsuCtreVCV4yVJRm_mcjsnC-+LuUwLRLHWavtZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDk1ywgsuCtreVCV4yVJRm_mcjsnC-+LuUwLRLHWavtZA@mail.gmail.com>

On Mon, Mar 30, 2026 at 06:21:39PM -0700, Kuniyuki Iwashima wrote:
> On Mon, Mar 30, 2026 at 2:57 PM Jordan Rife <jrife@google.com> wrote:
> >
> > Adjust lookups and scoring to keep their results equivalent to before
> > even if inet_daddr+inet_dport are left intact after disconnecting a
> > socket (sk_state == TCP_CLOSE). sk_state == TCP_ESTABLISHED implies that
> > *daddr is non-zero, so remove redundant checks for that at the same
> > time. Note that __udp6_lib_demux_lookup already checks if sk_state ==
> > TCP_ESTABLISHED, so no change was needed there [1].
> >
> > I could find no discernible difference in performance in
> > udp4_lib_lookup2 before and after the change in compute_score.
> 
> What workload did you test the series with ?

These measurements were taken on the server side while running a netperf
UDP_STREAM test over a 100 Gbps link.

> I think we want to see results under DDoS.

Intuitively, it seems like the performance should be similar.
sk_state resides in the same cache line as inet_daddr, inet_dport, and
sk_v6_daddr, and we trade a comparison with inet_daddr/sk_v6_daddr for
one with sk_state. Of course, code-level intuition can be wrong, so I'm
happy to do some more extensive testing if you feel it's warranted to
make sure that performance isn't regressing.
 
> >
> > (AMD Ryzen 9 9900X)
> >
> > kprobe:udp4_lib_lookup2 {
> >         @start[cpu] = nsecs;
> > }
> > kretprobe:udp4_lib_lookup2 {
> >         @lookup[cpu] = hist(nsecs - @start[cpu], 2);
> > }
> >
> > BEFORE
> > ======
> > @lookup[11]:
> > [80, 96)         1387077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [96, 112)         364973 |@@@@@@@@@@@@@                                       |
> > [112, 128)         34261 |@                                                   |
> > [128, 160)          7246 |                                                    |
> > [160, 192)           215 |                                                    |
> > [192, 224)           126 |                                                    |
> >
> > AFTER
> > =====
> > @lookup[11]:
> > [80, 96)         1408594 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [96, 112)         340568 |@@@@@@@@@@@@                                        |
> > [112, 128)         30753 |@                                                   |
> > [128, 160)          8019 |                                                    |
> > [160, 192)           231 |                                                    |
> > [192, 224)           157 |                                                    |
> >
> > [1]: https://lore.kernel.org/netdev/20170623222537.130493-1-tracywwnj@gmail.com/
> >
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >  net/ipv4/udp.c | 20 +++++++++++---------
> >  net/ipv6/udp.c | 18 +++++++++---------
> >  2 files changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index b60fad393e18..d91c587c3657 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -385,16 +385,16 @@ static int compute_score(struct sock *sk, const struct net *net,
> >         score = (sk->sk_family == PF_INET) ? 2 : 1;
> >
> >         inet = inet_sk(sk);
> > -       if (inet->inet_daddr) {
> > +       if (sk->sk_state == TCP_ESTABLISHED) {
> >                 if (inet->inet_daddr != saddr)
> >                         return -1;
> >                 score += 4;
> > -       }
> >
> > -       if (inet->inet_dport) {
> > -               if (inet->inet_dport != sport)
> > -                       return -1;
> > -               score += 4;
> > +               if (inet->inet_dport) {
> > +                       if (inet->inet_dport != sport)
> > +                               return -1;
> > +                       score += 4;
> > +               }
> >         }
> >
> >         dev_match = udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
> > @@ -796,8 +796,9 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
> >
> >         if (!net_eq(sock_net(sk), net) ||
> >             udp_sk(sk)->udp_port_hash != hnum ||
> > -           (inet->inet_daddr && inet->inet_daddr != rmt_addr) ||
> > -           (inet->inet_dport != rmt_port && inet->inet_dport) ||
> > +           (sk->sk_state == TCP_ESTABLISHED &&
> > +            (inet->inet_daddr != rmt_addr ||
> > +            (inet->inet_dport != rmt_port && inet->inet_dport))) ||
> >             (inet->inet_rcv_saddr && inet->inet_rcv_saddr != loc_addr) ||
> >             ipv6_only_sock(sk) ||
> >             !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
> > @@ -2854,7 +2855,8 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
> >         ports = INET_COMBINED_PORTS(rmt_port, hnum);
> >
> >         udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> > -               if (inet_match(net, sk, acookie, ports, dif, sdif))
> > +               if (sk->sk_state == TCP_ESTABLISHED &&
> > +                   inet_match(net, sk, acookie, ports, dif, sdif))
> >                         return sk;
> >                 /* Only check first socket in chain */
> >                 break;
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 010b909275dd..b93a9a3e7678 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -147,16 +147,16 @@ static int compute_score(struct sock *sk, const struct net *net,
> >         score = 0;
> >         inet = inet_sk(sk);
> >
> > -       if (inet->inet_dport) {
> > +       if (sk->sk_state == TCP_ESTABLISHED) {
> >                 if (inet->inet_dport != sport)
> >                         return -1;
> >                 score++;
> > -       }
> >
> > -       if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
> > -               if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> > -                       return -1;
> > -               score++;
> > +               if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
> 
> This looks unnecessary.

Yep, thanks. This is inverted. It should have been similar to the ipv4
logic where the unnecessary `if (inet->inet_daddr)` check was removed
after adding if `(sk->sk_state == TCP_ESTABLISHED)`:

	if (sk->sk_state == TCP_ESTABLISHED) {
		if (inet->inet_dport) {
			if (inet->inet_dport != sport)
				return -1;
			score++;
		}

		if (!ipv6_addr_equal(&sk->sk_v6_addr, saddr))
			return -1;
		score++;
	}
 
> 
> > +                       if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> > +                               return -1;
> > +                       score++;
> > +               }
> >         }
> >
> >         bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
> > @@ -949,9 +949,9 @@ static bool __udp_v6_is_mcast_sock(struct net *net, const struct sock *sk,
> >
> >         if (udp_sk(sk)->udp_port_hash != hnum ||
> >             sk->sk_family != PF_INET6 ||
> > -           (inet->inet_dport && inet->inet_dport != rmt_port) ||
> > -           (!ipv6_addr_any(&sk->sk_v6_daddr) &&
> > -                   !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
> > +           (sk->sk_state == TCP_ESTABLISHED &&
> > +            ((inet->inet_dport && inet->inet_dport != rmt_port) ||
> > +            !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr))) ||
> >             !udp_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if), dif, sdif) ||
> >             (!ipv6_addr_any(&sk->sk_v6_rcv_saddr) &&
> >                     !ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr)))
> > --
> > 2.53.0.1118.gaef5881109-goog
> >

Thanks,
Jordan
