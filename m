Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F7377544
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166253; cv=none; b=HWLzX9shBtRMXJ9+VMj5guD5IPH7zhIlRK7FIv4do+zCUt5C4scVV0B12++a9meX6qf3MsOVvflioECWhVnpbXL29KrcdM6TkONpgEcpO1B1VQE2Jxr9h190+LNgH612jhYPbQSwhsJyT0gALMDsoZdrxlvesibnmGjBa5Alt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166253; c=relaxed/simple;
	bh=a6Yvow8n2ykwCb67sdPNyrWwWVkiXSgA1mV9EkbQnuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fSA+4CneqS5TJe6Iq/nZSD1VHb4iAC13tGaCZU6qXwFepnmIg4hRoBqQ5MM7GgGkiFA+oqSjvHOSsRITpyRdci/fVpQ99KrlHeT7WSo2tKntRQ3HZfEfGPlvgo6C3MURrKd2+N0MQ/0nhzOylt4g8TQTZJTpmlhJO+Cs075h9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw8aZCrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw8aZCrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905381F00898;
	Thu, 11 Jun 2026 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781166251;
	bh=D7w8PzZg+nYgqk35xBzeRJFV6A1yLz4I0AZE571+Aa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cw8aZCrG+OC4bubwWkxIiwohsiPihD1GOKHZclKjncy6othqW45qxO+17Gg+wLjIk
	 3CQW3WI1bEwSrWsiYhlhzc8KSWw1NVuenyBwFnxohdEv0GMAApZ2H+1fO5z4ql94JC
	 XcXfgnYQpXZGT+0WxnivtSi5x4rtbcuOXE8rPIhu5w8SBtq+kGT1250fRJdGDKpady
	 3+bWF1K+CBicU1ixn1/GaB7CaXBeyB9b9mKf3kVxgN4qnA40iP/tiJPI7nEiA4WPeF
	 aiWRfAyODI31py0GjccO1ybn4hoQ3gCLd3vhoSjcQHxK75bqx/NwU3TH42BrA55hun
	 6tq7fC3x9r8iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Cover generic devmap egress
 last-dst rewrite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611080850.536996-3-sun.jian.kdev@gmail.com>
References: <20260611080850.536996-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 08:24:11 +0000
Message-Id: <20260611082411.905381F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] bpf_map_lookup_elem on an ARRAY map never returns -ENOENT, masking=
 dropped packets and causing a false positive test pass.
- [Low] The test performs manual FD validation (`ASSERT_OK_FD`) on map file=
 descriptors immediately after successfully loading the skeleton, violating=
 the explicit BPF selftest guidelines.

Pre-existing issues:
- [Critical] Uninitialized stack structure `net_config` is passed to cleanu=
p functions on early error paths, causing arbitrary shell command execution=
 via stack garbage.
- [High] bpf_map_update_elem reads 8 bytes from a 6-byte user-space array, =
causing an out-of-bounds stack read.
--

commit 89d44c6ff3ea8b2a422a70685fda70fa6ebcbf9c
Author: Sun Jian <sun.jian.kdev@gmail.com>

selftests/bpf: Cover generic devmap egress last-dst rewrite

Strengthen xdp_veth_egress to check that each destination observes the
MAC selected for its own egress ifindex, instead of only checking that
the observed MAC differs from a single magic value.

Add a generic XDP last-destination test where earlier destinations do
not have a devmap egress program while the final destination does.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/too=
ls/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> index 3e98a16659362..0fa2cf835c629 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> @@ -456,7 +456,11 @@ static void xdp_veth_egress(u32 flags)
>  			.remote_flags =3D flags,
>  		}
>  	};
> -	const char magic_mac[6] =3D { 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};
> +	const unsigned char egress_macs[VETH_PAIRS_COUNT][ETH_ALEN] =3D {
> +		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x01 },
> +		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x02 },
> +		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x03 },
> +	};

[Severity: Critical]
This is a pre-existing issue, but does the error handling in
xdp_veth_egress() execute arbitrary shell commands?

