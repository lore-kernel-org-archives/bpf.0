Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C24949E4
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591813; cv=none; b=MHY/f8kFPUFc+7/rj2DpCxUjm5o2oKerCsPSk5a4n059HUBLq6F/pHPGluEaeRuuFFDLAvCBLGtY8N7rvN8Vsv6uLIVryIc7sG3rXbyxz68wbj7ey6m6tKNVkcIUlzGMAz+Tq3gc/0qODOt5I2AY2ms2FozImXWmCAW2WmYuJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591813; c=relaxed/simple;
	bh=PTdtYg6YI9sWhtrMdVcWhO+QjGvwwmjpLSej8/8rxes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LqMU82YVnrQK6uYUi3zbkYZzrc8E6rS2uzhg+yA4rDWxTEOCkSioKPjmLrNxnB9Ql0tRxPTegVCiR4GPdLafuqtGAfjN1bruLqxUUm4S3KIaHf29Yn+Ivna68GkuBSBncsoTsQwQp+WLYpjbd4sZHYQ/W+E3LfA8i4mwNfUcI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJAG3WSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJAG3WSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91791F00893;
	Thu,  4 Jun 2026 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591811;
	bh=jQM2oAwH9sOdxU7ZJ6Wbzc8gk7FiaryNTF5Gp9vtO2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aJAG3WSgvGrImZ5mo9o/LnFScifnNkL4CEKMr9GhNlTwR2MwGOsP/lxBKEPsVQvfp
	 E5cftbTAzq7KUS3dqb1RM5EFJcpXnlc7I0JlQcktF3k/p64cWmdBtrmxE9ZjejP+AR
	 p2fMI2vuMmrMZXWPak1G/CQ0Drs0Pou6XLT91HXDjUCeDKmJcRdU4x0gtVOunW1DOf
	 N/caZGcmMFEG/HYtbMYjk3BNAK3cdZ099Oz66D7OmDwvuEZOkfG9FMHG4fPyFuMEg+
	 W4aKUIe4YhGMPYxSay3P3aIzMVrlVlE7J+z2mCJSt8LW/U7Bytccwp7Np6IlljjXYv
	 NfaYcXe0f3ftA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C73930A0F;
	Thu,  4 Jun 2026 16:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059181241.2942053.15264975706579133260.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:50:12 +0000
References: <20260528222014.38980-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260528222014.38980-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, david@kernel.org, tj@kernel.org,
 linux-mm@kvack.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 May 2026 15:20:14 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> zap_vma_range() requires the owning mm's mmap_lock to be held.
> 
> Taking mmap_read_lock under arena->lock would AB-BA against
> arena_vm_close() and arena_map_mmap(), both of which run with
> mmap_write_lock held and then acquire arena->lock. Instead drop
> arena->lock, mmget_not_zero() the vma's mm, take mmap_read_lock, and
> re-resolve the vma via find_vma() since it may have been unmapped or
> replaced while waiting.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Take mmap_lock in zap_pages()
    https://git.kernel.org/bpf/bpf-next/c/80b89d0226a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


