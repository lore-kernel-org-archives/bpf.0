Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD228851C
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148027; cv=none; b=hl9awQQtoL1CWEQowXoUKqx6cjzY9wAHGU0eK2wJjdaeLz6G7KG2eSwrB4eoYAij+ElUh0Buhc3kUYt9799MPRt96f4WJR6pTyUcARGQQalMQqdCix67+CYCj+TqRIRCN+CnzcmY6AMSA55Z37OpOwUx26lAdsEFiwRZ96XdwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148027; c=relaxed/simple;
	bh=4Dxrn8uYz/oCr1yBxPGZWLd9y/Y61+2mSfwIfe1YCS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mmth+e6wcKJN1ifkdJB3joaLuTbSGWqUBEg0WmmgRLVZUIKxIhsFoydYV7ebi26wB8wodVJ88LoDIf1QO1A35RVNgu53gRFRDUg1qCibKRzQ9YNFKBD/d6lQo5epsaQ1DsMtmIJrq4qGQquoO3/6ahPTg+LqqGqoX2wOQ0zZzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUgSKesu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUgSKesu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA99C116C6;
	Thu,  2 Apr 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775148026;
	bh=4Dxrn8uYz/oCr1yBxPGZWLd9y/Y61+2mSfwIfe1YCS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sUgSKesut7nUtI+T6ad3licISTj5y7mF2Sld53fa8rAIXLpuUf/QmxLDMbNXwCC2C
	 Sc8MxdwBrUz5xAPmjv88L6ItJ/fWmMLoKUSS+z8sY21uem3eB4IHRE56+0lTzsJmhJ
	 dUp80hxFZQtMtb3v01TkWtQhTUEVpcaZ1trgQzllRNwJUMsQGwXYJfjsy909nCJ9/A
	 jWOk0pvHqrDCuVmqgdD55GJWWkBeajEA7TIwbD9XMPXUlCMQKEYhPh+Yxq6GhJV1jv
	 v2OwlLL4i8+agBizc8BmDO9phf63YQQKhCP6pO0TC+9jkHaIh1pPCrdPK5+48asycn
	 oJfdwbpQlBGqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EC83809A08;
	Thu,  2 Apr 2026 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Migrate bpf_task_work and file
 dynptr
 to kmalloc_nolock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514800854.525109.2727217490874276359.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 16:40:08 +0000
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
In-Reply-To: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 30 Mar 2026 15:27:55 -0700 you wrote:
> Now that kmalloc can be used from NMI context via kmalloc_nolock(),
> migrate BPF internal allocations away from bpf_mem_alloc to use the
> standard slab allocator.
> 
> Use kfree_rcu() for deferred freeing, which waits for a regular RCU
> grace period before the memory is reclaimed. Sleepable BPF programs
> hold rcu_read_lock_trace but not regular rcu_read_lock, so patch 1
> adds explicit rcu_read_lock/unlock around the pointer-to-refcount
> window to prevent kfree_rcu from freeing memory while a sleepable
> program is still between reading the pointer and acquiring a
> reference.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Migrate bpf_task_work to kmalloc_nolock
    https://git.kernel.org/bpf/bpf-next/c/90f51ebff242
  - [bpf-next,v2,2/2] bpf: Migrate dynptr file to kmalloc_nolock
    https://git.kernel.org/bpf/bpf-next/c/cc878b414450

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


