Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D123B42F1
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365039; cv=none; b=JNpEjHA2l736ijqM9om5aZWDvIG60xe+yrGYhNneI9KTYrAoHei+QYRKDnNbmaElCRujaHCZ2BCWNaK51UlyJtMjmCv7er1YDCEgQpF5ewkAD7SAckUl6JNOp5r0eg1ACt2ofXlrsTZi6VPSpbZKYWdK5XUm4A4dYNzie4CICgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365039; c=relaxed/simple;
	bh=7oZHl4myHf3DUscJnAQtx3SZPPTHpNpm+C6bpxBsX2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XHKwVmQzAx8LNmkQB+cyZLJuLXNksMAp1gnxUFkQ9+aHEfDYfkzxVFg38f0Gf5NzYPXUewL22LeA8/Io52pPLU7aCpVnbZYqk56KvgaAoruuqBtC9XID5SoCvletGPsrdZRMYDcHsU/axWL7FhA7O/18DeAVDTn3uYaouRxjNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQGuJAJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQGuJAJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD621F00A3A;
	Mon,  6 Jul 2026 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783365035;
	bh=usQ3/EMdVgXk+JVn0HYps1MYm5j33GI3fBZwjn4/QUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EQGuJAJKC3Jm2/4ICCYWHbYOqcDjUKHaSbJiszUwKpb93Nx3EkxpU+4OHKW4ITCIF
	 2yPfD7+g0LJkhc6+Tf4OTEWcnYVmAUBymz/MjXDyFHz6BKHo0TW09mGFbw3+c4O+By
	 8d6W1ToO5f5WfY8MW08qfbt58SDEg9Sm8f0PnjXuEBhF5gyMZ21/3YGPSfQdNY/Xhz
	 8bY1EC3dRymJ6qBZjDGmHW+0Bjt2f5gd6Cbat4dS6lB0i2v2aptFqftD0ITv/WZ9WS
	 nVDvZsqcXJpDsav9i1MqwyXR9UOiXzSDfw06F/B4gUx55qEQlue1juPzc81tT5cVI7
	 M908gr3uQrCcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0F3925F4E;
	Mon,  6 Jul 2026 19:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v3 0/6] selftests/bpf: libarena cleanup
 and
 bitmap struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178336501589.1168002.16838119661884881930.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 19:10:15 +0000
References: <20260706181730.21731-1-emil@etsalapatis.com>
In-Reply-To: <20260706181730.21731-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 song@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon,  6 Jul 2026 14:17:24 -0400 you wrote:
> Cleanup patches for libarena, along with a new bitmap data type that is
> in use by sched-ext. Patch 1 is an NFC that properly renames the buddy
> selftests for consistency. Patch 2 fixes the zero variable used in
> libarena for can_loop based looping, and afterwrds removes all bpf_for()
> instances from the code. Patch 3 fixes an (untriggered) edge case that
> could cause spurious selftest failures. Finally, patches 4 to 6
> introduce the bitmap data structure along with selftests.
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v3,1/6] selftests/bpf: libarena: Replace leftover st_ prefix with test_
    https://git.kernel.org/bpf/bpf-next/c/83a93e3b80bd
  - [RESEND,bpf-next,v3,2/6] selftests/bpf: libarena: Fix can-loop zero variable definition
    https://git.kernel.org/bpf/bpf-next/c/38ce1fcb3e33
  - [RESEND,bpf-next,v3,3/6] selftests/bpf: libarena: Clean up allocation state before buddy tests
    https://git.kernel.org/bpf/bpf-next/c/0cd6fdd7e85f
  - [RESEND,bpf-next,v3,4/6] selftests/bpf: Add arena-based bitmap data structure
    https://git.kernel.org/bpf/bpf-next/c/62406d9e6e67
  - [RESEND,bpf-next,v3,5/6] selftests/bpf: libarena: Add bitmap selftests
    https://git.kernel.org/bpf/bpf-next/c/7e6b29e8ec54
  - [RESEND,bpf-next,v3,6/6] selftests/bpf: libarena: Add parallel bitmap selftest
    https://git.kernel.org/bpf/bpf-next/c/015b8e873858

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


