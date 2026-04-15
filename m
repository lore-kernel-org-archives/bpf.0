Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DF383C8C;
	Wed, 15 Apr 2026 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280852; cv=none; b=oOc8o7ez+UV936/NJwvnmNOgokJkPQvRDFUz+Fq7d/wTqdnlcd/IAkF15kztvAxh4MBnRlzqqixCj7tIPFNzv8e4jpj7RJ9iwNi0DKa8rnGcTvk5jyqiDOWlgPGNQyQ+un1PsJer4FwVYyG+iRu6tybhTtRCadpreaLDU1Vemok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280852; c=relaxed/simple;
	bh=0cjfS3TGKA503XLC0Jjhfl8lB0O9FAFYE5IhFAGvE10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bNVmp5MDvLP4VPx7Oy3WUDnMetP+Q8i2OjhMbKFMA06ydzAC5JwOoZSUMvG5kvp4QIdZ5XEWMYxh98yPnedMeWyvqP1D5hlnc7sHr/tzPQ8g1xJ0xb0FP2yIwVI3cmrHqYny2CjXsqKtLBjwtTENiIUTtojEfxBSwbs/L1p0g2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOeJAJiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOeJAJiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C47C19424;
	Wed, 15 Apr 2026 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776280852;
	bh=0cjfS3TGKA503XLC0Jjhfl8lB0O9FAFYE5IhFAGvE10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QOeJAJiIVtMakhI6OY4h+mhte77jxFS3dhb45Ej3LPjznJGAP8P8FCPFVRUo2nBxG
	 oEKU0k2PaPtEH+0l+6jV1h6tVkFh1lrSpdrsvw4ogeFvEmlLaxFGXgSLbrbz/syvMT
	 X8/tBgGQCan17xASz+HLv0pHzOvhDq7Z7qvdvEh0LylzWHZM7ARCF3/3/2MSlbF+cw
	 S7KZSSOJUAdytWKR6jBFj4jZxBJ///gk0QAxXPhnWVOVH7cr2SaO1XUyDtBSgXwWKn
	 HWAgUUii5f0t0B6qgtptHPn4rmKNUdseOvwHmRRG4COSEtiu5Rc7C3oyZJKcxVEOSN
	 /ENfBdYJpLSgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D03380A963;
	Wed, 15 Apr 2026 19:20:23 +0000 (UTC)
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
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177628082153.2402333.2124499687552930382.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 19:20:21 +0000
References: <20260413191111.3426023-1-puranjay@kernel.org>
In-Reply-To: <20260413191111.3426023-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org,
 pulehui@huawei.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
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
    https://git.kernel.org/bpf/bpf/c/42f18ae53011
  - [bpf-next,v2,2/2] bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize
    https://git.kernel.org/bpf/bpf/c/46ee1342b887

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


