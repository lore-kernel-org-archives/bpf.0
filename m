Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3262256D
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281228; cv=none; b=GQ0mEh9AMkwLeP7APzyK7hr+9wNxeDr/eMgUM03yXyi4YAK1psl1ve6R6cQeUqYWygRpudMHifM0Thwaj7b3vXwfaK5w8cp67RS77b5NZLiHGJa5NOFwmiDzj2XKKMXGMdtjz7SIe7a1j6qngbxePphOIkCrbfErGAQpRl5qpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281228; c=relaxed/simple;
	bh=PQouqZSiwPygkE2EdGmB/q3JBUUkKc0qgGmnGLa0PAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Va/IfiBY/2GdCug947tkdZidgIx9qxKcaUeh92RuT1QNeql6zBSapuqddg9s0tGGDHZV5llynayfVZbGCGpLbmHdExLKN91kVTVbfpC/P3dO/3gRK3aeYgAcmurNoUdAdN5Xt/iJdawFWB55IbLwLUaYj99kofVFbbYkp1vMtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFrMlGHl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFrMlGHl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07490C433F1;
	Fri,  5 Apr 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712281228;
	bh=PQouqZSiwPygkE2EdGmB/q3JBUUkKc0qgGmnGLa0PAE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gFrMlGHl4R5NbZY83gtuaYlrPoibj1c/4XD7FAxad5d98xTgqKBo1abWEg9uOPCTq
	 aAQhjvjpytIwoz8Rav4+cehJwl9w9vWgABbnISYEWWSsRZLf34S/W90yzU5ycjQqvt
	 Puw8uuCn5tHXSk7gbSWLwxCyUexOp7XbUvJ4JPmVVgdke+M/BEo9AWc6le4fzjWrQ0
	 VSiSEi1YO3tcsnb4i3RkDaWVJtWwq/U/KLlhNo3t2lowxrkc9PhUlIvE2l7TOuBeqV
	 Vcjh+WD+QIYRkBVoPuQYFVzU1IHzlwGriTzPl5Y1HMXVn3Yj/JYzgov2kR7ScxJcFl
	 hf1n4FGGvAmWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC7EAD9A150;
	Fri,  5 Apr 2024 01:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: prevent r10 register from being marked
 as precise
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171228122796.16303.6942606089106269993.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 01:40:27 +0000
References: <20240404214536.3551295-1-andrii@kernel.org>
In-Reply-To: <20240404214536.3551295-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com,
 syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Apr 2024 14:45:35 -0700 you wrote:
> r10 is a special register that is not under BPF program's control and is
> always effectively precise. The rest of precision logic assumes that
> only r0-r9 SCALAR registers are marked as precise, so prevent r10 from
> being marked precise.
> 
> This can happen due to signed cast instruction allowing to do something
> like `r0 = (s8)r10;`, which later, if r0 needs to be precise, would lead
> to an attempt to mark r10 as precise.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: prevent r10 register from being marked as precise
    https://git.kernel.org/bpf/bpf-next/c/1f2a74b41ea8
  - [v2,bpf-next,2/2] selftests/bpf: add fp-leaking precise subprog result tests
    https://git.kernel.org/bpf/bpf-next/c/343ca8131c35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


