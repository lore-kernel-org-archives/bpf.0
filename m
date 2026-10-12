Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DB49E5FE;
	Mon, 12 Oct 2026 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821511; cv=none; b=J7YyCshfQBRCQfUcE90oMAvWXek+68r9h2YEp9INL4StK5y5RciyyLh6rUCwNl0HPI9dCS/s0cKgkBQ+Ka4d3nufYVqDMCWCPlXkP+bhVezaEsj/s1s/0+lE0BlpQdXH+Sj3ppNTfHYI+Nztl6ZP75k8xeKyyA1JvesY25tMNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821511; c=relaxed/simple;
	bh=6FSgLmlRieYCPz+3j2mwBhdGAKy2QiwnJyeM5ucEzcM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aDZvDuOo5vbAo8SgKQqte3ShNP9U47krzz2fq0ZlUf7LOz+p4vRIrRaVX6GCZHvjLOBLmMoARGMTfleIEmyhE0jsI5URrgw9kcvoorJCUdV+SWXM9hEuARC3qphXXXYAY2NeNExM9dG6fT61RtDTQLAQAyyQM1Up+Zl9d8lFpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctUAn24i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctUAn24i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789541F0089B;
	Mon, 12 Oct 2026 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821508;
	bh=sjrJKhT2IROUQqK2omAaK4ws05KJ8UAbS6zJzFtHQUI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ctUAn24iI2rL/oR620R6zxqpq3Z8NEhkftAF+WHGMFv7Xkweg9/ZNUyUqdhR+pgG9
	 2plUxunF6z8pqWkcboL/4rTWQ+KigPyVGV0azmutdBnt3zbiXx7LFKy+uwHSRnHIN5
	 lv21xUxRp5lmsvFaHfI6lnCHaIEAbS5vvQb7u2FXHDWcmzvGDA8HW0Ei880BNPz9yc
	 jmiIjyJip3DkGAVRLkay0gwEAFNwyxwnTmrc8sn4SEsEBN/KTUdJFoOHwJVt1cyrpC
	 7le9wXmxgwzlNwkR17WdwGHuNBisSc+NsRscGnNEC+uzturoBHF725GrD7cjAZyl+D
	 uNSsrgeFKKdFw==
Content-Type: multipart/mixed; boundary="===============5565528010280399983=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <99aeee9b4fb782792f6f20be06470233aad1b47aaaa00b4073cc431552f48cac@mail.kernel.org>
In-Reply-To: <20261012154024.29423-7-leon.hwang@linux.dev>
References: <20261012154024.29423-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 06/21] bpf: Add bpf_text_poke_batch() helper in trampoline
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 16:11:45 +0000 (UTC)

--===============5565528010280399983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_text_poke_batch() helper in trampoline

TL;DR: The new static bpf_text_poke_batch() has no caller in this patch, so it
may trigger -Wunused-function and, with CONFIG_WERROR=y, break the build and
bisection; consider squashing it or marking __maybe_unused.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 21d460866dfe..a2fd0bd8c685 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1863,6 +1864,56 @@ void bpf_trampoline_multi_detach(struct bpf_prog *prog,
>  	  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS &&
>  	  CONFIG_BPF_SYSCALL */
>
> +static int bpf_text_poke_cmp(const void *a, const void *b)
> +{

[ ... ]

> +static int bpf_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt)
> +{

bpf_text_poke_batch() is static and nothing calls it in this commit.  Will
this trigger a -Wunused-function warning for any config that builds
trampoline.o?

  kernel/bpf/trampoline.c: warning: 'bpf_text_poke_batch' defined but not
  used [-Wunused-function]

With CONFIG_WERROR=y that becomes a build failure, which would break
bisection at this point in the series.

The first callers, bpf_trampoline_multi_prog_attach() and
bpf_trampoline_multi_prog_detach(), only arrive later in the series in
59e80b53cc6b ("bpf: Add bpf_trampoline_multi_prog_attach/detach()").  That
commit also wraps these helpers in #ifdef CONFIG_BPF_SYSCALL so they are not
unused in !CONFIG_BPF_SYSCALL builds.

Could this helper be squashed into the commit that adds its first user?  If
it stays separate, could it be marked __maybe_unused until that user arrives?

> +	int i, err;
> +
> +	/*
> +	 * Sort pokes for two purposes:

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38273555988
--===============5565528010280399983==--
