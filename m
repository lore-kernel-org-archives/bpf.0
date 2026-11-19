Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082264;
	b=Z9R9OGl4kj0rzagIvirEmB1y8VNiZT44mBtvB/Kp1oTXWzmNVeOrNefrRIrLmmRdp78q
	 SWUiDGTJ6uSN5qEaiQLS/Dp5FyL0XWU9HcSzJ3dQZQacthas/m6+ngjG9PZLaKO70V/4R
	 uETTxj8Xo7MrVKdKIx1YNkkaCgfA4+23+yIF1J5fua2AqBI6ltSP0SskmzFiAhdoSDwjn
	 7Cq97hJYzWRk+yPqhvlXxHYj6C8AcsaE+QtCm+2crCD1QkwK5HBGLthw7XH/mcrPDeVLM
	 CrmmQi43d0VmepLaYSmJUgl6VWhYY9CeDfaeB1An8IyHeSpzxpf76uUlgW9QgpB1/Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082264;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lOEEb3xkcDjySa+zz1fKZtGI0y7c9MFtdo/OrpAicu0=;
	b=e3758HdQasvmcS4etzbbMVHz5vBSD+nfPtyVlIe6I1xuUGCi4jBIgPNzRzGV2qekxNEz
	 5+CceS1QO70NZrQOds0o3S57KR184Jf0OxYsz3lCmrrkoRRwN/vivwYOzw13ad0haedQP
	 h0YAv7A7kyHG/zdxSFdR/8xdShxaHOgD1ppK8wyCgsFacTl3QynXt4yZ6e7om7lhXT/GT
	 IT+d6pCf0ORY5rbKRAK3Vg017oS/uNl+rKVIBiTIWHzc54svtdmEc9RKC7BQzf8g7Euka
	 VoPd8u4oPm/B9N8L6j029rnqZGqJdBmialkaaJiMCr7qL8iCbzeqiiNaBJcmORKLggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B66W5Anj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6C60A2607;
	Thu, 19 Nov 2026 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B66W5Anj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA56D1F000C4;
	Thu, 19 Nov 2026 09:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082264;
	bh=lOEEb3xkcDjySa+zz1fKZtGI0y7c9MFtdo/OrpAicu0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B66W5AnjvREPognEqYec8dNFLWaVQhvqSRV8xcZpHLfbmA6o87wy5yoxNHtnD5M5c
	 xvmWDrjiy7S/SFDxFB7+nN4VQpcObAFiDZ93Lv5BAFZmfXuzNjTrnwWppgW+HNgLB8
	 xtI7dfaw4FT/oTvALrf3nmWiR4Ebi5Bm7i/RAaLA4/0zugLVN7uZEv2Pgf2o2e/OL0
	 R9xTvjG22tTVBMPV/qtb5E7za7OhOA43us9ZhaOyPiI3nh7uXYVq1Ou7d3WFHdrc6U
	 mFd7dHF7V13lMydBW+P6OzWtsfYvocnv+E/0+zaLQ/pyDGayTq2GkAmHIeeVLqLNYN
	 tY0qhBBUzXjbA==
Subject:
 Re: [PATCH net 2/2] selftests: net: cover connected UDP reuseport rescore
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, benh@amazon.com,
 kuniyu@google.com, shuah@kernel.org, vega@nebusec.ai, kuba@kernel.org
Date: Thu, 19 Nov 2026 09:57:43 +0000
Message-ID: <179508226333.3136.7134798566838618368@kernel.org>
In-Reply-To: <4302d941304941ea6059b3d1fa167236635686c6.1794759652.git.zihanx@nebusec.ai>
References: <4302d941304941ea6059b3d1fa167236635686c6.1794759652.git.zihanx@nebusec.ai>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch's parent commit in the series, "udp: fix reuseport
  rescore fallback", changes the rescore branch in udp4_lib_lookup2()…
- [Medium] On the default CONFIG_BASE_SMALL=n kernel,
  test_connected_reuseport_rescore() never has a BPF program select the…
- [Low] The comment on the second assertion in
  test_connected_reuseport_rescore()…

--

selftests: net: cover connected UDP reuseport rescore

This adds a reuseport_bpf selftest in which a constant classic BPF
program selects a connected UDP socket in a reuseport group. A packet
from a different peer should go to the unconnected socket, and a packet
from the connected peer should still reach the connected socket. The
test runs for both IPv4 and IPv6.

> diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/selftests/net/reuseport_bpf.c
> index 12e48b97b8625..fbfe73dce2111 100644
> --- a/tools/testing/selftests/net/reuseport_bpf.c
> +++ b/tools/testing/selftests/net/reuseport_bpf.c
> @@ -303,6 +303,154 @@ static void test_reuseport_cbpf(struct test_params p)

[ ... ]

