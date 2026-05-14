Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6512BD5BF
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722865; cv=none; b=P0ciDGaTVa7jtvkVttozoPqlx3V5QBxHE6Jzh82JDihGgQjLwYy3XLOoSaTWybA41qItIcbC48Us2CMeKRsMieOplTrZWcK3oU5J9pwc6xeh6ipuyjbN/a41m5uvcScn37EGQ9mcX2FoyMrSvB0sJLIIkBhoecbKqRXtUFgmPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722865; c=relaxed/simple;
	bh=OdpGBrnEPFc68XQNqZZzOY4sgst32Y6Wd3GUoI5e7uc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/0di4L49aVAWXv5ej8vQzsCj4nkJzeIi+pJqZoOnQKkINGu3r7q7c9DxuLhqiFy9fFE39IBaqlnpgjOfE4OWBXbeVfOeDh4lpuBvSTOmMBeZJpOHEVTDzt8+oOq4aVcAm/fxLybF+D5GN7bF0hJzPhDbwOi76uVkjwexMwU6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJth3iIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJth3iIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7682C2BCB3;
	Thu, 14 May 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722864;
	bh=OdpGBrnEPFc68XQNqZZzOY4sgst32Y6Wd3GUoI5e7uc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dJth3iIwv5qUEUoFgJx965uBxpGescmieHw+hTj7LMi33DE5intQkeQBfjZLOmYjz
	 lu2Yc5FltIsr+9c8uDQ3awpYf5jlADM5VuTKZYXazQYmTk1euNzNaRDPEC9Qyw9uo9
	 B/wZ59E5wPJmgxDq/DHeHUKkpmXUFC37Ueupmns3qTq6bHwrurjtXZwt4BHyeWXs4G
	 1Xmf77x55b0+OR/cMb5CKnSseD9290nzPVqKGRF8pfQPoLmLtMEi5SxcoN7iAxdeKs
	 +3ALAj035hZmgvrJHPgHHTvVZmwnii5zj/Th4zEwbnLWafiedEeSnFvvetk0qeAIU/
	 ZM6fusMaYYipQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE50382330A;
	Thu, 14 May 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Maximum combined stack depth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872280980.3914219.4817879194920517908.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 01:40:09 +0000
References: <cover.1778700777.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1778700777.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 13 May 2026 21:33:41 +0200 you wrote:
> This patchset dumps the maximum combined stack depth in verifier logs
> and parses it in veristat.
> 
> Changes in v3:
>   - Increment spec_cnt field in veristat for new MAX_STACK id (AI bot).
> Changes in v2:
>   - Remove unnecessary max_stack_depth assignment (Eduard).
>   - Fix and test incorrect handling of private stacks.
>   - Add veristat metric (Eduard).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Report maximum combined stack depth
    https://git.kernel.org/bpf/bpf-next/c/f41f34ec6474
  - [bpf-next,v3,2/3] selftests/bpf: Test reported max stack depth
    https://git.kernel.org/bpf/bpf-next/c/2a5b22e87ba5
  - [bpf-next,v3,3/3] veristat: Report max stack depth
    https://git.kernel.org/bpf/bpf-next/c/f0015ffbf40c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


