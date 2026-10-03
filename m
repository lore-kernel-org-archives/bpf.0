Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8D5282F09;
	Sat,  3 Oct 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016809; cv=none; b=hbDPoLSSc+ct/4EzdGtm0/w79Mr7P/1/7bwwLbLKNLKLZRG2CfL8lSqWuA0i0+mUNrkmSDW2DS0H4ltyWhK0PomiQxw+F7/ZBD8YJVytFc+zLO3s0dLSTFzMdSJnQz5lJpnLQbqKIHiN5q4kQ8e8bWX565BfONSU/9h6s6HSsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016809; c=relaxed/simple;
	bh=KDyBQsWOkXVI8i8zQ1FXAXyYRI9Ss7lqHOVr994hE60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRygJGM4C4ZJsfF6RiZya8Lapg2tZP7Fyqw0REkNOWDIuXwqDrHVAbYTZIUNWOm5QL6GH1jq9AZrq2nVR2SpBw+Fw68p2eao29mCsFn4a1Mku7rYQ5W0vVlhkh+hRB9GWTRAW5UaFjSwPjwlA8ttizf0kov46XRCxvlHjN8EKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kheDDqeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kheDDqeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD02F1F0089B;
	Sat,  3 Oct 2026 08:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791016807;
	bh=ouJddzKByPrry0D0Upehb6Z/luwfT6C8do1CMv077sM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kheDDqeNhlKbTvCGU90UgIlAWvaZhqO9RlXdMnALYk/L2+PmT5YOe0Vs5c1uudTz0
	 b9pzRbEaOAo2mZByLlxlMFsgsdamUMaYWgghGTcVl497bxC0fF1rufuXLlQX5/1wIs
	 XoRzaC7Kej62OAG+zijybqg3TPA/0W/7xoxZcvxc/guhF6hiElermScTS+4A/53s0j
	 ORmwTqXbWRA/nSIb+FjGhzrigMrQ7gHWn/REUYH8dHr5faESCVMKz533fgQEWqk5Jk
	 VFze8NyJgdlrjyFbvmoJaGzyoJ7JlfB+wZN8/noar6oIxvjPrgPb+4AZaUevckpyr7
	 C1jinQV1F2vgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43EB392445F;
	Sat,  3 Oct 2026 08:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v2] bpf: Roll back freplace link state when
 bpf_arch_text_poke() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179101680654.10350.15119401687517610714.git-patchwork-notify@kernel.org>
Date: Sat, 03 Oct 2026 08:40:06 +0000
References: <20260928091121.219333-1-chenyuan_fl@163.com>
In-Reply-To: <20260928091121.219333-1-chenyuan_fl@163.com>
To: chenyuan <chenyuan_fl@163.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org,
 leon.hwang@linux.dev, linux-kernel@vger.kernel.org, chenyuan@kylinos.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 28 Sep 2026 17:11:21 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> A freplace attach claims the target prog by bumping
> tgt_prog->aux->freplace_link_cnt and setting tr->extension_prog.
> bpf_arch_text_poke() then makes the extension take effect.  If the
> poke fails, the claims are never released: the attach unwinds
> through bpf_link_cleanup(), which clears link->prog, so
> bpf_trampoline_unlink_prog() never runs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Roll back freplace link state when bpf_arch_text_poke() fails
    https://git.kernel.org/bpf/bpf-next/c/5ec398d9ec8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


