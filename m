Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676546F4A5;
	Tue, 21 Jul 2026 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658650; cv=none; b=OKBQMdmH32eENdEdRr3H8fg1k7Tge2FUUhxb5lq8bvvkM6TDRDoiIBLxabG4thWMJOIMwuEHHdxJhzsp/+Kt5e3QwbafXWVNbT3zM5skKPRj20V+l/hzxIyllsrRxyXPYM3LTdwiR/bggjFCn2zNyTJkCdW5Y5ZOEcEv6JaccsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658650; c=relaxed/simple;
	bh=zyaIyHPAgt+cJuAO56GQdmeQx3zssLlCthdy1WtBbGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gIeW0GH+hQFrmBRGC+cKfpO0FUDLWMy5JhxUk+owJwKgEf5MEHbCAC5qiooJbL64zRkI6zzHRYkYB/mulM23GgXYoiMswRODT/PlJTOt6Qu69hbUEKUYOAaokj9EvDGxx8TmT957D9/WTxIXFdxcMPrBZxmSB7dlLYwdimXKfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRAP1m8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRAP1m8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925F61F00A3A;
	Tue, 21 Jul 2026 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658648;
	bh=xImigRmDnIx1zusSwHpXh3TKLKehrpgm2XReoQ8B3p4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aRAP1m8nSJHiWjBmQgmhAPrtgBI6FDHCA1EWKJaAtrnW3PPTEiluupniJbTDpo6Xm
	 tpkIjaYc0uD4DRsdhr8a3GoUmHNpxoJHkeL2N4RkUb/yAaVGYU0dfX6SpOX2kgB6/K
	 loc35dANYletc4bdaq6mDfajSfkxdDTWFaLo4EE5OjF8FeOjn3wuWLCFGUWZ9JqGjD
	 AhLd+JGE3rZkAHlKY9ilU+iAF+UPEUrLWFJxUHTTZbOLVXrmOStVDQRJVTVuUAHkv3
	 mrYMGZdPUdB/ceqcNtvNL0f0wJBiU0/yiVvLE63bas1DgcAJsAR2VdVqbJSj/wK96L
	 M/LhQzZvVMO3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B0F39253EE;
	Tue, 21 Jul 2026 18:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/7] Mixing bpf2bpf and tailcalls for RV64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465861815.931197.16356281577887013283.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 18:30:18 +0000
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
In-Reply-To: <20260708064436.2971933-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  8 Jul 2026 06:44:29 +0000 you wrote:
> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> the TCC can be propagated from the parent process to the subprocess, but
> the updated TCC of the parent process cannot be restored when the
> subprocess exits. Since the RV64 TCC is initialized before saving the
> callee saved registers into the stack, we cannot use the callee saved
> register to pass the TCC, otherwise the original value of the callee
> saved register will be destroyed. So we implemented mixing bpf2bpf and
> tailcalls similar to x86_64, i.e. using a non-callee saved register to
> transfer the TCC between functions, and saving that register to the
> stack to protect the TCC value. As for the tailcall hierarchy issue,
> inspired by the s390's low-overhead approach, we store TCC from
> RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
> func in bpf trampoline.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/7] bpf: Extract the is_struct_ops_tramp helper
    https://git.kernel.org/bpf/bpf-next/c/6bcecae4b65d
  - [bpf-next,v6,2/7] riscv, bpf: Fix memory leak in bpf_jit_free
    https://git.kernel.org/bpf/bpf-next/c/369e4635d048
  - [bpf-next,v6,3/7] riscv, bpf: Using kvzalloc_objs to allocate cache buffer
    https://git.kernel.org/bpf/bpf-next/c/f3ab878594b5
  - [bpf-next,v6,4/7] riscv, bpf: Fix kernel stack corruption in tailcall with CFI
    https://git.kernel.org/bpf/bpf-next/c/52fb1756ea1d
  - [bpf-next,v6,5/7] riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
    https://git.kernel.org/bpf/bpf-next/c/a21731f54cfe
  - [bpf-next,v6,6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
    https://git.kernel.org/bpf/bpf-next/c/ec72848ca0ad
  - [bpf-next,v6,7/7] selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64
    https://git.kernel.org/bpf/bpf-next/c/683ed8b78c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


