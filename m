Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255C3FE34D
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369466; cv=none; b=R8HaurLFrCkCKGN/WdDFCiOzBG9qLNm38XwsVX7EI2cM0Ze9tMC4mthGZyyrikSMfiXBtElLMCzUA7/MY2W1A8/SRfDxWMOkI7aMrKA1WB6hxAruIVK8vg//zSi3kpEnv7pbmyA6duOkBrae/3x/OalyskW/GRfIYpHbDIMsqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369466; c=relaxed/simple;
	bh=uPPWUa26kw1Db77bEu1RWtgYEKqQoJrjY6uhWvp66/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NTSqxub7eqk1X/fQZQGv6CLmHwantscszdTTxLZzMS/cAY+kE/K5hQJsvDqJNFJjIt1c3TC4aAmVbKKtjNy/RktdC1Bexgbqqgnju2OVQ5DFgL7U0Y0BAjD75Trtg/yrj0dUohMTF3IxFMenpHVpk2Z23VGc2yantvYbbSoAGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLfGl++P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLfGl++P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E3C19424;
	Tue, 24 Mar 2026 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774369466;
	bh=uPPWUa26kw1Db77bEu1RWtgYEKqQoJrjY6uhWvp66/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLfGl++PVU8kljFnDjnEOk4X3WYB0jFHktoVlcklZ6rzyeXaCDltggoMyAhNeWRVT
	 fmFG72bF9iqXdQ0TAZksY3HLdO6eR9cjRZKWRz1ZC2zA+cdfYKsUIDIVLdmFytgo/R
	 Ck4v8mpgWtQJjjey7yzuIGkVYT3eHQuYI+0WUAC3piS1A0fbIw5TAwNpjXeWBLB3I2
	 hIGaeHt4BdXDCvXunijzspTc4nl+xMDbOlDpRTCOjKqWXriK9QkY6MAjXsD29x3etH
	 zTRMWnjzSyLDDKKkM8PFVbdoW6qrCz3UdKPbGLCGSst+KExgbRUdn7+ONLjY7gQcE8
	 EjQ+zepY/Ce1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ECE3808203;
	Tue, 24 Mar 2026 16:24:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: Update MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436945353.1152246.7792679291734074029.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 16:24:13 +0000
References: <20260324152230.2916217-1-memxor@gmail.com>
In-Reply-To: <20260324152230.2916217-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Mar 2026 08:22:30 -0700 you wrote:
> Per discussion with Alexei, add Eduard and myself as maintainers under
> BPF [GENERAL]. While at it, drop R entries for reviewers who have been
> inactive.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  MAINTAINERS | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: Update MAINTAINERS
    https://git.kernel.org/bpf/bpf-next/c/02bcf8ef264d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


