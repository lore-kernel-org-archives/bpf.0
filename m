Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79C3F4DFC;
	Fri, 26 Jun 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480640; cv=none; b=Xu5orsc8xJY6pKE/NVJ3WNq1NYxf+W3wJIlKcrexqn3oAjA7s0UE0U2/MIYv8acMXkL4xKhEOKoL/JLEoso6qlIpNKc4jrW1yj0lPUI9cvC1UokyZv9dgAimYWHbkuJg2CTaOlDhCbeT09d5gSqxFpcd7z3DyAcsgQRQPcmHDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480640; c=relaxed/simple;
	bh=EUxHTp2uexX3BlTMGfUqIxasHUqcfSYXguegSouhoF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GIAat42P9YpHzr6Zb9304SvJpm7PH1eF5spntN7FjfWsGb5hogLLVauWjIfzpkDCwlgca4B8Ov4Ie7jcZB0obXZeRJtZUIZtliFB2lbD3+ja9UXoxxgWBTRhnNzUEVPx1hj2jGxf8se5X7Uz0dkxmXqdmYvRjY98gDcBlRd5GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdMit/Ey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdMit/Ey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFED1F000E9;
	Fri, 26 Jun 2026 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480639;
	bh=ZGQut91I0eyuwdOlMkbQ+Aix1zzIRn5OQIH4JbqR9Po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EdMit/Ey3m7RQtd2f6iu42w5eMWSxDhsf0vmeR448tY4ztHT6RDZoSXxg+LjGljr4
	 48EAD/NY2GUr0BVtj/Li1s84EpOgVVqdtKAAiQkC7Tc8XQYWLIr5Jkfe8+WXYOlErw
	 YVL/bx46I6hjq/M2LjwQKubmCTpDdfioerRSIysCw7PSmQJb1VvBcUcD5+nSTQXmXv
	 zd87COzMLAiujYo2p68P2LrX1oCPfpe8yqJ3T4sj4Kug5ATPS4P93Z3UN7e9CmlRSS
	 oXo+lkgTeLHC3uEPA0D43VyUO3HsR+UPUezHvOiHcrlKaESvJTCF6vVVVrYGr69nE1
	 aIJ2xsZ7Mm2wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399C39389FC;
	Fri, 26 Jun 2026 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178248062629.457674.10289796084912546858.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 13:30:26 +0000
References: <20260618182035.43811-1-jordan@jrife.io>
In-Reply-To: <20260618182035.43811-1-jordan@jrife.io>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, jiayuan.chen@linux.dev, paul.chaignon@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 11:20:31 -0700 you wrote:
> We have several use cases where a pod injects traffic into the datapath
> of another so that the traffic appears to have originated from that
> pod. One such use case is a synthetic flow generator which injects
> synthetic traffic into a pod's datapath to enable dynamic probing and
> debugging. Another is a transparent proxy where connections originating
> from one pod are redirected towards another which proxies that
> connection. The new connection is bound to the IP of the original pod
> using IP_TRANSPARENT and its traffic is injected into that pod's
> datapath and handled as if it had originated there. This can be used for
> mTLS, etc.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Support BPF_F_EGRESS with bpf_redirect_peer
    https://git.kernel.org/bpf/bpf-next/c/509ca545d425
  - [v2,bpf-next,2/2] selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_EGRESS
    https://git.kernel.org/bpf/bpf-next/c/006b9456e9f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


