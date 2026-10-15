Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB004C6531;
	Thu, 15 Oct 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052407; cv=none; b=pBudRBtePvucr2cZlK1U3ctiYWLUya33c3wp9TS13Y+F8hnOw9xZElFvHENwo/1yTovy+MDPG98cq4Wy4d1oZIbBl5zfnw/0rY/1thcjl67zhiYHdZcNKOB9ZPAGCE0mv4BEJhWlXt/M4XpXe6avCAuVRfHIbzagkE+oGdQqIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052407; c=relaxed/simple;
	bh=8jCHQm6YGyLbzzuDtZCpslXsjH5ss7zLw6nwavgl+dY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvuAJ4UKZ1Et3bRHjUBTP+6adVMOWMF+ADA2voe2We389CQlRLVAChVIcFmX25m4rSuGdMj62VATgKvr+akt+vsH0Qyp6+bTp4UKSMHy2jNu3ckqmRb/HdwzndmNwXjrl1hQ6kK0omQ+OIK1ktMlg31IHJ9rRlQEpfLz0QtvwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1/IkUPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1/IkUPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD43A1F000C4;
	Thu, 15 Oct 2026 08:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052405;
	bh=yhvn8bIgQn4Ii8JvjJVQJ8Fslzl0AFG6s5FtZK1BfYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B1/IkUPwNn5+tf1JLU8XbWtOaQ57iSAYtJ4ykienK0G7QRoIJRwiVKoQWgR1CRy/I
	 iRctEXK/Gn/9pI0h4gZtiLADjSNpPYto6vnzg//p5bsoj2e0usOruioAWQe2O3wKwQ
	 xuV6a71UxqDLC1FGMNg4B42Ifvv9asus/TTFGyiXz5EsRsEix0a33NLJsw4Vog7LWo
	 ZNuReFcOWGitNbExKWGtUe48ftHbFhLN5C8cdNWQM2LxT/YbLQ1Mn3tU2uotHirC6E
	 ztngbJJESnakSOdFgBMTDkPqknilU+L0XSdpiB1a5mpUwf12DaP0Rnbza676RLRnLx
	 MEBGEi23lnPag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4475392E9E2;
	Thu, 15 Oct 2026 08:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Expect at least one tp_recursion
 miss in missed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205240454.3269137.11377280407638045267.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 08:20:04 +0000
References: 
 <20261008-selftests-bpf-missed-tp-recursion-v1-1-0dd60471d655@gmail.com>
In-Reply-To: 
 <20261008-selftests-bpf-missed-tp-recursion-v1-1-0dd60471d655@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 08 Oct 2026 22:03:47 +0800 you wrote:
> missed_tp_recursion attaches its tp programs to bpf_trace_printk and
> expects each of them to miss exactly one run, the one that its kprobe
> program triggers by calling bpf_printk().
> 
> Any other kprobe program calling bpf_printk() hits bpf_trace_printk as
> well. When another test runs one in parallel, the tp programs that are
> already attached at that point count an extra miss, and
> test2_recursion_misses comes out as 2 instead of 1.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Expect at least one tp_recursion miss in missed
    https://git.kernel.org/bpf/bpf-next/c/a5e144985d68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


