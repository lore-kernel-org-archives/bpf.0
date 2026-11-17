Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887754;
	b=tjBQId9gHH8Rq+wb63JXPiqA7pOHfvQVU+ZHiVR1QAUPFUxK0fnlmEdWboASzS1jaYEO
	 bVRnC/Yaov4Pw0ckTM80QK+sBvpROo+jxsdNeWqcfzrLF3ECtJFnklfaXt6DZ0lwme/Yi
	 JHf9IUBJ0wWsQQo4J87ZbIY68wX0QEbZhmGTnRFgLiXZijmwmh8BaE3FxbvlLHsRMJ0PX
	 PhiZ6X96yvlTreIz2SPofRkElvx4E7JCZus80ojNO7YBii0jCBUJgOvQnmBQtiEw7//AB
	 cGJCEf2nNYemStq18NvP/DUrsxKBHRrRRYMU/F/BDHtB3qNPlmbRxj8q/hGjGHx+I3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UiMi2V2N/XyzCUax0/FbapmkB+2suxIdICZjcUhBj5s=;
	b=sNGs9ExEZkrNUJbc4hkIcVAL6iu5bUYteR5gukA25t/cMA6aB9FbELLAb0Jlp5N6Gwgl
	 iyq6ND9c3sQgffFyuD150tW/z0tvTa0vqKa6mr2VaAqloeqFUlPlhjUfvvKGvRNOhwSq6
	 4BOfbW0xh0Oa213xJBYWqSly2V/AYKqvWawr6dPjkU2I95DzoSjJKm5aRe+CT0wMWvrLF
	 U32jR/grt+8zefBkUhEE5JY7NPhCQ4UqPVlioXn7nFQxpv0bV35VzRAWCrfjKbR82tAmb
	 /jR0uRXFCz5WF2o88ekdiJw/xbdkVYV4pv5UtiHDI4NWcFfLFK/956DUhky2eCsFePA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SGA/giu6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F4606A88E
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGA/giu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220A71F000CB;
	Tue, 17 Nov 2026 03:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794887754;
	bh=UiMi2V2N/XyzCUax0/FbapmkB+2suxIdICZjcUhBj5s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SGA/giu6W56RJUKdj/2LC89sc4POHms9nnVyAXJ6kg1573R2x5a/mvN6Old6AYJE5
	 K3uv5IlKxWSZh2I7oFU8ZCpS+CR2cianCn+oXWNnoztOLLyh9ZavM3JYIZAjPDwi7a
	 naUD5H/jsCtAZj8HjWiRoUr5MC0hRrdXDB+fpRLnL2dIb+08Uv3DIzzuevi5Y1OC7j
	 V+Kl/Ck1csq2spY9NDfR53W8xWCYD0woojH92ZO+NIF3ouDu/+lBnZ7l87k+kHoYmX
	 h+QgeoJiguNYSTus2+hd+plgTGo1ExXUO4ait5LOgjG7/qyaT1DwArK7bWHjajgq0y
	 ucCoQYe3UhMsA==
Message-ID: <sashiko-outbox-218171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: cover connected UDP reuseport
 rescore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <4302d941304941ea6059b3d1fa167236635686c6.1794759652.git.zihanx@nebusec.ai>
References: <cover.1794759652.git.zihanx@nebusec.ai>
 <4302d941304941ea6059b3d1fa167236635686c6.1794759652.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:55:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests: net: connect() in
  test_connected_reuseport_rescore() bypasses rescore
--

commit d5abe4da0e157c18e683e7d4c4cfb9dfd776e227
Author: Zihan Xi <zihanx@nebusec.ai>

selftests: net: cover connected UDP reuseport rescore

This commit adds a selftest in reuseport_bpf to exercise UDP SO_REUSEPORT
lookup when a cBPF program selects a connected socket over IPv4 and IPv6.

> diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/=
selftests/net/reuseport_bpf.c
> index 12e48b97b8625..fbfe73dce2111 100644
> --- a/tools/testing/selftests/net/reuseport_bpf.c
> +++ b/tools/testing/selftests/net/reuseport_bpf.c

[ ... ]

> @@ -303,6 +303,154 @@ static void test_reuseport_cbpf(struct test_params =
p)
> +static void test_connected_reuseport_rescore(int family)
> +{

[ ... ]

> +	good_addr =3D new_loopback_sockaddr(family, 0);
> +	if (bind(good_fd, good_addr, sockaddr_size()))
> +		error(1, errno, "failed to bind good reuseport socket");
> +	if (getsockname(good_fd, good_addr, (socklen_t []){ sockaddr_size() }))
> +		error(1, errno, "failed to get reuseport port");
> +	recv_port =3D get_sockaddr_port(good_addr);
> +	if (bind(connected_fd, good_addr, sockaddr_size()))
> +		error(1, errno, "failed to bind connected reuseport socket");
> +
> +	match_src =3D new_loopback_sockaddr(family, 0);
> +	if (bind(match_send_fd, match_src, sockaddr_size()))
> +		error(1, errno, "failed to bind matching source socket");
> +	if (getsockname(match_send_fd, match_src,
> +			(socklen_t []){ sockaddr_size() }))
> +		error(1, errno, "failed to get matching source port");
> +	peer_port =3D get_sockaddr_port(match_src);
> +	peer_addr =3D new_loopback_sockaddr(family, peer_port);
> +	if (connect(connected_fd, peer_addr, sockaddr_size()))
> +		error(1, errno, "failed to connect reuseport socket");
> +
> +	/* Bind order makes good_fd index 0 and connected_fd index 1. */
> +	attach_cbpf_index(good_fd, 1);

[ ... ]

> +	/* An unmatched BPF-selected socket must not replace the valid candidat=
e. */
> +	send_udp_packet(other_send_fd, dst, mismatch_payload);
> +	expect_udp_socket(epfd, good_fd, connected_fd, good_fd,
> +			  mismatch_payload);
> +
> +	/* A matching selected socket must still win the positive rescore path.=
 */
> +	send_udp_packet(match_send_fd, dst, match_payload);
> +	expect_udp_socket(epfd, good_fd, connected_fd, connected_fd,
> +			  match_payload);

[Severity: Medium]
Does connecting connected_fd while bound to a specific loopback address
remove it from reuse->socks[] and bypass the reuseport rescore path in
udp4_lib_lookup2() and udp6_lib_lookup2()?

On !CONFIG_BASE_SMALL kernels, connecting a UDP socket bound to a
non-wildcard address calls udp4_hash4() or udp6_hash4() -> udp_lib_hash4(),
which detaches connected_fd from the reuseport group via
reuseport_detach_sock() and inserts it into the 4-tuple hash table:

net/ipv4/udp.c:udp_lib_hash4() {
	...
	sock_set_flag(sk, SOCK_HASH4);
	hlist_add_head_rcu(&sk->sk_Value_node, &hslot4->head);
	...
	reuseport_detach_sock(sk);
}

That leaves only good_fd at index 0 with reuse->num_socks =3D=3D 1.  When
mismatch_payload arrives, run_bpf_filter() sees index 1 >=3D socks (1) and
returns NULL, so reuseport_select_sock() falls back to hashing and returns
good_fd directly instead of testing fallback from connected_fd.  When
match_payload arrives, __udp4_lib_lookup() and __udp6_lib_lookup() find
connected_fd directly in udp4_lib_lookup4() / udp6_lib_lookup4() without
reaching udp4_lib_lookup2() / udp6_lib_lookup2().  As a result, the test
passes even without the rescore logic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794759652.gi=
t.zihanx@nebusec.ai?part=3D2
