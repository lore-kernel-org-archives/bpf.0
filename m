Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25225228D;
	Thu, 20 Aug 2026 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241657; cv=none; b=gCEwXVpbJg63J6cwy7D/o4Dq6lZxyhBhAdXjgiNh0cU33swZ4PUHGqxqeexgiAjI/QjSNk6gRQ8flJY3CpG2Abesy1JRHriAEfd6hUcyAgvZrEzhd6CmhZ7stEB0AX+Rrxe7A6jbckrvxkIbiN+bKLx3nn3NlWB4IkHF/ofC/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241657; c=relaxed/simple;
	bh=5SWX2gkFBK1Hxcn2n9HM5JqWmNBNwzMztpNQRkhGD70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cz8gfzeqeRwidO8kePMvdO2upybaDQnQhmNWYa+jm2E2iEZAAIRTbi7stZYNEhwbwPVf7otOhJEOXEit4GhfZyAgmUysQAzb98/5ENdB9HpRetmsHkyLMKd7YxnCya9NF5Wtt4uJ/CdTQHpw1am7AhxUNCzxJkPRgWxrdu2STG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXC7zmsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXC7zmsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681301F000E9;
	Thu, 20 Aug 2026 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787241656;
	bh=1iL6uHiwuMj3OY0HN/FxzftnksGWy16FbNU4r2Wgz4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GXC7zmsdI+VkjvF+X/3OXsUCqIAQxCr3nKFKOrBOJRa8wG2oHwh47G3RVNSMEY3sP
	 jIk7f6eDve5Y3WUwJq0QJMP3A0f8B+aTXCVptCISCgLmXAr38Yv+8O9EhECen0YDv9
	 KaBB/H1L9xip9WlPZvKdRrt4w0w964cDD20/EnoEgulOnUz01kIh+WzFPurfwrK3z1
	 ElpeOzH8dSAtOy0Ab/gBtObrXwM2dTg8Jv7XqV3vgiZf7b3cvfJAaqRi06aih/VDdA
	 eozrrklITWy2mtN5ZYIgWui/Zl3Ny46EssW5Ti0QTEuAEOQRmLkpYtNrDnhkGLdlY7
	 47TeyfrJbncew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC5E23811A7B;
	Thu, 20 Aug 2026 16:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from
 EXECMEM_MODULE_DATA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178724160664.341736.16028923311216598674.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 16:00:06 +0000
References: <20260818130510.3110054-1-rppt@kernel.org>
In-Reply-To: <20260818130510.3110054-1-rppt@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: ast@kernel.org, andrii@kernel.org, bp@alien8.de, daniel@iogearbox.net,
 dave.hansen@linux.intel.com, eddyz87@gmail.com, mingo@redhat.com,
 memxor@gmail.com, song@kernel.org, tglx@kernel.org, emil@etsalapatis.com,
 hpa@zytor.com, jolsa@kernel.org, john.fastabend@gmail.com,
 martin.lau@linux.dev, yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, olsajiri@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 18 Aug 2026 16:05:10 +0300 you wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Jiri Olsa reports slowdown of tracing_multi benchmark that allocates huge
> number of trampolines [1].
> 
> The slowdown caused by extra protection changes in execmem_alloc_rw() and
> execmem_free().
> 
> [...]

Here is the summary with links:
  - x86/bpf: make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
    https://git.kernel.org/bpf/bpf/c/c7a2a3618290

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


