Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067538F945
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294600; cv=none; b=DfjVVJUT17KqymTTlE1kOrkfiNHGDx6mU6aP5kRYJasDjqowPktCzbOt6O/C+hop2MCtG6zsEzjd6w/lSZ/Rx2mcJTcxJ+FJyskwdkKDtTIRIQ6vvPlIEuInSN6mnFbtheeNd0lTyYAoUj7cYt65ngqkonsayp0xNFmwiT7TFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294600; c=relaxed/simple;
	bh=cUXplAvw7i2MERNiIeacz0VTAXi79RC741U2z7Hj9nA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J/WgqBtBOuE3UmMOtfZRD/ksNwruLf8hWqTaLsdgx8b1Rv61nGRlCpD0AnEmPM7GeN6dCcLJ/Ft5SVL+GoJNRyw8v617zMMElzJ6kgnviFELgSvHm5jrcRoxBtGjTUwarihpIU1Gp0KRrgxWKui5sQvzgWkeqBJ55om6MB59rBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7Utyvuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7Utyvuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0531F00893;
	Wed, 20 May 2026 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294599;
	bh=tWI12zJhl/NnIIHdDWDKpccTMA2Ui1kZkG7buDBj0Ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A7Utyvuv7YPr9RlWr6JNqItXnDkCnLSNo8BOiTj2PyEBODgqUgR5zhKYh9HIpbz15
	 4/0+wpJ6H5fCYwuHyZdT24tsIwAvVZFUzNH18xXMXPYQneK7ZdyyZf5F7d+cMt32pZ
	 Vl42fKZhG/EOdtw/ddD9FSXdBBvPysHQTRUQK3eAm/cuSEz60ONJWtROGWOALfOuEL
	 Bbp0Eayr1P3CtBpeNCv/GZesfJ+lJ49ZgyaPNpxI8ueysIEWOOTLIJx7bMyMcBqWuK
	 XHklihqJv5ktrANRLgqvJn/361f6bxag605j37vlXaaMvLkzqUhbu9jfAOj8p/49rq
	 fGYUQsgSODqEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0BC3D3930B81;
	Wed, 20 May 2026 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: XDP LB benchmark fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177929460989.3662293.646888504985123560.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 16:30:09 +0000
References: <20260520133338.3392667-1-puranjay@kernel.org>
In-Reply-To: <20260520133338.3392667-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 feichen@meta.com, taragrawal@meta.com, ndixit@meta.com, tehnerd@tehnerd.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 20 May 2026 06:33:29 -0700 you wrote:
> Changelog:
> v1: https://lore.kernel.org/all/20260519163632.2220753-1-puranjay@kernel.org/
> Changes in v2:
> - Drop patch 3 as it was fixing a situation that can never happen in practice.
> - Replace | 1 logic in patch 1 with replacing ^ operator with +
> 
> Three bug fixes and one improvement for the XDP LB and batch-timing
> benchmarks.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB benchmark
    https://git.kernel.org/bpf/bpf-next/c/fa747e9f843b
  - [bpf-next,v2,2/3] selftests/bpf: Fix expired UDP LRU entries in XDP LB benchmark
    https://git.kernel.org/bpf/bpf-next/c/12e896b9794b
  - [bpf-next,v2,3/3] selftests/bpf: Filter timing outliers with IQR in batch-timing library
    https://git.kernel.org/bpf/bpf-next/c/abac8acb633a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


