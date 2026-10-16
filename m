Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0EF535FB9
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173021; cv=none; b=Cf6YhiwtjsKjTJekdivIGvtwK3YTcDHI91niAFdk3j73x6HAGYgRBlpF2wE08ylMYZcOyR6s5Ik4dih3XFlDXShbgpw/mpoSRvRTzcCLaA0s5UP/tcBFdpxSFVOc5rayOE5Bf97SAg3gMh9Q9BTtCHReKV3YCraeU0wW484wcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173021; c=relaxed/simple;
	bh=cch2mwe5959FXDDSgauPrtpAINdIxCBDvb7HANHUPqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CSpyDEwS05jSF+ooiYspFL82u5Y89fJD8RyKy2exojv/i8Qcbg4eaKX+2asANfdP7R/N0HEJK3XP8WBVpMtJNgOKSUzmKuAKoAfO0ywMskGGSqlHg7AgNbeL+qSkyqxWEyfY5ZsTs7WiSzkZ0OlMLtIwl5jHRFGVnOemOJCeqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrAgXLmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrAgXLmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6AC1F000C4;
	Fri, 16 Oct 2026 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792173020;
	bh=PrXYyW6SWg+2GwsqY5HmZAt8ANJ/sHUHeG6RO/ismHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZrAgXLmKPL7ONXJ+0jAQ/ZYFTlpqOBZHpH59C+EBpdCbYM3z5DQJKxQaa2dpDk9x3
	 O1gHoHMHGIh2NfOxgCKBeiHuCxlnJmz3HUVXSi6VxF+rEjM7FQSGcswPFgd+l1bGjh
	 vp4KBgGTcy97vg3wKqp08tcrpGml/jDaFu712V3/hzjaQUi3vLHXUZ4dOnI3k7uveN
	 TGPqmrELH61wrDPQOj/WRB6v6RfGOXVRcVx6LvEo99tjy8Ty7CYHiajhCeMv9pMltY
	 lnK5NoQhBD991loWBf/n1tQ5N2cdNRz8K3hPA6AJIgL2x+JCxAcjJpHyiiDouiYk4r
	 WKGqdQxjnvPGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772F3380AA60;
	Fri, 16 Oct 2026 17:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/3] bpf,
 s390: Mask the count of 32-bit shifts by register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179217301901.897417.16584914717846246156.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 17:50:19 +0000
References: <20261016101822.632891-1-daniel@iogearbox.net>
In-Reply-To: <20261016101822.632891-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, memxor@gmail.com, bpf@vger.kernel.org,
 iii@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 12:18:20 +0200 you wrote:
> RFC9669 defines the shifts as dst <<= (src & mask), dst >>= (src & mask)
> and sign extending dst >>= (src & mask), where "shift operations use a mask
> of 0x3F (63) for 64-bit operations and 0x1F (31) for 32-bit operations"
> (Section 4.1), which the interpreter implements. On x86-64 and arm64 the
> hardware does so by itself, so both JITs emit the shift alone and conform.
> 
> The 32-bit shifts by register of the s390x JIT do not conform to the spec.
> They emit sll, srl and sra with the count in the address of the second
> operand, of which the "rightmost six bits indicate the number of bit
> positions to be shifted" (z/Architecture Principles of Operation,
> SA22-7832-13), so a count of 32 to 63 clears the register, or fills it
> with the sign for sra, instead of shifting by the count masked with 31.
> The 64-bit sllg, srlg and srag take six bits as well, which is the mask
> there, so only the 32-bit forms differ.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf, s390: Mask the count of 32-bit shifts by register
    https://git.kernel.org/bpf/bpf-next/c/4d8c247f1a21
  - [bpf-next,v2,2/3] selftests/bpf: Restore the je <-> jmp distance in convergence check
    https://git.kernel.org/bpf/bpf-next/c/b5fc954c39d4
  - [bpf-next,v2,3/3] selftests/bpf: Follow-up to JIT instruction tests
    https://git.kernel.org/bpf/bpf-next/c/b4e14f47371c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


