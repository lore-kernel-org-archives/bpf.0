Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B1435A82;
	Mon,  6 Jul 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377031; cv=none; b=dMjLXZbwmtuFEUyyTlNUK6O1EsXTY5kLtv9N8J72NUxAzG9CyO5CL9mVJgt7ujIFXppvxuNWqA2V7rxiZzM7QmW/HcIExtrESomZeDwPgDdRN89EYWqRMBJYPcG7cjvbZ1E1Af2AkXXTBjDEUpQ9RVqFCVAOpC82EmFH8gvOv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377031; c=relaxed/simple;
	bh=ZJJeiZf0MX7CN9hj6QYMMYe8rJqX8BU8zE/RobwtHpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ur6BW+pFH1MTDtyt3GhYtxacLABPvGSw9+f4M7s7D8Cwr3j0L34eiY6q3t9neCP07lttehQGXekNIV/nFmFqtYt/QKgqBhSzgsxEx8CgAh5Gk/W+392lRJ6KkUVnicSfEI5Aevr+hO+NQeIMzDT64GoXg2CDrvTF5ChvwT4Xh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAOV+y6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAOV+y6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515681F000E9;
	Mon,  6 Jul 2026 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783377030;
	bh=9n5pRHgZeiOoef1SAgYJvK2vfvoIYbJ6WL06PbrHzyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RAOV+y6OEB3RfyRiD+VTm7K350XUQxnypMPiTl0onQx6aTqzSt1Iul7+ziBkBBPNi
	 r5BiZpo0pH1fC89MKsKi2U//cw+n0dx2o+1Qqe5V8BlwzrqTniZ9Oh6jt91TLEykbB
	 xA3kqHsSXPawmRfMpy4PXM+CyeJuwv75EQdJxU4BHAe3pURafLyDPGiOEuGf4vGPj7
	 4IfLrLz6FGKkAhhk3lpdUbnk+EdJ4w5K5/W2Q+cu9itKvJQ+VrR6vZo0/7DY8vqgMu
	 zQI+erLBZPD3MsigV/eK/M3fIJ90L9QXFNhvEw7Bh7/cAiqYpZQxAc/D1g4u0K0bHl
	 nw9hdcTHudB1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD03925F73;
	Mon,  6 Jul 2026 22:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Reject MEM_ALLOC BTF accesses past
 bounds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178337701039.1232545.8737132384800629878.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 22:30:10 +0000
References: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 30 Jun 2026 08:41:25 +0000 you wrote:
> BTF struct walks can relax the top-level struct-size check for trailing
> flexible arrays. That relaxation must not let a PTR_TO_BTF_ID | MEM_ALLOC
> access escape the bytes allocated by bpf_obj_new() or bpf_percpu_obj_new().
> 
> Patch 1 rejects MEM_ALLOC BTF walks whose access range reaches past the
> current struct size before applying the flexible-array relaxation. This now
> also applies to struct ID matching used by kfunc and kptr type checks.
> Patch 2 adds a linked_list negative loader case for this path.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Reject MEM_ALLOC BTF accesses past object bounds
    https://git.kernel.org/bpf/bpf-next/c/a642e693cecb
  - [bpf-next,v3,2/2] selftests/bpf: Cover MEM_ALLOC access past object bounds
    https://git.kernel.org/bpf/bpf-next/c/d17f5823ca8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


