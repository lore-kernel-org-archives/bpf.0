Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CA20468E;
	Thu, 30 Jul 2026 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450643; cv=none; b=oMv3wCSnX59ldS6NXffc0lk55Myd4ZOikvJGFbpl2cIOtcPY0MnvB7uYNAnGPjmzZljZhHX0t8OZo5Vl9KNkk9XUQ/OEQMFXJKVDdtDAJQL5ts4BcwNYMgcZmN00kz7xmCt5nEBCUhIEMjz1sFSL3ckv/d2sIvi8SRZg8/4gMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450643; c=relaxed/simple;
	bh=pEHYVSTGMSfBDtBTp4OjueVkaPeskxvjbe78cwys6do=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnQrS1Ue09f65F3yoqgVN4N3B8ZFrTVotSLk/1w2ILHBgNCyUov5qCAZ9hT9fj7EfDNJu1CrgwSZ4hYkPAApsrAtmP/NmcfhbxPUZekH6JNyD01dAxw1VVYzijwhq3qrSZVrL9WJwkLTuhSdOVQOMvnHlK9kNpAL+oITe7Qca68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf8k2Y80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf8k2Y80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89F91F000E9;
	Thu, 30 Jul 2026 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450642;
	bh=LYeLnQoq7fW6to3rUyicCsrWANE10ahi4yG0KSipuxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jf8k2Y803kC0/MQFLlOde6Zgz57wAGyveoC8kZs5M9+EP+NIC5m+6uavrlMdfm//K
	 laohzq34agJ1VjSRIpNH6cDZSeGB2Xrc6H6yuf6E56nEPaO+nN87rtoY1v/ddN1ftb
	 cc3f2KAvFnvnyOV4eOEE48WTGdsjxjh7vVaww3Psu+LbRqjbIe+QQsmSSOYQw6msKx
	 vjGbmWJm+kCkRh5ipqDCvyMM96Yks8KbSwmaZdkxsoB3pWhVIOHVsAMS8ZXUQRWJfE
	 PFUsSQLcRUpMTF3hEwxOSRYnOcbLto4bz5EFbj9EfdbWagbBycjrpVFS5uhfF8zbT1
	 j72uxNjeqRhVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B73924459;
	Thu, 30 Jul 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545060590.16570.17188493468007032676.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 22:30:05 +0000
References: <20260728023259.2813482-1-pulehui@huaweicloud.com>
In-Reply-To: <20260728023259.2813482-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, yonghong.song@linux.dev, song@kernel.org,
 jolsa@kernel.org, emil@etsalapatis.com, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Jul 2026 02:32:59 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> In bpf_netns_link_update_prog, the checks for old_prog and prog type
> are currently performed locklessly before acquiring netns_bpf_mutex.
> This creates a race condition that can lead to a UAF issue.
> 
> If two threads concurrently execute BPF_LINK_UPDATE on the same netns
> link, the following execution path can trigger a UAF:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix potential UAF in bpf_netns_link_update_prog
    https://git.kernel.org/bpf/bpf-next/c/5c5997836381

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


