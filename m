Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084732D3EF2
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777072535; cv=none; b=GsOs+JMIb6X4OLCcRw+trcR41Op5vzJGoHblpOBxOnAFW90rGM9xOe7p5t9BNm0AwSOooP1lyg0K6U5lO8PKlwA32Q4CCL6cunizK65XfLpNJ2o7PoaO4w6EvAsC81epCOM6DZviscKFPlwW5RxfXfbmYOD8ZmFwOWneihXO00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777072535; c=relaxed/simple;
	bh=yce3UbCJ7MPLxQ0yqhK4GCkeV7nHiQqh/m0w93e3+RU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eoDd6PuQGUKrW4SxQxIVBfjfA4dmmnRhe657jtQKZrOebmNC8dZ5j/bug9FE2Y6ilMgNSKyrB9kJx4NsF+Ra4or5pf7l6j9sTJSD6jQD6d5k4rWdpvq8F0sxerQn8tU2Qzv/5E0cKZfae2oHztLCJJBIEerNaVklLM2c1Yw7tgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEGSltvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEGSltvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84394C19425;
	Fri, 24 Apr 2026 23:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777072534;
	bh=yce3UbCJ7MPLxQ0yqhK4GCkeV7nHiQqh/m0w93e3+RU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cEGSltvYsbKjFmSQ5d0Xpo0DXTP/M0pXHqBBH7ORpcqMoF3FWh2gHXjK5xM6maygf
	 880KQ+e6bwUdSpTFg7/rG6e27KZbh85OESqOKN+4sMg3E4oVqVPvSPTn3F38Gg2PHl
	 r+y41SEosAAGp4aBZ6B6tt/cgrSBI2c7MxnL8092k72hC4N7tsqx2NxuiT2KbdvZ5u
	 1cT98qh0Uyrf6M3oboDXTu5ewds16NEEgebSXL3Ft5UeFFHr0YCUUURlk0Ij2Bl06W
	 6km9o0nHXuIwqRerL5XonXQoSCV3Su3sCqDMCkakJPIiBnMi4MBSj3tCHKdP/4e6mV
	 e/h0yLJKF/KGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/4] bpf: representation and basic
 operations on circular numbers
Reply-To: sashiko@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v3-1-ca434b39a486@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v3-1-ca434b39a486@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 23:15:33 +0000
Message-Id: <20260424231534.84394C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The `FN(normalize)` function incorrectly skips normalizing full cir=
cular ranges if their base evaluates to `ST_MAX`.
--

commit addd9a35120cb1e8b327011ef0f97fa736918a87
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: representation and basic operations on circular numbers

This commit adds basic definitions for cnum32/cnum64, providing a unified
numeric range representation for signed and unsigned domains. The operations
correctness is verified using a cbmc model checker.

Link: https://lore.kernel.org/all/ZTZxoDJJbX9mrQ9w@u94a/
Link: https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
Link: https://github.com/eddyz87/cnum-verif/tree/master

> diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> new file mode 100644
> index 00000000000000..3ebd8f723dbb53
> --- /dev/null
> +++ b/kernel/bpf/cnum_defs.h

[ ... ]

> +static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
> +{
> +	if (cnum.size =3D=3D UT_MAX && cnum.base !=3D 0 && cnum.base !=3D (ut)S=
T_MAX)

Should this condition be checking ST_MAX? It appears that this skips
normalizing full circular ranges if their base evaluates to ST_MAX. This
can leave the range denormalized as { ST_MAX, UT_MAX } instead of
canonicalizing it to { 0, UT_MAX } (for example, when adding a constant
ST_MAX to an UNBOUNDED range).

Leaving the range denormalized breaks canonical representation guarantees
and causes fast-path equality checks to fail, leading to unnecessary
fallbacks to slower subset checks.

If the intent was to check UT_MAX to protect the EMPTY representation
({ UT_MAX, UT_MAX }), operations like add(UNBOUNDED, -1) legitimately
produce { UT_MAX, UT_MAX } representing a full circle, which must be
normalized to UNBOUNDED.

Would it make sense to remove the exception entirely so that all full
ranges are normalized safely?

> +		cnum.base =3D 0;
> +	return cnum;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424-cnums-ever=
ywhere-rfc-v1-v3-0-ca434b39a486@gmail.com?part=3D1
