Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D3365A0E
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752214; cv=none; b=sgta5/LPLzktHtTIQt7iwdUXCE3b8kwgoneuumcypRz8OtlqJ3EsVEuRwGqaxE3f6G1HcYsGNUcWqNqXi8262U7S6dmDhwmUvHcfB7USw2uKbYwNfEgxtq56dOQDl/z2SoU7Y7MsLY7jXAnLEcIeq6jMJzE0KqAamXzgDlonkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752214; c=relaxed/simple;
	bh=iClASr+11pDpD3fRor45gy0JYgMhcPlAy7jV2389EW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=afjKHn/0KWhhumKXHixBhVsE/tuiBAhFfoThUhOsI9FX3iSpz0lYk/K2nEn03BqalAORPB4xrDZT3h8RDJBkDa6DE2/FgpG7FPmZpREA6kb0szQ53z2J56t2ejUW/E7sXHW0h2ow0raxexWLSBs1WY+TujXWNOZQUx7vaeyOY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eObS2RmV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eObS2RmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3447C19423;
	Thu,  5 Mar 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772752214;
	bh=iClASr+11pDpD3fRor45gy0JYgMhcPlAy7jV2389EW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eObS2RmVsX+w7uGn1q5lCN4+fxIRWwDGgoJl5cX5JNGaY66yX1Y7ilv8TKdqUbLTa
	 RsyleMrGpgbQzwrSYwRzNWDlUUX2QJVNG3iqv0b8IjS+8+1xeRto1hxQTyXwxVh0mJ
	 rJz0rhjEmWdBHJs9Iwx/jTy+eqv46WJlxyBascQsdYlMJNjW1zyNK2YU3uWtc0v444
	 UpGjgJgajtTTV1JsAA572HXTKvVx7LrpWnNoko+PRpOFq1duxZx3nWHuEmtBeL6z5y
	 Cq651ZrDz67PjX29/tdKlJ+wuHlyAAsXHhDcIQokKdQ26mT354lJbVi6j4KRwoRk2o
	 CINRXATXhpd0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D193808200;
	Thu,  5 Mar 2026 23:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/3] libbpf/bpftool: support merging split BTFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177275221379.3320727.2575476531046874927.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 23:10:13 +0000
References: <cover.1772657690.git.josef@toxicpanda.com>
In-Reply-To: <cover.1772657690.git.josef@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  4 Mar 2026 15:56:49 -0500 you wrote:
> v1: https://lore.kernel.org/bpf/cover.1771605821.git.josef@toxicpanda.com/
> v2: https://lore.kernel.org/bpf/cover.1771616227.git.josef@toxicpanda.com/
> v3: https://lore.kernel.org/bpf/cover.1771622266.git.josef@toxicpanda.com/
> v4: https://lore.kernel.org/bpf/cover.1771625484.git.josef@toxicpanda.com/
> v5: https://lore.kernel.org/bpf/cover.1771950922.git.josef@toxicpanda.com/
> 
> v1->v2:
> - Added a btf__dedup() call to btf__add_btf() to ensure that we don't have
>   duplicate types in the merged BTF.
> v2->v3:
> - AI review got confused about the UAF comment, so the comment was expanded to
>   clarify the UAF potential.
> - Fixed potential clobbering of errno in the error path.
> v3->v4:
> - Fixed a potential silent corruption pointed out by the AI review bot.
> v4->v5:
> - Addressed Andrii's comments for 1/3.
> - Addressed Alan and Quentin's comments for 2/3.
> - Addressed Alan's comments for 3/3.
> - Added my Signed-off-by for the third patch.
> - Made sure to validate everything still worked.
> v5->v6:
> - Fixed the missed is_prefix comment.
> - Fixed the removed warning about skipping vmlinux.
> 
> [...]

Here is the summary with links:
  - [v6,1/3] libbpf: support appending split BTF in btf__add_btf()
    (no matching commit)
  - [v6,2/3] bpftool: support merging multiple module BTFs in btf dump
    (no matching commit)
  - [v6,3/3] selftests/bpf: add test for btf__add_btf() with split BTF sources
    https://git.kernel.org/bpf/bpf-next/c/fefeeec61235

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


