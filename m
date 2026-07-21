Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75F433BDC
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618282; cv=none; b=da/t4DS/KmEVkp2kTcCuIBmir81olCGHyu4sBY9AaGOluWBPjSiomdI/XzAzCAPUvXpgoEwYhvIPOClYtUNmuMZIr3cKRkEx5zeDYSffuZmOXDsNioKngfqX/HUG5BRhXXDh3M2NVSTNF8tYTGMiaRlB9lXJQpvzo4k/10HC7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618282; c=relaxed/simple;
	bh=v4Sn1kt0qR/WulWgH4poDZWf7DK5PK+xd8XcZjsR/2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LpapkJpq6id+MaFDnwb9HvqkIErP6ROuNAIevN2THWdaw6OEja8E47/fA8yhLXnMoV1dDJfjFY22uPLXZAYH7g5bh8QbQj/prBE0qACEdt3nhjiv6yLx9RP6uBqljok9515RY0Sv1qznYqo7lxQJw5qtLIPzZkZetoJjr6m1fD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMK+ZBe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMK+ZBe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527C91F00A3F;
	Tue, 21 Jul 2026 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618281;
	bh=68H8YU4zQ0YE+FK1pWzcRZvWOy38cxrSdwGp4TkHarI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMK+ZBe3quTJ5O5ZEmomiGFJYRhE2X0+NEXFsS6PuvIGE7CIaj3COrObjG/bflSUn
	 h4YBMXxIhx2m2qg4sXlopcj4S+qddWictjXOqWfExDZ8GkRe0oT6TkFICp89xKUc/m
	 OGPQUyhKeF2hbxH5ykmjZCps4xm4TNxd2bwoWsCtXiZS3mFLSq3YOBcDriIhU5Oyio
	 Vsq9Vx1gz1Xfnk7/WU+NzLc2Hy6guuxTnKnb4joAxfPDYyskRXqlP/kUQm7hDLq6lh
	 Bghcs9Sw/ooKMNBWPGfRNZJrb9rZ1SLDa4LTNE8/1ip6Sz7merueXbz345REGorJVE
	 rx/SHGeN9LIqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 12/13] selftests: drivers/net: add knod
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260719175857.4071636-13-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-13-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:18:00 +0000
Message-Id: <20260721071801.527C91F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The tests hardcode relative paths to in-tree pyynl scripts and Y=
AML specs, which breaks when tests are run from an installed directory.
- [Medium] The map lookup script uses the GNU awk extension strtonum(), cau=
sing the test to unconditionally fail on systems using non-GNU awk (like ma=
wk).
--

--- Patch [12]: [RFC PATCH net-next 12/13] selftests: drivers/net: add knod=
 tests ---
commit 8c1df38ed71ba173e2fb3bc36bc8224d06cad0df
Author: Taehee Yoo <ap420073@gmail.com>

selftests: drivers/net: add knod tests

Add attach/detach and XDP offload selftests for knod, exercising the
genetlink control plane and the BPF data path over a knod-capable NIC.

> diff --git a/tools/testing/selftests/drivers/net/knod/lib.sh b/tools/test=
ing/selftests/drivers/net/knod/lib.sh
> new file mode 100755
> index 0000000000000..d0d9b03f109dc
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/knod/lib.sh
> @@ -0,0 +1,181 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# lib.sh - KNOD XDP offload test utilities
> +#
> +# The KNOD control plane is the "knod" generic-netlink family; it is dri=
ven
> +# here through the in-tree ynl CLI (tools/net/ynl/pyynl/cli.py) so the t=
ests
> +# need no dedicated user-space tool.
> +
> +KSRC=3D$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../../../.." && pwd)
> +readonly KNOD_YNL=3D"$KSRC/tools/net/ynl/pyynl/cli.py"
> +readonly KNOD_SPEC=3D"$KSRC/Documentation/netlink/specs/knod.yaml"

[Severity: Medium]
Will this hardcoded relative path cause the tests to fail when run from an
installed directory?

When tests are installed (e.g., via make install) and run out-of-tree, these
paths to cli.py and the YAML specs will likely be invalid since they are not
copied to the install directory by default.

[ ... ]

> +knod_map_lookup_u64() {
> +	local map_id=3D$1
> +	local key=3D$2
> +	local hex
> +
> +	hex=3D$(bpftool map lookup id "$map_id" \
> +	      key $key 0 0 0 2>/dev/null | \
> +	      grep -o 'value:.*' | sed 's/value: //')
> +	if [ -z "$hex" ]; then
> +		echo 0
> +		return
> +	fi
> +
> +	printf '%d' "$(echo "$hex" | awk '{
> +		v =3D 0;
> +		for (i =3D 8; i >=3D 1; i--)
> +			v =3D v * 256 + strtonum("0x" $i);
> +		printf "0x%x", v;
> +	}')"

[Severity: Medium]
Does the use of the strtonum() function break this script on systems using
non-GNU awk?=20

The strtonum() function is a gawk-specific extension. On systems where the
default awk is mawk or BusyBox awk, this may fail with an undefined function
error, causing the extracted map value to evaluate to 0 and the test to
falsely fail.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D12
