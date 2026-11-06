Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987411;
	b=h8p+OWQcrSYYiE/sP9ahULT92RjoePRqRF1WiAF5/z8byza1U2cRyAOpAhn3cps7Ik3b
	 +EQsHI7zxCJD5iv4SHfUeaR0seD3EmpozKPAspCIXQ6dbBzoAPBrEnUSN40r8H4Ppn7R/
	 MQ0ma4iVSfwJVHXRhTs/jNUEey10SX6S3ulZCysX//3xNe9QD9LgNzEQr/nOpW/iKIf3H
	 1w8Lqfm1sMilWgg27SAD1INXiVw9iBKUExnNhMG1qrJoiq2JlIdQxwjoGUMo9cFkHTpT/
	 X32tQVqUCfHO4Q7hNtr3zDtnsg5AINJQkz16xYegvAkGQpmXGWKUKnG4/JQx8lDRNsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=d7CKOwG8Ski72r+somzqJ25VMQ24bGvKPynp0n3Ef2Y=;
	b=hQdy7G0AA2OafgsOue2bKJ6YfcragLfFlPDDMw2S2ErDDr8rNxbqFaS4acoaH7LPTT9y
	 P9Rk16+a9HYBmnu8OKk29rBzHxEnlWsaTKH6+8UyL96SPv7ZePIL5Dg96xRB8jZHpnYd4
	 VbAjYotygzlvtK1tX9IYwJ3F0S94L/H0SisDtHmLhealf6xLoTB478O/Q0AbkixLG605i
	 F5LYD5UWMkiR2bn1PWnWVxnWW+jJloDnqFYgRVumKpkksf6kQKj30hNfFqagrhR54S09I
	 rKMxWHV1Z9vHvPhqwmHGvGNdXNa+8gTTRgKwD7EO4lfn8EVR4aqufUfKdu+ABfm4tuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWB+cvf2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0108606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWB+cvf2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1AC1F0089F;
	Fri,  6 Nov 2026 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987410;
	bh=d7CKOwG8Ski72r+somzqJ25VMQ24bGvKPynp0n3Ef2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VWB+cvf2gt3qnaTpo2Z7N67wP7yVGB2WkvcfSQj+ggHkF1E+QZMR4KnUUFWN/BJZA
	 5ohsBoZIUzp5wLyHcGDbuSMye0bkcIh5qlHhX/vzHxtVIxMf2EKsWsnMuMDtUKZ4nQ
	 I/SJiBrOe9Kbg+teM3iS53y53/bRYXz7yoqcIsHbaKxLMmzTpQEc9Maf1RV/VcNRUq
	 wdoOpGpmaCdeUKn6corxemmVL77UNuu6VLjTAV1KNh1OuP6C/RadoAHy3g4A+z0Xdi
	 UM0dFlHHEsh+8/N6RiYwjABDJoDk3Dl1dviqP5gGWEvDDGht+PjvBLCtyFYY5EtIoo
	 taTzcB+iQjCug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E0D43A41012;
	Fri,  6 Nov 2026 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next 0/2] bpf: Disable private stacks for uprobe
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179398740917.777046.9211090722200142386.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 17:50:09 +0000
References: <20261106164043.546879-1-jolsa@kernel.org>
In-Reply-To: <20261106164043.546879-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, sammiee5311@gmail.com,
 simon@swine.de

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Nov 2026 17:40:41 +0100 you wrote:
> hi,
> uprobe programs can be preempted and re-entered on the same CPU. Since
> the private stack is shared per program and CPU, a nested invocation can
> overwrite the preempted invocation's stack.
> 
> This patch disables private stacks for KPROBE programs except kprobe multi
> and kprobe-session programs, identified by the BPF_TRACE_KPROBE_MULTI and
> BPF_TRACE_KPROBE_SESSION attach types. Standard kprobes lack an attach type,
> and uprobes use different attach types or none, so they run without private
> stacks.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next,1/2] bpf: Reject multi kprobe programs in perf event attach
    https://git.kernel.org/bpf/bpf-next/c/6a6beb501ee7
  - [PATCHv2,bpf-next,2/2] bpf: Disable private stacks for untagged kprobe programs
    https://git.kernel.org/bpf/bpf-next/c/0eaeda0d2075

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


