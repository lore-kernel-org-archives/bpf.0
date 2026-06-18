Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CBA3CE083
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776061; cv=none; b=rEiIQrsnMwiUCwesCqzauQpAlyKu2ZeGCsj4wZ2WQfRrsiyP8i6xOSoMDWVfjXxC00G/DhIooMwx9rAv7C7rBuSvP+CRX8we9mcuVHEq15E2NtmZyrkOzZinShuuBXTFmP8GhqE878+ZOwLZu0Ir1vL3UV06UNgpYeJTubh7t0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776061; c=relaxed/simple;
	bh=sCyLvXVP61cKnnziZgNs+uoAro7sq85PimTj3bWwCas=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TyE7UQ5wlCOjJwCe50s3v04RgfETbQXonNdWBZ9h9h4URpk5OSImyaRUWy1YrBh+9mWka7tnThWG9XQB8aD/cCsjzQ/EegavhU8P9jtXm3QxgyN+rzSLrliPe927yWRBo5CGBxdR4p8ZX4mcXXKhir/cfa+o3pZRzKQEcbh/TP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKQGX4QX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKQGX4QX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7151F000E9;
	Thu, 18 Jun 2026 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776059;
	bh=1JzaCrcJn4cC9qQrzcneB5basyTqJY2PDp1CpXiZLf8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OKQGX4QX15lt14aX+fbddUeeWkjmibkmbAjRK7ennkBJ54Ud6rTzE2VG1QkvBF0Od
	 fBEAjwmcKECtSYVMVShW79tAW6UZT3TsqlRhUg3r1NP2ISGuRMPVq4vBcpqBxtrCTZ
	 kbGTrxbeyGLWVH/9bUEZe+jBKjyGdqsRBQIJWBKtM9NLCDZWCCEtkUca/3wdmme7fd
	 4HW+90DoyGkPhal3z0tZNkwJIcHbAemTUZTkwMwdb/ASGR3KrD8SZUkkQaicvvoSga
	 6+6dN1xtVkIdPDO3q3LlPPbmwLEbys8BBuR4Xcbi4P24SFFjis8ALaulxgtNcGYYyw
	 1Gg47WQ3/XYpg==
Content-Type: multipart/mixed; boundary="===============2890034755507948027=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <52707834463b9ad1861552674b98bcb2f92d6601295548454770d883c8c43536@mail.kernel.org>
In-Reply-To: <20260618085626.19633-4-emil@etsalapatis.com>
References: <20260618085626.19633-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: libarena: Clean up allocation state before buddy tests
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Jun 2026 09:47:38 +0000 (UTC)

--===============2890034755507948027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Summary: The buddy allocator requires the global BPF buddy allocator
> to not be already initialized. However, the test currently merely resets
> the allocator before the buddy tests instead of destroying it, and the
> test worked because the buddy test happened to run first. Properly
> destroy the allocator instead of resetting it.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

This looks like a bug fix for the buddy test harness, where the
run_libarena_test()/run_libarena_asan_test() path only reset the
allocator rather than destroying it.  Should this include a Fixes: tag?

  Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy allocator")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27749630149
--===============2890034755507948027==--
