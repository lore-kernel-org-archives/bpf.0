Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29B19BC8;
	Tue,  6 Oct 2026 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245423; cv=none; b=sQ+QUCkqreF2zROvnFGcRzH4nyGmyHp4Dfie/ejTt339wel8n+4xGa/4eM93cE6XkxNK38G+5xxgayj4wclv8cXlAXSUGe02bohFFE/p58kXqVMPWJuYZE0PRmaJE7e+Ep83Rxm0Pn+6gipGvFMOaL1/KYHP0e8vzzMOPZGINiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245423; c=relaxed/simple;
	bh=6IjSzqSePVbJ+JdMaCXuUoMWedxE4ZhtrPZTJDGDIsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QH946HY88KQhcfkf4MyCD8XLbAhYAkRt+sJ3b+6XlFLr7mYyCcWzO3V3hw/GdYB+hUDOBMjA8oR0LAzbb2vwWUqqtnG5035irv47e6IPi7K+ET5DME40wH2TC0qozp+9I9Y7IsQcSBHsXqaXTDpK1zP/pP39U6NmZiyUi04CDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFk3qNTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFk3qNTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F58D1F000FF;
	Tue,  6 Oct 2026 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245421;
	bh=oFptFADksPAkAOdMcibRU662GWZv2QltIDg01V3uyKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VFk3qNTuzlbbyrY8hthZoNeu4FYqQCUXt6O6n0lNOGt72M+juQ/ZMUHu/N246+YH6
	 BHYvCSSE0dqHnJWtXsuow8tg4fC8vZ9cnUa3oL250R9nkxSz28KdD6J32A6+vYvWU6
	 bi+Jh5nAB+Kdm7Ti7/S99odZJpRkI5Zr69Ns0w+7w2yFNJ8qPFIteeWxwAlNz7Ufuj
	 IsLJWv2Jop9RIN+/pE+K6Pl6fzv7nMKVWYisQ6xKrONnw+3zIsmxjpFowmZ8Ex1Lrm
	 4Z+50Tcaru8kOU1v533bm+NT7M1ax5KlrnCjVyYiIKfzm4+nOZsPVDyFoxwKYdkE6y
	 H8d10xwZz0QKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772D8392667F;
	Tue,  6 Oct 2026 00:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] gve: various XDP fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124542028.1947351.5137581473727943896.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:10:20 +0000
References: <20260930214735.3288780-1-joshwash@google.com>
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, jordanrhee@google.com, nktgrg@google.com,
 thostet@google.com, jeroendb@google.com, pkaligineedi@google.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 14:47:32 -0700 you wrote:
> This patch series consists of a number of small XDP-related fixes.
> 
> These changes are split off from
> https://lore.kernel.org/netdev/20260922194533.631387-1-joshwash@google.com/
> in an effort to prevent blocking relatively simple fixes on more complex
> fixes that will need more feedback to merge.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] gve: fix XSK buffer leak when rings are stopped
    https://git.kernel.org/netdev/net/c/73670ddb91a4
  - [net,v3,2/3] gve: fix XSK buffer leak on error descriptor
    https://git.kernel.org/netdev/net/c/9fed6a8ab8a5
  - [net,v3,3/3] gve: fix napi_disable deadlock when attempting to disable XSK pools
    https://git.kernel.org/netdev/net/c/0cb6939a4dfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


