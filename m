Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD51A683D
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031233; cv=none; b=nfrxb29tEsdR591GMYbbqRWAaahoCH4G7+ekO5bc7gyIdmG46bJCxZyB2KX26EnpP/XSxT+OLYgN1hwBvD7/MqeMS5TGw7hHndilCeYJZTV9pU+GSOS0oo+Lsoc3bnkZQhYY1E1qisz2dNXzOsNs6jYwXJG23p8743q6/Ine+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031233; c=relaxed/simple;
	bh=2zs3G8iKsGHwY55EMKcY5ZL2boJ1VPVFAtpT6X1rcnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n+P4sVxZvoClwq4BqA6eo6rmVX2E4AFjk5J+OgeuOfyIjvvERg0WfgHD6mLIUocQ+xbk5WV+mYvdt9OCLWO9FKTTUL1uL3Xbt+moUAMr6r1BQPa0tP+BT1+4BohytwHKOBieBPEqJvw7XhusK+WzWXX6mLlUJqTHog8z3AO0FPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzrAh/rA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzrAh/rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C8C19424;
	Sun, 12 Apr 2026 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776031233;
	bh=2zs3G8iKsGHwY55EMKcY5ZL2boJ1VPVFAtpT6X1rcnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dzrAh/rAOiUgQ0gnWQD4eIvfFzQ6meVlSd0hmay98ADI6fHQHgiOMpSKLUt0IOZ0m
	 W+40ElXfb9tU9NXau1hbc6acy0r4J5lCATpG09CWH5SC1ELYI5sOw9h8LTeLvPwvq2
	 8AVFhObz1MfYHOfQRtHqoj8H5r15nt9U5bNsl9pPAdeHelqLbbJgC8EH2ewJ3BYFwT
	 enVb+8FpRB6tGpWO+0UQFY7jHukz2DXSDChVKnR2PCvncmnfpgvEWubV+S4jZMjDK3
	 qnDCbM/0ok3AayqWMp6GI12lQ5YNd/1PT0EfhH8SuIwRbMu3SZM+05I+16BXrVyxat
	 eqLMcGyXf3IXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0C3809A8C;
	Sun, 12 Apr 2026 22:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Use memfd_create instead of
 shm_open
 in cgroup_iter_memcg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603120555.3835645.2249118390571440048.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 22:00:05 +0000
References: <20260412210636.47516-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260412210636.47516-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sun, 12 Apr 2026 14:06:36 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Replace shm_open/shm_unlink with memfd_create in the shmem subtest.
> shm_open requires /dev/shm to be mounted, which is not always available
> in test environments, causing the test to fail with ENOENT.
> memfd_create creates an anonymous shmem-backed fd without any filesystem
> dependency while exercising the same shmem accounting path.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Use memfd_create instead of shm_open in cgroup_iter_memcg
    https://git.kernel.org/bpf/bpf-next/c/47687a29b2c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


