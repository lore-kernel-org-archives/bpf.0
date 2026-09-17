Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220E3264FD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684273; cv=none; b=C6Y++U6ndqgFW4+BbtADQ0XGXzTLpgP+X/UorulexJMruXe61gAblfs/eaiu5DcMP2ocQWKaH8JL8imvPZ/CXc4O2wTtasep6pQBVm8whkbdoQgrbWhE++PGDhVbw0ccz+vSUuSa32E8dmHqtyuyjfy/EzzLJ0xXg/31X6oUgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684273; c=relaxed/simple;
	bh=5XPW37OOz6EckWaM/SoeEGRz4E4X+nadp7t6QOo8pd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C+tIay15Bap+1N0qo6JrV66HA3mlJ/0MiWuWNfcnVLKeVGbLu+6eP+3Gp+/phXXYHIL30mNG1VixppWwnvOpEXo5oxXvUP9y0h3Vb0n4bCDX0WbA/E/hCC9IkwkczN0eduSa+p/kHI3El9njXfyp4B67qeu8AiPt5iPUi+WznAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVH7PeTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVH7PeTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FEB1F000FF;
	Thu, 17 Sep 2026 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684271;
	bh=uoLvq32wFs3HRCgMTyThaxfKRFHqKTFCKDgqFgbMOpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RVH7PeTY8Ks1CgsWTqu6N5i342OpfnW8kk65tKLmbIjl/B71Un4t3UYIecpJWH5zG
	 aTP3c2uE5qUcTYgOY8eJna1DW44LyFeD1GFb1uMTBIwexrlzkYlQ6KVzsz2quDL9/5
	 Hgf413bEN+oWMeLsnhpPP1mL/JZTuqtrSlMslS9sMXqiohwR857xJZEMG4gaqFzzjr
	 eVPg1JVglzZJqQ657OIVUCJjd9XnnSXNxrao/yJkkVEBxLodqWac/kd8s//raNS+vX
	 QoCwt+gf64iBjWo11bJ4cxde65h0rZSyAX8aQeKckfY5NO4ljEy+9Lqvyq5QtO8iLg
	 qy1LzXtHoVnFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B993811974;
	Thu, 17 Sep 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] bpftool: Improve perf counter reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968420538.152767.17236037984981874138.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 22:30:05 +0000
References: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
In-Reply-To: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Sep 2026 12:26:39 -0700 you wrote:
> Accept valid perf snapshots whose counter is zero. Group selected metrics
> per CPU so derived ratios cover the same scheduling intervals. Scale each
> per-CPU counter before aggregation and report cycles per program run.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Changes in v4:
> - Use enabled time to recognize valid zero-counter snapshots.
> - Build and enable each CPU's complete perf event group in one pass.
> - Keep run_cnt as the total count, drop run_cnt_valid.
> - Link to v3: https://patch.msgid.link/20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpftool: Accept zero perf counter snapshots
    https://git.kernel.org/bpf/bpf-next/c/b2cf39f53478
  - [bpf-next,v4,2/3] bpftool: Group profile events by CPU
    https://git.kernel.org/bpf/bpf-next/c/6b5fe4b6d5ae
  - [bpf-next,v4,3/3] bpftool: Scale counters and report cycles per run
    https://git.kernel.org/bpf/bpf-next/c/c2c8bd265627

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


