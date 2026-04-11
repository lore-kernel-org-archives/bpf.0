Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD72347DD
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917238; cv=none; b=rGwXd95D+oTL8jOsNSvGZMzI/J130Kxc/PwrX/YgghynRoqHLcpLAqlSH2zp/T4BNhex+oS5/UYvs8yaMgnvwBw2VRAbdsCFlMKMj4EBn89xS8en0Bst65ckLxSQdlLjEZq+C3uAe5xpmhvvJ/7HPaWUlJ20GdGFy5kfDvdseM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917238; c=relaxed/simple;
	bh=XLNRP/BEKTE8S7fkEH+xic1n4U12JgHr5AHwHJyOH5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qjM3Yr3yb4Hz3IhQwTbZPRavHWRL9lTwRfkJxgguxC1H7B5OoN3HEJp/AXOrATm7wuzsvcEgfebh+2xs7Svci2kQtPySDDmsxZNBkpmZ/LrazTLznPjtfcIPCkaRSStJqsMKnByxKQQ/Tyv3sj5Xjz5KvUE65k8ksCLitnP21mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L09ySvWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L09ySvWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CBAC4CEF7;
	Sat, 11 Apr 2026 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775917237;
	bh=XLNRP/BEKTE8S7fkEH+xic1n4U12JgHr5AHwHJyOH5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L09ySvWCPf/cnMe4lbNCZ6hGzJTYwiQLPXsXlHXAC0XG9+OHhzGAqZFIAs0CH5N16
	 uju0yPrNBBLfEXm9w7hL1vZvWQlQRldljCVjpAzmQQH2msmNc10CXOrZ7ZqEAO48Ju
	 0XNvc94Igv1iGy/esOsZkEKjN8NjWOwlF/th4KHqk5Ok85hZnQWSSqVST29F2O9jMW
	 6mxc4spFN6i90DeR8ZdAZKFByXAKPQ/mPi8IBtAdl7b2F/h7BGDVXqbpiVhdedi1wA
	 hBCCrAG8cL+Q5NHoJkbnSfTqAoqSuBiUR8PWnqwwdGPhtXcYpkaFd1PrA5enJwglLg
	 b8xLPjW3i0Kng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCF83809A8B;
	Sat, 11 Apr 2026 14:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: impose global ordering for
 test decl_tags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177591721129.2987296.14759491353155138068.git-patchwork-notify@kernel.org>
Date: Sat, 11 Apr 2026 14:20:11 +0000
References: 
 <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
In-Reply-To: 
 <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, cupertino.miranda@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 Apr 2026 00:33:43 -0700 you wrote:
> Impose global ordering for all decl tags used by test_loader.c based
> tests: __success, __failure, __msg, etc. The tags are now sorted by
> testing framework to be processed in the same order they appear in the
> C source code of the test.
> 
> The ordering is necessary for gcc-bpf. Neither GCC nor the C standard
> defines the order in which function attributes are consumed.
> While Clang tends to preserve tags definition order in the output BTF,
> GCC does not. This inconsistency causes BPF tests with multiple __msg
> entries to fail when compiled with GCC.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] selftests/bpf: fix __jited_unpriv tag name
    https://git.kernel.org/bpf/bpf-next/c/cdd54fe98c00
  - [bpf-next,v2,2/4] selftests/bpf: make str_has_pfx return pointer past the prefix
    https://git.kernel.org/bpf/bpf-next/c/5160e584c361
  - [bpf-next,v2,3/4] selftests/bpf: impose global ordering for test decl_tags
    https://git.kernel.org/bpf/bpf-next/c/713db9fd0336
  - [bpf-next,v2,4/4] selftests/bpf: inline TEST_TAG constants in test_loader.c
    https://git.kernel.org/bpf/bpf-next/c/335a6ca04158

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