In xdp_veth_egress(), net_config is declared on the stack without
initialization. If an early failure occurs (such as
xdp_dummy__open_and_load() failing), the error path calls
cleanup_network(&net_config).

This cleanup function invokes SYS_NOFAIL("ip netns del %s",=20
net_config.ns0_name), which will execute a command using whatever stack
garbage is in the uninitialized ns0_name field.

The new xdp_veth_egress_last_dst() function added in this patch correctly
uses net_config =3D {} to avoid this problem.

[ ... ]
> @@ -512,7 +516,7 @@ static void xdp_veth_egress(u32 flags)
>  						 &net_config, prog_cfg, i))
>  			goto destroy_xdp_redirect_map;
> =20
> -		err =3D bpf_map_update_elem(mac_map, &ifindex, magic_mac, 0);
> +		err =3D bpf_map_update_elem(mac_map, &ifindex, egress_macs[i], 0);

[Severity: High]
This is a pre-existing issue duplicated by this patch, but does this
bpf_map_update_elem() call read out of bounds?

The mac_map is defined in xdp_redirect_multi_kern.c with a value_size of
8 bytes (__be64), but egress_macs elements are only 6 bytes (ETH_ALEN).
For the final element in the array, this operation will read 2 bytes past
the end of the egress_macs stack array into stack garbage.

[ ... ]
> +static void xdp_veth_egress_last_dst(u32 flags)
> +{
[ ... ]
> +	mac_map =3D bpf_map__fd(xdp_redirect_multi_kern->maps.mac_map);
> +	if (!ASSERT_OK_FD(mac_map, "open mac_map"))
> +		goto destroy_xdp_redirect_map;
> +
> +	egress_map =3D bpf_map__fd(xdp_redirect_multi_kern->maps.map_egress);
> +	if (!ASSERT_OK_FD(egress_map, "open map_egress"))
> +		goto destroy_xdp_redirect_map;

[Severity: Low]
Is this FD validation necessary?

According to BPF selftest guidelines, after a successful
xdp_redirect_multi_kern__open_and_load(), all maps are guaranteed to be
created with valid FDs. Manual FD validation like this is not needed when
using skeleton-generated fields.

[ ... ]
> +		err =3D bpf_map_update_elem(mac_map, &ifindex, egress_macs[i], 0);
> +		if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +			goto destroy_xdp_redirect_map;

[Severity: High]
Does this bpf_map_update_elem() call also read out of bounds, similar to
the pre-existing issue above?

The map expects an 8-byte value (__be64), but the egress_macs array element
provides only 6 bytes.

[ ... ]
> +	for (i =3D 0; i < VETH_PAIRS_COUNT - 1; i++) {
>  		u32 key =3D i;
>  		u64 res;
> =20
>  		err =3D bpf_map_lookup_elem(res_map, &key, &res);
> +		if (err =3D=3D -ENOENT)
> +			continue;
>  		if (!ASSERT_OK(err, "get MAC res"))
>  			goto destroy_xdp_redirect_map;
> =20
> -		ASSERT_STRNEQ((const char *)&res, magic_mac, ETH_ALEN, "compare mac");
> +		found =3D true;
> +		ASSERT_NEQ(res, last_mac, "compare last dst mac");
>  	}

[Severity: High]
Can bpf_map_lookup_elem() actually return -ENOENT for this map type?

Looking at xdp_redirect_map.c, rx_mac is a BPF_MAP_TYPE_ARRAY. Since array
maps pre-allocate their elements and zero-initialize them, lookups for valid
indices will always succeed (returning 0) and yield the current element
value (0 if unwritten), rather than returning -ENOENT.

If a packet is dropped and never updates the map, the value will remain 0.
The bpf_map_lookup_elem() call will succeed (err =3D=3D 0), and the test wi=
ll
trivially pass because res (0) is not equal to last_mac. Does this mask
datapath failures and cause a false positive test pass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611080850.5369=
96-1-sun.jian.kdev@gmail.com?part=3D2
