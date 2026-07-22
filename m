Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310839FCE
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729325; cv=none; b=fjE1j18n6txWrZkDT36WEkxPyu33CjDMKleVTRtzrYmdGngOnyDGBwfn4lkkdXiAXLrDT33NFx9IOPoPXK0TUpE3wrtlMxor0XXH1anBZ/72zcC6j2QHHWeDUXGleExlAWEpidgfABn9i4fYK4zdCbeNHWWK4oe9IuPBjbj/i8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729325; c=relaxed/simple;
	bh=/hDo/2ytwI3m3dibe3B2h6+SwchvwZC/CO7CUzuJIPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJ44unTX6n3C1SUEtjjjkcHJWdKFFr7ld2DjhNsdpF6KR9j32+f7X5N6KAXQeYwGFPElOKeX8Ex+oxRuUFtRZT3YpSVE6IHV3uOU/PvBPTFubNbBaH7jghqCEY2LSvN2lltXm11noJ/z6uQ9pfRGBeLOsdCwrq2N+MiiYLxZ+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYlqDeC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYlqDeC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B71F00A3E;
	Wed, 22 Jul 2026 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729323;
	bh=AxqiOXqk1Eh2FjbfREaxp/UEoDb4f7b4Mc6xIdI1Ew4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYlqDeC4g3SjcP7Ag/b4sBQCxNSoX/LCfq0YYpJ8Bc98zT7bUJ5eF9XVT4F+5iHWF
	 8Ti9xHwiN3iSzsj4JmX06PGjRMgkOTxxRYkc8e8zr9lQfPFPtKm2mlawykPKDcDU8d
	 lbzrfBfZjFHHzoPrJ4pfM3yoCMfTJJVT9LpWrnrHuWWtlXh/OHh3fA1SAlSU44NuUN
	 wqIcqXytqEMHKRCPS8Qzczln9lwLmiRS/WOAbq0bKnkTqgL2GFzi3pOk640ohPQ61P
	 5P/2jFVpEiJIRX2Ww8Ifu9MTMCdC0urdyG0JTBLn562bW3XsSijd67z3LDFRB+qcuz
	 /28bOsvzJzcfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 6/6] riscv, bpf: Remove BPF exceptions from
 denylist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Varun R Mallya" <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722140015.1982158-7-varunrmallya@gmail.com>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
 <20260722140015.1982158-7-varunrmallya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:08:43 +0000
Message-Id: <20260722140843.911B71F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Deleting `DENYLIST.riscv64` breaks the explicit testing instruction=
s provided in `README.rst`.
--

--- Patch [6]: [PATCH bpf-next v3 6/6] riscv, bpf: Remove BPF exceptions fr=
om denylist ---
commit e62702d45ea21775bb10258f8620e8e53e10eee4
Author: Varun R Mallya <varunrmallya@gmail.com>

riscv, bpf: Remove BPF exceptions from denylist

This patch removes BPF exceptions from the riscv64 denylist in BPF selftests
and deletes the file entirely since it is now empty.

> diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing=
/selftests/bpf/DENYLIST.riscv64
> deleted file mode 100644
> index ca1beae7fe8f1..0000000000000
> --- a/tools/testing/selftests/bpf/DENYLIST.riscv64
> +++ /dev/null

[Severity: Low]
Will deleting this file break the manual testing instructions provided in
tools/testing/selftests/bpf/README.rst?

The documentation explicitly uses cat on this file to assemble the vmtest.sh
command:

tools/testing/selftests/bpf/README.rst:
    tools/testing/selftests/bpf/vmtest.sh \
    -l <path of local rootfs image> -- \
    ./test_progs -d \
        "$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
            | cut -d'#' -f1 \
            ...

Since running this example command will now result in a shell error due to =
the
missing file, should tools/testing/selftests/bpf/README.rst be updated in t=
his
commit to remove or adjust the reference?

> @@ -1,2 +0,0 @@
> -# riscv64 deny list for BPF CI and local vmtest
> -exceptions					# JIT does not support exceptions

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722140015.1982=
158-1-varunrmallya@gmail.com?part=3D6
