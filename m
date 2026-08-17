Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1B3F9A05;
	Mon, 17 Aug 2026 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999856; cv=none; b=DjmKxxB/gmnyQngKMVnM0UNwBnK3dKnGqb4utVN6JwgFeNxUmTndTUe6bzBCZpis7Sir7EglL9zsqOKvrgGJOHM8E9CSSEMXh1t5RdMC+GziU71V7fLF3joNiZfrrDSrE/AMclJIIAmOHAr53Ggf7F0+JOQYdBujpX3j4D4JUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999856; c=relaxed/simple;
	bh=uQWYlvNtprcrUs2NonSBN07WkAMweaEP5BxWLT1sM6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qiBO9uEpmfU0q/OE8xemFnZQ0JAUn5zGJguVMZsL8ee4dXu3K9dJm/sXxuJGA9efhuDB+EHvfwW58jMW94FnQpE4rWlNNH9PcDEtlVfEQTu2wJeuUfwCB2IYFLAvSbPD2o2i/OhCLZKBNO7enP7+EGm2Ar85gZ41JoL6lCh7wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdOfHk/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdOfHk/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2CA1F000E9;
	Mon, 17 Aug 2026 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999854;
	bh=kC5S8J61dBF/7D+JWeTc2KgDl3sGaOaiUwA5xWr8AWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KdOfHk/sgBn52m4RRI0dYIkxgAvN7kQT/OHP+buX57xoNBTMbJlN3MVYKu9nalmYe
	 l4UkQsses+siIlUXHNavhYpXd4kBquLCW3WUlQkTA9gskdyjnVu/dxzoIzYuTnlJ6u
	 8qwt9tGdI1Oy7Eq+uRrFA4aBYmDUmUBM6QszfiVeKpsPOKFKHAebDdX6mVuoqWC5/h
	 Cji49s1vtsPCvmu6TLoqNjVIXOUP70vVqF2ZI1Bl75drnjAfVgLtqzhUesGi7hbEgs
	 o5aixseXw+6TgZ/lyOlwJCFyXXGw9uerOZIvVQyJ5rNXOBuAu14UMMlKfGaFwl49De
	 0rkKdivBxZ/Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D13926265;
	Mon, 17 Aug 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: kcm: Hold RCU read lock while running BPF parser
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699980640.1732278.16910244433930801525.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:50:06 +0000
References: <20260813035136.106167-1-zirajs7@gmail.com>
In-Reply-To: <20260813035136.106167-1-zirajs7@gmail.com>
To: Junseo Lim <zirajs7@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, rhkrqnwk98@gmail.com, tom@herbertland.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 12:51:36 +0900 you wrote:
> kcm_parse_func_strparser() calls bpf_prog_run_pin_on_cpu() which
> prevents CPU migration, but does not establish an RCU read-side
> critical section. Consequently, BPF map operations can trigger
> WARN_ON_ONCE(!bpf_rcu_lock_held()) when called from the KCM strparser
> program.
> 
> Hold the RCU read lock while running the program.
> 
> [...]

Here is the summary with links:
  - [net] net: kcm: Hold RCU read lock while running BPF parser
    https://git.kernel.org/netdev/net/c/b0346dd64e49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


