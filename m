Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC74908B0
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848846; cv=none; b=nN3gyOBSHcz8+9S+P5quM99ji8ilm3wxhu0hM5eDvWB23OVyJ7/z8lenHoYQWIV7JlJnTStePDFoAtTMkdlbM/szrPjYhrELu0xCLoGvhJe2Es43uXFeirv1cxoj/Kmz8RQtUSCixlK3eTBDVMw3lbEvOATqAVODqWD4LWU8kHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848846; c=relaxed/simple;
	bh=27Q/muHtW9YC9vKUR4G2aOdbVpINCWX50/8IFIaxic4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l3sbsncFLuND/MqOWjUCXkQSJ2ryYjsTDj+khB3jI6ZKLZkGfQPTgyDRNQgkJk5MDTtOiuo+8szBctx8oWZ8/aZb6gqwQCnotot5F9mVIUQ9Glbkzog3NDaBNaOWb6kv0qpl95RMMS5qmnUhp2iRE5WjQs5Z9LbKgyknBlsorWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkl174kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkl174kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476111F000E9;
	Thu, 23 Jul 2026 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784848840;
	bh=N6Um7pWQ0dp9Er45HMpKvhwWGkTPIjOm0ssG+JFY+dU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dkl174kdnlK6xvb1qrgsgdoeSIbN2EDiXApQunYWynYhczLAqizhrvRzONVnPPatf
	 YlyNT1fuMioBD8ILk8H2xNF6EwH3zVPTTVushP4F284MfMj+I8s8xPGNVUw9EtMday
	 /+DATZziG7X8EABn+QzD21jLJ+8yqJXblwqMgZm2ALG4tN1c3BfyBgs41g0LtQ2LJ+
	 4KKOucKuqGymZi7b62funnLSfDY4UY0mn4sLj7CjFKIJlI2ehC0tfJScfQEQz7uo4B
	 sb8PkfaBBc9rXS6+3fWnbmUX0fi2TIb8qGT1x34g+zQbYgthrj5IUiPFSIKnvGiWfB
	 nOsuxPwPOZh6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C93924A3E;
	Thu, 23 Jul 2026 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject passing scalar NULL to nonnull arg
 of
 a global subprog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178484880790.2910968.7200730529599928400.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 23:20:07 +0000
References: <20260723221815.367797-1-ameryhung@gmail.com>
In-Reply-To: <20260723221815.367797-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Thu, 23 Jul 2026 15:18:14 -0700 you wrote:
> A global subprogram argument tagged __arg_nonnull is set up as a
> non-nullable PTR_TO_MEM. However the verifier does not check against a
> scalar NULL, leading to real NULL pointer dereference. Reject it as
> well.
> 
> Fixes: 94e1c70a3452 ("bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args")
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Reject passing scalar NULL to nonnull arg of a global subprog
    https://git.kernel.org/bpf/bpf/c/289e680c89ae
  - [bpf,v2,2/2] selftests/bpf: Test passing scalar NULL to nonnull global subprog
    https://git.kernel.org/bpf/bpf/c/55c7bd2ddee5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


