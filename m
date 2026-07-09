Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF593A16BD
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625432; cv=none; b=Qk5yeFCw9VtnBZE7vwxu17O5mOKWvFeUB199VsIib3wlRIoETXEHJsFWcStri8pAzl8nBlwL3gICKugKfggBc9YQ22ji6MrrESygYB/IKFdahj7OjAu4LEn2sgpNOm20iOCDwU0kMlJ4+kn0oIBGilt4p3b3pa67krvqd/1mtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625432; c=relaxed/simple;
	bh=vAGoM11DhOI/9qpZgI+3OOMy5yoJErEbgDtE1+EfWmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJlJvCWd0vzJlkM28gFyYdYlrZVH1lLpfVqzMGT0omq1wX+wOtpADOoJmlZfmuwvhQiQxBgapk9MrTuJP0R7XlYgN30Ei+UNfvca3WZe+zLKMloZgzqff1f8bWEV/8XZ43DS1t3MXNJejVSrlQveE20nhQN8R3UaTUK3PX4PV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSG+XfoS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSG+XfoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375AE1F000E9;
	Thu,  9 Jul 2026 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783625431;
	bh=P9az9cFZmduRlWVUAJfvB+z1wNsp6giW2u4PvrM9aFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BSG+XfoSgPwylGN+9BWxs5LeUa1mZnkAvrUW65Pg9Ug1SvY9lZ50323cZHT382eJ7
	 y4rBnTVDCHWGEUDQrcFcmHQbbQGkuH5R+QgnxFGC4CYD5keAHbAoYfj638NWZs5zh5
	 hG9akCzTh8ua4KkICD/DQb5t1XPqXOQfliOB1FoOh2k+WFhiwxAgi1lj9CUC0CL334
	 /Wc8EnuVodEZh4oHGPS/ASeOH2q2efn4CxmmBl/Kem+MLpc8Jd/xEylEZkir/WoBQJ
	 YPsBb7wz7/5G1ofSvwRHrxRtV7tR5PtZNSj0cbn+oAQXMVJGg9GKpRtxA85bpfXcvV
	 1TeiTYI2Z9/hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D093924FD9;
	Thu,  9 Jul 2026 19:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Drop scalar id on sign-extending
 narrowing
 stack fills
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178362540938.4090369.14805985399599329813.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 19:30:09 +0000
References: <20260709153131.386599-1-daniel@iogearbox.net>
In-Reply-To: <20260709153131.386599-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: eddyz87@gmail.com, puranjay@kernel.org, memxor@gmail.com,
 yonghong.song@linux.dev, info@starlabs.sg, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Thu,  9 Jul 2026 17:31:30 +0200 you wrote:
> When a spilled scalar is filled back with a sign-extending narrowing load
> (BPF_MEMSX), check_stack_read_fixed_off() copies the spilled register
> including its scalar id, but coerce_reg_to_size_sx() then sign-extends the
> filled register's value. If the same slot is also filled with a plain
> zero-extending load (BPF_MEM), both destination registers share the id yet
> hold different values. A later 'if <zext-reg> == const' then refines the
> sign-extended register through sync_linked_regs() to a value it does not
> have at runtime (e.g. the verifier believes 0x80000000 while the register
> is 0xffffffff80000000), which can be turned into an out-of-bounds access.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Drop scalar id on sign-extending narrowing stack fills
    https://git.kernel.org/bpf/bpf-next/c/2cb5f4ca695e
  - [bpf-next,2/2] selftests/bpf: Add test for scalar id on sign-extending stack fill
    https://git.kernel.org/bpf/bpf-next/c/c3d5ef291a2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


