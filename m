Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D374A0915;
	Fri,  9 Oct 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544703; cv=none; b=heYNffAqZdZ11f5MHSuEuXfram177n4if4bUxpEVkPovah4i0kd5T6TgDQFCvvYIMpjBip3mmAeuHHXBHBSdNjn+flC0TAJYNnyQ1sgsOq1pKAWMGjVazpQvLyUMvyFCLO+hIIZOe9DIeDP/nLvQmRGVjDzbZ/fbM0arJ5RM0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544703; c=relaxed/simple;
	bh=7nxS2I2aVw+0r4Yzf+raKz1xpyoEyfatzqM5reWEoy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJN1x41cBWtOrnxd7IAmwHx1GpBq738Z0DbM8guOV1rlYjVO42+0t/rm6B+uipOL9rVBSQDasry0WNY2axWPkelCSwaQu25xL7HThndQZE+LMmBKMsd/Q/uAcnngkFMT6ZACtti9eApNYAD+ln7ZjXn2U5jpWZv/uAbgMDXldHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX8e1p6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX8e1p6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D6F1F000FF;
	Fri,  9 Oct 2026 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544693;
	bh=rWKMsscvTXY3/zZUf8OyMletBRfbuYUpwT7FFmOt+Mo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JX8e1p6tzNxj/VSqQpPPFaGhFdKBCyJPe4mZVr7BCfhQCn+mG46uyfLeQ0mNHG/C+
	 NImBU864zXrOjujG3QP297yFi7TGgVd+JTzSMaypnY1PmCeYPLiYnVg8aGbrvR7Js9
	 rkqDkDZXtOuLzuS3gRxfCywKtkLW0w8wWaOXx+uDAgrmP9qNFNG3Kpd8Ch7AtAnG+c
	 I0cDnzTWopJ/uT1NJ/NiLSd/AcVZ2TLCKs3uFIHugypSB/4wSmlsuA+yY9ukSDiIxK
	 AYVhS/tj/tzFW0uU1DtI9oASFr9zQ8ThlEhyfxg/Ea19QPLyFhWCeT8gFxsIhye/wR
	 sLFVTzNp43m/Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net-next 05/14] selftests: xsk: move the AF_XDP test
 suite to selftests/net
In-Reply-To: <20261008114909.734364-6-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-6-maciej.fijalkowski@intel.com>
Date: Fri, 09 Oct 2026 13:18:10 +0200
Message-ID: <87qzhzqg0d.fsf@all.your.base.are.belong.to.us>
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
> definitions and the XDP program to net/lib/xsk, and the veth launcher
> test_xsk.sh with its prerequisites script to selftests/net. A later
> patch drives the same engine against real NICs from drivers/net/hw, and
> net/lib is where both suites already take shared helpers from, so the
> binary does not need a second copy.
>
> net/lib builds xskxceiver together with its XDP program and skeleton,
> using the bpftool in PATH, and skips it with a warning when bpftool is
> missing or does not run, so the rest of net/lib still builds.
> selftests/net installs test_xsk.sh, which runs lib/xskxceiver.
>
> Like the rest of net/lib, xskxceiver builds against the installed uapi
> headers rather than the tools/include/uapi copies that the bpf selftests
> use. xskxceiver.c got min_t() only because the tools copy of
> linux/netlink.h includes linux/kernel.h, so include linux/kernel.h
> directly.
>
> Move the two ethtool ring helpers from network_helpers into xsk.c so the
> engine no longer depends on network_helpers, and point the kselftest.h
> include of test_xsk.h at the net/lib include path. The XDP program moves
> unchanged. Its Ethernet header bound check compares pointers of distinct
> types, so net/lib builds it with -Wno-compare-distinct-pointer-types, as
> the bpf selftests do.
>
> xdp_hw_metadata and the test_progs xdp_metadata test keep using xsk.c
> and xsk.h from their new location.
>
> Point the AF_XDP entry in MAINTAINERS at the new paths.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  Documentation/networking/af_xdp.rst           |  6 +--
>  MAINTAINERS                                   |  3 +-
>  tools/testing/selftests/bpf/.gitignore        |  1 -
>  tools/testing/selftests/bpf/Makefile          | 29 +++++------
>  tools/testing/selftests/bpf/network_helpers.c | 48 ------------------
>  tools/testing/selftests/bpf/network_helpers.h |  2 -
>  tools/testing/selftests/net/Makefile          |  2 +
>  tools/testing/selftests/net/config            |  1 +
>  tools/testing/selftests/net/lib/.gitignore    |  2 +
>  tools/testing/selftests/net/lib/Makefile      | 34 +++++++++++++
>  .../prog_tests =3D> net/lib/xsk}/test_xsk.c     |  2 +-
>  .../prog_tests =3D> net/lib/xsk}/test_xsk.h     |  2 +-
>  .../selftests/{bpf =3D> net/lib/xsk}/xsk.c      | 49 ++++++++++++++++++-
>  .../selftests/{bpf =3D> net/lib/xsk}/xsk.h      |  4 ++
>  .../{bpf =3D> net/lib/xsk}/xsk_xdp_common.h     |  0
>  .../lib/xsk/xsk_xdp_progs.bpf.c}              |  0
>  .../{bpf =3D> net/lib/xsk}/xskxceiver.c         |  7 +--
>  .../{bpf =3D> net/lib/xsk}/xskxceiver.h         |  0
>  .../selftests/{bpf =3D> net}/test_xsk.sh        |  0

I would not carry the test_xsk.sh over. Just do a Python variant, like
the drivers/net/hw/xsk.py, but for net instead. Look at the the
nk_lease.py pair for inspiration.

It's just a cogitive load switch between Python and bash. We're starting
out fresh(ish) here.

The Python ksft world gives us a lot for free.


Bj=C3=B6rn
