Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6C21A447;
	Thu, 15 Oct 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081218; cv=none; b=JFj/b8RRXzRFuul50lBt+Ng3VoZ8JNYzUTfkS5+9cYSaJyFONsROuxHFQRSG4FCqqSPqiPyC3jnW7f25UknR3wuOe0ytWOxo+0bHAL7kLcHihbHTw0GWg1wzgxifnoIZZFoSQjCCSGbLx9W+sM4FAH5JvN+FphclWWjQSgkDmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081218; c=relaxed/simple;
	bh=Qn73lTOacfWgCY5Cy/w1vJprjWXC8KmRfVAJFPmi2Mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iycTpJLhfCjV9zLQElxkNKpk6AxUlYvDma10yi35VvCezgpLJghUdZZ5S8nS6cl9yz13pj1K1pVxurjQLpy2nRA+ysH7qYCbQRtnUgsJCwJsd0NNAdzvx+AYz3XKyhokmjgUk43rqy2ROLRDRESZ4dXNvafh1Oh6QLxyw/B4lFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJToe7KI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJToe7KI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4455D1F000C4;
	Thu, 15 Oct 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792081206;
	bh=ouK+9YidLskXoJi4YvwdsKp9MZLmcAc5ekQ+1/gIASY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OJToe7KI0l03jVXgYBBgzEh7Y2RSXBa/IWZEXJI6oSk1x8VGiR8h6gUGgNIMfwbAQ
	 fh3JabVB5KcWo6VeKva/L38+J6SndwkLBTtPlEWFcLBLpJ7gOhSXUC9Cby9MWXPQN1
	 SYuUrsV8Y5LlkHWjYkwsVn6gNQXDOOpxzrCYbFnWhoar5ogs+7ixvdM9VikFGHDOjQ
	 jiBdgUKt2UBNta6LWMtC4Q2mQnRMfD4DBsuMUTqI9lHLRoux+Wj3O+PqKxL/UuQjEf
	 Ue89ch6wTDo52F+1ItzIF0Cg7Z0krCwPraxnPm5XUvUUHRgjl5W2/T+bPM0b6Sm8TA
	 rAxFeniASDa3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A26A3808209;
	Thu, 15 Oct 2026 16:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Clean up sa_family_t-stringifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179208120504.3991477.17422376673608105441.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 16:20:05 +0000
References: 
 <20261008-selftests-sockmap_listen-cleanup-v1-1-f6d1a4ff540d@rbox.co>
In-Reply-To: 
 <20261008-selftests-sockmap_listen-cleanup-v1-1-f6d1a4ff540d@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuniyu@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 08 Oct 2026 19:12:15 +0200 you wrote:
> Following commit f3de1cf621f7 ("selftests/bpf: sockmap_listen cleanup: Drop
> af_unix redir tests") and commit 9266e49d608c ("selftests/bpf:
> sockmap_listen cleanup: Drop af_vsock redir tests"), sockmap_listen.c:
> family_str() becomes functionally identical to select_reuseport.c:
> family_str(). Move the logic to socket_helpers.h.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Link: https://msgid.link/CAAVpQUDULzZh58oKkRaYqgM9bRToGb7wHrzT+cZNpRmAtM12Ow@mail.gmail.com
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Clean up sa_family_t-stringifier
    https://git.kernel.org/bpf/bpf-next/c/7f34009230b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


