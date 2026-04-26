Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA1283C9D
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777237769; cv=none; b=I7LNlkhcncwjKg8Qm9qHkb3+nCMbFpCb/pmWjpnydP8nfm9XOjoGE/Z+Q1I0KaAD/AyRbc/RmMr8MOtDrgdalnd+SBns01EP8r8VZogyiM4fWfrP9LcqfWJDD5/VA2iyef+nIU9S365Goi9pY8ypQOxPfu/RHsm3QyU4N+GFsMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777237769; c=relaxed/simple;
	bh=xbMiYFiLcx2AD8hz5/+4F1ckjRCQGRgzJxroMTCCgVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E4odsI+IEh4tt32aMqOjYZB397XTGzFCCsH9QNuJz1WUO6Uxt221u65dc43dMxsCf6rt8nxOcTXcQ6rB2gfeZ8ZAXESG1DyWY8875J1D2QNsIlCak2w+M0foiUhehLREFTH3FZoGSpNbeCXTZ2gBP1T9Gw/rimdgmJWz0tYNmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpu27Dna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpu27Dna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8A1C2BCAF;
	Sun, 26 Apr 2026 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777237769;
	bh=xbMiYFiLcx2AD8hz5/+4F1ckjRCQGRgzJxroMTCCgVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fpu27Dna4DTtg1GC1MqAoO6cc+yCbGLBF32vnQqkjhk/Q0tpCU+bgvAXFRzwLHguZ
	 zOhaqdw7F/m9gtjQglPaxWwRFsqw468i7reY1djwO+qhW1rdCGQd4Ml8AHNH5WaDHM
	 IITNCwqQYUrduq9BwJB8qAbxo163GFJ7zRQsj2um3HFTB0SHuaoaSsU1WbvxWn7FbR
	 yU5l21A09Y+ii13z8zUDEeETXUChIaJsBaFOLvTuLFB2Maz5ii+LSVDvCX7LTsXiAT
	 UT68I8Z6eTktso26eW5fu+lbcnpBv/lmc4HPkR+bQk+zv/FGhQzdsBvMcttCq3rQ7j
	 3aTvL4S4c+avA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 7/8] selftests/bpf: Add selftests for
 libarena buddy allocator
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260426190338.4615-8-emil@etsalapatis.com>
References: <20260426190338.4615-8-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 21:09:28 +0000
Message-Id: <20260426210929.2C8A1C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Commit message claims to add Makefile logic that is actually mis=
sing from the patch (added in a previous patch).
--

commit 1b0628e5609c4e162f40fb718876176d30532a33
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add selftests for libarena buddy allocator

This commit introduces selftests for the libarena buddy allocator, including
both ASAN and non-ASAN variants. It integrates these tests into both the
standalone libarena test runner and the broader test_progs suite.

> ASAN for libarena requires LLVM 22. Add logic in the top-level
> selftests Makefile to only compile the ASAN variant if the
> compiler supports it, otherwise skip the test.

This isn't a bug, but the commit message mentions adding logic in the Makef=
ile
to conditionally compile the ASAN variant. However, the diff for this patch
only contains additions for C source files and does not include any Makefile
modifications.

Was this Makefile logic perhaps already included in an earlier patch in the
series? If so, should the commit message be updated to accurately reflect
only the changes introduced by this specific patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426190338.4615=
-1-emil@etsalapatis.com?part=3D7
