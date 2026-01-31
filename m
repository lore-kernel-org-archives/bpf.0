Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930202AD0C
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836817; cv=none; b=BEvm3fJl4aD6P/6pM/66LGfq1nDBSb/cSf8nEffDRcOtz+rja4UrRo9n50q0M+zR29GNYloQ6e3hRVAplrMis6G7ePS0eQlUhir99GmlQn4thG66OhBAVjmN65wHZLxC77AGGujSMSY1WRYmjgkiuFRW2BiiNJW0ZNym5MvRts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836817; c=relaxed/simple;
	bh=5uanaFWIbirOAgV6ubPTnPCc9k5+D2sxp/+kJXiODLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Slm1ISSpnqxjGspxyBzysbbGk2JGeGYdACpshNg17prSlPgvk3SarMtVX+9UfuNOaG5LsfvtFtpp7fqMFUHaIC3O7aVzaqcz7N8gJAa+vl2+V73+7IXYxma+qra7QLBv/YZydz8nHxVRQIYP1HDJb6RqDTWkmP7vZ4ujqz+za74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H19pxq2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H19pxq2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C3C4CEF1;
	Sat, 31 Jan 2026 05:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769836817;
	bh=5uanaFWIbirOAgV6ubPTnPCc9k5+D2sxp/+kJXiODLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H19pxq2WY4KqWEBaWBXk1e184Xcr+bF+2t/6iIQ1HqpjWNBBIzpQWONoR2DErHnzI
	 xYw5Z41I4QQiSyGXRjXUOoKUgkhL40oQ7olarNVBdiIfTxj1GwjM6IRmtysXcs2kV9
	 ZtfEMen7HqlzonPYDKqyyKUxph4xvi+a0M8lIkpSiCr5nGwPY9LeC2GOYIV+yg8nhX
	 8pAZ5jg11bBVysV4Pk5XLc2sH3RLxs6V1E8AQ6x1bhnfGKHI9eSsI/mIOifA3hnt6K
	 eWKgRiwEBlQcuxmTy2mlBywNgby71NT3j+ql0wWE4leSuBaWAT6KlpBhCww07FWpZF
	 DClJA2yd8+ivg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD5C380CFFF;
	Sat, 31 Jan 2026 05:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Unify special map field validation
 in
 verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176983680936.4010965.17327888106509712903.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 05:20:09 +0000
References: <20260130-verif_special_fields-v2-0-2c59e637da7d@meta.com>
In-Reply-To: <20260130-verif_special_fields-v2-0-2c59e637da7d@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, ameryhung@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Jan 2026 20:42:09 +0000 you wrote:
> The BPF verifier validates pointers to special map fields (timers,
> workqueues, task_work) through separate functions that share nearly
> identical logic. This creates code duplication because of the
> inconsistent data structure layout in struct bpf_call_arg_meta struct
> bpf_kfunc_call_arg_meta.
> 
> This series contains 2 commits:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Introduce struct bpf_map_desc in verifier
    https://git.kernel.org/bpf/bpf-next/c/98c4fd2963cb
  - [bpf-next,v2,2/2] bpf: Consolidate special map field validation in verifier
    https://git.kernel.org/bpf/bpf-next/c/f4e72ad7c161

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


