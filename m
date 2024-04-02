Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B785286
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066434; cv=none; b=u58BVCSCINE47Ee9sLL0CCuRm/vcU47jD4TNoKY/7uGmWr/Nb73FkPYMKyvxDEv0v478mP+LO06krdvsQf1vqsVbdmsNiVL+qKLnKtGKoe+A4DqGTUKGYSzXHzux82SYV8Nh9dItZ8RzRzK+Sx1chpgzhIbZR9fEvmY3q9fVy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066434; c=relaxed/simple;
	bh=b/kRgH4AOd6d12Loed08dq0ySRhB0ACldVR9DAogoJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cn6X/AygRQTLTKzOs+2+Sn8+DKgiwDdl4ohXBvN5cBG8Dw2SrlG+3pmCAtWYETAcroagAX1HXKHXRfexbpac0QSDnYIty0eMMNR/CWgwyEM36PCRfWgQ6P/3AB6nEVb7+oHu3aZ8oHrZ8InMU5vpmkdgm9yEAAHTR+ksUS+q7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbSdkgEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbSdkgEB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65C6CC43390;
	Tue,  2 Apr 2024 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712066433;
	bh=b/kRgH4AOd6d12Loed08dq0ySRhB0ACldVR9DAogoJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tbSdkgEBdqs2lcjci1w1mjITPcahqCIoKF10HeJwKis75dNZ82yYl39/hkMv4RaNs
	 YDsrVtidscfwoEnbIR42U0k4B2l8C2FSJ5s5VxzcA+k+y5U6BNqmSeUeEaaY9l8G13
	 Vnvi13qlaNB5TI4AzrB1q+I8Txs2/WGLNTNRy5ZUtKCnlMe5q3o8t4npvjlP/B2IIZ
	 ylP4ClkqaTMApxnL6v8TT/0X4MdsRJj3fmNls9K0a6A19n0ybpk/GV7HVjKxj1Zq8o
	 Zcy5mV/P3Wfh9lgl2ZFXSl2pMaD9L5Zyihe2TnAv/t5zf2bmwDip5SVu7ik40lqUN4
	 kEmSRraoJuStA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 431FDD9A155;
	Tue,  2 Apr 2024 14:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpftool: Clean up indentation and formatting in
 docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171206643326.31786.8261961089605909281.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 14:00:33 +0000
References: <20240331200346.29118-1-qmo@kernel.org>
In-Reply-To: <20240331200346.29118-1-qmo@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 rameezrehman408@hotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 31 Mar 2024 21:03:43 +0100 you wrote:
> The rST manual pages for bpftool would use a mix of tabs and spaces for
> indentation. While this is the norm in C code, this is rather unusual
> for rST documents, and over time we've seen many contributors use wrong
> levels of indentation for documentation update. This series simplifies
> the indentation in the rST files by removing some unnecessary levels of
> indent, and by using spaces only for what remains.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpftool: Use simpler indentation in source rST for documentation
    https://git.kernel.org/bpf/bpf-next/c/f7b685436421
  - [bpf-next,2/3] bpftool: Remove useless emphasis on command description in man pages
    https://git.kernel.org/bpf/bpf-next/c/ea379b3ccc2e
  - [bpf-next,3/3] bpftool: Clean-up typos, punctuation, list formatting in docs
    https://git.kernel.org/bpf/bpf-next/c/a70f5d840a56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


