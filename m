Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362813E7BCA;
	Thu, 15 Oct 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052546; cv=none; b=j6qDyknC3hiu2CrqUWy8ZX2s3L4u9LtabBViiu7peCK1Ymk/SjeIbW+fGB4GbVDrsTDxKwH/SakBClEpMmvKlwECogpgmKOEzMC5k1ftet5TNVYm2W1ukMiWb622UOw5VmToFsDqYuqDTCI+nsXRBOvQBRZunYzZ6Rtrl+koKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052546; c=relaxed/simple;
	bh=G+L/wgaoYcqBZ4ijjYMw+BMWmzjqLw6Vr6U8+yyyXFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AuZCAasY0QJ/jCVbJgUHOShWGhjQjqWoZcbVc/uzgpdLbc5P92wedOFbRBO/rLKkY/+iEV/99cQABvxMCK7eo33c+PCeZNqmf+UUMp/NYTGlRITOErcSoBfUAxtOIwFuPYKkIquRZz3CcqgqX6WL1IqAZKoMjlrvTJOtw9pxcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+bzdRN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+bzdRN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5655C1F000C4;
	Thu, 15 Oct 2026 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052545;
	bh=G+L/wgaoYcqBZ4ijjYMw+BMWmzjqLw6Vr6U8+yyyXFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n+bzdRN4gOLiRgh3GakUYRHOzLlWGtjXfmEX8W49SSAqSJAw4Y16AlhLUtI9P7iWq
	 vhpwh8IX4kf4b4LC35CO7X1D0896mEGQry56K+23C/TUROsg2WXpUmDGKGyeF6c9v+
	 GPOX0iHWjjJZz2oE9QGotAHq8FZu7bsMq+E49DDO/Dmnb6Ja6GjXgvoAh73zqBL3iM
	 DTwJbW7EQ4cKIDGPMO7VS0f/5kvH4+zwlUqaVQ1WkTWUuZ92fMzqaOxVZ3mAt8VCE0
	 VOClSVaAgtV0se2KXlld1oR8ouxG0s5F0fd2OCUKRsD+eskOcfakumOZQa6Xd9OQRD
	 96p90kVRDdu0Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 06/15] selftests: xsk: move the AF_XDP test
 suite to selftests/net
In-Reply-To: <20261014184539.774708-7-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-7-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:22:21 +0200
Message-ID: <87ld7z74qq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Move the xskxceiver engine, the AF_XDP userspace library, the test
> definitions and the XDP program to net/lib/xsk, and test_xsk.sh with
> its prerequisites script to selftests/net. A later patch drives the
> same engine against real NICs from drivers/net/hw, and net/lib is where
> both suites take shared helpers from.
>
> net/lib builds xskxceiver with its XDP program and skeleton, using the
> bpftool in PATH, and skips it with a warning when bpftool is missing or
> does not run; test_xsk.sh then skips too. xskxceiver links -lpthread,
> which glibc older than 2.34 needs for the threads of test_xsk.c.
>
> Like the rest of net/lib, xskxceiver builds against the installed uapi
> headers, so include linux/kernel.h for min_t() directly rather than via
> the tools copy of linux/netlink.h. tools/include goes ahead of CFLAGS,
> so that O=3D builds take linux/kernel.h and linux/types.h from it rather
> than from a source tree usr/include.
>
> Move the two ethtool ring helpers from network_helpers into xsk.c and
> point the kselftest.h include of test_xsk.h at the net/lib include
> path. The XDP program moves unchanged; its Ethernet header bound check
> compares pointers of distinct types, so net/lib builds it with
> -Wno-compare-distinct-pointer-types, as the bpf selftests do.
> xdp_hw_metadata and the xdp_metadata test keep using xsk.c and xsk.h
> from their new location. Update the AF_XDP entry in MAINTAINERS.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
