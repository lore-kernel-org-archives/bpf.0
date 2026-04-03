Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C637F8BC
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230084; cv=none; b=KXJafIcGI/JWaWe87VjV4ryrFVQYXS65dT6Qc6kyiJwaWv4+510a1GzmTYHAYb00mlwZEyu9icT6vpcTZ2NqkKOrmi0UpW4WM9jb/car2Su+6+lFq2y5IPWO+WQs+ButQOLKJnkOETWF3ot0+aL0aoKbUnHXlDHo2Uy78o4IrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230084; c=relaxed/simple;
	bh=epsUyzDlfkDtqt5c3mqnKgwh1BSdmKJV8iVWtUCTEI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WJydT64hbJrP+xoj/s5OesGzP3ixcxlI/AJqqR84vPudfvBaelO6gbe2vZsOTuJAJXvmLEzs7FULlUXTNmDYU+d1qO93nvNrvvbu1snwtZ12qveCv+duWG5QJULme4APDVrRcfawu7XA25x+tlUFJsNRRo/oC07bS7CGfTm0rAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV2l9TfI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV2l9TfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0973EC4CEF7;
	Fri,  3 Apr 2026 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775230084;
	bh=epsUyzDlfkDtqt5c3mqnKgwh1BSdmKJV8iVWtUCTEI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iV2l9TfIaWlz/Xi/i/yN/I5dVTZKEHlspAklOOqYcvP6BNV6bed1H8xeD7m/Idklt
	 djEMm9e/tc7HZ0PC/70YsGtvN2ic5eZ2JNzFWv111TnOsUth+eZge84NC6dUBNZ9B5
	 lfB0/uEr8ZYuR0Xuy6gnN60pcz8Vi1WQ0Wxq1Wdj+wds56TOMoW0tcwpbpExmO3GAH
	 UdPUe7MUFmuBjgGrqd3aVjRuq25EggyqPyO259kWJTKeOkwA7DZ39cnJCdGFr7esrs
	 r5uD08zO60CjyEFjmNo14doXjG3oiyJjH7LYB0yBN3PgvmLGuIruAxj0s1zI5XuX+s
	 7RjEw3GcklU5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031983809A13;
	Fri,  3 Apr 2026 15:27:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: reject direct access to nullable
 PTR_TO_BUF
 pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177523006579.1344849.13798536246638210752.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 15:27:45 +0000
References: <20260403033828.18529-1-tpluszz77@gmail.com>
In-Reply-To: <20260403033828.18529-1-tpluszz77@gmail.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com,
 song@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  3 Apr 2026 11:38:26 +0800 you wrote:
> check_mem_access() allows direct dereference of PTR_TO_BUF |
> PTR_MAYBE_NULL without a null check, causing kernel NULL dereference
> on map iterator stop callbacks.
> 
> Patch 1 adds the missing type_may_be_null() guard.
> Patch 2 adds a selftest with a test runner.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: reject direct access to nullable PTR_TO_BUF pointers
    https://git.kernel.org/bpf/bpf-next/c/b0db1accbc73
  - [bpf,v4,2/2] selftests/bpf: add test for nullable PTR_TO_BUF access
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


