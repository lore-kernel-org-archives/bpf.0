Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E4381AEF;
	Tue,  9 Jun 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034620; cv=none; b=fDZn6HcLooUbm2jlCqbGeNbJl5vm5+rI4Sci0Rc8EYuLU09FK6cF7AhFMEoQ9GuFtVg+ozcyAaPgERY3pboqYrgNBeHBCbIGmytLCI1Ak/eQQq+V58l3hplokwEaeMuChBaptjjS4JkBMQTX9im2BrNWett1HRvVveNN18+PU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034620; c=relaxed/simple;
	bh=gtyja1AfPN5eHKQAXMeIHBSKQjxsb5L0L2Z5wYhjUV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qdTv/4PyGvFCPgcboxypQuJEoPglbonXdKYIgiqoQYJ0yRZv9f0azIjAq/1g6bc488y607VZg+yPrf1fd/+gkS03wgUrc/R8G3ZmZzrjwoVu5ufZ6XBBDeHTAhxvWTeibYvMRr/a6l7MuU3evfgJXg8UlGZBJW5f68qXyBNp/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFalzrdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFalzrdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B751F00893;
	Tue,  9 Jun 2026 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781034615;
	bh=JA227PLJ34wR8bV+KjkohVo6HejSGCaeUcI3E3Q6FHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GFalzrdHmgk1t8AkSjSNDMpOBBzvH6icfUjTSZ8YMmrM/SrrRJzAQcCasWj6z/SX3
	 9cdJZzDNz9j6kPI/IEbLBMCxcVVoFeFEQAATLNkIOIsUSezbzxGMNgJLQhexsVDTO9
	 MlhfKAt+yacGBvBDxg0H7q/GNBJAVroVGrj7tLKUjktXuX5tO6ti8VNZHhR6jsJgfM
	 vtYmc1PQaW1NjX8oL63WgyknGKpi2bYBD9Lpaqf2nCpN2Xm2MUF0DsNBiE1Gok2rYh
	 2UD7L/sft1T3DPz6vCUy2nA50UMeIUCxhETwAuOMBHbdbMom8emMpqGq0/dqKLWhKk
	 AS7qYuWB5SAXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E039309B5;
	Tue,  9 Jun 2026 19:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf,
 lpm_trie: Allow sleepable BPF programs to use LPM tries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178103461364.2620314.3413571029788507354.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 19:50:13 +0000
References: <20260609135558.193287-1-vlad.wing@gmail.com>
In-Reply-To: <20260609135558.193287-1-vlad.wing@gmail.com>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, toke@redhat.com,
 emil@etsalapatis.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jun 2026 06:55:56 -0700 you wrote:
> trie_lookup_elem() annotates its rcu_dereference_check() walks with only
> rcu_read_lock_bh_held(), so a sleepable BPF program that touches an LPM
> trie (e.g. a sleepable LSM hook calling bpf_map_lookup_elem()) trips a
> "suspicious RCU usage" lockdep splat on debug kernels: it holds only
> rcu_read_lock_trace(), which that annotation does not accept.
> 
> Patch 1 relaxes the rcu_dereference annotations in the trie walks so they
> no longer trip lockdep from the Tasks Trace context, including the
> trie_update_elem()/trie_delete_elem() writer walks (protected by
> trie->lock). Patch 2 adds BPF_MAP_TYPE_LPM_TRIE to the verifier's
> sleepable map whitelist so sleepable programs can reference an LPM trie
> directly, not just as the inner map of a map-of-maps. LPM trie nodes are
> reclaimed via bpf_mem_cache_free_rcu(), which chains a regular RCU grace
> period into a Tasks Trace grace period before freeing -- the same
> discipline BPF_MAP_TYPE_HASH relies on for sleepable access.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf, lpm_trie: Allow access from sleepable BPF programs
    https://git.kernel.org/bpf/bpf-next/c/2f884d371faf
  - [bpf,v2,2/2] bpf, lpm_trie: Allow sleepable programs to use LPM trie maps directly
    https://git.kernel.org/bpf/bpf-next/c/a3d76e27bbbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


