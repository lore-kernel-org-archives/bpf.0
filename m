Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F27CA45
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312466; cv=none; b=DS1uYxNXNuq90W2+N9WsQW5rAS92dgVHqaHQYgS5CyLuPfxgHYM0elWt08s7iSFWCV6lMBEEFvHrXaGN3DqY+2VJnH6qNQFBoV1B7pjCC+yFO4/lLK97eEPm9pOggUHn0Pz+5ZaiBkVSCA805siTfqzi4FBadjyn1xREysEwneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312466; c=relaxed/simple;
	bh=t/A82o8urKftOwVzbPUcXajyxtok1nkjhIX4o4u3XGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pFBsp0YMGRB2ZqSZjAs8SRF5PoJ4EiljurHNx/2jQdynugR7ScetZv3zUud0ihguh1S+gE5FANh+oNgFMq9eLGULoXWO/wg9FmuU3MLEj8AET41ndrEYnqjfWWzIJ0RLtYN8oXIWJlk+VqwrmhrdSkp6xQx3ytr9qkDlPEQZIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnoKX4iQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnoKX4iQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7D01F000E9;
	Sat, 13 Jun 2026 01:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312464;
	bh=P4QfsU4Qs8sKcP1UV1f+UqbLLvtD39R1khLMzbgsZRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EnoKX4iQhTce1jVPG9gcSPrPVdu4v5OK+jk9nJXOYijIn5HXvzLC6bxtlvGNt3j7I
	 CYqi+S4hibjiwE/MnZZcNPI6O2HN+F7rlFrNTpJSgnWkL91F/JEFD91iB+Jh98P2hv
	 iqFR/YUGBwS0Xjx2nhNVbluqb/yOCdVVU75Xun3BHoaj3m0uurpg0iPgZJFFGP8aei
	 oxZtGch9KFynpJTzsMoMKmOricLFXMwgoJ5+oBCfub2x3ZMval7WKLy+cWpOG7us4E
	 cZO9U4Vz3FrLz5Eh5IAxizenrXmJgxGlfi/xKpywS+kkdl4U0MiJRbj6BeHUA89pBW
	 ja+KgN5bYbTfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v13 2/2] selftests: net: add local ECMP rehash
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Spring" <ntspring@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612010047.1377331-3-ntspring@meta.com>
References: <20260612010047.1377331-3-ntspring@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 01:01:03 +0000
Message-Id: <20260613010104.8E7D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `test_ecmp_dst_rebuild_syncookie_consistency` test measures =
the client path instead of the server path, failing to verify the syncookie=
 server socket dst rebuild behavior.
--

commit 6880e49ae1e2a7fb67be7b81ac5c2bb2b4bb3261
Author: Neil Spring <ntspring@meta.com>

selftests: net: add local ECMP rehash test

This commit adds a script with several scenarios to test local ECMP path
re-selection on TCP retransmission timeout and PLB. It verifies that TCP
rehash properly selects different ECMP paths under various network
conditions and settings.

> diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing/s=
elftests/net/ecmp_rehash.sh
> new file mode 100755
> index 0000000000000..ccb761ecd160b
> --- /dev/null
> +++ b/tools/testing/selftests/net/ecmp_rehash.sh
[ ... ]
> +ecmp_dst_rebuild_check()
> +{
> +	local ns_client=3D$1; shift
> +	local port=3D$1; shift
> +	local rc=3D0
[ ... ]
> +	local base0 base1
> +	base0=3D$(link_tx_packets_get "$ns_client" veth0a)
> +	base1=3D$(link_tx_packets_get "$ns_client" veth1a)
[ ... ]
> +ecmp_dst_rebuild_loop()
> +{
> +	local base_port=3D$1; shift
> +	local label=3D$1; shift
> +	local path_changes=3D0
> +	local r
> +
> +	for r in $(seq 1 "$ECMP_REBUILD_ROUNDS"); do
> +		local port=3D$((base_port + r))
[ ... ]
> +		local check_rc=3D0
> +		ecmp_dst_rebuild_check "$NS1" "$port" || check_rc=3D$?
[ ... ]
> +test_ecmp_dst_rebuild_syncookie_consistency()
> +{
> +	RET=3D0
> +
> +	local saved_syncookies
> +	saved_syncookies=3D$(ip netns exec "$NS2" sysctl -n \
> +		net.ipv4.tcp_syncookies 2>/dev/null)
> +	if [ -z "$saved_syncookies" ]; then
> +		log_test_skip \
> +			"ECMP path stable after dst invalidation (syncookies)"
> +		return "$ksft_skip"
> +	fi
> +	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_syncookies=3D2
> +	defer ip netns exec "$NS2" sysctl -qw \
> +		net.ipv4.tcp_syncookies=3D"$saved_syncookies"
> +

[Severity: Medium]
Does this test the server socket's dst rebuild logic?

When test_ecmp_dst_rebuild_syncookie_consistency() calls
ecmp_dst_rebuild_loop(), the loop hardcodes the client namespace ($NS1)
for the rebuild check:

    ecmp_dst_rebuild_check "$NS1" "$port" || check_rc=3D$?

And ecmp_dst_rebuild_check() uses the client namespace and interfaces
(veth0a/veth1a) to measure traffic, and invalidates the route on the client.

Since TCP syncookies are transparent to the client, doesn't this exercise t=
he
exact same client-side code paths as the standard non-syncookie dst rebuild
test, skipping the intended validation of the server socket's dst rebuild
behavior?

> +	ecmp_dst_rebuild_loop "$((PORT + 2 * ECMP_REBUILD_ROUNDS + 1))" \
> +		"ECMP path stable after dst invalidation (syncookies)"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612010047.1377=
331-1-ntspring@meta.com?part=3D2
