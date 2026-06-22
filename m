Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07427233920
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090438; cv=none; b=Me5XzjnfDARFsOnc1oYCAr8JeuyTCZdy69AcWPb4w973ors7qyAejMvXzP0hWg2gOqaWX9j5WTUrq6Et9EFTmQwUcoK3Ckf93r240qWO5KKyoTOVtrT8h+AoZYDHAFPscTSxFEky78hSiIGKHJ6vuZ80cXOrN8qqW0NhODNvhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090438; c=relaxed/simple;
	bh=rqGjZ94Gp3wU4qlzMEXce5Wfj7lQ4MK+6GT5amFUtUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ksK+p1IvaBnbvbAZTZSnAyq5t1N/KFcvTz9VbghghGmx9p+ThBnKlXLWLmSTGQDYNv9uocDKxEVGi0OBe8pYXiC5JhHJnbojRlnOXFVPTfhINt+KZIpIY56HQviuP7vizgTEsra8EPfCWepC9Dgy+u77pLltTgw9sYyorexS+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6RUJgkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6RUJgkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF311F000E9;
	Mon, 22 Jun 2026 01:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090437;
	bh=d03JWu1HbB4aYsiu0LMWUbqQgVTejSDTKAowa9l12uE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j6RUJgkYT1xmnRKGcq+U/ZhpzveXp+VtUrmxMy+nOnlAVnmIboopkK0NCS6j2lHGs
	 B9uvYeAg7le9mq6jc4pZOnecIrMbLObfINU+jQT1r0jG1aRxmc93r1NrktGGzzRVa3
	 leraf+SE9bg2k7tXP2c3a8qdoHLiW36ZDlAx4lB4rAf1JVyruzgnJNMFdYTqwSEGD5
	 vyUHKP/SgmSudrgx2IDiY/TtWRFCHSbo4m5omDnupb3CiSaN7cRqykG6mBXtWqOHo+
	 Yj6fq4jYa74bz9hlJ6BSC858HU6n42xD7eyRYQN7UXRTwyqF/boGNKucR3Abgba/Th
	 Ga6Iab3vpsLOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197823AAA6EF;
	Mon, 22 Jun 2026 01:07:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209042856.554493.5494803454529215352.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:07:08 +0000
References: <20260615195536.1065107-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260615195536.1065107-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 Jun 2026 12:55:36 -0700 you wrote:
> This patch is a follow up to recent implementation of
> stack_map_get_build_id_offset_sleepable() [1].
> 
> stack_map_get_build_id_offset() and its sleepable variant each cached
> only the last successfully resolved VMA, with separate bookkeeping in
> each function. A run of IPs in a VMA with no usable build ID will
> repeat the lookup for every frame: find_vma() in the non-sleepable
> path, a VMA lock and a blocking build_id_parse_file() in the sleepable.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Better build_id caching in stack_map_get_build_id_offset()
    https://git.kernel.org/bpf/bpf/c/5e72b5b15729

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


