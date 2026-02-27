Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4201C1F02
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236209; cv=none; b=rVrOYUwhk7isYjhqCZeAedFSNQUWdodV59eQHyTVQ6nhfOrHcotj88x8fPuDrhdt2cUE4Yu8eeJnWdzwpOGZrWO9GaMqycx+O2b7PpR3DVSXA0w2B+J9rZZl6ufekWztCk6ZMjjXTDQKqPlXspN8z54GEa3RXmsh48pa6epVe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236209; c=relaxed/simple;
	bh=h0dWeUylQ8IEHe9C7JXGQspQ+cdksfAr7GyVMt5K1D0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rcM8PqRBgBCsxJJbxDfDeedab8YQkTU4TDk+rs7FemaQlaQor2TS03+/kurlX3nqRPbVZmreqr7mv9qw1YlA+z7uu+I8JqJzKRti41U7qJgIkt1Qhaa7RC7YChrwYhHJMGzvk9OeDCyLCnP1MDD4fQoKLYO+0sFU+acIewQz0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbVca1qF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbVca1qF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62FEC116C6;
	Fri, 27 Feb 2026 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772236209;
	bh=h0dWeUylQ8IEHe9C7JXGQspQ+cdksfAr7GyVMt5K1D0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IbVca1qFVzEIhFDRxm6psq+ahwyYlmhB8m6plyUUirqiASrkiC6vqOMSUh98mIVsC
	 o6+MORjnbllZ7b6Fl9HVn3e3KzHEB1BRJgOEBNDIXl6U1G/ohlIV/muL0Si+H55ffW
	 126eRPS8/XjsZlvucAWrdwbr5snkP8bcuLRh4nDNSzWC9OXAQXaEJGVXNYQISPe+uh
	 vUE8u9wm1nG8y5BBNBQAmvoWFBzzI5TPa+/7VCt6CXyucxUNQPS+pff7Kzhb3TfrVT
	 7b0haCUS5hQ+KM9H1JMDZ+lX5Vib9jL/q/22JEpuknhfrV8TCCL2MZRCutRpvvVih/
	 QImo/KM+xzvZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F9939E961E;
	Fri, 27 Feb 2026 23:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/5] Close race in freeing special fields and map
 value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177223621254.2804531.2076027770272153815.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 23:50:12 +0000
References: <20260227224806.646888-1-memxor@gmail.com>
In-Reply-To: <20260227224806.646888-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yatsenko@meta.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Feb 2026 14:48:00 -0800 you wrote:
> There exists a race across various map types where the freeing of
> special fields (tw, timer, wq, kptr, etc.) can be done eagerly when a
> logical delete operation is done on a map value, such that the program
> which continues to have access to such a map value can recreate the
> fields and cause them to leak.
> 
> The set contains fixes for this case. It is a continuation of Mykyta's
> previous attempt in [0], but applies to all fields. A test is included
> which reproduces the bug reliably in absence of the fixes.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/5] bpf: Register dtor for freeing special fields
    https://git.kernel.org/bpf/bpf/c/1df97a7453ee
  - [bpf,v3,2/5] bpf: Lose const-ness of map in map_check_btf()
    https://git.kernel.org/bpf/bpf/c/ae51772b1e94
  - [bpf,v3,3/5] bpf: Delay freeing fields in local storage
    https://git.kernel.org/bpf/bpf/c/f41deee082dc
  - [bpf,v3,4/5] bpf: Retire rcu_trace_implies_rcu_gp() from local storage
    https://git.kernel.org/bpf/bpf/c/baa35b3cb6b6
  - [bpf,v3,5/5] selftests/bpf: Add tests for special fields races
    https://git.kernel.org/bpf/bpf/c/2939d7b3b0e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


