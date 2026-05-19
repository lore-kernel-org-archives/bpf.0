Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC130AACB
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156598; cv=none; b=OBYBZ4+Fgz/vnffFz+jGkGZkl/qsD7lp3gulGq5WGKj4l3o+QrYcTDtjb4N3eszPjWZb9W+vOIPTKSQ/ycVUDHvT5T50qr+o4NAZAljcgYk5pxUTWebGNeFVcYJLCINouJIqapGfIGFRsQNRCjVgHBkWtQwYPYi5xp8S57d//Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156598; c=relaxed/simple;
	bh=7nL23O44mVGpZ9rGt7p+I5QV+neQbqbvwrlWyYvoNXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KkNKmjJP0GRZ/DwxuQltYvIFoG4b51+O4RW1DMkY8E7SfIaIIjMW09VV0DuMqU+mkyWmm/5C9Pb8l8CFjampDNReWrJpqHtlttMLeEZScpeHUjf0L1VAfg7JmTxZYxmMFtTF75Zwmc1iJyH8RHhOJYFHMMUbA//grueiq1QI2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYH6L6Gv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYH6L6Gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A1C2BCB7;
	Tue, 19 May 2026 02:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156598;
	bh=7nL23O44mVGpZ9rGt7p+I5QV+neQbqbvwrlWyYvoNXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYH6L6GvHhQI8UT/0N8Fn86J9TYM3LfrRA66+4w+dmDWx0djOKyuoKSGYrHv2J/dD
	 u14j+TwA5hse82d7vpYJRAGdwVWBoKMG1JsJd9Qtrsy4nMn87mwTh+5NkklWrHBmke
	 08BaIu0EOfZquMJPJlVqFCBZvW/rzjEp21OBzwkyU1WoPVF+2ykSo/3OUrIhKWh4Vb
	 3RDGamMn8X0zOMskXEU21yF6TEhjf3nYcbEgrle7ZT9p2tFVt4T4oiTYdrR63BaIIE
	 ZTpLhFOISBvBmS9rPKWPVKxTKri1UqtDZF7KQklHiHZUoxANoixF2NdWEzQf28K0Nn
	 ZBRFzjuBUI9Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A993930D10;
	Tue, 19 May 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test for refinement of
 single-value tnum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177915660913.2054007.2673876026046526600.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 02:10:09 +0000
References: 
 <be2dc2c3d85120286e60b3029b3338fff339f942.1779121582.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <be2dc2c3d85120286e60b3029b3338fff339f942.1779121582.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 May 2026 18:26:35 +0200 you wrote:
> This patch fixes the "bounds refinement with single-value tnum on umin"
> verifier selftest. This selftest was introduced in commit e6ad477d1bf8
> ("selftests/bpf: Test refinement of single-value tnum") to cover the
> logic from __update_reg64_bounds(), introduced in commit efc11a667878
> ("bpf: Improve bounds when tnum has a single possible value"). However,
> the test still passes if that last commit is reverted.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix test for refinement of single-value tnum
    https://git.kernel.org/bpf/bpf-next/c/523d2f42b406

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


