Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A351E52C
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323227; cv=none; b=P7UO13qBgSpezxT1DvGhiQNLm5IU1Fr/ik3v0oDFd+iMrsDuwWvtFKZFYhFWjyC2ineYwlggEXA1xgXA398jrElpwYD3fPh6ZzEnPKbAwAhTyzAjjkqkI9HmyHn3uStVg7d43+X0jg8PGQrVkj16jvozLlRTZICFVQKzCDTX9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323227; c=relaxed/simple;
	bh=wdU8aLFnsMSAQxGtYkAGA5WKT9rSwzZ3MBirjBQawsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MRhpIjfVWJxqO4XDwKGDtvtH90DvyzdpKRL0e22PO7N2pPcfebjnUGl3Wcl4J0VsoSuyDqrIYHqLujeFp8jqsGJk2sy1/7y80BXXgQJGORRTlmAAyUogQ8onGDo1iACknXpnIP+7qd8cjQAtSzS/fiwta+t1Xtj/FkCxwB8D8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNjw78E1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNjw78E1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49165C43390;
	Fri,  5 Apr 2024 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712323227;
	bh=wdU8aLFnsMSAQxGtYkAGA5WKT9rSwzZ3MBirjBQawsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vNjw78E1Is3LncVftvD++LuSL4m9lp3uIHuP4xt7tecoao2rYemXkm6wZ3PHTKo81
	 lnvamvgitkWJbd9yxXI7uXxbIj79f96dubL46zEN6rUdRapWXwu39VcwjqxpaU2Mi4
	 a2J3uFBPgiClO0HiQdDcqTdth1l25Ngfxvedll++fOc+/RJXe4mMNrAv8b84f1/Lrw
	 kJ4+95gGna07ulDadByBbTdH+mttIXl3yrSiDjtnpVH6hrYG9WIxkahcJu75vxfiPa
	 0JISInGwryDtehLPXumq0XguF1I3B4naqB75znxREMlamffcSvdpI/JBo/YiUxN7e7
	 CrWdKVxpXtXQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C98BD2D0F1;
	Fri,  5 Apr 2024 13:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf,kconfig: fix DEBUG_INFO_BTF_MODULES Kconfig
 definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171232322724.32675.2075271750135925551.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 13:20:27 +0000
References: <20240404220344.3879270-1-andrii@kernel.org>
In-Reply-To: <20240404220344.3879270-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, vincent.mc.li@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Apr 2024 15:03:44 -0700 you wrote:
> Turns out that due to CONFIG_DEBUG_INFO_BTF_MODULES not having an
> explicitly specified "menu item name" in Kconfig, it's basically
> impossible to turn it off (see [0]).
> 
> This patch fixes the issue by defining menu name for
> CONFIG_DEBUG_INFO_BTF_MODULES, which makes it actually adjustable and
> independent of CONFIG_DEBUG_INFO_BTF, in the sense that one can have
> DEBUG_INFO_BTF=y and DEBUG_INFO_BTF_MODULES=n.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf,kconfig: fix DEBUG_INFO_BTF_MODULES Kconfig definition
    https://git.kernel.org/bpf/bpf/c/229087f6f1dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


