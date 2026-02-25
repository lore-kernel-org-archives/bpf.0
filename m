Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2B38F249;
	Wed, 25 Feb 2026 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014210; cv=none; b=t5Fo6A0GpdmdG6psgYl5hLyQErsKm0BE1UZjuImXzAoHXzj+5sw+pdCBx3piWOqNsj20bRcK0Or8VjEuMuvUJUxyf+xPDV8bLjcz9X8y9UyAhKM2MlQh67oW3HRCFKIS+aR3dI9IB14JfAVm4+cdmgfSoRLYTRbYHRqk4+XyqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014210; c=relaxed/simple;
	bh=SUaaK6XzvzmyS1weeb2OkubB+G+5jkhXcoy21xTtFgw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=I8Utd7CGHRfE+kZ16M1kHnRs+kRowrlhCjokFazwHbGDsq4azfCFNuL2DkLqjA61bkmVMeJSq0TxECLyPrg2I+WYNiFxCQyLpu6iY8pEEO38x+/5s9rjyE4mT2Q/JvU/F5cFYQ9vcW4sEdEWX0G/pHhK/dC1T14IuxZKavUIMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twa7tu6T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twa7tu6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7813CC116D0;
	Wed, 25 Feb 2026 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772014210;
	bh=SUaaK6XzvzmyS1weeb2OkubB+G+5jkhXcoy21xTtFgw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Twa7tu6THq1J14Y+kC+Buchpk691W66o1zkIpEMqLJRVFAbGxLVOhx3OZX/4OxtX6
	 PWwHGvK2xWGFKhEZHHLjM9NWcxF6ukTSGIxY0GzJ8M0OIozOuuL//AMlSoeVSRjVZz
	 sfvwiLzsZwIhE4txoCpDks+ZvXcE2FgQrceO00jmYE1+rgPKdc9H8lFRU5fPdiudxT
	 r5jAvHnRBPCOcEQqjqUF/sZ8VJCnaQHdpluvelbPWsAQ3Zvd7wZFwbRVepj6FG7qgu
	 i8A4dvdazlI5psdFqOtE6Wab8Fe/fVqzlAmS7NMDpW682kqCG0WJb2Ha10yEFuCdrc
	 Jza2YsJJjDJTA==
Content-Type: multipart/mixed; boundary="===============6033642110113408588=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ac82d904dceaaf8bd1bd13859d6f89bf1d630c9d8912731413c5f6e9dc2a553@mail.kernel.org>
In-Reply-To: <20260225092651.94689-5-pilgrimtao@gmail.com>
References: <20260225092651.94689-5-pilgrimtao@gmail.com>
Subject: Re: [PATCH v2 4/6] selftests/bpf: Add test case for bpf_list_add_impl
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,leon.hwang@linux.dev,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 10:10:08 +0000 (UTC)

--===============6033642110113408588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h

[ ... ]

> +/* Description
> + *	Insert 'node' after 'prev' in the BPF linked list. Both must be in the
> + *	same list; 'prev' must be in the list. The 'meta' and 'off' parameters
                   ^^^^

The description says "Both must be in the same list" but looking at
__bpf_list_add_after() in kernel/bpf/helpers.c, the implementation
requires node->owner to be NULL via cmpxchg:

    if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON))
        goto fail;

This means 'node' must not already be in any list.  The Returns
section below correctly says "-EINVAL if ... node is already in a
list," which contradicts the Description.

Should this instead say something like "'prev' must already be in a
list; 'node' must not be in any list"?

> + *	are rewritten by the verifier, no need for BPF programs to set them.
> + * Returns
> + *	0 on success, -EINVAL if prev is not in a list or node is already in a list.
> + */
> +extern int bpf_list_add_impl(struct bpf_list_node *prev, struct bpf_list_node *node,
> +			     void *meta, __u64 off) __ksym;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22391130139

AI-authorship-score: low
AI-authorship-explanation: Code follows established BPF selftest patterns and the doc comment error is characteristic of human imprecision rather than AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Inaccurate API doc comment in selftest header contradicts implementation semantics but does not cause runtime failures.

--===============6033642110113408588==--
