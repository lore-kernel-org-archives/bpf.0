Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143F6FC2
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560827; cv=none; b=MuGD0OWCYF5/f1O2wYIrxtRsZiGbiCjvTnH6uXRecZKeT9/4mJRXpcYwLVeaWZH9vKp8sM5t/x8wBgQ+LOXjRuggz0Jtmh4Ota2LNwlscDqqI8ZO3c3LoZE01CRYhOtrg5cHeXmer+a2NnFT7MKZ4jBvniZ/LrN7AawpIqhffhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560827; c=relaxed/simple;
	bh=y23lC9oAivhNrApNjWIW9Ztfvv7iS3FZ6zxP28JWtRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FQsKY+tDp0jky1FH4Zx44Gi8RnRQbIG8aSpW43ai3lP0Uikctwzd7tbnMzrclRQGFqazbVdk2F6Ned2+Do6EIyiGBJ7luW5mjFv1znxVaKBJEPIf0HNLQD66/T8Ayto55IGLs4CNPiZNtPAYzVbIq/0dcmEyoHebZJjQOSut+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1uRj32v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1uRj32v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BB33C32783;
	Mon, 13 May 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715560827;
	bh=y23lC9oAivhNrApNjWIW9Ztfvv7iS3FZ6zxP28JWtRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h1uRj32vO9nxR2naogz6SbS1khogX35kKP9FJF2bRD3k/w/CBfRPaYQUUzML6AvJu
	 Pmiqc7aRMUyUFSBjVWWFsliEt5a8XFyis4KFaRBi6hQOmLvfKrzyxvQw9EJWQmHXwK
	 gzV8mHa+rMLv0BMGhYBdeLgD3qOofFcLMdh1lg9KCWYT+bhQOAzvrTBu3mPTY8tUJr
	 iYH+c4GlaIU57c5XhFeuvXUofJlhchhgzQkw46M5AftLLU0mpklaxxsp7Js5rkgQPn
	 AQEKqp8zk0fZjiXsT+IYTituDerYO/IxjOlQw/GQdxCrju7GRRAu6CACkwJrSKJ13J
	 ge0hQiLlNiywQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 051CCC4339F;
	Mon, 13 May 2024 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: ignore expected GCC warning in
 test_global_func10.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171556082701.5774.6057501092592357668.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:40:27 +0000
References: <20240511212349.23549-1-jose.marchesi@oracle.com>
In-Reply-To: <20240511212349.23549-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
 yonghong.song@linux.dev, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 May 2024 23:23:49 +0200 you wrote:
> The BPF selftest global_func10 in progs/test_global_func10.c contains:
> 
>   struct Small {
>   	long x;
>   };
> 
>   struct Big {
>   	long x;
>   	long y;
>   };
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: ignore expected GCC warning in test_global_func10.c
    https://git.kernel.org/bpf/bpf-next/c/6a2f786e6905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


