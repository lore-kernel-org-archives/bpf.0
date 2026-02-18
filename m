Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462D338936;
	Wed, 18 Feb 2026 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456818; cv=none; b=s1IFCXWn8czKtTn2PdpukdZsRYKQl4xneBaqXIncw9eSTn3xjsVeOzKgpjKhN7hPVaw+FJaOc+Nuz3ST+++qOmiGFdPGUEPAuaB0TAE0cj3S95HR3Rd6HDaCYOUcFpcJHLHI8eyfDaK2rY0MpkNUDZXq7lqYeWkEysID44SrR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456818; c=relaxed/simple;
	bh=QTrVz5IaAuqZQ+xaNJzBYU3H1cLdiG2sbdLrfR2MBmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g0FQDxTA8Wuvwd4ZhIkxar6hhjJuIP9GMvIgZiRPrhdVbnylZYpTo94VjjqgcB049FW2FtCv9Px46P5QXVugGLAdqiXuvVMMvLWzRjmljab2pkfxUvcuxNQumlaUEdfvn3U29o65B4OhDDN+E5u/M7my23nkL7dxjIvMnbKWReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6hwy7dx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6hwy7dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17693C116D0;
	Wed, 18 Feb 2026 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771456818;
	bh=QTrVz5IaAuqZQ+xaNJzBYU3H1cLdiG2sbdLrfR2MBmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i6hwy7dxFXaWt1zcO2KcSpawt5Cl7yr464niYuKQ6aYcNlojZ91Tp00kOscuYPFkN
	 /h0o9Y3mJ+qlKgX+WrbHxPbP3G9RsCenFgD9xLRZXuB465AuAFENgYkE09w1mBwdo+
	 B0Tsnsxwf4BUd8sBTXauPSQ5oHov1ZNSAYJ+q8pRepELQRsxzifhnyG8+H1e/eATE9
	 oYpDycLBHaWlKxbT9YFOqJdlJQJ9guxZragvZLJz49v6cx2N04zN3CUnBSY4xFviKW
	 b89osK7rlqyktBoROwCTVxPnzC56ooFyVoXGkwnu9voxVKsv/eKG9e2CQ2/YyVP/Pm
	 IIgzMkBB+HN0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85209380CEE0;
	Wed, 18 Feb 2026 23:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/2] libbpf: Remove extern declaration of
 bpf_stream_vprintk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177145680932.1592777.6289917082318107943.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 23:20:09 +0000
References: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Feb 2026 13:56:49 -0800 you wrote:
> The first patch adjusts a selftest that has been using
> bpf_stream_printk() macro. The second patch removes the declaration.
> 
> Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs/22156645808
> 
> Ihor Solodrai (2):
>   selftests/bpf: Use vmlinux.h in test_xdp_meta
>   libbpf: Remove extern declaration of bpf_stream_vprintk()
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/2] selftests/bpf: Use vmlinux.h in test_xdp_meta
    https://git.kernel.org/bpf/bpf/c/b3dfa128f7da
  - [bpf,v1,2/2] libbpf: Remove extern declaration of bpf_stream_vprintk()
    https://git.kernel.org/bpf/bpf/c/0cecd492f516

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


