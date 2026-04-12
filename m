Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3181ACA
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775971915; cv=none; b=uw8pBNEv54t6h6wbNoHWnSjuIcajAqqdP8mWDuYla1E51nHpwj1R2ltW9aYb84r3Z5BAqOu9wiRv/KuOdKsszlGH2v1MQUfVVAQnBcsjgd8TmZApOOqwOBp9rKd9BE8pfuUCZCwOSlhJUeqI2ss2aYgkg/LSDub5LyR6C84PhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775971915; c=relaxed/simple;
	bh=G8sCDu+B7jF9MNdAgFCj2aI//ECV9Txlsf/A5BwwS4I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pfdS5adGK9vVRL2I+mo4B8/DiYGDfoVc1kz8rl/jjEK8RW6APHqRgW2DgbtDUUGaGFpw5JprNsh6YCXVo6VYSMhezCoZ1sqQrFia8J7cacqKAr7cEfMRQp5pGKm8xtgjPFDeKtHTKkP/heo6Gt02EosOkdSrx0cMfnERE5FO34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlN83UrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlN83UrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5CDC19424;
	Sun, 12 Apr 2026 05:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775971915;
	bh=G8sCDu+B7jF9MNdAgFCj2aI//ECV9Txlsf/A5BwwS4I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GlN83UrW2iJxzAwpRjkTuwL6pfQv9pT1L4xdHgZrB6FsJLNeCN/0Ye8Bstd7Lf1Mk
	 0cVyM2NfQg1T/UI4vR/otOYrf9YaZK49EjWwPy1XduZkTYgeZY1T7WUbH8SFnfhH1/
	 xUxkKsi8wUYxRXOzZ4FXT1xfQOjyBCRSXchNC2afxBBaSzNm/zhwV1EFexU6Qs3Igr
	 aZABCiz/Sn9y+2ZoaFw6rn358HoLcNuNK+SuA/ZwLted8om+AaRJORxGI8cETYGNo9
	 /aOUgEK+eOWE4CkVsKBjfw/QuYElrkclEF6brFuCQa7+/w9VF5Hkfjv3qMO2kYsHvd
	 mjgK0R/PJYy3g==
Content-Type: multipart/mixed; boundary="===============2796073538568613761=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb261f110faa13eb0dddaf0197a670f8bb9716c8ba8c0537766bdf2cb4c17600@mail.kernel.org>
In-Reply-To: <20260412045842.255098-1-yonghong.song@linux.dev>
References: <20260412045842.255098-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 03/18] bpf: Refactor to avoid redundant calculation of bpf_reg_state
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:31:55 +0000 (UTC)

--===============2796073538568613761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6469e71cd1fa..4c67a15c73e1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8374,11 +8355,10 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   * read offsets are marked as read.
>   */
>  static int check_stack_range_initialized(
> -		struct bpf_verifier_env *env, int regno, int off,
> +		struct bpf_verifier_env *env, struct bpf_reg_state *reg,int regno, int off,
                                                                     ^

There's a missing space after the comma between *reg and int.  The
forward declaration earlier in the file has proper spacing, but the
definition here does not.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============2796073538568613761==--
