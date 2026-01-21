Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DAB225760
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962613; cv=none; b=F/1SloDu+G9BocrLWiQixf5637DneJfviiG6rY0Y77xzwAdl3pqAuMtHX2IO62Mi4dGUhr0GyGmA4n16+IGovI2FGunL81+wONgUFPBdmNphXjCI1Lc+Svh24wBuIBpOZw215jBYY4Cdt/wl4cyEMHaV6OB0/IxRmaBWNrVVyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962613; c=relaxed/simple;
	bh=ozIW3zxBHSS3PQ0QNLO4K3gY3a7v9dtYImsHE5DMSvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qSpAhhS+Nej/A2KtYx0+/JLoIrPKBgZbSWgkCYCf+H4Mpe/karsoFr9vk0hiSufNju5kHqb3dvD3SbqIWiuvmb2O/VBqDM3X7F2AcBeCE/JUu24BuMJ3dd/dVBAuQyO2dy8BtWRAmqfcvmd4jMqE5KXhyloWaMuFQ1NCLQtgyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJaJMDqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJaJMDqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D157C16AAE;
	Wed, 21 Jan 2026 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962611;
	bh=ozIW3zxBHSS3PQ0QNLO4K3gY3a7v9dtYImsHE5DMSvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aJaJMDqBiEBdpL5T/YqOoWGhnq16uFsKuRsrHOoV9KbcVjqGYcgZDMruavK5pwcEG
	 DeuNqRdG5f/wYHEVPTsOvXEvYy+y0JP8mNhWzQBsYBTdw2zCdw++SGakMFt99NBfZM
	 2mD1ASP0dIkYjAIOkDwueYmUeLWzvJ9hFbTK//SfI6RcQIsIw1MOH/ceHasTO/likv
	 BOkRyl9m3szHr41Z/yB6y0xi7jpfR+UPtny0H96sgithIcXH16QOY4fjgoy3awVMMx
	 kZ6my9f0oNuDNhlNHg9Qn9VE7OW3djXovZxtqWK2aWrmRRUGyE/DlUHDOsypNxTDT3
	 8qqcfqwv1A9yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8FDE380820D;
	Wed, 21 Jan 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 00/10] bpf: Avoid locks in bpf_timer and
 bpf_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896260860.696500.15496590516058993754.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:30:08 +0000
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Jan 2026 15:59:09 +0000 you wrote:
> This series reworks implementation of BPF timer and workqueue APIs.
> The goal is to make both timers and wq non-blocking, enabling their use
> in NMI context.
> Today this code relies on a bpf_spin_lock embedded in the map element to
> serialize:
>  * init of the async object,
>  * setting/changing the callback and bpf_prog
>  * starting/cancelling the timer/work
>  * tearing down when the map element is deleted or the map’s user ref is
>  dropped
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,01/10] bpf: Factor out timer deletion helper
    https://git.kernel.org/bpf/bpf-next/c/c1f2c449de27
  - [bpf-next,v6,02/10] bpf: Remove unnecessary arguments from bpf_async_set_callback()
    https://git.kernel.org/bpf/bpf-next/c/57d31e72dbdd
  - [bpf-next,v6,03/10] bpf: Introduce lock-free bpf_async_update_prog_callback()
    https://git.kernel.org/bpf/bpf-next/c/8bb1e32b3fac
  - [bpf-next,v6,04/10] bpf: Simplify bpf_timer_cancel()
    https://git.kernel.org/bpf/bpf-next/c/83c9030cdc45
  - [bpf-next,v6,05/10] bpf: Enable bpf timer and workqueue use in NMI
    (no matching commit)
  - [bpf-next,v6,06/10] bpf: Add verifier support for bpf_timer argument in kfuncs
    (no matching commit)
  - [bpf-next,v6,07/10] bpf: Introduce bpf_timer_cancel_async() kfunc
    (no matching commit)
  - [bpf-next,v6,08/10] selftests/bpf: Refactor timer selftests
    (no matching commit)
  - [bpf-next,v6,09/10] selftests/bpf: Add stress test for timer async cancel
    (no matching commit)
  - [bpf-next,v6,10/10] selftests/bpf: Verify bpf_timer_cancel_async works
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


