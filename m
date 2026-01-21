Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A236E46D;
	Wed, 21 Jan 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017211; cv=none; b=EBHmTJh9KDAeqDvXnvtWcWf8SRjkqEUxVaH9nG9QUpYqkHKqKaaYtMkFEop23b8c2h1GZGx5Sg6+NecVvt+93oSqAKtwyBFq8Vh+gyf8s9GCLHiA2skO9eXYst1ijRvfHmiAXpM15i87HPWQcosj1J5uVc7yywCrvA7M+hCCp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017211; c=relaxed/simple;
	bh=0a7UionxedEFE9bTWe9aMwNbENMDs5Wq/yYa4BGnEd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X3xMxmoIIUkpvqyVrQ3PO8f9jajBR5uEhDeOo+tukwY0vTKjEAw0PHbDMQbYV8C8yqm4ASY+C8kYnsajatH0TopX5BF5sw6nkGMcM1Js47r5ygm85bpXWo1rFEPPCWct9iEKWen1SLWwFjghet7ZJbSlbmqn2nllpzXUOmJNjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/j3EpV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/j3EpV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D85C4CEF1;
	Wed, 21 Jan 2026 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769017211;
	bh=0a7UionxedEFE9bTWe9aMwNbENMDs5Wq/yYa4BGnEd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e/j3EpV6XO6A162EzSSIG9zcq0Egt430wdrFnu254reCsq824copRhQvuWrJFqof1
	 PE0uUStrEWz4oOgctuXDIawklEZ6p5u193tWdEplTTDh7PdcLt7NakRK7GjyhUXROZ
	 3f3gLGg2FVsFdX7bACRmmRAoJP6Qg8G2sj5ailHYQ6/JPu4u6GrXYXKYwvVrheRrUa
	 2GBHoWZj4M/ox4ylDIaMW5/5HUKBd6a0tl/2JndZ9vw+nLs2oGkosNG/Ubsvf6pqPv
	 1xYh1hER2i94qcxcELHyZInDrUfe7hrxul4lnhaJ8B2bFNKPK3Jwr7jVM7UpAhSmSO
	 zpghVC+y97+zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB8D3808200;
	Wed, 21 Jan 2026 17:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176901720810.1387878.7393789218608952602.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 17:40:08 +0000
References: <20260121044348.113201-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260121044348.113201-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Jan 2026 12:43:46 +0800 you wrote:
> Support bpf_get_func_arg() for BPF_TRACE_RAW_TP by getting the function
> argument count from "prog->aux->attach_func_proto" during verifier inline.
> 
> Changes v5 -> v4:
> * some format adjustment in the 1st patch
> * v4: https://lore.kernel.org/bpf/20260120073046.324342-1-dongml2@chinatelecom.cn/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
    https://git.kernel.org/bpf/bpf-next/c/85c7f9147147
  - [bpf-next,v5,2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
    https://git.kernel.org/bpf/bpf-next/c/1ed797764315

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


