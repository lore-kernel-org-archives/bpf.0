Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753C35F162
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205985; cv=none; b=Hi1u7eNd7qJaitWsMGok5Egl8w769MFWva9jO/saFsbVxPFAB2towrAJ5eJ8RccKxCaTFnJasPIjfKn01nikhlla+b9lxZ2Tb/gC6kMa3CTKqLcZZxXjfwNzp08qEsmO6+jf/BJNrxqmvE+PkVfnZo7qhUW48sRkpsJ/Hg1+OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205985; c=relaxed/simple;
	bh=hv6aBGaAfYZGtqtBfKeXPsbliq4KpOlXusphHtKrXz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eNqM+x4hKtqhi+Owk4xKYUaJ+Hpr10LG6AFXK2bLjtiFP8BX2a1s8RRjgqHYs4Fg2OHzhORqqgv5Ciu6hCVgnMgisqjRtdel+gKAKDLLxSeQVhoXO5j7LyWtrrA/kKlLZSDCNRG6Dg1J4FlEM8OgEDjCbP1zuRLidypjxyhmzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT4xWIwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT4xWIwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85D7C19424;
	Sun, 22 Mar 2026 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774205984;
	bh=hv6aBGaAfYZGtqtBfKeXPsbliq4KpOlXusphHtKrXz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sT4xWIwUgRC5W3CM9jWeINRchH2NKziRcnlGNMeki0E+qNWXN8LA/Z9P0MjxXFOLJ
	 NtyEJMTDWdzj9oAAmIoMFHKyn0TOmB7iZe+Z5U1EQhiuExZuCbqVzsqxyRsm908uHg
	 Cj8prSuLud+n1lUzG5zKzybV61fkMB2Z0bEeiM/dQ8IEKv4TzoKXUHr2/Kf/MljK6A
	 hpvw0qNV07AcsCZoxGZZU4nPCoOKyxg311Hta+Zxz5zY95U7U22OBQOsddbw+ZXKRq
	 +mfe28O7UqW6ghQ/8dE4JR/7zSy7U7RveHgP0Si1XB+9Iu0oEbjVHvA3gDor6U83Ul
	 aJKfp1KiX7BaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F0C3808200;
	Sun, 22 Mar 2026 18:59:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF fixes for 7.0-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177420597379.3170431.15998372373306005026.git-patchwork-notify@kernel.org>
Date: Sun, 22 Mar 2026 18:59:33 +0000
References: <20260322164633.4165-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260322164633.4165-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sun, 22 Mar 2026 09:46:33 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:
> 
>   Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.0-rc5
    https://git.kernel.org/bpf/bpf/c/d5273fd3ca0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


