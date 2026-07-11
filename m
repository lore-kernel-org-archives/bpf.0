Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0525B0B6;
	Sat, 11 Jul 2026 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783769632; cv=none; b=COI6xVztfWIogmWXVJ7Pfab0SjkfEeg8IAGhJiNeTYF1rkfXzFGn5fYkDbcV2JHTLkX7dymuUrs6Iy7UuLwBAf2KK9G8rgKg4THHgB9d97uUSKbkvXfJBECmE3Vc4AXo2r/SkewaEvKKP806yOzV6FfaaBXNq+g7bmrhUGhF0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783769632; c=relaxed/simple;
	bh=8LmPRFDPlAnIc1m/H2DRLrBOfEKUJh5ZpUUWKbCrYHc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YmWCl9EYOiyIXteZ8Kz+fUbrtGELJz9zl4TligSCA0+cy4da96YRzkGSOLlzQEDv8E0YvQL8oJz98RlmRVKtHBpoCfoxmsAdCPwMtSLm5YHVsjv4b79/MCh5sZVDVNZ4tFfBXvtzS+DyWJvqV507YY2pCm9D9Gpv1zcpgKyugxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNy5riVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNy5riVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E111F000E9;
	Sat, 11 Jul 2026 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783769631;
	bh=F9q0YlDvI/Js7FeGCONKApl9mEpT+pYemA5mpwvtMP8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MNy5riVjmET07iBxOlZkYKoIeF1/zoeszrV2/6UJP8ba5eXThtIfi+3GxTp9KV1lq
	 ZUCmminQFmWsSlsZE56KurFK9gY+Zv4tMnWG1p/Or5bDCavmd5YSkaGOk9sCgVZpNZ
	 r7536o1nI9WXYbLjqLg0c+Z6PFtoGZHhxcEFxjHez3dlgxKZdEvf1kL94/JkXv6mPD
	 dL7JJM0rQXPM4qEVwXTY1I6WxInkUja+Kfs82jiVIHIFjL4R5rqa385cczab65/c/s
	 OZUDz52POxXQ6uiUZH9XvfaHervcb68tZaC7vSg4KwxySctAh7oBTVcEkaxuZCyAvP
	 pYFiKzW3wxrjw==
Content-Type: multipart/mixed; boundary="===============5699139597305415616=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba107f614b57dcc666c3eaae4a14180187fdf5b0d47ee339a557dc43bea5b0e1@mail.kernel.org>
In-Reply-To: <20260711104727.4023420-2-pulehui@huaweicloud.com>
References: <20260711104727.4023420-2-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject callback subprogs invoke tailcall
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,bjorn@kernel.org,daniel@iogearbox.net
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,martin.lau@linux.dev,john.fastabend@gmail.com,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Jul 2026 11:33:51 +0000 (UTC)

--===============5699139597305415616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Reject callback subprogs invoke tailcall
>
>     Some JIT compilers, such as x86_64, rely on a register to pass the TCC.
>     When subprograms of synchronous callback invoke tailcall, C helpers
>     invoking bpf callback clobber this register, and the corrupted TCC may
>     bypass the TCC limit, leading to infinite tailcall.
>
>     Fix this by rejecting tailcall inside all subprogs of sync callback.
>     This also cleanly consolidates the existing async and exception callback
>     checks into a single unified `is_cb` check.
>
>     Signed-off-by: Pu Lehui <pulehui@huawei.com>

This looks like a bug fix, but there is no Fixes: tag.

The change broadens the tail_call_reachable guard in
check_max_stack_depth_subprog() from the exception-only test to the
unified is_cb test:

    if (subprog[tmp].is_cb)

The narrower "cannot tail call within exception cb" guard it replaces was
added by commit b9ae0c9dd0ac, which only covered exception callbacks and
left synchronous callbacks unprotected. Should this carry:

  Fixes: b9ae0c9dd0ac ("bpf: Add support for custom exception callbacks")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29150078207
--===============5699139597305415616==--
