Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461273491F1;
	Tue, 17 Mar 2026 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715214; cv=none; b=cL5po51XrHrqNeVOoJRHTCnIIQDxZcYm/cQu+I8V68QaFc3qzcpkw2T674yBcIeghC4jlRTSaLZgiKjCYKymI8WpP1KSoAkmN8UYhvj18xkabkwmLUj3YuvlGNa9cIAAm2sMIh6Id8a6+EUaUEJ9MT4xlQFPf57bP/HtghXz0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715214; c=relaxed/simple;
	bh=mdDI6k+DTqtdZ8vWoHEZG9zGbBbobLIA59WZVP7ayaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BmLfdvhnLJVMl7QcLf9d5YP2IJIusMZ3/jHnbRPsQxOx2FJcoRYLPK+5Rx72Y8Iiiip5nbYdKaibWxarqBeH/aDcjLK39cZtJM7tB/a/H/DoZmAbQdqiG6vUG9Rn2u+TDZCkgnk+S9qsmEQxawRCshb9kRepH2g1afAPEXnsqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw2gb9WN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw2gb9WN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD7C2BC87;
	Tue, 17 Mar 2026 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715214;
	bh=mdDI6k+DTqtdZ8vWoHEZG9zGbBbobLIA59WZVP7ayaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iw2gb9WNDlHz8dcS09yg4ARJXypXAMlFlGt0ekgTd1jEzoRgXwXlVk9UxIqvz9zxA
	 mtzxsMEFuctnguj8WfthaxXmmOwDycusMNR1dW2fDyf34BAWJ5+vq+xwkZor1dX7VF
	 q75PukXfgnoEXyaFOVMXo8sj8TD4amDiMi4YfDxWLpzd0AgTwTSSiGMmUhrm40FY8O
	 K08X/JxEoQ/MDnI8I3mm4pVln2G8qwrEgX7qoRUeMaCjzWm3e9D8NQ51M+3j9/8aWl
	 +2EGf3az/YDmJUDfTnoapL/5EdVgCZC5h+qghi/c+27ZShv00gks6jVH6JFV/bwMSz
	 nvV45Q4nzY/2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030833808200;
	Tue, 17 Mar 2026 02:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] xsk: remove repeated defines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371520679.3399897.13209936627620788705.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:40:06 +0000
References: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 12:19:31 +0100 you wrote:
> Seems we have been carrying around repeated defines for unaligned mode
> logic. Remove redundant ones.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v2: remove another repeated define (Stan, Paolo)
> 
> [...]

Here is the summary with links:
  - [v2,net-next] xsk: remove repeated defines
    https://git.kernel.org/netdev/net-next/c/cc6421acd97f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


