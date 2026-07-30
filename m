Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A3329E55;
	Thu, 30 Jul 2026 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451244; cv=none; b=YF8Zr7Qa/SKWFXdy9NHTjkE+u2JHRFwf6S3r3zLlB1T2tJGJ0zH1pGte/p/89LsLRXH8p/8m8ASObTYbrjkgI/EfYxotLdhjXP7MIwiiMKBiMLUVDwoWeYIGpeqbqz/DCoKWhGlf/3cnwIxIx6QB+PjB8efo88OpHNeHKFyML18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451244; c=relaxed/simple;
	bh=B2qdxnI3yT3+0jxI7Z5zf2epzAwAJZP4BsGP9ssHcSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mBePJj1QU+cUo8EQ9QDBPE4NSsZ1SSraXG8RIxtqTGXN4KLDlHVYmg63UzH2uDf3AoGKje56Kpkk3/Nh3Pe7Kllv2kaBQ7nxxU4omsNJvEkDIOrjG+ePxgfl9Z5OFqcsuf2SJXEzO20OJ7dMoJJfmKheNgvlSpIw30dTI+rW9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs/xbEIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs/xbEIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B031F000E9;
	Thu, 30 Jul 2026 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785451243;
	bh=EccM8aYnUxRL54PgTBrMDBjrsSJpzniVqqskWhoFq0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rs/xbEIqNPI0V78dOLyue9LzJCe6wtc9+VzvHu0Tf2FuqMLB/TqhrZ7fUCYN/b+8D
	 pTqz4GHAswrs2piz3feJT4HPPIfV+Ek1yqW1u/VpLAmg6I2pRwWCAydbXRi5iJh4Xu
	 TZ1rYoJ2mKqOiyV0NMLNfe3Nuwe1gUI0c/MoBJgjDYlSEih3d2dYGXTfzcgQWpcI5/
	 L0LakEcGTN3irFNGgRsh2KBCR3eliQeP+8uZrri2WcwyfM4p6L2DW3Cr+69vKFzpKf
	 4LGyiGrOTUFnfaBwNx/t7AWm3cY00GybUPMydjxBWQsVSsTOXL4SlbxIxcjzZNShwU
	 H0ESE8W+yerSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 841253924459;
	Thu, 30 Jul 2026 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf: Fix potential UAF when reading bpf link info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545120615.19459.9646361737147779776.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 22:40:06 +0000
References: <20260728025457.2814876-1-pulehui@huaweicloud.com>
In-Reply-To: <20260728025457.2814876-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, yonghong.song@linux.dev, song@kernel.org,
 jolsa@kernel.org, emil@etsalapatis.com, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Jul 2026 02:54:57 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
> accessed without holding any locks. If the prog is concurrently replaced
> via bpf_link_update, the old prog can be freed, leading to a potential
> UAF issue.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Fix potential UAF when reading bpf link info
    https://git.kernel.org/bpf/bpf-next/c/863f3ddd0b8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


