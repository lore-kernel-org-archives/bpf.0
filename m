Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A03D331A;
	Fri,  5 Jun 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694421; cv=none; b=mCVXnXX5MK7s6FNhfGhKteGsK8RQb80ZA24Wg2oDp3hTa2G8pQ2OdUEgfChcaHG2N15upUXjPCbhbadx7yPDb0oKBp2PaMQvdgrCOQAckoppCeK85DHiiaMJnEut3WC6q9poaKPp+EzpLT/i0xPKwIA4vhXbf7Gjf1RYg25VoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694421; c=relaxed/simple;
	bh=Cx+8qomZY5FQwAhNoiy9JrsEd1ll4hy79/vzsGtXG54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fS5O2f846mnWgJ4zP3pRnBgbuPFY2vACMxV/JfHz78Gi7T8kf8xkIOUqg2mqddsXKtTDgW4OtI3iX/lKd00PdBEvvjJSH2WswlcWluZHpu0vh1U/AAaNfZvg7DhUvqTdpRdAEoe2UoWM8rzWUm5K43pVi6L6ILQP7BfUiXsMb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi1CngqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi1CngqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57A51F00893;
	Fri,  5 Jun 2026 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780694419;
	bh=D5IJ/BwlkmKjnnqEMKn+22YmB1KatBt00b8eCo4vmOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Oi1CngqIPerXOPHZBRFVN6VpPiem2VLPwVRE4v+5P+5eSK48uaHycR+Q0tVloSgbL
	 bxUITYi6v59JFG/cGOEHJ0nw/QmrGF6rrUBoMY6kmjMouYZxFGnwzeZwg23Z0zWeJg
	 M9rvh/Yovva1Je2LSEhNI9wyHSCpqISx8DcaIh0XCus3dsvnghkp4tqGQg6XpkQ7xu
	 23dgpibWq6TFYyHKGQQwuCjEy62KiPatxp9mD7Q/9ek8UjBjh0AB0qYb59N6KzXBPt
	 I/R1q6RGOmVJmAvjeIqmECuLv9jUg7qUwoABVvuQLyAtU+1VjPXXlic9InQVBrCqDB
	 0d0Ze9aDpjtig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568323930BB9;
	Fri,  5 Jun 2026 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] Object relationship tracking refactor
 followup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069441988.3922226.2367638176969669476.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 21:20:19 +0000
References: <20260605202056.1780352-1-ameryhung@gmail.com>
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 13:20:51 -0700 you wrote:
> Hi,
> 
> The main patchset refactoring object relationship tracking in the
> verifier has landed and this is a followup that addresses the remaining
> feedback in v6 [0].
> 
> [0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
    https://git.kernel.org/bpf/bpf-next/c/a3863aa4f55e
  - [bpf-next,v3,2/5] bpf: Check acquire_reference() error for "__ref" struct_ops arguments
    https://git.kernel.org/bpf/bpf-next/c/73d475dc6c13
  - [bpf-next,v3,3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
    https://git.kernel.org/bpf/bpf-next/c/41025f441fe6
  - [bpf-next,v3,4/5] bpf: Remove WARN_ON_ONCE in check_ids()
    https://git.kernel.org/bpf/bpf-next/c/ac7f6c9da6b6
  - [bpf-next,v3,5/5] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
    https://git.kernel.org/bpf/bpf-next/c/d83d4f63cb8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


