Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1B2F6188
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538693; cv=none; b=QjCwguRUHKZ0nkNXiymKS4A+mNVNx4m+tDxdIg4YnASArO6lHh2rjwI9lpIvULjr5rTZuj9hi5Jg4ukngCo8OHbb28eDYf3tNU9yxy/d4Q07renPBK4asA4Q9UiJRXO7L+vv9EUv4TJIPV70+EpIifRDxfx8py+J9GtnBDrhkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538693; c=relaxed/simple;
	bh=Nm9ffIBgf3OeN3myAHCd4z7H30iwLt5MyQ2Fc7GHuV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NXhgrmYJBTHMmRqLKntDndAI/2+3ZCXLbmoBmw19BsuIUfcF43xn/cEQJTi9/FJ4gFJsOnCH7KZgvyWceNpRBu6ptj9iMPa8NMLROtImjVPRp2rkO1QIoFFwH0QJeRelRszTH7BRkLb/CCCtoSKUrrD7ZuVoTnR++azTHP5KqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl/iXckB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl/iXckB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7415C1F000FF;
	Sun, 27 Sep 2026 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790538692;
	bh=qgSyL5htdVsEmEXd8esel0bzD98BEAXJqlAk7Y3nPzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nl/iXckBsXYQjQBL5SKt4OdEq7VrzDlliXcCiSTT8xMNleTccpa+aUoWwHkSmvIQZ
	 0Q7mahC9O8cBS07+87g1DUQf0fWe+QDRSNCoQ6nf4N4C0JENmj7/BtGi7Kgzbz1Jc0
	 0f51LTGaTwYW1ofArNubK0zrO51tkfACWvw48i1GZN+d9Zb4MQ0/sNx2C/cLv/GORx
	 GZh88b2A38RPWYTuR93oWXU2I8gz+aOKu6GD0uPztlvRBVDjFJplfY2SS8l1YUu9Ya
	 gN2jVtn7tXEeSZlleJ5mXT20lWBUX8iSRdGAPkU2A0dPongKO0h9w7ASjlRjjp/K+8
	 mho9QGB3Pr6vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56813380AA5F;
	Sun, 27 Sep 2026 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix gcc -Wreturn-type error in
 the
 tail call subprog test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179053861814.2786179.11839021614306294577.git-patchwork-notify@kernel.org>
Date: Sun, 27 Sep 2026 19:50:18 +0000
References: <20260926113835.1193471-1-daniel@iogearbox.net>
In-Reply-To: <20260926113835.1193471-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat, 26 Sep 2026 13:38:35 +0200 you wrote:
> gcc's C front end warns for a static function returning non-void that has
> no return statement at all, regardless of the for (;;) {} it ends in, and
> BPF CI builds test_progs-bpf_gcc with -Werror:
> 
>   progs/verifier_cfg.c: In function 'tail_call_or_throw_subprog':
>   error: no return statement in function returning non-void [-Werror=return-type]
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix gcc -Wreturn-type error in the tail call subprog test
    https://git.kernel.org/bpf/bpf-next/c/ea9358e1270a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


