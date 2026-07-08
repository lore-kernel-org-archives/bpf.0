Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3587DA66
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480828; cv=none; b=DPRwpJTnZWYGsFOAz8LWQKUhx7s3JsjXjpq60iepG1DvviDwjAwNN6mhSleITgYqaCJkhmeBVzGJqK7zDX5q0q/ui56Agj5O7fjF2WM5l5D4xL9uKsVVxQm3vokfGGWMzO5DCNn8T/JHlFgHPvCNgxtsgOXYq2KTHQskBvMtpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480828; c=relaxed/simple;
	bh=F8qG5bIZ8QO8gBYLlWyL736vwx9VSi4p8k/+zIZqBsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rTWh6cadImGz37MPnjx1j+Ehyq57IHypqg82Bw8c2nIjccT5lbpayTyTub358Vfs6YPuUuqXiWSseff3aqfQSun9rV+K00r6WOlmGjsCeTY61eALLWnmE84eGRPmauEDrocOSdiBQv8fKdp4ODq3fGTuemgKmqR9fdUSsHQut8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYx8Cu2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYx8Cu2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F71F000E9;
	Wed,  8 Jul 2026 03:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783480826;
	bh=ZJhf5yRUJ96+FTmfAkztVJByQWWUXLlBdhrGW5/t648=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RYx8Cu2B1vSEbPc7eo2aqivECSaFEDYb29dK4s8XeItujAANGZCgw170GEmmvyWKe
	 OTbQl4+QT8QHPV+szRtNPXLHLlcHxeFlDOajtU837ztiuHnmz3mNfPSdbGYelyZEXq
	 roDqwKIHivqCqGmBA94g62YGn1rGeJJtLwuOGmz4ajMWNBYmwlyPqc2SSPARRJl2tM
	 1xCwoG2NC77PjIFmQ9FL89w48TD0VAI4EcpcBa+CPcigRfmuIr1X4W3olPqQsYXIMm
	 /GCb+98BwJYM8+ksBHYdaYNGDMfEyBhfopB8JIMIXG8MqULN3802sO1gDZ+WF/UQ/v
	 rHM0YSPPOCYcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698D3925440;
	Wed,  8 Jul 2026 03:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Rename libarena struct bitmap to
 struct arena_bitmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178348080592.2269416.13888096250636232840.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 03:20:05 +0000
References: <20260707220136.910374-1-yonghong.song@linux.dev>
In-Reply-To: <20260707220136.910374-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 emil@etsalapatis.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue,  7 Jul 2026 15:01:36 -0700 you wrote:
> When building bpf selftest with latest bpf-next, I got the following failure:
> 
>   In file included from /home/yhs/work/bpf-next/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c:8:
>   /home/yhs/work/bpf-next/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h:11:8: error: redefinition of
>         'bitmap'
>      11 | struct bitmap {
>         |        ^
>   /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:51320:8: note: previous definition is here
>    51320 | struct bitmap {
>          |        ^
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Rename libarena struct bitmap to struct arena_bitmap
    https://git.kernel.org/bpf/bpf-next/c/ee1bcf8271eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


