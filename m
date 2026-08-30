Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2753D73;
	Sun, 30 Aug 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788087664; cv=none; b=SlG47UOhUv0iXODpthahZE18NIpAeJsFfBhmrtjzQJYbhIlAfD2u1OQvl9jVIoHdprhbYcz0cqr6Q6z8sONf4NPIBjiV7E4Ocw3E/EGGZ4vSV5Tj1wx+lIx4T/z/iT1oJHsjrVAkzlvEFw358THGF42CAp1KiabNWdmtUv2MCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788087664; c=relaxed/simple;
	bh=g9chWcycbKK70Sq+esKZRUusitCbJg8S6RhfzNLvKlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X2p43FW3rmHPFrAHkeac8l5F1PV8qJX8bPSKBZsBvWRMD9cxpnDKCjHGVIoT7WnbkVeZzU9fSevHzZ43tahzYWa0a6256rpNvMGD4y2o1WVW0Lz+S7wh3whSHe+Dww4ASHYxDHMG5XUWXyM7iJRrEHo0JV1hRfe33QqVJaIdo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIxcLbLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIxcLbLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B85B1F000E9;
	Sun, 30 Aug 2026 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788087662;
	bh=475vZTilbt6tQi3iinEjRGpfcKbWuCp1Qh6bSe+Pyvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iIxcLbLQgF18DmtTZUCAvH54b4VaJkwkqnhbucNUq6THfMmSCMt5T1z2xOrrebMQg
	 95hEXn/JIrKwp3wGwTGa/Kf9q/YS/gKZlNdwB8U5tDvoxwrf/9EV2BzTa0wmpVO7fP
	 U3rMXiOD/HF3pReLmou0aOXMOQvYyFz1LhyBEzL4tRUw1RrzzirCaoMp1c5O2fPqts
	 aLgIU1zrwLm/hAv2mRBUDwemNy7MpkOKpt4Ff7NWo+POhG+N8MKVT5bgHub5vV+D0/
	 LHDHLQ2ZYa6T4H+Rwr402R872rthY/k0EVJIWshQHCcKoT+NsZ6MvxdA/Xo+NBXYSE
	 LW8bqy8qAEpTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399F380CEE2;
	Sun, 30 Aug 2026 11:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] selftests/bpf: convert lirc_mode2 to prog_tests and
 extend
 coverage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178808760617.3314773.13243773534139324133.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 11:00:06 +0000
References: <20260820214332.89030-1-sean@mess.org>
In-Reply-To: <20260820214332.89030-1-sean@mess.org>
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 20 Aug 2026 22:43:29 +0100 you wrote:
> While porting, extend coverage of the BPF_LIRC_MODE2 attach/detach/
> query API:
> 
>  - bpf_prog_attach() with invalid flags is rejected with -EINVAL
>    and does not attach the program
>  - bpf_prog_query() with invalid flags is rejected with -EINVAL
>    without disturbing existing attachments
>  - bpf_prog_query() reports the correct program id, not just count,
>    at each step, via bpf_prog_get_info_by_fd()
>  - a lirc chardev can hold more than one attached program: load a
>    second, independent instance, attach it alongside the first,
>    confirm both are reported by bpf_prog_query(), then detach it
>    without disturbing the first program's attachment
>  - detaching an already-detached program consistently fails with
>    -ENOENT, for both the first and second program
> 
> [...]

Here is the summary with links:
  - [v3] selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage
    https://git.kernel.org/bpf/bpf-next/c/d761934c9483

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


