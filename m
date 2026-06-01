Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64C1D6DB5
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275022; cv=none; b=jq2k1n4CgxNJljaKi5Zx8rwGO4wZZ6zzY95KdgaJ2RNaCJDJVJP1XtzxtQFu+g7RJ39roNj6WaxqkcNtLAF2Opv4ReN0AhXJ1Sov7YI8OU+EIYjYi3lcOUDpJKLA9f2M+gHyGlZiBSmAI8epQ78/OwNtfc2X1PqLv7Mjlgsxj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275022; c=relaxed/simple;
	bh=BXOyOG7Q0lRFT6NluzTV7ghYLtmwcGoaJ5Bed70nw/k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JkTtRMqcN31qoiI4EQUBFT7OXprHoKbtMCZC03X5nr7BxpeFPoh7lmR8DNKvduAk/T6VVIPvraGD3xCiaV2t088a+brmaEKgGLs7RVZC89uzdWXlGLRjQJFvgYnNqABUt5GdYug2II2DGhWXFjg8+lJnJX1G4RRsbK94sv22dZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf2ZbdzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf2ZbdzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210E61F00893;
	Mon,  1 Jun 2026 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275021;
	bh=GV/NNL62+q12KRM7d5KYnYejFnzKoLfBM68t6soUzck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Gf2ZbdzYfj6jnopvq5kqpWJUy0umQTEZqRaRz8Vyvy3rSMTp0nZ6Jw9niNnJk/WGo
	 fyE/Kd8XaiTnjsIbuNcnD02J6umSe5iHqHhpNEkWPKjyovKjJEINfxNfV6OmUxv++N
	 RXINNwmW8TuSqqeSN6ZOuUZ7uHQgsa4APBi1Wa5sueuFJ0ssXhfxmhPqj0y7gXgFVQ
	 5OVAxBdUOFx24Q3okULov7fk8zTP2joaPwOY+UM9vzWyQU69Yq1PtKntKdCxgq58o9
	 KhyoamzOiqpXjtmpcgGEnMsUCVA9jrwLs3yc4lJf18rnqtnhJ6OhVVFCJkmkMe3+In
	 83UI7ql74PVDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1979539302FC;
	Mon,  1 Jun 2026 00:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Skip endianness swap when loader
 generation
 failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178027502364.3441607.1883494793511267828.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 00:50:23 +0000
References: <20260529162829.315921-1-daniel@iogearbox.net>
In-Reply-To: <20260529162829.315921-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, sashiko@sashiko.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 May 2026 18:28:29 +0200 you wrote:
> bpf_gen__prog_load() byte-swaps the program insns and the {func,line}_info
> and CO-RE relo blobs in place for cross-endian targets. The blob offsets
> come from add_data(), which returns 0 on failure: realloc_data_buf() either
> frees and NULLs gen->data_start (realloc OOM) or returns early on an
> already-latched gen->error, leaving a stale, possibly too-small buffer.
> 
> Neither bswap site checked for this. With gen->swapped_endian set and a
> failed generation, "gen->data_start + off" becomes NULL + 0. Guard the
> same way via !gen->error so they are skipped once generation has failed.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Skip endianness swap when loader generation failed
    https://git.kernel.org/bpf/bpf-next/c/41300d032a1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


