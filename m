Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3418FDBD
	for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769302811; cv=none; b=JYiJbOP7r2h8DCh1rXpBOYPVV9617KrDUgdxJupsiVeMH+Z5sxN32fLjjc/IK4FPqtRZyWEOTdVVp9E+OyyXOxHWpQBhndeHk909lmyUwSqR7oIYNwyyYEM/7DH6QF7OxQFJ/JldwefeKwrXb6ZrohkbHArccI7AKj2UuStACvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769302811; c=relaxed/simple;
	bh=J8PEmthmW4BLtac/HXwGmwn0LuF1I+7EnikWN62CmGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K2M5p5lgEoPIxExtjGLc3f/mi73VJnhiFK6Ee42RHoKCwcpmrkaL58+J8OA8zK2bTFPCQ7Wpzl6/oAQEPfwMdzEcV5dJn6LDfPCw8+UZrSaqdYSSQRifdj3iG+OveQCAtxTFnRqBstc4Ba/nue+cBweaj/1JDS1sNYE2q7dO7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0LkFww6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0LkFww6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538E1C116D0;
	Sun, 25 Jan 2026 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769302811;
	bh=J8PEmthmW4BLtac/HXwGmwn0LuF1I+7EnikWN62CmGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0LkFww6j4r0iuE9uHY/v+Q6mlr3Md2usrUPX/gNieCdHV/26FuG4rO59UOzRxKFz
	 qQt/2YqAGDM/r/68SNqqpiZ+WZ7AnY8vbC3541EB7uhPWv48u2Ime5H8qeWtoMLmCD
	 1toCaGNmIAL4Btsa7udYPNlPiwI34nZNk9vfCxdS0ifLfBqP0wNTt0AlCp4kjBTU3c
	 7IL7kZ4ttmjBLLGDdAQTUCszCErT2xPUtqNvIUk/TcHCnBf9c0VrW2tJeumWNh5Pxv
	 gNMfzeqwygra1wSCBeKbvphLb3RTkpEjfVjvE4tNhl5VrHy0Lh2loTIpdpWWiNxvlY
	 WJrcm1ZveR8dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B4B3809A00;
	Sun, 25 Jan 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] selftests/bpf: Fix task_local_data
 failure
 with 64K page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176930280636.3404204.10420557260901762684.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 01:00:06 +0000
References: <20260123055122.494352-1-yonghong.song@linux.dev>
In-Reply-To: <20260123055122.494352-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 alan.maguire@oracle.com, ameryhung@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Jan 2026 21:51:22 -0800 you wrote:
> On arm64 systems with 64K pages, the selftest task_local_data has the following
> failures:
>   ...
>   test_task_local_data_basic:PASS:tld_create_key 0 nsec
>   test_task_local_data_basic:FAIL:tld_create_key unexpected tld_create_key: actual 0 != expected -28
>   ...
>   test_task_local_data_basic_thread:PASS:run task_main 0 nsec
>   test_task_local_data_basic_thread:FAIL:task_main retval unexpected error: 2 (errno 0)
>   test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpected tld_get_data value0: actual 0 != expected 6268
>   ...
>   #447/1   task_local_data/task_local_data_basic:FAIL
>   ...
>   #447/2   task_local_data/task_local_data_race:FAIL
>   #447     task_local_data:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] selftests/bpf: Fix task_local_data failure with 64K page
    https://git.kernel.org/bpf/bpf-next/c/d8df87814050
  - [bpf-next,v4,2/2] selftests/bpf: Fix xdp_pull_data failure with 64K page
    https://git.kernel.org/bpf/bpf-next/c/c7900f225a10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


