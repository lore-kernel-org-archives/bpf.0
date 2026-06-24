Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125A3B840E
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308022; cv=none; b=RjtugS6e1acxynLKT9NkTJjcdQqC1N9y68rMT+yuO7ayIuLMD70yxXK2kqJSc5vcXiFGgJ1vhLEJ9c+HlLL6SuvI64JmxVKFaIVWbSnx6We1U2WzhDx3lTVM6+i1YUkdG34pxq4aRQAXc/SK7TdlIpm0z5hBLejfv8EsNeoBv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308022; c=relaxed/simple;
	bh=+WaPCPWOiyRfrEqw0tmrJWDEV4k33IYVRBXBk6EZaBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pySswcQ78xRynLZk82mhAG73cU7PhMYk5eQcHpmrZt7VapXwT9f+0qHgHcens90eZJRY6rq/d2Q2BXJzsr5ACvL1MZ65yu09uFwQFnygmgdYC/3TlfAJ9vaU58LWzTM+gmlhjkUKcPOuqvQJQG4t9UYEPLBUm+b3Kj22hAp6ZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxEaA2F4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxEaA2F4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957561F00A3A;
	Wed, 24 Jun 2026 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308021;
	bh=QW+wgm4ERD4RmTVpEylOOsmuktmN/e2bRMc9+L53VRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxEaA2F4lhNh1Ue38Q/bTCNBLU8seK9CowqPIm5C+LfenAX6xlTdthpzOXG25K5v9
	 G09mZ+++pJ0r42s0OV6ISekii/ht8RwGx/MPZmwxP/WUWinjmRhJQeUipK4pDQjaO4
	 mTrRmR3DK5r+bIyd5NZT3KNX93uSW3mjWmIz3MTy6AMiczeSZKl3ctmrYYpPdfjG6H
	 eOG9MNOhB8SY60YWl6ZrPb4e6LqmuP3CeLhTjnfCiaOTY7yDlzXLg9OVHS7LGhQry2
	 HO1wZHPcdZWSux6OdVfsjLjOkHMquAfOGV9uZhdKGgJVZwxueUR+Rclp94lTYZmylw
	 Y8RkEb8ZxIcRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 6/7] selftests/xsk: fix too-many-frags multi-buffer
 Tx test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623133240.1048434-7-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-7-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:33:41 +0000
Message-Id: <20260624133341.957561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The comment describing the invalid packet construction contradicts =
the new code logic.
--

commit 55a7ead387fcdab87dd100f7febd5012bd365ab8
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests/xsk: fix too-many-frags multi-buffer Tx test

This patch updates the too-many-frags test to keep the oversized packet's
Tx descriptors valid for accounting purposes while ignoring the packet on
the receive side. It also appends a synchronization packet to verify
proper queue draining.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -2279,21 +2279,29 @@ int testapp_too_many_frags(struct test_spec *test)
>  	/* An invalid packet with the max amount of frags but signals packet
>  	 * continues on the last frag
>  	 */

[Severity: Low]
Does this comment need to be updated to reflect the new code logic?

The comment explicitly states the packet has the max amount of frags and
signals continuation on the last fragment. However, the modified loop now
appends an extra fragment (resulting in max_frags + 1 total fragments)
and explicitly clears the XDP_PKT_CONTD flag on that final fragment.

> -	for (i =3D max_frags + 1; i < 2 * max_frags + 1; i++) {
> +	for (i =3D max_frags + 1; i < 2 * max_frags + 2; i++) {
>  		pkts[i].len =3D MIN_PKT_SIZE;
>  		pkts[i].options =3D XDP_PKT_CONTD;
> -		pkts[i].valid =3D false;
> +		pkts[i].valid =3D true;
>  	}
> +	pkts[2 * max_frags + 1].options =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623133240.1048=
434-1-maciej.fijalkowski@intel.com?part=3D6
