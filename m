Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE552F363E
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087203; cv=none; b=Zc9Y9LttGcVXDF9gmz3Et2q1/AguKBvZMnADIBaCu+PjkIykUXWkbwYEMC4BuHIf8kp06bJo4nduO6kZW0rJTKPalburSsNyzKtL59T3xoyMbdLsr4+iKUmVKp8f2llQvQRr56mDgpzfQQN88U/FmEgc1n6OxpVg3WiBAf5GCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087203; c=relaxed/simple;
	bh=yvKUdCnK3yUoB8MqT+FUgCo3k+bQs2RS938i4L2ErZw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aarNz/dEDzcwi0Ih3+42klrsEwru8c/6sXLNpC8gJ7jLUWNPCpRKUKzwsMjazycAdLW3B5FuZTu0nA4Oe68XrFIeTM+prwmySzbtDp8ytNU3Eel2ubPpbsLj9Qxl1NmwcrrkKHurguAFsYHHXF4lKo3t8cDKNw596xmoCmzdDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkymhUgg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkymhUgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8A6C19425;
	Tue,  3 Feb 2026 02:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770087203;
	bh=yvKUdCnK3yUoB8MqT+FUgCo3k+bQs2RS938i4L2ErZw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TkymhUggsJYRJ9aAFsLNwZxCQX2qkp7cFEttNCtsCfEw8J/8H2M3nfa4dbujOYVTi
	 9/EzJqK6uMqvZbuVN8nEgsTvRyG9jPF3rCnQdHcTcpZ6cAifewVpmzZd7pQuUySxbY
	 jRd+tnzA318eAt77J3pQzPlC58U1shpjwsIpms+EUET4AlsfBOnXuVK2pOvoU23D9x
	 58pDzrPCX00X4g258NidQwUwBNvIG8fv19A9BaXtRrRp1T4wKFL02nk56ivm1hCUo5
	 2bhrYzqlgItBbhMl1tHUHFboQJJ4y9MLX3GBetK5rXl39oe2w/fQqjc0Mn0cDjf+0P
	 AAlLoxY6ud85Q==
Content-Type: multipart/mixed; boundary="===============9215086658162783791=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ee9a7350e136e13d16e6b5c7526beff39aa1ab555f3d815804abbecdd233e210@mail.kernel.org>
In-Reply-To: <20260203022229.1630849-4-puranjay@kernel.org>
References: <20260203022229.1630849-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: verifier: relax maybe_widen_reg() constraints
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,andrii.nakryiko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 02:53:22 +0000 (UTC)

--===============9215086658162783791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d92e10d4c..5da1c6036 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9023,8 +9031,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
>  		for (i = 0; i < MAX_BPF_REG; i++)
>  			maybe_widen_reg(env,
>  					&fold->regs[i],
> -					&fcur->regs[i],
> -					&env->idmap_scratch);
> +					&fcur->regs[i]);

The change removes the idmap_scratch argument from maybe_widen_reg() calls,
but widen_imprecise_scalars() still calls reset_idmap_scratch(env) at the
start of the function. After this commit, the function looks like:

    static int widen_imprecise_scalars(...)
    {
        ...
        reset_idmap_scratch(env);      <-- this is now dead code
        for (fr = old->curframe; fr >= 0; fr--) {
            ...
            maybe_widen_reg(env, ..., ...);  <-- no longer uses idmap
            ...
        }
        return 0;
    }

Should reset_idmap_scratch(env) be removed since it no longer serves any
purpose in this function?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21614542865

AI-authorship-score: low
AI-authorship-explanation: The commit demonstrates deep familiarity with BPF verifier internals and uses precise domain-specific terminology naturally; the focused scope and minimal code changes are consistent with experienced kernel developer patterns.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor dead code issue where reset_idmap_scratch() is called but the idmap is no longer used after this change; no functional impact.

--===============9215086658162783791==--
