Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044244F549;
	Mon, 12 Oct 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801018; cv=none; b=iW7E+4xWd2ZYIUGaRc/MCLkYfJFpF43Rg4c4o/Be6z1OF3s/1SJ/KkaLIbHkFH8ktWosLd3DSXIQ9veB6XaeRoYJQOJljYLdyLMTpEtpoq1W97zZEqvcA3jap1gXhHDQoB2N4jikqFzzOcimWefyeFczwiQOETA/NTGtpzUofno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801018; c=relaxed/simple;
	bh=7HvmZ7z+FHzKUsgiySg15xR765kRqCbAiT/35Wu3I2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cO2yANBgXwch+eAqugfrO4+wbp07uqpZQfYufuwudGV/hec375V8nD313swN7tnUo9O4Rws6S00enou4OtOZABUaVzLKwYD3wXtMJLfcwjeMYvHpGtr2eKTPbJCTFxVPTgGv83MML8hbFlar7bP19PeqqsyygY4oaXI3NWqPfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDcTx8pQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDcTx8pQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D131F0089E;
	Mon, 12 Oct 2026 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791801006;
	bh=CQm+l37PhvY4sn7GzDvhkIVLaZRnc8rXgqLaKi2lNS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EDcTx8pQf6FBbBicRtkHB94PH/CcsAFVpfUzXEF654Q5n138OEzGQRt8ulFmDzK6O
	 tsFNL8ULHR21TBRlEuY4qxgx2VCgWwJy85bQtxjUGscogyLQlfkwSvhDhLY/ltRNOE
	 WMzfOLpXhvqiF10HT2yCfmNZBa5soI7INHQgZPxydE11oPXVoGyLeywl3b17a4tUv2
	 MpNu5bGPeWq8vvtz3b9f3jqAIDc1ZLEKMNkew0tnobRrKmR5aN9Usvd4rLqYmnykg9
	 DVC1PuAudZ+OlHRidin8/phaWXlTSPIFhTA2M8E4J+t+d0hIfRW4K/7mhgda+8nynC
	 io32n9jfn4L8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A63E3811A63;
	Mon, 12 Oct 2026 10:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: Fix out-of-bounds read in kprobe_multi link info
 dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179180100503.3336084.3203597964728952228.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 10:30:05 +0000
References: <20261010074435.1415234-1-chenyuan_fl@163.com>
In-Reply-To: <20261010074435.1415234-1-chenyuan_fl@163.com>
To: chenyuan <chenyuan_fl@163.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, laoar.shao@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat, 10 Oct 2026 15:44:35 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> show_kprobe_multi_{plain,json}() walk the sorted kallsyms array against
> the sorted addr/cookie array with j as a cursor into the latter. The
> loop terminating condition is checked after the cursor has already been
> used to access the array:
> 
> [...]

Here is the summary with links:
  - bpftool: Fix out-of-bounds read in kprobe_multi link info dump
    https://git.kernel.org/bpf/bpf-next/c/0d5e3fc78a6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


