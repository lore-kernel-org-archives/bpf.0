Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6412DC791;
	Fri, 16 Oct 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114212; cv=none; b=C+ZPNkn7PDaacm29hZtD8qxxFFTg4SuyGVPi+4BbK7tm+O+x1AJr75hwCKoxYqnpxatup2gZcHcY1qTJvJB2AUitVYCnWCh6mAt9YlnUOGNiq3yO01TnZe4CeCsGgUhEEr2Myjm++Z+JS5MAdqJ22dA99VmzBWIIOMwkD6ZJI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114212; c=relaxed/simple;
	bh=FMRpqHY1JkdCInE0AyMV4ZIwU7oEQvNFojiCX5fa820=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VOt05cRnDtZb41Iz8JUQ6OA2WPIYbj5mOP0RJ5I6zYuIWdDN6zMjKwoP+VCoJ8l1vyXs3kg45SK34ApcHhkXGxSStdpB0hfCyhCJkxT/7X3LrmiRL/toryC7RlbINW3Pbzp4Kh/cGkH3YraI0xBJJTJiaJXmuUi0kdzgiTb3jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/Fokwrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/Fokwrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F801F000C4;
	Fri, 16 Oct 2026 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114211;
	bh=a4vmDGMEqXxNymS5nsWlu7+LR8nHxK3Uxy8Tp7bvucY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P/Fokwrk0D9CP27dJNbtQDaRNpXr/+TYePGiJENY7+1TY46XrgPD/FGYMRMZfsZ4K
	 nFwyBNxYRTQuUZzrzOwQJqODzwp73RPOjrgtZhvWx85yc5f/Wtg+kAwTrky7rQu/JX
	 XNyElluRqw5yc+8J8Gcah0b2M+Bk3dyaVtaGSI4EqBTet/rYTK0ppUbsv02eNnj+Ft
	 j+WusJI5vEj4V29yQY6mxuniuTabibGK354tioVZSf8wxmouVDZdB18ZAz1j4eXdvr
	 mwuN42l2j5oiupHebuYAXIKt1qbG2t7mR4LNJEUXBoadMej0smH2uKBQL6L/b05kO2
	 luy8014JGrT8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A7023808209;
	Fri, 16 Oct 2026 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: veth: test own ndo-xmit after
 peer
 GRO toggle while down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211420976.3903.15268146983159753897.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:30:09 +0000
References: <20261010192914.83651-1-tianyi@cloudflare.com>
In-Reply-To: <20261010192914.83651-1-tianyi@cloudflare.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, toke@toke.dk, lorenzo@kernel.org, hawk@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 20:29:14 +0100 you wrote:
> Test that a veth device advertises ndo-xmit when GRO is enabled on its
> peer while both are down and only the device is brought up.
> 
> Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
> device") made veth_open() set the flag in this case, and selftests were
> requested in its review [1].
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: veth: test own ndo-xmit after peer GRO toggle while down
    https://git.kernel.org/netdev/net-next/c/109b08f37639

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


