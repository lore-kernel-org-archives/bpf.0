Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622139;
	b=DJKaTCwXp7bd4THk8j1CKPVN8wW4r0O7/jiRl9X+jstNtXQ0w6XIVpx34tLC+qYZk8Be
	 MIUin5/mS7K6IJoGUn1+MnYBvsY5w9ah8l3Ky3bBESz342BYCAhVqjXLgRizNfL5XW1c2
	 FARAWlSD945aVrkRdY+rlvz6Pplm5zBkz7/SH9KJtn5Sd77T1fzGCjGOTNH3TVYeD9CI0
	 7dnQTajNFw3gT9lO8p57aWl4aIX8OAbxAn4LLqw7FLA8v541NCC4de2CVcgzNy00oj9EF
	 R99rSEOx9TO7jgfCaWyE7jldlE6NZt/0IMjT7+KI8e6AItH5rNhBYr09Uja1C4Vp36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622139;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=t32OTRTZmb7VBk8VN1bLpETXhRjyaIx/cChE8Ee/QZA=;
	b=VRLSNZlK+4lPXoKwUoRmo55Gmu5b4cMaY1/nOVRfWhXM69iCV/eVPIqrtzZuxN6O+O8y
	 Kl15auLsUOusbrFebl0McXzLWuXkz8yx7OwraaSqwbYc9qTJ16FIaMGWnlNK8E1ThcdO9
	 R2/W3I9O85zLOmPUuJTBVD2KdmQBkhoc2St+LrYbr+Oz3dB9/uqvxqPeM6fPklomRw0Jm
	 H7EeE02HDoILs3IuCx+cQUGWFvMFhqQ+/e20CcCOXL8YtjhggOWRcyh3eemsfMVFP1HwW
	 PnVCr3KMYo0PkUZ61JaZz1Pnlgj5vVIpgf4+mc1hKTYVMPMMkAyEgEGCwk6uH5ebPOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oswWqni5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E4606A32C;
	Mon,  2 Nov 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oswWqni5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD981F00A16;
	Mon,  2 Nov 2026 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622139;
	bh=t32OTRTZmb7VBk8VN1bLpETXhRjyaIx/cChE8Ee/QZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oswWqni53tKpWyf1U/og4FtdFzv3Gv9dxb5VFHP/Qv0P2Y5KzwC2OnM8Gw2eVEkLL
	 6jLqo6m7S7Dkr961tI5tyHAQ6Jj3yVEowfaNbdvfuvbAWD3sR6MxgxbLzQSs+0CUtD
	 IIc6M2jYhzqPTLAEGdENDXL0KIEH3PlMXtwRT84e4EHC6vzGq4tUHk+RGTb6Qjhuhu
	 FNZZ/60ECfrz0wEMUIbIb6S0AdbvKT0RERgAW15nZleIKVZTaOzUVdDagAZg4Pyy9+
	 jANgd8jOjMWZrbXApACLScQYMzDgOWg5hZoWwz98Jjbl/qQLUvxySyeUQqjnlEcyFl
	 XS2LtVucKgDbQ==
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and secondary
 hash tables
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, david.laight.linux@gmail.com,
 willemdebruijn.kernel@gmail.com
Date: Mon, 02 Nov 2026 12:22:18 +0000
Message-ID: <179362213820.3131.12108035098960840444@kernel.org>
In-Reply-To: <20261030122045.3035709-1-edumazet@kernel.org>
References: <20261030122045.3035709-1-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The hlist_nulls restart does not work when an IPv6 SO_REUSEPORT
  socket is tail-inserted back into the bucket it was just removed from.

--

udp: restore hlist_nulls for primary and secondary hash tables

This patch converts the UDP primary (hash) and secondary (hash2) tables
back to hlist_nulls and keeps SOCK_RCU_FREE. The lockless lookups now
restart when the nulls value at the end of a walk does not match the
expected slot. The goal is to stop readers from missing sockets that were
moved to another chain by rehash, or by unhash followed by re-insert,
without an RCU grace period.

Closes: https://lore.kernel.org/netdev/20260922130856.2c4f409a@pumpkin/

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 173b37b2b8bb0..6140244735b55 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h

[ ... ]

