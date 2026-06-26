Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BFC3F39EB
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480644; cv=none; b=eSrTGVKvR8xN70TRpKkf3S7rM1cdYOQV1235YL5IAal+UrtM7HR7NkNGAGRH4SDOUpe1sJMP0BL6+am/Q3GqZH/SDc27v0kMPUpvubzFwJv/gjXPaK40V/DaZmEGZdkElOv3yfQvyaz/Qv32a14ilIEiBoebZpRGl+SM+VSGBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480644; c=relaxed/simple;
	bh=dSYtF1qMCfsQB5E/bbAEc2n29MCtVmeoNeIUsja7Q1k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXzXMhDyePeszT1muhj7LbS+HDXyQcmwGxhSpbFulWfOaoNGsyN4vcUxb+qM585Rx0XeMFEB/OpnY3mZUn5L3vXtt3+RxlpDDrhNVRNDEoLJ7oeHXxO1PqUQywUwKBX39giRpH8H7O6yKmecrkvsEQgZc8j4xEC4K1dfCAgh/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYat8YbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYat8YbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB2F1F000E9;
	Fri, 26 Jun 2026 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480643;
	bh=ok3tINVrE1TMoKvXzYkTywdbJB7LK4DzrCy8pWrSGYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iYat8YbP6OhIP3cdCrFlDfmT/uSVOxmd/1bpztCPqVerHwXzBPNEu5feowY3I5kyj
	 MunD6HicMYFOsoJJ+AV4ItytT2XZvo68zZrg5+666XO2AuIjehSwJQBFMmHAvv1iM5
	 fJCa85aeWs/BMjB9cBhp1645dkrPeeB9L6jpXMcSzBWtx25jNHe3RV9DWIO5EbDdVl
	 GgEoCZrlps+jeBe3LFA4hijcHGAi6n97vXmTtZERU+LugkYODGM30tLpCtFV+S4PNi
	 BjKpcH9IaeGyYArQ6WvFsDSSmhDFse00pix9cdj+dOaNQ0XBufJyia8Fd6+MbDN7uC
	 N/7V0Q5UQLO9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1439389FC;
	Fri, 26 Jun 2026 13:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Preserve scalar zero spills for
 stack
 reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178248062933.457674.17057280003944862522.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 13:30:29 +0000
References: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
In-Reply-To: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 john.fastabend@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 25 Jun 2026 19:25:36 +0900 you wrote:
> Changes in v3:
> - Apply scalar-zero spill preservation to fixed-offset mixed stack reads as well.
> - Remove the var-offset-only flag from mark_reg_stack_read().
> - Keep pure register-fill behavior unchanged.
> - Add fixed-offset mixed zero/spill-zero selftest coverage.
> - Address selftest nits: drop extra unpriv checks, align asm formatting, and remove the pruning-sensitive test.
> - Link to v2: https://patch.msgid.link/20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Preserve scalar zero spills for stack reads
    (no matching commit)
  - [bpf-next,v3,2/2] selftests/bpf: Cover stack reads from zero spills
    https://git.kernel.org/bpf/bpf-next/c/e693da913d2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


