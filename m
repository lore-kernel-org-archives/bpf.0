Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE230648A;
	Mon, 15 Jun 2026 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497812; cv=none; b=i2ZmcLWT10947bGlwtXMjWeRWYMsDd4Uh5rQD71thGozR4HNNF+nZqLQccQr5UzUFwo39Xb4dLXJXLXFmEMori7QtTd6dZMiTt6DDIZBMEZ9grChUfSbrqXtYE5qx4R4qxd0Tfi5egQhuU3TMOurrtdtDhVb7Ls1tHdnCtDo4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497812; c=relaxed/simple;
	bh=rMeP4hkWE2KXaZMmQd4HwPLf/jfC2CYxj0YGHHoGpaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PCWMir3chGPuHw7u95ihx7vF93z2daR6uH0ApaiZPRnPvpni3Z1jyyk+LCI0S0tN3gc7P4KVwKqVkBc8QH7+A5DLZowlqK/MEx1e9UEN7fWZVdPrP/rC7jK0qMEzOOF1dRcxVrY4367YkJ2tC+CHFqYSMMLTwcnIEfQUd9DurVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsXf//x+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsXf//x+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEAF1F000E9;
	Mon, 15 Jun 2026 04:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781497810;
	bh=P2Uk873BX8PfR2kO6C6Y/BqqAvOnW2I9fPACnlwodms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dsXf//x+vFUaZwwDUuTNtcVbawAi4Vcc+ZSrhId2rK3j4W8F2LcvzQAolFa5fea4T
	 br+2mVwlDsOm/6U1WrZzZN0Tq1cKvk/iYDkEEziFdXbvad7QwJ+VuWIB5f///DPVQv
	 9MzP6iBkDkxFOw/dWoKCJoB9XTKu9iF4WFQmCNsVMBpo5achYM220btDoZEjhVYzh4
	 d23QB4zhs0nRLybvkjfFWdvtw5IFPH18jwIcn5qPxA/hKeN2xEg53se/ZoyYfslzzR
	 R+1BNaTfJzzyhmBctffpHsEs3MM8tg+lKkU/VHurmURKP9TVj5nVxS+LcMGyDYBFHd
	 7Nih/RxN9jNpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983A3A566E0;
	Mon, 15 Jun 2026 04:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftsets/bpf: Retry map update on
 helper_fill_hashmap()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178149780566.2424819.1098701964217668443.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 04:30:05 +0000
References: <20260611150704.95133-1-gmonaco@redhat.com>
In-Reply-To: <20260611150704.95133-1-gmonaco@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 11 Jun 2026 17:07:03 +0200 you wrote:
> helper_fill_hashmap() is used also on parallel and stress map tests.
> Those are consistently failing with ENOMEM on kernels built with
> PREEMPT_RT if preallocation is disabled. The failure is transient and
> only called by the memory cache refill running in a preemptible
> irq_work, which can easily stall in case of contention.
> 
> Use a retriable update in those cases to handle transient ENOMEM and
> make the test more stable also on PREEMPT_RT.
> Also fix the sign of the value printed in case of error (strerror()
> expects a positive errno while updates return it negative).
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftsets/bpf: Retry map update on helper_fill_hashmap()
    https://git.kernel.org/bpf/bpf-next/c/1f32c0d619d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


