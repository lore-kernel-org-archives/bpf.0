Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4ED2D5922;
	Mon,  6 Jul 2026 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366231; cv=none; b=qfBeYOkskqs3eTn/ZR6tZD5f9cgwYHqwz8EZ4trHNZJAPNlzYN0MJYj80SwxW00D3v9SdeHC1bFvrh9jH6AWxfcscywaURYMHmI13XQktVIWUoB+8eukuoPwO9V2JDWy6eMhli0zb8r4TAhCTKiIo/AfhrDQz5f3j4WJC2n0OBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366231; c=relaxed/simple;
	bh=VBtbYcfPjKQbmr8RAcQ1nGffy9tW20FGR3WmW4xHOIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DphqbSHlDqQFaRjEHGULQrZbQ4s1lMZHIGy9+hk4dTMOIcnImqPaEwTezS8i2eDvIaD9HfBnUX9XdAGhdJFyjCADRcC+pBwZEscQp+5lLFCFgMUbWTAHb1qQfSYY/JIEu0hREJ0q9rIoRQvxc/fulR88CM8wbWZMv0rUZkn3t3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4fyPXXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4fyPXXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B195D1F000E9;
	Mon,  6 Jul 2026 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783366229;
	bh=KYfAZuR1GlHB8srk2dRV+9pb0lHb7ypvdtEi+ATkMd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O4fyPXXdKlrrfQUBdtjtfZXBq3TAuTraSrOIdom2xagF9pkCHGG30QDs4+jLkmegK
	 9SnmsWZi7d3w6QM2lNKKPYsYGSoWTpesoxAAVBqOoKpZa/6McEbGe5mc+h96l3fY7g
	 TbOKuB4uJ34OEXfY0SkWWbDrh9S8JH4zjeYW9mWPrAKvT88ZKAm9YT8w5gC3dhgMzO
	 mGQStQcVv786dj57j7OjTTcph1uJGML0w9tIgv67Q5yGFmT4tyT0vIegsZhbBFyl2Y
	 MEU744e22pj6zLpFE/PYbPtOOZ9JTlg/KtoJKfI5sNqKId5Gxn5y2ro0KpcuVRZE6V
	 WXIG03KYP7G/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697C3925F51;
	Mon,  6 Jul 2026 19:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: Fix memory leak in msg_alloc_iov error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178336620988.1174442.12823379964255859491.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 19:30:09 +0000
References: <20260704122936.102394-1-malayarout91@gmail.com>
In-Reply-To: <20260704122936.102394-1-malayarout91@gmail.com>
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 ast@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat,  4 Jul 2026 17:59:35 +0530 you wrote:
> In msg_alloc_iov(), when calloc() fails for an individual iov_base
> allocation, the error path frees all previously allocated iov_base
> entries but fails to free the iov array itself that was allocated
> with calloc() at the beginning of the function. This results in a
> memory leak of the iov array.
> 
> Add free(iov) in the unwind_iov error path to ensure proper cleanup
> of all allocated memory.
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Fix memory leak in msg_alloc_iov error path
    https://git.kernel.org/bpf/bpf-next/c/07c1b07d3871

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