> @@ -932,7 +932,11 @@ static inline void __sk_nulls_add_node_tail_rcu(struct sock *sk, struct hlist_nu
>  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
>  {
>  	sock_hold(sk);
> -	__sk_nulls_add_node_rcu(sk, list);
> +	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> +	    sk->sk_family == AF_INET6)
> +		__sk_nulls_add_node_tail_rcu(sk, list);
> +	else
> +		__sk_nulls_add_node_rcu(sk, list);
>  }

[ ... ]

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 303d0102519ac..7d3790550241f 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c

[ ... ]

> @@ -324,7 +327,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
>  
>  		sock_set_flag(sk, SOCK_RCU_FREE);
>  
> -		sk_add_node_rcu(sk, &hslot->head);
> +		sk_nulls_add_node_rcu(sk, &hslot->head);
>  		hslot->count++;
>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  
> @@ -332,11 +335,11 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
>  		spin_lock(&hslot2->lock);
>  		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
>  		    sk->sk_family == AF_INET6)
> -			hlist_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
> -					   &hslot2->head);
> +			hlist_nulls_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
> +						 &hslot2->head);
>  		else
> -			hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> -					   &hslot2->head);
> +			hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> +						 &hslot2->head);
>  		hslot2->count++;
>  		spin_unlock(&hslot2->lock);
>  	}

[Severity: High]
Does the nulls restart still catch the second scenario from the commit
message when the socket is an AF_INET6 socket with SO_REUSEPORT set?

The commit message says:

  2. __udp_disconnect() calls udp_lib_unhash() when an implicitly bound
     port was used, and a subsequent connect() or bind() can immediately
     re-insert sk->sk_nulls_node and sk->skc_portaddr_node into different
     hash and hash2 buckets.

In that case udp_lib_get_port() puts the socket back at the tail of both
chains:

  - the primary hash, through sk_nulls_add_node_rcu(), which now
    tail-inserts in this case
  - hash2, through hlist_nulls_add_tail_rcu()

hlist_nulls_add_tail_rcu() sets n->next = last->next, which is the nulls
marker of the target slot. hlist_nulls_del_init_rcu() in udp_lib_unhash()
leaves X->next pointing at its old successor. No grace period separates
the unhash from the re-insert.

If the socket goes back into the same slot it was just removed from, a
reader parked on it gets the expected nulls value and does not restart.
Here is the sequence for hash2, with X at the head after the connect()
rehash:

  hash2 slot S2: X -> Y -> nulls(S2)

  CPU1                                  CPU2 udp6_lib_lookup2()
                                        sk = X
  connect(X, AF_UNSPEC)
    __udp_disconnect()
      sk->sk_prot->unhash(sk)           (SOCK_BINDPORT_LOCK clear)
        hlist_nulls_del_init_rcu()      S2: Y -> nulls(S2)
  bind(X, saddr:p)
    udp_lib_get_port()
      hlist_nulls_add_tail_rcu()        S2: Y -> X -> nulls(S2)
                                        node = X->next == nulls(S2)
                                        get_nulls_value(node) == slot2

Y is never scored.

If a wildcard socket is bound to [::]:p, the wildcard hash2 lookup
returns it. The lookup1 fallback in __udp6_lib_lookup() is then skipped,
so the packet goes to the wildcard socket instead of Y. If there is no
wildcard socket, the packet is dropped instead.

The primary hash has the same problem. Re-binding to the same port always
lands in the same primary slot, and that chain is now tail-inserted too.
That exposes udp6_lib_lookup1(), udp4_lib_lookup1() and
__udp4_lib_mcast_demux_lookup() in the same way.

The v2 changelog says the IPv6 SO_REUSEPORT tail insert defeated the
nulls check. The new comment in udp_lib_rehash() says head insertion is
required for the restart to work. Only the rehash path was changed,
though. Can the re-insert path in udp_lib_get_port() still hit the same
problem?

Separately, the commit message doesn't mention that the shared helper
sk_nulls_add_node_rcu() in include/net/sock.h now tail-inserts for IPv6
reuseport sockets. Before this patch it only did head insertion. Could
this be noted in the commit message, or kept local to udp instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030122045.3035709-1-edumazet%40kernel.org
