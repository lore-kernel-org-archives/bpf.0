Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C251E5714
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396668; cv=none; b=J2rw84CRyos1llQ4JW3TLcXixBDAOuW2f967gmUOIDIPBKqpouXy438+ubUxqA/vJHOcD4wmO4K8Cw1VXJtAtNlrdOB/ISfPohaogm+mrIxnCuSln/1qp2luVjn26Lbs/EYEKQ/nWfhC42Ah/qGZPo7r//D3zkAzHM7grUOWnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396668; c=relaxed/simple;
	bh=USV91Y/nK9pn3AQ/1/kzF/5EyVDldgql0JnkgdUUI7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbrQeNa7Fvc9LRZG1NUliOk5Ki7/hmrEDptqMLy5St9HajB2SptC9S23TfOvRPcPVCL5Cv13PtP4OGG4dJem278oiATwruF+iOmVmSCI9AcTxS3gDaurAZEMCXC5XTE6klVtlwGGWvuIzgO2rbbBmHj5+PLTeNWCmaUq7zGa7ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIKf/OUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIKf/OUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CC21F000E9;
	Thu,  3 Sep 2026 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788396666;
	bh=fhHDesYJPZ6Of1e+qE1Q2KEJrOrQLuW4HaY7qlajV1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dIKf/OUKNUdRqU/tYmFEMPyATjJb1e1gAnl3I4cyw/d8xQOOv3aKkxE8ZAc3hvZD/
	 K8RNhlJFuHOF2jfwxFTLOu/EPiNRR2WUAkLHE67+AMX+YLywYE4nda1/Iy1yCXtCt7
	 iY4oPhmxkJhaiIJw0NZpds7w2FLDItuDeHJAuZlq5OT0IoTfodRQN4HTTlHSmz152h
	 q/mcuDps7TOF7n9bHubPuSZwpitU+C1A29iM97udu2BHpFWClePZn7PjyZKw417Lni
	 x+9UbZSgmJhM9IKKJki+ijk+JQr5ii2Joxn9+faHVQDtHBW2UwLsH/AtGHbDa4OHEQ
	 46xHSku4WAdTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F73927054;
	Thu,  3 Sep 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: reject BPF_PSEUDO_FUNC reference to the main
 program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839660765.3021740.4286063453849532120.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 00:50:07 +0000
References: <20260902233658.1186477-1-eddyz87@gmail.com>
In-Reply-To: <20260902233658.1186477-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  2 Sep 2026 16:36:57 -0700 you wrote:
> fixups.c:jit_subprogs() rewrites BPF_PSEUDO_FUNC loads to contain real
> function addresses. This function is invoked from bpf_jit_subprogs()
> only when env->subprog_cnt > 1. Meaning that for any program like
> below:
> 
>   int main(void *ctx) {
>     void *ptr = main;
>     ...
>     bpf_timer_set_callback(..., ptr);
>     ...
>   }
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: reject BPF_PSEUDO_FUNC reference to the main program
    https://git.kernel.org/bpf/bpf/c/374b2c5561db
  - [bpf,2/2] selftests/bpf: BPF_PSEUDO_FUNC reference to the main program
    https://git.kernel.org/bpf/bpf/c/ac0aaef0aa99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


