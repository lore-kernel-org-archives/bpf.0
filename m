Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E8E555;
	Tue,  4 Aug 2026 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885647; cv=none; b=bRDTUpUDSlaUbrFzeJlkQxSYUZvThoLsLjCVVF5JykBU4GBzjc+8ScXxhMYauD6WBgCxLbudeWpLIjyz+gaFNB4kpike6Rwg/XTV9n/3SNMWPvQTJCZXoqxN559qqw//1c5x13+QyVQxJD67OlvIxIkDfZ0JqIsvE2XBoR509yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885647; c=relaxed/simple;
	bh=NCZtaaFk5dcvZBWt2rAdqusH78z0ztFB/ImCPdEDlZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i57y9wYcKsNPzQnWAGUkgUS7UrIb1EM61hzHXTfsoeQ6IP9fBL6NZCrYYzJdNxzj87mLi0/HM0Y/4U7aNeL69I0kPOInaGVESOzhdPIkjc2WbEvvkl+7wKcbDIoPCoOZzfPP7yZ7w0DSZKyqFYNeWJOGZJ21KLEvZYCzWWyV7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI3BTOwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI3BTOwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAA31F000E9;
	Tue,  4 Aug 2026 23:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785885645;
	bh=7S3QBOT7vArjf4rPw9zhf6wBBgfnjniCwKO8FERyQ0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lI3BTOwTyLs0baWB7L55DIwxo1KGm5M3Rukduzz9wg2n0PooDq3ivtmfBNuFtCxCY
	 yc7O1KBiEaBqC8vBia5/W7RpVfXGmoy2+tBPx6PDUdYr+Ep/6BDEg7jk6y5votHu/4
	 q+WspUacEMGO+G0S/hKhyS1fmRXuwh8c/1QEs0z9G9hyXgIek5wT1eIcxRTXxVt6lX
	 +4Ua1Eais6jkUgnjp2s/GHlSbYzfR+fYeHTyObfAKYVxp7SKlf+ZFWWkT0gavfDfgi
	 TWZA8OWLPByDQi4hg3hXiHljTJ9Y7oZKM+BSuK2jJ7u2i+6HHiEl/rJZ/7/G2NG79g
	 54JTksQkU/WhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56999392664C;
	Tue,  4 Aug 2026 23:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf,
 cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178588560612.3827355.4279286751170984862.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 23:20:06 +0000
References: <20260803013934.4036646-1-pulehui@huaweicloud.com>
In-Reply-To: <20260803013934.4036646-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, yonghong.song@linux.dev, song@kernel.org,
 jolsa@kernel.org, emil@etsalapatis.com, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  3 Aug 2026 01:39:34 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> A potential invalid storage access issue can occur after replacing a
> cgroup bpf prog.
> 
> This occurs in the following scenario:
> 1. prog1 with storage is attached to a cgroup in multi-attach mode.
> 2. prog1 is replaced with prog2 using BPF_F_REPLACE in multi-attach
>    mode, but fails midway (e.g. in bpf_trampoline_link_cgroup_shim or
>    update_effective_progs).
> 3. A new prog3 is attached to the cgroup in multi-attach mode.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
    https://git.kernel.org/bpf/bpf-next/c/6655c409707e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


