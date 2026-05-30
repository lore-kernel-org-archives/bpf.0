Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A2267B05
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101870; cv=none; b=nOBkw7SJ0KO9oxbgZRJxbDAXZDt/+ruIsky9lDkiuPjYfr9Ue8jqLLpwt8blc4Q1SlY3MFnLoEIol6cRaU30FS3SwTKrQhjG7i+FcjJQC9ISPlzFhg05ZkMSHBjY7UcX3I6oBvn7mhEcE8wTgn97gNIWbgVbygEZepI5PziMtwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101870; c=relaxed/simple;
	bh=iH6JNcnd/nrwpJaOKo+j85es6mKFAlHz0wHBVxBvjNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDw2FXJWMGzPLUNbfF/IeU5rUwm/jSExqWGpLlZHX37lXjlPJnLd4kmKG8u5qddeLLzCc9cJJFSb6pM2olYWPQqBKQLvZS5R+ljX9PHKyKpPKE3KOL3jtiT5QG8hM7YxPqrZCwd+eIBD8e+HYwGmUsQQQ63IxtlzF/Y7spUyIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX5JItGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX5JItGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABE1F00898;
	Sat, 30 May 2026 00:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101869;
	bh=qanXZzE7etdU5STR3toWJ1wEN0so+P3ZN41azq5RTHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nX5JItGvsy7u5sB82XNoI+8jWcS4ZcgoO3Sz0abl6CFic1I/VL9cESxgk6yCH2urP
	 7zJbOGQUM2tLDsQ8J+uvl6wgxtDPLMZjgir1kYujje+iggE4OfuzbRdG7BfuVffp58
	 wtX4qxPJ3tRM9wAQxkwELi8Kgblc2sfUqEqcn/tFkA2qrTrwNHpO6MXB/AaR2aj5NU
	 bl57FaE+rNvUjcoCnfhYDfCC7ar4NuX1p66FvypuWNPmcSwUPCJFepCoqiypQASCax
	 iC5t2IvFCwaiZdg639d8RerDFADt4x6tvNfkkUoTlWCxuSXqOzqZNvJZ4O+yVk+d4g
	 BZzrhkSUFxBdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 2/2] selftests: net: add local ECMP rehash
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Spring" <ntspring@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520064310.4154268-3-ntspring@meta.com>
References: <20260520064310.4154268-3-ntspring@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:28 +0000
Message-Id: <20260530004429.24ABE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `test_ecmp_dst_rebuild_syncookie_consistency` fails to =
verify its claim that both endpoints select the same ECMP path.
--

commit f06e95b4d5669d963a1fb7ffc9820d130b26b945
Author: Neil Spring <ntspring@meta.com>
Subject: selftests: net: add local ECMP rehash test

This commit introduces a new selftest script, ecmp_rehash.sh, to verify
TCP local ECMP path re-selection. It includes nine test scenarios covering
various network conditions like SYN/ACK retransmissions, midstream RTOs,
PLB, and dst rebuild consistency with and without syncookies.

> The dst rebuild tests stream data, replace the ECMP route with
> identical nexthops, and verify that traffic stays on the same path.
> The route replace creates a new fib6_info, causing ip6_dst_check()
> to fail on the next transmit and trigger a fresh route lookup via
> inet6_csk_route_socket().  The syncookie variant verifies that the
> server's initial mp_hash (set in cookie_v6_check()) is consistent
> with the client's, so both endpoints select the same ECMP path.

[ ... ]

> diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing/s=
elftests/net/ecmp_rehash.sh
> new file mode 100755
> index 0000000000000..f41fc1e633565
> --- /dev/null
> +++ b/tools/testing/selftests/net/ecmp_rehash.sh

[ ... ]

> +ecmp_dst_rebuild_check()
> +{
> +	local ns_client=3D$1; shift
> +	local ns_server=3D$1; shift
> +	local port=3D$1; shift
> +	local rc=3D0

[ ... ]

> +	local base0 base1
> +	base0=3D$(link_tx_packets_get "$ns_client" veth0a)
> +	base1=3D$(link_tx_packets_get "$ns_client" veth1a)
> +
> +	ip netns exec "$ns_client" timeout 15 socat -u \
> +		OPEN:/dev/zero \
> +		"TCP6:[fd00:ff::2]:$port,bind=3D[fd00:ff::1]" \
> +		&>/dev/null &
> +	local client_pid=3D$!
> +
> +	# Wait for enough packets to identify the active path.
> +	# Return 2 for setup failure (distinct from 1 =3D path changed).
> +	if ! busywait "$BUSYWAIT_TIMEOUT" until_counter_is \
> +			">=3D $((base0 + base1 + 50))" \
> +		link_tx_packets_total "$ns_client" > /dev/null; then

[ ... ]

> +	local mid0 mid1 active_dev inactive_dev
> +	mid0=3D$(link_tx_packets_get "$ns_client" veth0a)
> +	mid1=3D$(link_tx_packets_get "$ns_client" veth1a)

[ ... ]

> +	local active_after inactive_after
> +	active_after=3D$(link_tx_packets_get "$ns_client" "$active_dev")
> +	inactive_after=3D$(link_tx_packets_get "$ns_client" "$inactive_dev")

[Severity: Medium]
Does this test actually verify that both endpoints select the same ECMP
path as described in the commit message?

The test implementation in ecmp_dst_rebuild_check() only monitors the
client's TX statistics (veth0a and veth1a in $ns_client). It never appears
to inspect the server's TX statistics (veth0b and veth1b in $ns_server)
or the client's RX statistics to determine which path the server used
to send ACKs.

Since both ECMP paths are open during this test, the connection will
succeed regardless of the server's path choice. Should this test also
verify the server's TX statistics to ensure the syncookie consistency
claim is actually validated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520064310.4154=
268-1-ntspring@meta.com?part=3D2
