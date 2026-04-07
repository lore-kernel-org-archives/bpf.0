Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CA388E5D
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775602828; cv=none; b=o3XT68QQOe4SvF5YOuZ5eJEwNLK0BIqSxzqmEShC/G3jpPmJmJap0Cy0qa+DHX/ub6YXX6LPWc1MEYgeYIAymEKbkqCwotEvdqciAKz7IEQXgVeUVsw6gUpCLdLWQW3BUeXljs6QKL2UPhRF5Pd/SLGRgDh1hNozAyTJ5LZf4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775602828; c=relaxed/simple;
	bh=xKzieA2ZSqWsniUMrq9v9gZzg9PpMFiqEIf58YmZpps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ik+ROh7uBT6OiW263J9KvbGbJX7mtYsmo9gWBECbbOCYXZXhKoUgqc46wBGvadZaPN+tUk8XtAle2yu3e1gLXyoL7iZyPKBwjuOMeeOnUwlXcZ5c4LYdssYuAVWWklxlJpUdhELeyNiMRpl9xXOHvv0Z+9ccq1A+LVyByhoab+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf1DFH8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf1DFH8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F22CC116C6;
	Tue,  7 Apr 2026 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775602828;
	bh=xKzieA2ZSqWsniUMrq9v9gZzg9PpMFiqEIf58YmZpps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kf1DFH8gXmKfFVzp+jWM8fySqjDI5Hkhq/5yCQuPgAFpbZJRtCh4HQrq1QdLO9jBa
	 SNh+iH2AJ37V9y5O+qsP7p9XcuXBhuCwPNcI0UShDqR1Kcly3k9br6P9XACiEkPfKI
	 cDkaIFCSmUHEx5FJR09eCsqB3TRk/X1MWZUXirViJ++FBDzuzJVSxuaIt0QbtZUfj7
	 EkeML2p9wnY1iO45CDrerqbqYVOwhcqlqtTuDYknOwZQ51GNyK5W3rwYErabv9CwGk
	 lJFxSIj9dApNt3fWZ0oAS7rSBv+vjNcSC1kxeS4hwYibwlBeOJ9YOr/KO9TH59//+C
	 mc55WbScmyvVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D623809A3D;
	Tue,  7 Apr 2026 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add test for nullable PTR_TO_BUF
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177560280529.4188799.15135394423120356900.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 23:00:05 +0000
References: <20260407145421.4315-1-tpluszz77@gmail.com>
In-Reply-To: <20260407145421.4315-1-tpluszz77@gmail.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 ameryhung@gmail.com, eddyz87@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 Apr 2026 22:54:21 +0800 you wrote:
> Add iter_buf_null_fail with two tests and a test runner:
>   - iter_buf_null_deref: verifier must reject direct dereference of
>     ctx->key (PTR_TO_BUF | PTR_MAYBE_NULL) without a null check
>   - iter_buf_null_check_ok: verifier must accept dereference after
>     an explicit null check
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: add test for nullable PTR_TO_BUF access
    https://git.kernel.org/bpf/bpf-next/c/a4985a1755ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


