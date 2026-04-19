Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4733F39C
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600642; cv=none; b=teF4PM6WV7PxlzpALaYC+M312YOQ/dhd0jz6Q+4q3/Z4/C1GRvPLvoc2NWPMGv/DAiCE5PNF0i6puKqnOZRZXTpHkUCMTr4qHAnklCyClchimoBOF3CEWBmMUWWBqwJ3BWEuN/YeWPdOJeDC3FQWMJIIFTg+9bgSpPCmA9ZLwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600642; c=relaxed/simple;
	bh=XWQBX4w8S1ZsVsF1DNysDTwoseBsJreg1lAJ0WhjnOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lktahYzfugu7e/gmZwdVYuUDQ1BjgSr20Wb3IQISmCuhI2NaXujPURyU3qR1afVv56JmIoO+Fw0MaM3g/lk04cbaeDQgu9LOo5d+X+2okVpa7C2O9JWKLIsp4fwMbZ/c0PfbeQTf7w3egbe7RMEd6zywSyFPxsr6IesEkL5rHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG2zWPlQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG2zWPlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD704C2BCAF;
	Sun, 19 Apr 2026 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776600641;
	bh=XWQBX4w8S1ZsVsF1DNysDTwoseBsJreg1lAJ0WhjnOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WG2zWPlQeryfU0fE5i9bcEZaRtxWNCuqFt51ZhnM3try4njCrcW4l0LxIn3VspJYz
	 /Mrzr09M/fmsFqY/YED61m1JfkqTlWqPEphF4EtfHrBstLzIMUgZuiUcyLMaLpQ9dD
	 X0Tp48I4PrD9UvrfBrawSXBLtMXX2hrhpNgITwL55MEqlUCV07NdtV4NXIbXYUI5de
	 m+OaMAkwLAntNyPyx2QNnjUy4I+Iu3j0qbgJhf7WnA0BER5ApoKVZUvXD+5E/cCn6L
	 9jz7IryUBE4ahrmAEuT6YV25oc3PggXJeSjcb3HF+uqjfmFlGUIea6EKg/u8EyuAPD
	 fH6f/YONqCFOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F22380CEF9;
	Sun, 19 Apr 2026 12:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/1] selftests/bpf: Trace
 bpf_local_storage_update
 to debug flaky local storage tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177660060732.747443.11265955963985803869.git-patchwork-notify@kernel.org>
Date: Sun, 19 Apr 2026 12:10:07 +0000
References: <20260417233631.1443199-1-ameryhung@gmail.com>
In-Reply-To: <20260417233631.1443199-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri, 17 Apr 2026 16:36:31 -0700 you wrote:
> task_local_storage/sys_enter_exit and cgrp_local_storage/
> cgroup_iter_sleepable occasionally fail in CI possibly because
> bpf_{task,cgrp}_storage_get() returns NULL. Add a fexit probe on
> bpf_local_storage_update() to capture the actual error code when this
> happens. It will allow us to tell if it is trylock failure in
> kmalloc_nolock(), timeout/deadlock in rqspinlock or something else.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/1] selftests/bpf: Trace bpf_local_storage_update to debug flaky local storage tests
    https://git.kernel.org/bpf/bpf-next/c/7c528b364bd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


