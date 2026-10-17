Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831C3BBA04
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259079; cv=none; b=U4+l3nZjnfhwynPtiD/Nzs4+hNb6dd1FU9dEEkUrl1Xdrd0HpjFsKvVAnbswJfIe5NyX5jmXs8xStrE+CeCSj1QqjWzBArcjfDPKwFn27UyVOKBoTM2+jFqrmQFO+DXNaRNvq6DYymJR7RKy27KAaXsE20iKZ+dI7rhL/Z/m5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259079; c=relaxed/simple;
	bh=TJoXTLeZYya7vlpBy165K61mM0lbewpzgwXK6YzIPlU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=S+GF5NdeV8lm1WTAKu6rW5mMLNV/e/cqCaq9YvH6/kUxDvN9nkKdwWBnpclwf0xcEwQMe3Aw8cAplqe4/fWh2snuLljphUrQf2SkVTNk+VAiQgaYvcb7eTFC2WrV/V4MV55jIv1paZx5v4zsDTuxtDTyg0lFzA/7Y9kkSI0WGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNcLbjfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNcLbjfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CFC1F000C7;
	Sat, 17 Oct 2026 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792259077;
	bh=3yyN0gxFg1AvF+IsNJ8hy3dlR3GPvXwkR93496l2kaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fNcLbjfe4TpS+7zveRSriNZMYbsto8qQqn79RBGYrYchnDaOXLaTMYf6p66lGkxtj
	 DpXqDRX5xI5DA0mMFw01BdfzVCZyxDc1zgjJBzdkcjiLfkIPTVujERG3by/d0YvRxV
	 y9grEOQ11CxrhsCYBLT9bVMwAnKVtFhlELZhlcpkD9HnwSnGMReaFHa3W6cVmwe3aQ
	 7iR+VLuNeikQFtfx2JGOCG3Og+yTNpI+5uJ8F/a6a8RqHNOJnwCX1yOEsjdlWMjWJn
	 IVesGhaXnV9tS3/oGhM6AYbNw6CKYN2e956pFvkxKtkmOUBSul6djifHaSV1AnBJpz
	 MC88AZ1a3HVLg==
Message-ID: <sashiko-outbox-175723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016174338.787135-10-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
 <20261016174338.787135-10-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:44:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: missing prerequisites (root, veth) cause hard failure=
 instead of skip
--

commit 621c952e0f68b97c93b16b3262842ed60506e7fc
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: xsk: run one test case per xskxceiver invocation

Replace test_xsk.sh and xsk_prereqs.sh with test_xsk.py to run xskxceiver o=
nce
per mode and case. The new Python script relies on the networking selftests
Python library to manage test cases and resources.

> diff --git a/tools/testing/selftests/net/test_xsk.py b/tools/testing/self=
tests/net/test_xsk.py
> new file mode 100755
> index 0000000000000..80ac67cdebb66
> --- /dev/null
> +++ b/tools/testing/selftests/net/test_xsk.py
[ ... ]
> +def _veth_pair(busy_poll):
> +    pfx =3D f"xsk{random.randrange(1 << 20):05x}"
> +    veths =3D (pfx + "a", pfx + "b")
> +    ip(f"link add {veths[0]} numtxqueues 4 numrxqueues 4 type veth "
> +       f"peer name {veths[1]} numtxqueues 4 numrxqueues 4")

[Severity: Medium]
When the test suite is run as a non-root user or on a system without veth
module support, will this cause a hard failure rather than a skip?

The previous xsk_prereqs.sh script explicitly checked for root privileges a=
nd
veth support, returning ksft_skip gracefully if they were missing. Here, the
ip() command will raise a CmdExitFailure exception if the privileges or dri=
ver
are missing, which the test runner catches and reports as a failure.

Could this turn an environment difference into a false regression signal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016174338.7871=
35-1-maciej.fijalkowski@intel.com?part=3D9
