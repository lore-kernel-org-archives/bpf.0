Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D6385D84
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717207; cv=none; b=jqg7J5qQGB9IrUq//zVaQeuadlaW6wpMqdxUUZq7wARScDu8zvMIW1kiOC00xtDuvVBusWcVTxJa0jpBRqFRCe5Xb1AWkfPK00UbWumg8yi8cuyeWeNaCl+j2+xmB0tWqHkd9rjSm45XgMdxMcWk4MVJOBrXaeLvCu6KS1WCfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717207; c=relaxed/simple;
	bh=b30NSvu+3tdRar9pNGUyvE3pR3Pi1Pvmc4E2+AtqQfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T+dloqR5k/Mt6de+SszBcv8tfcPXiXNVhUZOswqLmCCMQjKxFoemMmMrPIz7iTlAsbL9YMEaUd/amrmKR1W/yMRDMeOstUcBG9uj1v4ZgzT9zJW4WKoRkTMjJ6CPej67p6d8gfppr5j7mrQcYcfz1zAbAgWMaVWjAtedH6PN8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBhxu4Lp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBhxu4Lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CC91F000E9;
	Mon, 25 May 2026 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779717206;
	bh=snNx46YuPUWVrck8uhu1NrADo01E/aQdLiVeaH3443g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QBhxu4Lp79i2xq+Shb6ZoqQF46uWjd4GYFkGAc2nsHFFzXRMeF01NWOX4p0DtMqr1
	 /elwh83+7PI+x3s0hEiW+GBmTS2p437+83SKihFXy+psL7UytPOvOTOGcTTwEPc01l
	 VWspB/YgDI+lnrf2h6mOLna03//TQ6dF3WkosnQA/rtMnVpY1m+0jTicV7qn7NIJpK
	 KrmVqNOMTt4dsXOmHC0ZK0sb7lyI5iROwt5+sDa4yK5+KlK7ERXatN/WU432bb7jmq
	 a38r0et7Px8zzQ/kqP4VUJBmaFpV9G2tspseqrSmZPJEpANp4dF0+nf9btmI3QXclb
	 AUIph5u3PG2sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56DDE380AA60;
	Mon, 25 May 2026 13:53:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] BPF fixes for 7.1-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177971721289.2579362.14417978635479793726.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 13:53:32 +0000
References: <20260523145928.46476-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260523145928.46476-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sat, 23 May 2026 16:59:28 +0200 you wrote:
> Hi Linus,
> 
> The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:
> 
>   Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.1-rc5
    https://git.kernel.org/bpf/bpf/c/f0e77c598ebb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


