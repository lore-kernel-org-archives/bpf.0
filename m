Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A21481FAA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285482; cv=none; b=TtyfadmHPuUCkshn6beQ8nf6ADpyYDslxlLRM+UlG+W6H9qaSWMC2BIaiyzhGEfRU93VZYMw5KJ52WQv2DQ5bvfGfRHdwFGGdOFUEJoATa81SJe8ovNOO6OTOUY6bMZx6/QRFWhNqoHmENFixiPcJOLC3aXn2N9ivIJpU1+LiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285482; c=relaxed/simple;
	bh=kjK+tRHtrSevSdd8qk8oWUtzvgIUSUnby09prrhwWrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ll7xZ2X+Mub2IW7vFG7KxDpr4sQ5j2jJ3F4+uL/771u8VSplfD+Q6kA3ziavOHVJm/7xp9TPonA7Y4cZBFSuJN7V+mswom6qGem93Xt3dzTJQk4EmbN6EafRAOlwQiqnDwFdt9D/q+jA92uZUhSH/xF+hXhr3mRgwJcXDlBhvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqSNpQHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqSNpQHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2ED1F000FF;
	Thu, 24 Sep 2026 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285478;
	bh=qyoDFD3BULdcIT7rQIg3zQYG8PnrUGnTQMgB2UrRPJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DqSNpQHYgL5PdaboHNNI6pfU2Vb1JcbnyjsNEwcYmpu9VpXQnf4UScjgR1Vq1co4R
	 MrNMZu/9TZ0KDlqAnK0Y61KT5Mmg808MiQaTTqcdddh2ssIrKZ/kj6U87d89DvhRgo
	 DqB8SlPGRuT0CbVsGBBnyaQxlZfPlyIKPt71Q4HMtNshc4Un6ol5ezZJ/saET8wrHY
	 fd2MdbM8EDSSNMdJE0jvqLmb+KwBuWCOx65hP5Lic1clz66c7swcWSwgPn42p2e6a1
	 5u7zz4BgbHZyxkQuC34VmDIOZ6YnPZPuACifBVfQTCSR4DlNkSIUaRyeKL+6tSUNoe
	 inj5O4G4FyoAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B13A566ED;
	Thu, 24 Sep 2026 21:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Run callx prog_tests once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028540690.2209702.14577087846512121741.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 21:30:06 +0000
References: <20260924182533.281399-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260924182533.281399-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 18:25:33 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> prog_tests/tests.h is generated from 'void test_*(void)' definitions.
> callx_func_ptr_map.c and callx_rodata_lskel.c define the test twice,
> under #if and under #else, so both tests are registered and run twice:
> 
>   DEFINE_TEST(callx_func_ptr_map)
>   DEFINE_TEST(callx_func_ptr_map)
>   DEFINE_TEST(callx_rodata_lskel)
>   DEFINE_TEST(callx_rodata_lskel)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Run callx prog_tests once
    https://git.kernel.org/bpf/bpf-next/c/31575dcba0ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


