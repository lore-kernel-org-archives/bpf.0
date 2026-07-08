Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028039281D
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518681; cv=none; b=NWePL/5jvM5gLESps0FbK5cbIQ56LftDhsLXJgnuK1SZqrGBSAsM1lRfk3HT875EGVGn/iAlyoGdMvEY8ARyYN894c68HP2CYYuzCn4aiRnBBnSUuaCfIDn97Vuo3JG9SiK3QTR6SfBiLGyc4RtrYSLmDo/mRiOGaWPx9yprVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518681; c=relaxed/simple;
	bh=Y/QSa/nPVNC5fh4qWI2N7dZ8SL/lBnxT78BZTatHljQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q2f9rl/isQ+PUWKJUTv0QzTgqPZ92VqnSoT6Y02HxuuWKtvrwT5eEfw1jDNuRh6iB3Dcu1gVDb0uhO1AYFSkxgXb6q9GpWlW/IgjT6PXQ7jx6SYAA/NSTVL+Cl8h92OFgfhmjJQat/V7yDXYEY+pKA+pceVPRf71r4OP8YER85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l17xjUAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l17xjUAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6201F000E9;
	Wed,  8 Jul 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518673;
	bh=j/6BxaWGLk97y0lesce9tYSJ9xzRJRbIPt9Dt3KOIOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l17xjUASdmMpF4LGLdzoOEb3h5GbBEMzbD4+qoGb6AAvaK7Ic8yIWx/DuCCS9xtQr
	 cULKyVBw4sRp7Pm6XY0Flc+MmaT76jZvvHjkftcejkO8w8ADzy0THFzCtfeyMGgNWs
	 E1n7KDjfyuiJFdfot2Jx9N1PKuA5/GMn0YaDt3i0u5Q3yWUu4Kv3LbS+uLXFVriRAY
	 xz5aqWL6f/DJhDBqPpq8gU1K6pDjz4zFTfwSJ6sfBKazQONclUKOvUGtyUqo/aOhpQ
	 PTobwOgaz213xvETHEu3p1Kw8g17v/a3fZyBh2W69OWKOOSyuqe1blPOcED3n8mnzZ
	 r7xgL7dryoQhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test FIONREAD on a sockmap
 socket without a verdict program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattia Meleleo" <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-fionread-no-verdict-v2-2-29dd293621c7@coralogix.com>
References: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
 <20260708-fionread-no-verdict-v2-2-29dd293621c7@coralogix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:51:12 +0000
Message-Id: <20260708135113.3E6201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The test allocates two socket pairs but only uses one.
- [Low] Multi-line comment violates BPF subsystem styling rules.
--

--- Patch [2]: [PATCH bpf v2 2/2] selftests/bpf: Test FIONREAD on a sockmap=
 socket without a verdict program ---
commit b610a0eeb2389887cf749b47e6bba8ebcb416f08
Author: Mattia Meleleo <mattia.meleleo@coralogix.com>

selftests/bpf: Test FIONREAD on a sockmap socket without a verdict program

This commit adds a test to validate that FIONREAD on a TCP socket in a
sockmap without a verdict program correctly reports data pending in
sk_receive_queue.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711f93a..f0f368201ddad 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotype)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +/* A socket in a sockmap without a verdict program keeps its ingress data
> + * in sk_receive_queue: FIONREAD must account for it.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
coding style? The preferred style requires the opening /* to be on its own
line, rather than sharing a line with the comment text.

> +static void test_sockmap_no_verdict_fionread(void)
> +{
> +	int err, map, zero =3D 0, sent, avail;
> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
> +	struct test_sockmap_pass_prog *skel;
> +	char buf[256] =3D "0123456789";
> +
> +	skel =3D test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);

[Severity: Low]
Is it necessary to allocate two socket pairs here?=20

The test allocates c0 and p0 alongside c1 and p1, but c0 and p0 appear to be
entirely unused except for being closed at the end of the test. Could this
use create_pair() to allocate just a single socket pair instead?

> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
> +		goto out;
> +
> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-fionread-n=
o-verdict-v2-0-29dd293621c7@coralogix.com?part=3D2
