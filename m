Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D14A4F19
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873437; cv=none; b=ebiP/A0cYwUUY3/rOz6LDO7Cel6lxPB0TSnndzMioiX2Rm+qKxLcBx5EY3rQgETmKxgAYQkUQCIaJ9WFdriwbc5KNAtCRrMjMgYL9wt4SgE/AUrgd2YT8OCMg5PJOHyRlKXwuRa2HQSPSSDciEVykrzsk4I0aDtejXyPJY9AENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873437; c=relaxed/simple;
	bh=ki92aWm036FrKnDqkph5TJz2cbdgHRLfT4s4Z6WvJbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O3WCf6TD2b7CqcTKUFJJRr2QCQ51oRUPnNM70EmKmbYAuMCdbnWFLwbczbQLOppCdzmMT8DkTcWj0wyA907ZLIgVtSwo+FkYRmJiQ4yQ+570v/EV2Urkf0oYUkmv3SG7C3KGQHGH9F1osJ3PTQNBiSSYL2mkq1k8sk+bsfHJgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgVa2gLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgVa2gLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807731F000FF;
	Thu,  1 Oct 2026 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873432;
	bh=tT8YQerysB5S5I0EF9Na0EnCxAEXheVtrw9Zxh7PpaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QgVa2gLbH2a+b6S5UJHykL5fSH2UYPe77hRdl5e4uPn7CULjtum+WlcPsPTD655+c
	 IGkAq3nZqD35TpOU0Y8bcNMyD1z8XUZclQEpZbiOk5P4NWinaJa58/MfMfV/EPggft
	 pWX8Gw5sQmYiBQJmu3mvtpxdC2nJgPyzkdtv8B+58PUvYt4USYe8svc7QH8YybJwnG
	 mC26/dXAPSV552BpP1jQ72SANLFjaubmFoFnyssQrXZqyLBThboQ7FlFiqNDtNCUf/
	 rkaEpajEXB2Q7BBlW6XDOQf0sFrAOlQDJnQaaciBOaOih2RRqhNjhuXn95+gpIKZeS
	 3n0uMHh6R95Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774F13811960;
	Thu,  1 Oct 2026 16:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] bpf: Fix objects stuck in free_by_rcu_ttrace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179087343109.3011010.17144166539288469552.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 16:50:31 +0000
References: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 30 Sep 2026 09:59:17 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The objects that bpf_mem_alloc frees while RCU tasks trace GP is in flight
> stay in free_by_rcu_ttrace list until the same bpf_mem_cache frees or
> allocates in bulk again.
> 
> Patch 1 - refactoring. No functional change.
> Patch 2 - the fix.
> Patch 3 - selftest.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: Factor out __do_call_rcu_ttrace()
    https://git.kernel.org/bpf/bpf/c/47f4f695cec1
  - [bpf,2/3] bpf: Fix objects stuck in free_by_rcu_ttrace
    https://git.kernel.org/bpf/bpf/c/fbd97dd1d3ce
  - [bpf,3/3] selftests/bpf: Add a test for objects stuck in free_by_rcu_ttrace
    https://git.kernel.org/bpf/bpf/c/aeb709c767ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


