Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C31DFDA1;
	Mon,  6 Apr 2026 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440826; cv=none; b=BKQbOUlGW5w7ijxu0vVORts/SVILNsIuS7q6wXomu5RmSEtan+tf8ul5XeW3ClDAf0Ihyy/Ucd/11fuGqZPSYukdboAhTrdpOHT0h9v9iDdoxN6wvM8SsC0zFCgcwqoJ1iSOhjA+ZCHFjyicK5VhS0RN1ywKKnnLVE0e9w1JuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440826; c=relaxed/simple;
	bh=cRGtH3iGiqJC3Zv3qXzjSRVQ3Q3fg92M0qSmevXaDu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D/GnoYlyKNCApcfpGYHAh+3UDv2WGAKRESH08atCP0JTzCRyq75h9xPNtqCokhaNq+K4X23G0OcpcB4Du8dBKBf0t9VVCLYDHqwWYI6NecBsFnBy9qQ15WgqhBuZpfpuics2ICtKZi8wXwWeGYlz0dcWLLDVbcTB8FGPiOIoQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5WGEiox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5WGEiox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC008C116C6;
	Mon,  6 Apr 2026 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775440825;
	bh=cRGtH3iGiqJC3Zv3qXzjSRVQ3Q3fg92M0qSmevXaDu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d5WGEioxIIKQvKpB5Y/eerKAfo2wrKFQLI9v1+1FIxO/hCseY2vjQmR2C3bnUFisA
	 Uo3rJpcqYtyh+7k84k/95NdrivsLb2VcNNZqk3eQpfFx1gz7D9UD9qeEPROMnT7Sxn
	 RduMiy4YqMJdDgPtcxtYuw9d5KU+nzabh9dWQrvExNSc4UkQM2PZcDnJpix1QEwpJZ
	 k9uaeZafPjxng04cw47SMhSmwLTvE2zQ+hEXJNrwm+JAhGvqcGIr5mCSnm/W7bLSb5
	 GRYRE6luEv5a/dh6RG/yw8AdCEy6Rvg6DjudlLWz6ZL1TJu6fqQ3+2aUIpsGKZ0PMd
	 NHLCS1T1SIQ3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF133809A22;
	Mon,  6 Apr 2026 02:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix stale offload->prog pointer after constant
 blinding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177544080529.2523223.7238691313202506498.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 02:00:05 +0000
References: <tencent_BCF692F45859CCE6C22B7B0B64827947D406@qq.com>
In-Reply-To: <tencent_BCF692F45859CCE6C22B7B0B64827947D406@qq.com>
To: MingTao Huang <1037827920@qq.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, mintaohuang@tencent.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Apr 2026 20:18:50 +0800 you wrote:
> From: MingTao Huang <mintaohuang@tencent.com>
> 
> When a dev-bound-only BPF program (BPF_F_XDP_DEV_BOUND_ONLY) undergoes
> JIT compilation with constant blinding enabled (bpf_jit_harden >= 2),
> bpf_jit_blind_constants() clones the program. The original prog is then
> freed in bpf_jit_prog_release_other(), which updates aux->prog to point
> to the surviving clone, but fails to update offload->prog.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix stale offload->prog pointer after constant blinding
    https://git.kernel.org/bpf/bpf-next/c/a1aa9ef47c29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


