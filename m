Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF15218A6;
	Mon, 21 Sep 2026 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030220; cv=none; b=HD+/fslFX3eUJ2m4/WCoS1Guv4UXPMhqin/M5wzz3fsAC2Y/bO82qIpojiUrLfZoUkwFOhmQO55vazcBEXrOZO/fTa5vB2jN9WKsr0Z75787bEi9Jb4NhGR2dDhTYbBdSSJ8Nf+pWQEaoYMeQfUSiy/iPttkJJw+W+o1Yj3xo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030220; c=relaxed/simple;
	bh=pgUhBiEg73bIVoV2ofBsXEvGou/hL6SEl/g8tC9tIjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MhhLqqkXNzG4fOQ5syWnfdObmQqHQ6cC27zKCtyLjwiGCEJ8KDr3jM8WJAMoJiw7ppFsvNBKQsiITNB/cXrBxtoGdBdsNednLWYX0+Zl4UzKGXGEZtQrIFSJtlRoysUQc2wvNHh/ay6zCN4HHi/WvoiDFvHJi/np9ccOR8FlMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESPtoGJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESPtoGJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66C11F00899;
	Mon, 21 Sep 2026 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790030216;
	bh=6PRe6lqrU24knYhzbuqLK6/Nc7WBWqovdWCiChRp3+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ESPtoGJIuGpIbjq9Pr6w78YFzAg6Qo9w1AETIgNzEF1jyGXeXFSDyFRc7k6Q/3D/0
	 Jmj6zJekNDtP6HBt2GHG4oYJjtzHeGeHnx165HKjAbf7lptmmnqIoEh4akiGTokeca
	 MSqsarsQ/L/tLehg/yi0hbMmx6mlbqEdy/HIshZ4BL6+qsZAf1mQkGkm7s8D4ZSQ0l
	 Vv6LP7tsX/jTSzjQdf3rHQoKyysqWnVa/2Bj5lIAdrihug/NRo4x1DVcOc6JXo2rI2
	 g+ho+PS8BhPn0AyHaFtNoNhiN9OK0W+JnvHUGxaRYDmHugsXqpmxlxESJ0Z/tEEN9j
	 5B16oZQqarAlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AF93927205;
	Mon, 21 Sep 2026 21:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] bpf: add printf attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002560791.3241479.4745904474529201466.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 21:20:07 +0000
References: <20260915213123.2361066-1-arnd@kernel.org>
In-Reply-To: <20260915213123.2361066-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, arnd@arndb.de, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, ameryhung@gmail.com,
 kees+treewide@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 15 Sep 2026 23:30:09 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with extra warnings enabled shows a missing printf attribute:
> 
> kernel/bpf/diagnostics.c: In function 'bpf_diag_source':
> kernel/bpf/diagnostics.c:828:9: error: function 'bpf_diag_source' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>   828 |         msg = bpf_diag_vfmt(env, fmt, args);
> 
> [...]

Here is the summary with links:
  - [v2] bpf: add printf attributes
    https://git.kernel.org/bpf/bpf-next/c/7f2b0b57a8d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


