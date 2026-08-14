Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AA3596E1
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725056; cv=none; b=GTLnnnje8cf55KAULw1csZcN/XrmkBWAYCADau+6JPkD+p1YVFtOpgrHP97pKzjCTsct1pL7XVE0Ic2b4LKg8zZJejQFChZHcFNcfEQYek8RkTshsgrjS2ul0kU78z/rxDOfK50FVJfeoxcNQ25dnMtOjTJsc9xhHaoWoR0wNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725056; c=relaxed/simple;
	bh=1HtsnfAR3RJddFl8bG6lfVRQFd4w4+FGpVV0IhJatRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOXs35nsV70ojuA1b3wiJXc17ocbIVviqWSGD2io7JRZo8sFAOvN+8M2VjJ4u3D60aKEIHyFWs6sC07pzgWUskoNkKr0vIpoZOzeIbVvs5VnVeswmdC3n+Ed8zZZzKsPH2ISsEK1zuMzNSdnoa8EDGeQmGZzvw3uuFSgieCtqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNCuHanE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNCuHanE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36A31F000E9;
	Fri, 14 Aug 2026 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725054;
	bh=A3zxcI90QT4DZ4voh3ZG0jrhI0TbVGMwRSLisiWsbBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GNCuHanEAu8MSyW+Fp428UjEV0kmeKIwK4dQjGpLl4zIlm2lc+zIOFhju3weQGpS/
	 YU812/k6B/gfAMF+bkRRL1x4aBOPCbtcJlvlQd1plwLXa6x/FH4ztgB9bG89KqUumt
	 cKlbbpRmjXn/x5XtHtJ9XVeDiAYqAt71SjqEzUzZUxLniLu0XKVuxFqOabGVOghlkn
	 Lq7rL+xPZheSLNOivUgYzGyY9Kzh02bQRoTFYHvVlaJ6m+lHEdBiqxGKQMWnljSMdl
	 AU9YWUh+8KerPRcQqSpjercYXeAki/9zwkl4a97Aw6gsMVpmv6sL4AwgSHQCY4OKnh
	 S+qzs02bq15+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198533924451;
	Fri, 14 Aug 2026 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix arm64 KASAN false positive after
 bpf_throw
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178672500865.3867910.15406727079777879390.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 16:30:08 +0000
References: <20260812-hello_world-v1-1-c3c2ddcb362d@meta.com>
In-Reply-To: <20260812-hello_world-v1-1-c3c2ddcb362d@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, puranjay@kernel.org, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 12 Aug 2026 07:47:22 -0700 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> arm64 passes zero as the stack pointer while walking BPF frames, so
> bpf_throw() leaves stale KASAN stack poison after jumping to the
> exception callback.
> 
> Use the frame pointer as the fallback stack watermark.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix arm64 KASAN false positive after bpf_throw
    https://git.kernel.org/bpf/bpf-next/c/b0e872a31e15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


