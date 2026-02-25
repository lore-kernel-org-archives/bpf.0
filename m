Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8491D5ABA;
	Wed, 25 Feb 2026 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982401; cv=none; b=GxYtv+YpyWBaST9t6/2/sJ1UfIRCX3ZClu7F7hpATR3xaiQJIEHk8mVKePRN0U0WLN0zzVr0LTGlLhxHGKg42AE6G+lkuvzpSwKuL/Th/DXwm+wk/gU7uYXkvIs84KjUsfjpjxjAshydkN+3dXOaucDy5SXNxcWPhoA9U3p0hZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982401; c=relaxed/simple;
	bh=JG8QoKBVRtK9A3HZdQullOOHjhjO+hCedrg/ou/hOm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gCU2cB9BTjr/u66pi8B/HHSHd9IuJoKB0DVIvKlWgDzptWQpL2K4i+iix7KupyT77vJmZJoubqF0EYyAxQLWjNgmVxHfjyx9ZpXgZ+ePgCzSJTFHAnqrhqsEywd6tNIegu3HoJEjCKQQFtpn3312f+KAvVK5eCBkiBJ2JucvW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsbagQE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsbagQE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1049C116D0;
	Wed, 25 Feb 2026 01:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771982401;
	bh=JG8QoKBVRtK9A3HZdQullOOHjhjO+hCedrg/ou/hOm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PsbagQE3CmTZr6U4Sr5Gnt5MY+0EdljiKUN19GSvcIgWEoaSDaxqQoJ3PF6AF9z74
	 xF5ZiNHfFJLlVSCi3UL7cicTNpwS6I1hqmq1c/qIAKrPNYA/FMJFPAxcKeADzeC6aB
	 oRMBohYLOlzAWSa5oFZm2yG9HMStgw+jdEzZB0KNXL9byfNaXcc87Z2B117ElEG8Iq
	 ufx1K0Xb1B3FXSaPkl01e/cf0i/r3YzyawYammsovkEu6ZdZI2vw5KzzVbANpwlkgb
	 SOr5a3pAQuR5G6F+4JChjFewbA7zv39dll86T3/fnHN2KJQgbLd78tlxLU6ulpVZUC
	 av2FJmBS7kW1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFEF3808203;
	Wed, 25 Feb 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: test accounting of tail calls when prog is
 NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198240631.23068.16768536304424176943.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 01:20:06 +0000
References: <20260216090802.1805655-1-hbathini@linux.ibm.com>
In-Reply-To: <20260216090802.1805655-1-hbathini@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 16 Feb 2026 14:38:02 +0530 you wrote:
> Test whether tail call count is incorrectly accounted for, when the
> tail call fails due to a missing BPF program.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> - powerpc64 BPF JIT has been incorrectly accounting for tailcall count
>   even when BPF program to tailcall into is missing. A simple change
>   to one of the tailcall selftests could have flagged it earlier.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: test accounting of tail calls when prog is NULL
    https://git.kernel.org/bpf/bpf-next/c/8ebfe65e22d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


