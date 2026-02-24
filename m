Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAD23D7E3
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958999; cv=none; b=BaLKumFUslFXvqi3W+boGtItoq1Nhba3J06TSE3+5Kpu6xnWjlhUGq5sRpW8YPm7knF0ujwb+PZWb9mMuEdFjbm/vpT0UZihOrjdfaSi0BsBe/T4uaAqSAEoyvXi2JNCGfCnfNaNtva/owdYUyosy4ltzteWJ9SztekOvYGsxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958999; c=relaxed/simple;
	bh=nd4DGxYDMjBrOs/IM5Td5TOfJWqPOfod+e2V330dArg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u+Rd13iRdYN+Xyxqvqvxo3xMZGCWFshJNiDDbbSH854+sMXTZXK/nMtVQm9MQCyVtW51q65QtUDb48jfHOuBve4YwX/H4grCj9X+Xx4Zxi8JTTs+krBHTsviGjmZRk0YcTghN7KrIIm59fMwKN3yMmjAgbsdJlFjdSlKGkIBACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USpnR4Gq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USpnR4Gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7374DC116D0;
	Tue, 24 Feb 2026 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771958999;
	bh=nd4DGxYDMjBrOs/IM5Td5TOfJWqPOfod+e2V330dArg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=USpnR4Gq7m+8EPbzQK19+99D4vR3+lCceZdJaQMlK1/JvjFcwbQ+P/PEGVaYHAmUW
	 mJqhVZIxT5+c2s/I2brGu+lVlay7JB9q+5V0+eWPhKMukeoKZwZp2Im2Qkjv70oVsf
	 a79new5TswLRPNEeYXguyyAIu+p+tZcp8WO4OlEzkNxaepaJ5vMdx+/6aqBuYkyxvX
	 gXw4RLcrI+vK92ToGfnILS3oNhJ+AErQWvmVSIpiZ8jM94ief6uHnExSldHsMopnX6
	 Pxz9xmx2fLbHJdi2xOdyJwPV/5WEdU6lWz6/7klxYE0PUWY6EobKQDZKAhD266iKxJ
	 Qd+8NAq1DxqOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401053808200;
	Tue, 24 Feb 2026 18:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/bpf: Do not increment tailcall count when prog is
 NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177195900505.4107953.13925195401275701661.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 18:50:05 +0000
References: <20260217161058.101346-1-iii@linux.ibm.com>
In-Reply-To: <20260217161058.101346-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, hbathini@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Feb 2026 17:10:06 +0100 you wrote:
> Currently tail calling a non-existent prog results in tailcall count
> increment. This is what the interpreter is doing, but this is clearly
> wrong, so replace load-and-increment and compare-and-jump with load
> and compare-and-jump, conditionally followed by increment and store.
> 
> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - s390/bpf: Do not increment tailcall count when prog is NULL
    https://git.kernel.org/bpf/bpf-next/c/e4094d56c559

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


