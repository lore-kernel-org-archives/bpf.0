Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8EF158535
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086512; cv=none; b=Pu3QWB+7QXrnGtWsOGTWdybcgx/E7Lrh8LXs42EyRX6coDup/XqIztRIok7e2WBV0hlr/qebQTtWYrcx6xzj3py8uAknK8HjxD7mr+SqNZLKz3+bnAhlSzrdds7Gp8nJ3hnoJj+J8XSrfECAoA3XLlWocCpMvdaCW7b/KD43qn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086512; c=relaxed/simple;
	bh=K9L9sO9LMOhufOyJerX0ru/IbFZFVvUFyzcZr6clLyI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CaEhuwei8PHpgxku2UwQiQN7VN69uDfUitJHHPbIbj79usuY/rkN+q7G14/xRP3oLuirOxUSZp0XksvzZMXH1FwpSpWegaYIjD1S5eZpdxR4mdgmArvHtAgpDA+QEDPMVawNM8pxMzWdi+qaRZ7qQ6p68a6Vg0R2JYKJu39Dl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RATVx/L9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RATVx/L9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFA2C116C6;
	Tue,  3 Feb 2026 02:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770086511;
	bh=K9L9sO9LMOhufOyJerX0ru/IbFZFVvUFyzcZr6clLyI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RATVx/L9lNNu5V91cWdGRWWOJt8sQeDJv8dUeOl0AHcivygCxZNRNZhka97bVvfzw
	 y+SqT3GgfzmefhiBICgr02ySSsx83BHnXJNWa4C9v0jMQBroUQHUGHVQ5kpM+fCEpg
	 yPkX0hwAQV6fwlF+415Hmi6j2sh/Jk4+DBtC+qkuCdYABx9d6mbtnCr7SKTbj3E6rm
	 7HuLZR2Fd363B13xSZUekaercB9MN67wvFJfmOJlNTgGPIjvvAMILk9MGVQQk4Cizp
	 JYZZH0zP1uUSJQCvYB23iOC+4gbc9dh7oWlwEds9nGX4c+UbmzyO0XU9XpX+DFk6RV
	 AtW449sdw2aJw==
Content-Type: multipart/mixed; boundary="===============4925430534599764262=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <82a4f19dd09324ddd796b62f2f66097abc5037644fbe4368bc3c8aef55849815@mail.kernel.org>
In-Reply-To: <20260203022229.1630849-6-puranjay@kernel.org>
References: <20260203022229.1630849-6-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 5/5] selftests: bpf: Add a test for ids=0
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,andrii.nakryiko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 02:41:51 +0000 (UTC)

--===============4925430534599764262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> index c8f882033..a67f2ce40 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> @@ -715,6 +715,51 @@ __naked void ignore_unique_scalar_ids_old(void)
> 	: __clobber_all);
>  }
>
> +/* Check that two registers with 0 scalar IDs in a verified state can be mapped
> + * to the same scalar ID in current state.
> + */
> +SEC("socket")
> +__success __log_level(2)
> +/* The states should be equivalent on reaching insn 12.
> + */
> +__msg("12: safe")

[ ... ]

> +"l1_%=:"
> +	/* Mark r{6,7} precise.
> +	 * Get here in two states:
> +	 * - first:  r6{.id=0}, r7{.id=0} (cached state)
> +	 * - second: r6{.id=A}, r7{.id=A}
> +	 * Currently we don't want to consider such states equivalent.
> +	 * Thus "exit;" would be verified only once.
> +	 */

The comment says "we don't want to consider such states equivalent" but the
test expects __msg("12: safe") which indicates the states ARE considered
equivalent (pruning happens).

This appears to be copy-pasted from the adjacent two_old_ids_one_cur_id()
test which has the opposite expectation. The top-level comment, the
annotation comment ("states should be equivalent"), and the "exit would be
verified only once" all indicate equivalence, but this line contradicts them.

Should this say "we DO want to consider such states equivalent" instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21614542865

AI-authorship-score: low
AI-authorship-explanation: The code follows established patterns with a typical copy-paste error in comments, which is characteristic of human development rather than AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Comment in test code contradicts test expectations, causing confusion but no functional impact.

--===============4925430534599764262==--
