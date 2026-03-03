Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74D3947B2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556620; cv=none; b=HpEyUWufnCJYZ+7UM5Y+BztrqhVLRVeVHC1jR0Tej18CbA4gRcLNFU6TMjxCNyJP+uHQgeA4nEgiIXLX0DH1jwtckZX4t8FmdQzRPks+DhQAca0JhjzXpkFlm+y8QV9Kdaei5rqfMYe6xcbx0t0Zhtu3qqxF8MQ6qCWxM+UzyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556620; c=relaxed/simple;
	bh=W6yXrkehX4Vd0xq+xsmaOoCCwLEDkcwlfwPv/gAtKkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T4f8KpvtiZg+97Jdnsa5y/L/tNJ+wzyviRDkaltwzQ/nnAxJ2KCq+90s6XHL4sxpnn7XtzFOYS1DlXW+OP1eLAtwyMqnliBB5Dl3aCz+eIgYA+qFt9tRAYEdW+tewhpbH50bfsz83YFoM7BajbXDxwm1/Ym6C5y2j/WQHYWFRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z658sLmd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z658sLmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798BBC2BCB2;
	Tue,  3 Mar 2026 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556620;
	bh=W6yXrkehX4Vd0xq+xsmaOoCCwLEDkcwlfwPv/gAtKkA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z658sLmdqYP3kjL5nzmj3HsHUxrCyEyQ/5TrVI5fDWlcBWgpDLhf/t4BJDNJC98WH
	 uLltF4yLp9kDQvGuRPWsxWadPYxtNa+fYrx6F07BGocVKzEWn8xMhfjfkAC99qiQu1
	 BtOl1Kq/duNHsfKn2QZjOyNbQgkqWVdhDUzKaxoVZ41w6j1hdhPMLabkEiJuURqUsN
	 HzEl/qE+yI1LW1d7t+AXXHdAkEZcw4sSYSi610XVr2r2BIK2DC9MnBkImq6rpg7qAY
	 8iN5gPoOwTn0WlE61NYvlFoj1PwXiSKZyU8H5aQtGQfaGfA1GM/iay5QBU5kpjxSqw
	 aJZ30XTjCXVJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E383808200;
	Tue,  3 Mar 2026 16:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/5] bpf: Allow void return type for global
 subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255662179.1383432.17952808984148177343.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:50:21 +0000
References: <20260228184759.108145-1-emil@etsalapatis.com>
In-Reply-To: <20260228184759.108145-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 28 Feb 2026 13:47:54 -0500 you wrote:
> Global subprogs are currently not allowed to return void. Adjust
> verifier logic to allow global functions with a void return type.
> Exception callbacks are excluded from this change, and still require
> a scalar return type.
> 
> Adding additional logic for void globals significantly complicates
> check_return_code(), mainly because of how the new feature interacts
> with bpf_throw(). To avoid complicating the code, refactor the return
> value range validation logic into two separate functions, one for
> program exits through BPF_EXIT and one for program exits through
> bpf_throw(). The changes are non-functional.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/5] bpf: Factor out program return value calculation
    https://git.kernel.org/bpf/bpf-next/c/83419c8fdbbc
  - [bpf-next,v6,2/5] bpf: Extract program_returns_void() for clarity
    https://git.kernel.org/bpf/bpf-next/c/63ec29623943
  - [bpf-next,v6,3/5] bpf: extract check_global_subprog_return_code() for clarity
    https://git.kernel.org/bpf/bpf-next/c/69ca55e63101
  - [bpf-next,v6,4/5] bpf: Allow void global functions in the verifier
    https://git.kernel.org/bpf/bpf-next/c/8446ded1e1a0
  - [bpf-next,v6,5/5] selftests: bpf: Add tests for void global subprogs
    https://git.kernel.org/bpf/bpf-next/c/422f1efabd13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


