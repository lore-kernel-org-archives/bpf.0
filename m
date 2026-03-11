Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9043E6DC2;
	Wed, 11 Mar 2026 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253210; cv=none; b=kKmipsyhbPsozcQZxXaQcgif0+EaJo+vKWkcT4LmlpOgibzLhQYj9QmaaUWN+r27MCS/u9NYlsfAoEXul4Ep0j8ooY9G1FQiD/C4CFdyM6fERFKzoVED2qwodV14an8nFGJC4UANFUdqDHxEahaVfh6SqQfYypHnXrcpZRiIZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253210; c=relaxed/simple;
	bh=DaSduLqxZiXdsFIRRUAZC5SKDODNKUet4IE0LsHv4uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ur8ldo3isNw03Tz/zc/H9s78MLdz5wbDwkucT1D72QFZ4baYoJyXEm0ebP2ccI6qGLvi5A+AzTLPJjAgzL+yb9SsDpM6QeJ0DG+Zn9GrkBtedw+2tjR/TyqJ74Y/iZk8tUKepDHFXcKdNO0cYrY2HJauue3XrvK/2ZKrhc8JywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElbHVzjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElbHVzjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC23C4CEF7;
	Wed, 11 Mar 2026 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773253210;
	bh=DaSduLqxZiXdsFIRRUAZC5SKDODNKUet4IE0LsHv4uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ElbHVzjGRAMtftyPhr3sal80Yia7wuCiVFKZbcMx6+Kr8HTfRLA+T0pdGtjFtSc0F
	 6KKLBhygR+Kad2WGpaB/jWWyqeeIH5qP8UVDUffcQFZnf0QYkm4vfN1qSab8E9XQWl
	 Eb18W3jBRSfsB8IQ9ESdlsgZqTt1AmjgYJnzOV0CYXuIe7TE456uOUThJWKAOYRBgb
	 mauJZmIfn9w0tZOlXK3O706JDVjYh6DDZJPCKDcLpjvM+sHKO8raiI+zAZx9xYLWqz
	 +YNsywaM8MrpY0XiMbeHTzXiwsQH1r7SGujxrul0Xx4LCyWgXyByg0RUrFP6F5B3s/
	 6tFUJIKcKx/Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FED03808200;
	Wed, 11 Mar 2026 18:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix const qualifier warning in
 fexit_bpf2bpf.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177325320607.3779062.5511337420258180281.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 18:20:06 +0000
References: <20260305222132.470700-1-varunrmallya@gmail.com>
In-Reply-To: <20260305222132.470700-1-varunrmallya@gmail.com>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, toke@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, song@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Mar 2026 03:51:32 +0530 you wrote:
> Building selftests with
> clang 23.0.0 (6fae863eba8a72cdd82f37e7111a46a70be525e0) triggers
> the following error:
> 
>   tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:117:12:
>   error: assigning to 'char *' from 'const char *' discards qualifiers
>   [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix const qualifier warning in fexit_bpf2bpf.c
    https://git.kernel.org/bpf/bpf-next/c/ca0f39a369c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


