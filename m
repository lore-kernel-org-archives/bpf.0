Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFA37EFF8;
	Sun, 14 Jun 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781479812; cv=none; b=OB1VogXt/CZfzaDNE6dzC/L2CmMNL/Hi2Mv5/1e2Z3c4dUIwYgWO5xmo/YEiB3YxeVdiEQu2UmdQyhMwcvB5cJ6CFVE+kX2TNC47MrCIS/qEoXGKlOxfDiD0c9Wcg1O0OygFSsQVcVDmB5dk4E6y/VehX3HDRuM/UE1bsQaAcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781479812; c=relaxed/simple;
	bh=qJba7MdJAbbWjqXizasTSC3R8OgkUlfb9UExjLdYoqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I+l4sFrR6yHnISXLuhHImA4c5c80zB7kDOR4VqJN2ljFH0BaSyKC9ahVMuGMsgXFgyLqShB1tmJLf6A1tMJ5WamaEYUWbuDVTsLQbFc9oToAm6cVCp44a54htc8kduV0eb+aORzxPC05HxF/qMIIatUHZ6R5brP3ZoULD2OONHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkDvCDE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkDvCDE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1241F000E9;
	Sun, 14 Jun 2026 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781479809;
	bh=/rbjK59HUTf0wE3NhmbrJC+irGOkjOo/XNW6yQgv5do=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lkDvCDE6RMD8G5/LvLDstEOtWKW3qYZnvDKAkirS3ZRQ1e4DjIJMv+wIsrCVftQu/
	 SwwQOt7+n2s8FVoYyGBqEeS/iZIdtX/oboGnZhsjS508f5JwhOciNbONguC52q8Cpi
	 TyE+T70fzf7tCLi7Q/G/sEwSJCaiCjfhKsjxSNc8pvGk4VefKGdmGVkoI6/u2sSc/z
	 +chmkkiAnRJeHB2OLlp2rtimjFLmoSiHq9JonTMlZLHviDpRx2D27jH61dQkceOwAK
	 VNpuY72kcyOXNPgItk5csB+PITWpppuyfnwe4HcV3elu7Mi3hAJVTV73AopQ9Yx975
	 NvLyIURINvuPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BD53A566CC;
	Sun, 14 Jun 2026 23:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] arm64: mm: Remove misleading pte_none() comment
 from
 ptep_try_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178147980539.2349009.4002197585422309428.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jun 2026 23:30:05 +0000
References: <20260614210209.2371030-1-tj@kernel.org>
In-Reply-To: <20260614210209.2371030-1-tj@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 memxor@gmail.com, akpm@linux-foundation.org, david@kernel.org,
 rppt@kernel.org, arighi@nvidia.com, emil@etsalapatis.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 14 Jun 2026 11:02:09 -1000 you wrote:
> This comment was thoughtlessly copied from the x86 version and doesn't
> apply to arm64. Remove it.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [bpf-next] arm64: mm: Remove misleading pte_none() comment from ptep_try_set()
    https://git.kernel.org/bpf/bpf-next/c/16deef8de06e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


