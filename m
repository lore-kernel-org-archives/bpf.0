Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C932B118
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716596; cv=none; b=lB1En+A1j7Wd0qto0y851wyV1CTUY7G8tiALRMj6nH7tIDesfgODF6W1ynPazbf034u8+Zvfmpg5d6Ey+vQ4Z8aZl5vZbD/retUSSFo9Tk7yLRkmReLVugO682vsGnpaJ7M9uWFR0JJRMXlSJTYzyqHPRivl4X91AjvAQTQGymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716596; c=relaxed/simple;
	bh=C+P7Y65iFOpf2u5w1ui1qcWGUcD6e4zwMOQ5NfPbT28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kR/R45fCmGrKg8aJWtE1H/9LdFK+mM+uOCO6lComtPuRIE3ngclK3I2+Jo7tpdmllr5+fshMI9De5hn1G4IOTG9uTFvcBmOF0FS/j9Yc6S6X8TtEJXK8135IMV0dY+V8WgHKUClfva9fcSsZf+dQb3CslloQInrboCyy1eTwRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdPNuOdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdPNuOdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9522B1F00A3A;
	Wed, 17 Jun 2026 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716592;
	bh=afjoJKd/w8SYES5RyYBhJqjjNPyAs/sQmPmgEezqjs4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DdPNuOdCUGELXMpB6kj5vyhfGVXcAkoLtg9G1PtyiY7Du892txsqAp9UbeeKpJ2d+
	 yzkL4Ruo+dXNZtaMMz2XP9BHjdmNaAXbhMjKE6exQ0fLyo5uGl7xS9WXkz/i/R788D
	 orW+4bZIBthgy4rYkDqAkGs0n46Qm19G+twb/2TYbukkdLGXbXMYiW3MIKnE+94GqC
	 iHYGsuQADgEceomFTmBvg5gNBEXnDnNwP+BazzuY0RYVB+/L93Fr1P1H6f6jQw5yGO
	 m/eTjt6QlmSewYVeyhW+PAx/vv5FygMTqVot+rLYBr0kEMgmelnZ8/pSoUHxRa2MCK
	 6SZZCsnB4daWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6A3930F8E;
	Wed, 17 Jun 2026 17:16:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF changes for 7.2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178171658638.1670911.8293025186538848313.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jun 2026 17:16:26 +0000
References: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org

Hello:

This pull request was applied to bpf/bpf-next.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 15 Jun 2026 11:08:57 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:
> 
>   Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF changes for 7.2
    https://git.kernel.org/bpf/bpf-next/c/9c87e61e3c57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


