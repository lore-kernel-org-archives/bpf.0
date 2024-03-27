Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B36130AC8
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548030; cv=none; b=DGawXm1VWHQPaiHfN8sn//ndiz7BzXzxRnA94agb3b1U0JZzymq472spLSXAwes/eH3fAiIsjrWdA0chmA0Mb99hhh9O4MRJLcU0qDG9Hw7ghFf4rUDhvzboxUMPULg0Du/sXk3/Tro26OehBSMd+yKbyAB5iatoOTDaA27oxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548030; c=relaxed/simple;
	bh=ZWRwW5a/atUY75Ot5EmWWJL5+SmwS0RdF9EFAzrkh/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pCRKc7ZTSepNgLKejLE5raUyK4of/vnvX3z2pGcpgeE68T0PMQ9e9eKm7rWblmOrpDaxjOV6e5ASbLbbSngrdd0uIT5+II3wFJO8btvdlgXX2r0DsgSr2CeDgyXwQTCuEHrDncQf3gw+xvB9GlIhqw74oJsDJBFx5M03flqnAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReEFqrog; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReEFqrog"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EFA8C433C7;
	Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711548029;
	bh=ZWRwW5a/atUY75Ot5EmWWJL5+SmwS0RdF9EFAzrkh/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ReEFqrogeCi+nRbx42nxkjrSkR3GIqBQ6PZ6p2tUuKR9PTorPRZZutM0AROiDLTkF
	 2s/dHtCXduY6xTzRPGnE2eGGEHU3iqsf5mbWq+5lm/ECl78jWGez4+euoaXONpegN2
	 Y5q+GvKsZOTtSokf/mgdk4IZSAEK4V9ebdx05kez1Fh7ikPLmN7fQrqbLzNW7D1MGp
	 43gypArhfrHuQKX164JMDZZ3ON8XJNfXJiyGavzXlhXw7Db4ROgDhG2ARBAN5exPL1
	 weYVQBMzbFDpSFMDOn9Cr+6mgdsorM1wqMOJck8EkDxQ7XMd7TDNE6VINSJWZ3a+3G
	 Rs+TcgrS6WfrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 821ABD95061;
	Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while
 not supported
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171154802952.9827.25009069225289323.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 14:00:29 +0000
References: <20240312012053.1178140-1-pulehui@huaweicloud.com>
In-Reply-To: <20240312012053.1178140-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 atishp@atishpatra.org, conor@kernel.org, anup@brainfault.org,
 palmer@dabbelt.com, bjorn@kernel.org, pulehui@huawei.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Mar 2024 01:20:53 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> RISC-V perf driver does not yet support branch sampling. Although the
> specification is in the works [0], it is best to disable such events
> until support is available, otherwise we will get unexpected results.
> Due to this reason, two riscv bpf testcases get_branch_snapshot and
> perf_branches/perf_branches_hw fail.
> 
> [...]

Here is the summary with links:
  - [v2] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported
    https://git.kernel.org/riscv/c/ea6873118493

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


