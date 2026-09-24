Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEF2F60CC;
	Thu, 24 Sep 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286677; cv=none; b=QheM/+e1svce44fU//qVKEF5chvppAeapbJSKBQbGVZpAeGo1CPfRxfdSfxEzZDSoR5zPiMtxG1Ee9sWPQmaQtYCJz9WAC6+KDfzp0Vqw+23fS8I1zHmoSNqusZkrNYRR7N4aOCF35k1N+3H68xh4/pyupAWy84+VGsMocxWUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286677; c=relaxed/simple;
	bh=D9mz1nMlN8VAd8fi690SgYq5tdkLuuBA64uSjuIVShk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OrCmGdyeJuJM2jmFhg+hKK5E251lUqIwhKTFHsewWGzUV60pkmzcH73CET89GHZlkpQtaiT8hyJt1Ui7ZWBzzz/NVFY/HN6L4PcGxSkzHRjnde2b3Qs1prgGq+39xhwXr9ByidSqJ+2CUG98nwoj7AN6jrWfZJCiugcWi7m6rnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLiY0kyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLiY0kyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD0D1F000FF;
	Thu, 24 Sep 2026 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790286676;
	bh=+cPtGNovbKnNVgecFKbOU1WPKhVL+fqBGP0y91NqE1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cLiY0kyUzsMXjMnvdYs050Yjw0BHqio6IaJqFp4miGQYhwQMRLBWfodpiyvhO1yjD
	 OVFGEDO+Np6fRgHghRy5fy+cUb7WzJRNnrKPkPG553ThzyhFu5gdsKwU/wzhomItcY
	 SzXip3fCdR4z8n9EDzhmrmE83mwkjzNCBZcxPQitlM9w0Dayz6++f5/oHLb5NplNVj
	 7L1IxzgPyBy/EipL1naLyYyirLdvc0jikpkqxr2I/x2Fn8FUTmJaYbkPP4C7ukRpdB
	 LdR56MxB4dyMukPVvxDczxcV5Sj9M4bqJqwvtGmdUpTtta6AO798tbOGQbMR+FEE5L
	 I2HmBawWc1W2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD03A566EC;
	Thu, 24 Sep 2026 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] riscv,
 bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028660516.2215629.2749041219653206416.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 21:50:05 +0000
References: <20260923144216.934701-1-pulehui@huaweicloud.com>
In-Reply-To: <20260923144216.934701-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
 pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Sep 2026 14:42:16 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When CFI is enabled, the actual BPF program entry point is shifted
> forward by a CFI preamble. During bpf_jit_free(), this shifted pointer
> causes the wrong ro_header to be fetched, leading to a potential invalid
> memory free.
> 
> [...]

Here is the summary with links:
  - [bpf-next] riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
    https://git.kernel.org/bpf/bpf-next/c/93df8ae3267f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


