Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082263;
	b=Z4Er0hX2TS3URaEcOuAfgOCyJkyPzh3E1/LA4Hhn4F/yxJBgjhm2wfgi0M3+8NXlfrwY
	 6fnhJ2b6kcX+niix2UDhjuxlm0x18dbBvfkNsoZ0JUwpvNoGuf9Y+WrHcMRSvtioOohzb
	 JoItI5XhC5jeHjeN86vMydYVZzbMROCYbr9ZF7Y+79mpY5e2qfdgdY4WO8ppYSoov8yue
	 OezzJVf/n5rtF7/4019M8aLiH9PCS84csYXVZrvBvVT5pAl5/EKR1b7ulerBS6oq07gk2
	 cBIxVQmrZ4vquIY0gdzKtUsXsoXkYyqmn8EB5TJt5+0aDvVyjatYxtrW4rbnfBGzrwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082263;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=y625Etk8u3ex3Tjo/KtPtgnQQJTTr3iIXOZEFCoS/aI=;
	b=PALSRU8LemJffuMbGnk37mn1rUd5RICviz5K57HkKyS4mjVY+cB0cFiTWLYNt9m46FBZ
	 uPOwk+6VmAJ2FDNQHj3yq7RGwNu0vwuw2A9dcsUO8b7WxeXy5YRZbtsNstKRnSM5CA5LM
	 JRdFJUbfeXFn7AfTNLX+lUmgRXveeeoJoCSXAf+LzrSiXCAqRI31p6zIOnjxRsn+E0fP7
	 sVSJ0v09O9Lcp+wv+XJpJyabWqb/t7WE+KV/5QKPqOqGkI5XjyFei73czT4oJ818CdfWM
	 7OMZzMpQOSNTViQVGb3Q2m4FUffMar4RD1UnNmuWvkyoKjRIGaCBED9fQnBfnW4YJ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ibQzUq/W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A75606A334;
	Thu, 19 Nov 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibQzUq/W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771AA1F000C4;
	Thu, 19 Nov 2026 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082263;
	bh=y625Etk8u3ex3Tjo/KtPtgnQQJTTr3iIXOZEFCoS/aI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ibQzUq/WD1r0LCCNo4i7pLHQGP5FKraIKKbL8BLCEx20NkLSPeWkX04Zg6y1k11TX
	 ecq5T6YUSu5D3nbL73Vr2NxFII6EXoz81xW1BXPq4UryKceAcQKsJYe9+S+ISwJlk9
	 YxKmPVYIYFUCta1I3TuyYWkG+T/TAwIh+7CkcnwRhlsg+DHmLSgri0PV3n+kcyB70n
	 vTXjCzReqxFMLltvD2kUKEiEes8TnJSbFdNAYJvWVxcuIhs5LFStxKZ2RHztxv03ty
	 NRUmuGvO9ARdEn0YViyLmxb50k9bjhwl4g+86sNEGygSk5zDQU1IqIalIn0MD9rNIV
	 Ymw0FesoPvgig==
Subject: Re: [PATCH net 1/2] udp: fix reuseport rescore fallback
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, benh@amazon.com,
 kuniyu@google.com, shuah@kernel.org, vega@nebusec.ai, kuba@kernel.org
Date: Thu, 19 Nov 2026 09:57:42 +0000
Message-ID: <179508226205.3136.710014559426997072@kernel.org>
In-Reply-To: <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
References: <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
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

- [High] The patch adds a rescore branch to udp4_lib_lookup2()
  (net/ipv4/udp.c:478-484) and udp6_lib_lookup2()…

--

udp: fix reuseport rescore fallback

This changes the UDP lookup rescore path in udp4_lib_lookup2() and
udp6_lib_lookup2(). When the reuseport group has connected sockets, the
socket selected by reuseport is now kept only if its rescored value is
strictly higher than the current badness. Otherwise the lookup goes back to
the socket that set the current score.

Link: https://bugtracker.nebusec.ai/f/net/ipv6/udp.c||udp6_lib_lookup2||socket-hijack||m7q

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 2e5562f353f85..23a8c951559c7 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -475,12 +475,17 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
>  rescore:
>  		score = compute_score(need_rescore ? result : sk, net, saddr,
>  				      sport, daddr, hnum, dif, sdif);
> +		if (need_rescore) {
> +			if (score > badness)
> +				badness = score;
> +			else
> +				result = sk;
> +			continue;
> +		}

[Severity: High]
Does this throw away the reuseport selection whenever the selected socket
only ties with sk, and not just when it fails to match the packet?

All unconnected members of a reuseport group get the same base score from
compute_score(). udp_reuseport_add_sock() requires the same family,
ipv6_only, bound device and rcv_saddr, and unconnected sockets have no
daddr or dport. The only thing that can differ is the incoming CPU bonus:

net/ipv4/udp.c:compute_score() {
    ...
	if (READ_ONCE(sk->sk_incoming_cpu) == raw_smp_processor_id())
		score++;
	return score;
}

The hash path only ever returns a non-established socket:

net/core/sock_reuseport.c:reuseport_select_sock_by_hash() {
    ...
		if (sk->sk_state != TCP_ESTABLISHED) {
			if (!READ_ONCE(reuse->incoming_cpu))
				return sk;
    ...
}

Once the group has at least one connected socket, reuseport_has_conns() is
true and the lookup goes like this:

udp4_lib_lookup2()
  first unconnected member sk scores > badness
  inet_lookup_reuseport() picks unconnected socket X
  goto rescore
  compute_score(X) == badness
  result = sk

If so, all traffic for the unconnected members would go to the first group
member in the hslot2 chain. Wouldn't SK_REUSEPORT BPF and
SO_ATTACH_REUSEPORT_CBPF steering to unconnected members also be ignored
without any warning?

That looks like the behaviour that efc6b6f6c311, the Fixes: target of this
patch, removed. Its commit message says:

  "unconnected sockets have the same score, hence only does the first
  unconnected socket in udp_hslot always receive all packets ... the
  result of reuseport_select_sock() should be used for load balancing."

The old code kept X on a tie. The problem described in this commit message
is the case where X does not match the packet at all: compute_score()
returns -1, for example when BPF selects a socket connected to a different
peer.

Could the fallback to sk happen only when score < 0 (or at most when
score < badness)? That would fix that case and keep load balancing.

The same logic is added to udp6_lib_lookup2(), where badness starts at -1
and the rescored unconnected socket also ties with sk.

The commit message says "Keep the selected socket only when its score is
higher". It does not mention the effect on load balancing or BPF steering.
Also, the selftest added later in this series ("selftests: net: cover
connected UDP reuseport rescore") only checks a CBPF program that selects
the connected socket. It never selects an unconnected peer, so it would not
catch this.

> +
>  		if (score > badness) {
>  			badness = score;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794759652.git.zihanx%40nebusec.ai
