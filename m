Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7F288AD;
	Fri, 10 Apr 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850037; cv=none; b=Ys/6jgN05JeEU3r6W3lbHUOtEGQvhtI609t9Hp+jHgKYNnI1DTDNECULxJi/QbtrVSoa5B56qzgmaq/smvyGS6rtJfjROR5TQrWy0zpXh6wMimhcpgvrGvaRgBK5aJnZvcCqKqIbxwrqHNhUCX1Eam1AGCKb+iu59zPgwv4AFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850037; c=relaxed/simple;
	bh=7YW/3Y/8guj4qzku/GCgaUJcbwVWxzLHT+OTtEuOUGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cp9EbdX/hZQrnwZRiOEQQl+mzNarLvSeWmf3bZC7jHTSEUNdV3dNT1//mhWgY1tRwbec/LgOof9EyeoT7ZfsR4PrqsK89KquHhzCNh2Kosb+usKGdniQs/YCPPVO+Pgcc0aRP3MXPwk0zGhsmanJXngG87XVfQyVu4sUvQKZcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO18maer; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO18maer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E20C19421;
	Fri, 10 Apr 2026 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775850036;
	bh=7YW/3Y/8guj4qzku/GCgaUJcbwVWxzLHT+OTtEuOUGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UO18maerFX74v9sW/aWVCA5v0gC9t3qqkGxwWo/h39xYDGY7IQh6XGaNtZyQyd4Dx
	 VQ3LOzaeV+31Flw8vDMzx55YX+W9I3foyUzLcRcRt3mwW4ulGRXRDbBAy8IHcfweZM
	 NhsNp/0+2oD+/i73nCF0cJ1EkpyiXxDL8xzNSzfz3NVn+3hs2pQP66LJsnaP7OhGFO
	 Ie2HNmRUUlfSCtnvjQfdAXksLrZ2YeHMRvTrrlEtwhVtze2GmVLfI1CjAy4nm3XYg5
	 iERWazpdl1m1YvUH1r/SYIRXqGaPvPEapt9qdEPycRrYnTRLiPUFgePjD3ufpxkM36
	 WHdVq6Hr55VsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA53809A88;
	Fri, 10 Apr 2026 19:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf/selftests: remove test_access_variable_array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177585001113.2617676.9954602800837392587.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 19:40:11 +0000
References: <20260410105404.91126-1-venkat88@linux.ibm.com>
In-Reply-To: <20260410105404.91126-1-venkat88@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: bpf@vger.kernel.org, skb99@linux.ibm.com, hbathini@linux.ibm.com,
 adubey@linux.ibm.com, ast@kernel.org, alexei.starovoitov@gmail.com,
 peterz@infradead.org, andrii@kernel.org, maddy@linux.ibm.com,
 linux-kernel@vger.kernel.org, riteshh@linux.ibm.com, alan.maguire@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 10 Apr 2026 16:24:04 +0530 you wrote:
> test_access_variable_array relied on accessing struct sched_domain::span
> to validate variable-length array handling via BTF. Recent scheduler
> refactoring removed or hid this field, causing the test
> to fail to build.
> 
> Given that this test depends on internal scheduler structures that are
> subject to refactoring, and equivalent variable-length array coverage
> already exists via bpf_testmod-based tests, remove
> test_access_variable_array entirely.
> 
> [...]

Here is the summary with links:
  - bpf/selftests: remove test_access_variable_array
    https://git.kernel.org/bpf/bpf-next/c/aacee214d576

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


