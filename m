Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD423EA99
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899001; cv=none; b=NLRduZLKh9T8sa4sKw0vpnUMNhYjtUV+G59G4lld0JaTegfZsbcMI7CVNnr31pQVlX1ckj8zrypyOcfs9NBVyFwQHJZcCRXqDGq2uASZ11gfcN7cauNJAC+R+RIrhZlHWv3VnGtu8PDswzm9fS3Hdhg7TzVVc3wHwrq1U/Gg8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899001; c=relaxed/simple;
	bh=qjSeJuUblY/nLxny+q0JewN6WGbFSRVwa3HTTiJ5HTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IzBIcneEtr/+ka/7vu0CUmvw77+18mMYKWfH7eVWElT+/kaPp6+UnXYhtRSPnnN3F91wuqRjpYRL8Um5UPzhLDPs+0pUfaz7/bcVi5lAq+9l0kRrpMLVlL+Y4u4e53Wh/G34zav2Hy80do569KlpZZnWxqET+boo+a9yWMLHjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn9/H3t5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn9/H3t5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ACFC116C6;
	Tue, 24 Feb 2026 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771899000;
	bh=qjSeJuUblY/nLxny+q0JewN6WGbFSRVwa3HTTiJ5HTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hn9/H3t5DjOawIM6U7cKrhMuBUYUsp4rv5hQcrQAtDRzqFfmc2Q9Lk3hmR9I4+qOu
	 +ZlKhorlEoekd8oY62kONDGaK7Ivo0xP/VuAK6xH42A0KF5a6S7/O8eXwwMhyGolbJ
	 UOy9OFkByPwFXhCCEmGsmScnK3WBC/8r6KCcWKGMzZv+2IoIWtTMm8DknXAIIb8uSp
	 m2jvi7l4gY8jYTT1WSz5q7DKjsFGIOczYikRIdj7zETqvQQGRNC93xfNs7jc+xdr5H
	 RStifBbfkB/W1XgXRS7CzJ5dWVt8p64iorZHzR66Jf9KJyK/dHGnKpLN1UJ2he90Fy
	 z/dZEVgZ5Gvpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F9F3808200;
	Tue, 24 Feb 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftest/bpf: enable test for instruction array on arm64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189900655.3277452.13026471633191925203.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 02:10:06 +0000
References: <20260223203511.118475-1-adubey@linux.ibm.com>
In-Reply-To: <20260223203511.118475-1-adubey@linux.ibm.com>
To: adubey <adubey@linux.ibm.com>
Cc: bpf@vger.kernel.org, puranjay@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Feb 2026 15:35:11 -0500 you wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> As arm64 JIT now supports instruction array, make sure
> all relevant tests run on this architecture.
> 
> #21/1    bpf_insn_array/one2one:OK
> #21/2    bpf_insn_array/simple:OK
> #21/3    bpf_insn_array/deletions:OK
> #21/4    bpf_insn_array/deletions-with-functions:OK
> #21/5    bpf_insn_array/blindness:OK
> #21/6    bpf_insn_array/incorrect-index:OK
> #21/7    bpf_insn_array/load-unfrozen-map:OK
> #21/8    bpf_insn_array/no-map-reuse:OK
> #21/9    bpf_insn_array/bpf-side-ops:OK
> #21      bpf_insn_array:OK
> Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - selftest/bpf: enable test for instruction array on arm64
    https://git.kernel.org/bpf/bpf-next/c/99726ece0c8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


