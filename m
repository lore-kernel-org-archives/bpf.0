Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF84A4835
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283685; cv=none; b=C3123YXm2WD2Y37b9GHJqdFZER7PooTiacfus0mMijzgJAo3hu/Qf8zqmQ6fVGo4PpptQc3EPG7L9CaPlo2Q84wSC8/XHttN0FBp0Sqw8VY/0LPkgkkNDwxyL1slAHHxxTEci4HVELEf6ommxRk7nixK2c6EKvgPf3/rO2k7/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283685; c=relaxed/simple;
	bh=ZITk1FR1SyqhHUS9YFPdYDh7/phPW5XWBW4iSAdJ/9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rZk6KPd8tGw7+TCHeiXjwAHu1tO1K5l7ZXwIL3iZZDAk0Zmep6nVkzs+aRN/6yK6+tMmrjOoiqTtdNzl8nRgRHl2qsJfpJi8sfHgSOtjNVlcXuAbyP1vv++teAwf8AJ1wXiCcOUIVx3gE5oIQVSrc/Z+nWpeTh4j4yHucNcfD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaOlfctC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaOlfctC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928901F000FF;
	Thu, 24 Sep 2026 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790283682;
	bh=8mhgjxDVXDYj0/T8mN3FLR4d4hGlW47GyoJrzHQPbRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RaOlfctCF2saH5snFzoIiIfMA1GeKTEltmTWohc8/kQK4hBFQCSvCtMinDfLUArHx
	 fEeoa27039h8c+GHwV39x11gad6UD9dfpMAUnAiF96vW8DKTTru/D3cKh9yjt0Wwg4
	 l2dW6GHUVX51t/0WbcAPylsbyVyo1xUUyzQQjTOFT47jra7LEO1Ker3x90Z2g7tBxN
	 qQn4ymLMYj1rGzfqXT4jGGpBhsTBak/sueNNAGdten4pqbQsr3Z8PyCwWLAFYr6sf5
	 Z0OUTDVCEq/ee5uyt0Bvx3KEOzs35iW/dUPMQA+0IBou7f05mkJ/PJCKUc8R5J49+y
	 q2ghoWP9G+fCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1E3A566E5;
	Thu, 24 Sep 2026 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Return the id scratch to a fixed array
 sized
 for the stack budget
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028361142.2197912.11945342962296412428.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 21:00:11 +0000
References: <20260924193403.3032037-1-memxor@gmail.com>
In-Reply-To: <20260924193403.3032037-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, tj@kernel.org,
 kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 21:34:01 +0200 you wrote:
> Commit 9f3d900a69be ("bpf: Grow the verifier id scratch on demand") turned
> the id map comparing the ids of two states, which also serves as the id
> stack of release_reference() and as the id set of
> bpf_clear_singular_ids(), into arrays grown on demand, so that the env
> would not embed a map sized for 2 KiB frames. That gave the map a way to
> fail, and with it release_reference() and the iterator destroy path an
> -ENOMEM to hand up, states_equal() a case where states compare unequal
> for lack of memory, and bpf_clear_singular_ids() a flag to keep every id
> when the set could not record them all.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Return the id scratch to a fixed array sized for the stack budget
    https://git.kernel.org/bpf/bpf-next/c/9bf1f086e7dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


