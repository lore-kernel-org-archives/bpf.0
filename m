Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E46FCC
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560827; cv=none; b=iArdYOU3DA+/+nbKMZeU1K60HNV9bUCWyxm9vKEfbrHv26ul+ZOtIZeLIuKDrnBhIYdBWu5I4AO0rqpEVztAOcMbN8uh3QJSIVLC3lo5dAeI7QSwdxzpagTUkhFBSENxnlN1fZLpOZ+PMLCY6UiU9obEflGQ6XmJFB177GbZjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560827; c=relaxed/simple;
	bh=a1FYTLGG8/HT6lFgKIJQ7G7I43CbEQ2QQpVV2sX9UsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AIXPgYHwgiOuPt0F2Wot4mlUUWXW8VKKdzio/eIwznD6HUiAVDSdxF6optKzxtZUmr476eeBiJkWqEdeV6AS1zUYxwmAhtea9Odxxo5HfKhdpKgX94nQgmY/2Zf6rsMjF/8GTVvblPHcV5dGXfrd63yAkMjAmktd4z5S8bVhHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptoubnan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptoubnan"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 259AFC32782;
	Mon, 13 May 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715560827;
	bh=a1FYTLGG8/HT6lFgKIJQ7G7I43CbEQ2QQpVV2sX9UsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PtoubnanpOVr6QRK1kT57GZ9FgvSEkl7MItAEKKkWNvuQVNhhfs1TKkTPLOkrV/Eo
	 8S/7X0F2GfYnI1iDPM1TK3kVUHOt4d9LUnrLxkMotl4e3BDdEPQTCq44vIQDe4TgMq
	 Mz6kGPyP8XRqoe7nbMnJ/FaMhQqHs1wn1eTEuybXs7WgQgoC31fm//hl4EZnxGvsmZ
	 hC4zaxlg2oNCSASxJvjWfjpUqAre0VSTjA39Hp+q9U8+WszcdLbWamPdXm76k9uLs7
	 sE725HEGAwEhz4aUDMf2eG76vmLvyJY9Q92DSDJMsDxU1SFcsl4PNieBhTEtMMTu8f
	 rfwuiAx+nqjtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F057C43339;
	Mon, 13 May 2024 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: disable strict aliasing in test_global_func9.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171556082705.5774.11082507027749009065.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:40:27 +0000
References: <20240511212213.23418-1-jose.marchesi@oracle.com>
In-Reply-To: <20240511212213.23418-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 yonghong.song@linux.dev, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 May 2024 23:22:13 +0200 you wrote:
> The BPF selftest test_global_func9.c performs type punning and breaks
> srict-aliasing rules.
> 
> In particular, given:
> 
>   int global_func9(struct __sk_buff *skb)
>   {
> 	int result = 0;
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: disable strict aliasing in test_global_func9.c
    https://git.kernel.org/bpf/bpf-next/c/73868988c90d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


