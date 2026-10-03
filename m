Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E635C6A7
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791065407; cv=none; b=MZRggpE8WXG0lMZ21p0qjWsK4IeErh7seid/S+sV4bhNLLgwmg/N20KrHIognoVPYiQKUhnbS/rRor1RGWliIwogKMJZX9JgJEU+EhTNBdgiBVPRzBdAEBLcDyPnY613U7iss2nXqg8xc+rEGrIHBD0QX3l56/selus5YJkqBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791065407; c=relaxed/simple;
	bh=JmHC7ffML7wYWIhh/a6tLaagVmN0HwYJ4i2wTQZ19+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F3nWUNHJhNAQTVflJSnR1ot2+pH+rVhPfHG9dwo19+OPPSn45Osed/1LggTO8tcCU0G9B2XZwsBDYZMEP2gVbsoXSaMlf23CBKydUmNZh6G8KHkUhw2Rf8ijoCfX51heaG6EDH9lPjAP4EdNxx+jdYgGbuXVSPUCfxUbvzJNlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8+FlGt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8+FlGt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1411F0089B;
	Sat,  3 Oct 2026 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791065405;
	bh=a9Kv2Rm9I+6NZ4gbVtM6UhQYqsU+Xsd7zAqJvXaZpSw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q8+FlGt98ageA8rJt0jlfTYppMmnxwVj/9Qud+KaRuMuBrRSFFNDc1yeCjHR1Q1zC
	 oVtDvr+M/MLFnxebM+Bwr/avQylGu64AJ3WHtmMhUQWNMZObMzH3NbvdE5KGInzN/P
	 M6ukVabUDtXkGLFLbf6nbthRUDfNZEFciMEB3fmqIfnGTdv4UZOKiCZT9YVEDkR1qZ
	 uERYsJh2mUL9Ha5kGvUqoDlqYALUoEHG65vkmC3Xjv+bc1Wt9UI9mzSmwbXBRAIurs
	 +e+XVGjaScGocaCEp5bRP3IwMVAUm/HBR6gA3JruiXnYJmtHB89+oXHhinsL0hc1vm
	 KT9xUWvak7dUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43943924A65;
	Sat,  3 Oct 2026 22:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Format data_in_arena_rust.rs with
 rustfmt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179106540453.231337.18350634083826612292.git-patchwork-notify@kernel.org>
Date: Sat, 03 Oct 2026 22:10:04 +0000
References: <20261003203326.1086454-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261003203326.1086454-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat,  3 Oct 2026 20:33:26 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> 'make rustfmtcheck' checks every .rs file in the tree and fails since
> the test in Rust was added:
> 
>   Diff in tools/testing/selftests/bpf/progs/data_in_arena_rust.rs:42:
>    #[no_mangle]
>    static IN_RODATA: Node = Node { val: 3, next: None };
>    #[no_mangle]
>   -static mut IN_DATA: Node = Node { val: 20, next: Some(&IN_RODATA) };
>   +static mut IN_DATA: Node = Node {
>   +    val: 20,
>   +    next: Some(&IN_RODATA),
>   +};
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Format data_in_arena_rust.rs with rustfmt
    https://git.kernel.org/bpf/bpf-next/c/99dc1ba54242

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


