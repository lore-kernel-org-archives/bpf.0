Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0112F5A2
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558232; cv=none; b=Q3+N00zQuek8SMH1wJ2F1gVKCaR82GtetEOdaXS7HhRZBvqlEf8mB0xZek4emaSZXsiVHD2s/I066PiR2LnHFYbqeqCsomQo1ktDjzq91V8KADgZ61USp5zlqXsFeepj//aPZRwugg8rIKcGRNuFRMawjW9+47MY1LBh/LIyPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558232; c=relaxed/simple;
	bh=D6OhoZwlpvWinHQgPMO4Ym+zFaTB/BdkqfMryTftGAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S8J29Y8C1z60AYcr2sooGSXJ0cRRVMIGhfKPTFKVg613bNFVCILBIdh716WcqLemjhhbarNQ/4k63wHVB1A2lOKcv5p/aysgrSgENqkBrKvK7UgIi/EUAL/sKT2kChtOQAUhao5r0SlYWXteNGW8IREeDsRc9C83hjt0yl0/qPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1B2tWsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1B2tWsu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8BBEC43390;
	Wed, 27 Mar 2024 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558231;
	bh=D6OhoZwlpvWinHQgPMO4Ym+zFaTB/BdkqfMryTftGAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D1B2tWsuh3etjIoXHD5Ozot23q9JoRAnTiQHG5S+BouB2BMbNqIuB0Xizki+7ted0
	 fohz9T6ruRbtwEKtW52MiFACDy/pobMBO2DCOmlk34qfpKoz2kiNd7ycVhoJ1igaQj
	 eGcYWPckOSjX6Skh4Oa1GDl1Ibuw1uqdFrzMLKpEc9JGiBSzwHXPfYosngkBEjo+u+
	 CoUL3pS1qDxdYZwBqLq7Fijs3Y4WqlKrJ5AHFECOm+V3+AeFVBR8oBg/L0YCeY4SQ9
	 48yIj3lG8QvpYFBjWjB8F077nq397WVcWZsPHPGp5SZAzqihk3xWmjpeNxJw9OPjsf
	 DC+2l9msGHz5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8334D95061;
	Wed, 27 Mar 2024 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 bpf 0/2] Check bloom filter map value size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171155823187.28682.4569570365467320556.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 16:50:31 +0000
References: <20240327024245.318299-1-andreimatei1@gmail.com>
In-Reply-To: <20240327024245.318299-1-andreimatei1@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 26 Mar 2024 22:42:43 -0400 you wrote:
> v1->v2:
> - prepend a patch addressing the bloom map specifically
> - change low-level rejection error to EFAULT, to indicate a bug
> 
> Andrei Matei (2):
>   bpf: Check bloom filter map value size
>   bpf: Protect against int overflow for stack access size
> 
> [...]

Here is the summary with links:
  - [V2,bpf,1/2] bpf: Check bloom filter map value size
    https://git.kernel.org/bpf/bpf/c/b018c30d030a
  - [V2,bpf,2/2] bpf: Protect against int overflow for stack access size
    https://git.kernel.org/bpf/bpf/c/8a1f008933b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


