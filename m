Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D62FF675;
	Sat, 21 Mar 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123216; cv=none; b=Xr6IKr45rCeoVWmGyImn+jBz72wGtFD+07LyDzwRp6N8P9tEuVvS19r45aOhv44SdAyZ6ST1ZQUzDDt/e6ywUo3d8r0A7OpH8PHaKDsG+KW3jSi6Aw3VAK+7rH4V8JOTAajLMQqT1ARJ2G5n1EHIESeeTjprmx9j5935l9ZyjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123216; c=relaxed/simple;
	bh=UFiDAQwwxYrZ0/p6Bai7yQ32UsP7Q1TgJnSoDbL5A7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g24YCqj0HeSGdUi6unVyhlXAOZJ/SZRber70LnZXTCj+Gxu+8zhwEd6WVjwxfICqFPLtk9Q3/ILgf9P0MQhd6Q8rVBpnOxzi2VadUuuUTcTJA0VhICpRzPJ2vLfBQ/hb6bVUmCmYe6UL9QkbWG4dW+8BjlFO0FKqpkFXdGWmOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0yQnZRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0yQnZRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39196C19421;
	Sat, 21 Mar 2026 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123216;
	bh=UFiDAQwwxYrZ0/p6Bai7yQ32UsP7Q1TgJnSoDbL5A7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d0yQnZRcrf2PfFFf/zHDdLmF44OxA2FjS5cWb9DvjfzgcVuxOQ432ip3j7/U3diF2
	 W1op8XgEqS+8An5ir0Vb5gOfZwvykjZbAbO6a/J2mW3Ed5E1teH0CgxsTxEmsUAAbD
	 AJ+FafW3yvSMM+TGdXJAo5OeFPQCtWN5Jh6XGqxDOnOYx6lZl0qbbFXVt8nsKzAMiV
	 5yaJqnPwRhEWeY7gIlBr6w8V8rbqNlmz7ccnKvZEdHObOJPtOU1nCVxe7pHFojg+Gt
	 AGjJpglnIyFY/l9WS2cnfyU2gXEFIfUwkMhrqn12jcof7tBuz9+ZSHy++ic6gKYxBJ
	 lbswy/e+j5wmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D773808200;
	Sat, 21 Mar 2026 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix exception exit lock checking for
 subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177412320580.2947029.9138360675199400150.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 20:00:05 +0000
References: <20260320000809.643798-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260320000809.643798-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, martin.lau@linux.dev, memxor@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Mar 2026 17:08:08 -0700 you wrote:
> process_bpf_exit_full() passes check_lock = !curframe to
> check_resource_leak(), which is false in cases when bpf_throw() is
> called from a static subprog. This makes check_resource_leak() to skip
> validation of active_rcu_locks, active_preempt_locks, and
> active_irq_id on exception exits from subprogs.
> 
> At runtime bpf_throw() unwinds the stack via ORC without releasing any
> user-acquired locks, which may cause various issues as the result.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix exception exit lock checking for subprogs
    https://git.kernel.org/bpf/bpf/c/6c2128505f61
  - [bpf,v2,2/2] selftests/bpf: Add tests for bpf_throw lock leak from subprogs
    https://git.kernel.org/bpf/bpf/c/a1e5c46eaed3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


