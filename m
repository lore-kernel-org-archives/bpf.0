Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D6250C1C;
	Wed,  5 Mar 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197601; cv=none; b=uG6nDswIF+/gmTmTClWCLP6Aeq01eiiU+8a/89Ibygk6hrHF35yB2jrFsqPILbUhLB5M3j2t+kDUJw2aF+ZbzppRFL1lfnLPjKb4WfChq7vlZ6buOjPvj9UAf0f1aSn6GlkGm/D32R5+zEfSjTwF/R7RiPr2H8UdtQ73zzRpV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197601; c=relaxed/simple;
	bh=RZp4U+jYLynv07h7676ER25Ev/Yq9pXQYjKGxCn7CVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cDAArSdvlYEc+iQ3Q7RLoOXf36DZfZ2YayXrcWKQkaxtAacR1CGLKC0MVV14P+SuVyYn37SUmElfaM5Mv3Zpd8js18CO67AEhZ92YtFKnCV3jkAmiFGMM8DbG14gy13/iMBtu/DmPzxLGpnSVdz9mHOw3QmDU+TF7ALsrHssyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIGufrcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIGufrcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A03BC4CED1;
	Wed,  5 Mar 2025 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741197601;
	bh=RZp4U+jYLynv07h7676ER25Ev/Yq9pXQYjKGxCn7CVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BIGufrcs//TMH4PTu3EkXj3cMUNNZsutpQiIVzX2HwCAHnm5gfV2FyIw4S5TpMnB3
	 88QEWwb1L/m1RZHXKSRYEZxkVfi8ZIaQnXg6DEQFKYbuZJYaml9HdWRFAbzL5NKNk/
	 eWxWLc05E9TMNcrqK6P6QjIhdb6cXMuj65M6zv45wfnpEYzEQieplL+2WBVgjmijyy
	 DRtcUsM1Ccm9bpLOu4wLJf+lXCPB3nxmbVTnF1twI2joVABXft2We0xgOWtsB+jmfh
	 n3lUrKHcEg1dk0/eXqVkO7BgNEXnBXX8/LqJ/PGh3DHS0PNsAE6huXZb2OMWB0keLH
	 +h8TX8rnhM0QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EE7380CEDD;
	Wed,  5 Mar 2025 18:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, docs: Fix broken link to renamed bpf_iter_task_vmas.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174119763411.970160.4101069434619256136.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 18:00:34 +0000
References: <20250304204520.201115-1-tjmercier@google.com>
In-Reply-To: <20250304204520.201115-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
 davemarchevsky@fb.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  4 Mar 2025 20:45:19 +0000 you wrote:
> This file was renamed from bpf_iter_task_vma.c.
> 
> Fixes: 45b38941c81f ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  Documentation/bpf/bpf_iterators.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpf, docs: Fix broken link to renamed bpf_iter_task_vmas.c
    https://git.kernel.org/bpf/bpf-next/c/7781fd0ddeb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


