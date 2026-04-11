Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E51A275
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775927432; cv=none; b=YYZypG+b1kBXBnJrRl4hiF8pSCIvg14vkgZjIGfvBn6+WJxLeIZhu0YZ581kAvozUNMpYy66cn/rcGhPyHWkcWhSPRZJazz0Lk6EDRYTSRSQsVeRvLXq3wsiSvXK6xZzgILLsTuSXFMVS5+9d4Hor6YawU887TK8fDp/UwVlLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775927432; c=relaxed/simple;
	bh=YvM2vGDtcLBvOErD2bi2cljJ7w+E6nMClzLqyexwn2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CMaMOuzKUFHTuLUuwstLmWoRyqFjhU13AqnnQ8xPaZC8s3oh6LjY6ILehLonxBbaXvVXlgZnHG0Fw12C1XU7+L0CpEyroBR622SQvZ6h1X+HBRJ2/gxUusngRIW1ZH/BioLPZf9BAfisf5LYIGFPDTadIa6JaoYB2NFwkAdOjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0KaCYho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0KaCYho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEC1C4CEF7;
	Sat, 11 Apr 2026 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775927432;
	bh=YvM2vGDtcLBvOErD2bi2cljJ7w+E6nMClzLqyexwn2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o0KaCYho8buWrHxoiUWGWdstYzCs6mG459IMZ8IQlTCGyaSsM+ELu4hFTdjH7KueS
	 Gy3Tshj1V8gz3yHZiqhY/tDKaG1dxU5pfAUctiEAhN/0nwlAyU+47MG6Z+M6xDXjic
	 dq/maj48EJspqNEepxbB7wiYGkn5Ms+E8tgex3MDiQzsYPluwaZg6gx4a+AXBuNFfH
	 0TqTO69yZN3X/b3Q5fY9DlaxHIv0gQGbAnr29oDxtjWkxU4/oQjgUgVnEvODcJhCax
	 YyACv9bIZsQdf9JweAg+HI9WVdf3ahZR2cwJiAfyOpfKnqoAEGKUcXQK44BvP5+qlm
	 le+Ak+bL7/Ipg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B8E3809A8B;
	Sat, 11 Apr 2026 17:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Delete unused variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177592740580.3026957.412768943399871463.git-patchwork-notify@kernel.org>
Date: Sat, 11 Apr 2026 17:10:05 +0000
References: <20260411141447.45932-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260411141447.45932-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 Apr 2026 07:14:47 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> 'cnt' is set, but not used. Delete it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604111401.eqzyF2kx-lkp@intel.com/
> Fixes: 2c167d91775b ("bpf: change logging scheme for live stack analysis")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Delete unused variable
    https://git.kernel.org/bpf/bpf-next/c/57205e2dd962

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


