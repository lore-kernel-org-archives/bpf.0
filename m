Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8F221F1F
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526032; cv=none; b=MQl/BBxul2DT4vyL4OojoDv2wBKaLu1jAfHyixMszbytwFmG56MIFxaG+QmpZ8Hn85QRxHHwHs+b/+R2ARmtz5zIVFWPCggDGlsUO6iytZScbsjnliejT3dI92mxcPjt7EvLXS8HaZAgSR1abWLVsYVnryLE/HEhPdo+VcWEgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526032; c=relaxed/simple;
	bh=95OSM4nXvZL9C1DKKeg6FygZhZkjPDtZMeS9FPfcRck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uzV6neDdBd9QoNsXxegUcCVJifJUZ7fcuavFeLubQI4UZpwwWqQs3hKXMVJnFAlmEcOo3JbPfhtu7Gxf9vY5DPZr2gghWf0doxIlbpHugqpchnOJQwyDoFLc4XgTSvQHNbEWSdhRRcx+2WdU0H2PXLTiPb+PzHpTHJW+HmqFscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYywYoX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYywYoX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F16C4CEF7;
	Tue,  7 Apr 2026 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526031;
	bh=95OSM4nXvZL9C1DKKeg6FygZhZkjPDtZMeS9FPfcRck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IYywYoX5o7f/dlD5bO+HYMLlrWhDaNn9MHCqLsMlTwcQ8FtusblCkUZrKccoTjPc2
	 Iu8JptRvZIJEbsTYoPS9neXtQrGd5wZVJ9gvVBIcpUM+rngVyssV+FMTWuvWOKCDNB
	 dysa1U/JNdeNpq4uFeTMk/NoN+ZNFC0tLkMpcBN2J+lMMAUL9LGYfs03bV4xOSn5E4
	 nblgTA2pW3KSPvF0YE2UcWHlgeXTYjzolN1FseD05qx4JpBYvbf69BrcO1r/zd8eDF
	 7zprQ1fFaingKnDvLoVPfy2cpCk8YFzy3X1biMIVV8qSORg21QftVkhb8XIgsEa9l+
	 J/YOM4icPgoyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400103809A28;
	Tue,  7 Apr 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/2] Properly load values from insn_arays with
 non-zero offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552601005.3334922.16545303514959582708.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:40:10 +0000
References: <20260406160141.36943-1-a.s.protopopov@gmail.com>
In-Reply-To: <20260406160141.36943-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, ksur673@gmail.com,
 mykyta.yatsenko5@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  6 Apr 2026 16:01:39 +0000 you wrote:
> The PTR_TO_INSN is always loaded via BPF_LDX_MEM instruction.
> However, the verifier doesn't properly verify such loads when the
> offset is not zero. Fix this and extend selftests with more scenarios.
> 
> v2 -> v3:
>   * Add a C-level selftest which triggers a load with nonzero offset (Alexei)
>   * Rephrase commit messages a bit
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] bpf: Do not ignore offsets for loads from insn_arrays
    https://git.kernel.org/bpf/bpf-next/c/43cd9d9520e6
  - [v3,bpf-next,2/2] selftests/bpf: Add more tests for loading insn arrays with offsets
    https://git.kernel.org/bpf/bpf-next/c/1c2e217ad349

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


