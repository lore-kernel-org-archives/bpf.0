Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853135AC12
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084875; cv=none; b=ckunEoFQCPGGURVL6F/IVPdzgomCXyCL+JZ+t3uM82VLmi/Y+jeNvMIogD9EtGmkrLiM4Y8ugpFl8vohfOfVvxpuzpuu4qB1WvMZB87aD1eLN6nlUFNi0r3Z78lO4hDnf7FBXKuDgXOrqdr8BEwkhgAT+uEpsthyu3nuab/y/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084875; c=relaxed/simple;
	bh=ZYEJL4ltQlTmTqSfEK0QwQhCjqRgd/oG4Vxb9UMEJV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PoofapDi6yPXYqDnNbYuqNCJKm3thsqP75Osu9fQMNpcQBcj+5r0I8P7gQCSvjBKcCgfW4KdsITLOS3lvjL50Hzmjt+8If3R+GZt4kj2hLxwE0UemUZo/xehWWBkbMXm6KDmLcYVyZNLG9EPTErQZPKHdkU0zacM8w4t1T9ErZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdgmgSyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdgmgSyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259361F000FF;
	Fri, 11 Sep 2026 00:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084874;
	bh=04WuFt93ejg5vE7RXecgDe5iphRXWyQ/ZoIWhWeM1qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CdgmgSyw2vS+VEmkiAQc23riSh4hzHR39ip750x6T8i23iFTKOJjd7ddDks0lIQNg
	 I0rW20z0MZ8S9m1XqU8dw0TW+aPE+6NBReoQyhtD25AOu3Ty7IoTzMCvL6VzrpLqJI
	 AHghNApT/U+P2NZMxmIF44AiLlmewHe9i0TNX6v46JLABDOUpAQgk9I5sqilaIadF7
	 RL00cfHyNR8+jF2YNVl27v/QiMBx3nlJs6J4BgjHzyitKi2a1/t+r2Y8TVCgJRvEYX
	 q1kQQqlXqsCXCluqIdKCrOiyriErOZjA2XezpEflUKEU8WRfGB0BMN5FX3f4HKAHZT
	 CUtxTJjtiU9aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B633810901;
	Fri, 11 Sep 2026 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Clear scalar delta on narrowing stack spill
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908481113.2150752.7791376548198456287.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 00:00:11 +0000
References: <20260910185604.44949-1-daniel@iogearbox.net>
In-Reply-To: <20260910185604.44949-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: eddyz87@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Sep 2026 20:56:04 +0200 you wrote:
> check_stack_write_fixed_off() breaks the scalar link on a narrowing spill
> by zeroing the id of the destination stack slot, but leaves the delta in
> place. save_register_state() has just copied the source register verbatim,
> so the slot keeps the BPF_ADD_CONST delta of a register it is no longer
> linked to. This is the same shape as the case addressed in 1b327732c846
> ("bpf: Clear delta when clearing reg id for non-{add,sub} ops"). Unlike
> the latter, no miscomputation seems reachable, so mainly consistency.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Clear scalar delta on narrowing stack spill
    https://git.kernel.org/bpf/bpf/c/2936aed9b021

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


