Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3526299
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111816; cv=none; b=FYIyqu67Qj6K7ckuoTRgIUxRfSpck261tfw0RwoWuLaScI2Gny6F5+qvVefYEo11ScUuPg06WfDykip9YW+Az1xtmSqhSWf0GM8qrX/4bnUlAI5CFqy5rLDOSBKJOm0zsuGWBMA5gPVyrOgUkHkHomiWAcviFNmZvld1PE7JuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111816; c=relaxed/simple;
	bh=G7cWEJSbxL/M5ICsFFyskH+xpI4hxCH2GO3lTHKpi7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ja1L4JFtGxN/MPqemiohzXt1e9XrN0h9mlnApR5IcEfgviDziiNZjwAoGWGC87KDn8Q9xBB1loV/DqbkO8GjAaNFnFjFAOlTKUV+OWX7pHM9qVOcjuwkAqk1GE8ugV3mi9Rb4cupyuBgyVISOMsoccAlfam5f+9b8hx06pe9rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuZkD3yK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuZkD3yK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D161F000C4;
	Fri, 16 Oct 2026 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111815;
	bh=Q00lJHDWC5p/RitVOvwkyFusAai2/tvQdHPkZ2wFbg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cuZkD3yKSRxosZwoCjLncULlw7MUD98xdHhqjxJNRVFp9hasP9SB2PnLx7zytLNdR
	 UwVj7CslhXZ9JBsfds/+kiNmybY7DqSpbHbZFvaIL7jIXnX2p7YfN39DmoxN0jq7uK
	 AL6zuuBVNtz3GGBerbVpqRB6P83HhvJs9DxugMImHTGnFI/y7f4q7tCwb6cXqjLO8G
	 SvlXKCroIQ3r3MBl31p6K3q4qvmvSlSwUiJrvhwdbhk24pX4XQS7pYyTNvRK2BR4gb
	 CLhRq5Sr/p1MTSHn0+aEwwDC5Oebew3SN+Xw3GiNk91/NM/8QO55Qo4pOZMxGT6GKz
	 HiByEh/uinZgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14C43808209;
	Fri, 16 Oct 2026 00:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/4] bpf: Fix task work scheduling races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211181351.4179746.9574390540438023653.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:50:13 +0000
References: <20261012061915.231254-1-luyun_611@163.com>
In-Reply-To: <20261012061915.231254-1-luyun_611@163.com>
To: luyun <luyun_611@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, yatsenko@meta.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Oct 2026 14:19:11 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> This series fixes two races in the bpf_task_work scheduling kfuncs and
> adds a regression test for each.  Each fix is followed by its test.
> 
> Patch 1 captures the task pointer before publishing the callback, which
> can clear ctx->task before the scheduling handler attempts cancellation.
> The existing RCU read-side section keeps the captured task alive because
> bpf_task_release() is put_task_struct_rcu_user().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/4] bpf: Fix NULL task dereference in task work cancellation
    https://git.kernel.org/bpf/bpf-next/c/c961f7b41a10
  - [bpf-next,v7,2/4] selftests/bpf: Add task work cancellation race test
    https://git.kernel.org/bpf/bpf-next/c/6674dcb2785d
  - [bpf-next,v7,3/4] bpf: Prevent task work context reuse while irq_work is busy
    https://git.kernel.org/bpf/bpf-next/c/a36d9afe8d92
  - [bpf-next,v7,4/4] selftests/bpf: Add task work BUSY window test
    https://git.kernel.org/bpf/bpf-next/c/33b2c64f073c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


