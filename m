Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F93C661A
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850121; cv=none; b=QYrxIN/M566M6qP4yZKM13LUfgjTB0zml3yDWXZ8VaJFnwZbYt0AZ/ap7xSN1sFz2iwns+H8EWL8hOSp9+mXn/2cpKfdcxj46lPwfhSd6pzMB8nK7zstmpzPaPFSwPRppKbHiw9r/gygiXSBM6s41PmLa7igGKBFW0SWCFOocX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850121; c=relaxed/simple;
	bh=AYmHbXRU0iVjyjz03KFtEKin0VAR2WHPqji285UJTnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gzju2/teO8ea4bFq99adJGclB9JfywE/Nb4JUbG9zyzH20ZKvaCW3ug0OMHyk5ZukXe3b9Gmhr1lr2XvuVdQNWMXaCHXx28hFPjzmSv+gVpZMIAGuwY9rsoOxQc98EEyGCxcWgkFvmy1qjDA1DCgBBoB6kNJa2eWevTZL90jFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USXVEQGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USXVEQGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC711F000FF;
	Thu,  1 Oct 2026 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790850120;
	bh=oO/5rU6MnZopL32OSVAKxIiKv34Gi8nDKx37yBMHp1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USXVEQGy49mG7HZtbGTbYU1WFrgIujyBhVX0lkKhVCG5kOrAO22gHWyMx/iLkULke
	 7jqz6HYZnXZsb6+4KCvWOJUyIkgn9a0pQdXHZK4wETVS1beW0qYtuC5mNx+dMFjbMa
	 uK3cGgL/aRybf1u0kbkFGp7Ye/ZcRs2M98uk0fEcmQxOKmUt+Xsbzhiv6qYUDi0crq
	 AI9+mo33zxsdFkP3xDU6wzgIBXISkNgDI3HuwqvP+Ngy6PFq7jDgONyJXFYWVd4qRv
	 Cxa1LslWiiAQP5axi+DIYOv1RroL1sSqLjcSpki6pigNxP56r5xCMZaNV6gRw9q4po
	 oAVJcdZSJimxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5] tcp: add TCP_ECN and TCP_ECN_OPTION kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Irlanki Sandeep" <irlanki.s@samsung.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930102308.197808-1-irlanki.s@samsung.com>
References: <CGME20260930102144epcas5p419270301dba37c520277e6c6cff75def@epcas5p4.samsung.com>
 <20260930102308.197808-1-irlanki.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:21:59 +0000
Message-Id: <20261001102200.0BC711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf: out-of-bounds write in bpf_sock_ops_set_accecn_option() for n=
on-TCP sockets
- [Medium] tcp: child sockets inadvertently inherit listener's ECN overrides
- [Low] bpf: multi-line comment style violation in selftests
--

commit c9aee50642be2579799b62e26cc528d60bbb2e33
Author: Irlanki Sandeep <irlanki.s@samsung.com>
Subject: tcp: add TCP_ECN and TCP_ECN_OPTION kfuncs

This commit introduces two BPF kfuncs to allow per-socket overrides of ECN
and AccECN configurations. It also adds helper functions to resolve the
effective values, updates the TCP stack to use them, and includes selftests.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..b9dc1079aefc5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> +__bpf_kfunc int bpf_sock_ops_set_accecn_option(struct bpf_sock_ops_kern =
*skops,
> +					       u32 opt)
> +{
> +	if (!skops->is_fullsock)
> +		return -EOPNOTSUPP;
> +
> +	if (opt !=3D TCP_ACCECN_OPTION_UNSPEC && opt > TCP_ACCECN_OPTION_PERSIS=
T)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(tcp_sk(skops->sk)->ecn_option, opt);

[Severity: High]
Could this lead to an out-of-bounds write for non-TCP sockets?

When a UDP socket requests hardware timestamping, the transmission skb gets
SKBTX_HW_TSTAMP set, which implicitly sets SKBTX_BPF. When the timestamp
is delivered, __skb_tstamp_tx() triggers bpf_skops_tx_timestamping(),
invoking the CGROUP_SOCK_OPS BPF program for the UDP socket with
is_fullsock set to 1.

If the BPF program calls this kfunc, it bypasses the !is_fullsock check.
Since there is no verification that the socket protocol is IPPROTO_TCP,
it casts the smaller udp_sock to a tcp_sock. Writing to ecn_option would
then corrupt memory past the end of the udp_sock structure.

[ ... ]
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockops_ecn_kfunc.c b=
/tools/testing/selftests/bpf/prog_tests/sockops_ecn_kfunc.c
> new file mode 100644
> index 0000000000000..506b48e08621f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sockops_ecn_kfunc.c
[ ... ]
> +	/* BPF_SOCK_OPS_TCP_LISTEN_CB -> BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
> +	 * Listener's values are consulted for SYN negotiation, but the child
> +	 * socket is initialized with UNSPEC (not inherited).
> +	 */
> +	ASSERT_EQ(bss->listen_set_mode_ret, 0, "listen_set_mode_ret");
> +	ASSERT_EQ(bss->listen_set_opt_ret, 0, "listen_set_opt_ret");
> +	ASSERT_EQ(bss->passive_mode_read, TCP_ECN_MODE_UNSPEC,
> +		  "passive_mode_read");

[Severity: Medium]
Will this assertion fail due to child sockets inadvertently inheriting the
listener's ECN overrides?

When a passive connection is established, tcp_create_openreq_child() in
net/ipv4/tcp_minisocks.c clones the listener socket via
inet_csk_clone_lock(). This copies the entire tcp_sock structure, including
the new ecn_mode and ecn_option fields.

Since these fields are not explicitly reset to TCP_ECN_MODE_UNSPEC during
the initialization block in tcp_create_openreq_child(), the child socket
seems to retain the listener's mode, breaking the intended design and
causing this test assertion to fail.

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/sockops_ecn_kfunc.c b/tool=
s/testing/selftests/bpf/progs/sockops_ecn_kfunc.c
> new file mode 100644
> index 0000000000000..32ed64ac4f3d3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sockops_ecn_kfunc.c
[ ... ]
> +		/* Leave the socket on the sysctl defaults so the loopback
> +		 * handshake driven by the test is not altered.
> +		 */

[Severity: Low]
Does this multi-line comment violate the BPF subsystem style rules? The
required style places the opening /* on its own line.

[ ... ]
> +	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> +		/* Listener values consulted for SYN negotiation; child starts
> +		 * with UNSPEC (not inherited).
> +		 */

[Severity: Low]
Similarly here, should the opening /* be placed on its own line to match the
BPF comment style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930102308.1978=
08-1-irlanki.s@samsung.com?part=3D1
