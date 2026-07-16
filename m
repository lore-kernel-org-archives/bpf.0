Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65634E75D;
	Thu, 16 Jul 2026 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244037; cv=none; b=XoipwuO/ISG3LDt+WvmkFalPThWECU+EhZS2BCmV9IHQ17+4fjVYg9ZuxbQofQvoJWnQ8EdMPnBoKK2pTY61sYYM7ot5UDKxNBzrWoThMSn6J4AUC5EhiL7rVXlbGiCZR0Q6dOcVGc2BItuypK1zevVzbidiZi032wKZoNFPE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244037; c=relaxed/simple;
	bh=3wpdS/FC/sukYAXl2TaDgcijDiDZVHSaVo0A0rsoLSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fTnfMQhm9Pv8xvYYsIreaFuR7C7r8qxvT+DbUQ3Z+TdXNNNxBZfo5DfXIXPpkvLn7Pah8SNXNVHE8fAI4hnBPXvHYbHwksNmn3ipJk7J7mShP8c+OqxZW+BqZZYxvO0+0mQmgC3JbQK7CwDzi0jB9FFHuYi7ZhaS1E7Izvc5Uxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R61jl9nk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R61jl9nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5E51F000E9;
	Thu, 16 Jul 2026 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784244036;
	bh=JXusWhX13WmLzBkiMrHQZhME61LZDEq0yc6ne+rIXsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R61jl9nk+U7lxZ1RW/vDNYhoKnQHdzY5sBlDS9R4x0WFMvKx/eAu9VFhIYAKixAZt
	 StUJh6pGIerV8JpBRW+F7Pv+93zYwf7zRp7+qJcvidMB5tNvSYc0e24XG0y8uRhNcc
	 Fz03ZVcQ4SkyBVat0LU6t+VMzz34n0Ycua1kWtLWk6BMARvCdrekAlGKuf9FWyiQEo
	 oKk+Zdnj89wxUVfdbijfKK6lpLvV0kzEf6NOjzGf8ZlwI4JRbzHy9qQmOCVnznouPh
	 6+TyLHzArJGQb0a93RXnb74lBxr8cfwby7m6BBpN9duiuJvkyDZY9AzySeT16Jeo6X
	 3xaYY951rJV4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AFD380A964;
	Thu, 16 Jul 2026 23:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix tracing of kfuncs with implicit args
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178424400940.1454328.16219271761426595594.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jul 2026 23:20:09 +0000
References: <20260713235223.1639022-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260713235223.1639022-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, tj@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Mon, 13 Jul 2026 16:52:21 -0700 you wrote:
> Tejun reported an issue where a BPF program tracing a kfunc with
> KF_IMPLICIT_ARGS can crash the kernel [1]. This is caused by a bug in
> bpf_check_attach_target(): the btf_func_model for such a kfunc is
> computed from a wrong BTF prototype. For more details see the commit
> message of patch #1.
> 
> The second patch adds a selftest that can catch this situation.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Fix tracing of kfuncs with implicit args
    https://git.kernel.org/bpf/bpf/c/3917b1012ee2
  - [bpf,v3,2/2] selftests/bpf: Cover tracing implicit kfunc args
    https://git.kernel.org/bpf/bpf/c/0af15f3057a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


