Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801039A802;
	Fri, 24 Jul 2026 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926244; cv=none; b=qa6IwJBuV6p35SwBDC7SNf76vVDHwqzU+O1i+AN29TBdN7vvYTIBkn5wBEG47SPZ2hUqAUtmhQ0Fb4AdkkZNXmEHCdreVpkA+IwtBUxKZ/O1pEmpFdxlsZuqSIrKgdUKR213Lalr4mShoceuVlF2Ce5vpUyCuj2p6v1wesEo8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926244; c=relaxed/simple;
	bh=T5FhBI+Ux3nf0bv5vM+6pOEK1UdrVKkPHV4ey/G1v0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKHqhYuPMI3RIx/HnzYeiv83/59DRBBKxjMtC2L5etjTXsfSK2nvomhy9rvBhRSrtH8qjbQQgEDOTz6Ko3WGxRGZ6TASqPyV2HsQemxuWbsAsY93e/Up1W9ph483ttfAaNayKia0mKW+HeoLPFOIB65Kgh8mN0VCxLmC3Ma7IQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwlxL+UG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwlxL+UG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4CD1F000E9;
	Fri, 24 Jul 2026 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784926243;
	bh=/ChcfBdIW71Nq92NRFCyt8DOkb52JvorM6JPHEyvc7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bwlxL+UGQIyejR/SkBtSS729VxWs51F3BFKZlacjeN+ltHj4vuVlX4bNmP1BWWpz6
	 N1uj68MwyiocGLyC5FrICQZznZeH/A+DJ93KmsAGupb4YjZuvEtclyT0rd2LMXmesI
	 p/503QWTE5bJ1SfZgh2Cir4jQ/tpT7C0Vc18lPkeUvLZ0uEbvcLMw/Vst0yVjgDo7M
	 8UUCWozKuOLAspvWH9BI49xsnG9Jd+kcKkJB+SGD12J+pdgTTBpYByrlDuzCU+IYtV
	 cff5HVA/D4TB+VtTuYYVGjQSJX7qYIsVToGjsw66P9/TsuwpHQ8qihIe11Xxzmw+DA
	 kMCwb82hVPTbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687038111D2;
	Fri, 24 Jul 2026 20:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix WARNING in
 bpf_tracing_link_release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178492621014.3303195.2965122653260784419.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 20:50:10 +0000
References: <20260722151909.69142-1-leon.hwang@linux.dev>
In-Reply-To: <20260722151909.69142-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, tanjingguo@huawei.com, pulehui@huawei.com,
 malin89@huawei.com, maciej.fijalkowski@intel.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 22 Jul 2026 23:19:07 +0800 you wrote:
> The trampoline could be corrupted by the blindly
> 'tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX' in verifier.
> 
> 1. A fexit attached to a tail_call_reachable prog. 'tr->flags' became
>    'BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_TAIL_CALL_CTX'. And, the
>    trampoline would poke the target prog's nop insn using jmp insn instead
>    of call insn.
> 2. Another fexit loaded with the same tail_call_reachable prog target.
>    'tr->flags' became 'BPF_TRAMP_F_TAIL_CALL_CTX'.
> 3. Close the first fexit link. Due to no BPF_TRAMP_F_CALL_ORIG in
>    'tr->flags', the trampoline will fail to restore the prog's nop insn
>    using call insn.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Fix WARNING in bpf_tracing_link_release
    https://git.kernel.org/bpf/bpf-next/c/61aaa8782bec
  - [bpf-next,v2,2/2] selftests/bpf: Verify no warning when close fexit link
    https://git.kernel.org/bpf/bpf-next/c/09e074666b7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


