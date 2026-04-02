Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948336D51B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168429; cv=none; b=c2ytXmV4xJehd2ewIudD8vjImhFUo1SCMKvb6KwopyF6sxokyXqY1RnLvAH6oxyuejBzFS6YetWpJqq9Ifka2hdEXO+6eo4qlR97IJxBdbjExJQTVc9nUiH90vIAAofO1Xhl2eYzZb5XXLaT3jvQ20jcNDsKt5lw/uVTvSEaD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168429; c=relaxed/simple;
	bh=ueKaOuXj4rNV2XOaVojuRS3VReB8HHKNLGK0trT3aFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AnhDSL2D5ATYYK6qUD/tN2q2Lox2ZWa/+RC7BWGhpMuQuC4B68XFRJDR72EK7wpchoj7U9T6bl6y89sfEsiSjXnr6U85REtHInfEsDHLX6ylEDm4X5amF9Q48cyeAPjmkAQHRKwJjvYWyLXlY0HkAn/B3uisMDoCroub0OAuZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyIr10vQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyIr10vQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A71DC116C6;
	Thu,  2 Apr 2026 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775168429;
	bh=ueKaOuXj4rNV2XOaVojuRS3VReB8HHKNLGK0trT3aFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VyIr10vQ6NukPCgAMdh7Zk1eFOPzkVcFbG7WELyvwkl2lgg6lYc903fcYKSHD2OHu
	 2sLkhUGa/qzN5Hx50+U9ymxMdcNX1uw53WzXKVBgin0syPKPKa60wpMGgPEzeJPFxn
	 lJFFMGpSF6QIPjbcA8R2f4DvfY8vD9K0ig4b8TgqyUAXPw7LhgFCV+ZJEfLIXz3g6q
	 BxApKyoU/axbDcYU99wyRiH4OeqmM8+jC+SdRKn+NgjPYDMKOoyqtRjHkAmCLCmxug
	 ejVi5+fcE7UAvFdtcA+MomXwB62YhpnNZOQdu6xyxJBmeIPEQ49ytYLemNsBWnvtN4
	 BP4Q2RtTPn48Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EB63809A09;
	Thu,  2 Apr 2026 22:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] Task local data bug fixes and improvement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177516841154.640064.7942863903383946772.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 22:20:11 +0000
References: <20260331213555.1993883-1-ameryhung@gmail.com>
In-Reply-To: <20260331213555.1993883-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 31 Mar 2026 14:35:50 -0700 you wrote:
> Hi,
> 
> This patchset fixed three task local data bugs, improved the
> memory allocation code, and dropped unnecessary TLD_READ_ONCE. Please
> find the detail in each patch's commit msg.
> 
> One thing worth mentioning is that Patch 3 allows us to renable task
> local data selftests as the library now always calls aligned_alloc()
> with size matching alignment under default configuration.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] selftests/bpf: Fix task_local_data data allocation size
    https://git.kernel.org/bpf/bpf-next/c/7c8ca532a741
  - [bpf-next,v2,2/5] selftests/bpf: Simplify task_local_data memory allocation
    https://git.kernel.org/bpf/bpf-next/c/bb6d9f5cf1d4
  - [bpf-next,v2,3/5] selftests/bpf: Make sure TLD_DEFINE_KEY runs first
    https://git.kernel.org/bpf/bpf-next/c/80aa8e9c64d0
  - [bpf-next,v2,4/5] selftests/bpf: Remove TLD_READ_ONCE() in the user space header
    https://git.kernel.org/bpf/bpf-next/c/0b481a6915ed
  - [bpf-next,v2,5/5] selftests/bpf: Improve task local data documentation and fix potential memory leak
    https://git.kernel.org/bpf/bpf-next/c/63f5156a9c3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


