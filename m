Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611715E5BB
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875866; cv=none; b=p6TfBnrx3ME1hW8oQyAUiDheV6mBN3lXbkTNlc5AEE1OzNEEDfOQzBPDmpzqwuaT3PMmn8bWyUp+qJf9nbONVsg8YL+F6ZAybcF+M83K5Aafw/s3GPkrkhhBhFb2s2Otk6uHOMJxmSlyrRb4MI32kuHfRGqYkXvSKRIVqBNe+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875866; c=relaxed/simple;
	bh=lf3fo43v9UcKM0d0pqv2mv6iGn8pQKg9L1AbMhqPrSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JG9HM4w6O+2dxT/BmGjlhzRKMSLorarA4MydHRenpdnW7VMgau3bAzc85qFVBR8tQ6L0DSoCJub2A0nECriR76wVvgkR8kjuOX/5DuJqmamZDcH9EhQbRNpN0z+7+BuoWp4B6UOGkxo+T6UKcq4ArLRyBWwwAo8QO42oD3KIaE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB1Rm6/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB1Rm6/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB201F00A3A;
	Fri, 28 Aug 2026 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787875864;
	bh=dho44LHU81Emvbf7G34Ltcg7dOcgHlvkfMbqp5Bv/vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mB1Rm6/st4Oy9mJeWlPIcXHCsbc9FUFKauBJvliFKsKQxFYhhrA30x4Z7Ex8NY+XN
	 j8r5vjuTBKtspv6uVwnOi9ZgVXLy8h4KsR37id+chnQk06frZpN4gTdlgI3MnVbF+I
	 RjDOrbUoZp+5WMW1a6zfvpvGdXAkq0OSh+VvQen3SMRV/XIrYt2j7Il/BLK5g9Gb1q
	 b1DNoiQDh2X7ZyR1eKDh+kzdkd8Jgx0OShBYc8t/QrflpFu72m6K4G5AwYGCn7JOYJ
	 0X8wtUs9NV7AeM0ZaxUa1pnjp/nWDQKnGuwsBOE/3Ml5ry+ejDBIKii92/6smq6EpB
	 kPn6W+xByhQdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197683809A8D;
	Fri, 28 Aug 2026 00:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 2/2] bpftool: Fix bypass of the batch line
 length
 check by comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178787580964.1904688.14666110875872426788.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 00:10:09 +0000
References: <20260824092657.1789956-3-chenyuan_fl@163.com>
In-Reply-To: <20260824092657.1789956-3-chenyuan_fl@163.com>
To: Yuan Chen <chenyuan_fl@163.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 andrii.nakryiko@gmail.com, chenyuan@kylinos.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 24 Aug 2026 17:26:57 +0800 you wrote:
> do_batch() strips trailing comments by truncating the line at '#'
> before checking whether fgets() filled the buffer. If a batch line
> longer than the buffer contains a '#' within the first
> sizeof(buf) - 1 bytes, the truncation makes strlen(buf) smaller and the
> line-length check is bypassed. The unread remainder of the line then
> stays in the file stream and is parsed and executed as a separate
> command on the next loop iteration.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,2/2] bpftool: Fix bypass of the batch line length check by comments
    https://git.kernel.org/bpf/bpf-next/c/ac3d88577cda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


