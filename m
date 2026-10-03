Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB94908BB
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045607; cv=none; b=GxMR5aeXdKshwZDtPzc3lIe2erj3fB42VFUdJsuOsf7xJcJREzEWHOFMVhOXVDI8JDGaFmcNfZAXvgs6j+e1bGjjk+88+N1kLG/+mv6hM0Mq5kcRh9E9YhLMHKON516e3WfZYpRaA4eIrQCnF2nTocGo9UWo7jIqtbuTwMCPz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045607; c=relaxed/simple;
	bh=c/mfhwFyPybgVf0jISjrtZ0T4Fok4mtwTKrSc0Hur/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jzHqmRQ8X+wjjgdvm66bkf8YL1btKlU23cRfR7gymIyu1QOjeVO1rD5aHr1SrjzkrpGh6QRZY2zV4y+fh+h0hlx2D1rfgYyWVyCZUOhPmxsgFV6rO6AW2zkEESrJmKZySgzfTcxmuuaLpa9eSeB8DWtikRKrorm9ZAAZIaSHIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQCL87Cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQCL87Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8101F0089B;
	Sat,  3 Oct 2026 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045605;
	bh=rOfebEJz+5qEis+cshKt/Un9ay5hRI2n3qW7vf5t1Gc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DQCL87Cs1m3eEWMHwC1xLWILK0pvHoVN1moKOdjADO/F7gRw7ZRdHSKyltmwuaxv7
	 j8KLwtJ8ldzjP26C39xAwOjufXaFNFYGhePvV/7Ykg9d9MDVrZad+qrFJkfet1hchG
	 /zfsGW+OTp8vMs+NFbvvq/E1Bn6Imu9xRDE8bBYMj4rjaN98/8viWRBJ5B+QaR0j1a
	 e51yJSRwJ3XJ7ZQsndywvDy+fuUbMBOuSZZq/ICDXtlMRitWUwpZm9/mrrdvFEGXJv
	 X7NFr+blNkMLroSkk8W1jJXHUTrQpcYMJr7WTb8OIODsCZls5ffD9YCAdN5tViTGxb
	 fQ81rrG4Bxo1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44F63924475;
	Sat,  3 Oct 2026 16:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix data_in_arena test with GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179104560432.140575.6058877833972070957.git-patchwork-notify@kernel.org>
Date: Sat, 03 Oct 2026 16:40:04 +0000
References: <20261003150456.168903-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261003150456.168903-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat,  3 Oct 2026 15:04:56 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> GCC doesn't support indirect calls in BPF:
> 
>   progs/data_in_arena.c: In function 'use_ops':
>   progs/data_in_arena.c:65:1: error: indirect call in function, which are not supported by eBPF
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix data_in_arena test with GCC
    https://git.kernel.org/bpf/bpf-next/c/1ad83c31abfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


