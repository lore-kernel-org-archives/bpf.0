Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F54DEC0C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679017; cv=none; b=BmRZBccyDK3X1ZCAnNajBa7Nz42epXQHXT3FnfJFVT7ZLOlJzkcLms+Old6NeVPYEnJSpb2q1bBI1XCji8bXhShzfESCD08qU9NTfmkRF5hPyrhaIMiF6E46seAJGPxstKlY9LP9IJ5Gx2Xrp/miIhPbqzVe7UQd69iQ7xuKpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679017; c=relaxed/simple;
	bh=k5ZhP3FzRyoVHeZjRYJAgKpRGe3swyWFYCy0tsQs3Jo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jvX58qZH/0ocbvYnJ1p6PkEgkbi7Khn42JdPJs8jIr0MlztYMMMM/+MXWcK8j2883l3EH7bHrSiApFoWYOCKZZYRY0VZoBpiMYtTsD/tIZHaV4k8jG+PbdH5ZF5ZoBToCG7xJ9kEs61ETBbPIBHwXGZqQs40fOypoFwutZupyZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdEW6el+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdEW6el+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E281F000FF;
	Tue, 29 Sep 2026 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790679011;
	bh=znu/dYVmGYyvNv5yqqVRVq4FS1r66GeHcZcc2rR4dIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JdEW6el+wwtXLq+/l5uRcdhLnax0u6dkxlZTmsYKE03ZpGHWXMeORQhvpO4z8D/Sz
	 tyUUtVoKxpM/oLmdzpAAon+hPEMzlHnAVR9VpEcUxXzDkxdG/fbEjfTPKizdEPH5JG
	 LUSMI1kGjiCpM6hpzW2CVgRLlVknWhwnrEOEw41xEA/P8Oylx8LwlN4oBOrfAkRTAw
	 zrzjO4t+zYhsk2b8s4PVUV3zMi+ey7LGdAyu7z7IthNkQFAuRA3VW0eYx2PJET3TzD
	 /Jd+wABaLShbHdk3+h9Pdjnba73feDeyjqlEm4dLNhOEwlwM3FYT3APaqh3LqSpOab
	 wQvzMUqeMxXeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E639263B1;
	Tue, 29 Sep 2026 10:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/3] BTF inline functionality followups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067901003.426683.12732875294825624275.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 10:50:10 +0000
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
In-Reply-To: <20260926175113.2368566-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 26 Sep 2026 18:51:10 +0100 you wrote:
> Include additional vlen/flags verification for BTF_KIND_LOC_PARAM
> (patch 1), and add function signatures to LOCSEC entries (patch 2),
> adjusting test to cover these (patch 3).
> 
> Changes since v2 [1]
> 
> - Improved flag/vlen verification to check combinations (Alexei,
>   patch 1)
> - Simplified overrun ellipsis printing (Quentin, patch 2)
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/3] bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
    https://git.kernel.org/bpf/bpf-next/c/a3df11403e8c
  - [v3,bpf-next,2/3] bpftool: Update func representation to include function signature
    https://git.kernel.org/bpf/bpf-next/c/29f6453491f3
  - [v3,bpf-next,3/3] selftests/bpf: Fix up bpftool btf dump test for signatures
    https://git.kernel.org/bpf/bpf-next/c/3cc62f77b974

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


