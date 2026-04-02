Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790C3E9F80;
	Thu,  2 Apr 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147426; cv=none; b=PJLNzHyLRWMF5XzMcGzlxTOyOr8ou66jupE7hYiHTiIKPaWbTiIVdbnKNvZgIDwajsvlAAlGRjMNr6AOScqYyv1i030LoMWFFcyrS4+w0m9kPq18KMu59dw5pZWZGkv7BUiRKtO4an7pobQhPA1RU9xoVgrg8Sz2T53sCpI3vIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147426; c=relaxed/simple;
	bh=Yafctupw8vgHDd4gFrWF/60vp2as1igy7rnpXC8AuGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L9GGIA3N3awG2ErDuuobRzeU5YlaR7299GIDnQILvvVCdc3VxMqQPGJx0q1pDSi76/np5XtuQp5vcMekWiIr7+Iq/+U5Jze34IkrHR9Q3MU3XY+gUJfSq3vmHy3U6YAKaTwda5XN4da0aqA+5A++npQY56RbBhstusTxyoRjz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUOC4KlX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUOC4KlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06F0C116C6;
	Thu,  2 Apr 2026 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147425;
	bh=Yafctupw8vgHDd4gFrWF/60vp2as1igy7rnpXC8AuGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUOC4KlX5HWYZU9XEsdNO848ok8Sp+Tmkg3pT3GJSXLLpjdhQt38ahwEgVSHPdYPp
	 vtwsAUlnITWuJoCacbo6HL6YDmS9tyhPh4IEAeR5eMUSRIsu+OphlDLcGsAwed2C5h
	 bs5lBanv6n/GRNjLHDLBJIhR+SGBIFDNKr0DTpCDyH4rM/OHKovjB0aJ+Ua8c6SQmq
	 w61gW7L7vcn5ehIgRvfkVR/c+VMXajsoZ9wPL18R4heYz1ep+4nN74W7YWtyNctwos
	 NqDb+7ZjhHIZddE+w9MUhdoRaZoyIVJ3QivtJZbfKFBfZEfKn2qPBy7mWMv9dFM3i5
	 LBNquRBL+Smtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEAF3809A07;
	Thu,  2 Apr 2026 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Fix abuse of kprobe_write_ctx via
 freplace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514740829.519974.14050247148684313912.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 16:30:08 +0000
References: <20260331145353.87606-1-leon.hwang@linux.dev>
In-Reply-To: <20260331145353.87606-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 yangfeng@kylinos.cn, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 31 Mar 2026 22:53:51 +0800 you wrote:
> The potential issue of kprobe_write_ctx+freplace was mentioned in
> "bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs" [1].
> 
> It is true issue, that the test in patch #2 verifies that kprobe_write_ctx=false
> kprobe progs can be abused to modify struct pt_regs via kprobe_write_ctx=true
> freplace progs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Fix abuse of kprobe_write_ctx via freplace
    https://git.kernel.org/bpf/bpf-next/c/611fe4b79af7
  - [bpf-next,v3,2/2] selftests/bpf: Add test to verify the fix of kprobe_write_ctx abuse
    https://git.kernel.org/bpf/bpf-next/c/da77f3a9aa55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


