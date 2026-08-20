Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FC2222D0;
	Thu, 20 Aug 2026 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254295; cv=none; b=V8rv0W8tmLuSIHTGHP4kGy0fSUUff0ytADKaAngghalmvttMNABBfWczKvo40CUtE//4Lw1a2AeVBPkdErBGvMwR0ie/EL3zafTrB2OmJMX+NJG5+AD+nrFLIogWEDktFAVZA/G0yJr3nGyLGYZ7gA/L0oksPRQvlpIoOw+3hI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254295; c=relaxed/simple;
	bh=QXCxpZ3idEpPO8G3upmGVaPk4vDWN0F4x+d9pK6tyGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CCWK8+723leZMLN6kXXeiSuy5ZxoYKDU/3HM0V5XXHY7XpS37W/ZjZMD22wLUSOQN1R9VVCq4DwhMk1Nf6ZPbAXz8cOIrhZIPr39gMoZ7ltVLibcP+APXmqFRSGIeu++mGEWklGEUcCSd2/07hMQS7l6Zgucr3ZB+xszcBvHumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBefLUPp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBefLUPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE28D1F00A3D;
	Thu, 20 Aug 2026 19:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254290;
	bh=iq6yrhgTmRQirEq8urxJl/4A8AnVrLFRgrm4gfWoWh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iBefLUPpPJDVPLTI7jDp0GHH40JZwmEdp64mAJt4cLLzMoDXY8WNHe8oRo7FJ3s8M
	 09UgpJ88sGZp8RcC/mP5h64YBuV2iFGCZdi2oEtNgce0wsWqE4H9EgnPSyizZs+Vcd
	 KTNDdEg62V6dagO57oWNnUpT69iEwSseN05v4bbIR4JcZmnojx5Kjw2y2pD0yUn+F/
	 6RLyVKBZ8leJOLVencBT0g9AkwNIFCwZFOG+CpCnLqD7P+8IjPOYwufab736bEFFkJ
	 5lHzgKwYgOLIdc2aCW+rTv4wmR7xcXkdcIORgFKuLMRoANcSxN9Elw5Hq5RTT3cZVH
	 GESsKt+u5I1kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C03924459;
	Thu, 20 Aug 2026 19:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: add get_fill_size callbacks for actions
 missing them
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725424113.446762.7196863721726971573.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:41 +0000
References: <20260816201327.2435335-1-victor@mojatatu.com>
In-Reply-To: <20260816201327.2435335-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Aug 2026 17:13:27 -0300 you wrote:
> Several tc actions - act_police, act_bpf, act_pedit, act_ife, act_sample,
> act_ct, act_ctinfo and act_tunnel_key among them - provide no
> get_fill_size() callback, so tcf_action_fill_size() falls back to
> tcf_action_shared_attrs_size() which does not account for the
> action-specific netlink attributes emitted inside TCA_ACT_OPTIONS by
> their dump functions.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: add get_fill_size callbacks for actions missing them
    https://git.kernel.org/netdev/net/c/8e2efb3f45a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


