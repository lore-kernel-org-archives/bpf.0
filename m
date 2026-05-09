Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CA2EC57C;
	Sat,  9 May 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778368859; cv=none; b=XyoiVrKR08kVB70r8tZNiHUO1E/whPW9jsFh0oDzf0601PS9OfoPXzocdYlY2wvv0aQNKcT0pz/GwmBPXHEzm98pduYrHekmXlppxv3WnodFwTtiG2MqOB6fV6BT/vRGFEALPw5DpG+R7qB2G7H2oZqfP5P8d3G5orfLStxK2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778368859; c=relaxed/simple;
	bh=nfKeovBbfRTcfLaExtvN2cMkkog5MgHyOOaIBcOtZBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LZjWQnyjiFrfEBk4X3c+A0SaKYEpxM3im3hpfIZYyHFTGaKpYrsVelNAjRmbPAjNkXtIvSXfrhrveXreKs4ad0PXOF4XXBhey8eVZFjm1D5aeT/pWjA51RIf8rBuWWU4Y3g0678xXGUdoTglHGaUyiea9wKY+URJoJQMF0/yRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERnWJXff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERnWJXff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DCCC2BCB2;
	Sat,  9 May 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778368859;
	bh=nfKeovBbfRTcfLaExtvN2cMkkog5MgHyOOaIBcOtZBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ERnWJXffJ+hR1rQ/YTcvgtf9fPK+1FGpzyIeiYxtWYJnwshXj+rw293/yaSwhiBSS
	 +pri6W7e5qrw4V7SSA+dUHeubGBIi2e2aZZbfloI94w2I316yCKxICoAIJlicbjPd8
	 RojO1fuBO/zUXQxhmm1wsHLZGFlqhzw9ka5kVpLr7VAwkmN04urmz95sUiQlno4nZt
	 1qZKZHHX78DpvL05xbl1xPxuJDaOAcnLaCgkq5Jfp6xqaGDJwJnMzeIm3LQzNuNJ1b
	 w/A17+TMc2R8Ybd3g6mb69RdzvFn5uOeZdHWGQW/lpPa6YaOw72V8mfO3hdvRRV2t/
	 C7k1mcUDVhxRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF663811A7B;
	Sat,  9 May 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] xskmap: reject TX-only AF_XDP sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177836880730.1203938.10346076460528713605.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 23:20:07 +0000
References: <20260508144344.694-1-linpu5433@gmail.com>
In-Reply-To: <20260508144344.694-1-linpu5433@gmail.com>
To: Linpu Yu <linpu5433@gmail.com>
Cc: kerneljasonxing@gmail.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org,
 linux-kernel@vger.kernel.org, tanyuan98@outlook.com, yifanwucs@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 May 2026 22:43:43 +0800 you wrote:
> XSKMAP entries are used as redirect targets for incoming XDP frames.
> A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
> traffic, but xsk_map_update_elem() currently allows such sockets to
> be inserted into the map.
> 
> Redirecting packets to such a socket on the veth generic-XDP path
> causes a kernel crash in xsk_generic_rcv().
> 
> [...]

Here is the summary with links:
  - [bpf,v4] xskmap: reject TX-only AF_XDP sockets
    https://git.kernel.org/bpf/bpf/c/bf6d507f7e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


