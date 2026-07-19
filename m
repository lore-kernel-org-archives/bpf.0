Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EF2222AA
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784495332; cv=none; b=VREjhIn8oze3zvrpY8eHAUZRCuOepySqoBpKhO7BQoD5MeG2pk9sSiwcO22EIiEEJtnt1PBw79AF/xcooMJC+3VpHmrAcKVS3ieTd7GER0FNRj7Pf2tcsBb0QWlIYgJtXStvDOf5eBXxYmtvZa/NS+4SoaNmughBuyBQBtaqteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784495332; c=relaxed/simple;
	bh=7Ib2a3L6uiH6HL78MLwMPzVjXouXlBG3nx5WIyWxwEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRcMA4awqMfUq6TdK4SCcQZFuErNAVH6ML1cXwK5yizMPCgFSSHq5Y7dI9PL+7qwFq/AqOFDQ+PiSfeiGEukyaHyWBzprd0u+NxuxPb7aBk5sahl6gq79OILXy78i/NWKyEXXw+mZqOD88JKa0auG4GbrmLRoKzN5IGV4AH8tOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXz9y8eU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXz9y8eU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853861F000E9;
	Sun, 19 Jul 2026 21:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784495331;
	bh=/sPEKQ2/0mNNxJMBHIQhxQOOy5HF0wlZficolM8fdNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YXz9y8eU2WYaxKwTx8Y8cnUki0tllXK7bUrpMaUIxDOuAeN/C0qnG5dI3SbBXhFc7
	 mJGnq6Vh1uYBUkUQqBmKgntK6pwa60+6UPF5dCDdvOR88WYcqz96Xnyh1Dx5tRaCqI
	 6FAZ61ik7/GvpFHvk8nc5BilfnFmq+KqGS4YhYlW7/B+TuVHc5W7PsN9A1hKE5iALw
	 D+aTIz8mFEaTwF5MpgUzmTJxEDDnJBlhmUOygiEozD+vOIFYPSF6K1sb5qoJSXt6Gy
	 WqsFuYTiZ+vAkyITZoae9oDaTWUgpQDjaiTmbpF7XlV3K3yNZnLrY9zPgYlJNO0MJR
	 TkfSEjeZ+4ing==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396838119CA;
	Sun, 19 Jul 2026 21:08:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF fixes for 7.2-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178449530241.2815364.13274266152413126619.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jul 2026 21:08:22 +0000
References: <20260717191356.3513879-1-memxor@gmail.com>
In-Reply-To: <20260717191356.3513879-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 17 Jul 2026 21:13:56 +0200 you wrote:
> Hi Linus,
> 
> The following changes since commit 2c7c88a412aa6d09cd04b414211b4ef8553b5309:
> 
>   Merge tag 'net-7.2-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-09 08:26:51 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.2-rc4
    https://git.kernel.org/bpf/bpf/c/94515f3a7d42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


