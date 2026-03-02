Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DF317170;
	Mon,  2 Mar 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474444; cv=none; b=qC1oJ5w+0CHdW2P7Gdx71QLayl6ohXpIgHB5qvNWwLpYSg3BQR2DSP/qpxRbMIjEPuTz/68rCaTHsMItUvQOjftjXcWLnioBwd1XXtnWhWZAL6QMHoEAIgGr0SkeZbiDQupnw5jvWfjzmSXt3vOdDGOUoDlvaef1CklN/SQNQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474444; c=relaxed/simple;
	bh=AAWR9gZY03nbOlbVMTbEKUl4nXa8dqWaMd25yAG8vMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SpR0TxWxFCLjcAUivS6i934ZxONr18U6YWI0TCFPqxfoOKiBNx7XPFqV4suMC8M6Z8vGnsRtmsr5IkUQYq+GxRNHz+nVAfu5iYYANROQWZcdtfLY8qy/OIiixKWb07Ne/YaJ4OBsJEo37JcjxdjTKL6syl4R8CKbTSyKl5bASKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icasvtPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icasvtPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5DDC19423;
	Mon,  2 Mar 2026 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772474443;
	bh=AAWR9gZY03nbOlbVMTbEKUl4nXa8dqWaMd25yAG8vMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=icasvtPaWk5jGAFIPUsrmqzB/YK9toz7kWucD/s0nvCBOdG8QSYFncz9bgSrUQZ7y
	 0a5AAXdzkJmvWwSZQa/xhMr+giiU4dvy3wVfZxv2imeud7K+LiVa/bZQ4kWUPV4EB7
	 S2ksegSyFyTjQYrM6vNBHA/oheyW5XuAm/IGZFnOEugFW0EW8poV+mL/SRUwW4Ua1M
	 Gdvi113QkWbIJcxlY+grToX5kWmz9EaghxfmOfd+YBnIo4FlMyx0dVAsMkqY3bAZqx
	 RqMQem6cgCefSIndbFU+QzoCf6GbiF1mAoW8c4ld4aoMWaOsjeMAZCZ7Iy8T7Xn6OD
	 oNtSXzMtfy0qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E683809A80;
	Mon,  2 Mar 2026 18:00:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] ftrace: Add missing ftrace_lock to
 update_ftrace_direct_add/del
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177247444580.428681.9651303937673098793.git-patchwork-notify@kernel.org>
Date: Mon, 02 Mar 2026 18:00:45 +0000
References: <20260302081622.165713-1-jolsa@kernel.org>
In-Reply-To: <20260302081622.165713-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: rostedt@kernel.org, ast@kernel.org, ihor.solodrai@linux.dev,
 memxor@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 menglong8.dong@gmail.com, song@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Mar 2026 09:16:22 +0100 you wrote:
> Ihor and Kumar reported splat from ftrace_get_addr_curr [1], which happened
> because of the missing ftrace_lock in update_ftrace_direct_add/del functions
> allowing concurrent access to ftrace internals.
> 
> The ftrace_update_ops function must be guarded by ftrace_lock, adding that.
> 
> Fixes: 05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
> Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Closes: https://lore.kernel.org/bpf/1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev/
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] ftrace: Add missing ftrace_lock to update_ftrace_direct_add/del
    https://git.kernel.org/bpf/bpf/c/3ebc98c1ae7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


