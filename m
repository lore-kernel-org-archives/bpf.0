Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F714A8B
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775955033; cv=none; b=Xe/uDxUysVVNnlp8MzziFc+SwSpErRKK/BP0TJrwKVC/CInBvNKcriz8PT8Gqq6iWrcqdJRrnGDrubLnPmvYOuRmi3b6HgiNEFNnfZPIwVYpTgGDpADEaYlR4VNCV4DA4R26jTHKHNxXmmn6exJBfxM+Uo7+Ur6KZz34yJwhYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775955033; c=relaxed/simple;
	bh=fK1FXWNs8ISsph7h4NrWzJV2n/ky7rAWlRge3PB7VuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ViDM1oQo/5N0aYBPKEf6UGzQszo3JzxuDpNn9nf75Mn0lRsr1whh7BH9l4DxEwvC4m8JLQIt2panhn0E4z0zSbHBgMDJYIaJPUGOO39L5hhJVy2axsrGeYZ0XUVSgN4e0cHf8+CON/rqp3D4H0I2KOK8BXNYlPuTPVFdhBrC9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3KfZiTb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3KfZiTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880D2C116C6;
	Sun, 12 Apr 2026 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775955032;
	bh=fK1FXWNs8ISsph7h4NrWzJV2n/ky7rAWlRge3PB7VuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O3KfZiTbPLs1uL8Ei0Z7mc1GjQs7+iaIPgoLki/KTQFZo3mexhHymcIznA/TB7YXn
	 oQnc4xRxZTM2Sg+QIq5Ch4A8K4aK79C3CcBrkOWpHqsK9B4ZG5+9EuM4WK5akBYm0z
	 btJ20vVGjyGtpWlpp54VdQ43eyVgMQ/IHNJV3lKx3wqelbGB35GInnaNAqJN1TMMSz
	 V+yTrgfKKKTRijbN+YZu3tDjK9Fnc9L1BR04CmEUC8JI8ZEh3FH+2Bi8c7WkcurjIO
	 o/6V+/igKkJROo5tZSTDQMDad8M95hNPSkW8UMistBioEi3Aqxxo0KB2R1w53iEFvv
	 Ad7N2XBuGvtUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D4A3809A8B;
	Sun, 12 Apr 2026 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Simplify do_check_insn()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177595500580.3127504.6650770601785541715.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 00:50:05 +0000
References: <20260411230001.71664-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260411230001.71664-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, mykyta.yatsenko5@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 Apr 2026 16:00:01 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Move env->insn_idx++ to the caller, so that most of
> check_*() calls in do_check_insn() tail call into the next helper.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Simplify do_check_insn()
    https://git.kernel.org/bpf/bpf-next/c/2ec74a053611

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


