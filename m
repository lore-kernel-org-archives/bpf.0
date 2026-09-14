Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DA36F42D
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362077; cv=none; b=YYK7bWUQI9XK4230BGzI9h+ARXkN9cHuSiQeBcVQVeQGDL1ZuvQHpFkb2M+pBwd8FgTHHIKojhlyOP1PxExovIXD7/Buzl46WRMijGA8M6IvooU1E2Zrz15mJfJXvCEyuaGqGuR4+RF+EOWtZL9pxSxv4KY3wH5d2caCzQD1Yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362077; c=relaxed/simple;
	bh=6rJ07SZuai0GwVg7XqiepAsAUYUqJOb7lcFEm8tC+xg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EIliXA4ofExeNX4HE60oa4Evhgs31aj6ylFBlT3hmrgu5BsGIXxbVn8LhAuBYU9mT0Yzfw3umImvYxSSMXibF4nWXXf00rA3fgxHWnTqaIyruEQFQYV2kR3RmPSYimCSbeA0f12Z/inAw8foAwgReU4StptPU4hLpFkhTmbwRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSz4XXw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSz4XXw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2831F00893;
	Mon, 14 Sep 2026 05:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789362075;
	bh=2PTFmH4202PJk84L6OdjVpUeOPFFtanw/x1OXUOHWMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eSz4XXw+XuZRO70q5JPZ9ZR4LdV7PHi5JLg4C5cnH3flVg3aTFk0PwmK9ZAl+BknK
	 3XpOWtXpIr2H9TESKB0H+XLWZhnIvX5XYnQh+KpXehcQhq8JQb+yFCyAhu6+qGV9No
	 ujImgHuvKkBaBxh6qMv907YVKvGe10skqzK8VYeFDGgPjGtlGWEtLt+WkR+tA8Xbhf
	 QK2nLAQrCxKKsLbQzjl3RmidB/+qLJZ+TCXiYDA/kYjh08nBgZjxrfObq9BIROeGpm
	 qf4nHR8iLOvgO+MDoC/FNOhGflGmte/va4EiUqYVo5h9piHBxt8UBp9uafIn4Aeu/h
	 0nB52/uFdPNQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56983380AA63;
	Mon, 14 Sep 2026 05:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] bpf,
 x86: Use global buffer for trampoline size generation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178936201088.325205.11694378615444726589.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 05:00:10 +0000
References: <20260910094353.1256316-1-jolsa@kernel.org>
In-Reply-To: <20260910094353.1256316-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, rppt@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Sep 2026 11:43:53 +0200 you wrote:
> Currently arch_bpf_trampoline_size allocates and frees a temporary
> trampoline buffer on every invocation. The buffer is only used as a
> scratch space while __arch_prepare_bpf_trampoline() calculates the
> required size, and the generated trampoline is discarded.
> 
> Allocating a writable scratch page during kernel initialization and
> reusing it for all size calculations. This improves tracing_multi
> attachment time.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] bpf, x86: Use global buffer for trampoline size generation
    https://git.kernel.org/bpf/bpf-next/c/29fcf9ce4bbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


