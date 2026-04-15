Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDB3D6683;
	Wed, 15 Apr 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267040; cv=none; b=K7QqdZIqEOPegnK1jL98zhQ1rR5Ctgt2eRTfnMc8C85FlmQCxxuBpRBR9RkjSzLI9JS1ANGsTZpQnBuCXV3DcloCImHtlsomKC+OJnmLaa7IXr/m/CHoxY5THfHdlveuTXA9cIVZ12CsZX3KkY2zvZmsMnCy8Bgp/YS9w5Ow6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267040; c=relaxed/simple;
	bh=E1x7C2hRcnEsyc3OB113TDPeOYAlnpmn738oz08qO00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dfQvne1dDpgc21MWyCyXPaUE2xiqnQ0jNmSU7/zwpXeLHBARdVnvBp+WQCDExqnUElk7BSY4smT3Yz8BREOpPbabV2PvnvMaPUe3fH0sk3TcS9Y2BLufSwGtYX6VkB5y31k2ysj/dK6odvNa7KgQNtkPidrJyXm7PBB+f/Ns1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJUJ5B8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJUJ5B8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D5EC19424;
	Wed, 15 Apr 2026 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776267040;
	bh=E1x7C2hRcnEsyc3OB113TDPeOYAlnpmn738oz08qO00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uJUJ5B8R4//b+B6rK3GihAjQKj/ie/y9KZFsrR+HBTPwAypByzpEY8x41FzKaPHUL
	 HNUYYvUu555/KatVZDICC3zMROwx7gJ7W5v4VbOn9l2n5NYvlYiEGmkhQV24mzDTbe
	 C4WhpTZNHcdiSXM3psy6NE3kL5mnGenujDYKtynSLbtVeTadCXMNwNbkLKexsb1u28
	 qL9HbEr1tyCQzIMCp8yaRFCs8D3tNvDbuT39vMHC2O7nz/bDdV+2uLtPUysf1r98Ms
	 6HOlw/fQxgrF44Y4bUpJ5Xr99pI2kLN2FDkyGbjIiuWE2ecu/q5lAoV7D7tuadSANt
	 cE0oxFvy6YaGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D5E380A963;
	Wed, 15 Apr 2026 15:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix timer_start_deadlock failure
 due
 to hrtimer change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177626700980.2286650.9265086160531158230.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 15:30:09 +0000
References: <20260415120329.129192-1-shung-hsi.yu@suse.com>
In-Reply-To: <20260415120329.129192-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, tglx@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Apr 2026 20:03:28 +0800 you wrote:
> Since commit f2e388a019e4 ("hrtimer: Reduce trace noise in hrtimer_start()"),
> hrtimer_cancel tracepoint is no longer called when a hrtimer is re-armed. So
> instead of a hrtimer_cancel followed by hrtimer_start tracepoint events, there
> is now only a since hrtimer_start tracepoint event with the new was_armed field
> set to 1, to indicated that the hrtimer was previously armed.
> 
> Update timer_start_deadlock accordingly so it traces hrtimer_start tracepoint
> instead, with was_armed used as guard.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix timer_start_deadlock failure due to hrtimer change
    https://git.kernel.org/bpf/bpf/c/813f336269e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


