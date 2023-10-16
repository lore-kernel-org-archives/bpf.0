Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041442374D
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwrOohZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76171C433C9;
	Mon, 16 Oct 2023 12:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697457625;
	bh=akCvOikqSFTe2UD8n+wFN6wBYR8td17NbkoYMKlwbbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KwrOohZ+RbapQz0FAPyMmXk2No37WCuw6RkSGtZ/7WCmB46BZJknPuzfJHjB9MjNv
	 k5SZgyvcHbIHmm0Z0q7AgyPdmW0ds4O6VN2zCrEMH1J+1JnARHqyB5Vb0MP/j5mJir
	 uOZguUcIHVSmiz6oj+MaN65EZbNhZdjZPVF9yrZFeMOERtIuB23+gj2Kw3z4NeT77+
	 EwYvMYavksl+k12HHTIRSQUO0J6JIblkwcwv4D4EEdcAjZ4tcf/B1AYCx+UTHCIP99
	 +KQnYAngC/KvVkLbHVRHs5krGP7k8N8+52UckV6gibWN8JkdZFU2xQQYyWBSfIUyah
	 ZyuKMydXKBsOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 649A3E4E9B5;
	Mon, 16 Oct 2023 12:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/5] BPF verifier log improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169745762540.32178.17215607110786044172.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 12:00:25 +0000
References: <20231011223728.3188086-1-andrii@kernel.org>
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 11 Oct 2023 15:37:23 -0700 you wrote:
> This patch set fixes ambiguity in BPF verifier log output of SCALAR register
> in the parts that emit umin/umax, smin/smax, etc ranges. See patch #4 for
> details.
> 
> Also, patch #5 fixes an issue with verifier log missing instruction context
> (state) output for conditionals that trigger precision marking. See details in
> the patch.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/5] selftests/bpf: improve percpu_alloc test robustness
    https://git.kernel.org/bpf/bpf-next/c/2d78928c9cf7
  - [bpf-next,2/5] selftests/bpf: improve missed_kprobe_recursion test robustness
    https://git.kernel.org/bpf/bpf-next/c/08a7078feacf
  - [bpf-next,3/5] selftests/bpf: make align selftests more robust
    https://git.kernel.org/bpf/bpf-next/c/cde785142885
  - [bpf-next,4/5] bpf: disambiguate SCALAR register state output in verifier logs
    https://git.kernel.org/bpf/bpf-next/c/72f8a1de4a7e
  - [bpf-next,5/5] bpf: ensure proper register state printing for cond jumps
    https://git.kernel.org/bpf/bpf-next/c/1a8a315f008a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


