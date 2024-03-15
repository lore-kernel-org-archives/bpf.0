Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B43D2F0
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469831; cv=none; b=sc80tc9Esk0+WiVqTgDRVLWkeCLV17JGAxVjuZ+zx/XNWvdzkZGln+eH++jsrvthZt09sb7a/G3lP4ksmluIn4aLCZs0yoD8u1dRhFfUFf9lhM1csPbK7F/xKM4qVJjyJDxw6rJTaycgt/zF2kCPSM9OgbFz3UQBSLs8w8SXm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469831; c=relaxed/simple;
	bh=fY/NX/cQMM22dyD1v3nx5fyqpjC9sBZkxAMZqKsHZVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kSDE46kOpD5tSHB+5/oUnLDE61THaZQ5G/zYmzN2ise612obFCeO4DyEcMQhL8Zx4KajbjoCohFcdmRiGhQAmrNIQEWQPEKfWyMSmTB8U0R4Qm7Gkg4PfNHbwEnHVzBiClAdVLlnzYJ+Nmxckmaw/2Fr3m2Ke/T+gEFmLk3Jgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN2Qg/du; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN2Qg/du"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17A57C43390;
	Fri, 15 Mar 2024 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710469831;
	bh=fY/NX/cQMM22dyD1v3nx5fyqpjC9sBZkxAMZqKsHZVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eN2Qg/duvaBF5GD3sAZt9nQcY9k7Xs7iiSD2hKW3JKiBWfYieEqBHJTLiqwkhQFdQ
	 7DhDXnxxDFoHnFydInxXuPJCnjYS5zFlwX+RwGxaqvTdvZQkFa+iTI4QAlMKp89qJ5
	 MUKR6by/vPrxoJcrzzW8kTZdXHZq0UDTtZYYF2w8PTJBjF2khRl6FuMZYD+k1y8Mvb
	 qw8+r8Bhayv4FlliH1nO75HK+vsOnzrAdr7YZSym0eycksEK2u1ZOhF+5L/gTGlB7G
	 Stj7gkjo7zScMQVEA2BWoS+ph7DKvL2MMRUxeIO8EryvUnQXsumnpBBh4un5ZJaSWz
	 mL4iMnbZ8O3nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06404C595C3;
	Fri, 15 Mar 2024 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: preserve sleepable bit in subprog info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171046983102.25404.3149367929106857077.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 02:30:31 +0000
References: <20240314000127.3881569-1-andrii@kernel.org>
In-Reply-To: <20240314000127.3881569-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 13 Mar 2024 17:01:27 -0700 you wrote:
> Copy over main program's sleepable bit into subprog's info. This might
> be important for, e.g., freplace cases.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf-next] bpf: preserve sleepable bit in subprog info
    https://git.kernel.org/bpf/bpf-next/c/4d8926a0407c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


