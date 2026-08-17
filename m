Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25E23D7DF;
	Mon, 17 Aug 2026 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993257; cv=none; b=E+ao+uqTzd2LKV3ww1MhqFdl3k8dNmBiFZyfMPfrcU7MJv9iS9+g2eQcEHhvkLQQvLxY9/jYQLqjMUU3aEQpP2ZKTHhDtGrusFW3+nL0cqJUznp8NeSdCb/zeYnXP58VvCWSpPX9+C+zSxwYwsGOfaOI9GOj295MjxBagt1rQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993257; c=relaxed/simple;
	bh=5xqrS/DqHQjAddMiA1TXHoqKl01SknktJwq7pQc82L8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DyXfrESeI9XvfAgMEJBo/qrX33NH1GV7uQnG5gjECvEDjFFBUPz7cCak9fPY2CvUVAUAZqNRIwcAQMB3X8k2pZMYoWza28TvKv6E0l8/7bFOA+0E9dlOKUqnRp/n4uHuO0CpOayfLsW5tbAFvqW4IFobWYBi/8CiSmKvir7mXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2wW2PTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2wW2PTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86081F00A3A;
	Mon, 17 Aug 2026 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786993255;
	bh=bznh0x54v18hIE4vPDAjTSnoqc+zwwjgGdRrNxOELG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L2wW2PTNCqwSNtk/AFOjdVrRLUvNRKAmiAY+Db8gnd/xkdAAqlutj8051H81UkiQG
	 6/FPJ328yX6R2G+mpCEEIyS51FqDM2c3K+RQopwrfAiiB+1qEp4BUehSlnBDJs1b0t
	 rJPF9OqnoaAiF4XFOAUN/QTKJZbA3jCI9m2oJlkdJzdMENAJAgeH9dccTytOQYdfRJ
	 ui84d9eVOGjCvNiYlwChIhVgsGElp9DUyRBkG0D9J6BXsJlMHdxDva9YQEFaIQWIJw
	 EAdgQMAXFCOrJKNv0I8oqVipqMnoMVs8RxHcQWY4AiWeL6CZQUDqDbiGs7j3CkSfdx
	 j2sKOOiuzhkGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198443926262;
	Mon, 17 Aug 2026 19:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699320761.1691257.15795041250819922475.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:00:07 +0000
References: <20260817160249.655916-1-changwoo@igalia.com>
In-Reply-To: <20260817160249.655916-1-changwoo@igalia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org, emil@etsalapatis.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 18 Aug 2026 01:02:49 +0900 you wrote:
> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
> every translation unit including it emits a copy. __weak makes them all
> resolve to one instance, but bpftool gen object merges only the symbols
> and concatenates each input's .addr_space.1 bytes, leaving the surplus
> copies unreferenced in the linked object.
> 
> libarena links ten such units, so nine copies were dead weight (bytes):
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Remove duplicate copies of the arena spinlock qnodes
    https://git.kernel.org/bpf/bpf-next/c/9d19ca5d0e8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


