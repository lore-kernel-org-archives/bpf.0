Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46D3BD62E
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497467; cv=none; b=SdEuWxb9tNdqkCeNUhXsUIFbWlU2V7FbbPWC5zVb94e85B6Pf9nWZEGl+SFlB8YCfCG28M+LYipdDQLR0AjclCvdct9n40/Ps0kK/2JS5zYfYtssple2aRRc5CylbhoB0drnOehmKLjkooUW7/k6tFlctQnIRv1fPajaJJJaK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497467; c=relaxed/simple;
	bh=TCOjKJ3rqBZ0FbwcAB55ruSIVyZ00Iqg4ty9D0w+iHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dZlSaw2pfolWHigJGR9SfRqr8qnMCp8deEM1GCwGJEX6mjYfR0RoIJmURUJUkhKTiFSQPDt+23+jYSb05jKSJrpfTrbzBgsH0atdL+ToIeGt2bGvMmNs4q9Xi4rswEAzql+FHqwa3EqZoVhaqLCnDW7l/Uj7rLgc1N+OlhAynng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jITXPQhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jITXPQhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBB41F00A3D;
	Fri,  4 Sep 2026 04:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788497465;
	bh=UdY+qxklHuUBQcVL3F8dWvoxF15ujZV17hxsWL+WT80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jITXPQhdwBG7vM7co7oK6itClLt5A/bYFh1q90pJuRGeiRLtSn/HXICzE1HaAzjO2
	 TmWky7cEQpMtTdlpatTOPmNTt7ijS5mtN8v8vPrabUZXUJsqlSD9N96d1LYq9bFY64
	 ikmSZpXCjMCgDS96oQJ/9vlEwnKpcLGhcD6Y6S/eNq0+u/joDfSpmOtmJlCdfL3y+K
	 oLk/cxQezp/C8lHPhp6XQ/VFBKV77yB09tXFxbRonrEshUoyTgdhtVoPc15qQg+YPU
	 3EwRetLc1khjt+K/N9Ci7C4YyJ9CI4Tr345+b3TQPh9eNZpp/NdHIH6B1pJnXYqYno
	 XNIIXK/42stig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A1238119CA;
	Fri,  4 Sep 2026 04:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] selftests/bpf: Add tests to assert that netfilter
 progs cannot write to skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178849740666.4168721.4480340490467562293.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 04:50:06 +0000
References: <20260903065845.22762-1-fw@strlen.de>
In-Reply-To: <20260903065845.22762-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 08:58:45 +0200 you wrote:
> The netfilter framework is allergic to ip header changing after
> validation done by ip/ipv6 stack.
> 
> Assert that bpf netfilter programs do not allow skb write access.
> 
> Following additional tests are expected to be rejected by verifier:
> 
> [...]

Here is the summary with links:
  - [v2,bpf] selftests/bpf: Add tests to assert that netfilter progs cannot write to skb
    https://git.kernel.org/bpf/bpf/c/254c881fe055

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


