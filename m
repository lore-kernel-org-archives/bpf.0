Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850B4CDDC3;
	Fri, 16 Oct 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158014; cv=none; b=t2xRGpdsGorM0cs7Rw5ZGkrbqSaQhAspBm7+Qe8iX2+S0iOpOmFJ3jj9BS7I/WgH7sDXb5WNoY8kMG91pCE3pyAbMH9I9q4ChVhC+koopnSs8Ag4X+YXqVCXUJKtkBX1usAsIe7hGg6Oj8wR+K0iWch+MOuRnKXV5voz4pmcjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158014; c=relaxed/simple;
	bh=0IHTEs+pvAYa+7vQMln3xlEfDIWWNKsBpDvOnwo8Yrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IP+lYaYe6rdq+NCcW6+bHYNpS+uxv/E+b0zJjSyEQWylAxfVgpzdlA5sm5ctfLhX+FtOxBDFL410GVbXZCexfJMWP3Xu0/5xf8jCA1Wc/PBhmSoVHTS42MxZzEwvsJaIvVu1H51KVoIlCQiItAVN4MmQG159yBBhUTjGvVUPNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N54YhCq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N54YhCq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472591F000C4;
	Fri, 16 Oct 2026 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792158013;
	bh=q4+yFQ1RMTVGxRi4ZRN5qNEa/3n1uEqLEnZJnPJw83o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N54YhCq3dbbNJlVWMM/Celw4+UppRffTa1ak3EhneeVTs5wiAwXZuhvvSIy6cnGbY
	 e1HdMV+dtZpHGo3bydHFIIjAB8xwr2S3jqpwJav/Bp5rG3htkMjbfVJ2O6GHcyxJNF
	 eSV+omXdybqfjbYM4khcDGghAFpM8KYAV6xtUuCDrAUN2TAtR4/1rDkqEqxU3oIfo7
	 WRZFBCidF8eMjoM5j2AJkhv/QRMl99015z+DVgWLbS7g7BdQzmNynU9HPt+aP+wPho
	 xM0XdXQJlvSHNurvsGlW7VdozKs3DSOR2a7VXZXWKcsxcWXoGaY5VbHZ6epobORtxM
	 aTYwsQOQfEu/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AC13380A95C;
	Fri, 16 Oct 2026 13:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Fix inverted tracefs validation when
 scanning /proc/mounts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179215801179.300760.9186201876116142523.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 13:40:11 +0000
References: <20261016015057.127061-1-chenyuan_fl@163.com>
In-Reply-To: <20261016015057.127061-1-chenyuan_fl@163.com>
To: chenyuan <chenyuan_fl@163.com>
Cc: bpf@vger.kernel.org, chenyuan@kylinos.cn, qmo@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 kuba@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 16 Oct 2026 09:50:57 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> The /proc/mounts fallback in get_tracefs_pipe() accepts only
> non-tracefs mount points, so a tracefs mounted outside the default
> locations is ignored: bpftool prog tracelog then mounts a second
> tracefs, or exits silently with --nomount. Negate the condition.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Fix inverted tracefs validation when scanning /proc/mounts
    https://git.kernel.org/bpf/bpf-next/c/21c755efaab1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


