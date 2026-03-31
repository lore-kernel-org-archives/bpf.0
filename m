Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A603321AA;
	Tue, 31 Mar 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997424; cv=none; b=bsgGmjB0MHzPDVAiQPN18jFi5yQkQuBd1Wcbu8++1dJLHxkb3zlRMYULpGYac2nglfQrFWGeSqHpiUPiJ8nq32Sl4aRqoftWe1jZrtiK6JKORkLK/VBO+ll7SpAZtN11a7dOjy+M7hEvXpDM+LMnFjQzMFcYNtECV88aRq7w3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997424; c=relaxed/simple;
	bh=5UtSxWZRYA/l9uOow5gvzjnZ2tldcTpobUpm2kuEeSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A1zanS6K8DpA4cCqmn+z2Ec5H5u9UaVr28LdtsPkta0FBeve7dYItBtcHjUtn1oAq2P0vT3JwT0+SXxEnVMmzxrmXFeN9oUritIngnm8vniZYNT8gnRSorean2qGeVNu+Rbnx1EFRHRJ7YuNVnFerUd7hET/D8qKbxVaDteWzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3y9mAjO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3y9mAjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CE6C19423;
	Tue, 31 Mar 2026 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774997423;
	bh=5UtSxWZRYA/l9uOow5gvzjnZ2tldcTpobUpm2kuEeSw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G3y9mAjO9K+07bTDoe80h6Ju+eqm/zLuRCivcOL/Y9whvVOnsV/BvmfPSW6NPsebt
	 ZUg15GhQmfgJ/qUaNlfIBlobj0iVE0m/VH36SrINxU2NgYjKQoaQaRQPDdnm5UItdl
	 BeBnOtevFwjPO9b6ijhsPbeeiE1qkU/T0T+q3cBRvncJ7SbmdK9G8wBH0o6oVGQraI
	 Y7vIrx0/ickdcktnRPoc/xIN416sAt1/i8w8WOn300C01r/tLIbfRwmUSBfSRY4et/
	 qrw7QLSu2wG5aKzq2sBzHmQKad7Jb8EjfDIUBrW+rHRPjrVkz1+ekWPb3Xh6yvLuLT
	 SlwMmbtRH5w0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE4B3808203;
	Tue, 31 Mar 2026 22:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next,v2] bpf: clarify BPF_RB_NO_WAKEUP behavior for
 bpf_ringbuf_discard()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177499740679.2977813.7335235373687761125.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 22:50:06 +0000
References: <20260331130612.3762433-1-eyal.birger@gmail.com>
In-Reply-To: <20260331130612.3762433-1-eyal.birger@gmail.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, paul.chaignon@gmail.com,
 chen.dylane@linux.dev, kpsingh@kernel.org, a.s.protopopov@gmail.com,
 yatsenko@meta.com, ameryhung@gmail.com, tklauser@distanz.ch,
 shmulik.ladkani@gmail.com, puranjay@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 31 Mar 2026 06:06:12 -0700 you wrote:
> Clarify bpf_ringbuf_discard() documentation for BPF_RB_NO_WAKEUP.
> 
> Discarded ring buffer records are still left in the ring buffer and are
> only skipped when user space consumes them. This can matter when
> BPF_RB_NO_WAKEUP is used: a later submit relying on adaptive wakeup
> might not wake the consumer, because the discarded record still needs to
> be consumed first.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: clarify BPF_RB_NO_WAKEUP behavior for bpf_ringbuf_discard()
    https://git.kernel.org/bpf/bpf-next/c/f9a80c7ce49e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


