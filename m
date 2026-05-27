Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889E1B4F09;
	Wed, 27 May 2026 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915602; cv=none; b=s0Dm+FIUkF2PKT8XDfQb3Ucrtsv46NNf2VSYMUIools96dmRg1MV6p+tprI6wyCVOqLszwMIfmMrytlUn7q5GSUHuDg1qK4DTe2oCyOBMhaCtde80l6WoRCRwuKb2jbWfpkSNFoyulxzBoRRfmgk3eT860PtKvdmEr+ayhy8Vxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915602; c=relaxed/simple;
	bh=0WQQcpdEAxLNt1k5eHfbLQoD0/1eEAKxhz9+8Q4a7kU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mKytRiBPTjdM3tvCMs9Y29SGdchWpM1bEZClmgzQXMnzhb/mWACk+rf9cXTAMNp5aHyIo6k2pelYDkEp/0OYVuNGPh8/+5wbYMjiV2IEZs5Hg7XJN1HvLwE+hsG7A8ZvZCXBU8e7HQtaIa5nqJQB1J8g174lt94CXOHcWOLrgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW1BAaaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW1BAaaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6A61F000E9;
	Wed, 27 May 2026 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779915601;
	bh=l/JLl9VLTP/Gm2tarXCEuUlfyXeVSAUq6Yvpw6kaNJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gW1BAaaTsWH/qsay1x1JXLrAm9s7CHPU2lhJeVnpZSOJcUPf9R3XcXABGC1kzFZJ3
	 6IvUOO0zV8Lp075xIEDax3ua5BdMPVrlZl324HhyMbVJEJh4goTQr6OghOaLEdkss9
	 d9McKtYx9FjgC7MZCTnmw3fUOL5ORIGWmpGsIVmdSUPsnZMaav0Dl1jhjkG1QEKj3F
	 AXAo+r+ON3KtJK1t2EvW/JeT/CfN/MwGa7y4w8jFKVq9lXrEVLmbupUMaZoQlJPL8v
	 z7rH7m76iluI65aOLTlWRL8TkpZoyL6KK6cOMPq47c5pLA0NOyHjJ7tiGr2pxhkf6F
	 4pAH2eNlVdTCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B71380CFEF;
	Wed, 27 May 2026 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_arena_handle_page_fault()
 redefinition
 without CONFIG_BPF_SYSCALL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177991560565.650332.12549553605514557955.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 21:00:05 +0000
References: <20260527192632.2109419-1-tj@kernel.org>
In-Reply-To: <20260527192632.2109419-1-tj@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com, emil@etsalapatis.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 27 May 2026 09:26:32 -1000 you wrote:
> On configs with CONFIG_BPF=y but CONFIG_BPF_SYSCALL=n (e.g. arm
> multi_v7_defconfig), kernel/bpf/core.c defines a __weak
> bpf_arena_handle_page_fault() while bpf_defs.h already supplies a static
> inline stub for it, causing a redefinition error. Build the __weak
> definition only under CONFIG_BPF_SYSCALL, matching the bpf_defs.h
> declaration and the CONFIG_BPF_SYSCALL-gated strong definition in arena.c.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix bpf_arena_handle_page_fault() redefinition without CONFIG_BPF_SYSCALL
    https://git.kernel.org/bpf/bpf-next/c/e42e53ae23b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


