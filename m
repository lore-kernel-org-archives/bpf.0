Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F6421F1B;
	Thu,  6 Aug 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007454; cv=none; b=dNWCUgZj9EEh4pFpYVHI5X6zxuZpq0GzYgSCBv5QRmtsmnO9fmP5eu/jSo+IxUplVzl2MtLfrnH7bB+qNvMOFE6dXjBodKG52NzK3RgMNEW3uAeklnIa18m9ya5oMsVmjDT8w1T3HcSLooE+i6syq9en67ClWNGQzzDPCxQMs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007454; c=relaxed/simple;
	bh=5PAIYNCXMzKjXjS2Bk+18ajPd0rSl53iubWcQPOToE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kFnEFl2hmCwY5pQJ3EFNv1U2753/ZqpgFMOlvcSxUOEuJND9pGqUu8vR+HmbLLnsfDQxxypfpN0DW9TqDMLT9OA2/QTjUErOpf+4BO+aZWQfdgWvPqAAwa4t+/UA9vHFeXYi00iTAAA7O51ff/VE4AHeh305w+ZavunLe0PxoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2hLdmtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2hLdmtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08541F00A3A;
	Thu,  6 Aug 2026 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007451;
	bh=gPc/u9Up7eVWllgtzkNXgVbHyJFWOFFaOBF27HtrdPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O2hLdmtDkX2nqc+L7a0b/hWiH5kGf9Z2NJJFE6fnP7nX3EMrB4DOxBtBiWqZZUCXr
	 rh/srLhKXTfeA0Z2hdaziywujrDOzQuuGsKFWwGCVcS9JuJO0bZma49R+PvgUoxIFz
	 nsAASfMdQWNyrVn4FVF++gvX9Bqd0KxlNZsk099j6GBtXypyBQe8c8n0tDgXXen+5u
	 HgFyNDjEQSG1OPB3SZPMLsnBlqgTOWio1R4D7ngFsC4qrqgmh308QMSfN+3IZ0Tka6
	 w1PJnhu4noOx5zaGn8GEp5hfDqyGnrOaYngk2H8s0B0ZWuvfeDH3E3CuSJjMbKTQ6d
	 5Bym/8N4BYQCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A743930033;
	Thu,  6 Aug 2026 09:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Allow selected kfuncs under
 bpf_spin_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178600741091.736609.7351771465681958135.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 09:10:10 +0000
References: <20260805153340.34776-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260805153340.34776-1-kaitao.cheng@linux.dev>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, shuah@kernel.org,
 leon.hwang@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  5 Aug 2026 23:33:37 +0800 you wrote:
> The verifier currently has a hard-coded allowlist of kfuncs that may be
> called while a BPF program holds a bpf_spin_lock. This works for the
> small set of built-in kfuncs known to the verifier, but it does not give
> kfunc providers a registration-time way to declare that a kfunc is safe
> in such a region. In particular, module kfuncs cannot be added to that
> allowlist without changing verifier code.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Add KF_SPINLOCK_SAFE flag for kfuncs under bpf_spin_lock
    https://git.kernel.org/bpf/bpf-next/c/ed3b3093b624
  - [bpf-next,v2,2/3] bpf: Mark existing lock-safe kfuncs with KF_SPINLOCK_SAFE
    https://git.kernel.org/bpf/bpf-next/c/7619a0ee9340
  - [bpf-next,v2,3/3] selftests/bpf: Test module kfunc calls under spin lock
    https://git.kernel.org/bpf/bpf-next/c/bca83aa31f15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


