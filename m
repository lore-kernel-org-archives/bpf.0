Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE6225417
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124422; cv=none; b=ePdCNqbJ5b05MCPCBBDbfvmKdeK18yFM4rbf2mH0xL+mNi3/e0wUQn5ybOs4fdRjHdIlSA74QdFD2B/i6O7p4cgq2YxcPtkSbDdYzJwAC1NsMyKgZkbp0t4r9EDivfeUvj2TIOx1oJ4k1llReGKJX9E24qcqoqszXZaFEC9QCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124422; c=relaxed/simple;
	bh=74MnQGS2ysRDtX4Pq6BqEyFwckDC17L6kX9cNohcVuo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iRNGjprsQ3sdn2TmVoBjaLkYCEVPrqwcMONQz6kTB0fy5qLqnyeY7cIAO50zd3Y38jsNxPouFFeUwroJ76TO3riFF62IQP/eJJeGoODwM1vNFLUto1viJ43x2URSlczozMlsPDin5PPXX0EkFhA4Klk1L9gNdxFt3LHfU58RZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkE9uUoz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkE9uUoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E7BC19421;
	Sat, 21 Mar 2026 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124421;
	bh=74MnQGS2ysRDtX4Pq6BqEyFwckDC17L6kX9cNohcVuo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UkE9uUoz5gPfcWcLXn1G73K2/ida8T4xXGY/6KnRwi8WkNjBPD+26DuoLMrz05hgW
	 UmZ3rks84Fu5GmvOwlArmPkVNs3aycbOQC1du1x7TI9EdnCPU/Nt+lLw8IL7oBN/TP
	 IriLrG+85Q2YiA8WZirslhXIltWIAK8Ud7L9erk3mS5IKXHAgUy4I573JSoUCQDyo8
	 WaEdYuqyhsrrrjh0s00v8ZSoufG2IXyUlc07HKFO8R1IPJnosbIM4ZrlBz5x5pwMWv
	 sozxVldGd+NulpWgST2kxYjsXYCL22nsQmb74/enhXyK5ezUMBtOhSUmwZIx5Zcfar
	 75q7nd3R5LpjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEB53808200;
	Sat, 21 Mar 2026 20:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] bpf: Fix abs(INT_MIN) undefined behavior in
 interpreter sdiv/smod
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177412441129.2951219.8888701346937198649.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 20:20:11 +0000
References: <20260311011116.2108005-1-qguanni@gmail.com>
In-Reply-To: <20260311011116.2108005-1-qguanni@gmail.com>
To: Guanni Qu <qguanni@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, mykyta.yatsenko5@gmail.com, yonghong.song@linux.dev,
 jiayuan.chen@linux.dev, lkp@intel.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Mar 2026 01:11:14 +0000 you wrote:
> The BPF interpreter's signed 32-bit division and modulo handlers use
> abs() on s32 operands, which is undefined for S32_MIN. This causes
> the interpreter to compute wrong results, creating a mismatch with
> the verifier's range tracking.
> 
> For example, INT_MIN / 2 returns 0x40000000 instead of the correct
> 0xC0000000. The verifier tracks the correct range, so a crafted BPF
> program can exploit the mismatch for out-of-bounds map value access
> (confirmed by KASAN).
> 
> [...]

Here is the summary with links:
  - [v5,1/2] bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
    https://git.kernel.org/bpf/bpf/c/c77b30bd1dcb
  - [v5,2/2] selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend
    https://git.kernel.org/bpf/bpf/c/4ac95c65efea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


