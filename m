Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1D42464E
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357488; cv=none; b=uvyJDXBo7fZbgyXC1SFh1I+WV6eqMxRo3fNJKT0MI0RIi32pGu35Ti1cIL9kcJxqZ97Dj5JCRVobc1P8H/xn618VEhSoXo0oCqPQJjD9+9pGJw9XQBkyJkrfIWR7nL4oRL5emzBHix4fvgl4mQOdzHD5qkwf8C1gEve6ue3Lu8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357488; c=relaxed/simple;
	bh=c/3a0uzvqVjf2htAUz/BroeR8aIar1cRGnHcU2tQ8go=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aSgOmDt35Hg7olr/11vp9N6pqGAK1GnWXKirToFpUn83N6rTu5KM26T5Vxz6+g3ly7kLwRh0q1rClJtBogZ1mjP6/a8Mt2VeMw5VDuAeL3S/ZcXUYF15jpVzVEGfmQ2S/AKgNEHRiVrtETMSt1De03FdnnuMWAwvt98sH2jlhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elTJobJB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elTJobJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6BF1F000FF;
	Fri, 25 Sep 2026 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790357487;
	bh=f66Uj727awILtMO69gCVZHjKq+ypffgfOdlylebhG0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=elTJobJBYbB693S/zJRtHrxttBqOOBOVQYbxrtsyG6BZpq7HFadVGGHih3RX2K/Hg
	 7v9yw5Uax/bC2n3Cn/v4Q8Yl5BhycZzNLF42RHzVekb/2Tp2NesQ71qt2/JKCkaA+2
	 PHW+pBp3DzY117ym+qu95cDx3mJELY9mNcgaqEQowoknRE3xKXdE/zYY3GUNdEenrQ
	 AQBatEvi3a/uktf1EMyiLw4T93ecHj6j45vtPoBCMLRUj+m8bzv9oX7u5t7HporxgZ
	 xXGPe8bDkhZyBb3TLOrHsZACSPMm8D38I4uEKl7zMFeANDC1Ctxznz8uODFmOeAt/0
	 rMg4md3/onK/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93940380820D;
	Fri, 25 Sep 2026 17:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Check callx operand before requiring JIT
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179035741514.3062647.11160147298832193132.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 17:30:15 +0000
References: <20260925060945.1993547-1-memxor@gmail.com>
In-Reply-To: <20260925060945.1993547-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Sep 2026 08:09:44 +0200 you wrote:
> check_func_callx() requires a JIT with callx support before it looks at
> the register operand. On an architecture whose JIT doesn't support callx,
> or when the JIT is disabled, every callx is thus rejected with "JIT
> doesn't support callx" or "JIT is required to use callx", including one
> whose operand is invalid. The "invalid call insn1" test_verifier test
> expects "R0 !read_ok" for callx of an uninitialized register and fails
> on s390x:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Check callx operand before requiring JIT support
    https://git.kernel.org/bpf/bpf-next/c/b9f30c763c7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


