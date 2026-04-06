Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0F39E16B
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514636; cv=none; b=gRIQ49VcwIlbeM60aZhP8no3/h4qRHee128hDQWWOKjvSfgNCEa2Yg8GlOMWMR7dLY9ZwF92SjJBPG+cnFWLzoYXA555uFC7WiX7lTay8fvVFknVvhQCHrj8McCsVBtCT0g7ycmbx5sYvQXBZY/3DPyzMvoAKqEBuREYVuX4n+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514636; c=relaxed/simple;
	bh=VXo3mND4W9yH0ZgjMHQwNyPTha9SjSaBkNyavEYqV98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BSSTDHD+2viWH+pP+tmyPCet/I7Vy5mwy+cWb65fkb6cbLMK2FNOk0QMJu5jnDZKsj3w+8udz6nK75c6VkPLciN1A5zV3qHeuDn19oC1wU7M1gbT7LdpV4u3ml4QLq3HAmnFcL/2GWAWqeDcGa7TqwdSwxFrf/tqJQ5m6BH3xdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1vxWwGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1vxWwGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F337CC4CEF7;
	Mon,  6 Apr 2026 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775514636;
	bh=VXo3mND4W9yH0ZgjMHQwNyPTha9SjSaBkNyavEYqV98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B1vxWwGzt2NH6vum+z3CY+wT826k+W1F6mvzCUWSJNm+gAt7Xk23ymy7RuH/J72Du
	 yld1BSS/2n+ivbYlgW/CFneMV4+gpT/Ag52XvB/C+qgwOK+Xw7SLo5hRfbK5gaSyLs
	 JtRs1dBtWZTAn6LNFN6ToGUtx8kXWkzWGdJRmkbnBJ2jul7PhiUjghRaCCO5A/zDO6
	 PN19rb4AmRl5uxmTTxS7dxkhNiUV9sD0jdJvyuhwUHPpJVX/yQpstiYajnyWmY26fx
	 M6Nae+W7VT/q1yY+9VR8VvAuqGOk3SEpPysiU0n0Em15Bi8m6oNtymQu9Y6E8TPR+M
	 rYDOKrVHpNebw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F8D3809A23;
	Mon,  6 Apr 2026 22:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/7] Allow variable offsets for syscall
 PTR_TO_CTX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177551461454.3284566.6663759272582357934.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 22:30:14 +0000
References: <20260406194403.1649608-1-memxor@gmail.com>
In-Reply-To: <20260406194403.1649608-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 tj@kernel.org, dschatzberg@meta.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  6 Apr 2026 21:43:54 +0200 you wrote:
> Enable pointer modification with variable offsets accumulated in the
> register for PTR_TO_CTX for syscall programs where it won't be
> rewritten, and the context is user-supplied and checked against the max
> offset. See patches for details. Fixed offset support landed in [0].
> 
> By combining this set with [0], examples like the one below should
> succeed verification now.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/7] bpf: Support variable offsets for syscall PTR_TO_CTX
    https://git.kernel.org/bpf/bpf-next/c/ae5ef001aa98
  - [bpf-next,v5,2/7] bpf: Enable unaligned accesses for syscall ctx
    https://git.kernel.org/bpf/bpf-next/c/f25777056e24
  - [bpf-next,v5,3/7] selftests/bpf: Convert ctx tests from ASM to C
    https://git.kernel.org/bpf/bpf-next/c/02f500ce0109
  - [bpf-next,v5,4/7] selftests/bpf: Add syscall ctx variable offset tests
    https://git.kernel.org/bpf/bpf-next/c/5a34139b2732
  - [bpf-next,v5,5/7] selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
    https://git.kernel.org/bpf/bpf-next/c/02c68b10d84f
  - [bpf-next,v5,6/7] selftests/bpf: Add tests for unaligned syscall ctx accesses
    https://git.kernel.org/bpf/bpf-next/c/0dca817f4dbd
  - [bpf-next,v5,7/7] selftests/bpf: Add tests for syscall ctx accesses beyond U16_MAX
    https://git.kernel.org/bpf/bpf-next/c/171580e43272

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


