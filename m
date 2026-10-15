Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11F3D4129;
	Thu, 15 Oct 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051807; cv=none; b=GIcxn9xBrd7jFQCn8lLeJIt45jVLIKZ+uN2ExF3nrYFznT0ag1AoQPZtLCmtdbOxx1wNDH6nmHBwwosiqxO1lBuAVH0CFNiBQkH0N40O6lYD3fHg6H5USL/bMPjGUBRBfp9OafB1sl8X3kyUDv5c5dGBB9Qyi3pCFeJEpUL/hvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051807; c=relaxed/simple;
	bh=1nJ7JqAp/hjJCBrhsZfLL6LP1UpxTz7irnB2XFyIgys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GPzGB1/S8gpLafXozcW+8EllQ2tuOOQtMk0A9v1tj9h1yvFpqZX0iRNt3ftrXIrYwVAiYRPiBdUpORJRXHrf5kAJjDVEqK2sjJWkTjgU/ooCLpj5XLRyonQB7pOZXg+e5mS55xLSlapRX09GBmcw0RvUcUfNy4IX6cWhD+XTtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqwhqnsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqwhqnsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EEC1F000C4;
	Thu, 15 Oct 2026 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051806;
	bh=e8lzYLVpnRWmRqsq7Q3LYeLB9N234ALYisZYgKg3Sh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NqwhqnsI4BbXw30pheLSw0gQHz446F1hGJ1NTjcef3dia9lEicaxZRVpdNCN8yzqW
	 YBFj3jqGUt25cnOGznT61bEqnOskYM2by2Nnao/Atha4iU6g4MyySV8NbtfLXDHizp
	 57yHw+6Nz8j8faGvZ7gZx7LeWXwpVlXvrpkAaQ/TvQFW2UuQPEd07yoZKiAqLJc89r
	 R8pM2FgTe7+lWRQIj23eZgdmp9BDlGVS2XulNGgn8Vrq/8sAVeE/xn9Qtb3sTIvdMn
	 PDs09mCap5qBXA68YbInP32oera3QhUIyQK4+OInlrIzuZILONMYj0m7GOCJiM+k/t
	 0ziUQ/kfk/NWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A358392E9D9;
	Thu, 15 Oct 2026 08:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Report a failure to register the
 session key in test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205180479.3264110.5124083722824998872.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 08:10:04 +0000
References: 
 <20261008-selftests-bpf-test-progs-session-key-v1-1-ec48e793639b@gmail.com>
In-Reply-To: 
 <20261008-selftests-bpf-test-progs-session-key-v1-1-ec48e793639b@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, kpsingh@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 08 Oct 2026 22:03:25 +0800 you wrote:
> test_progs adds the key that verifies signed programs to the session
> keyring before it runs any test, and exits when that fails.
> 
> It exits with 255 without printing anything. pam_keyinit revokes the
> session keyring on logout, so a test_progs started in the background
> from an ssh session that has been closed since leaves nothing but an
> empty log behind, with no hint of what went wrong.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Report a failure to register the session key in test_progs
    https://git.kernel.org/bpf/bpf-next/c/66fd5eb9da12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


