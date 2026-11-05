Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920207;
	b=KejidYmIx+batJZJyqZJAqvgZhb8EzmoLPhrj0//8U/8kRvTcQCQLkk3IJI/GY5pZp/d
	 c88b0DaVnpMy5WcBQQLSpOKIIzXcCnBwbDmC6WK0Q8+NK782S9IGrIItKTnFjdUbhhRAF
	 Nese4ZSmcstcRIzuuJZPtuKIZNdUCIjGyj3+0RIjUgKCcFCrqGtqKfs8bNjwgzfGNKRzO
	 gc81bW21agiWPKAhChYcFV8M67rTjTx/F3iPhi5SKLQ5GLSCela+M5qvEVI4HOz0TSqjk
	 g/JxBebGoK6lhhsyJY3S7+FPnyWj1T7FFgn6kIT6aSwtpzaklbhUvD1ssYGFwCs7Tew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=m0lF75XxYWXMEUJ361UBCB07HVTnuk0OPPAAlGVoOW8=;
	b=xRdvFC9TXdCeIbtHtj9qqYwgXEejyH7YM3mh4Xwoy9Zhan5MCiaoLNb2KpNW3UFwdNz9
	 tCaVpplCGdl4lSYeVLlpvSRbwx/hGTp56l06kGEYw9OS9ueeAQuRFve9+anm3Wlb7MW9V
	 spB1MdGiVd3wYBDvs09E91Rg6ZUJ1rBOuOKMpwJ8Q4sJjY4loWeV/VsIz+PDGWyRrPJ8D
	 Rgq9HS6nEgPI7cTa/L46XvMl+honnwy+22FrOkpucho6xmzrWtPntR7QONBJ+0VLFU+0B
	 r7WJB4v4KPYaAW9itA7uDR3Ml5lFXRDLnv2v8z61QwosJMCHHl8tTwZvfPsDxARlbjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXxHnLEA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5C606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXxHnLEA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6998D1F0089F;
	Thu,  5 Nov 2026 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920207;
	bh=m0lF75XxYWXMEUJ361UBCB07HVTnuk0OPPAAlGVoOW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kXxHnLEAe+bNu8EyRznIbzI2vRWga5s85Z1wiDQbSIJJiHMsawn1fJnIhDmLr4bQ+
	 uaFxsEIVKG9J/+mxU7xgV9FDvZczcLmr4biFr2rZm3MF3UCR6M0UhJ9lDwkAbUmPDf
	 G7Po8pF1WW/HaPYHbgkkd0CY1MQ0umgayG5eQdZvAu9ciC2s1PbJxA8X5oKWZ2+McP
	 Xe8fY1nsNO/hdBMaQb/ugje5WkkpTHeOKU+TIflA9pWBHXjMeM9KEGpoQ2PtNgKlxK
	 zTaBlkgVlZQouao+2bjGLOCcjiRS0TjUjeJs5oi82UI8hVacCoQVGGn+TQ1Ds8PpjZ
	 jtmkV7Vcypumg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DFFE391B1AB;
	Thu,  5 Nov 2026 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Specialize inlined lookups for more htab
 types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179392020599.229163.7828613010978206008.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 23:10:05 +0000
References: 
 <20261105-b4-hashtab-fast-hashfn-all-types-v1-1-287199376359@meta.com>
In-Reply-To: 
 <20261105-b4-hashtab-fast-hashfn-all-types-v1-1-287199376359@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 05 Nov 2026 08:56:04 -0800 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Commit 63b13537e6b2 ("bpf: Speed up htab lookups for u32/u64 keys")
> specializes the inlined lookup only for BPF_MAP_TYPE_HASH. LRU_HASH,
> PERCPU_HASH and HASH_OF_MAPS still call the generic lookup.
> 
> Select the lookup function in all htab map_gen_lookup() callbacks by
> key size and by has_hash. has_hash does not change after map creation,
> so each variant uses a constant elem_has_hash. This also removes the
> load and the branch on htab->has_hash for other key sizes.
> LRU_PERCPU_HASH has no inlined lookup and does not change.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Specialize inlined lookups for more htab types
    https://git.kernel.org/bpf/bpf-next/c/d03b6e1357dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


