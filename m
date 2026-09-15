Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8746A5E1;
	Tue, 15 Sep 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462912; cv=none; b=sPxwk2nIa2lvhiL0ARyGAN1pIPVGUz6cXvPcwpy2hPbYOGG4CkeDKCnPvS2jd7rlUc2dLUbKuz8vqDGP+oW24U1S4V0ngvWjTrwlAJqVd9qDmomJgjUplmQ9Hnu4ZPGQv6ql+/lsDfvbr6lGgft83jQER+iGFO49PTbBuHBTQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462912; c=relaxed/simple;
	bh=aRyUL2XU+gxp4Mn1Uiq547yTXErqRLkcmDZ746FHE1E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eKa3Svwbvoa+c4xohqOeiI5hqVMgQQUoqfxJhqnaOT9v+tvAzyZVjSXLAXiP3DAAq6d9BFE4k3ZIDOQiP9xn4IWFc37Ec4jBFkx/jfSTrrFSkXY4v91VA64JR4TVU9zfDzIcRb2bu8cADCMRs4xDIn7N3ZLrwoSv6T76i9PDcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHs+4okT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHs+4okT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9451F000FF;
	Tue, 15 Sep 2026 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462910;
	bh=exObQpVPCz+CYWwPcxHV0eYvHDRpab6T8xfQK+9Wolc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nHs+4okTqlsr/veDUcsDRkgqzRvHrYeS7z7WOEYv6LKZ95EUEM94YPMgS1m0ollGq
	 L/MVyePpk1zV7RUrhyprB6BD9MRmWIwwveGibN/SRM7NkrTwB0Gj6vvi9K9gUlSiVl
	 01HSYpmuNTkOfc59KnL7VLMY+yhdyVAnZY3z1eVVXDx53cwmVrcSQa8lQIbf5AjXpC
	 uJdCXMtrzGomyFTX+XBpQep2ViZ6+S7zEY22ToVOT7sY8CKYD6C1t2N9wSvzGCQXv5
	 /eMOFnLzyYNGhbu7davJym+Gen/NsgU3MhX12j+u2d9BZ+dFbIHTzqIqbJ6sS9OB2S
	 cRPp1mOD8tCkQ==
Content-Type: multipart/mixed; boundary="===============3167789660122054062=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e4c6c05feaa894234b5941f694c04db8da58169ab1165ff1a6579ce63dff8f2@mail.kernel.org>
In-Reply-To: <20260915080255.48929-6-tasos.papagiannnis@gmail.com>
References: <20260915080255.48929-6-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v7 5/5] selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,david@kernel.org,akpm@linux-foundation.org,andrii@kernel.org,ast@kernel.org,brauner@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kpsingh@kernel.org,ljs@kernel.org,matt@bobrowski.net,memxor@gmail.com,song@kernel.org,sun.jian.kdev@gmail.com,utilityemal77@gmail.com,viro@zeniv.linux.org.uk,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 09:01:49 +0000 (UTC)

--===============3167789660122054062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> new file mode 100644
> index 0000000000000..07ca96d9db45f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> @@ -0,0 +1,122 @@

[ ... ]

> +static const char expected_arg0[] = "first";
> +static const char expected_arg1[] = "second-argument";
> +static const char expected_env0[] = "SOME_ENV=a";
> +static const char expected_env1[] = "OTHER_ENV=something";

[ ... ]

> +	char arg0[32] = {};
> +	char arg1[32] = {};
> +	char env0[32] = {};
> +	char env1[32] = {};
> +	u64 offset = 0;

[ ... ]

> +	/* arg0 is at bprm->p */
> +	str_arg0_ret = bpf_copy_from_user_mm_str(arg0, sizeof(arg0),
> +						 (void *)(bprm->p + offset),
> +						 mm, BPF_F_PAD_ZEROS);
> +	if (str_arg0_ret != sizeof(expected_arg0))
> +		return 0;
> +	offset += str_arg0_ret;
> +
> +	/* arg1 is at bprm->p + sizeof(arg0) */
> +	str_arg1_ret = bpf_copy_from_user_mm_str(arg1, sizeof(arg1),
> +						 (void *)(bprm->p + offset),
> +						 mm, BPF_F_PAD_ZEROS);

Do the offset comments describe the right quantities? Looking at the
buffer declarations, arg0 is a 32-byte array (char arg0[32]) while
expected_arg0 is a 6-byte string ("first"). The comment says arg1 is at
bprm->p + sizeof(arg0), which would be +32, but the code advances offset
by str_arg0_ret, which is sizeof(expected_arg0) = 6:

  offset += str_arg0_ret;  /* str_arg0_ret is 6, not 32 */

The same pattern continues for the env0 and env1 comments - they name the
destination buffers (32 bytes each) rather than the expected strings (11
and 20 bytes). Should these reference the expected_* arrays instead?

> +	if (str_arg1_ret != sizeof(expected_arg1))
> +		return 0;
> +	offset += str_arg1_ret;
> +
> +	/* env0 is at bprm->p + sizeof(arg0) + sizeof(arg1) */
> +	str_env0_ret = bpf_copy_from_user_mm_str(env0, sizeof(env0),
> +						 (void *)(bprm->p + offset),
> +						 mm, BPF_F_PAD_ZEROS);
> +	if (str_env0_ret != sizeof(expected_env0))
> +		return 0;
> +	offset += str_env0_ret;
> +
> +	/* env1 is at bprm->p + sizeof(arg0) + sizeof(arg1) + sizeof(env0) */
> +	str_env1_ret = bpf_copy_from_user_mm_str(env1, sizeof(env1),
> +						 (void *)(bprm->p + offset),
> +						 mm, BPF_F_PAD_ZEROS);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34946192265
--===============3167789660122054062==--
