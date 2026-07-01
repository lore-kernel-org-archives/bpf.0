Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92364C77C5;
	Wed,  1 Jul 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930040; cv=none; b=N85/1lKfx/LhtM9/2yymgxRT7yvo4QXOcG/jv5XCFrCYVd20zGXLAem9h70oBJlxZ/2KEgLJ/KFAcxmgXzRDGf3J7JyIfKtXugSZin+rFAtMYPBgUWn8pcLXYaBzzL+qIwRyFYpof2FixUapcOuYPgrnMG1qO3TMrLd4L7Zk/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930040; c=relaxed/simple;
	bh=TOLHBFND6ppr68lJWaNCk+SEB2rlXO73mQeKsXmMgNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=njNpm3deWfMLb4uzjpQZyYVpfePU0reg+kGSyo6gMvhSoGDRrqmK9Yp9rbGGYKyhgxeXC78TjwTmrnMwdq66fRRAgmuKQruoL8FDtjvdfawcAGqq8V+iz9KSy83UXs0tbBF0VHWgeoIF2VQbmeZFvsgRdaatmWlJrOPFUDxURr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaVZDv/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaVZDv/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799E81F000E9;
	Wed,  1 Jul 2026 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930039;
	bh=Tqe1iKgcR9VnyzKFrUF243iApoSgQbbr//NwEAsy2YA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PaVZDv/C+MDveRIXjCiMjswfJ7upbLZf6+WMd9u7iTVAuYIhHkXi99Pm9AtTqedLe
	 kPo9qdf40mJDaPzBsx7xfvqbK9r32U+smcukIQ3EfL7qkBrnButDZ+LlP4uQlgmjFu
	 l13IGEXbZXEgMEmbsPplBcvh2iY8Ry+E77KF5T7OsQ6raVzd1aB6QxibWCjZuX4Grf
	 CU/9+K34nzvzpipgqgKRB790vMdZKHDzkbEpaQDg9JvMhNOw1Hjq6XvW3O2Ya8P445
	 DQ7ckH8JhCOo6NqiQkSMOULjYRpbrUWC6+pk094koEuTWHyCuG/qPT6jdm5CmIeTYE
	 /8Ko2njcF3WJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19872383B26F;
	Wed,  1 Jul 2026 18:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] tools/bpf/bpftool: Fix vmlinux BTF state cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293002265.1238008.17846374226094054785.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 18:20:22 +0000
References: 
 <12A35C14DA710D2E+20260624025055.1574875-1-chenyichong@uniontech.com>
In-Reply-To: 
 <12A35C14DA710D2E+20260624025055.1574875-1-chenyichong@uniontech.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: emil@etsalapatis.com, qmo@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 24 Jun 2026 10:50:53 +0800 you wrote:
> This series fixes stale vmlinux BTF state in bpftool batch mode.
> 
> Patch 1 resets the map command cached vmlinux BTF pointer when the
> command releases it, and avoids freeing the cached object from the
> map lookup path.
> 
> Patch 2 resets the struct_ops command cached vmlinux BTF pointer and
> dependent cached map info state after each struct_ops command.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] tools/bpf/bpftool: Reset vmlinux BTF after map commands
    https://git.kernel.org/bpf/bpf-next/c/66d7e39e49b0
  - [v4,2/2] tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
    https://git.kernel.org/bpf/bpf-next/c/f7f540e19751

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


