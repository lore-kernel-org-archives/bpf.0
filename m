Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8C36998B
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367432; cv=none; b=d6GZn66vAvXlAvAjYVivDX5Dc6300agB9PqJsa1Y8SOC7JCBdhyqHe1iKjiviqQNvBFbAAlD0hAoTmuvI0Ibmui51XcxxdeNlh5uIaFjY8IDZ+an2mLCG1V8X0iIk3BdzlAq4cazi0dg3uOtCtXhL8wJqXGAf7UHzm5CPKGfa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367432; c=relaxed/simple;
	bh=GwOQfHB5FU6xnIHc0U7QAc/Wf/+2NibPkKr/SNo7WJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=smEF3oJ+DJLk69VG+J10UT94KFmXvC6AVzyRIVle+6tfA9P84x9Rrl0PQgV3GYST7LKWLujduujHmNYrMHCWPBA4M4xe+Lz79+Hf/mN4WS83gBxPfuJ4RyMJwt5CquKETgjfLfKpGeBiRJHktSa8KxUZJD/MPkdGvBGIDub3Dsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHv+cRLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHv+cRLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3435C19424;
	Tue, 24 Mar 2026 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367431;
	bh=GwOQfHB5FU6xnIHc0U7QAc/Wf/+2NibPkKr/SNo7WJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oHv+cRLmripgooi+vVNcttZWnpjF1+o4GNY+E4bmEcDwhI4V+NHjbqkbcNAPYTEu1
	 eyZZOzfI8SfQCFS+4ZlkBSlZZ+jnar45m/31kxTIm9WD0yQg2RsP41sGWAKtouHSkK
	 hrkuvsRxM43Y5muQIDoQxffPOnxhIpSimivohumtiKW7OG9I4hwCZZInh2klz3TTbJ
	 vUvvLEBuBqS0ullTM0lUmWGSKqRxYCHhethi0ErubZhB1tTfJba6tFj2ggKna2ELru
	 FS5cJrcJSrFJ86e7y0gPOAEve2/Lp3x0vBnXzmjj+PqVJqxN1JVYne9gIcwnlMbDWw
	 JhQadWC1VWANQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E833808203;
	Tue, 24 Mar 2026 15:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpftool: Enable aarch64 ISA extensions for
 JIT
 disassembly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436741929.1084685.16278655162855571093.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 15:50:19 +0000
References: <20260318172259.2882792-1-puranjay@kernel.org>
In-Reply-To: <20260318172259.2882792-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 qmo@kernel.org, kernel-team@meta.com, yonghong.song@linux.dev,
 leon.hwang@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Mar 2026 10:22:57 -0700 you wrote:
> The LLVM disassembler needs ISA extension features enabled to correctly
> decode instructions from those extensions. On aarch64, without these
> features, instructions like LSE atomics (e.g. ldaddal) are silently
> decoded as incorrect instructions and disassembly is truncated.
> 
> Use LLVMCreateDisasmCPUFeatures() with "+all" features for aarch64
> targets so that the disassembler can handle any instruction the kernel
> JIT might emit.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpftool: Enable aarch64 ISA extensions for JIT disassembly
    https://git.kernel.org/bpf/bpf-next/c/4ea43a435505

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


