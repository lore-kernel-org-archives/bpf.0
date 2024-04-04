Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A080131E2A
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262035; cv=none; b=DM4pUNOH0YXNA3PPYzr+wLaKh7PI8BNRe+vxSRmqZ9iYKsxGO1eCZrgE8iU/JN4EkrwkUYSI9JixB8+ya57chiB3wWo7r8Yz7xquuRjNDaUmx1+cN4Q9UdaDiyZxJ61Blv2/BGkhFf+aO+0bW7uyEhq4C9J9mqI9sBlWon3q4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262035; c=relaxed/simple;
	bh=eQpPswI1AM4r4Bv26gYVk3Xg2bL5SaYFvPOSpViC7cE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPTu/RdWBfhaSn8AngRnVBwqvr25SIY7hBSnmsFdVGwtUYKnjPjvcQ3eDNyiLEyzK34N+uPkVlZ6NyZjp7Oz/snpdvXrEqlNDYUiVtJRD9BOJXlpGSgWeRgnwwXrcZp3UllZOzXZ3zFK+cKrbASdVqwXJINiUv9Ipk4RPg8Gdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYV9PCTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYV9PCTW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC1FEC433C7;
	Thu,  4 Apr 2024 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712262035;
	bh=eQpPswI1AM4r4Bv26gYVk3Xg2bL5SaYFvPOSpViC7cE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IYV9PCTW4svVZJaNGa0Fn+K5RqIgZP1c75IyL9IJlaka2zXI5FPnTLBcN+UjXGJmW
	 tHpvV7k97csvqPIYrGJ3hwD8Ai3X7ZNIv/m9/v9MX1e1U4esgZU+CSWSKZE5GUBgLi
	 D4ApBx0m2PRVXDbRGtWu1HJHQg9enWhpbIe3VAZXj96P3rCWZ4G4IVnzRK5OW7PkwS
	 U8WS6gFUbwrBh6BZz0o8Pw0hF6uI/6E2Nay++q3SCTerOoyvuuYror84h48hkh3iIm
	 R9hoohGqgzWcP6AumS90sWZRtUtAoVFtUfNWYfbxXUKdkat8VaW+QsHFANvNzxnu49
	 Jxq+8Y92uevEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D36BFD84BAD;
	Thu,  4 Apr 2024 20:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/2] Inline bpf_get_branch_snapshot() BPF helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171226203486.5668.1036797984297732600.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 20:20:34 +0000
References: <20240404002640.1774210-1-andrii@kernel.org>
In-Reply-To: <20240404002640.1774210-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Apr 2024 17:26:38 -0700 you wrote:
> Implement inlining of bpf_get_branch_snapshot() BPF helper using generic BPF
> assembly approach. This allows to reduce LBR record usage right before LBR
> records are captured from inside BPF program.
> 
> See v1 cover letter ([0]) for some visual examples. I dropped them from v2
> because there are multiple independent changes landing and being reviewed, all
> of which remove different parts of LBR record waste, so presenting final state
> of LBR "waste" gets more complicated until all of the pieces land.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] bpf: make bpf_get_branch_snapshot() architecture-agnostic
    https://git.kernel.org/bpf/bpf-next/c/5e6a3c1ee693
  - [v3,bpf-next,2/2] bpf: inline bpf_get_branch_snapshot() helper
    https://git.kernel.org/bpf/bpf-next/c/314a53623cd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


