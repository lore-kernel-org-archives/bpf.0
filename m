Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6F35F60B;
	Fri, 29 May 2026 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024203; cv=none; b=LLIGcw1SfhTASVcskeL6HEBlq1nI7riaGAwqHtwyyGv9zrPb6SVbdW5H1Ol7U5C99bIfmHXwyA7/M01WihOWsJqog0cvuWE9ui/XMzouQxykKUmP832Ir/0xC+TDFCs3/u9wR6N5FOk2JEVK6myeQQbFAXfmsAsL0Zvsw7l0W2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024203; c=relaxed/simple;
	bh=CeUjJBo2ThFr8CJnMkzb/TaXhZ9WUPYhbjXq9A95FXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LIBx9dc/kuZKdGHEER6c/3UtGkd4NslCb/lFxRs3iFmSymi4AEuzaWHJuCnJLYPtkcmTAcqe/Twql+20ZNsTe9DcopXWrv+SiR79/JN/oNUb21F8dyvElE5nmjT3bv7JlkzdfkUaGu+fdYlmewJme4l7ok8CQuE1wNqqA0jaVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdA8Y8ke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdA8Y8ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD081F000E9;
	Fri, 29 May 2026 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024201;
	bh=xy6FbJEA5HmyjHXP9O75txhq8iEh6IsT/3Y2mVqRyk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kdA8Y8kerGDEXkd4iOyIMBmOChBSFv26qGU0bqqv2rZ3b5djkKM/smOJ0e37HmpLO
	 l4awfRW42m23gd5MIGmf76DF/c471XdN6WyHeDQLSa/EZH1exn3vkZVq2HmQREaJxo
	 /XFI4xbfP7EYby0EXWqnk6ZiM0tB1MQiAiZHd3vwxuura2IdJMpvWnkwKPTL7VDYZ4
	 7QyirWaw/W2NDSlj3k3ZQDTL1GD3cQ7RnORUwUVAt2a+I89dtr5e8On2nvaNQr7ETk
	 cDDiJ4OSWPX4LtiP7aolFqZWjIeUI3+6fy42tl+893sgM+KehcAbfpr+OzIiE1Pw/O
	 hubQpfNClXE7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198033930002;
	Fri, 29 May 2026 03:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: replace pop/push emptiness check with
 bpf_list_empty()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178002420565.1611545.6374072020383806220.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 03:10:05 +0000
References: <20260524025853.13786-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260524025853.13786-1-suchitkarunakaran@gmail.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 24 May 2026 08:28:53 +0530 you wrote:
> Simplify fq_flows_is_empty() by replacing the pop/push based emptiness
> check with a direct call to bpf_list_empty().
> This avoids unnecessary list mutation and simplifies the code while
> preserving correctness.
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] bpf: replace pop/push emptiness check with bpf_list_empty()
    https://git.kernel.org/bpf/bpf-next/c/9a720e090eb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


