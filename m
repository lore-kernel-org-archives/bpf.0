Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122D3537EA;
	Tue, 24 Mar 2026 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384826; cv=none; b=T1dAaZCjJjooYMvDPn3diMBTVTMatZOT4+UQEyQF2EVXdWPwUqpzCmM4K7ui6iy+Ie0CPDfy52EJkdudjLHvx6FebTDEAGMww0wMY3T6QZ6FwxJMtC+nVlP53nXWGlaWT33x3tih5zjCYKY2YP+BUe2GibBzzDLsKBreGpcUHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384826; c=relaxed/simple;
	bh=1leEzHN+QPywbtvby6s36XPPnQJTfxskzaS3CarP/qo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uRpVrJ1pc3u/KaDsqri8Ft4n9Pykdu63Ax5nl63bdtpuKJoPuHXLbMaBU6cQ3lpGHSZ5UMEzkN0kEBB++Gtsk/M1j0MFqygOuyY4sAHzMmLoIAji7TIuIO221L2Bcfsfd4Hez0R1fLwqfcsZ0Lkp9at32LN9kuoTJAObLA4wjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owqil4dH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owqil4dH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0B1C19424;
	Tue, 24 Mar 2026 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774384826;
	bh=1leEzHN+QPywbtvby6s36XPPnQJTfxskzaS3CarP/qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=owqil4dH0Uc+XbIYHLNxDmWXZx4wwaxnmVQOxYPpbJqSHmTmDN4haEdMFgZb3TFaJ
	 ZBU5MfLSV9XJBEnpeGaS2VVTbdOSUbZoMKq6sJwq4htoy1cekUNaZtsQLY+nw2YCM6
	 4N2z7UxTNQpPYUhWBGmKLXqFNCuwWlJS8J2T+ACORi0mB0Z8YNghGjISznixUa487e
	 JvLfHnkUxRXd8cC0kS0b0HUz+QXSPWXU+lcJL+I/9MsxSEYrwiMQVFztNSG5OokHaZ
	 NGgqWcHcX5qMJ+C4zUani4a1Cd92fkvbwwk7PUQMSeH108m2BLOzAuLtRcBdtl9S8X
	 Sdx0JIdUiHvsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E233808203;
	Tue, 24 Mar 2026 20:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177438481380.1297770.15501151150857730949.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 20:40:13 +0000
References: <20260324044949.869801-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260324044949.869801-1-sun.jian.kdev@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, mykyta.yatsenko5@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Mar 2026 12:49:49 +0800 you wrote:
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
> 
> It currently targets bpf_modify_return_test, which is also used by
> other selftests such as modify_return, get_func_ip_test, and
> get_func_args_test. When such tests run in parallel, they can contend
> for the same per-function trampoline quota and cause unexpected attach
> failures. This issue is currently masked by harness serialization.
> 
> [...]

Here is the summary with links:
  - [v4] selftests/bpf: move trampoline_count to dedicated bpf_testmod target
    https://git.kernel.org/bpf/bpf-next/c/7f5b0a60a8b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


