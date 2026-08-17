Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6A3CB2E9
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980053; cv=none; b=eWES2fX8iFU/YgUi0qYGBDFUD3dbpAS3caHVsIqE+wn1XmQexFp8BtCa8vmKbxegWJZeLhDi0+vHKxsKlvxs45Wx45QieJwGohR+4d0D05HwhJgg4p4YqdrwAWAOLOs4nx5WoflJL5CMnJF4jvhnE9p/T6UA3361RCL2PzKB4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980053; c=relaxed/simple;
	bh=nBpe/aGSAWEPSLezvJlEIYzifsiTJOufZuQpq98Ht1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X00sERngIBcr5JpYunAWIC9FmOxP+ys842Sxg0NZ732YtvCbs1f8vfD7rJeFmMql3QxAWJTZb4PzFx8oZSfXt/3VQRjZ/XZBuEcbRzQwA5svGLUAQzxkdKoTxZz7c8GXc9D/xgAhoxmZtPLjBKlaivZ4idUT6pv3QY3pttAly3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL2K+/EK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL2K+/EK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167841F00A3A;
	Mon, 17 Aug 2026 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980052;
	bh=vVJAG/JVccH6B+4RpOjYABD1E8SsJLRfJ1953HBVjMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fL2K+/EKQ/oOwPFKLegyhTpxatxYuGT8bhBemGltvpnXjK+5NihH3OmMl+Gcaa2GQ
	 90BW7sXx2MsIeFs9h/NciSmuN/loEA3rMIEEXvaxCI6rTx7HKvzK9FFO5Pertmb3Q3
	 H1Dg60A2a8EoHodswNZC3UvduuyR7SMeSChgnykNFPHL26dQMfIEr6CN8lx4zDhedj
	 70KarPueMThOK5g5omMW5OsVVoMuCBr8W9fj+eaJowZqMYnEiyrl5WApKUHtKbWw6Q
	 RC3W0lKwfPPP902N9I6BBHV39NPgZzq0d8wr4QB8SeA2kvochIQ6MHugCnGZ8OEf2/
	 eSLI3aSdeGliw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938C2380690E;
	Mon, 17 Aug 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Retry stat generation in
 cgroup_iter_memcg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178698000441.1184401.15726013769999807610.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 15:20:04 +0000
References: <20260814232017.2839959-1-andrii@kernel.org>
In-Reply-To: <20260814232017.2839959-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 14 Aug 2026 16:20:17 -0700 you wrote:
> Each cgroup_iter_memcg subtest touches 1024 pages and expects the matching
> memcg counter to be non-zero. On a host with many CPUs it reads zero
> instead:
> 
>   test_anon:FAIL:final anon mapped val: actual 0 <= expected 0
> 
> memcg stats are cached per-cpu and only become visible once the periodic
> flusher runs (FLUSH_TIME, 2s), or once pending updates cross
> MEMCG_CHARGE_BATCH * num_online_cpus(). That threshold is 512 pages at 8
> CPUs but 8192 at 128, so a single pass no longer reaches it and
> bpf_mem_cgroup_flush_stats() returns without flushing anything.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Retry stat generation in cgroup_iter_memcg
    https://git.kernel.org/bpf/bpf-next/c/3d9393ff98ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


