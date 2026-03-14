Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CF1624DF
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454816; cv=none; b=Gj0ooyC4Jy1POrH/RJJUGVQR7o4C8nvvBxGxdZ9X5wj6h7hNkH4GcjQzIrr4h69myg5JVheAo9MbotoR0SSYs2ihaK5MqcreG5PJP4BaasjJb8k/TgyNUE/7ix9BovXjuRFe1SaP9ARlPI1YqN3BGLbY7klJYanJYrvm6ZJi75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454816; c=relaxed/simple;
	bh=G+QaJvz1AXsMnfh3JaUZ8qnQz+mQR2v9tVXrpdACJZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u++3MPHA0T81CpvM96DjNawrkeSCxsQHMge4ppe7m/FlSRcLn7JGwb7zhbjtlquuVN3KwJxTLVNR8tjlQ61Yja9cwIDEREKbT3m1S7Aa8tX6hBsH+5I2rWr/h74UJUPZoEC/lIgJwRCrJzvFcKKy8dorzFR3u76T8KSPnsZ04BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqStbC4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqStbC4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A11C19421;
	Sat, 14 Mar 2026 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773454815;
	bh=G+QaJvz1AXsMnfh3JaUZ8qnQz+mQR2v9tVXrpdACJZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cqStbC4KOncSBjlO0kSuE8JOVLAZHALkoOCFz6mTQ2SXwtMjsz7eb1/XFF+x3Z+Ze
	 GgnQlx6Tyy2RQlclv08GLyQeGRpaKgUoLw62K4aHZY9WIaXTwRICeMGcXuteCVblQq
	 YA9fM/DAITTYDoWDZD/ti+kLMt6DsRWVPEr5iN7Q4VWfH9Z1M7HG4RBDcz9v8vB/sS
	 U2poP7sLE/PCKJl3HF32cT34GA4ZwBT/bvgloMqEdTBUir4bJKOopvPsnCZl+Nfmdr
	 E/h+JmDh2PM++zZK5Zau36Hh9DXtekc7eo9sezDNkvYLZRLr7HEDN2NjujS6t1/xDf
	 zX6538YfkF1xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2AF3808200;
	Sat, 14 Mar 2026 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] Optimize bounds refinement by reordering
 deductions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177345481030.1571585.17753334081849342960.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 02:20:10 +0000
References: <cover.1773401138.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1773401138.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, shung-hsi.yu@suse.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Mar 2026 12:36:11 +0100 you wrote:
> This patchset optimizes the bounds refinement (reg_bounds_sync) by
> reordering deductions in __reg_deduce_bounds. This reordering allows us
> to improve precision slightly while losing one call to
> __reg_deduce_bounds.
> 
> The first patch from Eduard refactors the __reg_deduce_bounds
> subfunctions, the second patch implements the reordering, and the last
> one adds a selftest.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: better naming for __reg_deduce_bounds() parts
    https://git.kernel.org/bpf/bpf-next/c/879cace97667
  - [bpf-next,v3,2/3] bpf: Avoid one round of bounds deduction
    https://git.kernel.org/bpf/bpf-next/c/9e5fcb003aec
  - [bpf-next,v3,3/3] selftests/bpf: Test case for refinement improvement using 64b bounds
    https://git.kernel.org/bpf/bpf-next/c/0a753d8cd61e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


