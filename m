Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F63ECBE8
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265423; cv=none; b=nO3Gh+lbDYiBdRDz7aXyukKB92u3lzsZoiC/Ai9Qd2s4LyifTMfsglC0T8QR0GBqt8ynQp7Qjzv7i2CMTswRPuLHs+2zHMtvjI+z/NXa/EHuvwTt8mrlT1+HyNlV7OSBv6IW1GLOfbdqRasiW7cMLcEskaKC+WvJIgR3pLOyVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265423; c=relaxed/simple;
	bh=Gm9o3axkz+DlsBBpbJdl/ovQZ0RjZkt7NSJDf+NCjdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZfIAgl3oF5Bpkag8MykZb0jr4RR7PJWErHvPDPlzjh0r2TWBUHqc9BbiToyKYG2XtV1ZNzJx6VWiZ7hWNLIqe5NIeKIPJ+osk6OOr4y94Ms2HYdzfgGosasrvnsaaiqK8g9MlLC9jYFIBkd0mZp04AVipf1u12S6P2QmL/qYLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXqgUjj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXqgUjj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59841F000E9;
	Fri, 12 Jun 2026 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781265417;
	bh=t74imXOZNVwvZt+aHx9vDzN0H8ToyJ+9myaccNnm7BU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXqgUjj3fFRqP1dlB9FxP492kcAmCuVgeG5s4O0p7yGh1Ymc+/02f0FsvQu3gPYSq
	 oOOTNToVaKbdLdTx3gskgr7GvaFevca+Ot09FC63i+WyVonipuQQBFOFd/cs19d7vU
	 U23yPeePB6sgoaHOCaCMDTb6+aV0i9J15B0cLu2uXZMo35bETJFYtiGmOo1eB+oka/
	 /TN5RWOc/jBL9UjhJxUC4YQAptG/iiN4b3BtSAeWi7Wm8C5U1MnYvX8zkft5WMBpyL
	 pHiy5rHQg9mYchgeM8YbuZo+5UR4dfRfCNuIKeNg4ShrCm/dQEZQKzk53sSxL0dTtb
	 1sm01UuPusEWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover generic devmap egress
 last-dst rewrite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612114032.244616-3-sun.jian.kdev@gmail.com>
References: <20260612114032.244616-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:56:56 +0000
Message-Id: <20260612115656.B59841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The sentinel value `sentinel_mac` is identically initialized to =
the same value as `last_mac`, masking the bug the test is intended to detec=
t and resulting in unreachably broken assertions.
- [Low] Redundant manual file descriptor validation on skeleton-generated m=
aps violates the BPF subsystem Skeleton vs Manual Lookup guidelines.

Pre-existing issues:
- [High] Uninitialized stack variable `net_config` is passed to `cleanup_ne=
twork` on error paths in `xdp_veth_egress`, leading to undefined behavior a=
nd potential command injection.
--

commit a20e1dfd3338912dfdbb631c91d105ada7591c25
Author: Sun Jian <sun.jian.kdev@gmail.com>

selftests/bpf: Cover generic devmap egress last-dst rewrite

This commit strengthens xdp_veth_egress to check that each destination
observes the MAC selected for its own egress ifindex, and adds a generic
XDP last-destination test.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/too=
ls/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> index 3e98a16659362..1675b32753a8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> @@ -531,15 +541,162 @@ static void xdp_veth_egress(u32 flags)

[ ... ]

> +destroy_xdp_redirect_map:
> +	close_netns(nstoken);
> +	xdp_redirect_map__destroy(xdp_redirect_map);
> +destroy_xdp_redirect_multi_kern:
> +	xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
> +destroy_xdp_dummy:
> +	xdp_dummy__destroy(xdp_dummy);
> +
> +	cleanup_network(&net_config);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to pass the
uninitialized net_config struct to cleanup_network() on error paths?

In xdp_veth_egress(), we declare net_config without initialization:

	struct net_configuration net_config;

If skeleton loading fails (e.g., xdp_redirect_multi_kern__open_and_load()),
the code jumps to destroy_xdp_dummy and calls cleanup_network(&net_config).
Inside cleanup_network(), uninitialized stack data like net_config.ns0_name
is passed to system() commands via SYS_NOFAIL(), which might trigger arbitr=
ary
shell commands since selftests run as root.

> +}
> +
> +static void xdp_veth_egress_last_dst(u32 flags)
> +{

[ ... ]

> +	if (!ASSERT_OK(create_network(&net_config), "create network"))
> +		goto destroy_xdp_redirect_map;
> +
> +	mac_map =3D bpf_map__fd(xdp_redirect_multi_kern->maps.mac_map);
> +	if (!ASSERT_OK_FD(mac_map, "open mac_map"))
> +		goto destroy_xdp_redirect_map;
> +
> +	egress_map =3D bpf_map__fd(xdp_redirect_multi_kern->maps.map_egress);
> +	if (!ASSERT_OK_FD(egress_map, "open map_egress"))
> +		goto destroy_xdp_redirect_map;

[Severity: Low]
Are these FD validation checks needed?

After a successful skeleton __open_and_load(), the skeleton guarantees that
all maps and programs are loaded with valid FDs. We don't need additional
ASSERT_OK_FD() validation when accessing fields like
xdp_redirect_multi_kern->maps.mac_map.

[ ... ]

> +	res_map =3D bpf_map__fd(xdp_redirect_map->maps.rx_mac);
> +	if (!ASSERT_OK_FD(res_map, "open rx_map"))
> +		goto destroy_xdp_redirect_map;
> +
> +	memcpy(&sentinel_mac, egress_macs[VETH_PAIRS_COUNT - 1], ETH_ALEN);
> +	memcpy(&last_mac, egress_macs[VETH_PAIRS_COUNT - 1], ETH_ALEN);

[Severity: Medium]
Does initializing sentinel_mac and last_mac to the same value bypass the
intended checks?

Since both are initialized to egress_macs[VETH_PAIRS_COUNT - 1], if the
res equals last_mac, the test will fail at the first assertion:

	if (!ASSERT_NEQ(res, sentinel_mac, "rx_mac overwritten by store_mac_1"))

with a misleading error message. The second assertion checking against
last_mac then becomes unreachable:

	if (!ASSERT_NEQ(res, last_mac, "earlier dst not rewritten by last dst"))

> +
> +	key =3D 0;
> +	err =3D bpf_map_update_elem(res_map, &key, &sentinel_mac, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612114032.2446=
16-1-sun.jian.kdev@gmail.com?part=3D2
