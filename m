Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589735F18B
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358267; cv=none; b=Dtt0TjoiacqKs3VDfJdaCAZ2WhHmnjNlDMVLpZg9AXxhuWRKMc+0RHwy0pCz+ZAPkmX2aDvGGmKQYa1Fndnj+oIs5vipKbXDVqN9AmbzHJU1gs1aKrozvbPAf4vIFyUaROJwJWGoDECO7H0K6cnrA4lwlUp9R8HaegtxC2+NyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358267; c=relaxed/simple;
	bh=ZfuYiqmTuj8VvMyDNlfy9wq/YHUMmE+WYRn7ujllPwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T23pdECJkF8EG5kCAsYwe3JY2I3eOiXlGkhRbzdI+gPilJw0puMBUNUdjvPOjwHCWf7aJKVlH5ICxtTiPk3GKM+x6dqUdS+LUq5pJ1dWYWkOlEx00SM3MNpfKVajpRJD+/107Ruy0yhQ0kVHtlvcR6zowoy3gSdPz6O5xLk65po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfTnh1r+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfTnh1r+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4911F000E9;
	Wed,  2 Sep 2026 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358266;
	bh=Y408Ju2f4Jn59Sq5ssxVoPtux5XB4+01AFn9TbLd0FQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KfTnh1r+v6WHDKHxMFSf81ig2fka2qsE8KjeH7jYlkmNiR9MHAaRzRV/lYhaV+rVJ
	 2Fz/x4JjLeLLP1LgWGikge+3mP9I5sX9bAg1uZxXYooBDd2nI3uKTjI9yU0nbwzn8I
	 7CjlOdja3Gf7W+KP4nYMSG+DUpKo89Nn9kRqXujhLwf59Lo8nc7AB9/CG9S8m4vkWt
	 zLo9Vp8nhYXR+Jpgg0+e7VbwsRM8BTLVAWseFPnbymZ5k4OGdqbql5DlU2wkCERpcw
	 a4MjOoWLfXYN1Cse9R5DWlowWSKShvi3cgOG+LAH3OUCcs676YfCBTqwSb9+hlGPaG
	 v9BCjJxSNP97g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C939263BF;
	Wed,  2 Sep 2026 14:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: backtrack_insn(): handle ld_{abs,ind}
 subprog
 exit edge
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178835820815.2755289.2342806265562175999.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 14:10:08 +0000
References: <20260901-bug-016-backtrack-ld-abs-v1-1-59368f1be435@gmail.com>
In-Reply-To: <20260901-bug-016-backtrack-ld-abs-v1-1-59368f1be435@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  2 Sep 2026 00:28:34 -0700 you wrote:
> Nicholas Carlini reported a bug in precision backtracking mechanism
> for BPF_LD | BPF_{IND,ABS} instructions. These instructions are
> modelled as two branches:
> - fallthrough;
> - implicit exit from current subprogram.
> 
> The implicit exit case was not handled by the backtrack_insn()
> function. When backtracking such a path backtrack_insn() did not call
> bt_subprog_enter(), which meant that backtracking continued
> manipulating precision marks in a caller frame, while looking at
> instructions in a callee frame.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: backtrack_insn(): handle ld_{abs,ind} subprog exit edge
    https://git.kernel.org/bpf/bpf/c/387b1baefbb7
  - [bpf,2/2] selftests/bpf: precision tracking across BPF_ABS subprog exit
    https://git.kernel.org/bpf/bpf/c/ce6b9e5dd873

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


