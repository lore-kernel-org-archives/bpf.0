Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D534CFD1;
	Thu, 16 Apr 2026 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348644; cv=none; b=HVOGU+kOv2nwNiTr2ss+9RYKezuXb0Kr4ZI8VXxzURwf3oW5FZEsaFSFigULZDA/koILAqK2fjLJpUhykGpM2zxZ27jsqJ++BTr5OzFDJ7ZHzqjlqjrV04VvqpqmH5KdeLFUjTwrFMlvvP6Tk2Cm4/VCa7WNElDzVvfMj2QB2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348644; c=relaxed/simple;
	bh=pX7i/5+LnUDc6Duofn2BILOt1Pooo9KnzAacs/0u3mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vx+bnNimzc3g1B0NOQwvrk+8thAhS/RGmaJXPlyHXYfW/yoeaQPp2x8IPKCXOeZwIfffdoxvnlQ4RTAanXfAFY9Q40fYV4Z1sZEVkePXl50n4sQsL7dHWeFuPkkLoJHcSBVsW7uAc0zii1sTabxT3iCFndWWCBvwBwGbTPRzPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbQZX91S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbQZX91S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A624C2BCAF;
	Thu, 16 Apr 2026 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776348644;
	bh=pX7i/5+LnUDc6Duofn2BILOt1Pooo9KnzAacs/0u3mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qbQZX91Sd215h+Ii0G9MyMrp1sFoxhOe8u2y/puzg+ZYxqg0xm3EhwJvuCA/u5VtC
	 7CghDvGUyP8TBsM+zm/eUu+dSS7gmPD5J0B6bdyiYCGQtXFTdNveDjPop9poLtw3F6
	 /lHb28E1fLBZhgTrVKpod42Q0Ga+WSBGYlpRbKfYJeQYbE6Df+ASgGeiDuFfV4/Wxi
	 J89STjeG5ZSjR0JsPEj94nnuhdE30xG4IFvUvzRjwEW1B4czQfjPyxmbhEnfaUyvIj
	 5Iry5Ci71iVVbWVT5sVreZaFkOBXKnU6++eg6A3s5pHzCJQzPNcyomhTVE4OrxfrBs
	 UgGhllICwEx8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE13380AA61;
	Thu, 16 Apr 2026 14:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v15 0/5] emit ENDBR/BTI instructions for indirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177634861305.3246567.7251798812226371156.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 14:10:13 +0000
References: <20260416064341.151802-1-xukuohai@huaweicloud.com>
In-Reply-To: <20260416064341.151802-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 yonghong.song@linux.dev, puranjay@kernel.org, a.s.protopopov@gmail.com,
 alexis.lothore@bootlin.com, list+bpf@vahedi.org, linux@armlinux.org.uk,
 yangtiezhu@loongson.cn, hengqi.chen@gmail.com,
 johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
 hbathini@linux.ibm.com, chleroy@kernel.org, naveen@kernel.org,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org,
 pulehui@huawei.com, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 davem@davemloft.net, udknight@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Apr 2026 06:43:36 +0000 you wrote:
> On architectures with CFI protection enabled that require landing pad
> instructions at indirect jump targets, such as x86 with CET/IBT enabled
> and arm64 with BTI enabled, kernel panics when an indirect jump lands on
> a target without landing pad. Therefore, the JIT must emit landing pad
> instructions for indirect jump targets.
> 
> The verifier already recognizes which instructions are indirect jump
> targets during the verification phase. So we can store this information
> in env->insn_aux_data and pass it to the JIT as new parameter, allowing
> the JIT to consult env->insn_aux_data to determine which instructions are
> indirect jump targets.
> 
> [...]

Here is the summary with links:
  - [bpf,v15,1/5] bpf: Move constants blinding out of arch-specific JITs
    https://git.kernel.org/bpf/bpf/c/d3e945223e01
  - [bpf,v15,2/5] bpf: Pass bpf_verifier_env to JIT
    https://git.kernel.org/bpf/bpf/c/d9ef13f72711
  - [bpf,v15,3/5] bpf: Add helper to detect indirect jump targets
    https://git.kernel.org/bpf/bpf/c/07ae6c130b46
  - [bpf,v15,4/5] bpf, x86: Emit ENDBR for indirect jump targets
    https://git.kernel.org/bpf/bpf/c/9a0e89dcc9be
  - [bpf,v15,5/5] bpf, arm64: Emit BTI for indirect jump target
    https://git.kernel.org/bpf/bpf/c/f6606a44bc43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


