Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C933939B
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786680663; cv=none; b=pC3Gbe1IcjHrOZxHY91Oirl0ToothZVOENmIUwibLi0RuhfPlquPE8TggQNaloZVCiYM5AnRjDnUc5Vmf2wmYoeMcZXF8THvMiGdbZngpUF0TuCe7ekKsFWNqN25MQt8uQw0zV6iEx6eRT6uJhTPA8rxyFig+jxBjU63sOgcYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786680663; c=relaxed/simple;
	bh=aq/EqwL6zhltxxpNiUoGziL8FH1hiQc+acxLKmnSMEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CBfF9p47hPiwM4wp4RY1mcDLGdFIfC0kU6Uc9IvqgDPTI3zt01QoOpdBoq6pBp1i79SLD2EeZDdT3tlrZYPYN+LaQk3Tfm4atbpCJvn56Lo/t8UQiy0QgaXD2S0UhOZUznyk7xvQZIcYPZ0gVee7A7sYNo+sRY16JOLCrk4ew8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAtEaSeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAtEaSeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5ED1F000E9;
	Fri, 14 Aug 2026 04:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786680662;
	bh=igDloU0eyHCmVW+1Lf/+qXx7WlPxGnvePMTmA5Ykc3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MAtEaSeRJerdcfTQjoeRZdOBF4Yq7oLlKMpWE/1wlt8DrReTvIJn8K03CpF+6qiyP
	 nsRj3GVH2EM47MuTEeu/KsYowQkLZHN9LvXd2xceVzCNlXM45JKZ/XvkiqrH9gEU3z
	 X0BI22hylV2QyH5RP/jjzpox7NpP5v91l5cX81C8xBvnIXbglVM7DYMpk+6lDeFJCT
	 kz+CB6Z4r2Yxi9qkFZFGTXzD5697aDuB2IEzT03q0CmdRq5dDaqCOjFnUejXNcUSfi
	 85oD7B6APHG4k/LDoCllXi41rqop3iTnKe1EejiJAQn31TqHn7N/dHILBl955+EFeZ
	 /fexCCkH5xUEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198813810900;
	Fri, 14 Aug 2026 04:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] bpf,
 arm64: __arena kfunc and struct_ops arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178668061664.3161817.18426400734023554692.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 04:10:16 +0000
References: <20260813190356.335181-1-puranjay@kernel.org>
In-Reply-To: <20260813190356.335181-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, xukuohai@huaweicloud.com,
 mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 13 Aug 2026 12:03:47 -0700 you wrote:
> The x86-64 JIT recently gained support for the __arena and
> __arena__nullable argument suffixes on kfuncs and struct_ops stubs. This
> adds the arm64 side and flips bpf_jit_supports_arena_args() on, so the
> verifier stops rejecting these programs on arm64.
> 
> Patch 1 is an independent fix. save_args() reads stack-passed arguments
> at FP + 32, which only holds when the trampoline is entered through the
> fentry call and two frame records are pushed. A struct_ops trampoline is
> entered via blr and pushes one frame fewer, so its stack arguments start
> at FP + 16 and every one of them was read two slots off. No struct_ops
> member passed arguments on the stack until the test added by commit
> 2d4de9a493a0, which is why this went unnoticed. It carries a Fixes tag
> and can be taken separately; note that the test covering it only runs on
> arm64 once the rest of this series lands.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf, arm64: Fix stack-passed arguments for indirect trampolines
    https://git.kernel.org/bpf/bpf-next/c/50de1c47a41d
  - [bpf-next,v2,2/7] arm64: insn: Add encoder for ADD/SUB (extended register)
    https://git.kernel.org/bpf/bpf-next/c/f4adb983ef3d
  - [bpf-next,v2,3/7] bpf, arm64: JIT __arena kfunc argument rebasing
    https://git.kernel.org/bpf/bpf-next/c/760cb40cfd6a
  - [bpf-next,v2,4/7] bpf, arm64: Convert struct_ops arena arguments in the trampoline
    https://git.kernel.org/bpf/bpf-next/c/bb5bad6a78b6
  - [bpf-next,v2,5/7] selftests/bpf: Add arm64 JIT-sequence tests for __arena kfunc arguments
    https://git.kernel.org/bpf/bpf-next/c/1c5bc60f957d
  - [bpf-next,v2,6/7] selftests/bpf: Enable __arena argument tests on arm64
    https://git.kernel.org/bpf/bpf-next/c/05a3575f225c
  - [bpf-next,v2,7/7] selftests/bpf: Test a multi-slot argument before a struct_ops arena argument
    https://git.kernel.org/bpf/bpf-next/c/197d34b16943

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


