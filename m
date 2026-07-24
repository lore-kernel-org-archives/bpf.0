Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A5380FF5;
	Fri, 24 Jul 2026 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928828; cv=none; b=fcnAtJdd7U4dYn/g+nlYncYB7/Yg2R2pT3figwODHjAlNVTs0NQ36QPbZGBFRa52cUJNd+Od9ZIvLKSVxMzNYcw4C9IBqWG61kq4x0SO1qSWOGPpJsTThVimS9KhD/qX2InauU2OBfBKKUP44UMWroGMNlbHG+j4sxuprGLYfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928828; c=relaxed/simple;
	bh=CbRXQuRR+arCZi/csc09MOw9Ae+OTA2AcgoaNCY+o8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i2nPVmuafkPJNcO4Pv59w12zQBoIN3eXWeApSAERn16TiCbZaAGOmzsPVCU3jdXu54tFuBIj4qBY1YqfIeen3RZuLrB3yfqwLiq/GHWtvG7cxqALNi3zk3hesYCLznNjIlzDWwMAGf8TcsZmc7pYU9hYvFF2ZFvEMBJyjV4Y1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIW69292; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIW69292"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732EE1F000E9;
	Fri, 24 Jul 2026 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784928826;
	bh=2MAjy3sRqglktAMb9kLeD58RV0s6NOxHFAcD1dDrH3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lIW69292V6XWCO1EmdWjQsOE3XWpau3LHf+FpZmas09nVZlgsz6FX4/+OH8OACXg2
	 7JHMU/V2+L14lpJojlt+QZWh2Sol7fzTJER9XnsVDB3QjSxn1wd91cCKov0wj9ZBJK
	 J1rAe1rcfZDgo7nOjDjs+9vbp+mMXvYgJ39DcpBjGf7yD1N9WEh1utRvgjWD+axdeJ
	 nHvW9xADCZZTl/+kKu2jLY5V5LiTJ/nk3QvaFmxNpjU43doq7zz05pn4cByJZ+jRw7
	 /21zoLCP4tgQ6KZ7xezGjHCJT/mb1o3/l/h1oTBLQL3+lZ0HU7usmrCE2azxOyClPF
	 fa7p/cNNkf0IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B9A38111D7;
	Fri, 24 Jul 2026 21:33:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/5] Fix several issues in test_progs.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178492879339.3315717.9218051815031997167.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 21:33:13 +0000
References: <20260722074748.674080-1-yangfeng59949@163.com>
In-Reply-To: <20260722074748.674080-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 22 Jul 2026 15:47:43 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Fix several issues in test_progs.c
> 
> v2: Fix several issues raised by sashiko-bot
> 
> v1: https://lore.kernel.org/all/20260721094404.593127-1-yangfeng59949@163.com/
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/5] selftests/bpf: Fix double free of subtest_state->name
    https://git.kernel.org/bpf/bpf-next/c/791841e038c4
  - [v2,bpf-next,2/5] selftests/bpf: Fix missing allocation null checks in test_progs.c
    (no matching commit)
  - [v2,bpf-next,3/5] selftests/bpf: Use calloc to allocate subtest_states
    (no matching commit)
  - [v2,bpf-next,4/5] selftests/bpf: Fix memory leak on subtest_states reallocation
    https://git.kernel.org/bpf/bpf-next/c/06efb01c6530
  - [v2,bpf-next,5/5] selftests/bpf: Fix potential NULL pointer dereference in strscpy call
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