> +static void test_connected_reuseport_rescore(int family)
> +{

[ ... ]

> +	good_addr = new_loopback_sockaddr(family, 0);
> +	if (bind(good_fd, good_addr, sockaddr_size()))
> +		error(1, errno, "failed to bind good reuseport socket");
> +	if (getsockname(good_fd, good_addr, (socklen_t []){ sockaddr_size() }))
> +		error(1, errno, "failed to get reuseport port");
> +	recv_port = get_sockaddr_port(good_addr);
> +	if (bind(connected_fd, good_addr, sockaddr_size()))
> +		error(1, errno, "failed to bind connected reuseport socket");
> +
> +	match_src = new_loopback_sockaddr(family, 0);

[ ... ]

> +	peer_addr = new_loopback_sockaddr(family, peer_port);
> +	if (connect(connected_fd, peer_addr, sockaddr_size()))
> +		error(1, errno, "failed to connect reuseport socket");
> +
> +	/* Bind order makes good_fd index 0 and connected_fd index 1. */
> +	attach_cbpf_index(good_fd, 1);

[Severity: Medium]
Is connected_fd still in the reuseport group at this point?

On a default CONFIG_BASE_SMALL=n kernel, connected_fd is bound to
127.0.0.1 or ::1. So udp_connect() calls udp4_hash4() (udpv6_connect()
calls udp6_hash4()), and udp_lib_hash4() detaches the socket:

net/ipv4/udp.c:udp_lib_hash4() {
    ...
	spin_lock_bh(&hslot->lock);
	if (rcu_access_pointer(sk->sk_reuseport_cb))
		reuseport_detach_sock(sk);
    ...
}

That leaves good_fd as the only member (num_socks == 1), while has_conns
stays set from __ip4_datagram_connect(). The cBPF return value of 1 is
then out of range, and run_bpf_filter() rejects it:

net/core/sock_reuseport.c:run_bpf_filter() {
    ...
	if (index >= socks)
		return NULL;
    ...
}

reuseport_select_sock_by_hash() then picks good_fd.

As a result, the mismatch packet reaches good_fd on both the old and the
new code. A good_fd rescored to an equal score is kept either way. The
match packet is resolved by udp4_lib_lookup4() or udp6_lib_lookup4() in
__udp4_lib_lookup() or __udp6_lib_lookup(), before udp*_lib_lookup2()
runs.

The case the test is named after, a BPF-selected connected socket kept as
a stale result, only seems to reproduce on CONFIG_BASE_SMALL=y kernels.
There udp_lib_hash4() is a stub and connected_fd stays at index 1.

Could the setup keep a connected socket in the group on hash4 kernels?
One option is to bind and connect connected_fd before good_fd binds, so
that reuseport_add_sock() rebuilds the group around it, and then set
has_conns. Failing that, could the test at least check the group
membership it assumes, rather than passing silently?

[ ... ]

> +	/* An unmatched BPF-selected socket must not replace the valid candidate. */
> +	send_udp_packet(other_send_fd, dst, mismatch_payload);
> +	expect_udp_socket(epfd, good_fd, connected_fd, good_fd,
> +			  mismatch_payload);

[Severity: High]
This is about the parent commit 33c2c891d6d7 ("udp: fix reuseport rescore
fallback"), but this test can't detect it. That commit changes the
rescore branch in udp4_lib_lookup2() and udp6_lib_lookup2() to:

		if (need_rescore) {
			if (score > badness)
				badness = score;
			else
				result = sk;
			continue;
		}

Suppose the socket picked by the reuseport program or hash scores the
same as sk, the socket that set badness. Won't the pick then be dropped
and sk returned instead?

Before that change, an equal score left result unchanged, so the pick
was kept. Only a lower score, the stale connected socket case, seems to
need the fallback.

Unconnected sockets have sk_incoming_cpu == -1 unless SO_INCOMING_CPU is
set, and only connected sockets update it. So equal scores are the usual
case.

reuseport_has_conns_set() sets has_conns in __ip4_datagram_connect() and
__ip6_datagram_connect() when a member bound to a specific address
connects. The flag is never cleared, and it stays set after
udp_lib_hash4() detaches the connected socket.

For example, take unconnected A and B plus connected C, all bound to
127.0.0.1:X, with the BPF program or hash picking B. B rescores equal to
A, the else branch sets result = A, and A gets every packet from
unconnected peers.

Does this override hash load balancing and cBPF/eBPF steering in every
group with has_conns set? One such setup is a QUIC-style server with
several unconnected workers and per-connection connected sockets on the
same address and port.

The parent is tagged Cc: stable. Should it keep the pick unless
score < badness?

This test uses only one unconnected and one connected socket, so it
can't catch this. Could it add a second unconnected socket and have the
BPF program select that one?

> +
> +	/* A matching selected socket must still win the positive rescore path. */
> +	send_udp_packet(match_send_fd, dst, match_payload);
> +	expect_udp_socket(epfd, good_fd, connected_fd, connected_fd,
> +			  match_payload);

[Severity: Low]
Is this comment accurate? On every config, the match packet seems to be
decided by something other than the positive rescore branch
(score > badness).

On default CONFIG_BASE_SMALL=n kernels, connected_fd is in the 4-tuple
hash. __udp4_lib_lookup() returns it from udp4_lib_lookup4() before
udp4_lib_lookup2() runs, and IPv6 does the same through
udp6_lib_lookup4().

On IPv4 with CONFIG_BASE_SMALL=y, connected_fd is bound second, and
udp_lib_get_port() adds it at the head of hslot2. It is scanned first and
taken by this shortcut, with no reuseport selection or rescore:

		if (sk->sk_state == TCP_ESTABLISHED) {
			result = sk;
			continue;
		}

On IPv6 with CONFIG_BASE_SMALL=y, the rescore does run. But connected_fd
outscores good_fd on its own merits. Even if the positive branch fell
back to result = sk, the next iteration would still pick connected_fd
through the TCP_ESTABLISHED shortcut.

So can this assertion catch a regression in the badness = score branch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794759652.git.zihanx%40nebusec.ai
