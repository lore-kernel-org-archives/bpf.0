Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010446EF9B;
	Tue, 21 Jul 2026 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658653; cv=none; b=QCvUWQ/FfHb+EVoPMAGFoSINjQLlOXO6ElIx0CKz8RL5ilGxWfHSryTBGZNX9OGaPOCMJ1OktZJXIIbXzqXWYxvuZahCi3T3Ax85xy+0vCgxYqul94r7v+/9DiXRmZAnDztcdkebirPcPLRUhGgOKFOlcqqBVKPgaZY2XOFOg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658653; c=relaxed/simple;
	bh=+CLWXbUKBegsiBsDe8REVnGU/QqkR73CkTnDl2LNw5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RBFZNIkB3WsHc/7WhucxQugRzDDcrMgAj7ZhVupMPTmZQxChIbnEnYpkF0cdJSVLDMKF+YFabUSTFFMtrnw3i/qRYxFVM789uvp2FNS4Cov2Gn1M9nXyF/MHcTRhuZvn4SK/RHPkvSuCxL/ORz62v1VJaicUyBpr0bPW8Q2Guws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkmjGzCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkmjGzCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0201F000E9;
	Tue, 21 Jul 2026 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658650;
	bh=o34XGnWKkv3zk66cAVYP967kqgxsfnLjUYH66OHztlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IkmjGzCLewpl2zglNrnxt8mPCrcamwsT/BBD2nUwsm58LiQiRsuMHlKdDYkmZHAil
	 vRZKfqpRFbfem0YeAbgUxShrK9sBYtvmiBk855YJT8+xUA4tGn+Eueal84J5Lr1n3N
	 2MhygonkGt8gSZZU3We15H4/qIj3ePKL878LzON+uX7+IlJ5SJyPxhqET9fynYrI7m
	 2Y/o3ugX8VU8xikJmIQ0H2KnncPwPKg4b00v+g22kB3MuSZcgrKDA1krN+/D6sp9L9
	 GFFiZhCn2Qo0sCNO1ouKGAPcdjaOeDge1zBrKPUM1ww6TkTHSOUKBVQv2VyL7k73os
	 k0whWoJAUdKeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C3E39253EE;
	Tue, 21 Jul 2026 18:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] bpf,
 riscv: fix extable handling for arena load_acquire
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465861940.931197.3483820108983370634.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 18:30:19 +0000
References: <20260720-bpf-riscv-fix-extable-v4-1-165c0b3b07d5@kylinos.cn>
In-Reply-To: <20260720-bpf-riscv-fix-extable-v4-1-165c0b3b07d5@kylinos.cn>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, bjorn@rivosinc.com,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 20 Jul 2026 06:42:57 +0000 you wrote:
> emit_atomic_ld_st() returns 1 to have build_body() skip the zext after
> a sub-word load_acquire. The caller does "ret = ret ?:
> add_exception_handler(...)", which skips add_exception_handler() on any
> non-zero ret, so the extable entry is missing and a faulting
> PROBE_ATOMIC load_acquire oopses.
> 
> REG_DONT_CLEAR_MARKER leaves rd stale on fault, and the verifier still
> thinks the load overwrote it, so a program can leak it through a map.
> 
> [...]

Here is the summary with links:
  - [v4] bpf, riscv: fix extable handling for arena load_acquire
    https://git.kernel.org/bpf/bpf-next/c/5eb8921371c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


