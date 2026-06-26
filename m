Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072A3F6606
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480642; cv=none; b=irdE4WtGB9wkPImXpY/FkF9XzUG55eqBmNZ2MdugP8SyXvhFABuIKFsMIammRwRMJReoC0kh+3WZvysmL3yJaTNUSlg+Iex0guEvqoVRFRTA2o3RjO3jjYBKVFHrZgYSy9aV3l+6DiZ23gu2C464NcNoSKCkvZ47QRtMBSUSvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480642; c=relaxed/simple;
	bh=RsoAqF537RBi4zSJM2wZH8hFr8JXyHI9dvicdgvRmEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eEwoN3RW96RUM9mSHdkyfSXoPOMImLpkbDMl8znLqdktn+YsyLLbpFbhF7AVeyEpq559vcCd8iF7MFoRdt4zMKYhT1rqFVmxcbyL3Pvaf38br2IbO7Iplu2nBi4nS8MFFkUWisdQrDc8A7mCqdEtaCkcLnJWb4JXTquAf2DEtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQMQuv+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQMQuv+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD81F000E9;
	Fri, 26 Jun 2026 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480641;
	bh=waknB6QvfnSNK9YcKx87Fj5LyEOea1BR22ZAbwEPC0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hQMQuv+oDzVUZwHAUYchr5ih5FUF08l4ZL8rK3xrLy7FmBgYrzHSip3Bmhdzco8c0
	 j2lmRe7cZLNmDvjtdQw9QwpYaLaE86LEoIJH4GUysozpEh66zA/gIyI44pp7Javyzc
	 gcxuGxx2zjqzphtxrrI4Tp2Hu5px/xQrecmVht+Idk9hKA3vBCThttsrSblCGVItIA
	 +Jxi1Kp2zuQn8z5lkqiOGpzrFVvbUMKM6hNARVJCaIBm0c02oVb9fQuM4AZLm7Hgkw
	 B5rtjyhv+l7B+qfMorSW66ZFkDygEvi1DvXYjtWn4+dv+3gb7lDMPR7LvQqHX74D0F
	 XcHjVaMCnGUwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2D0E539389FC;
	Fri, 26 Jun 2026 13:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix -Wformat warnings from
 format/argument
 type mismatches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178248062788.457674.6865742035078097472.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 13:30:27 +0000
References: <20260624204946.2901178-1-andrii@kernel.org>
In-Reply-To: <20260624204946.2901178-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 Jun 2026 13:49:46 -0700 you wrote:
> Building libbpf with -Wall (as happens via bpftool's bootstrap build)
> surfaces ~120 -Wformat warnings where pr_warn/pr_debug format specifiers
> don't match their argument types: %d for __u32/Elf64_Word, %u for signed
> ints, %zd for size_t, %ld for unsigned long, and %x/%lx/%llx applied to
> signed values.
> 
> Match each specifier to its argument's type where a correctly-signed
> specifier exists (%d<->%u, %ld->%lu, %zd->%zu). For hex conversions,
> which have no signed form, cast the argument instead (%x->(unsigned),
> %lx->(unsigned long), %llx->(unsigned long long)). No functional change.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix -Wformat warnings from format/argument type mismatches
    https://git.kernel.org/bpf/bpf-next/c/df3153758ddb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


