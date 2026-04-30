Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA473783B2;
	Thu, 30 Apr 2026 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519567; cv=none; b=a5z3wKY0kZWxuCK5AycaYZU5d9R4DLBFoDSQU/gQHpuNXB31JO3nGgdpwKTNKFMWWwUUZZWXsmliIM8a+Y61wF52VPnFD0glt9sojTK4gG8WYXDtiaf3CxBxm/W6z+vwyyIInTw9kw5bvQdoq494+de1I4Ewiwf0aoqlImq2AoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519567; c=relaxed/simple;
	bh=R60i1i6tdMN1HpucW7gHhlJRra2Kl1V9Gtj4FxNETVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a62fkEWGy1WGJLcDTkXw7F6kwdLeigNa/JbAZCOFsEsPBRhVlhO1Wdw+bVXlG924RBw5ohjBHQboBgZfT7vBId6dkCO4MNqU5C85ioreGhhKsQidy2UgmOmZRytX7/aG8V641GHQtaLbruRxYUWhVVSLeMnr8d4i54FZGz05RZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu/jQMW2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu/jQMW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292D4C2BCB8;
	Thu, 30 Apr 2026 03:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519567;
	bh=R60i1i6tdMN1HpucW7gHhlJRra2Kl1V9Gtj4FxNETVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yu/jQMW2NROEp2O3mOHp0YT/DLhA4liRauQz0HEyBARaTkOoEnCSFLpxTtNGZOTIA
	 KZDzyWhaL3Phf0IKL3xirNqgWeu8VdkFpbvr1p++42EepIJRk810U1tdSfW3ZVpH4a
	 yI2NKYxdlznVZrWAy52h17IcNRXPyPTyacG5pkt9+in0pAfozwKLphOlUq1nX5ERwA
	 5e5D+93rsbSl1vYoIO/8DkiPql3tgrLs0yjGvR1HFY2RqkPh3GPWgVzJTRTxRg2Dfi
	 s3e7vtGykqD3YzkGd3Pn93agy6tYwajQo/jaGUvgf0T6JeBcwuLjnmNmYwbE9XByY5
	 IUAVB5LBzj4yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFB43809A07;
	Thu, 30 Apr 2026 03:25:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf,
 arm64/riscv: Remove redundant icache flush after pack allocator finalize
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751952229.2274119.6699210354046026962.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:22 +0000
References: <20260413191111.3426023-1-puranjay@kernel.org>
In-Reply-To: <20260413191111.3426023-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, xukuohai@huaweicloud.com,
 catalin.marinas@arm.com, will@kernel.org, luke.r.nels@gmail.com,
 xi.wang@gmail.com, bjorn@kernel.org, pulehui@huawei.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Apr 2026 12:11:07 -0700 you wrote:
> Changelog:
> v1: https://lore.kernel.org/all/20260413123256.3296452-1-puranjay@kernel.org/
> Changes in v2:
> - Remove "#include <asm/cacheflush.h>" as it is not needed now.
> - Add Acked-by: Song Liu <song@kernel.org>
> 
> When the BPF prog pack allocator was added for arm64 and riscv, the
> existing bpf_flush_icache() calls were retained after
> bpf_jit_binary_pack_finalize(). However, the finalize path copies the
> JITed code via architecture text patching routines (__text_poke on arm64,
> patch_text_nosync on riscv) that already perform a full
> flush_icache_range() internally. The subsequent bpf_flush_icache()
> repeats the same cache maintenance on the same range.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf, arm64: Remove redundant bpf_flush_icache() after pack allocator finalize
    https://git.kernel.org/riscv/c/42f18ae53011
  - [bpf-next,v2,2/2] bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize
    https://git.kernel.org/riscv/c/46ee1342b887

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


