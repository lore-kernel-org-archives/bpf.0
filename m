Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AE37BE92;
	Mon,  2 Feb 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048008; cv=none; b=F816Em2K4CT5FM/4CnQAI20+GutZRuDPepMQyeg/xXuH2Sm8d/nGIpF4D/SnepewLk+YSH6lQ/O0Pey39KRBfh5ryQXggLehToKHsTbN0aOcJrJoP7m3jsPiWTHgBM4gyid9fwEciv6ctoL8HPCSqDR63xRSurOejiA0VtkPTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048008; c=relaxed/simple;
	bh=n7OHGGC6M10XZ+8EdSzqRv5SyRrmKWSGn9ITj/6THhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gfn6icLzUG2pKWFgzVWY6d42la3SdRjq0wVAmZaXWNDvjRbk5q9ESHFHhRNoWTL/Yv/heP8r//f8Vo6dVie7jBK4LT+xkZbCFJBXUPBjuNkTt/veIuij37bcRnFIsTNKyY/VlXahvbK9BuNnlcbR6zF+x19OH6juJnL5KuLe/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqz1supF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqz1supF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24422C116C6;
	Mon,  2 Feb 2026 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770048008;
	bh=n7OHGGC6M10XZ+8EdSzqRv5SyRrmKWSGn9ITj/6THhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nqz1supFJ92wF94gxdkj6dWeNQ6N9tt0BcwFO9nO+yjCDzgbaFyTr4ycwe2S75Bt6
	 NjBqeUvkEilr7ucf0QRqwMdk+LZiXeiqy2jK5P5+3nz7URamEMtCpV79ZmnVAJ4DwI
	 lMSYStIbSjfM7r8JIrsLCPrlefZ7130ukzMHuKi7/f4XHwYKcl+MW/C+yzw1OxiNcS
	 lHuBiJW4Im1T3OMqpRXLYrU8YDaMGGa2YOx9nIAbtsRI8/AHhcx4aFuYg8IIWYAc7r
	 SXtkuZp85pkKvh3xckkLMN1JZJWFO4W43fQpBTv6Gc8FsHSJKb2sxu+xCOy1GOpVs2
	 NEZRLpYtSEU7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 53E54381197A;
	Mon,  2 Feb 2026 16:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] ftrace: Fix direct_functions leak in
 update_ftrace_direct_del
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177004800488.692604.16316475775904494017.git-patchwork-notify@kernel.org>
Date: Mon, 02 Feb 2026 16:00:04 +0000
References: <20260202075849.1684369-1-jolsa@kernel.org>
In-Reply-To: <20260202075849.1684369-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: rostedt@kernel.org, ast@kernel.org, alexei.starovoitov@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 menglong8.dong@gmail.com, song@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Feb 2026 08:58:49 +0100 you wrote:
> Alexei reported memory leak in update_ftrace_direct_del.
> We miss cleanup of the replaced direct_functions in the
> success path in update_ftrace_direct_del, adding that.
> 
> Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/bpf/aX_BxG5EJTJdCMT9@krava/T/#m7c13f5a95f862ed7ab78e905fbb678d635306a0c
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] ftrace: Fix direct_functions leak in update_ftrace_direct_del
    https://git.kernel.org/bpf/bpf-next/c/6b95cc562de2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


