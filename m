Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9E3D6472
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548654; cv=none; b=nAuanDD9o1g/R443u64JiX/RIp6aEeOwsNhnNjvPoXsm26JssqCUM4Pid7PP1KS2DjjgaC+H4WWvmuScpcb+wO7+xV+02g7cKurPihr+llsIY7kdKafBA7o5b1FZIHQDK0zTssLoypQ3djxqPvpgo5AUzgaUtCtV0wfhTxSW0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548654; c=relaxed/simple;
	bh=//O2O2AlV2mBZZ6Kiw3VfPz0/94rtXGWtQpYNQn4BlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g0CioETiK1NZxCiLsE5brqOKR1yx/zFmZtaf3gm4W28HPb0dEV7EW6B055//q6T+7kogAPVidCzqbRtVg2zLm5NB8QYlnfnN0Q3Ldg2G0SVY+e5X19OdtZNv3a8yute2t3YVmAL/RYBcYa9hEI0M8iMqKuonvk6X1oXBty7dBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/jCd6DZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/jCd6DZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DBBC2BCB3;
	Thu, 30 Apr 2026 11:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777548653;
	bh=//O2O2AlV2mBZZ6Kiw3VfPz0/94rtXGWtQpYNQn4BlA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M/jCd6DZatO9wcQzsAnY8oleH0P/XFsAyBYrOBraOT4oie132K6lGgW3R47VjEZS1
	 SQxEOSam6b4dFYQpeP9Jwgws7lahE/pedfoWR1OedNpaubKQUzw7fClV9M1HWpFDxZ
	 MnOmxjgtqMevR6wkO9GnYF9T9MLhEYgfH1fL6it/F0bUm7NJngNjvPY95q8lhyl9UM
	 snODlPa6vu7VeWw42NF31pR30rJRxZoTyFHzfiqCGYyvLtuUBjjAKRCXC9Lpjm+09m
	 dniRtX5nhDevwzB/vAoOITqD0ROdqmKm/nKx2X62CLQzB/SSADp39v4XGP8Iv81SJW
	 lbou4H4h9iRIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA023380A97E;
	Thu, 30 Apr 2026 11:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Print breakdown of insns processed
 by
 subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177754860856.2535146.15547738525971886964.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 11:30:08 +0000
References: 
 <5590f9c67e614ec9054d0c7e74e87cc690a52c56.1777538384.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <5590f9c67e614ec9054d0c7e74e87cc690a52c56.1777538384.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 30 Apr 2026 10:44:28 +0200 you wrote:
> When using global functions (i.e. subprogs), the verifier performs
> function-by-function verification. In that case, the sum of the
> instructions processed in each global function and in the main program
> counts towards the 1 million instructions limit. Only that sum is
> reported in the verifier logs.
> 
> While starting to use global functions in Cilium (finally!), we found it
> can be useful to have the breakdown per global function, to understand
> exactly where the budget is currently spent. This patch implements this
> breakdown, under BPF_LOG_STATS, as done for the stack depths.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Print breakdown of insns processed by subprogs
    https://git.kernel.org/bpf/bpf-next/c/f603e84ab791
  - [bpf-next,v3,2/2] selftests/bpf: Test insns processed breakdown
    https://git.kernel.org/bpf/bpf-next/c/2ca6723a5f7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


