Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B34239E9B;
	Sun, 18 Oct 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337413; cv=none; b=GHgXeBoQ+Li2bdMLDob4jxrku+6bb3T6Cg4yB1ZUn1l3VwvsHXbFEPhInRR2ThWtLqFtT1IULbjoH85brGTNdSpapME3j3sW523lh5ROP+6Ub24HQiub4FM20sY2LPWbmsF9vN/bXF41WAkjuL0N0YAXwTeGFWGWQlp792dgxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337413; c=relaxed/simple;
	bh=uVhzQOhsRrNM/U+yQpyrSYEnMZ+vGmBrIZZVcz4jmY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BvXadnjSjJAI4ZcA0MZ4oXo+eyqegeJY/i3Frv6Ktp6QT81yWcHDjBhIQld/4bTFm1ChImLyBd7y2uUPnoJVisqiCgbsyspAOfwo/Q3awW+lL7E5FG8pYTIdbtOxREbpALD4Vn060NHr8o+UWZ+sR4XrImHgce4/v19GCGUjCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw9nSQSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw9nSQSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C087A1F000C4;
	Sun, 18 Oct 2026 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792337408;
	bh=q/HR72gFHItCPfFgx3/JNMsaaf8Rwbc8aR6XfNrkGN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vw9nSQSC57W4Dp3DEjbpItFVPTV0+spJ/pxmA4kAzpDp/PsG8ziHOZKCtTUAum5Pm
	 Igy5aqp0DuFifO8L1N6Md+awcVMSH03l83pL1CWACeuB5JySq8nsofu8+wo7oWqZle
	 Cyut/TCiMDKFg7jSTMaaIrYVzyzoZmIwGCjS5JBnj1dV8eAQ3fxy+w3I4xIJBXBtz7
	 oT7YjBpzFBO36IBD6hRaMqRdxVCDmqMuVPmGXCF5pOXFtPewUMwUO5pZ36nsVbF6rT
	 ZkzRNyc8kM5DixMlSYggboucOtTrH7S84ZfbCCRJt0xu0Z8M+nonPdjDZrNSqGpPPy
	 KKkKgMOZerVsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44413811965;
	Sun, 18 Oct 2026 15:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] locking/atomic: arc, hexagon,
 openrisc: Define arch_cmpxchg_local()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179233740728.1716327.4924636966415964247.git-patchwork-notify@kernel.org>
Date: Sun, 18 Oct 2026 15:30:07 +0000
References: <20261018132907.3823160-1-sashal@kernel.org>
In-Reply-To: <20261018132907.3823160-1-sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 vgupta@kernel.org, bcain@kernel.org, shorne@gmail.com, josef@toxicpanda.com,
 eddyz87@gmail.com, memxor@gmail.com, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, peterz@infradead.org, will@kernel.org,
 boqun@kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
 bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bot@kernelci.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 18 Oct 2026 09:29:07 -0400 you wrote:
> Commit ccb88db8dac8 ("bpf: Don't hand out a linked element as extra
> element") made alloc_htab_elem() take the per-cpu spare element with
> try_cmpxchg_local(), the first caller of cmpxchg_local() outside of
> architecture code. It doesn't build on arc, hexagon and openrisc:
> 
>   include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit declaration of function 'arch_cmpxchg_local'; did you mean 'raw_cmpxchg_local'? [-Werror=implicit-function-declaration]
> 
> [...]

Here is the summary with links:
  - [bpf-next] locking/atomic: arc, hexagon, openrisc: Define arch_cmpxchg_local()
    https://git.kernel.org/bpf/bpf-next/c/8cebaa3be829

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


