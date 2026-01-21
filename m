Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DB2D8DC2
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768956610; cv=none; b=fe8OgNbIqLnrJbkcTLmgX+ppvkZ6jCw+PIqyR6j3t0R8u8Mt7RNAGYzVi4H1QWtczSkjG9WC0hnKgtn5nhzRBdSCjsmjSWWvhZ3Y1HICTa8uOWOOGA3SkEy11a+XvOt2lHGKpJC5ICUsSXcK1WGl33JVyE0vePl75/+FGdLPbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768956610; c=relaxed/simple;
	bh=wT4gwA8bhHfkRx8ePoelVkFl7eeV1SXjybp1oWf/K+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ESrAP5zzEKNDvLDLOCuNY4kRzH20KyLLtnU5TeDJ/drRw49S2DmIj1fC2YS384t0Op8OBzbiP1OdYBiS4MjOaMkEj3+xgVPzNctU/NLpDnzoVcdE5NDhix4krEZcApvcNpJynUWlciRs+Rv7LW6jg+NmcOFC4VUUdwcDjeRzZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d71nE4XZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d71nE4XZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29A9C16AAE;
	Wed, 21 Jan 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768956610;
	bh=wT4gwA8bhHfkRx8ePoelVkFl7eeV1SXjybp1oWf/K+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d71nE4XZdHkxpSHTxljBAaXQSQdROaDs7jXGXjAjpADx0WRXQg67FqL/YykKXVbB+
	 aQEIA6dY9btVSN3xatgIeSr0dgqSrCnKkz3d/zFO1vuXLiCsI8EoZ36JxCHxLihFL/
	 zmhwtXjNaXWBrhspuscl4NrAsDhpojckK/MzZfWiY5f6Kwy2a3MPOCIj4TTQE/j62S
	 31iN8L5wj1kEYx6Eqv3D/3eSaw9DnD+qgDJcsMkZ1tsmtWE/MfAai1TFaFFoy+t8bR
	 uvCWbSmgMxVWK9xEg6a1hVRsetdXfxYLssdbe2Q++4dvWusQxoXw2xpM5FcqhzD+58
	 euJT+eC/9Gpkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD3C380820D;
	Wed, 21 Jan 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Add range tracking for BPF_DIV and
 BPF_MOD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176895660735.669085.547201918994205516.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 00:50:07 +0000
References: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
In-Reply-To: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Jan 2026 16:54:56 +0800 you wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> Add range tracking (interval analysis) for BPF_DIV and BPF_MOD when
> divisor is constant. Please see commit log of 1/2 for more details.
> 
> ---
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
    https://git.kernel.org/bpf/bpf-next/c/44fdd581d273
  - [bpf-next,v5,2/2] selftests/bpf: Add tests for BPF_DIV and BPF_MOD range tracking
    https://git.kernel.org/bpf/bpf-next/c/c9e440bf25a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


