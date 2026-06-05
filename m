Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642943F23B3;
	Fri,  5 Jun 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672820; cv=none; b=j9LD50HhwdhdgNWnm43hOo5PxCPwz3zsk+rwtQYNYf48reVQQzkH8MTth1wwSHtqeyz4egaLjKiqb2klD8cIfxjD+nrrQnSGlwvCvqepmN7rWDYL8viO8rSHf0miyWLq4YKp+6fAQrgn/RtjbhjsLjKXBYkCqhodvcYtnqR0jUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672820; c=relaxed/simple;
	bh=yzPGuDNo54wL52VfmYQKbDDMosWjOS5Jx3pXjYb+r9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CihzzXWyxrAWHNLZd6zmDe9wJ6Z0xbEaZU0r1RI/ivTsJwSrun1bb65Rln32+Yq5whLelKF6dOE+yJhrBYpvRR/FuA5OnjtJkPc12pgUmn12kbTNsPj72vIRctLRnj5AfhgVm0MWFq6yw7sFVSHDbk//pYP4yfI1oroJlYXPw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn40vPdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn40vPdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B834A1F00893;
	Fri,  5 Jun 2026 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672817;
	bh=BjuDiwrCJ0HFdDBtjVZfdklhLy78dBCMYX7p5JyQUcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mn40vPdmbtViyL47/G6/VUyIYtBFD7+1taRlY+YrPGh4/Ni+d5+aVl7A3zHHTglKc
	 UugSVWAa9+8+kbSjPwyBhOb6JXj/hW+piY/T5KWFNOZD9PGTdGXmkpmCF5l/p5ph6J
	 wbOgOm2n5FVFKVOUROH/zcAyiUuM9jBxtnQY1bpxiBM27V7eQzrtnRV61pwlCRCCNw
	 Qwg45LlCOBc7l1b65OyLatyPaVKg9eKb6aC1Mw02Z6QBEM/Ta2P+Z79+YbG4ytVpnz
	 vBkvbHCPh2HDQGaxl9Nk3EIAVjD1883InRnOiaHdYI5L6SByM2DR++yRssP7NY7Hcz
	 ADcGof83mFeXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A043930BA5;
	Fri,  5 Jun 2026 15:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] btf: reject to register duplicated kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178067281789.3799550.6894548124212100107.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 15:20:17 +0000
References: <20260603091910.7212-1-chensong_2000@126.com>
In-Reply-To: <20260603091910.7212-1-chensong_2000@126.com>
To: Song Chen <chensong_2000@126.com>
Cc: martin.lau@linux.dev, ast@kernel.org, alexei.starovoitov@gmail.com,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, kaitao.cheng@linux.dev,
 leon.hwang@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Jun 2026 17:19:10 +0800 you wrote:
> I had an ebpf program which calls a kfunc defined and
> implemented in one of my kernel modules, it was working
> fine in 6.16, but was rejected to run by libbpf in 6.19,
> the error message was:
> 
> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
> incompatible with vmlinux [94389]
> 
> [...]

Here is the summary with links:
  - [v5] btf: reject to register duplicated kfunc
    https://git.kernel.org/bpf/bpf-next/c/27ffbfd14d77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


