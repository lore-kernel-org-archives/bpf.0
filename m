Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F043F083;
	Sun, 19 Jul 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784478042; cv=none; b=oAbU0LNcGZxjqzyEapp96pGbaYulS6jxqS5l2ZP4QuFxplxUAhvuOidVMh2O1oNsF0qBoXVDKHGI5Am5AbdNoD0bL1D4mHeuUVYr6jKNfKmdSUsFCPB7QkdJli1SSQCcYT1mhXd3s5MBWhsXQLcEsWjuOTH8BFkErgqKasJiONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784478042; c=relaxed/simple;
	bh=3A1R3kKW0VUFr5l99jhIGYczE/bUrdV+Ir1EeNWvjrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i1kBodN1HzGK3cp79XUZug6nkmhIZOY0J1ckdek7l8tMG6ep9FEwNjBr0C7q7ZgC1G56AhrN9B70eOdYARqlYslXve5sooCb6ik+k5Ju9g8wKFiGEFiYTIXNty2JbAgBPuk/umkTxANYiTS5wpNfka6QNEpA3PbWgnujTEr4M/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enu13aXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enu13aXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6296D1F000E9;
	Sun, 19 Jul 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784478041;
	bh=d8lRrcpriKa0Dnh8uHSYYnowCMgAlxgBTMJmHMfw3W0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=enu13aXjPIIaB4+LHmgqSR6XEvS43qz63AVfG/Eve5biQn2y/bX9UzWC/RNTnuF3l
	 JHieLp26/hlQMXg6yHT0SZgMe8AHNrRu4swZ4dgI09bIMgAICzZPHXQDsfvOTDtr0a
	 XBTKYnYuCUutMp1afpgsYRnYtqk82ppaMUDQNAcAVgB5GttLshlmqS1Tt3G4nQw80s
	 jypnExhoVyot37Et/4zMxTk3i53R7US28HZnD9P5kf9G/BukRByjmYcKNTiisy9zkA
	 OvMD+7yZbPK4NuDosVZY3CYBQAH+SnL55d1JaIKOvuxY3In1bDFo8tlGrsqOO8H2m8
	 +jOy+dquOJIQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8138119C7;
	Sun, 19 Jul 2026 16:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] bpf: Add memory usage for arena and
 selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178447801214.2765968.4502308683135798549.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jul 2026 16:20:12 +0000
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260717114117.350851-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, random6.xyz@gmail.com,
 puranjay@kernel.org, skb99@linux.ibm.com, ihor.solodrai@linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri, 17 Jul 2026 19:37:00 +0800 you wrote:
> arena is the only map type whose map_mem_usage() still returns 0, so
> bpftool and fdinfo always show 0 memlock for it no matter how many pages
> it holds. This series adds the accounting, runs the arena selftests
> serially so they don't OOM a small CI VM, and adds a test for it.
> 
> v1 -> v2:
> - split the scratch_page -> arena refactor into a prep patch (no
>   functional change)
> - use WRITE_ONCE() for nr_pages to pair with the lockless reader
> - reword the "run serially" commit message
> - selftest: alloc prog returns 0 so the failure check is reached
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] bpf: Pass arena instead of scratch_page to the pte callbacks
    https://git.kernel.org/bpf/bpf-next/c/f8248ac8f044
  - [bpf-next,v2,2/4] bpf: Add memory usage for arena
    https://git.kernel.org/bpf/bpf-next/c/89318afb1414
  - [bpf-next,v2,3/4] selftests/bpf: Run arena tests serially
    https://git.kernel.org/bpf/bpf-next/c/a14f9ba080c1
  - [bpf-next,v2,4/4] selftests/bpf: Add tests for memory usage for arena
    https://git.kernel.org/bpf/bpf-next/c/29e4bcf12604

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


