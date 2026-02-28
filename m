Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AB1EA7DB
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238608; cv=none; b=CiDrDnsPaMnm1rd62X8T4wwBeaR6jaUSIsPWPmTZIGI//lZKruZZdmG48j5e5PTpMAxVhwUyGlgf1/R0807Jvdpv4y476rpRc2SRbipLwsTOy/DmbyU9cSskb4LobETpzG8uOl6H2V/nl2SpfkA9ucLvdzTlMRkCFga4ObgHCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238608; c=relaxed/simple;
	bh=WrkCDXWxJX3OVtWpuxLfR+KFvfJn6qTI/O4c4mo7L30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PwlVtNyPMscaTt7HdmxraFuGoMZUF99tn4Ne55CPjVl1jS3NHXTnD34k6yRIVGfLljeDYnztKu5WL89tPWAkqJGwVuO2oIerWJdKan156eDjhfLXtpBvb174Gt22Zkk5fecxowL2Mw1K5beZYcM9DabLAY96mfBMU63561q9/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUS0iPmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUS0iPmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6951C116C6;
	Sat, 28 Feb 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772238607;
	bh=WrkCDXWxJX3OVtWpuxLfR+KFvfJn6qTI/O4c4mo7L30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SUS0iPmQ23xnuvCBYZq6iO/Rp51qoRgOhYR9AJOJ/haPmPN7ilhKmPWcZXzbnaRak
	 tUzzgoFeNCNwekRdpLZCl9X7e26zp25Iz3SnUfFLnVzesRN1pPxlq8sOUNmsDrvpd9
	 IVSghDgMweslqMmCCEYekXJtQXCWdzK3L4+zPZSacfsGv3nX7amp87u6OTHBNO31cD
	 HMQAakbvOH7NQE/U7HQT/CHtTAft3F1gl66mWiW+xyLrFzAOf2Q1WOrGo4osxXM8V5
	 QQ5S73JbsTD0mxN+QjqHIFvr5IJb8nuN/uLpChWtINwjw8vqbbmDDBTYrL6EIUcPen
	 ESKrfhh42R0ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD8339EF967;
	Sat, 28 Feb 2026 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf 0/4] Fix invariant violation for single-value tnums
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177223861129.2814566.1659105832274078716.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 00:30:11 +0000
References: <cover.1772225741.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1772225741.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, harishankar.vishwanathan@gmail.com,
 srinivas.narayana@rutgers.edu, santosh.nagarakatte@rutgers.edu

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Feb 2026 22:30:53 +0100 you wrote:
> We're hitting an invariant violation in Cilium that sometimes leads to
> BPF programs being rejected and Cilium failing to start [1]. As far as
> I know this is the first case of invariant violation found in a real
> program (i.e., not by a fuzzer). The following extract from verifier
> logs shows what's happening:
> 
>   from 201 to 236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
>   236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
>   ; if (magic == MARK_MAGIC_HOST || magic == MARK_MAGIC_OVERLAY || magic == MARK_MAGIC_ENCRYPT) @ bpf_host.c:1337
>   236: (16) if w9 == 0xe00 goto pc+45   ; R9=scalar(smin=umin=smin32=umin32=3585,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100))
>   237: (16) if w9 == 0xf00 goto pc+1
>   verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xe01, 0xe00] s64=[0xe01, 0xe00] u32=[0xe01, 0xe00] s32=[0xe01, 0xe00] var_off=(0xe00, 0x0)
> 
> [...]

Here is the summary with links:
  - [v3,bpf,1/4] bpf: Introduce tnum_step to step through tnum's members
    https://git.kernel.org/bpf/bpf/c/76e954155b45
  - [v3,bpf,2/4] bpf: Improve bounds when tnum has a single possible value
    https://git.kernel.org/bpf/bpf/c/efc11a667878
  - [v3,bpf,3/4] selftests/bpf: Test refinement of single-value tnum
    https://git.kernel.org/bpf/bpf/c/e6ad477d1bf8
  - [v3,bpf,4/4] selftests/bpf: Avoid simplification of crafted bounds test
    https://git.kernel.org/bpf/bpf/c/024cea2d647e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


