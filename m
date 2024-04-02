Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DE12C530
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068829; cv=none; b=Wvh7/9HF+y1Wyja1t1c6aOaIIDqfJopiH4lBcIObO0SlEuwt6HQNNdsvsBJ9EDGO/PMv7K3Hu1OzLZwMYqMmJ3MROXBPw/g4G8B7dD/4HG5hhPbUbus2ymVb+rDxBoE/2XuAS5ZPq1lpKoSIONdVUcm8BUDZHhsCHksdjACduhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068829; c=relaxed/simple;
	bh=2F1beY2islqh6MxEbROlVxLvsV8Miz1kGlCD7RStJOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MVcnWpiungb1mCldDN264B2d3+bcVIjBYv6kX5Sx5OScH8/U52OW8dc9gpba0FUojS/filguSIUYsab4jP+Xy7f1PDnAPwFm/anTXloz9BQeBBhDNoMzOevM53rypJl8F3dQeiULUCpD2rwLHSA5mJmuidjpESqB+OOFtjFtsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoE6PPvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoE6PPvt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 756A9C43330;
	Tue,  2 Apr 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068827;
	bh=2F1beY2islqh6MxEbROlVxLvsV8Miz1kGlCD7RStJOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GoE6PPvtpmKi0ZbqDtcLLZvDJj7AY1Oy0IrYo/NO1Tt83KAsl4ZHWj+V/w0PlVzEK
	 KxHZDP1ZYyB+lNAX1nnKP+m21i/x/7ijr5CMfSRV8LJfhcb07y31gVAQRB93dMdOxc
	 wpjmMlhU9tF6cVrhu2XYwHLgxdOaVDdbPC1+sbTM6MTJKOEyLfCOn6cexYPBedsAYG
	 oYAa2zjgd+CNuti6/pzZlc9xGeMnlPFKI+2Os4kRZbhp6o3vPgNWaraRi0xg4mw20o
	 xa2TPNzLpV22i3ooNFNYc0TSrpLcBz/UeDgRH+mPwDx+taxzwIneUf9SLn8NveMVhi
	 47hdLg2aUOFHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69225D9A155;
	Tue,  2 Apr 2024 14:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Skip test when perf_event_open
 returns EOPNOTSUPP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171206882742.27281.12905125548526952131.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 14:40:27 +0000
References: <20240402073029.1299085-1-pulehui@huaweicloud.com>
In-Reply-To: <20240402073029.1299085-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Apr 2024 07:30:29 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When testing send_signal and stacktrace_build_id_nmi using the riscv sbi
> pmu driver without the sscofpmf extension or the riscv legacy pmu
> driver, they encountered failures as follows:
> 
>     test_send_signal_common:FAIL:perf_event_open unexpected perf_event_open: actual -1 < expected 0
>     #272/3   send_signal/send_signal_nmi:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Skip test when perf_event_open returns EOPNOTSUPP
    https://git.kernel.org/bpf/bpf-next/c/c186ed12a8ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


