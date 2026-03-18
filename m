Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54233D668F;
	Wed, 18 Mar 2026 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837409; cv=none; b=BBdqzBkKNLZp+j0XPmjDCZybgcxmkbiwcOIGVhexi3msfm9XaoFeXIwd00EwpSKfSgmqHN1SWkWvejsEeaq9s+J9XEy3p82HR/q2oyV+QqnJrpCHzwuaMh3EyHFfa7y71lmio42S12AwhZC81l1U/Ye5P1imMkmGYkkkMNvFqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837409; c=relaxed/simple;
	bh=6p/bOGQV3bVHyXfICaZQhpqLiEn2oYsSwhkVuDUqroM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTTvVfTEgEHFBVNz5EcjWcFE2+Wl1KjvZh0x67rVkkuj/Bd8UhGtI4Nroe/KCupdF6cTOurzVUNEoQQOPG4PVRoxR2zpR5OCJDGJR/XN/7lXOJ09KVxQI4rGKHrWC/zxYfULEsFrdKz3sqSWoJO/uK8NWpTtFbTIC6YFdQAMSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewIUmGS+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewIUmGS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC132C19424;
	Wed, 18 Mar 2026 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773837409;
	bh=6p/bOGQV3bVHyXfICaZQhpqLiEn2oYsSwhkVuDUqroM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ewIUmGS+pputSFk8ZS5eqUP5mw1jH6LQOOe73Lb0VYTc3IuRy2I6weEpQECJzdLfW
	 lb/LeevNBgCwYGRgfdp7xxvE2o5nLF694tg+9vhdmftjK/IkEv9miQBNMYgkLzyhS/
	 nxnK+71GB/uKf+6amDGJzTH+o7fbRU55PfFXwq/l+sRrrd3Km+3PHAK/97SSWvQHh4
	 DhRKjFxk+syNMsakNOIOafzIVZpZRuUSGpHDjkY7yJ9l046NLZBv8ghHFGSkLVaqhe
	 o+4QaUC/2hYyK9SpRrcb3PNI5h9oio5NfOfa0xYil87G9ewq5EUacRz70hCLezu0fz
	 S8avVhgX/+Ceg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, paul.chaignon@gmail.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH] selftests/bpf: add a 32-bit bounds deduction case
In-Reply-To: <20260318113200.303824-1-sun.jian.kdev@gmail.com>
References: <20260318113200.303824-1-sun.jian.kdev@gmail.com>
Date: Wed, 18 Mar 2026 12:36:30 +0000
Message-ID: <m2fr5xnwkx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sun Jian <sun.jian.kdev@gmail.com> writes:

> verifier_bounds.c already has 64-bit cross-sign-boundary bounds
> deduction coverage.
>
> Recent 32-bit signed/unsigned intersection tests extended the refinement
> coverage, but a corresponding negative case is still missing.
>
> Add a 32-bit selftest for that case and assert that the program is
> rejected, confirming that verifier remains conservative there.

The "recent 32-bit signed/unsigned intersection tests" are Eduard's
signed_unsigned_intersection32_case1/case2 (commit f81fdfd16771), which
cover the two refinement branches added to deduce_bounds_32_from_32() in
commit fbc7aef517d8.

Your test claims to be a "negative case" for the two-overlap scenario
where the verifier can't refine bounds. But tracing through the code,
that's not what happens. After the two w0 conditionals you have
u32=[0x80, 0xffffff80] and s32=[-128, 127]. In
deduce_bounds_32_from_32():

- (u32)s32_min_value <= (u32)s32_max_value (0xffffff80 <= 0x7f) is false,
so we enter the else branch

- u32_max < (u32)s32_min (0xffffff80 < 0xffffff80) is false, skip

- (u32)s32_max < u32_min (0x7f < 0x80) is true - the single-overlap else
if fires, successfully narrowing the register to the constant 0xffffff80

So this isn't a "two overlaps / no refinement" case at all. The verifier
resolves the value completely. This is the same else if branch that
signed_unsigned_intersection32_case1 already exercises (with u32=[3,
U32_MAX], s32=[S32_MIN, 1], where (u32)1 < 3 fires the same path).

No new coverage is added.
