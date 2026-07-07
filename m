Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D8371CE3;
	Tue,  7 Jul 2026 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449028; cv=none; b=Hn3wb4TbXX522t/gvY8uuM9S5+TCXIGMzShab/GCBdt092fx2Q666enuC3uMNlWOirft34GAvYn419KFVhJKhM/DMa2mAE2bpcVSUerit0cYu9Tz3mxU2NdCFHtjPPhjRTgiihmehM6dBHJf5jbo2tFYOnujXVSABfD4NIhJsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449028; c=relaxed/simple;
	bh=6u/2hvYXlsazTSamhG1nUn0J1c4mJuOxrTR3AawE3BY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RBmA5U8D0Z0wnakiUpEjW1X1pulGKsyVMAsEO5R2OUE+8/rlC9HAUD+wK1lwWMuN32qXik+qEei5ghKndU0Wmo0bcgpoMIJ3lzXf/VXto8OXPMLUEL90Ry1k7iYdqS8kd3/7MuwCs48r9XBsh47Z17uf1X9UroniImM4pVXeeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzlOYGQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzlOYGQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AEA1F000E9;
	Tue,  7 Jul 2026 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783449026;
	bh=MfN8TzBQDAGt/UbCPt2yj1D5Wyc4T9eOTCCMpMK9T7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jzlOYGQ97gxsBtfT7nVVfcfBKxfj8QQ5WNkPnPOwWpf5+4hq+/hL2081/nnECmqjS
	 Ki//2MRyTyMmmVaXgVCCK8cv/g1uhJ/Xy0GVaNrkICSpN5G6F95BYjdIGXAyzLhII1
	 kCXqXcmneAg7LTrAQZEB/ib5YRE1EOhotYnr7r6nj63mman9nMsASMkVvr4SPtNx6f
	 aq/mHm/iCLRu4FdKJAr/IqMKshHS16MaXGIXZLt7YDdq/xyDiQtl5YUY5GNjzxmvTF
	 i/QXO+3rUbOkYvLh5pjXODp2Z5cgZ//bex6mW3zGsQbZFJsZa8TlAlqTYTw6EKlqd8
	 K140YtA1Ur6Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569EA39253F9;
	Tue,  7 Jul 2026 18:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix memory leak in msg_alloc_iov
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178344900589.2120119.14450071034049445005.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 18:30:05 +0000
References: <20260707081434.539327-1-yangfeng59949@163.com>
In-Reply-To: <20260707081434.539327-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue,  7 Jul 2026 16:14:34 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> In the msg_alloc_iov function, the iov pointer is only assigned to
> msg->msg_iov after all memory allocations complete successfully.
> Therefore, when a calloc failure triggers the unwind_iov cleanup branch,
> we should use the local variable iov instead of msg->msg_iov.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix memory leak in msg_alloc_iov
    https://git.kernel.org/bpf/bpf-next/c/f425a0443b7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


