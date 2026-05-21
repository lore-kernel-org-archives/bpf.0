Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FB30EF90
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376692; cv=none; b=vDNKfwdGrkyiTbYqtPC10+4bBf1AJ0oJHzE1yYnZHpnd3L5MxseHfDdRJ6qYHXyUPHOxyyZaHiM+bDyVCnhtRiaVdsNp9GY2lL3Yzy+fpYMfYJOHACev3UEXv7dn5F0z3kYq9wazAm/vG9msQ2fzhRBiRufnwiq7bprBCGl36Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376692; c=relaxed/simple;
	bh=yiYCD9rRHekIWEyqOSqLpymSd9ZOyD0sQ+4aeWH6msg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bR5EyUfy38v+WpJfuQw6z78tBeB+MRVCtAd9gCCXPAgM1MVQUdAbF8dP5r4R60/cM6duqbOUKxoJ7FLPXHerkyH7YXBaTM0cfYEtdQwMMnL6HPI0L4phqHjrnEDWjqPnsTVqbvN5kL/oeZJATjEZIvEsU/wTG6/NwqkglEc/eV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxBVk7N3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxBVk7N3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FD61F000E9;
	Thu, 21 May 2026 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376691;
	bh=yiYCD9rRHekIWEyqOSqLpymSd9ZOyD0sQ+4aeWH6msg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxBVk7N32zt4bFAkkUB+IwTQ1kebvGfO9AqHYz5mGTEVMTWx6pIim0AKEiNCjiRgT
	 UkSBG5F5niDClUpYuPgrUbH+tSXmORmReGtZKuX9DzhnIavDaqptxhtnI7VVRJChx6
	 1g5hCbpYvXpggrSw4JY6/T9ts2PQHrFnQNvXzYh6yZ6N46W+XrdMxbB3XPBnkpA+Mk
	 P2VIQbyxTkbVPnyMCEpx4O3xHMTRBxCtE899QwKN2aGFpVCu5caWOG7ohpXuTm4vhB
	 UL44FOg4VTp1Q9/eC55kXKNTy+sc6fXn6pKuxzSD/BOSZgrNm2j675qcru9SDyfEix
	 G0WndtJFazPZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 05/20] unwind_user/sframe: Add support for reading
 .sframe contents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-6-jremus@linux.ibm.com>
References: <20260521142546.3908498-6-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:18:09 +0000
Message-Id: <20260521151811.23FD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Mixing unsafe_copy_from_user() and unsafe_get_user() inside a user=
_access_begin() block breaks user access state (PAN) on architectures like =
ARM64.
- [Low] Mixing goto-based cleanup with scoped_guard() in sframe_add_section=
() violates the kernel's cleanup subsystem rules.
--

Note: The standard inline-quoting format has been altered to a free-form
summary due to text recitation restrictions. Code snippets from the
original patch are omitted.

commit b0f7b5132f15107b2df84ba67a33ced97fd3372a
Author: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: unwind_user/sframe: Add support for reading .sframe contents

This commit adds an sframe_find() interface to support unwinding user
space stacks using sframe information. It implements performant user space
access using user_read_access_begin() and unsafe accessors.

Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.=
1737511963.git.jpoimboe@kernel.org/
Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linu=
x.ibm.com/

[Severity: High]
In sframe_find(), scoped_user_read_access_size() opens a user access block.
Inside this block, __find_fde() uses unsafe_copy_from_user(), followed by
__find_fre() using unsafe_get_user() via UNSAFE_GET_USER_INC().

Does mixing these accessors risk breaking the user access state (PAN) on
architectures like ARM64?

On platforms that do not explicitly override unsafe_copy_from_user(), it
falls back to calling raw_copy_from_user(). With CONFIG_ARM64_SW_TTBR0_PAN
enabled, raw_copy_from_user() explicitly enables and then disables TTBR0,
re-enabling PAN during the copy. When it returns, user access is prematurely
disabled for the rest of the block.

Could the subsequent unsafe_get_user() in __find_fre() then trigger a fatal
page fault and kernel panic because TTBR0 is unmapped?

[Severity: Low]
In sframe_add_section(), scoped_guard(mmap_read_lock, mm) is used for
scope-based locking, but later the function uses goto err_free; to clean up
the allocated sec object on error paths.

This isn't a bug, but does this violate the cleanup subsystem guidelines?

The documentation for the cleanup subsystem states that functions should
convert all resources that need a goto cleanup to scope-based cleanup, or
convert none of them, specifically recommending against mixing goto-based
error handling and guard declarations in the same routine.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D5
