Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDE4C7522
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280080; cv=none; b=dxEWHqikFg7uWq7b9XBVBvVTatVygnNg87spWkjw8djL9IQzYhNCEfSc91thWAWL00l2hmjw+/KSZZGGEwFlOzIEBKavtaIXo4fopfnRdRir3biDG69e19OShbbKhptZ2kNtgFGkvhEFAFU7vFzfVQmBjgprGZ+B3gSB1+Qd/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280080; c=relaxed/simple;
	bh=/wvGjFenkDyQWIuDcqqhrxO/Ot7dNJjL1g6UIhK/izs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKjRlUjojQM67zPGqnreRsoa30RKwKyPszyyMKh9hxuS0fUoqinv1e3ogCznn7sge3vOtzf4FOYMJP6dlVuxhoMm3Fe4uiYbYTBaiQRo3/mNXU/skfXlKpmA4TgMsJ7a4n96Bpd8rmU4djOX1mC7zSqqjz69Yuv0ftBQUnYI2CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXRinmqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXRinmqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489031F000FF;
	Thu, 24 Sep 2026 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790280076;
	bh=ilub/QhWsAIOyvG1o9pF8wOt/n/1VUd1OyqXMPw8/hY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lXRinmqZQeZPTrY+sF53OkhbioCXf2JOdPd958BrU1cHfBxYmgZ0zVC3ao8JcF53Z
	 YMJjsxerWkYy/7v4r8Fi+yLZ0+CW22XRrpPpY0NR5p+r7urrYX0ZLeefGwucqqeOPu
	 uGvWMJvnbvtNldPankP9yIMMH/CeMzlSev9r1nxMSoQ1aiySCuWZXo8AEXqzLwMPEK
	 2+sVARmoNis/vLTqCrON847l9zn0uTQvov8Xc15TBv72DrXiClVhkcPJqQh7+a8ub/
	 UGqL7cf8cCXT7cYbgIKLkYWXhyjVTpT2kT5fHG9KTRWDDFNNdgnK8f3jhpeZpaZ2jT
	 pm0yHTkQiMFZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B9F3A566E4;
	Thu, 24 Sep 2026 20:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of callx tests with GCC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028000515.2177981.16885786005383140357.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 20:00:05 +0000
References: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260924182104.261823-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 18:21:04 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> GCC doesn't support indirect calls in BPF:
> 
>   progs/verifier_callx.c: In function 'apply_op':
>   progs/verifier_callx.c:977:1: error: indirect call in function, which are not supported by eBPF
>   progs/verifier_callx_rodata.c: In function 'use_shape':
>   progs/verifier_callx_rodata.c:746:1: error: indirect call in function, which are not supported by eBPF
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix build of callx tests with GCC
    https://git.kernel.org/bpf/bpf-next/c/7cd1f73b37ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


