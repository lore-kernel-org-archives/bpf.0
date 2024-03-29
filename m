Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3F22093
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677630; cv=none; b=eA35dtYKA3tBYJr7nG4BqYF5A1BoKWu5kyE5/5OYeppIppwIuFdlE71iy2d+vmYP3+PTBFlAsVzUqekhPdp6wHV9wIbK5RJiERwfGf+f5ikDw3fnlFq8BkV4wDkHisDsWIf1h0bI6O3pFaHRpT9T1j+KPQnDcsWAiTYs5bmVgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677630; c=relaxed/simple;
	bh=NMJwLuazMkU1eLN7U6eL3j7hDmS2iIJVMvISMuvhzHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UVCXRDiZpLi2Rd3i8jmZ4AaBRrOcMlbYweKIf0fdlvBGbdNVxsKvOVwwTHOA/4fSdGoSOpLl89baRWsXgV/OpazQqna1CS9++SeAqdX1qjmgemJ2tRwpgAvaHXiSIKNvW0WIjfixTu59+OJGz9/eyoyzJut5apqIOYkq4zVP9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFWFdhbh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFWFdhbh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27341C43390;
	Fri, 29 Mar 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711677630;
	bh=NMJwLuazMkU1eLN7U6eL3j7hDmS2iIJVMvISMuvhzHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eFWFdhbhQ47eExVpbO0stHsm+Q2If23CaOiXGjZu7VWSAT3zgUvrMxzJRomWLTfuU
	 CQhjpWDurDb5Zk7gb2jOoC95If8AZggYFG5F9l0LgQVRIddRdOlFrBt70mX2E6hlds
	 +Dh4V72A4n8rdKkilaefRFnstGmpP0nlMZ6+43M6oey4YH1rj4ezAOrIQSs8iYTFck
	 v9f9H5byZhggoB52vOTCAL5Ekg3aD5au/D3YYv9u4B2bVdbQXzeV5RiK79aLLNlPLP
	 Mk6zTjjqrHJi/Zj+SXPpBchCVDbhxvXi/8UFoiSBghHmLGJwvt4qyWsSLhUMVYpeZi
	 3tsio/IQm3ltA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13541D8BCE9;
	Fri, 29 Mar 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: put uprobe link's path and task in release
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167763007.19983.16546135385199447230.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 02:00:30 +0000
References: <20240328052426.3042617-1-andrii@kernel.org>
In-Reply-To: <20240328052426.3042617-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 27 Mar 2024 22:24:25 -0700 you wrote:
> There is no need to delay putting either path or task to deallocation
> step. It can be done right after bpf_uprobe_unregister. Between release
> and dealloc, there could be still some running BPF programs, but they
> don't access either task or path, only data in link->uprobes, so it is
> safe to do.
> 
> On the other hand, doing path_put() in dealloc callback makes this
> dealloc sleepable because path_put() itself might sleep. Which is
> problematic due to the need to call uprobe's dealloc through call_rcu(),
> which is what is done in the next bug fix patch. So solve the problem by
> releasing these resources early.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: put uprobe link's path and task in release callback
    https://git.kernel.org/bpf/bpf/c/e9c856cabefb
  - [bpf,2/2] bpf: support deferring bpf_link dealloc to after RCU grace period
    https://git.kernel.org/bpf/bpf/c/1a80dbcb2dba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


