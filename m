Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100FD44A73F
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209499; cv=none; b=YzSSn+vc/pKCZn2e+QRrLra4L37tVILfU82ZvHE8oFWrJDOlkPDqm+fSoM6ufxs0vAzaEXCUDMMo2KrOg8eL6BBb6oNYKCyqny0DCaC5J3v+MCJ0eYB2Js2OxFbHFo9zvYWW4ozPP8dTvaRCZQM0n7OTj2eCIIZiniWrrhYbccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209499; c=relaxed/simple;
	bh=7/e8g0dOtstzLF/gP81ezuOqSvH1PgIqvObz1l2UzZI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VrghoeWjocQq/tYv7XwBlxfkV05FlwGVkhFjQZM/rEYWpAiCu+zBUD7SCY03ke9ZnBNNbbmw6tvrT1NninXweooAKhfO0Q4dQUuilnBSfAodPmnirhv9bF1z0tUaHMxD0g5eW+J+TTz1bkK1RmXUxWDVK6ao1nAt9YC8XXgdSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItHIP2i8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItHIP2i8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F47C116C6;
	Fri, 27 Feb 2026 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772209498;
	bh=7/e8g0dOtstzLF/gP81ezuOqSvH1PgIqvObz1l2UzZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ItHIP2i8WQ7PkiYuUQMSCOeMItDNuqJHZyWfKF/Via0jfgmZiiIPBZQG4ve4lsUre
	 G8YEWEgL9TvOUM9XDhBhoEc5S7XFOqVzaFgPtPZmXErL6iGCXw9m6FX4ReB/8OmhqL
	 qyecrgoO+RDerwUEkyDY3rM6MN9Jd2BlzuE2M76sdAbim6xOROlSjFbT/db7olLS2G
	 Su5t4HMXAAEWBCczBnym0rOC8lSCT5RJD5SicQPlbGbLZWAa9SdaPh7KLWi341aEZj
	 rJsRnjlcNEYRoYQR9djBB17Ea3YCUoLzGx3nIILU7fzGX+4nObbRU6aDPWb8CwNWAZ
	 5QjRV1tgwilnA==
Content-Type: multipart/mixed; boundary="===============8083472874280105529=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2bfb6ce40d72a7410955b583600befe49db0e7a401d11aae8391c842a9e6a15a@mail.kernel.org>
In-Reply-To: <20260227154616.6846-5-emil@etsalapatis.com>
References: <20260227154616.6846-5-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Allow void global functions in the verifier
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 16:24:57 +0000 (UTC)

--===============8083472874280105529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18022,8 +18057,13 @@
>  static int check_subprogram_return_code(struct bpf_verifier_env *env)
>  {
>  	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
> +	struct bpf_func_state *cur_frame = cur_func(env);
>  	int err;
>
> +	if (subprog_is_global(env, cur_frame->subprogno) &&
> +	    subprog_returns_void(env, cur_frame->subprogno))
> +			return 0;
                        ^^^^

Should this be one tab less? The rest of the function uses a single
tab for if-body indentation:

	if (err)
		return err;

but here we have three tabs instead of two.

> +
>  	err = check_reg_arg(env, BPF_REG_0, SRC_OP);
>  	if (err)
>  		return err;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22493365766

AI-authorship-score: low
AI-authorship-explanation: Standard kernel development pattern with iterative human review across 5 versions and a coding style oversight typical of human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Over-indentation in check_subprogram_return_code() is a coding style issue with no functional impact.

--===============8083472874280105529==--
