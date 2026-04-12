Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062343A1DB;
	Sun, 12 Apr 2026 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023448; cv=none; b=YjHubDwNfsM+H12Yqvzyh+lVmLRnMA3MAkAR8c3qNyhijNYt3mjyk9bcKp2b2IHxYrfkLanoY9J0KZQ+4pg1JJRLOqSQHS5yGrDoZdfED7Au4NGAKO3vJh0szYQWz0TA/4+mCKrO/MCQCT+tagIR/aqR/fuxk7QPhbNrM8mu1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023448; c=relaxed/simple;
	bh=Ylq6ngyfQKMcKqfpdBa56P/0g12905cE/VPjTJtZ9Dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S8rCUQykXgRnUZ9SAG5INFhLJx7tTJIg51pUFHC0y/W1P/X7RiJ1u+7zVV5+Zmq9em1kY8PtGdUJKOBu90N5qmMKtvIx3Ot0R2C/DBh7xlPpJkyfx/IsX61wxM7VegyrEnnvmfnqlyoXBlOyCyooR7ef6KEa55XIdP+Sh13GOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK8+kyxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK8+kyxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8371C19424;
	Sun, 12 Apr 2026 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776023447;
	bh=Ylq6ngyfQKMcKqfpdBa56P/0g12905cE/VPjTJtZ9Dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TK8+kyxhkjC5jHGdjeOgDe8YjHmARelUhkLyuq2UH007ALRGfSudt1b5vpPQPvbOF
	 +RpEaMhCUbKXJOK6YbCHpKGoRHiSNJgQ3wQ7Fsz147XFK2fJn07wP0++jEojKlsbse
	 KJaMWN4pyOWUQIYr3jzkCiw5sWz/REB0wjvmM4oQD20XgfLnwmd8kwo7UObvGKW/Qf
	 TlmwCVAc54LT+kCSnIW2tCzq05jQaj8ck277bTAWMsXcbLlF61p3fNId9x/eHrkD8Y
	 DBTDvCx/72eY5bZ1o+hxOB0Ai2YhmRmPulvtGLeJWotMX+3CVGRr8xuA7wMs5cw1aZ
	 I5l3i3k8pknpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD383809A8C;
	Sun, 12 Apr 2026 19:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: add the missing fsession
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602342004.3390867.8771869478459170311.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 19:50:20 +0000
References: <20260412060346.142007-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260412060346.142007-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 emil@etsalapatis.com, leon.hwang@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 12 Apr 2026 14:03:43 +0800 you wrote:
> Add the missing fsession attach type to the BPF docs, verifier log and
> bpftool.
> 
> Changes since v2:
> - replace "FENTRY/FEXIT/FSESSION" with "Tracing" in the 1st patch
> - v2: https://lore.kernel.org/all/20260408062109.386083-1-dongml2@chinatelecom.cn/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: add missing fsession to the verifier log
    https://git.kernel.org/bpf/bpf-next/c/9fd19e3ed775
  - [bpf-next,v3,2/3] docs/bpf: add missing fsession attach type to docs
    https://git.kernel.org/bpf/bpf-next/c/46d9f15a55fb
  - [bpf-next,v3,3/3] bpftool: add missing fsession to the usage and docs of bpftool
    https://git.kernel.org/bpf/bpf-next/c/f0e16ac71618

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


