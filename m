Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125C51812D;
	Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028418; cv=none; b=CF5rD/XtgpjYED0mrhI9U95uXi+s12+jqgin+yYYcExVkhsZOawHw0TSpAIhRVW5cUtHRlgBLb1p6dtgyCzUAyd/QfJ+fIMiVsoZWsTyVBGaXO7E22mK22t3Tw9xIHnanff3tWYePVP0NmDKLV8PrXzvNqzaDoeXJ7xKheGfhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028418; c=relaxed/simple;
	bh=GgNENqJkCM/xz7Z9wqwxA0+wh7IGrTwy5OjHU8HZFMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gpLy87Uq/UZia/dA0UlNmm+OG9uIfZ0LzyoDZgrrJO6ksANMhXZaUt15iM+wygKC6TVZ78z+UV3/08zdiizs+db9OiD0n6ccJoMMbJTPsIOIw5uNGZJdh/iZMYK8ltpWWZ7CctQSfLKDovZOCdXz5PIlil+lvUF6rK7nTutjVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNIL9T6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNIL9T6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2091F00893;
	Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028416;
	bh=o3zzywcgV3KmlI0ryQf9YMR9hcyyZ2sLqP4cA6oaHpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZNIL9T6X1SGb3qqHTI5c2ImTjmO/erC3/5/+twAfc2kvhxC6O4udeLBI3tiFn6oqi
	 EnH1u8J/r756XinQZ6j1tWJM7kHUel1X2ik26MUhtN54G7iNoTnjIWA1OP0Tno8NmZ
	 q6C0jNFwEsaF5DEhvPC79zslONp24pSX7L2j1kAkZsPiwhT+lLaGUhfvr9OgRkru5j
	 grsJuTqgBdASN55qkMhqLG6PcB0ami1Gzz5SPdl5LHo8a4U3aTpg1ukwMPPYipsVq9
	 0WY6AlDhjxhgX1wMLCYnHtYWq9AneS0zmTFeHyJz4KnsuTmIFL9IPOaJiToTvkrvDs
	 VABe9q3e4e1iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A1E39307A4;
	Mon, 21 Sep 2026 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Clean up child when
 task_work__open()
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002620965.3245651.9058032105571504514.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 21:30:09 +0000
References: <20260918024300.18321-1-luyun_611@163.com>
In-Reply-To: <20260918024300.18321-1-luyun_611@163.com>
To: luyun <luyun_611@163.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 18 Sep 2026 10:43:00 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> task_work_run() forks a child that blocks reading a pipe until the
> parent wakes it. If task_work__open() fails afterwards, the parent
> returns without closing either pipe fd or waiting for the child.
> Because the parent retains the write end, the child remains blocked in
> read() until test_progs exits.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Clean up child when task_work__open() fails
    https://git.kernel.org/bpf/bpf-next/c/8715b13c1a80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


