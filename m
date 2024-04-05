Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54A171E62
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338829; cv=none; b=DUPgr6mIc3mqcSTGiVrIcOarPLW7WQqWf6IhYQzgHKmiEHvIo2zu9q8MuufGcrOl2opxL6w7O8T8Psl37fSRV8TzIOMFF1eGLosk6eit4cHTYOFBwI5iGMyeCatHkCmrtfRZbSAiLvuLfl1Zmd5Y/LU7uvoWCW0LLlHsea0ds5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338829; c=relaxed/simple;
	bh=4sFxt79hKjG7dhiKcgFycWfyXq5/IaZzTdx5N90HHw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TqXfnB/Gp/qAsH2s34ZvdMVANGX6SK4vg/gXF6Cdfs1/3rQgVUXAp5s3LMwqK9UE+kIZ3PcP+Napa+4mtJOIaxQ4XH8wD+trim8tuEzD9kQr5v2c1GaRKxMtC+evaDg8/jM4uYpnZ4may8Tgdnf5ho0LXKA/NqZH/rXHTwYuiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF2f/MXU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF2f/MXU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52C14C43601;
	Fri,  5 Apr 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338829;
	bh=4sFxt79hKjG7dhiKcgFycWfyXq5/IaZzTdx5N90HHw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AF2f/MXUWgKv/QWlo+FmIFYAEILCiSpntqHxo5fytLVXRlwE8BkcrVwirtaGCSokp
	 ekrbsl9OAnfUgDEqkkN5Ti3K2KcnEImIwiMqB69Rvx78jJ7wItp1EQoPXr4pY15kXB
	 OWHqwNWfxWvvpPHFChKtw79Xl0PyVBr/bsoBQvn0rgBkJw+5XQr1BKBdP0d2FqQdKo
	 FW0wB8WRpxDkA3FEm/E5YT87u3K7ypZY+ed5JeqCi5Ej+HSrKXg0UQpWaIzkhWtHfb
	 0PLKdcTSoNqkhWJl5zqCEPIopy8155q04VCYoxViDZDDWM8ETfxzBW4VyuewFv2Y5z
	 27W7qeN69pslw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 443E6D8BCE4;
	Fri,  5 Apr 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Make sure libbpf doesn't enforce
 the signature of a func pointer.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171233882927.27871.5401916900839509718.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 17:40:29 +0000
References: <20240404232342.991414-1-thinker.li@gmail.com>
In-Reply-To: <20240404232342.991414-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 john.fastabend@gmail.com, sinquersw@gmail.com, kuifeng@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  4 Apr 2024 16:23:42 -0700 you wrote:
> The verifier in the kernel ensures that the struct_ops operators behave
> correctly by checking that they access parameters and context
> appropriately. The verifier will approve a program as long as it correctly
> accesses the context/parameters, regardless of its function signature. In
> contrast, libbpf should not verify the signature of function pointers and
> functions to enable flexibility in loading various implementations of an
> operator even if the signature of the function pointer does not match those
> in the implementations or the kernel.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Make sure libbpf doesn't enforce the signature of a func pointer.
    https://git.kernel.org/bpf/bpf-next/c/ba0cbe2bb4ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


